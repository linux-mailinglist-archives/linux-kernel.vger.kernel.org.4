Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B067459AE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 12:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjGCKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjGCKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 06:08:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F095DE4E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 03:08:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8423960EA2
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 10:08:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE10EC433C9;
        Mon,  3 Jul 2023 10:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688378915;
        bh=BaD6toh2y0mnDbjbMSg7vY97x1We+x9GNSLBKlN07c8=;
        h=Date:From:To:Cc:Subject:From;
        b=fHt2T7CizBycMiJ0biFju0KrKh8vGDdnsgmwv07WIA+wv4Lja0SIKrKrC66UbPx31
         PngQJSfUruyz6Wo2PHSP02F1qBg5FK6WHyRS2Av7QCKSkiWu8hnTC/VHGhjnoo3Z7o
         ZDzcJJErBjlyS0jm4yn4PAsn3bYKxXvv8b/9SCoYqBhdFg9b9E4mDoG+B7hXfRxVw4
         JzLCqGX4FLNQF9WwR8aVj6n/WGQG+EGwWP05t/PicL1jGaeqKeGBzl/luz3LSCKdy3
         YgJMQhPPT5o7uoOoKRb6WdsHCWKPc1dTRV18puQv4r3DWUvP/u8HeSM7mkZ5OwDX57
         nvAI9niLncNVw==
Date:   Mon, 3 Jul 2023 11:08:31 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.5
Message-ID: <20230703100831.GB10359@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git leds-next-6.5

