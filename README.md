####BBB eqep and pwm
This is meant to help get the eQEPs and PWM working on a BBB running the 3.14 Kernel
I have only tested this for eQEP2b and PWM on pin P8_19. This should help get you started if you want more enabled.

I was using kernel 3.14.33-ti-r51

##Some useful websites:
https://www.mail-archive.com/beagleboard@googlegroups.com/msg19244.html 
https://github.com/SaadAhmad/beaglebone-black-cpp-PWM
http://dumb-looks-free.blogspot.fr/2014/06/beaglebone-black-bbb-kernal-headers.html
https://github.com/RobertCNelson/dtb-rebuilder
https://github.com/Teknoman117/beaglebot
https://github.com/cdsteinkuehler/beaglebone-universal-io.git
https://github.com/yigityuce/BlackLib

###Setup User
modify /etc/sudoers
  <username> ALL=(ALL) NOPASSWD:ALL

<<<<<<< HEAD
###Setup option 1
If you want to get things working on your own or do not have a similiar setup using eqep2b and pwm on pin p8_19 then use the steps below to understand and change the files necessary.

If you are using pwm on p8_19 and eqep2b and a beaglebone black you can use the script to get do the necessary steps.
first
  sudo ./setup_device_tree.sh
then
  sudo ./setup_drivers.sh

Then after every reboot run
  sudo ./start_drivers.sh

###Setup option 2
First download the dtb-rebuilder:
  git clone https://github.com/RobertCNelson/dtb-rebuilder
  git checkout 3.14-ti

The next step is to identify the eqep's you want to use and the pwm you want to use
To do this modify the am335x-bone-robot.dtsi file. It is currently setup for eqep2b and pwm on pin P8_19. 
  sudo nano device_tree_files/am335x-bone-robot.dtsi

copy the device tree files into it
  cp -r device_tree_files/ dtb-rebuilder/src/arm
  cd dtb-rebuilder
  sudo make
  sudo make install

next is to change the dtb file loaded on boot
  sudo nano /boot/uEnv.txt

change the line that says 
  dtb=
to
  dtb=am335x-boneblack-cape-bone-robot.dtb

reboot the BBB now
  sudo reboot -h

Download your kernel source files.
This can be down by running the following commands
  chmod +x bb-get-rcn-kernel-source.sh
  sudo ./bb-get-rcn-kernel-source.sh

Next build the drivers:
  cd eqep_driver
  make
  sudo insmod tieqep.ko
  cd ../pwm_driver
  make
  sudo insmod pwm_test.ko

Now to test the functions:
These tests use libraries from the following github repos
https://github.com/Teknoman117/beaglebot
https://github.com/yigityuce/BlackLib
  cd test/
  sudo make testPWM
  sudo make testEncoders

Then run the programs
The encoder test will let you see the current position of the encoders printed to the screen
it is set up to read from eqep2b which is only available on BBB
  sudo ./testEncoders 0 <location of eqep>
the pwm test will output a 50 percent duty cycle on P8_19
  sudo ./testPWM

There is also a test GPIO
  sudo make testGPIO
  sudo ./testGPIO
it will toggle the GPIO pin 51 ten times.

To change the GPIO pin, the PWM pin or the eqep, the source code located in the src folder will have to be modified.

### License
For full terms and conditions, see the [LICENSE](LICENSE) file.

### Authors
See the [AUTHORS](AUTHORS.md) file for a full list of contributors

  

