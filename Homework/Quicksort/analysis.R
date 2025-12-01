library(ggplot2)
library(dplyr)
library(scales)
library(tidyr)


# Load data
# NOTE: Update this path to point to your CSV file
# Example: df <- read.csv("./data/<hostname>_<date>/measurements_<time>.csv")
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
    ci95 = 1.96 * se,
    .groups = "drop"
  )

print(summary_df)

# ===========================================
# 2. Mean plot + confidence intervals
# ===========================================

p1 <- ggplot(summary_df, aes(x = Size, y = mean_time, color = Type)) +
  geom_line(linewidth=1) +
  geom_point(size=3) +
  geom_errorbar(aes(ymin = mean_time - ci95, ymax = mean_time + ci95),
                width = 0.1, alpha = 0.6) +
  geom_smooth(se = TRUE, method = "loess", linewidth = 1.2, alpha = 0.2) +
  scale_x_log10(labels = comma) +
  scale_y_log10(labels = comma) +
  theme_bw(base_size = 14) +
  labs(
    title = "Execution Time of Quicksort Variants (with 95% CI)",
    x = "Array Size (log scale)",
    y = "Execution Time (seconds, log scale)"
  )

ggsave("performance_plot.png", p1, width = 8, height = 6)
