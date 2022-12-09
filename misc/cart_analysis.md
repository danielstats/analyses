CART Analysis
================
Claire, Daniel, and Danielle’s group

## Reliability

Having determined to calculate Split-halves reliability, we will now
calculate the halves-based reliability and perform the Spearman Brown
correction:

``` r
#test without demo questions
set.seed(1213)
crat <- cart_bin |> 
  select(2:22) |> 
  mutate(id = 1:nrow(cart_bin)) |> 
  pivot_longer(cols = 1:21, names_to = "item", values_to = "response")

half_pick <- sample(1:21, 10)

half_2 <- filter(crat, item %in% names(table(crat$item))[half_pick]) |> 
  group_by(id) |> 
  summarize(half_2 = sum(response)/ 10)
half_1 <- filter(crat, ! item %in% names(table(crat$item))[half_pick])  |> 
  group_by(id) |> 
  summarize(half_1 = sum(response) / 11)

halves_scores <- inner_join(half_1, half_2, by = "id")

base_r <- cor(halves_scores$half_1, halves_scores$half_2)
adj_r <- (2 * base_r) / (1 + base_r)

pander::pander(round(adj_r, 4), caption = "Correlation Coefficient for Split halves reliability")
```

*0.5338*

Our correlation coefficient is not very high, but compared to some tests
in the social sciences, it’s actually pretty good.

We can also plot the scores between halves:

``` r
ggplot(halves_scores, aes(y = half_2, x = half_1)) + 
  geom_point() + 
  geom_smooth(formula = "y ~ x", method = "lm") +
  labs(title = "Correlation between randomly split halves")
```

![](cart_analysis_files/figure-gfm/unnamed-chunk-3-1.png)

### “Didn’t try/pay attention” Scale

Using the predetermined items, we can calculate a Try Scale score for
each respondent. As seen below, there are 2 individuals who scored a 2
on the Try Scale.

``` r
cart_long <- cart_bin |> 
  mutate(id = 1:nrow(cart_bin)) |> 
  pivot_longer(cols = 2:23, names_to = "item", values_to = "response")

try_scale <- cart_long |> 
  group_by(id) |> 
  filter(item %in% c("einstein", "panda", "color_red", "computer_science")) |> 
  summarize(tried = sum(response))
pander(table(try_scale$tried))
```

|  2  |  3  |  4  |
|:---:|:---:|:---:|
|  2  | 23  | 75  |

``` r
cart_long <- cart_long |> 
  filter(id != c(28,40))

t_sd <- sd(try_scale$tried)
t_mu <- 4
t_xb <- 2
t_n <- length(try_scale$tried)

t_score <- (t_xb - t_mu) / (t_sd / sqrt(t_n))
```

It is very unlikely that an individual would score a 2 if they were in
fact trying their best. Assuming that an individual trying their best
would get a 4, we can do a t-test, which results in a t-score of
approximately -40 and thus a p-value very near 0. Therefore, we will
remove those individuals whose Try_Scale score is a 2.

## Validity

We will attempt to demonstrate group differentiation. First, we format
the data to distinguish between those in our “Rexburg Resident” group
and those in Utah vs. elsewhere. Then, we will calculate scores for each
student and perform an ANOVA to determine whether mean scores differ
across groups.

``` r
group_val <- cart_long |> 
  group_by(id) |> 
  summarize(score = sum(response),
            group = as.factor(group)) |> 
  distinct()

group_nov <- aov(score ~ group, data = group_val)

pander(summary(group_nov))
```

|               | Df  | Sum Sq | Mean Sq | F value |  Pr(\>F)  |
|:-------------:|:---:|:------:|:-------:|:-------:|:---------:|
|   **group**   |  2  | 236.9  |  118.4  |  29.77  | 8.284e-11 |
| **Residuals** | 97  | 385.9  |  3.978  |   NA    |    NA     |

Analysis of Variance Model

``` r
tukeyout <- TukeyHSD(group_nov, "group")

#pairwise.t.test(group_val$score, group_val$group, adjust = "bonferroni")
```

As we can see, there is a significant effect in group. To identify which
groups are different from each other, we will consult a Tukey’s Honest
Significant Difference adjusted pairwise t-test. The results are
summarized in a plot below, where a line intersecting the dotted line at
0 is nonsignificant and a line that doesn’t touch 0 is significant. It
is most important that the 0-1 group is significant, so that’s the line
we are looking at:

``` r
plot(tukeyout)
```

![](cart_analysis_files/figure-gfm/unnamed-chunk-6-1.png)

