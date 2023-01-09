Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5908663203
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbjAIU4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237209AbjAIUz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:55:58 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6251A85C92;
        Mon,  9 Jan 2023 12:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673297675; x=1704833675;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5ZMy1vilEcd4JARUW7kqXKFaE9tRV+PY2Tn3+1zbuP0=;
  b=SWywOQNwHfbCfjyqckZravW7PG1iyrRXnpLC0YXayyV4hNO7cY0pjt/h
   Dtozp8v8KTj5bTCG4L6exeEFkUIHrrl85NJz1baPq1yv6yOAeWvyBaMNW
   wCQ9al517cwvkZn65YaKUKCQBuLY0u9awS3t3L/u5mH1mwtWZOHHZxtb7
   NdmlgJW0htY3UPiB2Xgo0jMoWgh0yuSWvuRpET2ktO8XMiOrtiWmpIIgk
   /ZtUVGMGpQ4NJEDPU6QivO7N5QYlgnJ7RMfohl1oaCG3xGhS22ZDnjFUP
   h9wLWL1/nvOVw1BnEvkmimrNvtnzghxRV/Qa/w+IDwuSAqSk8M6wHsV1l
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="324220247"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="324220247"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2023 12:54:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="725297979"
X-IronPort-AV: E=Sophos;i="5.96,313,1665471600"; 
   d="scan'208";a="725297979"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 09 Jan 2023 12:54:32 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id E2C7492; Mon,  9 Jan 2023 22:55:05 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Niyas Sait <niyas.sait@linaro.org>
Subject: [PATCH v1 1/1] pinctrl: Proofreading and updating the documentation accordingly
Date:   Mon,  9 Jan 2023 22:54:56 +0200
Message-Id: <20230109205456.30618-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Proofreading and updating the documentation accordingly, i.e. fixed:

  - ambiguity of foo_set_mux() implementation and explanations
  - semantics in some of the examples, e.g. _probe() --> _init()
  - references to the callbacks to make them start with dot
  - references to the legacy API by replacing them with newer one
  - indentation in some of the examples
  - double words or phrases

updated:

  - unsigned --> unsigned int in some of the examples
  - use struct pingroup and PINCTRL_PINGROUP() in some of the examples
  - use struct pinfunction and PINCTRL_PINFUNCTION() in some of the examples

and enabled:

  - syntax highlighting for the examples in the programming languages
  - chapter references

Yet to clarify:

  - "gpioN" menton for the default function when requesting GPIO

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---

It takes quite a bit of time for me to accomplish that. Anyway, there
is still open question (see commit message above) and even though this
needs checking and reading the rendered (as HTML and/or PDF) file for
formatting / spelling / semantical / logical / etc. issues. Reviewing
the patch without that makes a little sense, since it doesn't give the
context.

Also note, it includes some changes that rely on what I have in my
repo if this is going to be Reviewed/Acked I would like to push it
to my tree.

 Documentation/driver-api/pin-control.rst | 412 +++++++++++------------
 1 file changed, 201 insertions(+), 211 deletions(-)

diff --git a/Documentation/driver-api/pin-control.rst b/Documentation/driver-api/pin-control.rst
index 0022e930e93e..0274313e9997 100644
--- a/Documentation/driver-api/pin-control.rst
+++ b/Documentation/driver-api/pin-control.rst
@@ -11,7 +11,7 @@ This subsystem deals with:
 - Multiplexing of pins, pads, fingers (etc) see below for details
 
 - Configuration of pins, pads, fingers (etc), such as software-controlled
-  biasing and driving mode specific pins, such as pull-up/down, open drain,
+  biasing and driving mode specific pins, such as pull-up, pull-down, open drain,
   load capacitance etc.
 
 Top-level interface
@@ -57,7 +57,9 @@ Here is an example of a PGA (Pin Grid Array) chip seen from underneath::
    1    o   o   o   o   o   o   o   o
 
 To register a pin controller and name all the pins on this package we can do
-this in our driver::
+this in our driver:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/pinctrl.h>
 
@@ -78,14 +80,13 @@ this in our driver::
 		.owner = THIS_MODULE,
 	};
 
