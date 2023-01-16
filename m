Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC57266C410
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjAPPgP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:36:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjAPPfr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:35:47 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF8E23C65;
        Mon, 16 Jan 2023 07:33:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673883197; x=1705419197;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vuM2o8EoTj0+tC7xtEFdb7dShaM3+zGd8IxH49WmkOo=;
  b=T9z0Uhl4Tzj8+33Uxy9iEvzEILNYHYa/ZXcEJXEuXVZUnVgmjCPsOcrw
   4e9lVSQPBw2LzMx0p5y8GHc/ZMbSK87oRgreEA+lvXJtTA0rUrgtNND6T
   V3F8+YhhNdUZ+WvfMcT45yMuadlscp9N/ogd3bYkRBmgIMk/59LG6d/RY
   Z0tSUBOEWrIFHhPx6Jzf5eEb2hXtMvIGbe1WLFOm8zeagmo5doVJTGqv/
   EAtV0B00HlkVuqYtc18r8DUcTqbAW9huQztrtzxM7CHeQQ1U8vs7Ky/rr
   9r5JdOGS7iBPFVLhENyE25Bkyeg85Tmeq75f3wQ4DCRqnC0KKCXfDT6TW
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410734109"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="410734109"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 07:33:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="747761984"
X-IronPort-AV: E=Sophos;i="5.97,221,1669104000"; 
   d="scan'208";a="747761984"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2023 07:33:14 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 21F4CE1; Mon, 16 Jan 2023 17:33:49 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH v2 2/2] pinctrl: Proofreading and updating the documentation (part 2)
Date:   Mon, 16 Jan 2023 17:33:47 +0200
Message-Id: <20230116153347.15786-2-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
References: <20230116153347.15786-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bagas Sanjaya <bagasdotme@gmail.com>

Do the following:
- update the "Definitions" style in two sections
- don't use "I" for technical documentation
- inline the remaining (variables, function names, file paths)

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: new change based on proposal by Bagas
 Documentation/driver-api/pin-control.rst | 112 +++++++++++------------
 1 file changed, 55 insertions(+), 57 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 22a82ee23a41..0019f763e9b2 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -17,14 +17,12 @@ This subsystem deals with:
 Top-level interface
 ===================
 
-Definition of PIN CONTROLLER:
+Definitions:
 
-- A pin controller is a piece of hardware, usually a set of registers, that
+- A PIN CONTROLLER is a piece of hardware, usually a set of registers, that
   can control PINs. It may be able to multiplex, bias, set load capacitance,
   set drive strength, etc. for individual pins or groups of pins.
 
-Definition of PIN:
-
 - PINS are equal to pads, fingers, balls or whatever packaging input or
   output line you want to control and these are denoted by unsigned integers
   in the range 0..maxpin. This numberspace is local to each PIN CONTROLLER, so
@@ -96,20 +94,20 @@ this in our driver:
 To enable the pinctrl subsystem and the subgroups for PINMUX and PINCONF and
 selected drivers, you need to select them from your machine's Kconfig entry,
 since these are so tightly integrated with the machines they are used on.
-See arch/arm/mach-ux500/Kconfig for an example.
+See ``arch/arm/mach-ux500/Kconfig`` for an example.
 
 Pins usually have fancier names than this. You can find these in the datasheet
 for your chip. Notice that the core pinctrl.h file provides a fancy macro
-called PINCTRL_PIN() to create the struct entries. As you can see I enumerated
-the pins from 0 in the upper left corner to 63 in the lower right corner.
+called ``PINCTRL_PIN()`` to create the struct entries. As you can see the pins are
+enumerated from 0 in the upper left corner to 63 in the lower right corner.
 This enumeration was arbitrarily chosen, in practice you need to think
 through your numbering system so that it matches the layout of registers
 and such things in your driver, or the code may become complicated. You must
 also consider matching of offsets to the GPIO ranges that may be handled by
 the pin controller.
 
-For a padring with 467 pads, as opposed to actual pins, I used an enumeration
-like this, walking around the edge of the chip, which seems to be industry
+For a padding with 467 pads, as opposed to actual pins, the enumeration will
+be like this, walking around the edge of the chip, which seems to be industry
 standard too (all these pads had names, too)::
 
 
@@ -133,7 +131,7 @@ on { 0, 8, 16, 24 }, and a group of pins dealing with an I2C interface on pins
 on { 24, 25 }.
 
 These two groups are presented to the pin control subsystem by implementing
-some generic pinctrl_ops like this:
+some generic ``pinctrl_ops`` like this:
 
 .. code-block:: c
 
