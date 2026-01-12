# Synchronous PWM Controller with Parametric Dead-Band Insertion

## Project Overview
This repository features a high-fidelity Pulse Width Modulation (PWM) controller optimized for **Wide Bandgap (WBG) semiconductors**. The design focuses on the generation of complementary, non-overlapping gate drive signals. By implementing a parametric dead-band insertion logic, the controller effectively prevents cross-conduction (shoot-through) during high-frequency switching transitions.

## Technical Specifications
* **Architecture:** Fully synchronous RTL design with registered output stages.
* **Synchronization:** Input buffering to mitigate metastable states and combinational race conditions.
* **Resolution:** Parametric bit-width for duty cycle ($R$) and timer frequency ($TIMER\_BITS$).
* **Safety Logic:** Hardware-level enforcement of dead-time intervals across all duty cycle variations.

## Functional Verification Results

The design was validated using a **Parameter Sweep** strategy. The table below summarizes the timing accuracy across different operational modes.

| Test Case | Description | Duty Cycle | Dead-Band (`dt_val`) | Measured Delay | Waveform Link |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Case 1** | High-Frequency Opt. | 50% (`0x80`) | 5 Cycles | **50.00 ns** | [View Waveform](./waveforms/pwm_dt5_zoomIN.png) |
| **Case 2** | High-Reliability | 75% (`0xC0`) | 20 Cycles | **200.00 ns** | [View Waveform](./waveforms/pwm_dt20_zoomIN.png) |