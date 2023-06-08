$$
\newcommand{\Bhb}[1]{\mathit{Bhb}_{#1}}
\newcommand{\Bgb}[1]{\mathit{Bgb}_{#1}}
\newcommand{\Bbw}[1]{\mathit{Bbw}_{#1}}
\newcommand{\Rgfcy}[1]{\mathit{Rg}^\fcy_{#1}}
\newcommand{\Rwfcy}[1]{\mathit{Rw}^\fcy_{#1}}
\newcommand{\PREMg}[1]{\mathit{PREMg}_{#1}}
\newcommand{\PIEb}[1]{\Pi b_{#1}}
\newcommand{\E}{\mathrm{E}}
\newcommand{\Rh}[1]{\mathit{Rh}_{#1}}
\newcommand{\Rg}[1]{\mathit{Rg}_{#1}}
\newcommand{\Qh}[1]{\mathit{Qh}_{#1}}
$$

# Financial and settlement system

## Role

* Settlement of net claims of nonfinancial agents
* Financial arbitrage


## Balance sheet

Assets | | | Liabilities
:---:|---|---|:---:
Net claims on households | $\Bhb t$ | $\Bbw t$ | Net claims by nonresidents
Net claims on government | $\Bgb t$ | |


$$
\Bhb t + \Bgb t = \Bbw t
$$

## Denomination and remuneration

All claims by nonresidents

* denominated in foreign currency

* remunerated at the sovereign foreign currency rate

$$
\Rgfcy t = \Rwfcy t \cdot \PREMg t
$$
All claims on residents are 

* denominated in local currency

* remunerated at a rate comprising the cost and risk of maintaining the claims


## Profit of financial sector

$$
\E_t \left[\, \PIEb t\ \right] = \Rh t \cdot \Bhb t \left(1 - \Qh{t+1}\right) + \Rg t \cdot \Bgb t
- \Rgfcy t \cdot \Bbw t \tfrac{S_{t+1}}{S_t} 
$$