@@ -179,7 +177,7 @@ some generic pinctrl_ops like this:
 		.pctlops = &foo_pctrl_ops,
 	};
 
-The pin control subsystem will call the .get_groups_count() function to
+The pin control subsystem will call the ``.get_groups_count()`` function to
 determine the total number of legal selectors, then it will call the other functions
 to retrieve the name and pins of the group. Maintaining the data structure of
 the groups is up to the driver, this is just a simple example - in practice you
@@ -322,7 +320,7 @@ like this:
 
 So this complex system has one pin controller handling two different
 GPIO chips. "chip a" has 16 pins and "chip b" has 8 pins. The "chip a" and
-"chip b" have different .pin_base, which means a start pin number of the
+"chip b" have different ``pin_base``, which means a start pin number of the
 GPIO range.
 
 The GPIO range of "chip a" starts from the GPIO base of 32 and actual
@@ -330,7 +328,7 @@ pin range also starts from 32. However "chip b" has different starting
 offset for the GPIO range and pin range. The GPIO range of "chip b" starts
 from GPIO number 48, while the pin range of "chip b" starts from 64.
 
-We can convert a gpio number to actual pin number using this "pin_base".
+We can convert a gpio number to actual pin number using this ``pin_base``.
 They are mapped in the global GPIO pin space at:
 
 chip a:
@@ -357,9 +355,9 @@ numbers can be encoded in the range like this:
 		.gc = &chip,
 	};
 
-In this case the pin_base property will be ignored. If the name of a pin
+In this case the ``pin_base`` property will be ignored. If the name of a pin
 group is known, the pins and npins elements of the above structure can be
-initialised using the function pinctrl_get_group_pins(), e.g. for pin
+initialised using the function ``pinctrl_get_group_pins()``, e.g. for pin
 group "foo":
 
 .. code-block:: c
@@ -380,8 +378,8 @@ will get a pin number into its handled number range. Further it is also passed
 the range ID value, so that the pin controller knows which range it should
 deal with.
 
-Calling pinctrl_add_gpio_range() from pinctrl driver is DEPRECATED. Please see
-section 2.1 of Documentation/devicetree/bindings/gpio/gpio.txt on how to bind
+Calling ``pinctrl_add_gpio_range()`` from pinctrl driver is DEPRECATED. Please see
+section 2.1 of ``Documentation/devicetree/bindings/gpio/gpio.txt`` on how to bind
 pinctrl and gpio drivers.
 
 
@@ -468,10 +466,10 @@ in your machine configuration. It is inspired by the clk, GPIO and regulator
 subsystems, so devices will request their mux setting, but it's also possible
 to request a single pin for e.g. GPIO.
 
-Definitions:
+The conventions are:
 
 - FUNCTIONS can be switched in and out by a driver residing with the pin
