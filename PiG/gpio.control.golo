module PiG.gpio.control

# adapted from http:#pi4j.com/example/control.html
# which is 
# Copyright (C) 2012 - 2013 Pi4J
# Licensed under the Apache License, Version 2.0 (the "License")
#
# Golo version by Thierry Chantier
# Copyright (C) 2013 PiG
# Licensed under the Apache License, Version 2.0 (the "License")

import com.pi4j.io.gpio.GpioController
import com.pi4j.io.gpio.GpioFactory
import com.pi4j.io.gpio.GpioPinDigitalOutput
import com.pi4j.io.gpio.PinState
import com.pi4j.io.gpio.RaspiPin

import java.lang.Thread

#
# This example code demonstrates how to perform simple state
# control of a GPIO pin on the Raspberry Pi.  
# 
# @author Robert Savage (original java version)
# @author Thierry Chantier (Golo-lang version)
#

function main = |args| {
        
        println("<--Pi4J--> GPIO Control Example ... started.")
        
        # create gpio controller
        let gpioInstance = GpioFactory.getInstance()

        # provision gpio pin #01 as an output pin and turn on
        let pin = gpioInstance: provisionDigitalOutputPin(RaspiPin.GPIO_01(), "MyLED", PinState.HIGH())
        println("--> GPIO state should be: ON")
        
        Thread.sleep(15000_L)
        
        # turn off gpio pin #01
        pin: low()
        println("--> GPIO state should be: OFF")

        Thread.sleep(1000_L)

        # toggle the current state of gpio pin #01 (should turn on)
        pin: toggle()
        println("--> GPIO state should be: ON")

        Thread.sleep(15000_L)

        # toggle the current state of gpio pin #01  (should turn off)
        pin: toggle()
        println("--> GPIO state should be: OFF")
        
        Thread.sleep(5000_L)

        # turn on gpio pin #01 for 1 second and then off
        println("--> GPIO state should be: ON for only 1 second")
        # set second argument to 'true' use a blocking call
        let duration = 1000_L
        pin: pulse(duration: longValue(), true) 
        
        # stop all GPIO activity/threads by shutting down the GPIO controller
        # (this method will forcefully shutdown all GPIO monitoring threads and scheduled tasks)
        gpioInstance: shutdown()
    }

