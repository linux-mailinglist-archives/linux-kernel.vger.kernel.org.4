Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C8F64A824
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiLLTdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbiLLTdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:33:31 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F19462CD;
        Mon, 12 Dec 2022 11:33:29 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id c7so604451pfc.12;
        Mon, 12 Dec 2022 11:33:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFYlefV4h3v2nXvdtozVUHtBjF56hW8AbPdxkZDGIW0=;
        b=YilF7iQQq5wCsB609eq8cEfd0NtvpzZGS2Td7L2Sd7dL7ZKWl3V36/XHfq4XTZTAtT
         Og9aInv1z2ixRvH+rqacG+yI5R/if/ERVV8QHvFi+B+Rqum1YUXoMTUGGPto/fV+ugSJ
         tJ2Z1mRtBJUM8QLaZ72utY1bBfQeBhIei8ZsPNeQ32QBKyLEIK5ajFjb7LZeXeOvsKrO
         IKWFinNbLT58USJLn1k7DwmEakRC0ZVOM4jePQFp5d7EGlFvByhVi2oTlU89own3pgQ+
         g4i9ZIo0D5lfFqMXC/KScfGCFyJiggFByzwsIo2O2fQhIa41X3l4iXbP+r9FmXASb0Rq
         aeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UFYlefV4h3v2nXvdtozVUHtBjF56hW8AbPdxkZDGIW0=;
        b=1Z48oYtvEBOPuEYZZlgwG05f+QQLwcsudISF7pQ/rSumZJOoV3ZR3ymGmrAqQ78cjW
         xNP83G04zHQg8ebgCRZcTinIM32aZVIRQFb2MeEvLyRbe7UGs3746kI++dFwFUjeorv/
         ad9Z37E96vipkBGltuc/B++tq6edpP86wXq73h+Y1RxweYaZG+uHcXENnu8JItpQWwcy
         IOacvk3Ebxd9pRC4X86Zf/997evZ9JyCAs3BOD6mbiwQ/u6j/yRdsovprQGKcH/Mze2Z
         QSop/bFq7yqb54qF8iLdk2za693r3Pnf25rIT3kUqbq1srGgU4fZvLXwbVb1nR3EGyJt
         OHXw==
X-Gm-Message-State: ANoB5pm8Ez7wVPx44ivURKeR/DdPvR4pA7xaGhYaYxZ6AhW4grc/kIND
        iKK1soJ7f7w/X/umKzTN4mBqlyga3DM=
X-Google-Smtp-Source: AA0mqf4DAw2lXWuhN0j4IH8A9TP6ySMGsKd6TZDgmZ8jPa/U8Fi4kC5Lu5o24XDcNS1zK4Gz/jEmRQ==
X-Received: by 2002:a05:6a00:d6c:b0:577:a0d:b078 with SMTP id n44-20020a056a000d6c00b005770a0db078mr15989085pfv.20.1670873608358;
        Mon, 12 Dec 2022 11:33:28 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:77a6:a092:fc6e:38d3])
        by smtp.gmail.com with ESMTPSA id i26-20020aa796fa000000b00577986d77c5sm6151136pfq.152.2022.12.12.11.33.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 11:33:27 -0800 (PST)
Date:   Mon, 12 Dec 2022 11:33:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.2-rc0
Message-ID: <Y5eCBO0BlBsr1smj@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.2-rc0

to receive updates for the input subsystem. You will get:

- a new driver for Cypress Generation 5 touchscreens
- a new driver for Hynitron cstxxx touchscreens
- a new driver for Himax hx83112b touchscreen
- I2C input devices have been converted to use i2c's probe_new()
- a large number of input devices are now using DEFINE_SIMPLE_DEV_PM_OPS
  and pm_sleep_ptr() and no longer use __maybe_unused annotations
- improvements to msg2638 touchscreen driver to also support msg2138
- conversion of several input deevine bindings to yaml/DT schema
- changes to select touch drivers to move handling of wake irqs to the
  PM core
- other assorted fixes and improvements.

Changelog:
---------

