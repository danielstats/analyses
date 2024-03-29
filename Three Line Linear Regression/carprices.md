Cylinder Count’s Effect on Price Retention
================
Daniel Bagley

<br>

## Background

When deciding which car to purchase, it can sometimes be difficult to
know exactly how much each vehicle is worth when judging the fairness of
its price. Therefore, this analysis will attempt to determine: is there
a linear relationship between mileage and price, modified by the number
of cylinders the vehicle’s engine has?

The dataset utilized lists the prices, mileage, and number of cylinders
for \~800 American vehicles, arranged by make/model. To avoid irrelevant
outliers, the Cadillac XLR-V8 was removed from the data set, as its
price is abnormally high for other 8 cylinder vehicles in the dataset.

Let us define the model and hypotheses that will be used to examine this
question. Utilizing a Multiple linear regression model will result in:

$$
  \underbrace{Y_i}_{\text{Price}} = \overbrace{\beta_0 + \beta_1 \underbrace{X_{i1}}_{\text{Mileage}}}^{\text{4 Cylinders}} + \overbrace{\beta_2 \underbrace{X_{i2}}_{\text{6 Cylinders}} + \beta_3 \underbrace{X_{i1} X_{i2}}_{\text{Interaction}}}^{\text{6 Cylinder adjustments to the line}} +  \overbrace{\beta_4 \underbrace{X_{i3}}_{\text{8 Cylinders}} + \beta_5 \underbrace{X_{i1} X_{i3}}_{\text{Interaction}}}^{\text{8 Cylinder adjustments to the line}} + \epsilon_i
$$

where $\epsilon_i\sim N(0,\sigma^2)$. This results in the following:

<center>

| No. of Cylinders | Resulting Model                                                       |
|------------------|-----------------------------------------------------------------------|
| 4                | $Y_i = \beta_0 + \beta_1 X_{i1} + \epsilon_i$                         |
| 6                | $Y_i = (\beta_0 + \beta_2) + (\beta_1 + \beta_3) X_{i1} + \epsilon_i$ |
| 8                | $Y_i = (\beta_0 + \beta_4) + (\beta_1 + \beta_5) X_{i1} + \epsilon_i$ |

</center>

These separate models illustrate that $\beta_2$ is the difference
between y-intercepts for 6-cylinder vehicles, and $\beta_4$ the
difference for 8-Cylinder vehicles. Additionally, $\beta_3$ and
$\beta_5$ are the differences in slope applied for 6 and 8 cylinder
vehicles respectively.

Based upon this background and model, this analysis will test several
hypotheses to determine if price retention is modified by number of
cylinders:

### Test for Linear Relationship

If there is a linear relationship between the price and the mileage, the
cost of 4-cylinder vehicles will decrease as mileage increases. This
hypothesis will be judged at $\alpha = .05$.

$$
  H_0: \beta_1 = 0 \quad \text{(There is no relationship between price and mileage)} \\
  H_a: \beta_1 \neq 0 \quad \text{(There is a linear relationship between price and mileage)}
$$

### Test for Equal Slopes

If $\beta_3 \ \text{and} \ \beta_5$ are zero, then the vehicle’s having
6 or 8 cylinders will not affect the slope of price retention. However,
if they are not zero, there is an effect upon price retention due to
engine cylinders. This hypothesis will be judged at $\alpha = .05$.

$$
  H_0: \beta_3  = 0 \quad  \text{(Having 6 cylinders has no effect upon price retention)} \\
  H_a: \beta_3 \neq 0 \quad \text{(Having 6 cylinders has an effect upon price retention)} \\
   \ \\
  H_0: \beta_5 = 0 \quad \text{(Having 8 cylinders has no effect upon price retention)} \\
  H_a: \beta_5 \neq 0 \quad \text{(Having 8 cylinders has an effect upon price retention)}
$$

## Analysis

In order to test these hypotheses, we must first determine whether the
testing assumptions have been met. There are five test assumptions for a
linear regression, as follows: 1. The regression relation between $Y$
and $X$ is linear.  
2. The error terms are normally distributed with $E\{\epsilon_i\} = 0$  
3. The variance of the error terms is constant over all $X$ values.  
4. The $X$ values can be considered fixed and measured without error.  
5. The error terms are independent.

Because the order this data was collected in is irrelevant, we can
assume that the error terms are independent and that the $X$ values are
fixed and measured without error. However, a plot of residuals vs order
is provided to indicate how assumption 5 would be checked if there was
question as to its veracity.

