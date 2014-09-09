var map = func{
# var IAS = getprop("/velocities/airspeed-kt");
# var mach = getprop("/velocities/mach");
# var fold = 0;

# if ((mach > 0.95) or (IAS > 400)) {fold=0.4;}
# if (mach > 1.4) {fold=1.0;}
# if (mach < 1.3) {fold=0.4;}
# if ((mach < 0.85) and (IAS < 380)) {fold=0.0;}

# setprop("/fdm/jsbsim/fcs/wing-fold-cmd-norm", fold);
# alternate for non-automated wing tips folding
setprop("/fdm/jsbsim/fcs/wing-fold-cmd-norm", (getprop("/controls/flight/wing-sweep")));

setprop("/position/gear-agl-m", (getprop("/position/altitude-agl-ft")/3.2808399));

settimer(map, 0.1);
}
setlistener("sim/signals/fdm-initialized",map);