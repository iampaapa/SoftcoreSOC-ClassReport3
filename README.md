# FPro Blinking-LED MMIO Core

This project implements a custom hardware peripheral for the FPro System-on-a-Chip (SoC). The core controls four discrete LEDs with blinking intervals that are independently programmable by the MicroBlaze processor in real-time using the slide switches on the FPGA board.

**Demo Video:** [https://youtu.be/nSGeWkoQvVM](https://youtu.be/nSGeWkoQvVM)

## Hardware Requirements

  * **FPGA Board:** Digilent Nexys 4 DDR
  * **Software:** Xilinx Vivado & Vitis IDE (Version 2024.1 or later)

-----

## Build Instructions

Follow these steps to build the project from the source files.

### 1\. Hardware Build (Vivado)

First, we'll synthesize the hardware design and create a hardware definition file (`.xsa`).

1.  **Create Vivado Project**: Launch Vivado and create a new RTL Project named `blinking_led`. Do not specify sources at this time. When prompted, select the `xc7a100tcsg324-1` part.
2.  **Add HDL Sources**:
      * In the **Sources** window, right-click **Design Sources** and select **Add Sources**.
      * Add all SystemVerilog files from the `hdl/files_from_chu/` directory.
      * Add my custom core files: `hdl/blinker_unit.sv` and `hdl/blinking_led_core.sv`.
3.  **Add CPU Core**:
      * Go to **IP Catalog** and add the **MicroBlaze MCS** IP.
      * Name it `cpu`, set memory to **128KB**, and check **Enable IO Bus**. Generate the IP.
4.  **Add Constraints**:
      * Right-click **Constraints** and select **Add Sources...**.
      * Add the `Nexsys4DDR_chu.xdc` file from the `hdl/constraint/` directory.
5.  **Generate Bitstream**: In the **Flow Navigator**, click **Generate Bitstream**. Vivado will synthesize and implement the design.
6.  **Export Hardware**:
      * Go to **File → Export → Export Hardware**.
      * Ensure **Include bitstream** is checked.
      * Export the `.xsa` file to a known location (e.g., inside the `sw` folder).

-----

### 2\. Software Build (Vitis)

Next, we'll create the software application and driver to run on the processor.

1.  **Launch Vitis**: Open the Vitis IDE.
2.  **Create Platform Project**:
      * Go to **File → New → Platform Project...**.
      * Name the project (e.g., `blinking_led_platform`).
      * Select **Create from hardware specification (XSA)** and browse to the `.xsa` file you exported from Vivado.
      * Build the platform project by clicking the hammer icon.
3.  **Create Application Project**:
      * Go to **File → New → Application Project**.
      * Select your new platform (i.e., blinking_led_platform).
      * Name the project (e.g., `blinking_led_app`).
4.  **Import Source Files**:
      * Right-click the `src` folder in your new application project and select **Import Sources**.
      * Import all `.cpp` and `.h` files from the `sw/files_from_chu/` directory.
      * Import your custom driver files: `sw/blinking_led_core.cpp` and `sw/blinking_led_core.h`.
5.  **Build Application**: Click the hammer icon to compile the software. This will generate the final `.elf` file inside the `build` or `Debug` folder of your application project.

-----

## Running the Project

1.  **Connect Board**: Connect your Nexys 4 DDR board to your computer and power it on.
2.  **Program Device**: In Vitis, go to **Xilinx → Program Device**.
3.  **Configure and Program**:
      * The bitstream from your platform should be selected automatically.
      * For the ELF file, browse to and select the `.elf` file you just built.
      * Click **Program**.

The board will be programmed, and you should see the first four LEDs blinking.