# ============================================================
# FARS Motorcycle vs Passenger Car Fatality Study
# ============================================================
# Goal:
# Compare motorcycle vs passenger car fatality outcomes
# under controlled conditions:
#   - No alcohol
#   - No speeding
#   - Valid license
#   - Helmet use (motorcycles)
#
# Data Source:
# NHTSA FARS (Fatality Analysis Reporting System)
# Author:
# Ed di Girolamo
# ============================================================

library(dplyr)

# ---------------------------
# Load Data (update path)
# ---------------------------
data_dir <- "FARS2023NationalCSV"

accident <- read.csv(file.path(data_dir, "accident.csv"))
vehicle  <- read.csv(file.path(data_dir, "vehicle.csv"))
person   <- read.csv(file.path(data_dir, "person.csv"))

# ---------------------------
# Prepare Driver-Level Dataset
# ---------------------------
drivers <- person %>%
  filter(PER_TYP == 1)  # Drivers only

data <- vehicle %>%
  inner_join(drivers, by = c("ST_CASE", "VEH_NO")) %>%
  inner_join(accident, by = "ST_CASE")

# ---------------------------
# Filter Clean Cohort
# ---------------------------
clean_data <- data %>%
  filter(
    DRINKING == 0,   # No alcohol
    SPEEDREL == 0,   # No speeding
    L_STATUS == 1    # Valid license only
  )

# ---------------------------
# Define Study Groups
# ---------------------------

# Motorcycles (helmeted riders only)
motorcycles <- clean_data %>%
  filter(
    BODY_TYP.x == 80,   # Motorcycle
    HELM_USE == 17      # Helmet used
  ) %>%
  mutate(study_group = "motorcycle")

# Passenger Cars (all standard passenger vehicles)
compact_cars <- clean_data %>%
  filter(
    BODY_TYP.x >= 1 & BODY_TYP.x <= 9
  ) %>%
  mutate(study_group = "passenger_car")

# ---------------------------
# Combine Dataset
# ---------------------------
study_data <- bind_rows(motorcycles, compact_cars)

# ---------------------------
# Summary Results
# ---------------------------
results <- study_data %>%
  group_by(study_group) %>%
  summarise(
    total_drivers = n(),
    driver_deaths = sum(INJ_SEV == 4, na.rm = TRUE),
    driver_fatality_rate = driver_deaths / total_drivers,
    .groups = "drop"
  )

print(results)

# ---------------------------
# Notes
# ---------------------------
# - FARS includes only fatal crashes (≥1 fatality per crash)
# - Results represent:
#     "Driver fatality probability given a fatal crash"
# - Not overall crash risk (no exposure denominator)
# ============================================================