-	int __init foo_probe(void)
+	int __init foo_init(void)
 	{
 		int error;
 
 		struct pinctrl_dev *pctl;
 
-		error = pinctrl_register_and_init(&foo_desc, <PARENT>,
-						  NULL, &pctl);
+		error = pinctrl_register_and_init(&foo_desc, <PARENT>, NULL, &pctl);
 		if (error)
 			return error;
 
@@ -95,7 +96,7 @@ this in our driver::
 To enable the pinctrl subsystem and the subgroups for PINMUX and PINCONF and
 selected drivers, you need to select them from your machine's Kconfig entry,
 since these are so tightly integrated with the machines they are used on.
-See for example arch/arm/mach-ux500/Kconfig for an example.
+See arch/arm/mach-ux500/Kconfig for an example.
 
 Pins usually have fancier names than this. You can find these in the datasheet
 for your chip. Notice that the core pinctrl.h file provides a fancy macro
@@ -132,50 +133,38 @@ on { 0, 8, 16, 24 }, and a group of pins dealing with an I2C interface on pins
 on { 24, 25 }.
 
 These two groups are presented to the pin control subsystem by implementing
-some generic pinctrl_ops like this::
+some generic pinctrl_ops like this:
 
-	#include <linux/pinctrl/pinctrl.h>
+.. code-block:: c
 
-	struct foo_group {
-		const char *name;
-		const unsigned int *pins;
-		const unsigned num_pins;
-	};
+	#include <linux/pinctrl/pinctrl.h>
 
 	static const unsigned int spi0_pins[] = { 0, 8, 16, 24 };
 	static const unsigned int i2c0_pins[] = { 24, 25 };
 
-	static const struct foo_group foo_groups[] = {
-		{
-			.name = "spi0_grp",
-			.pins = spi0_pins,
-			.num_pins = ARRAY_SIZE(spi0_pins),
-		},
-		{
-			.name = "i2c0_grp",
-			.pins = i2c0_pins,
-			.num_pins = ARRAY_SIZE(i2c0_pins),
-		},
+	static const struct pingroup foo_groups[] = {
+		PINCTRL_PINGROUP("spi0_grp", spi0_pins, ARRAY_SIZE(spi0_pins)),
+		PINCTRL_PINGROUP("i2c0_grp", i2c0_pins, ARRAY_SIZE(i2c0_pins)),
 	};
 
-
 	static int foo_get_groups_count(struct pinctrl_dev *pctldev)
 	{
 		return ARRAY_SIZE(foo_groups);
 	}
 
 	static const char *foo_get_group_name(struct pinctrl_dev *pctldev,
-					unsigned selector)
+					      unsigned int selector)
 	{
 		return foo_groups[selector].name;
 	}
 
-	static int foo_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
-				const unsigned **pins,
-				unsigned *num_pins)
+	static int foo_get_group_pins(struct pinctrl_dev *pctldev,
+				      unsigned int selector,
+				      const unsigned int **pins,
+				      unsigned int *npins)
 	{
-		*pins = (unsigned *) foo_groups[selector].pins;
-		*num_pins = foo_groups[selector].num_pins;
+		*pins = foo_groups[selector].pins;
+		*npins = foo_groups[selector].npins;
 		return 0;
 	}
 
@@ -185,10 +174,9 @@ some generic pinctrl_ops like this::
 		.get_group_pins = foo_get_group_pins,
 	};
 
-
 	static struct pinctrl_desc foo_desc = {
-	...
-	.pctlops = &foo_pctrl_ops,
+		...
+		.pctlops = &foo_pctrl_ops,
 	};
 
 The pin control subsystem will call the .get_groups_count() function to
@@ -204,28 +192,31 @@ Pin configuration
 
 Pins can sometimes be software-configured in various ways, mostly related
 to their electronic properties when used as inputs or outputs. For example you
-may be able to make an output pin high impedance, or "tristate" meaning it is
+may be able to make an output pin high impedance (Hi-Z), or "tristate" meaning it is
 effectively disconnected. You may be able to connect an input pin to VDD or GND
 using a certain resistor value - pull up and pull down - so that the pin has a
 stable value when nothing is driving the rail it is connected to, or when it's
 unconnected.
 
 Pin configuration can be programmed by adding configuration entries into the
-mapping table; see section "Board/machine configuration" below.
+mapping table; see section `Board/machine configuration`_ below.
 
 The format and meaning of the configuration parameter, PLATFORM_X_PULL_UP
 above, is entirely defined by the pin controller driver.
 
 The pin configuration driver implements callbacks for changing pin
-configuration in the pin controller ops like this::
+configuration in the pin controller ops like this:
+
+.. code-block:: c
 
-	#include <linux/pinctrl/pinctrl.h>
 	#include <linux/pinctrl/pinconf.h>
+	#include <linux/pinctrl/pinctrl.h>
+
 	#include "platform_x_pindefs.h"
 
 	static int foo_pin_config_get(struct pinctrl_dev *pctldev,
-			unsigned offset,
-			unsigned long *config)
+				      unsigned int offset,
+				      unsigned long *config)
 	{
 		struct my_conftype conf;
 
@@ -235,28 +226,28 @@ configuration in the pin controller ops like this::
 	}
 
 	static int foo_pin_config_set(struct pinctrl_dev *pctldev,
-			unsigned offset,
-			unsigned long config)
+				      unsigned int offset,
+				      unsigned long config)
 	{
 		struct my_conftype *conf = (struct my_conftype *) config;
 
 		switch (conf) {
 			case PLATFORM_X_PULL_UP:
 			...
-			}
+			break;
 		}
 	}
 
-	static int foo_pin_config_group_get (struct pinctrl_dev *pctldev,
-			unsigned selector,
-			unsigned long *config)
+	static int foo_pin_config_group_get(struct pinctrl_dev *pctldev,
+					    unsigned selector,
+					    unsigned long *config)
 	{
 		...
 	}
 
