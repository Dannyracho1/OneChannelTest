
?
Command: %s
53*	vivadotcl2
route_designZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
Implementation2
	xc7vx485tZ17-347h px� 
q
0Got license for feature '%s' and/or device '%s'
310*common2
Implementation2
	xc7vx485tZ17-349h px� 
^
,Running DRC as a precondition to command %s
22*	vivadotcl2
route_designZ4-22h px� 
>
Running DRC with %s threads
24*drc2
8Z23-27h px� 
D
DRC finished with %s
79*	vivadotcl2

0 ErrorsZ4-198h px� 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px� 
D

Starting %s Task
103*constraints2	
RoutingZ18-103h px� 
k
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
8Z35-254h px� 
L

Phase %s%s
101*constraints2
1 2
Build RT DesignZ18-101h px� 
I
%s*common20
.Phase 1 Build RT Design | Checksum: 2c2c3e4d3
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:58 ; elapsed = 00:00:38 . Memory (MB): peak = 3697.844 ; gain = 194.988 ; free physical = 422 ; free virtual = 9670h px� 
R

Phase %s%s
101*constraints2
2 2
Router InitializationZ18-101h px� 
W

Phase %s%s
101*constraints2
2.1 2
Fix Topology ConstraintsZ18-101h px� 
T
%s*common2;
9Phase 2.1 Fix Topology Constraints | Checksum: 2c2c3e4d3
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:58 ; elapsed = 00:00:38 . Memory (MB): peak = 3697.844 ; gain = 194.988 ; free physical = 425 ; free virtual = 9673h px� 
P

Phase %s%s
101*constraints2
2.2 2
Pre Route CleanupZ18-101h px� 
M
%s*common24
2Phase 2.2 Pre Route Cleanup | Checksum: 2c2c3e4d3
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:00:58 ; elapsed = 00:00:38 . Memory (MB): peak = 3697.844 ; gain = 194.988 ; free physical = 424 ; free virtual = 9672h px� 
L

Phase %s%s
101*constraints2
2.3 2
Update TimingZ18-101h px� 
I
%s*common20
.Phase 2.3 Update Timing | Checksum: 23d7b3cf0
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:03 ; elapsed = 00:00:40 . Memory (MB): peak = 3846.031 ; gain = 343.176 ; free physical = 262 ; free virtual = 9511h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-28.249| TNS=-1241.059| WHS=-1.552 | THS=-53.879|
Z35-416h px� 
O
%s*common26
4Phase 2 Router Initialization | Checksum: 28fad0e7f
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:06 ; elapsed = 00:00:41 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 255 ; free virtual = 9504h px� 
L

Phase %s%s
101*constraints2
3 2
Initial RoutingZ18-101h px� 
M

Phase %s%s
101*constraints2
3.1 2
Global RoutingZ18-101h px� 
J
%s*common21
/Phase 3.1 Global Routing | Checksum: 28fad0e7f
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:06 ; elapsed = 00:00:41 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 255 ; free virtual = 9504h px� 
R

Phase %s%s
101*constraints2
3.2 2
Initial Net RoutingZ18-101h px� 
O
%s*common26
4Phase 3.2 Initial Net Routing | Checksum: 224b32a0c
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:09 ; elapsed = 00:00:41 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 255 ; free virtual = 9504h px� 
I
%s*common20
.Phase 3 Initial Routing | Checksum: 224b32a0c
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:09 ; elapsed = 00:00:41 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 255 ; free virtual = 9504h px� 
�
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
72�
�The top 5 pins with tight setup and hold constraints:

+====================+===================+================================================+
| Launch Setup Clock | Launch Hold Clock | Pin                                            |
+====================+===================+================================================+
| SYSCLK_P           | SYSCLK_P          | adjustable_clock/clk_out_reg_lopt_replica_12/D |
| SYSCLK_P           | SYSCLK_P          | ODDR_DACData7[3]/CE                            |
| SYSCLK_P           | SYSCLK_P          | ODDR_DACData7[2]/CE                            |
| SYSCLK_P           | SYSCLK_P          | ODDR_DACData7[3]/D1                            |
| SYSCLK_P           | SYSCLK_P          | ODDR_DACData7[3]/D2                            |
+--------------------+-------------------+------------------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
Z35-580h px� 
O

Phase %s%s
101*constraints2
4 2
Rip-up And RerouteZ18-101h px� 
Q

Phase %s%s
101*constraints2
4.1 2
Global Iteration 0Z18-101h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-30.144| TNS=-1333.637| WHS=N/A    | THS=N/A    |
Z35-416h px� 
N
%s*common25
3Phase 4.1 Global Iteration 0 | Checksum: 1eb5184f5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:12 ; elapsed = 00:00:43 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 241 ; free virtual = 9492h px� 
Q