Alistair Francis (2):
      dt-bindings: input: Add Cypress TT21000 touchscreen controller
      Input: Add driver for Cypress Generation 5 touchscreen

Andre Przywara (1):
      dt-bindings: input: sun4i-lradc-keys: Add F1C100s compatible

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

Chris Morgan (4):
      dt-bindings: vendor-prefixes: add Hynitron vendor prefix
      dt-bindings: input: touchscreen: Add Hynitron cstxxx
      Input: add driver for Hynitron cstxxx touchscreens
      Input: hynitron_cstxxx - initialize tmp to 0 to fix uninitialized variable issue

Christophe JAILLET (1):
      Input: Use kstrtobool() instead of strtobool()

Colin Ian King (2):
      Input: dlink-dir685-touchkeys - make array bl_data static const
      Input: tps6507x-ts - remove variable loops

Dan Carpenter (1):
      Input: elants_i2c - delete some dead code

Dmitry Torokhov (7):
      ARM: dts: imx6qdl-sabre*: fix Egalax touchscreen properties
      dt-binding: input: egalax-ts: fix GPIO and IRQ in example
      Input: egalax_ts - switch to using gpiod API
      Input: egalax_ts - do not hardcode interrupt trigger
      iio: adc: twl4030-madc: add missing of.h include
      ARM: s3c64xx: include header defining input event codes
      Input: stmpe-keypad - add missing of.h include

Douglas Anderson (2):
      Input: elants_i2c - properly handle the reset GPIO when power is off
      Input: elants_i2c - delay longer with reset asserted

Eray Orçunus (1):
      HID: add mapping for camera access keys

Fabio Estevam (1):
      dt-bindings: input: gpio-beeper: Convert to yaml schema

Jean Delvare (2):
      Input: atmel_captouch - drop obsolete dependency on COMPILE_TEST
      Input: stmpe-ts - drop obsolete dependency on COMPILE_TEST

Jeff LaBundy (7):
      Input: iqs7222 - drop unused device node references
      dt-bindings: input: iqs7222: Reduce 'linux,code' to optional
      Input: iqs7222 - report malformed properties
      dt-bindings: input: iqs7222: Correct minimum slider size
      Input: iqs7222 - protect against undefined slider size
      dt-bindings: input: iqs7222: Add support for IQS7222A v1.13+
      Input: iqs7222 - add support for IQS7222A v1.13+

Job Noorman (2):
      dt-bindings: touchscreen: add Himax hx83112b bindings
      Input: add driver for Himax hx83112b touchscreen devices

Jonathan Cameron (32):
      Input: pxspad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: adp5589-keys - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: cros-ec-keyb - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: cypress-sf - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ep39xx-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: gpio-keys - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ipaq-micro-keys - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: mpr121-touchkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: mtk-pmic-keys - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: qt1050 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: spear-keyboard - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: tm2-touchkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: lm8323 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: lpc32xx-keys - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: matrix-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: max7359-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: mcs-touchkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: nomadik-ske-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pmic8xxx-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pxa27x_keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: qt1070 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: sh-keysc - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: st-keyscan - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: tc3589x - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: tca6416-keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: tegra-kbc - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: tegra-kbc - allow build with COMPILE_TEST
      Input: spear-keyboard - improve build coverage using COMPILE_TEST
      Input: pxa27xx-keypad - allow build with COMPILE_TEST
      Input: nomadik-ske-keypad - allow building with COMPILE_TEST
      Input: lpc32xx - allow building with COMPILE_TEST
      Input: pxspad - fix unused data warning when force feedback not enabled

Luca Weiss (1):
      dt-bindings: input: Convert ti,drv260x to DT schema

Matti Vaittinen (1):
      fixp-arith: do not require users to include bug.h

Mika Penttilä (1):
      MAINTAINERS: change sis_i2c maintainer email address

Neil Armstrong (1):
      dt-bindings: input: qcom,pm8921-pwrkey: convert to dt-schema

Randy Dunlap (2):
      Input: joystick - fix Kconfig warning for JOYSTICK_ADC
      Input: wistron_btns - disable on UML

