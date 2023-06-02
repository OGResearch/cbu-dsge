![[math]]

# Details of local supply side

* Pairwise production stages
* Overhead and variable labor
* Productivity and public infrastructure
* Public incentives to expand capacity
* Short-term Leontief, long-term Cobb-Douglas at some stages


---

## Pairwise production stages

<br/>

### Stage T–3: Local inputs

Combine

* capital, $\Kd{t-1}$
* variable labor,  $\NNd t$
* public infrastructure augmented productivity, $\AAd t$

to produce $\Dthree t$ under perfect competition condition
$$
\Dthree t = \Kd{t-1} {}^{1-\gammaND} \cdot \left( \AAd t \cdot \NNd t \right)^{\gammaND} 
$$
To operate, the producers need to keep a fixed amount of overhead labor employed, $\NOd t$. Total amount of labor is

$$
\Nd t = \NOd t + \NNd t \\
$$

### Stage T–2: Nonprimary import inputs

Combine

* stage $T-3$ output, $\Dthree t$
* nonprimary import inputs, $\Md t$

to produce $\Dtwo t$ under perfect competition conditions

$$
\Dtwo t = \min \left\{
\, \frac{\Dthree t}{1-\gammaMD}\, , \ 
\, \frac{\ \Md t\ }{\gammaMD}
\right\}
$$


### Stage T–1: Energy inputs

Combine

* stage $T-2$ output, $\Dtwo t$
* nonprimary import inputs, $J_t$

to produce $\Done t$ under perfect competition condition

$$
\Done t = \min \left\{
\, \frac{\Dtwo t}{1-\gammaJD}\, , \ 
\, \frac{\ \Md t\ }{\gammaJD}
\right\} 
$$

### Stage T: Distribution

* Total output $D_t = \Done t$ is demanded either as consumption goods or investment goods

$$
\begin{gathered}
D_t = \underbrace{\ C_t + \Gg t\ }_\text{Consumption}
+ \underbrace{\ \Id t + \Iz t + \Ig t + \Ih t \ }_\text{Investment}
\\[20pt]
\CC t = C_t + \Gg t
\\[20pt]
\II t = \Id t + \Iz t + \Ig t + \Ih t
\end{gathered}
$$


* Monopoly power $\mu_\mathit{CI}\ge 1$ (Lerner index) when selling goods in either market

$$
CC_t = \overline{\CC{}}_t \cdot \left(\frac{\Pc t}{\overline{\Pc{}}_t} \right)^{-\frac{\muCI}{\muCI-1}}
$$


---

## Productivity and public infrastructure

Public infrastructure augmented technology

$$
\AA t = A_t + \iotaKG \cdot \Kg t
$$

Total productivity in local sector

$$
\AAd t = \AA t \cdot \Ad t
$$

---

## Public incentives to expand capacity

Household budget constraint in Lagrangian with government support of supply side


$$
\begin{gather*}
\Lambda_t \cdot \left[
\underbrace{-\ \Pi t \cdot \Id t \cdot \left(1 + \M{adj}_t - {\color{yellow}\iota_{GD} \cdot \TRgd t} \right)}_{}
\quad \underbrace{+\ \Pkd t \cdot \M{Id_t}}
\quad \underbrace{+\ \Pkd t \cdot \Kd{t-1} \cdot \left(1 - \delta_{Kd}\right)}
\quad \underbrace{-\ \M{Pkd}_t \cdot \Kd t}
\right]
\\[10pt]
+\quad \beta \cdot \Lambda_{t+1} \cdot \left[
\underbrace{\M{Prkd_{t+1}} \cdot \Kd t}_{}
\quad \underbrace{+\ \M{Pkd}_{t+1} \cdot \M{Kd}_t \cdot \left(1-\delta_{Kd}\right)}_{}
\right]
\end{gather*} 
$$

Government support for local supply side

$$
\TFgd t = \TRgd t \cdot \Pi t \cdot \Id t
$$

---

## Short-term Leontief, long-term Cobb-Douglas

Leontief production function

$$
\Dtwo t = \min \left\{
\, \frac{\Dthree t}{1-\gammaMD}\, , \ 
\, \frac{\ \Md t\ }{\gammaMD}
\right\}
$$

Demand functions for inputs

$$
\begin{gathered}
\Dthree t = \left(1 - \gammaMD\right) \, \Dtwo t
\\[20pt]
\Md t = \gammaMD \, \Dtwo t 
\end{gathered} 
$$

The real share parameter, $\gammaMD$ is not set as a deep/structural parameter but rather derived as follows:

1. Create a steady state model with a Cobb-Douglas production function instead, with the share parameter denoted by $\gammaMD\star$
$$
\Dtwo t = \left( \Dthree t\right)^{\gammaMD\star}
\, \left( \Md t \right)^{1-\gammaMD\star}
$$
2.  Switch to a Leontief equation for dynamic simulations, setting
$$
\gammaMD \equiv \frac{\Md{\ss}}{\Dtwo{\ss}}
$$
3. To resolve steady-state transition (from one value of $\gammaMD$ to another) and avoid a discrete jump, make the parameter time varying
$$
\gammaMD_t = \rho_{\gammaMD} \cdot \gammaMD_{t-1} + \left(1 - \rho_{\gammaMD} \right) \cdot \frac{\Md{\ss}}{\Dtwo{\ss}}
$$