Phase %s%s
101*constraints2
4.2 2
Global Iteration 1Z18-101h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-29.992| TNS=-1327.850| WHS=N/A    | THS=N/A    |
Z35-416h px� 
N
%s*common25
3Phase 4.2 Global Iteration 1 | Checksum: 27ce639f4
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:13 ; elapsed = 00:00:44 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 262 ; free virtual = 9513h px� 
Q

Phase %s%s
101*constraints2
4.3 2
Global Iteration 2Z18-101h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-29.954| TNS=-1326.179| WHS=N/A    | THS=N/A    |
Z35-416h px� 
N
%s*common25
3Phase 4.3 Global Iteration 2 | Checksum: 2d500dfef
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:15 ; elapsed = 00:00:44 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 262 ; free virtual = 9514h px� 
L
%s*common23
1Phase 4 Rip-up And Reroute | Checksum: 2d500dfef
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:15 ; elapsed = 00:00:44 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 262 ; free virtual = 9514h px� 
X

Phase %s%s
101*constraints2
5 2
Delay and Skew OptimizationZ18-101h px� 
L

Phase %s%s
101*constraints2
5.1 2
Delay CleanUpZ18-101h px� 
N

Phase %s%s
101*constraints2
5.1.1 2
Update TimingZ18-101h px� 
K
%s*common22
0Phase 5.1.1 Update Timing | Checksum: 27400f9e3
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:15 ; elapsed = 00:00:45 . Memory (MB): peak = 3854.062 ; gain = 351.207 ; free physical = 262 ; free virtual = 9514h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-29.954| TNS=-1326.179| WHS=N/A    | THS=N/A    |
Z35-416h px� 
I
%s*common20
.Phase 5.1 Delay CleanUp | Checksum: 19eee375d
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 172 ; free virtual = 9037h px� 
V

Phase %s%s
101*constraints2
5.2 2
Clock Skew OptimizationZ18-101h px� 
S
%s*common2:
8Phase 5.2 Clock Skew Optimization | Checksum: 19eee375d
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 172 ; free virtual = 9037h px� 
U
%s*common2<
:Phase 5 Delay and Skew Optimization | Checksum: 19eee375d
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 172 ; free virtual = 9037h px� 
J

Phase %s%s
101*constraints2
6 2
Post Hold FixZ18-101h px� 
L

Phase %s%s
101*constraints2
6.1 2
Hold Fix IterZ18-101h px� 
N

