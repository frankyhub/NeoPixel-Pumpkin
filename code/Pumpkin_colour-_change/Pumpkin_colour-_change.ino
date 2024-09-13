/*************************************************************************************************
                                      PROGRAMMINFO
**************************************************************************************************
Funktion: Pumpkin, Farbwechsel 8 LED-Ring NANO

**************************************************************************************************
Version: 12.09.2024
**************************************************************************************************
Board: NANO
**************************************************************************************************
Libraries:
https://github.com/espressif/arduino-esp32/tree/master/libraries
C:\Users\User\Documents\Arduino
D:\gittemp\Arduino II\A156_Wetterdaten_V3
**************************************************************************************************
C++ Arduino IDE V1.8.19
**************************************************************************************************
Einstellungen:
https://dl.espressif.com/dl/package_esp32_index.json
http://dan.drown.org/stm32duino/package_STM32duino_index.json
http://arduino.esp8266.com/stable/package_esp8266com_index.json
**************************************************************************************************/


#include <Adafruit_NeoPixel.h> // Die Adafruit NeoPixel Bibliothek wird verwendet um den LED-Ring anzusteuern
#ifdef __AVR__
#include <avr/power.h>
#endif

#define PIN 5 // Datenleitung an Pin 5
Adafruit_NeoPixel strip = Adafruit_NeoPixel(12, PIN, NEO_GRB + NEO_KHZ800); // In diesem Beispiel sind am LED Ring 8 Pixel.

void setup() {
  strip.begin();
  strip.show(); // Alle Pixel zu Beginn ausschalten
}

void loop() {
  for (int i = 0; i < strip.numPixels(); i++) {
    strip.setPixelColor(i, strip.Color(155, random(100,183), random(5))); // Die Pixel leuchten jeweils rot-orange in zufälligen Farben
  }

  strip.show();
  delay(random(100));
}