Raul E Rangel (9):
      HID: i2c-hid: Use PM subsystem to manage wake irq
      Input: elan_i2c - use PM subsystem to manage wake irq
      Input: elants_i2c - use PM subsystem to manage wake irq
      Input: raydium_ts_i2c - use PM subsystem to manage wake irq
      HID: i2c-hid: acpi: Stop setting wakeup_capable
      HID: i2c-hid: Don't set wake_capable and wake_irq
      Input: elan_i2c - don't set wake_capable and wake_irq
      Input: elants_i2c - don't set wake_capable and wake_irq
      Input: raydium_ts_i2c - don't set wake_capable and wake_irq

Siarhei Volkau (1):
      Input: matrix_keypad - force switch rows to input mode

Uwe Kleine-König (78):
      Input: max8997 - convert to modern way to get a reference to a PWM
      Input: as5011 - Convert to i2c's .probe_new()
      Input: adp5588-keys - Convert to i2c's .probe_new()
      Input: adp5589-keys - Convert to i2c's .probe_new()
      Input: cap11xx - Convert to i2c's .probe_new()
      Input: dlink-dir685-touchkeys - Convert to i2c's .probe_new()
      Input: lm8323 - Convert to i2c's .probe_new()
      Input: lm8333 - Convert to i2c's .probe_new()
      Input: max7359_keypad - Convert to i2c's .probe_new()
      Input: mcs_touchkey - Convert to i2c's .probe_new()
      Input: mpr121_touchkey - Convert to i2c's .probe_new()
      Input: qt1070 - Convert to i2c's .probe_new()
      Input: qt2160 - Convert to i2c's .probe_new()
      Input: tca6416-keypad - Convert to i2c's .probe_new()
      Input: tca8418_keypad - Convert to i2c's .probe_new()
      Input: tm2-touchkey - Convert to i2c's .probe_new()
      Input: ad714x-i2c - Convert to i2c's .probe_new()
      Input: adxl34x-i2c - Convert to i2c's .probe_new()
      Input: apanel - Convert to i2c's .probe_new()
      Input: atmel_captouch - Convert to i2c's .probe_new()
      Input: bma150 - Convert to i2c's .probe_new()
      Input: cma3000_d0x_i2c - Convert to i2c's .probe_new()
      Input: da7280 - Convert to i2c's .probe_new()
      Input: drv260x - Convert to i2c's .probe_new()
      Input: drv2665 - Convert to i2c's .probe_new()
      Input: drv2667 - Convert to i2c's .probe_new()
      Input: ibm-panel - Convert to i2c's .probe_new()
      Input: kxtj9 - Convert to i2c's .probe_new()
      Input: mma8450 - Convert to i2c's .probe_new()
      Input: pcf8574_keypad - Convert to i2c's .probe_new()
      Input: cyapa - Convert to i2c's .probe_new()
      Input: elan_i2c_core - Convert to i2c's .probe_new()
      Input: synaptics_i2c - Convert to i2c's .probe_new()
      Input: rmi_i2c - Convert to i2c's .probe_new()
      Input: rmi_smbus - Convert to i2c's .probe_new()
      Input: ad7879-i2c - Convert to i2c's .probe_new()
      Input: ar1021_i2c - Convert to i2c's .probe_new()
      Input: atmel_mxt_ts - Convert to i2c's .probe_new()
      Input: auo-pixcir-ts - Convert to i2c's .probe_new()
      Input: bu21013_ts - Convert to i2c's .probe_new()
      Input: bu21029_ts - Convert to i2c's .probe_new()
      Input: chipone_icn8318 - Convert to i2c's .probe_new()
      Input: cy8ctma140 - Convert to i2c's .probe_new()
      Input: cy8ctmg110_ts - Convert to i2c's .probe_new()
      Input: cyttsp4 - Convert to i2c's .probe_new()
      Input: cyttsp5: Convert to i2c's .probe_new()
      Input: cyttsp_i2c - Convert to i2c's .probe_new()
      Input: edt-ft5x06 - Convert to i2c's .probe_new()
      Input: eeti_ts - Convert to i2c's .probe_new()
      Input: egalax_ts - Convert to i2c's .probe_new()
      Input: ektf2127 - Convert to i2c's .probe_new()
      Input: goodix - Convert to i2c's .probe_new()
      Input: hideep - Convert to i2c's .probe_new()
      Input: hx83112b: Convert to i2c's .probe_new()
      Input: hycon-hy46xx - Convert to i2c's .probe_new()
      Input: ili210x - Convert to i2c's .probe_new()
      Input: ilitek_ts_i2c - Convert to i2c's .probe_new()
      Input: iqs5xx - Convert to i2c's .probe_new()
      Input: max11801_ts - Convert to i2c's .probe_new()
      Input: mcs5000_ts - Convert to i2c's .probe_new()
      Input: melfas_mip4 - Convert to i2c's .probe_new()
      Input: migor_ts - Convert to i2c's .probe_new()
      Input: mms114 - Convert to i2c's .probe_new()
      Input: pixcir_i2c_ts - Convert to i2c's .probe_new()
      Input: raydium_i2c_ts - Convert to i2c's .e_new()
      Input: rohm_bu21023 - Convert to i2c's .probe_new()
      Input: s6sy761 - Convert to i2c's .probe_new()
      Input: silead - Convert to i2c's .probe_new()
      Input: sis_i2c - Convert to i2c's .probe_new()
      Input: st1232 - Convert to i2c's .probe_new()
      Input: stmfts - Convert to i2c's .probe_new()
      Input: sx8654 - Convert to i2c's .probe_new()
      Input: tsc2004 - Convert to i2c's .probe_new()
      Input: tsc2007_core - Convert to i2c's .probe_new()
      Input: wacom_i2c - Convert to i2c's .probe_new()
      Input: wdt87xx_i2c - Convert to i2c's .probe_new()
      Input: zet6223 - Convert to i2c's .probe_new()
      Input: zforce_ts - Convert to i2c's .probe_new()

