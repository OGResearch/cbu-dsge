![[math]]

# Productivity assumptions

---

## Overall productivity

* Unit root process (in logs) with autocorrelated rate of growth
* A 1% shock $\longrightarrow$ a 1% permanent increase in the level

$$
\Delta \log A_t = \rho_A \cdot \Delta \log A_{t-1} + (1-\rho_A) \cdot \widehat a
+ (1-\rho_A) \cdot \epsilon_{A,t}
$$


* $\widehat a$ is the steady-state rate of change in overall productivity

---

## Public infrastructure augmented productivity

* Sum of overall productivity and efficiency adjusted public infrastructure

$$
\AA t = A_t + \iotaKG \cdot \Kg t
$$

* $\iotaKG$ is efficiency of public infrastructure relative to overall productivity

---

## Local sector specific productivity

* Sector specific component

$$
\log \Ad t = \rhoAD \cdot \log \Ad {t-1}
+ \left( 1 - \rhoAD \right) \cdot \log \Ad{\mathrm{ss}}
$$

* Total sector specifiy productivity

$$
\Ad t = \AA t \cdot \Ad t
$$

---

## Nonprimary export sector specific productivity

* Sector specific component

$$
\log \Az t = \rhoAD \cdot \log \Az {t-1}
+ \left( 1 - \rhoAD \right) \cdot \log \Az{\mathrm{ss}}
$$

* Total sector specifiy productivity

$$
\Az t = \AA t \cdot \Az t
$$

---

## Primary export sector specific produtivity


* Sector specific component

$$
\log \Aq t = \rhoAD \cdot \log \Aq {t-1}
+ \left( 1 - \rhoAD \right) \cdot \log \Aq{\mathrm{ss}}
$$

* Total sector specifiy productivity 

$$
\Aq t = A_t \cdot \Aq t
$$

* Does not include public infrastructure effects
