
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2$
create_project: 2default:default2
00:00:072default:default2
00:00:072default:default2
466.8092default:default2
156.6452default:defaultZ17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/utils_1/imports/synth_1/main.dcp2default:defaultZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2�
lC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/utils_1/imports/synth_1/main.dcp2default:defaultZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
t
Command: %s
53*	vivadotcl2C
/synth_design -top main -part xc7vx690tffg1761-22default:defaultZ4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2default:default2
	xc7vx690t2default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2default:default2
	xc7vx690t2default:defaultZ17-349h px� 
Y
Loading part %s157*device2&
xc7vx690tffg1761-22default:defaultZ21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
�
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
22default:defaultZ8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
`
#Helper process launched with PID %s4824*oasys2
155242default:defaultZ8-7075h px� 
�
%s*synth2�
yStarting RTL Elaboration : Time (s): cpu = 00:00:06 ; elapsed = 00:00:06 . Memory (MB): peak = 1504.863 ; gain = 411.152
2default:defaulth px� 
�
synthesizing module '%s'%s4497*oasys2
main2default:default2
 2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
212default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
IBUFGDS2default:default2
 2default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
722662default:default8@Z8-6157h px� 
a
%s
*synth2I
5	Parameter DIFF_TERM bound to: FALSE - type: string 
2default:defaulth p
x
� 
c
%s
*synth2K
7	Parameter IBUF_LOW_PWR bound to: TRUE - type: string 
2default:defaulth p
x
� 
d
%s
*synth2L
8	Parameter IOSTANDARD bound to: DEFAULT - type: string 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IBUFGDS2default:default2
 2default:default2
02default:default2
12default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
722662default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OBUF2default:default2
 2default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
911212default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OBUF2default:default2
 2default:default2
02default:default2
12default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
911212default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OBUFDS2default:default2
 2default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
911352default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OBUFDS2default:default2
 2default:default2
02default:default2
12default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
911352default:default8@Z8-6155h px� 
�
Fall outputs are unconnected for this instance and logic may be removed3605*oasys2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
4692default:default8@Z8-4446h px� 
�
synthesizing module '%s'%s4497*oasys2

IDELAYCTRL2default:default2
 2default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
738642default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2

IDELAYCTRL2default:default2
 2default:default2
02default:default2
12default:default2K
5C:/Xilinx/Vivado/2023.1/scripts/rt/data/unisim_comp.v2default:default2
738642default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
RDY2default:default2

IDELAYCTRL2default:default2'
IDELAYCTRL_instance2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
4692default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2'
IDELAYCTRL_instance2default:default2

IDELAYCTRL2default:default2
32default:default2
22default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
4692default:default8@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_rcv2default:default2
 2default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_rcv.v2default:default2
212default:default8@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_rcv.v2default:default2
922default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_rcv2default:default2
 2default:default2
02default:default2
12default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_rcv.v2default:default2
212default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
uart_trx2default:default2
 2default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_trx.v2default:default2
212default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
clkDiv2default:default2
 2default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_trx.v2default:default2
952default:default8@Z8-6157h px� 
^
%s
*synth2F
2	Parameter COUNTTO bound to: 200 - type: integer 
2default:defaulth p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
clkDiv2default:default2
 2default:default2
02default:default2
12default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_trx.v2default:default2
952default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart_trx2default:default2
 2default:default2
02default:default2
12default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/uart_trx.v2default:default2
212default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
crc2default:default2
 2default:default2u
_C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/crc.v2default:default2
212default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
crc2default:default2
 2default:default2
02default:default2
12default:default2u
_C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/crc.v2default:default2
212default:default8@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
realSPI2default:default2
 2default:default2y
cC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/realSPI.v2default:default2
212default:default8@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2y
cC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/realSPI.v2default:default2
812default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
realSPI2default:default2
 2default:default2
02default:default2
12default:default2y
cC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/realSPI.v2default:default2
212default:default8@Z8-6155h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
I_MUXout2default:default2
realSPI2default:default2
	spiModule2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
5182default:default8@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2

O_doneFlag2default:default2
realSPI2default:default2
	spiModule2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
5182default:default8@Z8-7071h px� 
�
9port '%s' of module '%s' is unconnected for instance '%s'4818*oasys2
O_data2default:default2
realSPI2default:default2
	spiModule2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
5182default:default8@Z8-7071h px� 
�
Kinstance '%s' of module '%s' has %s connections declared, but only %s given4757*oasys2
	spiModule2default:default2
realSPI2default:default2
122default:default2
92default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
5182default:default8@Z8-7023h px� 
�
synthesizing module '%s'%s4497*oasys2!
pll_sync_rqst2default:default2
 2default:default2
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/pll_sync_rqst.v2default:default2
262default:default8@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
pll_sync2default:default2
 2default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/pll_sync.v2default:default2
212default:default8@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pll_sync2default:default2
 2default:default2
02default:default2
12default:default2z
dC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/pll_sync.v2default:default2
212default:default8@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2!
pll_sync_rqst2default:default2
 2default:default2
02default:default2
12default:default2
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/pll_sync_rqst.v2default:default2
262default:default8@Z8-6155h px� 
�
-case statement is not full and has no default155*oasys2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6782default:default8@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
7362default:default8@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6732default:default8@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
main2default:default2
 2default:default2
02default:default2
12default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
212default:default8@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2"
r_dataRead_reg2default:default2y
cC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/realSPI.v2default:default2
1252default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2'
r_syncRequested_reg2default:default2
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/pll_sync_rqst.v2default:default2
652default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2 
r_dacSet_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6122default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2#
r_dac_I_lsb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6132default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2#
r_dac_I_msb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6142default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2#
r_dac_Q_lsb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6152default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2#
r_dac_Q_msb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6162default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2"
r_dacCLOCK_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6172default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2"
r_spiRXMSB_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6222default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2"
r_spiRXLSB_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6232default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2+
r_dacDataLength_lsb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6242default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2+
r_dacDataLength_msb_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6252default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2&
r_dacWRTConfig_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6262default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2'
r_dacActiveCore_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6272default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2!
r_dacMode_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6292default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK1_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6312default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK2_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6322default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK3_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6332default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK4_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6342default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK5_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6352default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK6_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6362default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK7_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6372default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2)
r_delayValue_CLK8_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6382default:default8@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2%
r_BB_Settings_reg2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
6392default:default8@Z8-6014h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_22default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1162default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_32default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1172default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_42default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1182default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_52default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1192default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_62default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1202default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_72default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1212default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
w_DACData_82default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1222default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

w_DACWRTIQ2default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1112default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

w_DACSELIQ2default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1122default:default8@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2 
w_DACRESETIQ2default:default2
main2default:default2v
`C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/sources_1/new/main.v2default:default2
1132default:default8@Z8-3848h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[7]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[6]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[5]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[4]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[3]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[2]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[1]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2*
I_PLLSyncPulseShift[0]2default:default2!
pll_sync_rqst2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
I_MUXout2default:default2
realSPI2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
DIP_SW02default:default2
main2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
SPI_MISO2default:default2
main2default:defaultZ8-7129h px� 
�
%s*synth2�
yFinished RTL Elaboration : Time (s): cpu = 00:00:08 ; elapsed = 00:00:08 . Memory (MB): peak = 1607.512 ; gain = 513.801
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 1607.512 ; gain = 513.801
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:08 ; elapsed = 00:00:09 . Memory (MB): peak = 1607.512 ; gain = 513.801
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0232default:default2
1607.5122default:default2
0.0002default:defaultZ17-268h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
332default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
Parsing XDC File [%s]
179*designutils2
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/constrs_1/new/constraints.xdc2default:default8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/constrs_1/new/constraints.xdc2default:default8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2}
iC:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.srcs/constrs_1/new/constraints.xdc2default:default2*
.Xil/main_propImpl.xdc2default:defaultZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0042default:default2
1709.9922default:default2
0.0002default:defaultZ17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2�
n  A total of 33 instances were transformed.
  IBUFGDS => IBUFDS: 1 instance 
  OBUFDS => OBUFDS: 32 instances
