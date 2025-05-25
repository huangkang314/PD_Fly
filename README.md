
---

## 🧠 PD\_fly: Behavioral Phenotyping in a Drosophila Model of Parkinson’s Disease

This repository contains the code and instructions used in our study on automated behavioral phenotyping of Parkinson’s disease (PD) in *Drosophila melanogaster*. By integrating pose estimation with kinematic analysis and unsupervised movement sequence clustering, we provide a computational pipeline for objective and quantitative assessment of PD-related behavioral deficits.

> 📌 **Main paper:** *Deep Learning Behavioral Phenotyping System in the Diagnosis of Parkinson’s Disease with Drosophila melanogaster*
> ⏩ See manuscript for experimental details and figure references.

---

### 📁 Repository Structure

```
PD_fly/
│
├── code/
│   ├── main_fly_behavior_data_process.m      # Main script to reproduce key analyses and figures
│   ├── data_io/                              # Functions for loading kinematic and movement sequence data
│   ├── pre_process/                          # Functions for preprocessing and feature extraction
│   └── visualization/                        # Scripts for generating figures used in the paper
│
└── data/
    ├── DLC_kine/                             # (Download separately) DeepLabCut pose data (.csv)
    └── Movement_seq/                         # (Download separately) Movement sequence clustering results (.h5)
```

---

### 📥 Data Download

Due to file size limitations on GitHub, the `data/` directory is **not included** in this repository.

You can download the full dataset from the following Google Drive link:

👉 [**Download Dataset from Google Drive**]([https://your_google_drive_link_here](https://drive.google.com/drive/folders/17M-50X0K2_2rGaFiPgNmP82BiLqUeHrr?usp=sharing))

After downloading, extract the contents into the `data/` folder so the directory structure matches the layout above.

---

### 🚀 Quick Start

1. **Install MATLAB (R2020b or later recommended)**
2. Clone this repository:

   ```bash
   git clone https://github.com/your_username/PD_fly.git
   cd PD_fly
   ```
3. Download and extract the dataset as described above.
4. Open `main_fly_behavior_data_process.m` in MATLAB and run to reproduce data processing and figures.

---

### 📊 Data Description

* `data/DLC_kine/`: Contains CSV files named like `DLC_resnet50_Fly_PDOct26shuffle1_1030000.csv`, which store pose estimation results from DeepLabCut. Each file corresponds to a single tracked fly.
* `data/Movement_seq/`: Contains `.h5` files (e.g., `results.h5`) storing the results of unsupervised movement clustering using BehaviorAtlas-style analysis.

---

### 📘 Citation

If you find this code or dataset useful for your work, please cite our paper:

```bibtex
@article{dong2024PDfly,
  title     = {Deep Learning Behavioral Phenotyping System in the Diagnosis of Parkinson’s Disease with Drosophila melanogaster},
  author    = {Keyi Dong and April Burch and Kang Huang},
  journal   = {bioRxiv},
  pages     = {2024.02.23.581846},
  year      = {2024},
  publisher = {Cold Spring Harbor Laboratory},
  doi       = {10.1101/2024.02.23.581846},
  url       = {https://doi.org/10.1101/2024.02.23.581846}
}
```

---

### 📬 Contact

For questions, please contact:
**Huang Kang**
`huangkang314@gmail.com`
Your Institution

---