Phase %s%s
101*constraints2
6.1.1 2
Update TimingZ18-101h px� 
K
%s*common22
0Phase 6.1.1 Update Timing | Checksum: 15eb044d5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 170 ; free virtual = 9035h px� 
{
Intermediate Timing Summary %s164*route2:
8| WNS=-29.929| TNS=-1312.981| WHS=0.081  | THS=0.000  |
Z35-416h px� 
I
%s*common20
.Phase 6.1 Hold Fix Iter | Checksum: 15eb044d5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 170 ; free virtual = 9035h px� 
G
%s*common2.
,Phase 6 Post Hold Fix | Checksum: 15eb044d5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:49 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 170 ; free virtual = 9035h px� 
K

Phase %s%s
101*constraints2
7 2
Route finalizeZ18-101h px� 
H
%s*common2/
-Phase 7 Route finalize | Checksum: 15eb044d5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9034h px� 
R

Phase %s%s
101*constraints2
8 2
Verifying routed netsZ18-101h px� 
O
%s*common26
4Phase 8 Verifying routed nets | Checksum: 15eb044d5
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9034h px� 
N

Phase %s%s
101*constraints2
9 2
Depositing RoutesZ18-101h px� 
K
%s*common22
0Phase 9 Depositing Routes | Checksum: 1640a3390
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9034h px� 
P

Phase %s%s
101*constraints2
10 2
Post Router TimingZ18-101h px� 
w
Estimated Timing Summary %s
57*route2:
8| WNS=-29.929| TNS=-1312.981| WHS=0.081  | THS=0.000  |
Z35-57h px� 
B
!Router estimated timing not met.
128*routeZ35-328h px� 
M
%s*common24
2Phase 10 Post Router Timing | Checksum: 1640a3390
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9034h px� 
@
Router Completed Successfully
2*	routeflowZ35-16h px� 
Y

Phase %s%s
101*constraints2
11 2
Post-Route Event ProcessingZ18-101h px� 
V
%s*common2=
;Phase 11 Post-Route Event Processing | Checksum: 230c5e0f1
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9033h px� 
E
%s*common2,
*Ending Routing Task | Checksum: 230c5e0f1
h px� 
�

%s
*constraints2�
�Time (s): cpu = 00:01:50 ; elapsed = 00:00:51 . Memory (MB): peak = 4328.062 ; gain = 825.207 ; free physical = 169 ; free virtual = 9033h px� 
H
Releasing license: %s
83*common2
ImplementationZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
4732
12
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
route_designZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
route_design: 2

00:01:522

00:00:522

4328.0622	
825.2072
1682
9033Z17-722h px� 

%s4*runtcl2c
aExecuting : report_drc -file main_drc_routed.rpt -pb main_drc_routed.pb -rpx main_drc_routed.rpx
h px� 
�
Command: %s
53*	vivadotcl2V
Treport_drc -file main_drc_routed.rpt -pb main_drc_routed.pb -rpx main_drc_routed.rpxZ4-113h px� 
>
IP Catalog is up to date.1232*coregenZ19-1839h px� 
>
Running DRC with %s threads
24*drc2
8Z23-27h px� 
�
#The results of DRC are in file %s.
586*	vivadotcl2�
c/home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.runs/impl_1/main_drc_routed.rptc/home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.runs/impl_1/main_drc_routed.rpt8Z2-168h px� 
J
%s completed successfully
29*	vivadotcl2

report_drcZ4-42h px� 
�
%s4*runtcl2�
�Executing : report_methodology -file main_methodology_drc_routed.rpt -pb main_methodology_drc_routed.pb -rpx main_methodology_drc_routed.rpx
h px� 
�
Command: %s
53*	vivadotcl2�
�report_methodology -file main_methodology_drc_routed.rpt -pb main_methodology_drc_routed.pb -rpx main_methodology_drc_routed.rpxZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
G
$Running Methodology with %s threads
74*drc2
8Z23-133h px� 
�
2The results of Report Methodology are in file %s.
609*	vivadotcl2�
o/home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.runs/impl_1/main_methodology_drc_routed.rpto/home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.runs/impl_1/main_methodology_drc_routed.rpt8Z2-1520h px� 
R
%s completed successfully
29*	vivadotcl2
report_methodologyZ4-42h px� 
�
%s4*runtcl2s
qExecuting : report_power -file main_power_routed.rpt -pb main_power_summary_routed.pb -rpx main_power_routed.rpx
h px� 
�
Command: %s
53*	vivadotcl2f
dreport_power -file main_power_routed.rpt -pb main_power_summary_routed.pb -rpx main_power_routed.rpxZ4-113h px� 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px� 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px� 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
4832
12
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
report_powerZ4-42h px� 
s
%s4*runtcl2W
UExecuting : report_route_status -file main_route_status.rpt -pb main_route_status.pb
h px� 
�
%s4*runtcl2�
�Executing : report_timing_summary -max_paths 10 -report_unconstrained -file main_timing_summary_routed.rpt -pb main_timing_summary_routed.pb -rpx main_timing_summary_routed.rpx -warn_on_violation 
h px� 
`
UpdateTimingParams:%s.
91*timing2'
% Speed grade: -2, Delay Type: min_maxZ38-91h px� 
j
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
8Z38-191h px� 
�
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2
timing summaryZ38-282h px� 
k
%s4*runtcl2O
MExecuting : report_incremental_reuse -file main_incremental_reuse_routed.rpt
h px� 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px� 
k
%s4*runtcl2O
MExecuting : report_clock_utilization -file main_clock_utilization_routed.rpt
h px� 
�
%s4*runtcl2�
�Executing : report_bus_skew -warn_on_violation -file main_bus_skew_routed.rpt -pb main_bus_skew_routed.pb -rpx main_bus_skew_routed.rpx
h px� 
`
UpdateTimingParams:%s.
91*timing2'
% Speed grade: -2, Delay Type: min_maxZ38-91h px� 
j
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
8Z38-191h px� 
H
&Writing timing data to binary archive.266*timingZ38-480h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write ShapeDB Complete: 2
00:00:00.012

00:00:002

4416.1052
0.0002
1792
9006Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote PlaceDB: 2
00:00:00.422
00:00:00.272

4416.1052
0.0002
1772
9006Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote PulsedLatchDB: 2

00:00:002

00:00:002

4416.1052
0.0002
1772
9006Z17-722h px� 
=
Writing XDEF routing.
211*designutilsZ20-211h px� 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px� 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote RouteStorage: 2
00:00:00.062
00:00:00.082

4416.1052
0.0002
1762
9007Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote Netlist Cache: 2

00:00:002

00:00:002

4416.1052
0.0002
1752
9006Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Wrote Device Cache: 2
00:00:00.022
00:00:00.062

4416.1052
0.0002
1732
9005Z17-722h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write Physdb Complete: 2
00:00:00.512
00:00:00.432

4416.1052
0.0002
1732
9005Z17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2a
_/home/dracho/Downloads/OneChannelTest/OneChannelTest/OneChannelTest.runs/impl_1/main_routed.dcpZ17-1381h px� 


End Record