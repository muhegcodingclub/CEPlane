ggplot2::ggplot(read.csv("data/results.csv"), ggplot2::aes(QALYs, Costs)) +
  ggplot2::geom_point() +
  ggplot2::scale_color_manual(values = c('#E69F00'))  +
  ggplot2::xlab("Incremental QALYs") + ggplot2::ylab("Incremental costs") +
  ggplot2::geom_abline(slope = 96000, linetype = "dashed") +
  ggplot2::geom_hline(yintercept = 0) +
  ggplot2::geom_vline(xintercept = 0)