# GORICA-for-contingency-tables

R code for the examples in

> Altınışık, Y., Hessels, R. S., Van Lissa, C. J., & Kuiper, R. M. (2025). An AIC-type information criterion evaluating theory-based hypotheses for contingency tables. *Behavior Research Methods, 57*(2), 70. https://doi.org/10.3758/s13428-024-02570-6

All analyses use the R package [`gorica`](https://CRAN.R-project.org/package=gorica). Each script sets `set.seed(111)`, which is needed to reproduce the simulated penalty terms.

## Which script produces which table

| Script | Example | Data | Results |
|---|---|---|---|
| `Gender by earned degrees example.R` | Gender by earned degrees | Table 1 | Table 8 (`res$estimates`, `res$Sigma`) and Table 9 (`res`) |
| `Eye_tracking_example.R` | Eye tracking, Person 1 influences Person 2 | Table 10 | Table 11 (`res$estimates` and the adjusted covariance matrix `covmtrx`) and Table 12 (`res2`) |
| `Eye_Tracking_Example/Person2influencesPerson1.txt` | Eye tracking, Person 2 influences Person 1 | Suppl. Table 6 | Suppl. Table 7 (`est` and the adjusted covariance matrix `covmtrx`) and Suppl. Table 8 (`res2`) |
| `Hypothesis_evaluation_in_the_presence_of_structural_zeros.R` | Structural zeros | in the script | Illustrates the section "Hypotheses Evaluation in the Presence of Structural Zeros" of the Online Supplementary material (no numerical results are reported there) |
| `Structural_zeros_local_odds_ratios_example.R` | Structural zeros, local odds ratios | in the script (illustrative table) | Illustrates the local odds ratio example in the section "Rewriting hypotheses based on η̂ = 1 or η is not estimable" of the Online Supplementary material (no data or numerical results are reported there) |

The `.txt` files in `Gender_by_earned_degrees_Example/` and in `Eye_Tracking_Example/` (scenario Person 1 influences Person 2) are short versions of the corresponding `.R` scripts and give the same results.

Notes:

- The defined parameters `a, b, c, ...` in the scripts correspond to `eta1, eta2, eta3, ...` in the paper.
- In the eye-tracking example, eta3 (`c`) and eta4 (`d`) are estimated as zero, so their variances are zero. These variances are replaced by the smallest positive variance in the matrix. Table 11 reports this *adjusted* matrix, which the scripts print as `covmtrx`; `res$Sigma` is the unadjusted matrix.
- In the structural zeros scripts, some calls are meant to stop with an error message (to illustrate that the hypothesis must be rewritten). They are wrapped in `try()`, so the full scripts run with `source()`.

## Corrections to the Online Supplementary material

1. In Table 5 (third row), the rewritten hypothesis is printed as *H*<sub>m</sub>: π<sub>11</sub>π<sub>22</sub> − π<sub>22</sub>π<sub>13</sub> > 0. This should be

   *H*<sub>m</sub>: π<sub>11</sub>π<sub>13</sub>π<sub>22</sub><sup>2</sup> − π<sub>12</sub><sup>2</sup>π<sub>21</sub>π<sub>23</sub> > 0,

   which follows from η<sub>1</sub> > η<sub>2</sub> with η<sub>1</sub> = π<sub>11</sub>π<sub>22</sub>/(π<sub>12</sub>π<sub>21</sub>) and η<sub>2</sub> = π<sub>12</sub>π<sub>23</sub>/(π<sub>22</sub>π<sub>13</sub>) after multiplying both sides by the (positive) denominators. In the notation of the supplement's local odds ratio example, this is η<sub>1</sub><sup>⋄</sup> > η<sub>2</sub><sup>⋄</sup> with η<sub>1</sub><sup>⋄</sup> = π<sub>11</sub>π<sub>13</sub>π<sub>22</sub><sup>2</sup> and η<sub>2</sub><sup>⋄</sup> = π<sub>12</sub><sup>2</sup>π<sub>21</sub>π<sub>23</sub>. Since π̂<sub>21</sub> = 0, η̂<sub>2</sub><sup>⋄</sup> = 0, and gorica then automatically evaluates it as π<sub>11</sub>π<sub>13</sub>π<sub>22</sub><sup>2</sup> > 0.

2. In the local odds ratio example (section "Rewriting hypotheses based on η̂ = 1 or η is not estimable"), "η̂<sub>2</sub><sup>⋄</sup> = η̂<sub>4</sub><sup>⋄</sup> = 0" should be **η̂<sub>2</sub><sup>⋄</sup> = η̂<sub>3</sub><sup>⋄</sup> = 0**. With π̂<sub>12</sub> = π̂<sub>23</sub> = 0, η<sub>3</sub><sup>⋄</sup> = π<sub>12</sub>π<sub>14</sub>π<sub>23</sub><sup>2</sup> contains both empty cells, whereas η<sub>4</sub><sup>⋄</sup> = π<sub>13</sub><sup>2</sup>π<sub>22</sub>π<sub>24</sub> contains neither. This is also why η<sub>3</sub><sup>⋄</sup> > η<sub>4</sub><sup>⋄</sup> is rewritten as η<sub>4</sub><sup>⋄</sup> < 0. The rewritten hypothesis in the supplement (η<sub>1</sub><sup>⋄</sup> > 0, η<sub>4</sub><sup>⋄</sup> < 0) is correct; see `Structural_zeros_local_odds_ratios_example.R`.

## How to run

```r
install.packages("gorica")
source("Gender by earned degrees example.R", echo = TRUE)
source("Eye_tracking_example.R", echo = TRUE)
```

Each `.R` script ends with `sessionInfo()`. The results in Tables 8, 9, 11 and 12 have been reproduced with gorica 0.1.6 in R 4.6.2 and in R 4.3.3, and those in Supplementary Tables 7 and 8 with gorica 0.1.6 in R 4.3.3. The eye-tracking scripts take about half a minute each.

## Acknowledgement and change log

We thank the editorial team of the [Journal of Reproducible Statistics](https://jrepstat.fairpressjournals.com/) (FAIR Press Journals) for independently rerunning the gender by earned degrees and eye-tracking examples (November 2026). All values they compared agreed with the paper.

Changes made in response to their report:

- this README, with the mapping of scripts to tables (they had to match the scripts to the tables by hand);
- the eye-tracking scripts now also print the adjusted covariance matrix (Table 11), so the variances of eta3 and eta4 can be checked from the output.

Their report also encouraged us to check the parts they did not cover: the eye-tracking example in which Person 2 influences Person 1 (Supplementary Tables 6 to 8, which agree with the supplement), the structural zeros examples, and the data in Table 10. This follow-up check led to these further changes:

- corrected table numbers in the script comments;
- `try()` in the structural zeros script so that it runs completely, and a corrected definition of eta1 in its last example (the denominator is now pi12*pi21, as described in the comments);
- a new script for the local odds ratio example with structural zeros (`Structural_zeros_local_odds_ratios_example.R`);
- two corrections to the Online Supplementary material (see above);
- `sessionInfo()` at the end of the scripts.

## License

See `LICENSE`.
