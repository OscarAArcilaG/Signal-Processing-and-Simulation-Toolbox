# Signal Processing and Simulation Toolbox

A collection of MATLAB scripts for signal processing, seismic simulation, spectral analysis, and numerical methods.

These scripts were developed and used during research on lunar seismology and synthetic ground-motion generation. They are provided as a reference toolbox for researchers, engineers, and students working with real scientific signals.

[![MATLAB R2022a](https://img.shields.io/badge/MATLAB-R2022a-blue.svg)](https://www.mathworks.com/products/matlab.html)
[![License: CC BY-SA 4.0](https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg)](https://creativecommons.org/licenses/by-sa/4.0/)

---

## Table of Contents

- [Overview](#overview)
- [Repository Structure](#repository-structure)
- [Requirements](#requirements)
- [Usage](#usage)
- [Script Highlights](#script-highlights)
  - [Convolution and Deconvolution](#convolution-and-deconvolution)
  - [Spectral Analysis](#spectral-analysis)
  - [Filter Design](#filter-design)
  - [Seismic Simulation](#seismic-simulation)
  - [Response Spectra](#response-spectra)
  - [Apollo Seismometers](#apollo-seismometers)
  - [Lunar Data Utilities](#lunar-data-utilities)
- [Use Cases](#use-cases)
- [Author](#author)
- [Acknowledgments](#acknowledgments)
- [References](#references)
- [License](#license)

---

## Overview

This repository contains a set of standalone MATLAB scripts covering:

- Convolution and deconvolution:
  - Spectral division
  - Tikhonov regularization
  - Water-level regularization
- Power Spectral Density (PSD) estimation:
  - Welch method
  - PMTM method
- Spectral leakage and windowing:
  - Rectangular
  - Bartlett
  - Hamming
  - Hanning
  - Kaiser
- FIR filter design:
  - Truncated filters
  - Windowed filters
  - Frequency-sampling filters
- Stochastic ground-motion simulation using the Kanai-Tajimi model.
- Response spectrum computation using interpolation of excitation.
- Seismometer transfer functions for Apollo Long Period (LP) and Short Period (SP) instruments.
- White-noise generation and PSD verification.
- Moment magnitude estimation from seismic moment.
- Distance calculations on a spherical Moon.

Each script is designed to be as self-contained as possible and can generally be run independently. Most scripts generate figures and print numerical results to the MATLAB console.

---

## Repository Structure

```text
signal-processing-and-simulation-toolbox/
│
├── convolution/
│   └── 01_exconv.m
│       # Convolution demonstration
│
├── transfer-functions/
│   └── 02_tfunc.m
│       # Transfer-function plots
│
├── psd/
│   ├── 03_power_white_noise_demo.m
│   │   # PSD of white noise using PMTM and Welch
│   ├── BLWN_PSD_Simulation.m
│   │   # PSD simulation of band-limited white noise
│   ├── simulated_WN_PSD.m
│   │   # Ensemble PSD of white noise
│   └── MQ031_02_simulated_WN_PSD.m
│       # Simulated PSD of band-limited white noise
│
├── windows/
│   └── 04_leaktest.m
│       # Spectral leakage and windowing demonstration
│
├── deconvolution/
│   ├── 05_deconvdemo.m
│   │   # Tikhonov deconvolution
│   └── MQ_ChirpTest.m
│       # Water-level deconvolution test
│
├── filters/
│   ├── 06_low_pass.m
│   │   # FIR low-pass filter design
│   ├── 07_filterdemo.m
│   │   # Frequency-domain filtering
│   └── 08_filterdemo2.m
│       # Comparison of FIR filter-design strategies
│
├── simulation/
│   ├── generate_quake.m
│   │   # Kanai-Tajimi ground-motion generator
│   ├── MQ_a03_bode_kanai.m
│   │   # Kanai-Tajimi filter Bode plot
│   └── Test.m
│       # Synthetic moonquake test
│
├── response-spectra/
│   ├── Espectro.m
│   │   # Response spectrum computation
│   ├── interpolation.m
│   │   # Interpolation-of-excitation method
│   └── MQ_a02_spectra.m
│       # FFT and PSD of a test signal
│
├── seismometers/
│   ├── MQ05_Transfer_Functions.m
│   │   # Apollo LP and SP seismometer transfer functions
│   ├── TF.m
│   │   # Sensitivity plots
│   └── peakacc.m
│       # Peak-acceleration transfer function
│
├── lunar-data/
│   ├── moment_magnitude.m
│   │   # Moment magnitude from seismic moment
│   ├── MoonDistance.m
│   │   # Great-circle distance on a spherical Moon
│   ├── MQ_R.m
│   │   # Epicentral distance matrix
│   └── MQ_Opti_Results.m
│       # PSO results summary and Excel export
│
└── README.md
```

---

## Requirements

### MATLAB

- MATLAB R2022a or later.

### Required Toolboxes

#### Signal Processing Toolbox

Required for functions including:

- `pwelch`
- `pmtm`
- `butter`
- `filtfilt`
- `hampel`

#### Control System Toolbox

Required for functions including:

- `tf`
- `lsim`
- `feedback`
- `bode`

#### Robust Control Toolbox

Required only for scripts using uncertainty modeling, such as `Uncertainties_EXAM.m`, including:

- `ureal`
- `uss`
- `gridureal`
- `usubs`

> **Note:** `Uncertainties_EXAM.m` is referenced here as an optional/extended script and is not included in the repository structure above.

#### Optimization Toolbox

Not strictly required for the core toolbox. It is useful for extended work involving:

- `particleswarm`
- Particle Swarm Optimization (PSO)

---

## Data Requirements

No additional data files are required for the core examples.

Several scripts generate synthetic signals internally, allowing the examples to be executed without downloading external datasets.

Some scripts, particularly those related to Apollo seismic research, may be used as reference implementations for externally obtained lunar seismic records.

---

## Usage

Each script can generally be run independently from MATLAB.

### Example: Tikhonov Deconvolution

```matlab
run('deconvolution/05_deconvdemo.m')
```

### Example: White-Noise PSD

```matlab
run('psd/03_power_white_noise_demo.m')
```

### Example: Kanai-Tajimi Ground-Motion Simulation

```matlab
[T, GA, ss_eq] = generate_quake(30, 0.001, 5, 0.6, 1, 1);
```

### Example: Response Spectrum

```matlab
run('response-spectra/Espectro.m')
```

---

## Typical Script Output

Most scripts produce one or more of the following:

- Numerical results printed to the MATLAB console.
- Time-domain plots.
- Frequency-domain plots.
- PSD estimates.
- Transfer-function plots.
- Response spectra.
- Comparisons between theoretical and simulated signals.
- Optional PDF exports of figures.

---

# Script Highlights

## Convolution and Deconvolution

### `01_exconv.m`

Demonstrates the convolution of:

- A boxcar function.
- A decaying exponential.

The example illustrates convolution in the time domain and its relationship with signal transformation.

### `05_deconvdemo.m`

Demonstrates deconvolution using:

- Direct spectral division.
- Tikhonov regularization.

The script compares different regularization levels and illustrates the trade-off between signal recovery and noise amplification.

### `MQ_ChirpTest.m`

Tests water-level deconvolution using a logarithmic chirp signal.

The script evaluates the reconstruction quality and quantifies the fit using NRMSE.

---

## Spectral Analysis

### `03_power_white_noise_demo.m`

Compares Power Spectral Density estimates obtained using:

- PMTM.
- Welch's method.

The estimated PSD is integrated to recover and compare signal power.

### `BLWN_PSD_Simulation.m`

Simulates band-limited white noise and verifies its expected PSD characteristics.

### `simulated_WN_PSD.m`

Computes an ensemble PSD for simulated white-noise realizations.

### `MQ031_02_simulated_WN_PSD.m`

Analyzes the simulated PSD of band-limited white noise.

---

## Spectral Leakage and Windowing

### `04_leaktest.m`

Demonstrates spectral leakage and compares several window functions:

- Rectangular
- Bartlett
- Hamming
- Hanning
- Kaiser

The script provides a practical illustration of the relationship between window choice and spectral estimation.

---

## Filter Design

### `06_low_pass.m`

Designs truncated FIR low-pass filters using different window functions, including:

- Rectangular
- Bartlett
- Hamming

### `07_filterdemo.m`

Explores frequency-domain filtering and the effect of phase manipulation on a real audio signal.

### `08_filterdemo2.m`

Compares several FIR filtering approaches:

1. Running-average filtering.
2. Truncated inverse-FFT filtering.
3. Frequency-sampling FIR filter design.

---

## Seismic Simulation

### `generate_quake.m`

Generates synthetic earthquake ground motion using the Kanai-Tajimi model.

The generator allows customization of model parameters and produces synthetic ground-motion time histories.

Example:

```matlab
[T, GA, ss_eq] = generate_quake(30, 0.001, 5, 0.6, 1, 1);
```

### `MQ_a03_bode_kanai.m`

Plots the Bode diagram of the Kanai-Tajimi filter and illustrates its frequency-response characteristics.

### `Test.m`

Generates synthetic moonquake signals and compares them with real Apollo seismic records.

---

## Response Spectra

### `Espectro.m`

Computes response spectra including:

- Displacement spectrum.
- Velocity spectrum.
- Acceleration spectrum.
- Pseudo-velocity spectrum.
- Pseudo-acceleration spectrum.

### `interpolation.m`

Implements the interpolation-of-excitation method for numerical response-spectrum computation.

The method is intended to improve computational efficiency while maintaining the required numerical response.

### `MQ_a02_spectra.m`

Performs spectral analysis of a test signal, including:

- FFT.
- PSD estimation.

---

## Apollo Seismometers

### `MQ05_Transfer_Functions.m`

Contains the derivation and analysis of transfer functions associated with Apollo:

- Long Period (LP) seismometers.
- Short Period (SP) seismometers.

The script includes analysis of:

- Flat modes.
- Peak modes.
- Transfer-function behavior.

### `TF.m`

Provides a simplified comparison of seismometer sensitivity, including sensitivity expressed in DU/cm.

### `peakacc.m`

Analyzes the peak-acceleration transfer function and includes relevant:

- Bandwidth markers.
- Water-level markers.

---

## Lunar Data Utilities

### `moment_magnitude.m`

Converts seismic moment into moment magnitude (`Mw`).

### `MoonDistance.m`

Computes the great-circle distance between two locations on the Moon, modeled as a sphere.

### `MQ_R.m`

Builds an epicentral-distance matrix between shallow moonquake locations and Apollo seismic stations.

### `MQ_Opti_Results.m`

Aggregates Particle Swarm Optimization (PSO) characterization results and produces an Excel summary.

---

# Use Cases

This toolbox can be useful for:

### Lunar Seismology

- Working with Apollo seismic records.
- Understanding Apollo seismometer responses.
- Analyzing lunar seismic signals.
- Studying synthetic moonquake ground motion.

### Signal Processing

- Learning PSD estimation.
- Studying spectral leakage.
- Comparing window functions.
- Designing FIR filters.
- Exploring convolution and deconvolution.
- Studying transfer functions.

### Engineering

- Studying ground-motion simulation.
- Computing response spectra.
- Exploring dynamic-system response.
- Applying numerical methods to vibration and seismic signals.

### Education

The scripts are intended to provide practical examples for:

- Students learning signal processing.
- Students learning numerical methods.
- Engineers studying dynamic systems.
- Researchers developing scientific signal-processing workflows.

---

# Author

**Oscar Alejandro Arcila Giraldo**

- LinkedIn
- GitHub
- ORCID
- ResearchGate

---

# Acknowledgments

Special thanks to:

- **Daniel Gómez Pizano, PhD** — Research advisor, Universidad del Valle.
- **Alejandro Cruz Escobar, MSc** — Research advisor, Universidad del Valle.
- **Universidad del Valle** — Internal research project 21078.
- **ISAS/JAXA** — DARTS database for Apollo seismic records.

---

# References

1. Chopra, A. (2012). *Dynamics of Structures* (4th ed.). Prentice Hall.

2. Clough, R. & Penzien, J. (2003). *Dynamics of Structures* (3rd ed.). Computers and Structures Inc.

3. Horvath, P. (1979). *Analysis of Lunar Seismic Signals* (Dissertation). Texas University.

4. Kanai, K. (1957). *Semi-empirical Formula for the Seismic Characteristics of Ground*. Transactions of the Architectural Institute of Japan.

5. Nakamura, Y., Latham, G., Dorman, H., & Harris, J. (1981). *Passive Seismic Experiment, Long Period Event Catalog*. University of Texas.

6. Nunn, C. et al. (2020). *Lunar Seismology: A Data and Instrumentation Review*. Space Science Reviews, 216(5), 89.

7. Tajimi, H. (1960). *A Statistical Method of Determining the Maximum Response of a Building Structure during an Earthquake*. Proceedings of the 2nd World Conference on Earthquake Engineering.

8. Yamada, R. (2005). *The Apollo Seismometer Responses*. DARTS.

---

# License

This work is licensed under the **Creative Commons Attribution-ShareAlike 4.0 International License (CC BY-SA 4.0)**.

You are free to:

- Share — copy and redistribute the material in any medium or format.
- Adapt — remix, transform, and build upon the material.

Under the following terms:

- **Attribution** — Appropriate credit must be given.
- **ShareAlike** — Adaptations must be distributed under the same license.

[View the full CC BY-SA 4.0 license](https://creativecommons.org/licenses/by-sa/4.0/).