-	static int foo_pin_config_group_set (struct pinctrl_dev *pctldev,
-			unsigned selector,
-			unsigned long config)
+	static int foo_pin_config_group_set(struct pinctrl_dev *pctldev,
+					    unsigned selector,
+					    unsigned long config)
 	{
 		...
 	}
@@ -281,8 +272,8 @@ The GPIO drivers may want to perform operations of various types on the same
 physical pins that are also registered as pin controller pins.
 
 First and foremost, the two subsystems can be used as completely orthogonal,
-see the section named "pin control requests from drivers" and
-"drivers needing both pin control and GPIOs" below for details. But in some
+see the section named `Pin control requests from drivers`_ and
+`Drivers needing both pin control and GPIOs`_ below for details. But in some
 situations a cross-subsystem mapping between pins and GPIOs is needed.
 
 Since the pin controller subsystem has its pinspace local to the pin controller
@@ -291,7 +282,13 @@ controller handles control of a certain GPIO pin. Since a single pin controller
 may be muxing several GPIO ranges (typically SoCs that have one set of pins,
 but internally several GPIO silicon blocks, each modelled as a struct
 gpio_chip) any number of GPIO ranges can be added to a pin controller instance
-like this::
+like this:
+
+.. code-block:: c
+
+	#include <linux/gpio/driver.h>
+
+	#include <linux/pinctrl/pinctrl.h>
 
 	struct gpio_chip chip_a;
 	struct gpio_chip chip_b;
@@ -302,7 +299,7 @@ like this::
 		.base = 32,
 		.pin_base = 32,
 		.npins = 16,
-		.gc = &chip_a;
+		.gc = &chip_a,
 	};
 
 	static struct pinctrl_gpio_range gpio_range_b = {
@@ -314,11 +311,13 @@ like this::
 		.gc = &chip_b;
 	};
 
+	int __init foo_init(void)
 	{
 		struct pinctrl_dev *pctl;
 		...
 		pinctrl_add_gpio_range(pctl, &gpio_range_a);
 		pinctrl_add_gpio_range(pctl, &gpio_range_b);
+		...
 	}
 
 So this complex system has one pin controller handling two different
@@ -343,9 +342,11 @@ chip b:
 
 The above examples assume the mapping between the GPIOs and pins is
 linear. If the mapping is sparse or haphazard, an array of arbitrary pin
-numbers can be encoded in the range like this::
+numbers can be encoded in the range like this:
 
-	static const unsigned range_pins[] = { 14, 1, 22, 17, 10, 8, 6, 2 };
+.. code-block:: c
+
+	static const unsigned int range_pins[] = { 14, 1, 22, 17, 10, 8, 6, 2 };
 
 	static struct pinctrl_gpio_range gpio_range = {
 		.name = "chip",
@@ -353,16 +354,17 @@ numbers can be encoded in the range like this::
 		.base = 32,
 		.pins = &range_pins,
 		.npins = ARRAY_SIZE(range_pins),
-		.gc = &chip;
+		.gc = &chip,
 	};
 
 In this case the pin_base property will be ignored. If the name of a pin
 group is known, the pins and npins elements of the above structure can be
 initialised using the function pinctrl_get_group_pins(), e.g. for pin
-group "foo"::
+group "foo":
+
+.. code-block:: c
 
-	pinctrl_get_group_pins(pctl, "foo", &gpio_range.pins,
-			       &gpio_range.npins);
+	pinctrl_get_group_pins(pctl, "foo", &gpio_range.pins, &gpio_range.npins);
 
 When GPIO-specific functions in the pin control subsystem are called, these
 ranges will be used to look up the appropriate pin controller by inspecting
@@ -378,7 +380,7 @@ will get a pin number into its handled number range. Further it is also passed
 the range ID value, so that the pin controller knows which range it should
 deal with.
 
-Calling pinctrl_add_gpio_range from pinctrl driver is DEPRECATED. Please see
+Calling pinctrl_add_gpio_range() from pinctrl driver is DEPRECATED. Please see
 section 2.1 of Documentation/devicetree/bindings/gpio/gpio.txt on how to bind
 pinctrl and gpio drivers.
 
@@ -515,11 +517,13 @@ Definitions:
   In the example case we can define that this particular machine shall
   use device spi0 with pinmux function fspi0 group gspi0 and i2c0 on function
   fi2c0 group gi2c0, on the primary pin controller, we get mappings
-  like these::
+  like these:
+
+  .. code-block:: c
 
 	{
 		{"map-spi0", spi0, pinctrl0, fspi0, gspi0},
-		{"map-i2c0", i2c0, pinctrl0, fi2c0, gi2c0}
+		{"map-i2c0", i2c0, pinctrl0, fi2c0, gi2c0},
 	}
 
   Every map must be assigned a state name, pin controller, device and
