#include "blinking_led_core.h"

BlinkingLedCore::BlinkingLedCore(uint32_t base_addr) {
   this->base_addr = base_addr;
}

BlinkingLedCore::~BlinkingLedCore() {}

void BlinkingLedCore::set_interval_ms(int led_index, uint16_t interval_ms) {
   io_write(base_addr, led_index, interval_ms);
}