2default:defaultZ1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common24
 Constraint Validation Runtime : 2default:default2
00:00:002default:default2 
00:00:00.0082default:default2
1709.9922default:default2
0.0002default:defaultZ17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
V
%s
*synth2>
*Start Loading Part and Timing Information
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Loading part: xc7vx690tffg1761-2
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Z
%s
*synth2B
.Start Applying 'set_property' XDC Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:21 ; elapsed = 00:00:22 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
r_state_reg2default:default2
uart_rcv2default:defaultZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2

r_case_reg2default:default2
crc2default:defaultZ8-802h px� 
�
iRegister %s driving address of a ROM cannot be packed in BRAM/URAM because of presence of initial value.
4359*oasys2 
r_adress_reg2default:defaultZ8-6040h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
r_state_reg2default:default2
realSPI2default:defaultZ8-802h px� 
�
3inferred FSM for state register '%s' in module '%s'802*oasys2
r_state_reg2default:default2
main2default:defaultZ8-802h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                             0000 |                             0000
2default:defaulth p
x
� 
�
%s
*synth2s
_              CHECKSTART |                             0001 |                             0001
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT0 |                             0010 |                             0010
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT1 |                             0011 |                             0011
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT2 |                             0100 |                             0100
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT3 |                             0101 |                             0101
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT4 |                             0110 |                             0110
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT5 |                             0111 |                             0111
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT6 |                             1000 |                             1000
2default:defaulth p
x
� 
�
%s
*synth2s
_                    BIT7 |                             1001 |                             1001
2default:defaulth p
x
� 
�
%s
*synth2s
_                    STOP |                             1010 |                             1010
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
r_state_reg2default:default2

