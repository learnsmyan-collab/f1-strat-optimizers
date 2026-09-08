# F1 Race Strategy & DRS Simulation Suite

A professional MATLAB simulation framework modeling Formula 1 race pace over a stint by factoring in non-linear thermal tyre degradation, transient fuel weight burn-off, and state-dependent DRS traffic dynamics.

---

## 🚀 What It Does

Most basic strategy models treat every lap independently. This engine implements a realistic race simulation by tracking:
* **Tyre Degradation:** Uses a non-linear exponential wear scale so performance drops off sharply as the stint progresses.
* **Fuel Burn:** Accounts for the car getting lighter lap by lap (~1.5kg to 2kg burned per lap), providing a natural pace boost over race distance.
* **Traffic & DRS Logic:** Replaces simple random probabilities with a Markov-style stickiness loop (`sticky_chance`) to model multi-lap battle persistence and adjust top-speed benefits based on tyre age.

---

## 📐 Mathematical Foundations & Governing Equations

### 1. Lap Time & Degradation Model
The net lap time ($t_{lap}$) for any given lap ($i$) across an $N$-lap stint is calculated as:

$$t_{lap} = t_{base} + (i^{\beta} \cdot k_{wear}) - ((N - i) \cdot k_{fuel}) - \Delta t_{drs}$$

*Where:*
* $t_{base}$ = Clean air baseline pace ($90.0\text{ s}$)
* $\beta$ = Tyre wear exponent ($1.2$)
* $k_{wear}$ = Base tyre wear factor ($0.02$)
* $k_{fuel}$ = Fuel weight lap-time gain ($0.07\text{ s/lap}$)
* $\Delta t_{drs}$ = DRS time delta, scaled down based on tyre thermal state.

### 2. Thermal Cliff & Stint Projection Engine
For any given lap $i$ with tire age $age_i$, the non-linear thermal degradation cliff is modeled as:

$$\text{LapTime}_i = \text{base\_pace} + (\text{wear\_rate} \cdot \text{age}_i) + \left(k_{\text{cliff}} \cdot \max(0, \text{age}_i - \text{onset})^{1.7}\right)$$

Cumulative stint strategies—evaluating staying out versus pitting now while factoring in pit-stop delta time loss—are calculated via summation:

$$\text{Total}_{\text{stay}} = \sum_{i=1}^{N} \text{LapTime}(\text{tyre\_age} + i)$$

$$\text{Total}_{\text{pit}} = t_{\text{pit\_loss}} + \sum_{i=1}^{N} \text{LapTime}(i)$$

---

## 📊 Visual Outputs & System Dashboards

### 1. Stint & DRS Traffic Analysis (`F1_Strategy_With_DRS.m`)
![F1 Stint Analysis Plot](outputs/drs_stint_analysis.png)

### 2. Pit Window Crossover Optimization
![F1 Stint Analysis Plot](outputs/F1_Strategy_Crossover.png)

---

## 📂 Repository Layout

```text
f1-strat-optimizers/
├── data/               # Config files & telemetry logs
├── outputs/            # Generated stint analysis plots
├── src/                # Core MATLAB simulation scripts
│   └── F1_Strategy_With_DRS.m
├── requirements.txt    # Environment notes
└── README.md

