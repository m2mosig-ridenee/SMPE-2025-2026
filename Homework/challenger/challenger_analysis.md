# The Challenger : MOOC Module 2 — Exercise 5
## Critical Examination of the Challenger O-ring Analysis

This short report reviews the analysis provided in the exercise and explains what is reasonable in the approach and what led to the serious under-estimation of the risk of O-ring failure on the morning of the Challenger launch.

---

## What is done correctly

The document starts well: the historical context is clear, and the goal of the analysis is explicitly stated. Using a probabilistic model to explore how temperature might influence the probability of O-ring failure is also the right direction. Logistic regression is, in principle, an appropriate tool for this kind of binary/binomial outcome.

The first exploratory visualization (malfunction frequency vs. temperature) is also sensible, even though the dataset is small. The note about pressure being almost constant is honest and helps simplify the problem, at least at first glance.

So the intention and choice of method are reasonable. The problem lies in how the data were handled.

---

## Problems in the analysis

### 1. The major issue: removing all flights with zero malfunctions

The analysis filters the data to keep only flights where at least one O-ring failed:

```python
data = data[data.Malfunction > 0]
```

Flights with no incidents are actually the most informative ones for understanding how temperature affects failure risk, because they show where the system performs safely. By removing them, the analysis ends up looking only at flights where something already went wrong.

As a result, the remaining temperature range becomes very narrow (roughly 53–75°F). With this restricted dataset, it is almost impossible for any statistical model to detect the sharp increase in risk at low temperatures.

A proper logistic regression must use all flights, including those with zero failures.

---

## 2. The logistic model is not set up correctly

The analysis models `Frequency = Malfunction / Count` with a binomial GLM, but it does not provide the number of trials (`Count`). In a binomial setting, each row corresponds to **`Malfunction` failures out of `Count` O-rings**; if `Count` is not supplied (as weights or as success/failure counts), the likelihood is mis-specified and the uncertainty estimates can be misleading.

A correct specification would use the binomial counts directly (e.g., `(Malfunction, Count − Malfunction)`) or use `Frequency` **with** `Count` as the binomial weight.

This is secondary to the selection bias, but it reinforces the incorrect “no temperature effect” conclusion.

---

## 3. The conclusion “temperature has no impact” is unjustified

Because of the two issues above (especially the filtering), the fitted slope ends up being almost zero. But this says much more about the incomplete dataset than about the true physical behavior of the O-rings.

It is also worth noting that the expected launch temperature (31°F) is far outside the filtered dataset. Even if the model had been correctly specified, extrapolating that far beyond the data without caution would be risky.

---

## Conclusion

The analysis underestimates the risk mainly because it discards all flights with no malfunctions, which removes the most informative part of the dataset. Combined with a mis-specified logistic model and an oversimplified risk calculation, this leads to the misleading conclusion that temperature has no impact.

Using the full dataset shows the opposite: the probability of O-ring failure rises sharply at low temperatures. At 31°F, the predicted risk is high enough to justify canceling the launch.