@@ -569,80 +573,51 @@ is possible to perform the requested mux setting, poke the hardware so that
 this happens.
 
 Pinmux drivers are required to supply a few callback functions, some are
-optional. Usually the set_mux() function is implemented, writing values into
+optional. Usually the .set_mux() function is implemented, writing values into
 some certain registers to activate a certain mux setting for a certain pin.
 
-A simple driver for the above example will work by setting bits 0, 1, 2, 3 or 4
+A simple driver for the above example will work by setting bits 0, 1, 2, 3, 4, or 5
 into some register named MUX to select a certain function with a certain
-group of pins would work something like this::
+group of pins would work something like this:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/pinctrl.h>
 	#include <linux/pinctrl/pinmux.h>
 
-	struct foo_group {
-		const char *name;
-		const unsigned int *pins;
-		const unsigned num_pins;
-	};
-
-	static const unsigned spi0_0_pins[] = { 0, 8, 16, 24 };
-	static const unsigned spi0_1_pins[] = { 38, 46, 54, 62 };
-	static const unsigned i2c0_pins[] = { 24, 25 };
-	static const unsigned mmc0_1_pins[] = { 56, 57 };
-	static const unsigned mmc0_2_pins[] = { 58, 59 };
-	static const unsigned mmc0_3_pins[] = { 60, 61, 62, 63 };
-
-	static const struct foo_group foo_groups[] = {
-		{
-			.name = "spi0_0_grp",
-			.pins = spi0_0_pins,
-			.num_pins = ARRAY_SIZE(spi0_0_pins),
-		},
-		{
-			.name = "spi0_1_grp",
-			.pins = spi0_1_pins,
-			.num_pins = ARRAY_SIZE(spi0_1_pins),
-		},
-		{
-			.name = "i2c0_grp",
-			.pins = i2c0_pins,
-			.num_pins = ARRAY_SIZE(i2c0_pins),
-		},
-		{
-			.name = "mmc0_1_grp",
-			.pins = mmc0_1_pins,
-			.num_pins = ARRAY_SIZE(mmc0_1_pins),
-		},
-		{
-			.name = "mmc0_2_grp",
-			.pins = mmc0_2_pins,
-			.num_pins = ARRAY_SIZE(mmc0_2_pins),
-		},
-		{
-			.name = "mmc0_3_grp",
-			.pins = mmc0_3_pins,
-			.num_pins = ARRAY_SIZE(mmc0_3_pins),
-		},
+	static const unsigned int spi0_0_pins[] = { 0, 8, 16, 24 };
+	static const unsigned int spi0_1_pins[] = { 38, 46, 54, 62 };
+	static const unsigned int i2c0_pins[] = { 24, 25 };
+	static const unsigned int mmc0_1_pins[] = { 56, 57 };
+	static const unsigned int mmc0_2_pins[] = { 58, 59 };
+	static const unsigned int mmc0_3_pins[] = { 60, 61, 62, 63 };
+
+	static const struct pingroup foo_groups[] = {
+		PINCTRL_PINGROUP("spi0_0_grp", spi0_0_pins, ARRAY_SIZE(spi0_0_pins)),
+		PINCTRL_PINGROUP("spi0_1_grp", spi0_1_pins, ARRAY_SIZE(spi0_1_pins)),
+		PINCTRL_PINGROUP("i2c0_grp", i2c0_pins, ARRAY_SIZE(i2c0_pins)),
+		PINCTRL_PINGROUP("mmc0_1_grp", mmc0_1_pins, ARRAY_SIZE(mmc0_1_pins)),
+		PINCTRL_PINGROUP("mmc0_2_grp", mmc0_2_pins, ARRAY_SIZE(mmc0_2_pins)),
+		PINCTRL_PINGROUP("mmc0_3_grp", mmc0_3_pins, ARRAY_SIZE(mmc0_3_pins)),
 	};
 
-
 	static int foo_get_groups_count(struct pinctrl_dev *pctldev)
 	{
 		return ARRAY_SIZE(foo_groups);
 	}
 
 	static const char *foo_get_group_name(struct pinctrl_dev *pctldev,
-					unsigned selector)
+					      unsigned int selector)
 	{
 		return foo_groups[selector].name;
 	}
 
-	static int foo_get_group_pins(struct pinctrl_dev *pctldev, unsigned selector,
-				const unsigned ** pins,
-				unsigned * num_pins)
+	static int foo_get_group_pins(struct pinctrl_dev *pctldev, unsigned int selector,
+				      const unsigned int **pins,
+				      unsigned int *npins)
 	{
-		*pins = (unsigned *) foo_groups[selector].pins;
-		*num_pins = foo_groups[selector].num_pins;
+		*pins = foo_groups[selector].pins;
+		*npins = foo_groups[selector].npins;
 		return 0;
 	}
 
@@ -652,33 +627,14 @@ group of pins would work something like this::
 		.get_group_pins = foo_get_group_pins,
 	};
 
