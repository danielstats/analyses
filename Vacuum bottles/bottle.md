Does the Bottle Matter?
================
Daniel Bagley
10/28/2021

# 

## Introduction

To many youths in the Intermountain west, a trendy water bottle seems to
be the very pinnacle of “making it” amongst your peers. However, a
question arises: while these more expensive vacuum-sealing bottles are
definitely cooler, are they really cooler? Or in other words, do they
perform the function of a water bottle any better than one which can be
purchased for half or even a quarter of the same price? Eschewing the
cultural value thereof in favor of statistical evidence, we will analyze
the temperature retentive properties of 3 water bottles and 1 control (a
glass jar) to determine whether there is a difference in temperature
retention between the control and any of the bottles; and if so whether
there is a significant difference between the three bottles’ temperature
retention. We will analyze these questions by measuring the relative
difference in water temperature before and after a 4 hour period. We
will test both hot and cold water to determine if one bottle is better
at retaining hot or cold temperatures. Formally stated, our questions
are these: Does a more expensive water bottle retain water temperature
better? Is it easier for a vacuum-seal water bottle to retain the
temperature of hot or cold water? And, finally, Is there a difference in
the temperature retention between hot/cold liquid depending on bottle?

### Hypotheses

Does a more expensive water bottle retain water temperature better?

$$
  H_0: \alpha_{Built} = \alpha_{Ctrl} =  \alpha_{Equate} = \alpha_{Hydro} = 0 \\ 
  H_a: \alpha_i \ne 0 \ \text{for at least one } i \in \{Built,\  Control, \ Equate, \ Hydro\} 
$$

Does a vacuum-seal bottle better retain temperature of hot or cold
water?

$$
  H_0: \beta_H = \beta_C = 0 \\
  H_a: \beta_i \ne 0 \text{ for at least one } i \in \{H = Hot, \ C= Cold\}
$$

Is there a difference in the temperature retention between hot/cold
liquid depending on bottle?

$$
H_0: \alpha\beta_{ij} = 0 \text{ for all } i, j \\
H_a: \alpha\beta_{ij} \ne 0 \text{ for at least one } i, j
$$

#### Level of Significance

Level of significance $\alpha = .05$ will be used for the duration of
this analysis.

## Methods

#### Materials

For this analysis, 4 water bottles were chosen. First, a control
consisting of a glass mason jar, a Built brand vacuum-seal bottle, an
Equate brand vacuum-seal bottle, and a Hydro Flask brand vacuum-seal
bottle. All the containers were sized at 32 ounces, and each except the
control had a screw-on lid.

Water was collected from the kitchen faucet and sourced from the City of
Rexburg’s Municipal water supply. To obtain the needed temperatures,
water dispensed from the tap was heated in a microwave or placed in a
refrigerator to cool, then added to the relevant bottle (which was the
ambient room temperature).

#### Measurements

Every test was performed in an apartment with an ambient temperature
averaging 72 degrees, at randomly chosen times of day (between 8am and
10pm) to prevent a potential effect due to time of day. Furthermore,
each bottle was placed in the same location on the kitchen table during
testing and left there for the duration of the test each time.

To balance the necessities of limited resources with a desire for
accuracy and to provide an effective test environment, each test was
performed for exactly 4 hours, with the water in the bottle being raised
or lowered to the target temperature and then immediately sealed and a
timer being set for that duration.

Measurements were taken through a Thermoworks IRK-2 Infrared thermometer
with a Thermoworks K-449 Industrial probe. The probe was fully immersed
in the bottle, stirred for a few seconds, then let sit until the reading
stabilized (about 15 seconds). This thermocouple is accurate to within
2.7 degrees Fahrenheit, and data should be interpreted thusly.

#### Conditions

Testing conditions were applied by either heating or cooling the water
to a specified temperature chosen before testing. For the Hot condition,
110 degrees Fahrenheit was chosen because most warm drinks are served at
a temperature of at least 100 degrees, but it becomes painful to drink
liquid hotter than approximately 140 degrees. Therefore, 110 degrees
seems a good approximate temperature, if also an arbitrary one.

