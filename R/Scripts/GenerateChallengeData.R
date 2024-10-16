install.packages("ggplot2")
install.packages("remotes")
remotes::install_github("ready4-dev/youthu")
library(youthu)
library(ggplot2)
# library(ready4use)
set.seed(1234)
ds_tb <- make_fake_ds_two()
predn_ds_ls <- make_predn_metadata_ls(ds_tb,
                                      cmprsn_groups_chr = c("Intervention", "Control"),
                                      cmprsn_var_nm_1L_chr = "study_arm_chr",
                                      costs_var_nm_1L_chr = "costs_dbl",
                                      id_var_nm_1L_chr = "fkClientID",
                                      msrmnt_date_var_nm_1L_chr = "date_psx",
                                      round_var_nm_1L_chr = "round",
                                      round_bl_val_1L_chr = "Baseline",
                                      utl_var_nm_1L_chr = "AQoL6D_HU",
                                      mdls_lup = get_mdls_lup(utility_type_chr = "AQoL-6D",
                                                              mdl_predrs_in_ds_chr = c("PHQ9 total score",
                                                                                       "SOFAS total score"),
                                                              ttu_dv_nms_chr = "TTU"),
                                      mdl_nm_1L_chr =  "PHQ9_SOFAS_1_OLS_CLL")
ds_tb <- add_utl_predn(ds_tb,
                       predn_ds_ls = predn_ds_ls) %>%
  dplyr::select(fkClientID, round, study_arm_chr, date_psx, duration_prd, dplyr::everything())
ds_tb  <- ds_tb %>% add_qalys_to_ds(predn_ds_ls = predn_ds_ls,
                                    include_predrs_1L_lgl = T,
                                    reshape_1L_lgl = T)
he_smry_ls <- ds_tb %>% make_hlth_ec_smry(predn_ds_ls = predn_ds_ls, wtp_dbl = 50000, bootstrap_iters_1L_int = 1000L)
results_df <- data.frame(IncrementalCosts = he_smry_ls[["ce_res_ls"]][["delta_c"]][[1]],
                         IncrementalQALYs = he_smry_ls[["ce_res_ls"]][["delta_e"]][[1]])
write.csv(results_df, "data/results.csv", row.names = FALSE)