Next, a Residuals vs. Fitted plot will allow us to determine whether the
relationship between $Y$ and $X$ is linear, as well as whether the
variance of error terms is constant.

Lastly, a Q-Q plot of error terms will allow us to determine if error
terms are normally distributed.

### Diagnostic plots

<img src="carprices_files/figure-gfm/unnamed-chunk-2-1.png"
data-fig-align="center" />

As can be seen, there are serious problems with the Residuals vs. Fitted
plot. There are several clear patterns: clustering near the 15000-25000
range, then a gap until \~30000, and an obvious downwards trajectory
between those two groups. Because of these patterns, we cannot assume
that the variance of the error terms is constant. Furthermore, there are
problems with the Q-Q plot of error terms, which shows clear deviations
from the fitted line in so many places that the error terms lie outside
the confidence projection more often than within it. For this reason, we
cannot assume that these error terms are normally distributed.

### Graphical Summary

<img src="carprices_files/figure-gfm/unnamed-chunk-3-1.png"
data-fig-align="center" />

As can be seen in the plot, the majority of the 6 cylinder and 8
cylinder cars are grouped together fairly closely, while the 4 cylinder
vehicles appear to have two groupings with prices approximately between
10000-20000 and 25000-35000. This causes the 4 cylinder data to almost
sandwich the 6 cylinder vehicles in the plot, and they have similar
slopes as well. This would probably indicate that their y intercepts are
not significantly different. However, the 8 Cylinder data is grouped
(for the most part) distinctly above the rest of the data, this would
indicate that its y-intercept will be significantly different than the
baseline’s. Furthermore, while the slope change between 4 and 6
Cylinders is minor, the projected slope of the 8 Cylinder group is far
steeper and would indicate that 8 Cylinder cars actually hold their
value worse.

### Hypothesis Test

|                        | Estimate | Std. Error | t value | Pr(\>\|t\|) |
|:----------------------:|:--------:|:----------:|:-------:|:-----------:|
|    **(Intercept)**     |  19439   |   870.6    |  22.33  |  5.981e-86  |
|      **Mileage**       | -0.07839 |  0.04007   | -1.957  |   0.05075   |
|     **Cylinders6**     |   3812   |    1322    |  2.883  |  0.004047   |
|     **Cylinders8**     |  24316   |    1960    |  12.41  |  2.05e-32   |
| **Mileage:Cylinders6** | -0.08363 |   0.0619   | -1.351  |   0.1771    |
| **Mileage:Cylinders8** | -0.3005  |  0.09135   | -3.289  |   0.00105   |

| Observations | Residual Std. Error | $R^2$ | Adjusted $R^2$ |
|:------------:|:-------------------:|:-----:|:--------------:|
|     794      |        6549         | 0.442 |     0.4385     |

Linear Regression of Price according to Mileage and Cylinder count

As could be inferred from the plot of the data, the estimated slope
adjustment for the 6 Cylinder group is very small (-.08), while the
adjustment for 8 Cylinders is relatively much larger (-.3). The same is
true for their P values, $P = .1771 \ \text{and} \ P = .00105$
respectively, indicating that the 8 Cylinder group’s slope adjustment is
statistically significant while the 6 Cylinder group’s is not
$(\alpha = .05)$. Additionally, the Mileage by itself has a $P = .051$,
just over the level of significance.

## Interpretation

Although the assumptions for performing these tests could not be met, an
interpretation will be provided here for what a valid test with these
statistics would indicate. First, although the model utilized revealed
that there is insufficient evidence of a Linear relationship between 4
cylinder vehicle’s price and their mileage, this value is so close to
the level of significance that minor adjustments to the model (perhaps
by removing irrelevant items like the y-intercepts) would most likely
yield a significant value and allow us to reject the null hypothesis
$H_0: \beta_1 = 0$. Second, The Test for Equal Slopes. This is more
intriguing, as there is sufficient evidence to reject
$\beta_5 = 0$—indicating that vehicles with 8 engine cylinders have a
different rate of price retention than those with 4—but NOT sufficient
evidence to reject $\beta_3 = 0$. This indicates that there is no
significant difference in price retention rates for 6 and 4 cylinder
vehicles. It would be interesting to determine if this 8-cylinder
pattern holds true for non-American vehicles, as well as whether even
higher cylinder-count engines have more dramatic price retention slopes.
