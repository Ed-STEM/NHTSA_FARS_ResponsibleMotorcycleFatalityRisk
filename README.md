# Motorcycle vs Passenger Car Fatality Study (FARS)

## Abstract

This study analyzes crash outcomes using data from the Fatality Analysis Reporting System (FARS) to compare motorcycles and passenger cars under controlled conditions.

A driver-level dataset was constructed with the following filters:
- No alcohol involvement
- No speeding-related crashes
- Valid driver’s license
- Helmet use required for motorcycles

Vehicle groups:
- Motorcycles (`BODY_TYP == 80`)
- Passenger cars (`BODY_TYP 1–9`)

The primary metric is driver fatality rate (`INJ_SEV == 4`).

### Results

- Passenger Cars: 34.5% (241 / 699)
- Motorcycles: 90.9% (50 / 55)

### Conclusion

Motorcycle crashes are approximately **2.6× more likely to result in driver death** than passenger car crashes, even under non-risky conditions and with helmet use.

This suggests that the observed difference is primarily due to **structural safety limitations** rather than driver behavior.

### Limitation

FARS includes only fatal crashes; results represent **fatality probability conditional on a fatal crash**, not overall crash risk.

## Author

Ed di Girolamo  
Software Engineer (C / Data Systems / Analytics)

---
