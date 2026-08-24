# f1-strat-optimizers
A simulation suite using MATLAB modeling the longitudinal vehicle dynamics, sensitivity to aerodynamics and Formula 1 race strategies (tyre degradation, fuel burn and optimization of DRS).
# Vehicle Dynamics & Race Strategy Suite 🏎️

I built this suite of MATLAB scripts to bridge the gap between fundamental vehicle physics and real-world motorsports strategy. Whether it's figuring out how aero drag kills top speed or modeling the dreaded "tyre cliff" over a long stint, these tools simulate real track dynamics from scratch.

---

## What's in the Repo?

* **`vehicle_accelerator.m`** — Simulates straight-line acceleration while managing the realities of physics: grip limits (traction vs. normal force) at launch, power curves at high speeds, and quadratic aerodynamic drag. It also runs a sweep across different drag coefficients ($C_d$) to see how aero tweaks affect terminal velocity.
* **`f1_strategy_optimizer.m`** — Models a race stint by balancing two opposing forces: cars getting faster as they burn fuel, but slower as their tyres degrade using a non-linear wear curve.
* **`f1_strategy_drs.m`** — Adds a bit of probability into the mix (`rand`), simulating realistic DRS windows (like chasing a rival vs. running in clean air) to see how much lap time you can actually gain.

---

## How It Works (Quick Breakdown)

* **Numerical Integration:** Uses custom Euler integration loops to step through velocity profiles over time.
* **Multi-Variable Sweeps:** Automatically iterates through design parameters (like varying $C_d$) to map out sensitivity analyses.
* **Real-World Math:** Factors in things like air density ($\rho$), frontal area ($A$), friction coefficients ($\mu$), and exponential tyre wear.

---

## Visuals & Plots

*(Here is where you'll want to drop in screenshots of your MATLAB plots—like the aero sweep or the lap time vs. stint progress. Recruiters love seeing the actual graphs right away!)*

```markdown
<!-- Drop your images in an assets folder and link them like this:
![Aero Sensitivity Plot](assets/aero_sweep.png)
-->
