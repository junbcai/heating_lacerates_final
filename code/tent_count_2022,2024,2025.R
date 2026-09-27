library(tidyverse)

# Avoid conflicts with functions from other loaded packages
select    <- dplyr::select
filter    <- dplyr::filter
mutate    <- dplyr::mutate
summarise <- dplyr::summarise
summarize <- dplyr::summarize
group_by  <- dplyr::group_by
arrange   <- dplyr::arrange
rename    <- dplyr::rename
count     <- dplyr::count
left_join <- dplyr::left_join


# ============================================================
# Read cleaned datasets
# ============================================================

tent_2022 <- read_csv(
  "~/Documents/GitHub/heating_lacerates_final/data/2022_tentcount_cleaned.csv",
  show_col_types = FALSE
)

tent_2024 <- read_csv(
  "~/Documents/GitHub/heating_lacerates_final/data/2024_tentcount_cleaned.csv",
  show_col_types = FALSE
)

tent_2025 <- read_csv(
  "~/Documents/GitHub/heating_lacerates_final/data/2025_tentcount_cleaned.csv",
  show_col_types = FALSE
)


# Avoid conflicts with functions from other loaded packages
select    <- dplyr::select
filter    <- dplyr::filter
mutate    <- dplyr::mutate
summarise <- dplyr::summarise
summarize <- dplyr::summarize
group_by  <- dplyr::group_by
arrange   <- dplyr::arrange
rename    <- dplyr::rename
count     <- dplyr::count
recode     <- dplyr::recode
left_join <- dplyr::left_join

# ============================================================
# 2022
# Only standardize plate type
# ============================================================

tent_2022 <- tent_2022 %>%
  mutate(
    plate = as.character(plate)
  ) %>%
  select(
    ID, plate, treatment, line, symbiosis,
    well, temp, lacerate, day, day_cat, tent_count
  )


# ============================================================
# 2024
# Standardize to match 2022
# ============================================================

tent_2024 <- tent_2024 %>%
  mutate(
    # Make plate character
    plate = as.character(plate),
    
    # Standardize symbiosis naming
    # Ino -> Inoc
    symbiosis = recode(
      symbiosis,
      "Ino" = "Inoc"
    ),
    
    # Standardize treatment capitalization/naming
    # H2-Apo-25C -> H2-APO-25C
    # H2-Sym-25C -> H2-SYM-25C
    # H2-Ino-25C -> H2-INOC-25C
    treatment = str_replace_all(
      treatment,
      c(
        "-Apo-" = "-APO-",
        "-Sym-" = "-SYM-",
        "-Ino-" = "-INOC-"
      )
    ),
    
    # Change 0_day, 3_day, etc. to day_0, day_3, etc.
    day_cat = paste0("day_", day)
  ) %>%
  select(
    ID, plate, treatment, line, symbiosis,
    well, temp, lacerate, day, day_cat, tent_count
  )


# ============================================================
# 2025
# Standardize to match naming conventions
# ============================================================

tent_2025 <- tent_2025 %>%
  mutate(
    # Make plate character
    plate = as.character(plate),
    
    # Standardize symbiosis naming
    # Keep Inoc as the standard
    symbiosis = recode(
      symbiosis,
      "Ino" = "Inoc"
    ),
    
    # Standardize treatment capitalization
    # H2-Apo-25C  -> H2-APO-25C
    # H2-Sym-25C  -> H2-SYM-25C
    # H2-Inoc-25C -> H2-INOC-25C
    treatment = str_replace_all(
      treatment,
      c(
        "-Apo-"  = "-APO-",
        "-Sym-"  = "-SYM-",
        "-Inoc-" = "-INOC-"
      )
    ),
    
    # Ensure day_cat follows day_# convention
    day_cat = paste0("day_", day)
  ) %>%
  select(
    ID, plate, treatment, line, symbiosis,
    well, temp, lacerate, day, day_cat, tent_count
  )


# ============================================================
# Check structures
# ============================================================

glimpse(tent_2022)
glimpse(tent_2024)
glimpse(tent_2025)

# Column names should now be identical
names(tent_2022)
names(tent_2024)
names(tent_2025)

identical(names(tent_2022), names(tent_2024))
identical(names(tent_2022), names(tent_2025))


# ============================================================
# Check treatment naming
# ============================================================

unique(tent_2022$treatment)
unique(tent_2024$treatment)
unique(tent_2025$treatment)


# ============================================================
# Check symbiosis naming
# ============================================================

unique(tent_2022$symbiosis)
unique(tent_2024$symbiosis)
unique(tent_2025$symbiosis)


# ============================================================
# Check temperature naming
# ============================================================

unique(tent_2022$temp)
unique(tent_2024$temp)
unique(tent_2025$temp)


# ============================================================
# Check day categories
# ============================================================

unique(tent_2022$day_cat)
unique(tent_2024$day_cat)
unique(tent_2025$day_cat)


# ============================================================
# Check plate data types
# ============================================================

class(tent_2022$plate)
class(tent_2024$plate)
class(tent_2025$plate)


# ============================================================
# Check lacerates
# ============================================================

unique(tent_2022$lacerate)
unique(tent_2024$lacerate)
unique(tent_2025$lacerate)

# ============================================================
# Check all values/codes in key variables
# ============================================================

sort(unique(tent_2022$tent_count))
sort(unique(tent_2024$tent_count))
sort(unique(tent_2025$tent_count))

sort(unique(tent_2022$symbiosis))
sort(unique(tent_2024$symbiosis))
sort(unique(tent_2025$symbiosis))

sort(unique(tent_2022$temp))
sort(unique(tent_2024$temp))
sort(unique(tent_2025$temp))

sort(unique(tent_2022$line))
sort(unique(tent_2024$line))
sort(unique(tent_2025$line))

sort(unique(tent_2022$day))
sort(unique(tent_2024$day))
sort(unique(tent_2025$day))



# ============================================================
# Save standardized datasets
# ============================================================

write_csv(
  tent_2022,
  "~/Documents/GitHub/heating_lacerates_final/data/2022_tentcount_standardized.csv"
)

write_csv(
  tent_2024,
  "~/Documents/GitHub/heating_lacerates_final/data/2024_tentcount_standardized.csv"
)

write_csv(
  tent_2025,
  "~/Documents/GitHub/heating_lacerates_final/data/2025_tentcount_standardized.csv"
)