-	struct foo_pmx_func {
-		const char *name;
-		const char * const *groups;
-		const unsigned num_groups;
-	};
-
 	static const char * const spi0_groups[] = { "spi0_0_grp", "spi0_1_grp" };
 	static const char * const i2c0_groups[] = { "i2c0_grp" };
-	static const char * const mmc0_groups[] = { "mmc0_1_grp", "mmc0_2_grp",
-						"mmc0_3_grp" };
+	static const char * const mmc0_groups[] = { "mmc0_1_grp", "mmc0_2_grp", "mmc0_3_grp" };
 
-	static const struct foo_pmx_func foo_functions[] = {
-		{
-			.name = "spi0",
-			.groups = spi0_groups,
-			.num_groups = ARRAY_SIZE(spi0_groups),
-		},
-		{
-			.name = "i2c0",
-			.groups = i2c0_groups,
-			.num_groups = ARRAY_SIZE(i2c0_groups),
-		},
-		{
-			.name = "mmc0",
-			.groups = mmc0_groups,
-			.num_groups = ARRAY_SIZE(mmc0_groups),
-		},
+	static const struct pinfunction foo_functions[] = {
+		PINCTRL_PINFUNCTION("spi0", spi0_groups, ARRAY_SIZE(spi0_groups)),
+		PINCTRL_PINFUNCTION("i2c0", i2c0_groups, ARRAY_SIZE(i2c0_groups)),
+		PINCTRL_PINFUNCTION("mmc0", mmc0_groups, ARRAY_SIZE(mmc0_groups)),
 	};
 
 	static int foo_get_functions_count(struct pinctrl_dev *pctldev)
@@ -686,26 +642,26 @@ group of pins would work something like this::
 		return ARRAY_SIZE(foo_functions);
 	}
 
-	static const char *foo_get_fname(struct pinctrl_dev *pctldev, unsigned selector)
+	static const char *foo_get_fname(struct pinctrl_dev *pctldev, unsigned int selector)
 	{
 		return foo_functions[selector].name;
 	}
 
-	static int foo_get_groups(struct pinctrl_dev *pctldev, unsigned selector,
-				const char * const **groups,
-				unsigned * const num_groups)
+	static int foo_get_groups(struct pinctrl_dev *pctldev, unsigned int selector,
+				  const char * const **groups,
+				  unsigned int * const ngroups)
 	{
 		*groups = foo_functions[selector].groups;
-		*num_groups = foo_functions[selector].num_groups;
+		*ngroups = foo_functions[selector].ngroups;
 		return 0;
 	}
 
-	static int foo_set_mux(struct pinctrl_dev *pctldev, unsigned selector,
-			unsigned group)
+	static int foo_set_mux(struct pinctrl_dev *pctldev, unsigned int selector,
+			       unsigned int group)
 	{
-		u8 regbit = (1 << selector + group);
+		u8 regbit = BIT(group);
 
-		writeb((readb(MUX)|regbit), MUX);
+		writeb((readb(MUX) | regbit), MUX);
 		return 0;
 	}
 
@@ -724,16 +680,17 @@ group of pins would work something like this::
 		.pmxops = &foo_pmxops,
 	};
 
-In the example activating muxing 0 and 1 at the same time setting bits
-0 and 1, uses one pin in common so they would collide.
+In the example activating muxing 0 and 2 at the same time setting bits
+0 and 2, uses pin 24 in common so they would collide. All the same for
+the muxes 1 and 5, which have pin 62 in common.
 
 The beauty of the pinmux subsystem is that since it keeps track of all
 pins and who is using them, it will already have denied an impossible
 request like that, so the driver does not need to worry about such
 things - when it gets a selector passed in, the pinmux subsystem makes
 sure no other device or GPIO assignment is already using the selected
-pins. Thus bits 0 and 1 in the control register will never be set at the
-same time.
+pins. Thus bits 0 and 2, or 1 and 5 in the control register will never
+be set at the same time.
 
 All the above functions are mandatory to implement for a pinmux driver.
 
@@ -742,18 +699,18 @@ Pin control interaction with the GPIO subsystem
 ===============================================
 
 Note that the following implies that the use case is to use a certain pin
-from the Linux kernel using the API in <linux/gpio.h> with gpio_request()
+from the Linux kernel using the API in <linux/gpio/consumer.h> with gpiod_get()
 and similar functions. There are cases where you may be using something
 that your datasheet calls "GPIO mode", but actually is just an electrical
 configuration for a certain device. See the section below named
-"GPIO mode pitfalls" for more details on this scenario.
+`GPIO mode pitfalls`_ for more details on this scenario.
 
 The public pinmux API contains two functions named pinctrl_gpio_request()
 and pinctrl_gpio_free(). These two functions shall *ONLY* be called from
