module PiG.gpio.LcdSimple

# inspired by https://github.com/Pi4J/pi4j/blob/master/pi4j-example/src/main/java/LcdExample.java
# which is
# Copyright (C) 2012 - 2013 Pi4J
# Licensed under the Apache License, Version 2.0 (the "License")
#
# Golo version by Thierry Chantier
# Copyright (C) 2013 PiG
# Licensed under the Apache License, Version 2.0 (the "License")

import java.text.SimpleDateFormat
import java.util.Date
import java.lang.Thread

import com.pi4j.component.lcd.LCDTextAlignment
import com.pi4j.component.lcd.impl.GpioLcdDisplay
import com.pi4j.io.gpio.GpioController
import com.pi4j.io.gpio.GpioFactory
import com.pi4j.io.gpio.GpioPinDigitalInput
import com.pi4j.io.gpio.PinPullResistance
import com.pi4j.io.gpio.PinState
import com.pi4j.io.gpio.RaspiPin
import com.pi4j.io.gpio.event.GpioPinDigitalStateChangeEvent
import com.pi4j.io.gpio.event.GpioPinListenerDigital

function main = |args| {

    let LCD_ROWS = 2
    let LCD_ROW_1 = 0
    let LCD_ROW_2 = 1
    let LCD_COLUMNS = 16
        
    println("<--Pi4J--> GPIO 4 bit LCD example program")

    # create gpio controller
    let gpioInstance = GpioFactory.getInstance()

    # initialize LCD
    let lcd = GpioLcdDisplay(LCD_ROWS, # number of row supported by LCD
                            LCD_COLUMNS,       # number of columns supported by LCD
                            RaspiPin.GPIO_11(),  # LCD RS pin 
                            RaspiPin.GPIO_10(),  # LCD strobe pin
                            RaspiPin.GPIO_06(),  # LCD data bit 1
                            RaspiPin.GPIO_05(),  # LCD data bit 2
                            RaspiPin.GPIO_04(),  # LCD data bit 3
                            RaspiPin.GPIO_01())  # LCD data bit 4
    
    # clear LCD
    lcd:clear()
    Thread.sleep(1000_L)
    
    # write line 1 to LCD
    lcd:write(LCD_ROW_1, "PiG is great!")
    
    # stop all GPIO activity/threads by shutting down the GPIO controller
    # (this method will forcefully shutdown all GPIO monitoring threads and scheduled tasks)
    gpioInstance: shutdown()
}