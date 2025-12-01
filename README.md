# Assignment 1 — Experimental Evaluation of Parallel Quicksort

## Objective

This assignment focuses on revisiting and improving the performance evaluation of a multi-threaded quicksort implementation.

The goal is to apply good experimental methodology to obtain reliable, reproducible, and interpretable performance results for three sorting approaches:

- **Sequential Quicksort** (custom C implementation)
- **Parallel Quicksort** (Pthreads-based implementation)
- **libc qsort** (reference baseline)

This project emphasizes experimental rigor, including data collection, noise reduction, statistical analysis, and meaningful visualization.

---

## 1. Context of the Assignment

The initial benchmarking approach provided with the project was functional but suffered from several weaknesses:

### 🔸 Inadequate number of repetitions

Only **5 runs** per configuration → not enough to estimate variance, detect anomalies, or compute confidence intervals reliably.

### 🔸 Sparse selection of input sizes

Array sizes jumped by powers of 10, hiding important transitions (e.g., where parallelism starts paying off).

### 🔸 Limited data analysis

Plots were simplistic and lacked key statistical indicators (CI, smoothing, trends).

**My work addresses all these points.**

---

## 2. Improvements Implemented

### ✔️ 2.1 Increased Sampling Density

I extended the number of repetitions to obtain more stable estimates:

```bash
for rep in `seq 1 30`; do
    ./src/parallelQuicksort $i >> $OUTPUT_FILE
done
```

This allows:
- calculating standard error
- computing 95% confidence intervals
- filtering out outliers
- comparing algorithms statistically

### ✔️ 2.2 Enhanced Set of Array Sizes

I refined the size grid to observe trends more precisely:

```
100, 500, 1000, 5000, 10000,
50000, 100000, 200000, 500000, 1000000, 2000000, 5000000
```

This gives much better visibility on:
- when parallelism overhead dominates
- where parallel quicksort becomes competitive
- how each variant scales as n log n grows

### ✔️ 2.3 Randomized Execution Order

To minimize systematic bias from execution order effects:

```bash
shuf_sizes=$(echo $sizes | tr ' ' '\n' | shuf)
```

This results in:
- more independent samples
- reduced systematic bias
- better statistical validity

### ✔️ 2.4 Data Cleaning & Robust Parsing

The original text logs were converted into structured CSV using two Perl scripts:
- `csv_quicksort_extractor.pl` — produces long-format CSV (Size, Type, Time)
- `csv_quicksort_extractor2.pl` — produces wide-format CSV (Size, Seq, Par, Libc)

I additionally cleaned the Type column to remove inconsistent spacing (e.g. " Parallel" vs "Parallel"), which was crucial for correct grouping and regression.

### ✔️ 2.5 Statistical Analysis with R

The R analysis script (`analysis.R`) performs:

#### Summary statistics

For each (size, algorithm):
- mean execution time
- standard deviation
- standard error
- 95% confidence interval

#### Confidence Interval Visualization

Plots with error bars on log-log scales:
- X-axis: input size
- Y-axis: execution time
- CI displayed as vertical bars
- Color-coded by algorithm

#### LOESS smoothing (trend lines)

Using:
```r
geom_smooth(method="loess")
```

This reveals:
- performance trends
- noise patterns
- crossover regions

without assuming a linear or polynomial model.

---

## 3. Repository Structure

```
.
├── src/
│   ├── parallelQuicksort.c       # Sequential + parallel quicksort implementation
│   ├── parallelQuicksort         # Compiled binary
│   └── Makefile                  # Build configuration
│
├── scripts/
│   ├── run_benchmarking.sh       # Automated experiment runner (improved)
│   ├── csv_quicksort_extractor.pl    # Long-format CSV parser
│   └── csv_quicksort_extractor2.pl   # Wide-format CSV parser
│
├── data/
│   └── <hostname>_<date>/        # Machine-specific measurement directory
│       ├── measurements_<time>.txt
│       ├── measurements_<time>.csv
│       ├── measurements_<time>_wide.csv
│       └── performance_plot.png
│
├── analysis.R                    # Main analysis and plotting script
└── README.md
```

---

## 4. How to Run the Experiment

### Step 1 — Compile the sorting program

```bash
make -C src/
```

This will compile `parallelQuicksort.c` into the executable `src/parallelQuicksort`.

### Step 2 — Execute the benchmark suite

```bash
bash scripts/run_benchmarking.sh
```

This produces raw logs in:
```
data/<hostname>_<date>/measurements_<time>.txt
```

The script will:
- Create a timestamped output directory
- Run experiments for multiple array sizes (randomized order)
- Execute 30 repetitions per size
- Measure all three sorting algorithms for each run

### Step 3 — Convert raw data to CSV

Extract the data into CSV format:

```bash
# Long format (recommended for analysis)
perl scripts/csv_quicksort_extractor.pl < data/<hostname>_<date>/measurements_<time>.txt > data/<hostname>_<date>/measurements_<time>.csv

# Or wide format (alternative)
perl scripts/csv_quicksort_extractor2.pl < data/<hostname>_<date>/measurements_<time>.txt > data/<hostname>_<date>/measurements_<time>_wide.csv
```

### Step 4 — Run the analysis

Before running the R script, update the file path in `analysis.R` to point to your CSV file:

```r
df <- read.csv("./data/<hostname>_<date>/measurements_<time>.csv")
```

Then execute:

```bash
Rscript analysis.R
```

This generates plots including:
- `performance_plot.png` — visualization with confidence intervals and LOESS smoothing
- Summary statistics printed to console

---

## 5. Interpretation of Results

![Final experiment performance plot](./data/LAPTOP-SMTR1LU7_2025-12-01/performance_plot.png)

The improved methodology (30 repetitions, enhanced size grid, statistical analysis) provides a clear view of the performance behavior of the three quicksort variants.

### 5.1 Built-in qsort is consistently strong

The built-in qsort (blue) is the fastest variant across all tested sizes. Its curve is smooth, stable, and exhibits low variance thanks to optimized libc implementations.

### 5.2 Parallel quicksort has overhead at small sizes

The parallel version (green) is consistently slower than both sequential and built-in quicksort for array sizes up to 1,000,000 elements.
This confirms that the cost of thread creation, synchronization, and recursion management dominates at these scales.

### 5.4 Confidence intervals reveal measurement stability

The **30 repetitions** allow for meaningful confidence intervals:

- **Sequential** and **built-in** algorithms show very tight CIs, indicating stable performance.
- **Parallel quicksort** shows higher variance, reflecting sensitivity to thread scheduling and OS noise.

---

## 6. Lessons Learned

This assignment demonstrates the importance of:

- accounting for measurement noise
- using repetition to reduce statistical uncertainty
- designing experiments with appropriate resolution
- visualizing results on logarithmic scales
- interpreting speedup/slowdown in the context of algorithmic complexity
- applying statistical rigor to performance evaluation

---

## Author

**Eya Ridene**  
M2 MOSIG — SMPE 2025–2026  
Université Grenoble Alpes

---

## Notes

- The parallel quicksort uses a thread level of 10 (defined in `parallelQuicksort.c`)
- All timing measurements use `gettimeofday()` for microsecond precision
- The analysis requires R packages: `ggplot2`, `dplyr`, `scales`, and `tidyr`
- Install R packages if needed: `install.packages(c("ggplot2", "dplyr", "scales", "tidyr"))`