For the Cold condition, 45 degrees Fahrenheit was chosen as a
temperature that is slightly warmer than most refrigerators but also
colder than most taps (the tap used approximated 55 degrees Fahrenheit
at its coldest setting) and hence a good middle choice between the two.

In both conditions, the water was cooled/heated to the desired
temperature INSIDE the bottle to prevent heat loss/gain from
stirring/pouring, then the bottle was immediately sealed.

#### Response

After the 4-hour timer elapsed, the bottle was opened and immediately
measured for the current water temperature using the same procedure
described above. The water was then dumped out of the bottle and the
bottle was allowed to return to ambient room temperature before
performing another test.

Order was randomized for each test, with each bottle being chosen
randomly and then filled. Each bottle was tested in staggered periods of
5-10 minutes (depending on how long it took to get the water to the
correct temperature), and Hot/Cold condition was chosen semirandomly
(random save that equal numbers of each condition had to be tested)
before each test.

## The Data

Seen below is a table showing some summary statistics for each water
bottle both by bottle and temperature, then all the collected data for
perusal if so desired. Note the similar means between the Built and
Hydro bottles, and that the Standard Deviation of the Control is much
higher than all the others (more than double even the second highest
value).

| bottle | min | median | max | mean  |  sd   |  n  |
|:------:|:---:|:------:|:---:|:-----:|:-----:|:---:|
| Built  |  1  |   3    |  9  | 4.333 | 3.724 |  6  |
|  Ctrl  | 17  |   23   | 36  | 25.33 | 8.847 |  6  |
| Equate |  3  |  6.5   | 12  | 6.833 | 3.971 |  6  |
| Hydro  |  1  |  4.5   |  8  |  4.5  | 3.146 |  6  |

Temperature differences by bottle

| treatment | min | median | max | mean  |  sd   |  n  |
|:---------:|:---:|:------:|:---:|:-----:|:-----:|:---:|
|   Cold    |  1  |   3    | 18  | 6.25  | 6.943 | 12  |
|    Hot    |  1  |   9    | 36  | 14.25 | 11.75 | 12  |

Temperature differences by temperature

## Graphical Summaries

Below is an interaction plot of the Actual Water Temperatures between
groups with the room ambient temperature (72 ℉) as a red line. This
graph is interesting because it indicates a strong difference between
the Control and all other groups, as expected, but little difference
between the other bottles’ final temperatures. If the Hydro Flask is
really better than the other bottles, we would expect to see a
noticeably higher temperature retention for that bottle vs. the other
two vacuum-seal units; we do not.

![](bottle_files/figure-gfm/unnamed-chunk-3-1.png)

Examining the data this way, however, has a few disadvantages. When we
look at the actual end temperatures, there will be an obvious difference
between the hot and cold groups; we want to see not if hot water is
hotter than cold water (knowledge bomb: it is) but rather if hot water
*stays hotter* than cold water *stays colder* in each bottle. So, we
will instead look at the absolute *difference* between pre- and
post-test temperatures, and perform our ANOVA of those data. An updated
plot is shown below:

![](bottle_files/figure-gfm/unnamed-chunk-4-1.png)

In this plot, the closer to 0 the y-axis gets, the better temperature
retentive properties that bottle is displaying. As we can see, The Hydro
Flasks and Built bottles showed the lowest absolute difference, with the
Equate bottle not far behind. The Control in almost every case
approached the ambient temperature, this may be better seen in the first
plot.

## Analysis

With this in mind, we will proceed to analyze the absolute difference in
temperature for each bottle. To determine if the analysis we intend to
perform is statistically valid, we will examine a residuals vs. fitted
and a QQ plot of our data. In the first plot, we look for an obvious
megaphone shape or other distinct pattern to establish whether or not
the variance in our data is constant, while in the QQ plot we look for
variation from the theoretical “normal” line as evidence that the data
is not normally distributed. These two diagnostic plots are shown below:

![](bottle_files/figure-gfm/unnamed-chunk-5-1.png)

