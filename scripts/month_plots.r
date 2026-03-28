pacman::p_load(tidyverse, glue, janitor, here, DBI, duckdb)
con <- dbConnect(duckdb::duckdb(), dbdir = here("data", "epc_new.duckdb"))
dbListTables(con)

# energy ratings
tbl(con, "epc_domestic_lep_deduplicated_vw") |> 
  distinct(current_energy_rating)

#@param con: database connection
#@param vw: database view to query
#@param cat_vec: vector of EPC categories to include in the "in_cat" group
#@param yr: minimum year to include in the analysis
#@return a tibble with monthly proportions of properties in the specified EPC categories

vw  <-  "epc_domestic_lep_deduplicated_vw"

raw_tbl <-  tbl(con, vw) |>
  collect()

raw_tbl |> 
    # filter(year(lodgement_datetime) >= yr) |>
    mutate(epc = if_else(current_energy_rating %in% cat_vec,
                         "in_cat", "out_cat")) |>
    group_by(
        epc,
        month = floor_date(lodgement_datetime, "month")
    ) |>
    count(epc) |> 
  arrange(month) |> 
  pivot_wider(names_from = epc, values_from = n) |> 
  ungroup() |> 
  mutate(in_cat_zero = replace_na(in_cat, 0),
         out_cat_zero = replace_na(out_cat, 0),
         in_cat = NULL,
         out_cat = NULL) |> 
  mutate(prop_in_cat = cumsum(in_cat_zero) * 100 / (cumsum(in_cat_zero) + cumsum(out_cat_zero)),
              in_cat_zero = NULL,
              out_cat_zero = NULL) |> 
  filter(month >= as.Date(glue("{yr}-01-01"))) |>
  view()



get_monthly_epc_cat_prop <- function(raw_tbl,
                                    cat_vec = c("A", "B", "C"),
                                    yr = 2020) {
    raw_tbl |> 
    # filter(year(lodgement_datetime) >= yr) |>
    mutate(epc = if_else(current_energy_rating %in% cat_vec,
                         "in_cat", "out_cat")) |>
    group_by(
        epc,
        month = floor_date(lodgement_datetime, "month")
    ) |>
    count(epc) |> 
  arrange(month) |> 
  pivot_wider(names_from = epc, values_from = n) |> 
  ungroup() |> 
  mutate(in_cat_zero = replace_na(in_cat, 0),
         out_cat_zero = replace_na(out_cat, 0),
         in_cat = NULL,
         out_cat = NULL) |> 
  mutate(prop_in_cat = cumsum(in_cat_zero) * 100 / (cumsum(in_cat_zero) + cumsum(out_cat_zero)),
              in_cat_zero = NULL,
              out_cat_zero = NULL) |> 
  filter(month >= as.Date(glue("{yr}-01-01"))) |>
  glimpse()
}

epc_a_c_tbl <- get_monthly_epc_cat_prop(raw_tbl, cat_vec = c("A", "B", "C"))
epc_a_plus_tbl <- get_monthly_epc_cat_prop(raw_tbl, cat_vec = "A")

epc_a_plus_tbl |> view()

theme_set(
    theme_minimal() +
        theme_minimal() +
        theme(
            axis.title.y = element_text(angle = 180, vjust = 0.5, size = 18),
            axis.title.x = element_text(size = 18),
            plot.title = element_text(size = 24, face = "bold"),
            plot.subtitle = element_text(size = 22, face = "italic")
        )
)

epc_a_plus_tbl %>%
    ggplot(aes(x = month, y = prop_in_cat)) +
    geom_line(linewidth = 2, color = "blue") +
    labs(
        title = "Percentage of Properties with Energy Rating A to C",
        subtitle = "West of England including North Somerset",
        x = "Month",
        y = "%"
    ) +
    expand_limits(y = c(0, 100))

epc_a_c_tbl %>%
    ggplot(aes(x = month, y = prop_in_cat)) +
    geom_line(linewidth = 2, color = "red") +
    labs(
        title = "Percentage of Properties with Energy Rating A to C",
        subtitle = "West of England including North Somerset",
        x = "Month",
        y = "%"
    ) +
    expand_limits(y = c(0, 100))