Vincent Knecht (6):
      Input: msg2638 - set max finger number and irqhandler from driver data
      dt-bindings: input: touchscreen: msg2638: Document msg2138 support
      Input: msg2638 - add support for msg2138
      dt-bindings: input: touchscreen: msg2638: Document keys support
      Input: msg2638 - add support for msg2138 key events
      Input: msg2638 - only read linux,keycodes array if necessary

Diffstat:
--------

 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   4 +-
 .../devicetree/bindings/input/azoteq,iqs7222.yaml  |  25 +-
 .../devicetree/bindings/input/gpio-beeper.txt      |  13 -
 .../devicetree/bindings/input/gpio-beeper.yaml     |  33 +
 .../bindings/input/qcom,pm8921-pwrkey.yaml         |  75 ++
 .../bindings/input/qcom,pm8xxx-pwrkey.txt          |  46 --
 .../devicetree/bindings/input/ti,drv260x.txt       |  50 --
 .../devicetree/bindings/input/ti,drv260x.yaml      | 109 +++
 .../input/touchscreen/cypress,tt21000.yaml         | 106 +++
 .../bindings/input/touchscreen/egalax-ts.txt       |   4 +-
 .../bindings/input/touchscreen/himax,hx83112b.yaml |  63 ++
 .../input/touchscreen/hynitron,cstxxx.yaml         |  65 ++
 .../bindings/input/touchscreen/mstar,msg2638.yaml  |   8 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 MAINTAINERS                                        |   9 +-
 arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   4 +-
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   8 +-
 arch/arm/mach-s3c/mach-crag6410.c                  |   1 +
 drivers/hid/hid-debug.c                            |   3 +
 drivers/hid/hid-input.c                            |   3 +
 drivers/hid/i2c-hid/i2c-hid-acpi.c                 |   5 -
 drivers/hid/i2c-hid/i2c-hid-core.c                 |  24 +-
 drivers/i2c/i2c-core-base.c                        |  14 +
 drivers/iio/adc/twl4030-madc.c                     |   1 +
 drivers/input/input.c                              |   3 +-
 drivers/input/joystick/Kconfig                     |   1 +
 drivers/input/joystick/as5011.c                    |   5 +-
 drivers/input/joystick/psxpad-spi.c                |   9 +-
 drivers/input/keyboard/Kconfig                     |  10 +-
 drivers/input/keyboard/adp5588-keys.c              |   5 +-
 drivers/input/keyboard/adp5589-keys.c              |  14 +-
 drivers/input/keyboard/cap11xx.c                   |   6 +-
 drivers/input/keyboard/cros_ec_keyb.c              |   6 +-
 drivers/input/keyboard/cypress-sf.c                |  10 +-
 drivers/input/keyboard/dlink-dir685-touchkeys.c    |   9 +-
 drivers/input/keyboard/ep93xx_keypad.c             |  10 +-
 drivers/input/keyboard/gpio_keys.c                 |   8 +-
 drivers/input/keyboard/ipaq-micro-keys.c           |  10 +-
 drivers/input/keyboard/lm8323.c                    |  11 +-
 drivers/input/keyboard/lm8333.c                    |   5 +-
 drivers/input/keyboard/lpc32xx-keys.c              |   8 +-
 drivers/input/keyboard/matrix_keypad.c             |  11 +-
 drivers/input/keyboard/max7359_keypad.c            |  11 +-
 drivers/input/keyboard/mcs_touchkey.c              |  14 +-
 drivers/input/keyboard/mpr121_touchkey.c           |  13 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  10 +-
 drivers/input/keyboard/nomadik-ske-keypad.c        |   8 +-
 drivers/input/keyboard/pmic8xxx-keypad.c           |   8 +-
 drivers/input/keyboard/pxa27x_keypad.c             |   8 +-
 drivers/input/keyboard/qt1050.c                    |   8 +-
 drivers/input/keyboard/qt1070.c                    |  11 +-
 drivers/input/keyboard/qt2160.c                    |   5 +-
 drivers/input/keyboard/sh_keysc.c                  |   8 +-
 drivers/input/keyboard/spear-keyboard.c            |   9 +-
 drivers/input/keyboard/st-keyscan.c                |   7 +-
 drivers/input/keyboard/stmpe-keypad.c              |   1 +
 drivers/input/keyboard/tc3589x-keypad.c            |   8 +-
 drivers/input/keyboard/tca6416-keypad.c            |  14 +-
 drivers/input/keyboard/tca8418_keypad.c            |   5 +-
 drivers/input/keyboard/tegra-kbc.c                 |   7 +-
 drivers/input/keyboard/tm2-touchkey.c              |  15 +-
 drivers/input/misc/Kconfig                         |   4 +-
 drivers/input/misc/ad714x-i2c.c                    |   5 +-
 drivers/input/misc/adxl34x-i2c.c                   |   5 +-
 drivers/input/misc/apanel.c                        |   5 +-
 drivers/input/misc/atmel_captouch.c                |   9 +-
 drivers/input/misc/bma150.c                        |   5 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |   5 +-
 drivers/input/misc/da7280.c                        |   5 +-
 drivers/input/misc/drv260x.c                       |   5 +-
 drivers/input/misc/drv2665.c                       |   5 +-
 drivers/input/misc/drv2667.c                       |   5 +-
 drivers/input/misc/ibm-panel.c                     |   5 +-
 drivers/input/misc/iqs7222.c                       | 504 +++++++-----
 drivers/input/misc/kxtj9.c                         |   5 +-
 drivers/input/misc/max8997_haptic.c                |   7 +-
 drivers/input/misc/mma8450.c                       |   5 +-
 drivers/input/misc/pcf8574_keypad.c                |   4 +-
 drivers/input/mouse/cyapa.c                        |   5 +-
 drivers/input/mouse/elan_i2c_core.c                |  20 +-
 drivers/input/mouse/synaptics_i2c.c                |   5 +-
 drivers/input/rmi4/rmi_i2c.c                       |   5 +-
 drivers/input/rmi4/rmi_smbus.c                     |   5 +-
 drivers/input/touchscreen/Kconfig                  |  42 +-
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/ad7879-i2c.c             |   5 +-
 drivers/input/touchscreen/ar1021_i2c.c             |   5 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   4 +-
 drivers/input/touchscreen/auo-pixcir-ts.c          |   5 +-
 drivers/input/touchscreen/bu21013_ts.c             |   5 +-
 drivers/input/touchscreen/bu21029_ts.c             |   5 +-
 drivers/input/touchscreen/chipone_icn8318.c        |   5 +-
 drivers/input/touchscreen/cy8ctma140.c             |   5 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c          |   5 +-
 drivers/input/touchscreen/cyttsp4_i2c.c            |   5 +-
 drivers/input/touchscreen/cyttsp5.c                | 900 +++++++++++++++++++++
 drivers/input/touchscreen/cyttsp_i2c.c             |   5 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   6 +-
 drivers/input/touchscreen/eeti_ts.c                |   5 +-
 drivers/input/touchscreen/egalax_ts.c              |  54 +-
 drivers/input/touchscreen/ektf2127.c               |   5 +-
 drivers/input/touchscreen/elants_i2c.c             |  28 +-
 drivers/input/touchscreen/goodix.c                 |   5 +-
 drivers/input/touchscreen/hideep.c                 |   5 +-
 drivers/input/touchscreen/himax_hx83112b.c         | 364 +++++++++
 drivers/input/touchscreen/hycon-hy46xx.c           |   5 +-
 drivers/input/touchscreen/hynitron_cstxxx.c        | 498 ++++++++++++
 drivers/input/touchscreen/ili210x.c                |   6 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   5 +-
 drivers/input/touchscreen/iqs5xx.c                 |   5 +-
 drivers/input/touchscreen/max11801_ts.c            |   5 +-
 drivers/input/touchscreen/mcs5000_ts.c             |   5 +-
 drivers/input/touchscreen/melfas_mip4.c            |   4 +-
 drivers/input/touchscreen/migor_ts.c               |   5 +-
 drivers/input/touchscreen/mms114.c                 |   5 +-
 drivers/input/touchscreen/msg2638.c                | 197 ++++-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   6 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |  12 +-
 drivers/input/touchscreen/rohm_bu21023.c           |   5 +-
 drivers/input/touchscreen/s6sy761.c                |   5 +-
 drivers/input/touchscreen/silead.c                 |   6 +-
 drivers/input/touchscreen/sis_i2c.c                |   5 +-
 drivers/input/touchscreen/st1232.c                 |   6 +-
 drivers/input/touchscreen/stmfts.c                 |   5 +-
 drivers/input/touchscreen/sx8654.c                 |   6 +-
 drivers/input/touchscreen/tps6507x-ts.c            |   2 -
 drivers/input/touchscreen/tsc2004.c                |   5 +-
 drivers/input/touchscreen/tsc2007_core.c           |   6 +-
 drivers/input/touchscreen/wacom_i2c.c              |   5 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   5 +-
 drivers/input/touchscreen/zet6223.c                |   5 +-
 drivers/input/touchscreen/zforce_ts.c              |   5 +-
 include/linux/fixp-arith.h                         |   1 +
 include/linux/i2c.h                                |   1 +
 include/linux/mfd/max8997.h                        |   3 -
 include/uapi/linux/input-event-codes.h             |   3 +
 136 files changed, 3113 insertions(+), 809 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/gpio-beeper.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-beeper.yaml
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8921-pwrkey.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-pwrkey.txt
 delete mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.txt
 create mode 100644 Documentation/devicetree/bindings/input/ti,drv260x.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/cypress,tt21000.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/himax,hx83112b.yaml
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/hynitron,cstxxx.yaml
 create mode 100644 drivers/input/touchscreen/cyttsp5.c
 create mode 100644 drivers/input/touchscreen/himax_hx83112b.c
 create mode 100644 drivers/input/touchscreen/hynitron_cstxxx.c

Thanks.


-- 
Dmitry
