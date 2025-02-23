# brewery-in-vhdl
A small project written in VHDL simulating how processes inside brewery look like, I divided them into 6 states (transit,nowork,cleaning, capping, packaging, brewing)

I used Xilinx ISE 14.7 for implementing and simulating but it's probably also possible with any web VHDL testbench.

In the architecture I used 4 internal signals in which beer_level and storage_room can get refilled as long as cash is not equal to 0.

The correct order of operations I envisioned is:

1.nowork

2.transit

3.cleaning

4.brewing

5.capping

6.packaging

Everytime state machine enters packaging state the progress which is the output signal turns high.

The simulation should look similar to this
![image](https://github.com/user-attachments/assets/a3919af9-fcd7-41a0-af7f-56a5470805e7)