-gpiolib-based drivers as part of their gpio_request() and
-gpio_free() semantics. Likewise the pinctrl_gpio_direction_[input|output]
-shall only be called from within respective gpio_direction_[input|output]
-gpiolib implementation.
+gpiolib-based drivers as part of their .request() and .free() semantics.
+Likewise the pinctrl_gpio_direction_input()/pinctrl_gpio_direction_output()
+shall only be called from within respective .direction_input() /
+.direction_output() gpiolib implementation.
 
 NOTE that platforms and individual drivers shall *NOT* request GPIO pins to be
 controlled e.g. muxed in. Instead, implement a proper gpiolib driver and have
@@ -794,7 +751,7 @@ is taken to mean different things than what the kernel does, the developer
 may be confused by a datasheet talking about a pin being possible to set
 into "GPIO mode". It appears that what hardware engineers mean with
 "GPIO mode" is not necessarily the use case that is implied in the kernel
-interface <linux/gpio.h>: a pin that you grab from kernel code and then
+interface <linux/gpio/consumer.h>: a pin that you grab from kernel code and then
 either listen for input or drive high/low to assert/deassert some
 external line.
 
@@ -805,9 +762,10 @@ for a device.
 
 The GPIO portions of a pin and its relation to a certain pin controller
 configuration and muxing logic can be constructed in several ways. Here
-are two examples::
+are two examples.
+
+Example **(A)**::
 
-     (A)
                        pin config
                        logic regs
                        |               +- SPI
@@ -836,9 +794,7 @@ simultaneous access to the same pin from GPIO and pin multiplexing
 consumers on hardware of this type. The pinctrl driver should set this flag
 accordingly.
 
-::
-
-     (B)
+Example **(B)**::
 
                        pin config
                        logic regs
@@ -899,13 +855,13 @@ If you make a 1-to-1 map to the GPIO subsystem for this pin, you may start
 to think that you need to come up with something really complex, that the
 pin shall be used for UART TX and GPIO at the same time, that you will grab
 a pin control handle and set it to a certain state to enable UART TX to be
-muxed in, then twist it over to GPIO mode and use gpio_direction_output()
+muxed in, then twist it over to GPIO mode and use gpiod_direction_output()
 to drive it low during sleep, then mux it over to UART TX again when you
-wake up and maybe even gpio_request/gpio_free as part of this cycle. This
+wake up and maybe even gpiod_get()/gpiod_put() as part of this cycle. This
 all gets very complicated.
 
 The solution is to not think that what the datasheet calls "GPIO mode"
-has to be handled by the <linux/gpio.h> interface. Instead view this as
+has to be handled by the <linux/gpio/consumer.h> interface. Instead view this as
 a certain pin config setting. Look in e.g. <linux/pinctrl/pinconf-generic.h>
 and you find this in the documentation:
 
@@ -915,7 +871,9 @@ and you find this in the documentation:
 
 So it is perfectly possible to push a pin into "GPIO mode" and drive the
 line low as part of the usual pin control map. So for example your UART
-driver may look like this::
+driver may look like this:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/consumer.h>
 
@@ -928,13 +886,13 @@ driver may look like this::
 
 	/* Normal mode */
 	retval = pinctrl_select_state(pinctrl, pins_default);
+
 	/* Sleep mode */
 	retval = pinctrl_select_state(pinctrl, pins_sleep);
 
 And your machine configuration may look like this:
---------------------------------------------------
 
-::
+.. code-block:: c
 
 	static unsigned long uart_default_mode[] = {
 		PIN_CONF_PACKED(PIN_CONFIG_DRIVE_PUSH_PULL, 0),
@@ -946,16 +904,17 @@ And your machine configuration may look like this:
 
 	static struct pinctrl_map pinmap[] __initdata = {
 		PIN_MAP_MUX_GROUP("uart", PINCTRL_STATE_DEFAULT, "pinctrl-foo",
-			"u0_group", "u0"),
+				  "u0_group", "u0"),
 		PIN_MAP_CONFIGS_PIN("uart", PINCTRL_STATE_DEFAULT, "pinctrl-foo",
-				"UART_TX_PIN", uart_default_mode),
+				    "UART_TX_PIN", uart_default_mode),
 		PIN_MAP_MUX_GROUP("uart", PINCTRL_STATE_SLEEP, "pinctrl-foo",
-			"u0_group", "gpio-mode"),
+				  "u0_group", "gpio-mode"),
 		PIN_MAP_CONFIGS_PIN("uart", PINCTRL_STATE_SLEEP, "pinctrl-foo",
-				"UART_TX_PIN", uart_sleep_mode),
+				    "UART_TX_PIN", uart_sleep_mode),
 	};
 
