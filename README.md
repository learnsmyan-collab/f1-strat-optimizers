# F1 Race Strategy & DRS Simulation

A lightweight MATLAB model simulating Formula 1 race pace over a stint by factoring in non-linear thermal tyre degradation, fuel weight burn-off, and state-dependent DRS traffic dynamics.

---

## What It Does

Most basic strategy models treat every lap independently. This script sets up a more realistic race simulation by tracking:
* **Tyre Degradation:** Uses a non-linear exponential wear scale so performance drops off harder as the stint goes on.
* **Fuel Burn:** Accounts for the car getting lighter lap by lap (~1.5kg to 2kg burned per lap), giving a natural pace boost over race distance.
* **Traffic & DRS Logic:** Replaces simple random coin flips with a Markov-style stickiness loop (`sticky_chance`). If you're stuck in a DRS train, it realistically models multi-lap battle persistence and adjusts top-speed benefits based on tyre age.

---

## The Math Behind It

The net lap time ($t_{lap}$) for any given lap ($i$) across an $N$-lap stint is calculated as:

$$t_{lap} = t_{base} + (i^{\beta} \cdot k_{wear}) - ((N - i) \cdot k_{fuel}) - \Delta t_{drs}$$
Where:
* $t_{base}$ = Clean air baseline pace ($90.0\text{ s}$)
* $\beta$ = Tyre wear exponent ($1.2$)
* $k_{wear}$ = Base tyre wear factor ($0.02$)
* $k_{fuel}$ = Fuel weight lap-time gain ($0.07\text{ s/lap}$)
* $\Delta t_{drs}$ = DRS time delta, scaled down slightly if your tyres are too worn to hit peak top speed.
  
## Stint Visualisation

![F1 Stint Analysis Plot](outputs/drs_stint_analysis.png)
---

## Repo Layout


f1-strat-optimizers/
├── data/               # Config files & telemetry logs
├── outputs/            # Generated stint analysis plots
├── src/                # Core scripts
│   └── F1_Strategy_With_DRS.m
├── requirements.txt    # Environment notes
└── README.md


# F1 Race Strategy & Pit Window Optimization Engine

---

## The Math Behind the Stint Projection

For any given lap $i$ in a remaining stint of $N$ laps, projected lap time is modeled as:

$$\text{LapTime}_i = \text{base\_pace} + (\text{wear\_rate} \cdot \text{age}_i) + \left(\text{cliff} \cdot \max\left(0, \text{age}_i - \text{cliff\_onset}\right)^{1.7}\right)$$

Cumulative stint times for staying out versus pitting now (accounting for pit-stop delta loss) are evaluated via summation:

$$\text{Total}_{\text{stay}} = \sum_{i=1}^{N} \text{LapTime}(\text{tyre\_age} + i)$$

$$\text{Total}_{\text{pit}} = \text{pit\_loss} + \sum_{i=1}^{N} \text{LapTime}(i)$$

### Corresponding MATLAB Implementation

Here is how those exact equations are vectorized and computed inside the script:

```matlab
% Stint lap vector and aging projections
stint_laps = (1:rem_laps)';
old_ages = tyre_age + stint_laps;

% Stay-out cumulative calculation with non-linear tire cliff
stay_out = base_pace + (wear_rate * old_ages) + (cliff * max(0, old_ages - cliff_onset).^1.7);
total_stay = sum(stay_out);

% Fresh-set pit projection including pit loss penalty
pit_proj = base_pace + (wear_rate * stint_laps) + (cliff * max(0, stint_laps - cliff_onset).^1.7);
total_pit = pit_loss + sum(pit_proj);
