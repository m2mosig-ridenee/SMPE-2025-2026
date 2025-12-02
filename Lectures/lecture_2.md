# 📊 Data Visualization – Detailed Course Summary

## 1. Introduction

The goal of this lecture is to teach how to design graphics that communicate information clearly, efficiently, and truthfully.

## 2. General Principles

Always keep in mind:

- Who is the reader?
- Why should they look at the graphic?
- What question should the graphic answer?

### Goals of a good graphic

- Minimize reader effort
- Maximize useful information
- Minimize ink (remove anything unnecessary)
- Respect conventions (axes, units, colors)
- Compare several graphic types before choosing

### Classic errors

- Too many graphical objects
- Confusing scales / non-standard axes
- Cryptic notations (symbols without explanation)
- Non-useful information
- Wrong scale or wrong graph type

### Key design principles

- **Occam's Razor**: if two graphs contain the same information, choose the simplest.
- **Completion (Dijkstra)**: the graphic is complete when you cannot remove any element without losing information.
- **Common sense**: adapt complexity to the audience.

## 3. Data: Choosing the Right Graphic

The graphic must match the nature of the data

- Time evolution → line plot
- Categories → bar chart
- Parts of a whole → pie chart
- Distribution → histogram
- Relationship → scatter plot

### Good practices

- Interpolation/approximation must make sense
- Curves must have enough data points
- The interpolation method must be clear (linear, polynomial, regression…)
- Confidence intervals should be shown (or explained separately)
- Histogram bins must be appropriate
- Histograms represent probabilities between 0 and 1 (if normalized)

## 4. Graphical Objects

### Requirements

- Must be readable everywhere (screen, print B/W, projection)
- Avoid too similar colors; avoid green on projectors
- Axes must be correctly identified and labelled
- Scales and units must be explicit
- Curves should not cross ambiguously
- Light gridlines may help readability

### Minimize ink

Remove:

- Heavy borders
- Decorative patterns
- 3D effects
- Shadows
- Unnecessary markings

## 5. Annotations

### Axes

- Labelled by quantities
- Clear, self-contained names
- Include units (seconds, %, jobs/s…)
- Standard orientation:
  - X: left → right
  - Y: bottom → top
- Origin at (0,0) unless strongly justified
- No "holes" or missing ranges on axes

### Bars and Curves

- Order bars logically (alphabetical, temporal, from best to worst)
- Each curve has a legend
- Each bar/category has a legend

## 6. Information Quality

To ensure the graphic conveys meaningful information:

- Curves must be on the same scale to allow comparison
- Do not exceed 6 curves per graph (readability rule)
- Curves should be compared only on the same plot
- Removing one curve should reduce the information (else remove it)
- The graphic must answer a specific, relevant question
- If vertical axis shows averages → show error bars
- No graphic element should be removable without harming readability

## 7. Context

Graphics must be integrated into the surrounding text.

### Rules

- All symbols and notations must be defined in the text
- The graphic should provide more insight than any other representation
- The graphic must have a clear, informative title
- Title must allow partial understanding without reading the text
- The figure must be referenced in the text
- The text must comment and interpret the figure

### Purpose

A graphic is not decoration — it is necessary information in a specific context.

## 8. Common Mistakes & Misleading Techniques

### Cryptic information

- Using symbols (μ, λ, p…) instead of descriptive labels
- Prefer direct textual labeling ("1 job/s", "3 jobs/s")

### Non-relevant graphic objects

- Using line charts for categorical data (wrong)
- Overly decorated histograms or bar plots
- Using 3D bars or meaningless backgrounds

### Manipulation (how graphs can cheat)

- Changing the vertical scale to exaggerate or hide differences
- Cutting the baseline (e.g., starting y at 8 instead of 0)
- Using overly large or tiny ranges
- Hiding confidence intervals
- Rearranging bars to mislead
- Removing uncertainty information

## 9. Final Recommendations

✔ A good graphical representation must be:

- Clear
- Complete
- Minimalist
- Honest
- Contextualized
- Adapted to data
- Readable
- Elegant

