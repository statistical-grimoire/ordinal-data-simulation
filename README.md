# Ordinal Data and Effect Size Inflation: A Simulation

This repository contains R code for a simulation that demonstrates how treating **ordinal Likert-scale data** as if it were **interval-scaled** can lead to **inflated effect size estimates** when using **Cohen's *d***.

The simulation compares estimated effect sizes under two assumptions:
- When **Likert values (1–5)** are treated as **equally spaced interval values**, and
- When values are mapped onto a **nonlinear psychological scale** that reflects more realistic spacing between categories (e.g., a jump from 4 to 5 may feel larger than from 1 to 2).

---

## Background

Ordinal scales—such as those based on Likert items—are often analyzed using methods that assume interval-level measurement. This includes calculating means, standard deviations, *t*-tests, and Cohen’s *d*. However, the assumption of equal spacing between values is often unjustified, especially when numeric labels mask unequal psychological distances.

This simulation illustrates:
- How Cohen’s *d* can be **inflated** by misapplying interval assumptions,
- Why the **underlying structure of the response scale** matters,
- The importance of **choosing effect size measures appropriate for the level of measurement**.

---

## Repository Contents

- `ordinal_simulation.R` – Main script to run the simulation.
- `ordinal_effect_sim_results.csv` – Output from the simulation in comma-separated format.
- `ord_vs_int_effect.pdf` – Plot comparing the distributions of Cohen’s *d* under ordinal and interval assumptions.
- `README.md` – This file.

---

## How to Run the Simulation

1. Ensure you have R (≥ 4.0.0) installed.
2. Install the required packages if you don’t already have them:

```r
install.packages(c("tidyverse", "effsize"))

```

3. Run the script:

```r
source("ordinal_simulation.R")
```

The script simulates 10,000 experiments, compares group-level differences under both interval and ordinal scale assumptions, and generates a histogram of effect size distributions along with a data file containing the full simulation results.

---

## Citation

If you use this code, dataset, or plot in your research, teaching, or publications, please cite the repository as follows:

### APA-style citation:

> Pisklak, J. (2025). *Ordinal data and effect size inflation: A simulation* (Version 1.0) [GitHub]. https://github.com/statistical-grimoire/book/tree/main/data/ordinal-effect-sim

### BibTeX

```bibtex
@online{ ,
  author       = {Pisklak, Jeffrey M.},
  title        = {Ordinal Data and Effect Size Inflation: A Simulation},
  year         = {2025},
  organization = {GitHub},
  url          = {https://github.com/statistical-grimoire/ordinal-data-simulation},
  note         = {v1.0}
}
```

---

## Package References

- Torchiano, M. (2020). *effsize: Efficient effect size computation* (R package version 0.8.1). [https://CRAN.R-project.org/package=effsize](https://CRAN.R-project.org/package=effsize)  
[https://doi.org/10.5281/zenodo.1480624](https://doi.org/10.5281/zenodo.1480624)

- Wickham, H., Averick, M., Bryan, J., Chang, W., D'Agostino McGowan, L., François, R., Grolemund, G., Hayes, A., Henry, L., Hester, J., Kuhn, M., Pedersen, T. L., Miller, E., Bache, S. M., Müller, K., Ooms, J., Robinson, D., Seidel, D. P., Spinu, V., Takahashi, K., Vaughan, D., Wilke, C., Woo, K., & Yutani, H. (2019). Welcome to the tidyverse. *Journal of Open Source Software, 4*(43), 1686. https://doi.org/10.21105/joss.01686

---

## License
This project is licensed under the GNU General Public License v3.0 (GPL-3.0). See the [`LICENSE`](LICENSE) file for details.


