//-------------------------------------------------------------------------------
//
// LED Test
//
// Examples of using the LED functions in IO Widgets.
//
// Swift for Arduino (S4A)
// swiftforarduino.com
//
//	Created 27 Jan 2019
//	by Mark Swanson
//
//-------------------------------------------------------------------------------

import AVR

//-------------------------------------------------------------------------------
// Setup

// Declare some IO Widgets
let myLED = LED_setup(pin: 6)
let button = BUTTON_setup(pin: 2)
let piezo = PIEZO_setup(pin: 3)

// State tracking
var buttonWasProcessed = false

// Signal User that the Arduino is Ready
LED_blink(myLED, onTime: 100, offTime: 50, count: 2) 

//-------------------------------------------------------------------------------
func LEDTest() {
  
	// Turn LED on and off
	for _ in 1...3 {
		LED_on(myLED)
		delay(milliseconds: 500)
		LED_off(myLED)
		delay(milliseconds: 500)
	}
	delay(milliseconds: 1000)

	// Fade LED on and off
	for _ in 1...3 {
		LED_fadeOn(myLED, milliseconds: 1000)
		LED_fadeOff(myLED, milliseconds: 750)
		delay(milliseconds: 500)
	}
	delay(milliseconds: 1000)

	// Blink LED in SOS pattern
	let timeUnit: milliseconds = 100 // Increase to slow down overall SOS signal speed, decrease to make faster
	let dot: milliseconds = timeUnit 
	let dash: milliseconds = timeUnit &* 3 
	let symbolSpace: milliseconds = timeUnit
	let letterSpace: milliseconds = timeUnit &* 3
	let wordSpace: milliseconds = timeUnit &* 7

	for _ in 1...3 {
		LED_blink(myLED, onTime: dot, offTime: symbolSpace, count: 3)
		delay(milliseconds: letterSpace)

		LED_blink(myLED, onTime: dash, offTime: symbolSpace, count: 3)
		delay(milliseconds: letterSpace)

		LED_blink(myLED, onTime: dot, offTime: symbolSpace, count: 3)
		delay(milliseconds: wordSpace) 
	}
}

//-------------------------------------------------------------------------------
func buttonPiezoTest() {
  
	// Example "one-shot" button. Button press will initiate action once, and not again until the button is 	released i.e. action won't keep running while button is held down.
	if BUTTON_isPressed(button) {
  		if !buttonWasProcessed {
    
			// Prevent processing again until button is released
			buttonWasProcessed = true

			let shortDelay: milliseconds = 30
			let longDelay: milliseconds = 500

			// "Shave and a Haircut": C-G-G-A-G
			PIEZO_play(piezo, note: PIEZO_C, tenthsOfASecond: 2, postDelay: shortDelay)
			PIEZO_play(piezo, note: PIEZO_g, tenthsOfASecond: 1, postDelay: shortDelay)
			PIEZO_play(piezo, note: PIEZO_g, tenthsOfASecond: 1, postDelay: shortDelay)
			PIEZO_play(piezo, note: PIEZO_a, tenthsOfASecond: 2, postDelay: shortDelay)
			PIEZO_play(piezo, note: PIEZO_g, tenthsOfASecond: 2, postDelay: longDelay)

			// "Two Bits": B-C
			PIEZO_play(piezo, note: PIEZO_b, tenthsOfASecond: 2, postDelay: shortDelay)
			PIEZO_play(piezo, note: PIEZO_C, tenthsOfASecond: 2, postDelay: shortDelay)
		} 
	}
	else {
  		// Button released, allow processing presses
  		buttonWasProcessed = false  
	}
}

//-------------------------------------------------------------------------------
// Main

while(true) {

	// Test LED API
//	LEDTest()
//	delay(milliseconds: 2000)

	// Test BUTTON & PIEZO API
	buttonPiezoTest()
	delay(milliseconds: 32)

}

//-------------------------------------------------------------------------------