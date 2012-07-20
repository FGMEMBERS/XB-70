var reheat = func
{
var IAS = getprop("/velocities/airspeed-kt");
var mach = getprop("/velocities/mach");
var alt = getprop("/position/altitude-ft");
var t0=getprop("/controls/engines/engine[0]/throttle");
var t1=getprop("/controls/engines/engine[1]/throttle");
var t2=getprop("/controls/engines/engine[2]/throttle");
var t3=getprop("/controls/engines/engine[3]/throttle");
var t4=getprop("/controls/engines/engine[4]/throttle");
var t5=getprop("/controls/engines/engine[5]/throttle");
var spoilers = 0.25*(mach+1)*(1-((t0+t1)/2));
var a0=t0*t0;
var a1=t1*t1;
var a2=t2*t2;
var a3=t3*t3;
var a4=t4*t4;
var a5=t5*t5;
var fold=0;

if (getprop("/controls/gear/gear-down")) {spoilers = spoilers+0.1;}

if ((mach > 3.10) and (mach < 3.20))
{
a0 = a0*(1-(mach-3.10)/0.10);
a1 = a1*(1-(mach-3.10)/0.10);
a2 = a2*(1-(mach-3.10)/0.10);
a3 = a3*(1-(mach-3.10)/0.10);
a4 = a4*(1-(mach-3.10)/0.10);
a5 = a5*(1-(mach-3.10)/0.10);
spoilers = spoilers+(mach-3.10)/0.10;
}

if ((alt > 80000) and (alt < 85000))
{
a0 = a0*(1-(alt-80000)/5000);
a1 = a1*(1-(alt-80000)/5000);
a2 = a2*(1-(alt-80000)/5000);
a3 = a3*(1-(alt-80000)/5000);
a4 = a4*(1-(alt-80000)/5000);
a5 = a5*(1-(alt-80000)/5000);
spoilers = spoilers+(alt-80000)/5000;
}

if ((mach >= 3.20) or (alt >= 85000))
{
a0 = 0;
a1 = 0;
a2 = 0;
a3 = 0;
a4 = 0;
a5 = 0;
spoilers = 1;
}

if (IAS > 550) {spoilers = spoilers+(IAS-550)/100;}
if ((mach > 0.9) and (mach <= 1.0)) {spoilers = spoilers+0.3*(mach-0.9)/0.1;}
if ((mach > 1.0) and (mach < 1.15)) {spoilers = spoilers+0.3*(1.15-mach)/0.15;}
spoilers = spoilers+getprop("/controls/flight/speedbrake");
if (spoilers > 1) {spoilers = 1;}

if (mach > 0.85) {fold=0.4;}
if (mach > 2.0) {fold=1.0;}
if (mach < 1.9) {fold=0.4;}
if (mach < 0.75) {fold=0.0;}

setprop("/controls/engines/engine[0]/afterburner", a0);
setprop("/controls/engines/engine[1]/afterburner", a1);
setprop("/controls/engines/engine[2]/afterburner", a2);
setprop("/controls/engines/engine[3]/afterburner", a3);
setprop("/controls/engines/engine[4]/afterburner", a4);
setprop("/controls/engines/engine[5]/afterburner", a5);
setprop("/controls/flight/spoilers",spoilers);
setprop("/controls/flight/wing-sweep",fold);
settimer(reheat, 0.2);

}

setlistener("sim/signals/fdm-initialized",reheat);