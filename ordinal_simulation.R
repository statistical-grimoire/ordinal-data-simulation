# Packages
library(tidyverse)
library(effsize)

# Set seed for reproducibility
set.seed(1750737416)

# Parameters
n_iter <- 10000
n <- 100

# Non-linear psychological scale
psych_scale <- c(
  `1` = 1,
  `2` = 3,
  `3` = 10,
  `4` = 32,
  `5` = 100
)

# Storage
results <- tibble(
  iteration = integer(),
  scale_type = character(),
  d_value = numeric()
)

# Simulation loop
for (i in 1:n_iter) {
  # Simulate n 5 point Likert scale scores for two different groups.
  group_A <- sample(names(psych_scale),
    size = n,
    replace = TRUE,
    prob = c(0.05, 0.1, 0.2, 0.3, 0.35)
  )

  group_B <- sample(names(psych_scale),
    size = n,
    replace = TRUE,
    prob = c(0.25, 0.25, 0.2, 0.15, 0.15)
  )

  # "True" psychological values
  true_A <- psych_scale[group_A]
  true_B <- psych_scale[group_B]

  # Get coded 1–5 values
  coded_A <- as.numeric(group_A)
  coded_B <- as.numeric(group_B)

  # Calculate effect sizes
  d_true <- cohen.d(true_A, true_B)$estimate
  d_coded <- cohen.d(coded_A, coded_B)$estimate

  # Store both
  results <- rbind(
    results,
    tibble(
      iteration = i,
      scale_type = "Coded (1-5)",
      d_value = d_coded
    ),
    tibble(
      iteration = i,
      scale_type = "True Scale",
      d_value = d_true
    )
  )
}

write_csv(results, "ordinal_simulation_results.csv")

# Plot
title <- expression(
  paste(
    "Impact of Measurement Scale on Cohen’s ",
    italic("d "),
    "Estimates Across Simulated Trials"
  )
)

ggplot(results, aes(
  x = d_value,
  # y = after_stat(density),
  fill = scale_type
)) +
  geom_histogram(
    alpha = 0.6,
    position = "identity",
    bins = 50,
    colour = "black",
    linewidth = 0.25
  ) +
  geom_segment(
    data = results |>
      group_by(scale_type) |>
      summarise(mean_d = mean(d_value)),
    aes(
      x = mean_d, y = 0, xend = mean_d, yend = Inf,
      linetype = scale_type
    ),
    linewidth = 1.25
  ) +
  scale_x_continuous(breaks = seq(0, 2, by = 0.2)) +
  coord_cartesian(xlim = c(0, 1.5)) +
  scale_fill_manual(values = palette.colors(n = 2, palette = "Dark 2")) +
  labs(
    # title = title,
    x = expression(paste("Cohen's ", italic("d"))),
    y = "Count",
    fill = "Scale Type:",
    linetype = "Scale Type:",
    colour = "Mean Effect"
  ) +
  guides(fill = guide_legend(
    label.position = "bottom",
    title.position = "left",
    title.vjust = 1
  )) +
  theme(
    plot.title = element_text(size = 17),
    axis.text.x = element_text(size = 14),
    axis.title.x = element_text(size = 16),
    axis.text.y = element_blank(),
    axis.ticks.y = element_blank(),
    axis.title.y = element_blank(),
    legend.position = "top",
    legend.direction = "horizontal",
    legend.justification = "left",
    legend.key.width = unit(2, "cm")
  )

ggsave("ord_vs_int_effect.pdf", units = "cm", width = 22, height = 12)
