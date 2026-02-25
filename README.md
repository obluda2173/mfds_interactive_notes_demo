# MFDS Interactive Lecture Notes

[![Build and Deploy](https://github.com/obluda2173/mfds/actions/workflows/publish.yml/badge.svg)](https://github.com/obluda2173/mfds/actions/workflows/publish.yml)

Interactive lecture notes for the **Mathematical Foundations of Data Science (MFDS)** program at the University of Vienna.

🌐 **Live Website:** [obluda2173.github.io/mfds](https://obluda2173.github.io/mfds/)

---

## About

This repository contains interactive lecture notes built with [Quarto](https://quarto.org/) and [Pyodide](https://pyodide.org/), a Python runtime compiled to WebAssembly. All code runs directly in the browser — no installation or server required.

Inspired by MIT's [Introduction to Computational Thinking](https://computationalthinking.mit.edu/) course.

---

## Available Lectures

### Introduction to Analysis

| Lecture | Topic | Link |
|:--------|:------|:-----|
| 1 | Newton's Method | [View](https://obluda2173.github.io/mfds/lectures/analysis/01_newton_method.html) |

*More lectures coming soon.*

---

## Running Locally

### Prerequisites

- [Quarto](https://quarto.org/docs/get-started/) (v1.6 or later)
- [R](https://www.r-project.org/) with `knitr` and `rmarkdown` packages

### Setup

```bash
git clone https://github.com/obluda2173/mfds.git
cd mfds
quarto preview
```

---

## Repository Structure

```
mfds/
├── _quarto.yml                 # Project-level configuration
├── _extensions/
│   └── r-wasm/live/            # quarto-live extension (Pyodide runtime)
├── index.qmd                   # Homepage
├── styles.css                  # Custom styles
├── lectures/
│   ├── analysis/               # Analysis I lectures
│   │   └── 01_newton_method.qmd
│   ├── linear_algebra/         # Linear Algebra lectures
│   └── programming/            # Programming lectures
└── .github/
    └── workflows/
        └── publish.yml         # Builds and deploys to GitHub Pages
```

---

## License

Released into the public domain under [The Unlicense](https://unlicense.org/).

---

## Author

**Erik An** — MFDS Bachelor, University of Vienna (2025–2028)  
GitHub: [@obluda2173](https://github.com/obluda2173)
