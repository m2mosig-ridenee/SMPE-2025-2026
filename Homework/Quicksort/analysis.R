library(ggplot2)
library(dplyr)
library(scales)
library(tidyr)


# Load data
df <- read.csv("./data/LAPTOP-SMTR1LU7_2025-12-01/measurements_17:46.csv")

# ===========================================
# Data Cleaning & Robust Parsing
# ===========================================

df <- df %>%
  mutate(
    Type = trimws(gsub('"', '', as.character(Type))),
    Type = case_when(
      grepl("^Sequential", Type, ignore.case = TRUE) ~ "Sequential",
      grepl("^Parallel", Type, ignore.case = TRUE) ~ "Parallel",
      grepl("^Built-in", Type, ignore.case = TRUE) ~ "Built-in",
      TRUE ~ Type  # Keep original if no match
    )
  ) %>%
  mutate(Type = factor(Type, levels = c("Sequential", "Parallel", "Built-in")))

print("Type values after cleaning:")
print(table(df$Type)) 

# ===========================================
# 1. Summary statistics + confidence intervals
# ===========================================

summary_df <- df %>%
  group_by(Size, Type) %>%
  summarise(
    mean_time = mean(Time),
    sd_time = sd(Time),
    n = n(),
    se = sd_time / sqrt(n),
    ci_lower = mean_time - 1.96 * se,
    ci_upper = mean_time + 1.96 * se,
    .groups = "drop"
  )

print(summary_df)

# ===========================================
# 2. Mean plot + confidence intervals
# ===========================================

p1 <- ggplot(summary_df, aes(x = Size, y = mean_time, color = Type)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", se = TRUE, linewidth = 0.6, alpha = 0.2) +
  scale_x_log10(labels = scales::comma) +
  scale_y_log10(labels = scales::comma) +

  labs(
    title = "Quicksort performance comparison",
    subtitle = "Confidence intervals with linear trend on log–log scale",
    x = "Array size (log scale)",
    y = "Execution time (seconds, log scale)",
  ) +

  theme_bw(base_size = 13) +
  theme(
    legend.position = "bottom",
    plot.title = element_text(size = 16, face = "bold", hjust = 0.5),
    plot.subtitle = element_text(size = 11, hjust = 0.5, color = "gray40"),
    panel.grid.minor = element_blank(),
    plot.margin = margin(12, 12, 12, 12)
  )

# p1 <- ggplot(summary_df, aes(x = Size, y = mean_time, color = Type,, fill = Type)) +
#   geom_smooth(method = "loess", se = TRUE, linewidth = 1.2, alpha = 0.2) +
#   geom_line(linewidth=1) +
#   geom_point(size = 3, alpha = 0.8) +
#   scale_x_log10(labels = scales::comma) +
#   scale_y_log10(labels = scales::comma) +
#   theme_bw(base_size = 14) +
#   # labs(
#   #   title = "Execution Time of Quicksort Variants (with 95% CI)",
#   #   x = "Array Size (log scale)",
#   #   y = "Execution Time (seconds, log scale)"
#   # )


ggsave("performance_plot.png", p1, width = 8, height = 6)
