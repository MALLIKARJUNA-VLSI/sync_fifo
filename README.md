# 16x8 Synchronous FIFO

**Description:**
RTL implementation of a 16-depth by 8-bit width Synchronous FIFO buffer written in Verilog. The architecture utilizes a 2D circular register array (`fifo_mem`), 4-bit read/write pointers (`rd_ptr`, `wr_ptr`), and a 5-bit occupancy counter (`count`) to manage simultaneous read/write operations and prevent overflow/underflow hazards.

**Key Features:**
* **Active-Low Asynchronous Reset (`rst_n`):** Immediately clears pointers, output registers, and occupancy count.
* **Pointer & Flag Logic:** Combinational `full` (`count == 16`) and `empty` (`count == 0`) flags prevent data corruption on boundary conditions.
* **Self-Checking Verification (`sync_fifo_tb.v`):** Verified using Icarus Verilog across full-write burst (16 bytes) and full-read drain sequences.

**Waveform Simulation:**

<img width="1920" height="1080" alt="Screenshot 2026-10-15 013050" src="https://github.com/user-attachments/assets/a00b460b-9386-4c4d-8d52-4c298b808176" />
