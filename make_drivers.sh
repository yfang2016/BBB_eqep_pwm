cd drivers/eqep_driver
make
insmod tieqep.ko
cd ../pwm_driver
make
insmod pwm.ko

