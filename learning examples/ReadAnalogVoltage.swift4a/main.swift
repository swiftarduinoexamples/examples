import AVR

// Read Analog Voltage
// In a later version of the SDK this should output a formatted decimal
// for now, it will output the rough millivolts output, e.g. 4500 means 4.5 volts

// This is an approximation as Double -> Int seems to rely on Swift runtime that isn't implemented yet

SetupSerial(baudRate: 9600)

while(true) {
  let sensorValue: UInt16 = slowAnalogRead(pin: 0)
  let voltage: Float = Float(sensorValue) * (Float(5.0) / Float(1023.0))
  print(unsignedInt: sensorValue)
  print(float: voltage)
  delay(milliseconds: 300)
}



// one day we should write this instead:
//  print(double: voltage)
//
//  let milliVolts: UInt16 = sensorValue*2 //* 5
//  print(unsignedInt: milliVolts)
