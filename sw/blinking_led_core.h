#ifndef _BLINKING_LED_CORE_H_INCLUDED
#define _BLINKING_LED_CORE_H_INCLUDED

#include "chu_io_rw.h"

/**
 * Blinking LED core driver class.
 */
class BlinkingLedCore {
public:
   /**
    * Constructor to initialize the core with its base address.
    */
   BlinkingLedCore(uint32_t base_addr);
   ~BlinkingLedCore();

   /**
    * Set the blinking interval for a specific LED.
    * @param led_index The LED to configure (0 to 3).
    * @param interval_ms The blinking interval in milliseconds.
    */
   void set_interval_ms(int led_index, uint16_t interval_ms);

private:
   uint32_t base_addr;
};

#endif // _BLINKING_LED_CORE_H_INCLUDED