-	foo_init(void) {
+	foo_init(void)
+	{
 		pinctrl_register_mappings(pinmap, ARRAY_SIZE(pinmap));
 	}
 
@@ -995,7 +954,9 @@ part of this.
 
 A pin controller configuration for a machine looks pretty much like a simple
 regulator configuration, so for the example array above we want to enable i2c
-and spi on the second function mapping::
+and spi on the second function mapping:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/machine.h>
 
@@ -1030,13 +991,17 @@ must match a function provided by the pinmux driver handling this pin range.
 As you can see we may have several pin controllers on the system and thus
 we need to specify which one of them contains the functions we wish to map.
 
-You register this pinmux mapping to the pinmux subsystem by simply::
+You register this pinmux mapping to the pinmux subsystem by simply:
+
+.. code-block:: c
 
        ret = pinctrl_register_mappings(mapping, ARRAY_SIZE(mapping));
 
 Since the above construct is pretty common there is a helper macro to make
 it even more compact which assumes you want to use pinctrl-foo and position
-0 for mapping, for example::
+0 for mapping, for example:
+
+.. code-block:: c
 
 	static struct pinctrl_map mapping[] __initdata = {
 		PIN_MAP_MUX_GROUP("foo-i2c.o", PINCTRL_STATE_DEFAULT,
@@ -1046,7 +1011,9 @@ it even more compact which assumes you want to use pinctrl-foo and position
 The mapping table may also contain pin configuration entries. It's common for
 each pin/group to have a number of configuration entries that affect it, so
 the table entries for configuration reference an array of config parameters
-and values. An example using the convenience macros is shown below::
+and values. An example using the convenience macros is shown below:
+
+.. code-block:: c
 
 	static unsigned long i2c_grp_configs[] = {
 		FOO_PIN_DRIVEN,
@@ -1074,7 +1041,9 @@ named states. When running on hardware that doesn't need any pin controller
 configuration, the mapping table must still contain those named states, in
 order to explicitly indicate that the states were provided and intended to
 be empty. Table entry macro PIN_MAP_DUMMY_STATE serves the purpose of defining
-a named state without causing any pin controller to be programmed::
+a named state without causing any pin controller to be programmed:
+
+.. code-block:: c
 
 	static struct pinctrl_map mapping[] __initdata = {
 		PIN_MAP_DUMMY_STATE("foo-i2c.0", PINCTRL_STATE_DEFAULT),
@@ -1085,7 +1054,9 @@ Complex mappings
 ================
 
 As it is possible to map a function to different groups of pins an optional
-.group can be specified like this::
+.group can be specified like this:
+
+.. code-block:: c
 
 	...
 	{
@@ -1107,13 +1078,15 @@ As it is possible to map a function to different groups of pins an optional
 	...
 
 This example mapping is used to switch between two positions for spi0 at
-runtime, as described further below under the heading "Runtime pinmuxing".
+runtime, as described further below under the heading `Runtime pinmuxing`_.
 
 Further it is possible for one named state to affect the muxing of several
 groups of pins, say for example in the mmc0 example above, where you can
 additively expand the mmc0 bus from 2 to 4 to 8 pins. If we want to use all
-three groups for a total of 2+2+4 = 8 pins (for an 8-bit MMC bus as is the
-case), we define a mapping like this::
+three groups for a total of 2 + 2 + 4 = 8 pins (for an 8-bit MMC bus as is the
+case), we define a mapping like this:
+
+.. code-block:: c
 
 	...
 	{
@@ -1167,13 +1140,17 @@ case), we define a mapping like this::
 	...
 
 The result of grabbing this mapping from the device with something like
-this (see next paragraph)::
+this (see next paragraph):
+
+.. code-block:: c
 
 	p = devm_pinctrl_get(dev);
 	s = pinctrl_lookup_state(p, "8bit");
 	ret = pinctrl_select_state(p, s);
 
-or more simply::
+or more simply:
+
+.. code-block:: c
 
 	p = devm_pinctrl_get_select(dev, "8bit");
 
@@ -1211,7 +1188,9 @@ PINCTRL_STATE_SLEEP at runtime, re-biasing or even re-muxing pins to save
 current in sleep mode.
 
 A driver may request a certain control state to be activated, usually just the
-default state like this::
+default state like this:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/consumer.h>
 
@@ -1285,7 +1264,7 @@ The semantics of the pinctrl APIs are:
 
 Usually the pin control core handled the get/put pair and call out to the
 device drivers bookkeeping operations, like checking available functions and
-the associated pins, whereas select_state pass on to the pin controller
+the associated pins, whereas pinctrl_select_state() pass on to the pin controller
 driver which takes care of activating and/or deactivating the mux setting by
 quickly poking some registers.
 
@@ -1305,18 +1284,20 @@ Drivers needing both pin control and GPIOs
 Again, it is discouraged to let drivers lookup and select pin control states
 themselves, but again sometimes this is unavoidable.
 
-So say that your driver is fetching its resources like this::
+So say that your driver is fetching its resources like this:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/consumer.h>
-	#include <linux/gpio.h>
+	#include <linux/gpio/consumer.h>
 
 	struct pinctrl *pinctrl;
-	int gpio;
+	struct gpio_desc *gpio;
 
 	pinctrl = devm_pinctrl_get_select_default(&dev);
-	gpio = devm_gpio_request(&dev, 14, "foo");
+	gpio = devm_gpiod_get(&dev, "foo");
 
-Here we first request a certain pin state and then request GPIO 14 to be
+Here we first request a certain pin state and then request GPIO "foo" to be
 used. If you're using the subsystems orthogonally like this, you should
 nominally always get your pinctrl handle and select the desired pinctrl
 state BEFORE requesting the GPIO. This is a semantic convention to avoid
@@ -1331,9 +1312,9 @@ probing, nevertheless orthogonal to the GPIO subsystem.
 But there are also situations where it makes sense for the GPIO subsystem
 to communicate directly with the pinctrl subsystem, using the latter as a
 back-end. This is when the GPIO driver may call out to the functions
-described in the section "Pin control interaction with the GPIO subsystem"
+described in the section `Pin control interaction with the GPIO subsystem`_
 above. This only involves per-pin multiplexing, and will be completely
-hidden behind the gpio_*() function namespace. In this case, the driver
+hidden behind the gpiod_*() function namespace. In this case, the driver
 need not interact with the pin control subsystem at all.
 
 If a pin control driver and a GPIO driver is dealing with the same pins
@@ -1349,11 +1330,13 @@ System pin control hogging
 
 Pin control map entries can be hogged by the core when the pin controller
 is registered. This means that the core will attempt to call pinctrl_get(),
-lookup_state() and select_state() on it immediately after the pin control
-device has been registered.
+pinctrl_lookup_state() and pinctrl_select_state() on it immediately after
+the pin control device has been registered.
 
 This occurs for mapping table entries where the client device name is equal
-to the pin controller device name, and the state name is PINCTRL_STATE_DEFAULT::
+to the pin controller device name, and the state name is PINCTRL_STATE_DEFAULT:
+
+.. code-block:: c
 
 	{
 		.dev_name = "pinctrl-foo",
@@ -1365,7 +1348,9 @@ to the pin controller device name, and the state name is PINCTRL_STATE_DEFAULT::
 
 Since it may be common to request the core to hog a few always-applicable
 mux settings on the primary pin controller, there is a convenience macro for
-this::
+this:
+
+.. code-block:: c
 
 	PIN_MAP_MUX_GROUP_HOG_DEFAULT("pinctrl-foo", NULL /* group */,
 				      "power_func")
@@ -1385,7 +1370,9 @@ function, but with different named in the mapping as described under
 
 This snippet first initializes a state object for both groups (in foo_probe()),
 then muxes the function in the pins defined by group A, and finally muxes it in
-on the pins defined by group B::
+on the pins defined by group B:
+
+.. code-block:: c
 
 	#include <linux/pinctrl/consumer.h>
 
@@ -1413,14 +1400,14 @@ on the pins defined by group B::
 		/* Enable on position A */
 		ret = pinctrl_select_state(p, s1);
 		if (ret < 0)
-		...
+			...
 
 		...
 
 		/* Enable on position B */
 		ret = pinctrl_select_state(p, s2);
 		if (ret < 0)
-		...
+			...
 
 		...
 	}
@@ -1432,6 +1419,7 @@ can be used by different functions at different times on a running system.
 
 Debugfs files
 =============
+
 These files are created in ``/sys/kernel/debug/pinctrl``:
 
 - ``pinctrl-devices``: prints each pin controller device along with columns to
@@ -1440,7 +1428,7 @@ These files are created in ``/sys/kernel/debug/pinctrl``:
 - ``pinctrl-handles``: prints each configured pin controller handle and the
   corresponding pinmux maps
 
-- ``pinctrl-maps``: print all pinctrl maps
+- ``pinctrl-maps``: prints all pinctrl maps
 
 A sub-directory is created inside of ``/sys/kernel/debug/pinctrl`` for each pin
 controller device containing these files:
@@ -1448,20 +1436,22 @@ controller device containing these files:
 - ``pins``: prints a line for each pin registered on the pin controller. The
   pinctrl driver may add additional information such as register contents.
 
-- ``gpio-ranges``: print ranges that map gpio lines to pins on the controller
+- ``gpio-ranges``: prints ranges that map gpio lines to pins on the controller
 
-- ``pingroups``: print all pin groups registered on the pin controller
+- ``pingroups``: prints all pin groups registered on the pin controller
 
-- ``pinconf-pins``: print pin config settings for each pin
+- ``pinconf-pins``: prints pin config settings for each pin
 
-- ``pinconf-groups``: print pin config settings per pin group
+- ``pinconf-groups``: prints pin config settings per pin group
 
-- ``pinmux-functions``: print each pin function along with the pin groups that
+- ``pinmux-functions``: prints each pin function along with the pin groups that
   map to the pin function
 
-- ``pinmux-pins``: iterate through all pins and print mux owner, gpio owner
+- ``pinmux-pins``: iterates through all pins and prints mux owner, gpio owner
   and if the pin is a hog
 
-- ``pinmux-select``: write to this file to activate a pin function for a group::
+- ``pinmux-select``: write to this file to activate a pin function for a group:
+
+  .. code-block:: sh
 
         echo "<group-name function-name>" > pinmux-select
-- 
2.39.0