-  control subsystem in the drivers/pinctrl/* directory of the kernel. The
+  control subsystem in the ``drivers/pinctrl`` directory of the kernel. The
   pin control driver knows the possible functions. In the example above you can
   identify three pinmux functions, one for spi, one for i2c and one for mmc.
 
@@ -573,7 +571,7 @@ is possible to perform the requested mux setting, poke the hardware so that
 this happens.
 
 Pinmux drivers are required to supply a few callback functions, some are
-optional. Usually the .set_mux() function is implemented, writing values into
+optional. Usually the ``.set_mux()`` function is implemented, writing values into
 some certain registers to activate a certain mux setting for a certain pin.
 
 A simple driver for the above example will work by setting bits 0, 1, 2, 3, 4, or 5
@@ -699,18 +697,18 @@ Pin control interaction with the GPIO subsystem
 ===============================================
 
 Note that the following implies that the use case is to use a certain pin
-from the Linux kernel using the API in <linux/gpio/consumer.h> with gpiod_get()
+from the Linux kernel using the API in ``<linux/gpio/consumer.h>`` with gpiod_get()
 and similar functions. There are cases where you may be using something
 that your datasheet calls "GPIO mode", but actually is just an electrical
 configuration for a certain device. See the section below named
 `GPIO mode pitfalls`_ for more details on this scenario.
 
-The public pinmux API contains two functions named pinctrl_gpio_request()
-and pinctrl_gpio_free(). These two functions shall *ONLY* be called from
-gpiolib-based drivers as part of their .request() and .free() semantics.
-Likewise the pinctrl_gpio_direction_input()/pinctrl_gpio_direction_output()
-shall only be called from within respective .direction_input() /
-.direction_output() gpiolib implementation.
+The public pinmux API contains two functions named ``pinctrl_gpio_request()``
+and ``pinctrl_gpio_free()``. These two functions shall *ONLY* be called from
+gpiolib-based drivers as part of their ``.request()`` and ``.free()`` semantics.
+Likewise the ``pinctrl_gpio_direction_input()``/``pinctrl_gpio_direction_output()``
+shall only be called from within respective ``.direction_input()`` /
+``.direction_output()`` gpiolib implementation.
 
 NOTE that platforms and individual drivers shall *NOT* request GPIO pins to be
 controlled e.g. muxed in. Instead, implement a proper gpiolib driver and have
@@ -724,8 +722,8 @@ In this case, the function array would become 64 entries for each GPIO
 setting and then the device functions.
 
 For this reason there are two functions a pin control driver can implement
-to enable only GPIO on an individual pin: .gpio_request_enable() and
-.gpio_disable_free().
+to enable only GPIO on an individual pin: ``.gpio_request_enable()`` and
+``.gpio_disable_free()``.
 
 This function will pass in the affected GPIO range identified by the pin
 controller core, so you know which GPIO pins are being affected by the request
@@ -733,12 +731,12 @@ operation.
 
 If your driver needs to have an indication from the framework of whether the
 GPIO pin shall be used for input or output you can implement the
-.gpio_set_direction() function. As described this shall be called from the
+``.gpio_set_direction()`` function. As described this shall be called from the
 gpiolib driver and the affected GPIO range, pin offset and desired direction
 will be passed along to this function.
 
 Alternatively to using these special functions, it is fully allowed to use
-named functions for each GPIO pin, the pinctrl_gpio_request() will attempt to
+named functions for each GPIO pin, the ``pinctrl_gpio_request()`` will attempt to
 obtain the function "gpioN" where "N" is the global GPIO pin number if no
 special GPIO-handler is registered.
 
@@ -751,7 +749,7 @@ is taken to mean different things than what the kernel does, the developer
 may be confused by a datasheet talking about a pin being possible to set
 into "GPIO mode". It appears that what hardware engineers mean with
 "GPIO mode" is not necessarily the use case that is implied in the kernel
-interface <linux/gpio/consumer.h>: a pin that you grab from kernel code and then
+interface ``<linux/gpio/consumer.h>``: a pin that you grab from kernel code and then
 either listen for input or drive high/low to assert/deassert some
 external line.
 
@@ -861,8 +859,8 @@ wake up and maybe even gpiod_get()/gpiod_put() as part of this cycle. This
 all gets very complicated.
 
 The solution is to not think that what the datasheet calls "GPIO mode"
-has to be handled by the <linux/gpio/consumer.h> interface. Instead view this as
-a certain pin config setting. Look in e.g. <linux/pinctrl/pinconf-generic.h>
+has to be handled by the ``<linux/gpio/consumer.h>`` interface. Instead view this as
+a certain pin config setting. Look in e.g. ``<linux/pinctrl/pinconf-generic.h>``
 and you find this in the documentation:
 
   PIN_CONFIG_OUTPUT:
@@ -1040,7 +1038,7 @@ Finally, some devices expect the mapping table to contain certain specific
 named states. When running on hardware that doesn't need any pin controller
 configuration, the mapping table must still contain those named states, in
 order to explicitly indicate that the states were provided and intended to
-be empty. Table entry macro PIN_MAP_DUMMY_STATE serves the purpose of defining
+be empty. Table entry macro ``PIN_MAP_DUMMY_STATE()`` serves the purpose of defining
 a named state without causing any pin controller to be programmed:
 
 .. code-block:: c
@@ -1165,7 +1163,7 @@ Pin control requests from drivers
 =================================
 
 When a device driver is about to probe the device core will automatically
-attempt to issue pinctrl_get_select_default() on these devices.
+attempt to issue ``pinctrl_get_select_default()`` on these devices.
 This way driver writers do not need to add any of the boilerplate code
 of the type found below. However when doing fine-grained state selection
 and not using the "default" state, you may have to do some device driver
@@ -1183,8 +1181,8 @@ some cases where a driver needs to e.g. switch between different mux mappings
 at runtime this is not possible.
 
 A typical case is if a driver needs to switch bias of pins from normal
-operation and going to sleep, moving from the PINCTRL_STATE_DEFAULT to
-PINCTRL_STATE_SLEEP at runtime, re-biasing or even re-muxing pins to save
+operation and going to sleep, moving from the ``PINCTRL_STATE_DEFAULT`` to
+``PINCTRL_STATE_SLEEP`` at runtime, re-biasing or even re-muxing pins to save
 current in sleep mode.
 
 A driver may request a certain control state to be activated, usually just the
@@ -1230,49 +1228,49 @@ arrangement on your bus.
 
 The semantics of the pinctrl APIs are:
 
-- pinctrl_get() is called in process context to obtain a handle to all pinctrl
+- ``pinctrl_get()`` is called in process context to obtain a handle to all pinctrl
   information for a given client device. It will allocate a struct from the
   kernel memory to hold the pinmux state. All mapping table parsing or similar
   slow operations take place within this API.
 
-- devm_pinctrl_get() is a variant of pinctrl_get() that causes pinctrl_put()
+- ``devm_pinctrl_get()`` is a variant of pinctrl_get() that causes ``pinctrl_put()``
   to be called automatically on the retrieved pointer when the associated
   device is removed. It is recommended to use this function over plain
-  pinctrl_get().
+  ``pinctrl_get()``.
 
-- pinctrl_lookup_state() is called in process context to obtain a handle to a
+- ``pinctrl_lookup_state()`` is called in process context to obtain a handle to a
   specific state for a client device. This operation may be slow, too.
 
-- pinctrl_select_state() programs pin controller hardware according to the
+- ``pinctrl_select_state()`` programs pin controller hardware according to the
   definition of the state as given by the mapping table. In theory, this is a
   fast-path operation, since it only involved blasting some register settings
   into hardware. However, note that some pin controllers may have their
   registers on a slow/IRQ-based bus, so client devices should not assume they
-  can call pinctrl_select_state() from non-blocking contexts.
+  can call ``pinctrl_select_state()`` from non-blocking contexts.
 
-- pinctrl_put() frees all information associated with a pinctrl handle.
+- ``pinctrl_put()`` frees all information associated with a pinctrl handle.
 
-- devm_pinctrl_put() is a variant of pinctrl_put() that may be used to
-  explicitly destroy a pinctrl object returned by devm_pinctrl_get().
+- ``devm_pinctrl_put()`` is a variant of ``pinctrl_put()`` that may be used to
+  explicitly destroy a pinctrl object returned by ``devm_pinctrl_get()``.
   However, use of this function will be rare, due to the automatic cleanup
   that will occur even without calling it.
 
-  pinctrl_get() must be paired with a plain pinctrl_put().
-  pinctrl_get() may not be paired with devm_pinctrl_put().
-  devm_pinctrl_get() can optionally be paired with devm_pinctrl_put().
-  devm_pinctrl_get() may not be paired with plain pinctrl_put().
+  ``pinctrl_get()`` must be paired with a plain ``pinctrl_put()``.
+  ``pinctrl_get()`` may not be paired with ``devm_pinctrl_put()``.
+  ``devm_pinctrl_get()`` can optionally be paired with ``devm_pinctrl_put()``.
+  ``devm_pinctrl_get()`` may not be paired with plain ``pinctrl_put()``.
 
 Usually the pin control core handled the get/put pair and call out to the
 device drivers bookkeeping operations, like checking available functions and
-the associated pins, whereas pinctrl_select_state() pass on to the pin controller
+the associated pins, whereas ``pinctrl_select_state()`` pass on to the pin controller
 driver which takes care of activating and/or deactivating the mux setting by
 quickly poking some registers.
 
-The pins are allocated for your device when you issue the devm_pinctrl_get()
+The pins are allocated for your device when you issue the ``devm_pinctrl_get()``
 call, after this you should be able to see this in the debugfs listing of all
 pins.
 
-NOTE: the pinctrl system will return -EPROBE_DEFER if it cannot find the
+NOTE: the pinctrl system will return ``-EPROBE_DEFER`` if it cannot find the
 requested pinctrl handles, for example if the pinctrl driver has not yet
 registered. Thus make sure that the error path in your driver gracefully
 cleans up and is ready to retry the probing later in the startup process.
@@ -1329,12 +1327,12 @@ System pin control hogging
 ==========================
 
 Pin control map entries can be hogged by the core when the pin controller
-is registered. This means that the core will attempt to call pinctrl_get(),
-pinctrl_lookup_state() and pinctrl_select_state() on it immediately after
+is registered. This means that the core will attempt to call ``pinctrl_get()``,
+``pinctrl_lookup_state()`` and ``pinctrl_select_state()`` on it immediately after
 the pin control device has been registered.
 
 This occurs for mapping table entries where the client device name is equal
-to the pin controller device name, and the state name is PINCTRL_STATE_DEFAULT:
+to the pin controller device name, and the state name is ``PINCTRL_STATE_DEFAULT``:
 
 .. code-block:: c
 
-- 
2.39.0