There are a few values at the top end of the data that fall outside of
our normality line and its bounded confidence level (the blue
highlighted area). With that potential skew in mind but also considering
the robust nature of ANOVA, we will proceed with an analysis consider
this slightly abnormal distribution in our results.

An ANOVA table of the data reveals the following:

|                      | Df  | Sum Sq | Mean Sq | F value | Pr(\>F)  |
|:--------------------:|:---:|:------:|:-------:|:-------:|:--------:|
|      **bottle**      |  3  |  1844  |  614.5  |  108.4  | 7.62e-11 |
|    **treatment**     |  1  |  384   |   384   |  67.76  | 3.82e-07 |
| **bottle:treatment** |  3  | 114.3  |  38.11  |  6.725  | 0.003805 |
|    **Residuals**     | 16  | 90.67  |  5.667  |   NA    |    NA    |

Analysis of Variance Between Bottle and Absolute Difference in
Temperature

With p-values far below the level of significance ($\alpha = .05$), the
bottle and water temperature are both found to be significant factors.
Far more important, however, is that the interaction between the two,
seen as “bottle:treatment” on the table, has a p-value of $.0038$, also
below the level of significance. Some of these values were expected, as
having a Control will obviously affect the bottle factor’s significance.
We will also analyze the three non-Control bottles to see if there is a
significant difference between them:

|                      | Df  | Sum Sq | Mean Sq | F value |  Pr(\>F)  |
|:--------------------:|:---:|:------:|:-------:|:-------:|:---------:|
|      **bottle**      |  2  | 23.44  |  11.72  |  2.705  |  0.1072   |
|    **treatment**     |  1  | 138.9  |  138.9  |  32.05  | 0.0001054 |
| **bottle:treatment** |  2  | 6.778  |  3.389  | 0.7821  |  0.4794   |
|    **Residuals**     | 12  |   52   |  4.333  |   NA    |    NA     |

ANOVA without Control bottle

This ANOVA table shows some very interesting information. Without the
control, we lose significance for the Bottle type and the interaction,
retaining only a significant difference in the Hot/Cold groups.
Examining the plot again without the Control, this is plain to see:

![](bottle_files/figure-gfm/unnamed-chunk-8-1.png)

Because there is no longer any significant difference between the
specific bottles, we will avoid performing multiple comparisons, as
there are only two groups and we therefore know that the Hot treatment
results in greater temperature loss than the Cold treatment group.

## Conclusion

The ANOVA performed with the data collected has shown that we have
sufficient evidence to reject the hypotheses that vacuum-seal bottles
have no effect on temperature retention vs. an open contatiner and that
vacuum-seal bottles retain cold and hot water to the same degree; as
well as some marginal evidence to reject the hypothesis that the
specific vacuum-bottle chosen will have no effect on hot/cold water
temperature retention.

It is important to remember that the measurement device used in this
test was accurate to within approximately 3 degrees; that means any
differences less than 3 degrees, even if found to be significant, could
be entirely due to measurement error. However, the significant
differences found had effect sizes between 5 and 8 degrees, outside of
our measurement margin of error. Therefore, we can conclude that the
bottles really do retain the temperature of Hot water worse than they do
for cold water. It would be interesting to study these bottles in
comparison to some sold specifically as hot-liquid thermoses, suited for
that purpose. While it is theoretically true that a vacuum shouldn’t let
cold or hot water disperse its temperature, it appears that the
execution of these bottles is oriented more towards keeping cold water
cold than hot water hot; most likely because most people (at least in
this culture) prefer to drink their water cold.

Lastly, while the Equate bottle had the worst Hot water temperature
retention of the 3 bottles tested, there was no significance found
inside the Hot treatment groups of the bottles, only between Hot and
Cold. In other words, we found no evidence that the Hydro flask is
actually better at keeping liquid the same temperature as the two other
bottles tested. Therefore, from a solely economic standpoint, it is the
recommendation of this researcher that if one is interested in a
vacuum-seal bottle, the price and not the brand should be the primary
consideration of the customer when determining which one to purchase.