sequential2default:default2
uart_rcv2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                             0001 |                               00
2default:defaulth p
x
� 
�
%s
*synth2s
_                     XOR |                             0010 |                               01
2default:defaulth p
x
� 
�
%s
*synth2s
_                     LUT |                             0100 |                               10
2default:defaulth p
x
� 
�
%s
*synth2s
_                     END |                             1000 |                               11
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2

r_case_reg2default:default2
one-hot2default:default2
crc2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                               00 |                             0000
2default:defaulth p
x
� 
�
%s
*synth2s
_                SENDADDR |                               01 |                             0011
2default:defaulth p
x
� 
�
%s
*synth2s
_                 READREG |                               10 |                             0001
2default:defaulth p
x
� 
�
%s
*synth2s
_                  WRTREG |                               11 |                             0010
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
r_state_reg2default:default2

sequential2default:default2
realSPI2default:defaultZ8-3354h px� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2t
`                   State |                     New Encoding |                Previous Encoding 
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2s
_                    IDLE |                              000 |                             0000
2default:defaulth p
x
� 
�
%s
*synth2s
_                 REGADDR |                              001 |                             0010
2default:defaulth p
x
� 
�
%s
*synth2s
_                  REGVAL |                              010 |                             0011
2default:defaulth p
x
� 
�
%s
*synth2s
_                  WRTREG |                              011 |                             0101
2default:defaulth p
x
� 
�
%s
*synth2s
_                     RST |                              100 |                             0110
2default:defaulth p
x
� 
�
%s
*synth2x
d---------------------------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
r_state_reg2default:default2

sequential2default:default2
main2default:defaultZ8-3354h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:23 ; elapsed = 00:00:24 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Detailed RTL Component Info : 
2default:defaulth p
x
� 
:
%s
*synth2"
+---Adders : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   16 Bit       Adders := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   14 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    8 Bit       Adders := 3     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    7 Bit       Adders := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    3 Bit       Adders := 1     
2default:defaulth p
x
� 
8
%s
*synth2 
+---XORs : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	   2 Input      8 Bit         XORs := 1     
2default:defaulth p
x
� 
=
%s
*synth2%
+---Registers : 
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               32 Bit    Registers := 2     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               16 Bit    Registers := 4     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	               14 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                8 Bit    Registers := 22    
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                7 Bit    Registers := 1     
2default:defaulth p
x
� 
Z
%s
*synth2B
.	                1 Bit    Registers := 26    
2default:defaulth p
x
� 
9
%s
*synth2!
+---Muxes : 
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   16 Bit        Muxes := 7     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  11 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input   16 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input   14 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  11 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    8 Bit        Muxes := 16    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    8 Bit        Muxes := 4     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  32 Input    8 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   3 Input    8 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    8 Bit        Muxes := 12    
2default:defaulth p
x
� 
X
%s
*synth2@
,	  32 Input    7 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    7 Bit        Muxes := 2     
2default:defaulth p
x
� 
X
%s
*synth2@
,	  11 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    4 Bit        Muxes := 12    
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    4 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    3 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    2 Bit        Muxes := 1     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   2 Input    1 Bit        Muxes := 64    
2default:defaulth p
x
� 
X
%s
*synth2@
,	  11 Input    1 Bit        Muxes := 5     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   4 Input    1 Bit        Muxes := 15    
2default:defaulth p
x
� 
X
%s
*synth2@
,	  32 Input    1 Bit        Muxes := 6     
2default:defaulth p
x
� 
X
%s
*synth2@
,	   5 Input    1 Bit        Muxes := 11    
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Finished RTL Component Statistics 
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s
*synth2p
\Part Resources:
DSPs: 3600 (col length:200)
BRAMs: 2940 (col length: RAMB18 200 RAMB36 100)
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Part Resource Summary
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
W
%s
*synth2?
+Start Cross Boundary and Area Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
�
iRegister %s driving address of a ROM cannot be packed in BRAM/URAM because of presence of initial value.
4359*oasys2 
r_adress_reg2default:defaultZ8-6040h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
I_MUXout2default:default2
realSPI2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
DIP_SW02default:default2
main2default:defaultZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
SPI_MISO2default:default2
main2default:defaultZ8-7129h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys20
crc/FSM_onehot_r_case_reg[3]2default:default2
main2default:defaultZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys20
crc/FSM_onehot_r_case_reg[2]2default:default2
main2default:defaultZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys20
crc/FSM_onehot_r_case_reg[1]2default:default2
main2default:defaultZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys20
crc/FSM_onehot_r_case_reg[0]2default:default2
main2default:defaultZ8-3332h px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:28 ; elapsed = 00:00:29 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Start ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
M
%s*synth25
!
ROM: Preliminary Mapping Report
2default:defaulth px� 
i
%s*synth2Q
=+------------+------------+---------------+----------------+
2default:defaulth px� 
j
%s*synth2R
>|Module Name | RTL Object | Depth x Width | Implemented As | 
2default:defaulth px� 
i
%s*synth2Q
=+------------+------------+---------------+----------------+
2default:defaulth px� 
j
%s*synth2R
>|crc         | r_crc      | 256x8         | LUT            | 
2default:defaulth px� 
j
%s*synth2R
>|crc         | r_crc      | 256x8         | LUT            | 
2default:defaulth px� 
j
%s*synth2R
>+------------+------------+---------------+----------------+

2default:defaulth px� 
�
%s*synth2�
�---------------------------------------------------------------------------------
Finished ROM, RAM, DSP, Shift Register and Retiming Reporting
2default:defaulth px� 
~
%s*synth2f
R---------------------------------------------------------------------------------
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
R
%s
*synth2:
&Start Applying XDC Timing Constraints
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:34 ; elapsed = 00:00:35 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
F
%s
*synth2.
Start Timing Optimization
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
}Finished Timing Optimization : Time (s): cpu = 00:00:35 ; elapsed = 00:00:37 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
E
%s
*synth2-
Start Technology Mapping
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
|Finished Technology Mapping : Time (s): cpu = 00:00:36 ; elapsed = 00:00:37 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
?
%s
*synth2'
Start IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
Q
%s
*synth29
%Start Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
T
%s
*synth2<
(Finished Flattening Before IO Insertion
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
H
%s
*synth20
Start Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Finished Final Netlist Cleanup
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
vFinished IO Insertion : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
O
%s
*synth27
#Start Renaming Generated Instances
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
L
%s
*synth24
 Start Rebuilding User Hierarchy
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Renaming Generated Ports
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
M
%s
*synth25
!Start Handling Custom Attributes
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
J
%s
*synth22
Start Renaming Generated Nets
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
K
%s
*synth23
Start Writing Synthesis Report
2default:defaulth p
x
� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
A
%s
*synth2)

Report BlackBoxes: 
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
| |BlackBox name |Instances |
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
J
%s
*synth22
+-+--------------+----------+
2default:defaulth p
x
� 
A
%s*synth2)

Report Cell Usage: 
2default:defaulth px� 
H
%s*synth20
+------+-----------+------+
2default:defaulth px� 
H
%s*synth20
|      |Cell       |Count |
2default:defaulth px� 
H
%s*synth20
+------+-----------+------+
2default:defaulth px� 
H
%s*synth20
|1     |BUFG       |     1|
2default:defaulth px� 
H
%s*synth20
|2     |CARRY4     |    18|
2default:defaulth px� 
H
%s*synth20
|3     |IDELAYCTRL |     1|
2default:defaulth px� 
H
%s*synth20
|4     |LUT1       |    54|
2default:defaulth px� 
H
%s*synth20
|5     |LUT2       |    24|
2default:defaulth px� 
H
%s*synth20
|6     |LUT3       |    48|
2default:defaulth px� 
H
%s*synth20
|7     |LUT4       |    46|
2default:defaulth px� 
H
%s*synth20
|8     |LUT5       |    56|
2default:defaulth px� 
H
%s*synth20
|9     |LUT6       |    81|
2default:defaulth px� 
H
%s*synth20
|10    |MUXF7      |     2|
2default:defaulth px� 
H
%s*synth20
|11    |FDCE       |    15|
2default:defaulth px� 
H
%s*synth20
|12    |FDRE       |   185|
2default:defaulth px� 
H
%s*synth20
|13    |FDSE       |    25|
2default:defaulth px� 
H
%s*synth20
|14    |IBUF       |     1|
2default:defaulth px� 
H
%s*synth20
|15    |IBUFGDS    |     1|
2default:defaulth px� 
H
%s*synth20
|16    |OBUF       |    92|
2default:defaulth px� 
H
%s*synth20
|17    |OBUFDS     |    32|
2default:defaulth px� 
H
%s*synth20
+------+-----------+------+
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:40 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth px� 
~
%s
*synth2f
R---------------------------------------------------------------------------------
2default:defaulth p
x
� 
s
%s
*synth2[
GSynthesis finished with 0 errors, 0 critical warnings and 10 warnings.
2default:defaulth p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:28 ; elapsed = 00:00:36 . Memory (MB): peak = 1709.992 ; gain = 513.801
2default:defaulth p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:41 ; elapsed = 00:00:42 . Memory (MB): peak = 1709.992 ; gain = 616.281
2default:defaulth p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0112default:default2
1709.9922default:default2
0.0002default:defaultZ17-268h px� 
f
-Analyzing %s Unisim elements for replacement
17*netlist2
532default:defaultZ29-17h px� 
j
2Unisim Transformation completed in %s CPU seconds
28*netlist2
02default:defaultZ29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
u
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02default:default2
02default:defaultZ31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0012default:default2
1709.9922default:default2
0.0002default:defaultZ17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2�
�  A total of 33 instances were transformed.
  IBUFGDS => IBUFDS: 1 instance 
  OBUFDS => OBUFDS_DUAL_BUF (INV, OBUFDS(x2)): 32 instances
2default:defaultZ1-111h px� 
h
%Synth Design complete | Checksum: %s
562*	vivadotcl2
b06e4d482default:defaultZ4-1430h px� 
U
Releasing license: %s
83*common2
	Synthesis2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
602default:default2
622default:default2
02default:default2
02default:defaultZ4-41h px� 
^
%s completed successfully
29*	vivadotcl2 
synth_design2default:defaultZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
synth_design: 2default:default2
00:00:502default:default2
00:00:552default:default2
1709.9922default:default2
1219.0742default:defaultZ17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2p
\C:/Users/dracho/Vivado_Test_Projects/OldSetup_PLLTest/OldSetup_PLLTest.runs/synth_1/main.dcp2default:defaultZ17-1381h px� 
�
%s4*runtcl2r
^Executing : report_utilization -file main_utilization_synth.rpt -pb main_utilization_synth.pb
2default:defaulth px� 
�
Exiting %s at %s...
206*common2
Vivado2default:default2,
Thu Oct 26 14:42:37 20232default:defaultZ17-206h px� 


End Record