for you to fetch changes up to 877e91191ccf0782ae18c5dfa7522fb1e5bfba8c:

  leds: leds-mt6323: Adjust return/parameter types in wled get/set callbacks (2023-06-23 10:57:14 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for Intel Cherry Trail Whiskey Cove PMIC LEDs
   - Add support for Awinic AW20036/AW20054/AW20072 LEDs

 - New Device Support
   - Add support for PMI632 LPG to QCom LPG
   - Add support for PMI8998 to QCom Flash
   - Add support for MT6331, WLEDs and MT6332 to Mediatek MT6323 PMIC

 - New Functionality
   - Implement the LP55xx Charge Pump
   - Add support for suspend / resume to Intel Cherry Trail Whiskey Cove PMIC
   - Add support for breathing mode to Intel Cherry Trail Whiskey Cove PMIC
   - Enable per-pin resolution Pinctrl in LEDs GPIO

 - Fix-ups
   - Allow thread to sleep by switching from spinlock to mutex
   - Add lots of Device Tree bindings / support
   - Adapt relationships / dependencies driven by Kconfig
   - Switch I2C drivers from .probe_new() to .probe()
   - Remove superfluous / duplicate code
   - Replace strlcpy() with strscpy() for efficiency and overflow prevention
   - Staticify various functions
   - Trivial: Fixing coding style
   - Simplify / reduce code

 - Bug Fixes
   - Prevent NETDEV_LED_MODE_LINKUP from being cleared on rename
   - Repair race between led_set_brightness(LED_{OFF,FULL})
   - Fix Oops relating to sleeping in critical sections
   - Clear LED_INIT_DEFAULT_TRIGGER flag when clearing the current trigger
   - Do not leak resources in error handling paths
   - Fix unsigned comparison which can never be negative
   - Provide missing NULL terminating entries in tables
   - Fix misnaming issues

----------------------------------------------------------------
AngeloGioacchino Del Regno (7):
      dt-bindings: leds: leds-mt6323: Document mt6331 compatible
      dt-bindings: leds: leds-mt6323: Document mt6332 compatible
      leds: leds-mt6323: Specify registers and specs in platform data
      leds: leds-mt6323: Drop MT6323_ prefix from macros and defines
      leds: leds-mt6323: Open code and drop MT6323_CAL_HW_DUTY macro
      leds: leds-mt6323: Add support for MT6331 leds
      leds: leds-mt6323: Add support for WLEDs and MT6332

Azeem Shaikh (3):
      leds: blinkm: Replace all non-returning strlcpy with strscpy
      leds: Replace all non-returning strlcpy with strscpy
      leds: as3645a: Replace strlcpy with strscpy

Christian Marangi (5):
      leds: trigger: netdev: Recheck NETDEV_LED_MODE_LINKUP on dev rename
      leds: trigger: netdev: Drop NETDEV_LED_MODE_LINKUP from mode
      leds: trigger: netdev: Rename add namespace to netdev trigger enum modes
      leds: trigger: netdev: Convert device attr to macro
      leds: trigger: netdev: Use mutex instead of spinlocks

Dylan Van Assche (3):
      leds: flash: leds-qcom-flash: Add PMI8998 support
      leds: flash: leds-qcom-flash: Disable LED when changing brightness
      dt-bindings: leds: qcom,spmi-flash-led: Add PMI8998

Geert Uytterhoeven (1):
      leds: Make LEDS_TI_LMU_COMMON invisible

Hans de Goede (9):
      leds: cht-wcove: Add suspend/resume handling
      leds: cht-wcove: Add support for breathing mode use hw_pattern sysfs API
      leds: cht-wcove: Set default trigger for charging LED
      leds: cht-wcove: Use breathing when LED_INIT_DEFAULT_TRIGGER is set
      leds: Change led_trigger_blink[_oneshot]() delay parameters to pass-by-value
      leds: Fix set_brightness_delayed() race
      leds: Fix oops about sleeping in led_trigger_blink()
      leds: Clear LED_INIT_DEFAULT_TRIGGER when clearing current trigger
      leds: cht-wcove: Mark cht_wc_leds_brightness_get() static

Henning Schild (4):
      leds: simatic-ipc-leds-gpio: Add terminating entries to gpio tables
      leds: simatic-ipc-leds-gpio: Move two extra gpio pins into another table
      leds: simatic-ipc-leds-gpio: Split up into multiple drivers
      leds: simatic-ipc-leds-gpio: Introduce more Kconfig switches

Jiapeng Chong (2):
      leds: cht-wcove: Remove unneeded semicolon
      leds: flash: leds-qcom-flash: Fix an unsigned comparison which can never be negative

Krzysztof Kozlowski (2):
      dt-bindings: leds: qcom,spmi-flash-led: Add PM8550
      dt-bindings: leds: Drop unneeded quotes

Lu Hongfei (1):
      led: qcom-lpg: Fix resource leaks in for_each_available_child_of_node() loops

Luca Weiss (4):
      dt-bindings: leds: qcom-lpg: Add compatible for PMI632 LPG block
      leds: qcom-lpg: Add support for PMI632 LPG
      dt-bindings: mfd: qcom-spmi-pmic: Add PMI632 compatible
      Documentation: leds: Add "rgb:status" path

Lukas Bulwahn (1):
      leds: Fix config reference for AW200xx driver

Maarten Zanders (2):
      dt-bindings: leds-lp55xx: Add ti,charge-pump-mode
      leds: lp55xx: Configure internal charge pump

Marek Vasut (1):
      leds: gpio: Configure per-LED pin control

Martin Kurbanov (2):
      leds: Add AW20xx driver
      dt-bindings: leds: Add binding for AW200xx

Nathan Chancellor (1):
      leds: leds-mt6323: Adjust return/parameter types in wled get/set callbacks

Neil Armstrong (1):
      dt-bindings: leds: qcom-lpg: Document PM8550 compatible

Niklas Schnelle (1):
      leds: Add HAS_IOPORT dependencies

Nishanth Menon (1):
      dt-bindings: leds: Drop redundant cpus enum match

Raymond Hackley (2):
      dt-bindings: leds: sgm3140: Document richtek,rt5033 compatible
      leds: sgm3140: Add richtek,rt5033-led compatible

Rob Herring (1):
      dt-bindings: backlight: kinetic,ktz8866: Add missing type for "current-num-sinks"

Uwe Kleine-König (1):
      leds: Switch i2c drivers back to use .probe()

Yang Li (2):
      leds: trigger: netdev: Remove NULL check before dev_{put, hold}
      leds: cht-wcove: Fix an unsigned comparison which can never be negative

Yauhen Kharuzhy (1):
      leds: Add Intel Cherry Trail Whiskey Cove PMIC LED driver

 .../ABI/testing/sysfs-class-led-driver-aw200xx     |   5 +
 .../devicetree/bindings/leds/awinic,aw200xx.yaml   | 126 +++++
 .../bindings/leds/backlight/kinetic,ktz8866.yaml   |   1 +
 Documentation/devicetree/bindings/leds/common.yaml |   2 -
 .../bindings/leds/leds-class-multicolor.yaml       |   2 +-
 .../devicetree/bindings/leds/leds-lp55xx.yaml      |  10 +
 .../devicetree/bindings/leds/leds-mt6323.txt       |   5 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |  30 +-
 .../devicetree/bindings/leds/leds-sgm3140.yaml     |   1 +
 .../bindings/leds/qcom,spmi-flash-led.yaml         |   2 +
 .../bindings/leds/rohm,bd71828-leds.yaml           |   2 +-
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |   1 +
 Documentation/leds/index.rst                       |   1 +
 Documentation/leds/leds-cht-wcove.rst              |  38 ++
 Documentation/leds/well-known-leds.txt             |   3 +-
 drivers/leds/Kconfig                               |  37 +-
 drivers/leds/Makefile                              |   2 +
 drivers/leds/flash/leds-aat1290.c                  |   2 +-
 drivers/leds/flash/leds-as3645a.c                  |   6 +-
 drivers/leds/flash/leds-lm3601x.c                  |   2 +-
 drivers/leds/flash/leds-qcom-flash.c               |  17 +-
 drivers/leds/flash/leds-rt4505.c                   |   2 +-
 drivers/leds/flash/leds-sgm3140.c                  |   1 +
 drivers/leds/led-class.c                           |   2 +-
 drivers/leds/led-core.c                            |  81 ++-
 drivers/leds/led-triggers.c                        |  17 +-
 drivers/leds/leds-an30259a.c                       |   2 +-
 drivers/leds/leds-aw200xx.c                        | 594 +++++++++++++++++++++
 drivers/leds/leds-aw2013.c                         |   2 +-
 drivers/leds/leds-bd2606mvv.c                      |   2 +-
 drivers/leds/leds-bd2802.c                         |   2 +-
 drivers/leds/leds-blinkm.c                         |   4 +-
 drivers/leds/leds-cht-wcove.c                      | 476 +++++++++++++++++
 drivers/leds/leds-gpio.c                           |  18 +
 drivers/leds/leds-is31fl319x.c                     |   2 +-
 drivers/leds/leds-is31fl32xx.c                     |   2 +-
 drivers/leds/leds-lm3530.c                         |   2 +-
 drivers/leds/leds-lm3532.c                         |   2 +-
 drivers/leds/leds-lm355x.c                         |   2 +-
 drivers/leds/leds-lm3642.c                         |   2 +-
 drivers/leds/leds-lm3692x.c                        |   2 +-
 drivers/leds/leds-lm3697.c                         |   2 +-
 drivers/leds/leds-lp3944.c                         |   2 +-
 drivers/leds/leds-lp3952.c                         |   2 +-
 drivers/leds/leds-lp50xx.c                         |   2 +-
 drivers/leds/leds-lp5521.c                         |  13 +-
 drivers/leds/leds-lp5523.c                         |  16 +-
 drivers/leds/leds-lp5562.c                         |   2 +-
 drivers/leds/leds-lp55xx-common.c                  |   9 +
 drivers/leds/leds-lp8501.c                         |  10 +-
 drivers/leds/leds-lp8860.c                         |   2 +-
 drivers/leds/leds-mt6323.c                         | 446 ++++++++++++----
 drivers/leds/leds-pca9532.c                        |   2 +-
 drivers/leds/leds-pca955x.c                        |   2 +-
 drivers/leds/leds-pca963x.c                        |   2 +-
 drivers/leds/leds-spi-byte.c                       |   2 +-
 drivers/leds/leds-tca6507.c                        |   2 +-
 drivers/leds/leds-tlc591xx.c                       |   2 +-
 drivers/leds/leds-turris-omnia.c                   |   2 +-
 drivers/leds/rgb/leds-qcom-lpg.c                   |  23 +-
 drivers/leds/simple/Kconfig                        |  31 +-
 drivers/leds/simple/Makefile                       |   5 +-
 .../leds/simple/simatic-ipc-leds-gpio-apollolake.c |  66 +++
 drivers/leds/simple/simatic-ipc-leds-gpio-core.c   | 104 ++++
 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c |  66 +++
 drivers/leds/simple/simatic-ipc-leds-gpio.c        | 139 -----
 drivers/leds/simple/simatic-ipc-leds-gpio.h        |  22 +
 drivers/leds/simple/simatic-ipc-leds.c             |   1 -
 drivers/leds/trigger/ledtrig-disk.c                |   9 +-
 drivers/leds/trigger/ledtrig-mtd.c                 |   8 +-
 drivers/leds/trigger/ledtrig-netdev.c              | 157 +++---
 drivers/net/arcnet/arcnet.c                        |   8 +-
 drivers/platform/x86/simatic-ipc.c                 |   7 +-
 drivers/power/supply/power_supply_leds.c           |   5 +-
 drivers/usb/common/led.c                           |   4 +-
 include/dt-bindings/leds/leds-lp55xx.h             |  10 +
 include/linux/leds.h                               |  43 +-
 include/linux/platform_data/leds-lp55xx.h          |   3 +
 net/mac80211/led.c                                 |   2 +-
 net/mac80211/led.h                                 |   8 +-
 net/netfilter/xt_LED.c                             |   3 +-
 81 files changed, 2268 insertions(+), 488 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-led-driver-aw200xx
 create mode 100644 Documentation/devicetree/bindings/leds/awinic,aw200xx.yaml
 create mode 100644 Documentation/leds/leds-cht-wcove.rst
 create mode 100644 drivers/leds/leds-aw200xx.c
 create mode 100644 drivers/leds/leds-cht-wcove.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-apollolake.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-core.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio-f7188x.c
 delete mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.c
 create mode 100644 drivers/leds/simple/simatic-ipc-leds-gpio.h
 create mode 100644 include/dt-bindings/leds/leds-lp55xx.h

-- 
Lee Jones [李琼斯]