As we can see, there is a significant difference in mean scores between
the Rexburg Resident group and the Utah resident group. This indicates
that our test is successful in identifying those who are/are not
Rexburgians.

Additionally, we can visualize a density plot/histogram of the CART
scores according to the respondent group.

``` r
ggplot(group_val, aes(x = score)) + 
  geom_histogram(aes(y = ..density..), fill = "white", color = "black", binwidth = 2) +
  #geom_dotplot(aes(y = ..density..)) +
  geom_density(color = "olivedrab", linetype = "3121", size = 1.5 ) +
  #stat_function(fun = function(x) mean(x), geom = "line", color = "firebrick") +
  facet_wrap(facets = vars(group)) +
  labs(title = "Distribution of CART scores by respondent group",
       y = "",
       x = "Score")
```

![](cart_analysis_files/figure-gfm/unnamed-chunk-7-1.png)

### Item difficulty analysis

Having reformatted each item, we can find combined difficulties across
the test as well as difficulty between groups. Doing so will help us
determine which, if any, questions should be re-worked or removed
entirely.

``` r
item_difficulty <- cart_long |> 
  filter(! item %in% c("group", "did_best")) |> 
  group_by(item) |> 
  summarize(difficulty = sum(response) / n()) |> 
  arrange(difficulty)

difficulty_by_group <- cart_long |> 
  filter( item != "did_best") |> 
  group_by(item, group) |> 
  summarize(difficulty = sum(response) / n()) |> 
  pivot_wider(names_from = group, values_from = difficulty, names_prefix = "group_") |> 
  arrange(group_0)

difficulty_all <- inner_join(item_difficulty, difficulty_by_group, by = "item") |> 
  mutate(GoodQ = if_else(group_0 > difficulty , if_else(difficulty > group_1 & difficulty > group_2, "Yes", "Maybe"), "Delete")) |> 
  arrange(GoodQ)
names(difficulty_all) <- c("item", "difficulty", "Rexburg", "Utah", "Other", "Good Question") 


pander::pander(difficulty_all)
```

|       item       | difficulty | Rexburg |  Utah   | Other  | Good Question |
|:----------------:|:----------:|:-------:|:-------:|:------:|:-------------:|
|  harvest_dummy   |   0.1212   | 0.1071  | 0.1667  |   0    |    Delete     |
|    snowballs     |   0.4242   | 0.4107  | 0.4722  | 0.2857 |    Delete     |
|     housing      |   0.6162   | 0.5357  | 0.6944  | 0.8571 |    Delete     |
| computer_science |   0.8586   | 0.8393  | 0.8889  | 0.8571 |    Delete     |
|     farming      |   0.9091   | 0.8929  | 0.9444  | 0.8571 |    Delete     |
|       NCMO       |   0.9596   | 0.9464  | 0.9722  |   1    |    Delete     |
|    color_red     |     1      |    1    |    1    |   1    |    Delete     |
|     einstein     |     1      |    1    |    1    |   1    |    Delete     |
|     owned_by     |     1      |    1    |    1    |   1    |    Delete     |
|    mcmidnight    |   0.697    | 0.8393  | 0.4722  | 0.7143 |     Maybe     |
|       fhe        |   0.8182   | 0.8571  |  0.75   | 0.8571 |     Maybe     |
|    population    |   0.8384   | 0.8393  | 0.8056  |   1    |     Maybe     |
|      panda       |   0.899    | 0.9107  | 0.8611  |   1    |     Maybe     |
|       Devo       |   0.9192   | 0.9464  | 0.8611  |   1    |     Maybe     |
|    republican    |   0.9596   | 0.9643  | 0.9444  |   1    |     Maybe     |
|    hold_music    |   0.3838   | 0.4464  | 0.3056  | 0.2857 |      Yes      |
|   parks_dummy    |   0.4242   | 0.6786  | 0.05556 | 0.2857 |      Yes      |
|    stargazing    |   0.4343   |  0.625  | 0.1389  | 0.4286 |      Yes      |
|     mc_dummy     |   0.4444   |  0.75   |    0    | 0.2857 |      Yes      |
|     grocery      |   0.6061   | 0.7143  | 0.4722  | 0.4286 |      Yes      |
|    semesters     |   0.7172   | 0.8214  | 0.5556  | 0.7143 |      Yes      |

As we can see, there are 6 items which are indicated as being
“high-quality” (whatever that means in this context), 6 with
questionable discrimination/usefulness, and 9 items where the Rexburg
group either did worse or no better than the Utah/Other groups.
