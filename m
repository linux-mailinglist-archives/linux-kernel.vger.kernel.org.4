Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A35F9879
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 08:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbiJJGoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 02:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbiJJGn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 02:43:58 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F7D94E877;
        Sun,  9 Oct 2022 23:43:57 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id q10-20020a17090a304a00b0020b1d5f6975so8478146pjl.0;
        Sun, 09 Oct 2022 23:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=baYJeJVbQDrNkkET09we7QWAxR0rQAusNrI+GinuNRc=;
        b=YcziNhB8wV1Csd5wJNrwe+S8HiXq0ErtbfF2VPSwQDqAjZqt81BNuMmryRWJyiPSeX
         rikLmFUR/gXVfBUHzvfMGNVpP1fQWGX5hN0xoa8RIYwrEvMOQ2JzQGgLc8k2jQFpmKBl
         cW9ytlSUR8WD0d4mr0zNbEjWc7ZbUiQVQXNZEW/4JvifT072nsJx989BPm0mbRej6eqe
         Q9u1Di38EQa5xIwaaBLY+wFb2SLVRtJ5+GWZly+xqA0vniuUbuDjrVEfU3RA3XcbWItL
         SvQoS1iYZu0dre0aMiprzznuvMPFoNxe3ZDQbeAMzrDKc1gYQl8aOG30p1UAG3KGVddP
         wg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=baYJeJVbQDrNkkET09we7QWAxR0rQAusNrI+GinuNRc=;
        b=xXZ+0PmqNO3WXj3vzRPNBOQ3pPkc8+223EF0/2FsdUVCsn6XHxGBjvyj6sUgLNARXO
         Cl2mwvyFqPd7YGSGCYveXo8IGzYSFlvmqmZkuQ/p3ymmcJFVd8eWKk7OFHxdtC5tmo1t
         WZpgsX3xyy4vAjOu6WrxNigIeiUUFN8LLzR0y/JDHXSO/DbAqN3NppoMqAb0zYwNd5U2
         uQHKpfl2nAYFLygloImsI8LXxMEVfHXXfIv8dCP3qkwGVsAip4cMxKRFvPk+6jVvNPtJ
         lsZ5x8stq5tP0ubeG99Uk+iexEoxdVV4jF+eQ9OVE07nH8X5BprqGmrUUd/KEzTLNdF7
         PSXA==
X-Gm-Message-State: ACrzQf0khddaqFkjR7odwV37HUNoVuTqhvGV3jISFQhillceiWrOQGhT
        Qyi3Z0bZs7MZPM2qy3d6t1CE7carYb8=
X-Google-Smtp-Source: AMsMyM5DOaCfxkjEWU6r1g9k+LfWyMsryoXkYZsON0GOXBM+o2DB9uh9H6aCYyrgfU65eJ8098ZAVg==
X-Received: by 2002:a17:90a:4fe4:b0:20a:629c:e854 with SMTP id q91-20020a17090a4fe400b0020a629ce854mr30820005pjh.30.1665384236288;
        Sun, 09 Oct 2022 23:43:56 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:1bd8:541a:735e:92d5])
        by smtp.gmail.com with ESMTPSA id f9-20020a636a09000000b004277f43b736sm5504759pgc.92.2022.10.09.23.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Oct 2022 23:43:55 -0700 (PDT)
Date:   Sun, 9 Oct 2022 23:43:53 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.1-rc0
Message-ID: <Y0O/KXxdj2gc4Sw+@google.com>
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.1-rc0

to receive updates for the input subsystem. You will get:

- a new driver for IBM Operational Panel
- a new driver for PinePhone keyboards
- RT5120 PMIC power key support
- various enhancements and support for new models in xpad (Xbox) driver
- a new compatible ID for Elan touchscreen driver
- rework of adp5588-keys driver to support configuring via device
  properties (OF, ACPI, etc) instead of platform data, and proper support
  of optional gpiochip functionality (and removal of gpio-adp5588 driver)
- improvements to firmware update handling in Synaptics RMI4 driver
- support for double key matrix in mt6779-keypad
- support for polled mode in adc-joystick driver
- other assorted driver fixes, cleanups and improvements.

Changelog:
---------

Andy Shevchenko (4):
      Input: clps711x-keypad - get rid of OF_GPIO dependency
      Input: matrix_keypad - replace of_gpio_named_count() by gpiod_count()
      Input: matrix_keypad - add missed header inclusion
      Input: icn8505 - utilize acpi_get_subsystem_id()

AngeloGioacchino Del Regno (3):
      Input: mtk-pmic-keys - add support for MT6331 PMIC keys
      dt-bindings: input: Convert mtk-pmic-keys to DT schema
      dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys

Cameron Gutman (1):
      Input: xpad - fix wireless 360 controller breaking after suspend

ChiYuan Huang (1):
      Input: rt5120 - add power key support

Chris Morgan (2):
      dt-bindings: adc-joystick: add poll-interval
      Input: adc-joystick - add polled input device support

Christophe JAILLET (2):
      Input: bma150 - fix a typo in some comments
      input: drop empty comment blocks

Christopher Crockett (1):
      Input: xpad - add support for XBOX One Elite paddles

Colin Ian King (3):
      Input: tc3589x-keypad - use correct struct names in comment
      Input: applespi - use correct struct names in comment
      Input: ims-pcu - fix spelling mistake "BOOLTLOADER" -> "BOOTLOADER"

Dmitry Torokhov (14):
      Input: atkbd - switch to using dev_groups for driver-specific attributes
      Input: psmouse - switch to using dev_groups for driver-specific attributes
      Input: aiptek - switch to using dev_groups for driver-specific attributes
      Input: auo-pixcir-ts - drop support for platform data
      Input: auo-pixcir-ts - switch to using gpiod API
      Input: auo-pixcir-ts - do not force rising edge interrupt trigger
      Input: auo-pixcir-ts - switch to using generic device properties
      dt-bindings: input: auo-pixcir-ts: fix gpio and interrupt properties
      Input: lm8333 - add missing linux/input.h include
      Input: st-keyscan - add missing linux/input.h and linux/of.h includes
      Input: mt6779-keypad - add missing linux/input.h include
      Input: imx_keypad - add missing linux/input.h include
      Input: ep93xx_keypad - add missing linux/input.h include
      Input: twl4030-pwrbutton - add missing of.h include

Eddie James (2):
      dt-bindings: input: Add documentation for IBM Operation Panel
      Input: Add IBM Operation Panel driver

Francesco Dolcini (1):
      dt-bindings: input: touchscreen: stmpe: Remove node name requirement

Greg Kroah-Hartman (1):
      Input: elan_i2c - convert to use dev_groups

Gustavo A. R. Silva (1):
      Input: applespi - replace zero-length array with DECLARE_FLEX_ARRAY() helper

Huacai Chen (2):
      Input: i8042 - rename i8042-x86ia64io.h to i8042-acpipnpio.h
      Input: i8042 - add LoongArch support in i8042-acpipnpio.h

Jason Wang (1):
      Input: joydev - fix comment typo

Jeff LaBundy (3):
      Input: iqs7222 - trim force communication command
      Input: iqs7222 - avoid sending empty SYN_REPORT events
      Input: iqs7222 - set all ULP entry masks by default

Liang He (1):
      Input: i8042 - fix refount leak on sparc

Luca Weiss (1):
      dt-bindings: input: qcom,pm8xxx-vib: convert to yaml

Lyude Paul (1):
      Input: synaptics - enable InterTouch for the ThinkPad P1 G3

Matthias Schiffer (9):
      Input: synaptics-rmi4 - fix firmware update operations with bootloader v8
      Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status() helper
      Input: synaptics-rmi4 - fix command completion check for bootloader v7/v8
      Input: synaptics-rmi4 - rewrite partition table unconditionally
      Input: synaptics-rmi4 - reset after writing partition table
      Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all" command
      Input: synaptics-rmi4 - remove unneeded struct register_offset
      Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
      Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()

Mattijs Korpershoek (5):
      MAINTAINERS: input: add mattijs for mt6779-keypad
      dt-bindings: mediatek,mt6779-keypad: use unevaluatedProperties
      dt-bindings: mediatek,mt6779-keypad: add mediatek,keys-per-group
      Input: mt6779-keypad - prepare double keys support with calc_row_col
      Input: mt6779-keypad - support double keys matrix

Max Krummenacher (2):
      Input: colibri-vf50-ts - don't depend on VF610_ADC
      dt-bindings: input: colibri-vf50-ts: Improve documentation

Nate Yocom (4):
      Input: xpad - add X-Box Adaptive support
      Input: xpad - add X-Box Adaptive XBox button
      Input: add ABS_PROFILE to uapi and documentation
      Input: xpad - add X-Box Adaptive Profile button

Nuno Sá (10):
      Input: adp5588-keys - support gpi key events as 'gpio keys'
      gpio: gpio-adp5588: drop the driver
      Input: adp5588-keys - bail out on returned error
      Input: adp5588-keys - add support for fw properties
      dt-bindings: input: adp5588: add bindings
      Input: adp5588-keys - do not check for irq presence
      Input: adp5588-keys - fix coding style warnings
      Input: adp5588-keys - add optional reset gpio
      Input: adp5588-keys - add regulator support
      Input: adp5588-keys - use new PM macros

Pavel Rojtberg (3):
      Input: xpad - add supported devices as contributed on github
      Input: xpad - refactor using BIT() macro
      Input: xpad - decipher xpadone packages with GIP defines

Peter Ujfalusi (1):
      Input: twl4030-vibra - drop legacy, non DT boot support

Rob Herring (1):
      dt-bindings: input: Convert hid-over-i2c to DT schema

Samuel Holland (3):
      dt-bindings: input: Add the PinePhone keyboard binding
      Input: pinephone-keyboard - add PinePhone keyboard driver
      Input: pinephone-keyboard - support the proxied I2C bus

Santosh De Massari (1):
      Input: xpad - Poweroff XBOX360W on mode button long press

Wolfram Sang (2):
      Input: move from strlcpy with unused retval to strscpy
      Input: gameport - move from strlcpy with unused retval to strscpy

Yunlong Jia (1):
      dt-bindings: input: touchscreen: elants_i2c: Add compatible for eth3915n chip

Zeng Heng (1):
      Input: ibm-panel - add missing MODULE_DEVICE_TABLE

wangjianli (1):
      Input: hgpk - fix repeated word in a comment

zhang songyi (1):
      Input: synaptics-rmi4 - convert to use sysfs_emit() APIs

Diffstat:
--------

 .../devicetree/bindings/input/adc-joystick.yaml    |   5 +
 .../devicetree/bindings/input/adi,adp5588.yaml     | 111 ++++
 .../devicetree/bindings/input/hid-over-i2c.txt     |  46 --
 .../devicetree/bindings/input/hid-over-i2c.yaml    |  83 +++
 .../devicetree/bindings/input/ibm,op-panel.yaml    |  50 ++
 .../bindings/input/mediatek,mt6779-keypad.yaml     |   8 +-
 .../bindings/input/mediatek,pmic-keys.yaml         | 114 ++++
 .../devicetree/bindings/input/mtk-pmic-keys.txt    |  46 --
 .../bindings/input/pine64,pinephone-keyboard.yaml  |  66 ++
 .../devicetree/bindings/input/qcom,pm8xxx-vib.txt  |  23 -
 .../devicetree/bindings/input/qcom,pm8xxx-vib.yaml |  38 ++
 .../bindings/input/touchscreen/auo_pixcir_ts.txt   |   6 +-
 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  16 +-
 .../input/touchscreen/elan,elants_i2c.yaml         |  10 +-
 .../bindings/input/touchscreen/stmpe.txt           |   3 +-
 Documentation/input/event-codes.rst                |   6 +
 Documentation/input/gamepad.rst                    |   6 +
 MAINTAINERS                                        |  21 +-
 drivers/gpio/Kconfig                               |  14 -
 drivers/gpio/Makefile                              |   1 -
 drivers/gpio/gpio-adp5588.c                        | 446 -------------
 drivers/hid/hid-debug.c                            |   3 +-
 drivers/input/ff-core.c                            |   3 -
 drivers/input/ff-memless.c                         |   3 -
 drivers/input/gameport/emu10k1-gp.c                |   3 -
 drivers/input/gameport/lightning.c                 |   3 -
 drivers/input/gameport/ns558.c                     |   3 -
 drivers/input/joydev.c                             |   2 +-
 drivers/input/joystick/a3d.c                       |   3 -
 drivers/input/joystick/adc-joystick.c              |  65 +-
 drivers/input/joystick/adi.c                       |   3 -
 drivers/input/joystick/amijoy.c                    |   3 -
 drivers/input/joystick/analog.c                    |   3 -
 drivers/input/joystick/cobra.c                     |   3 -
 drivers/input/joystick/db9.c                       |   3 -
 drivers/input/joystick/gamecon.c                   |   3 -
 drivers/input/joystick/gf2k.c                      |   3 -
 drivers/input/joystick/grip.c                      |   3 -
 drivers/input/joystick/guillemot.c                 |   3 -
 drivers/input/joystick/interact.c                  |   3 -
 drivers/input/joystick/joydump.c                   |   3 -
 drivers/input/joystick/magellan.c                  |   3 -
 drivers/input/joystick/sidewinder.c                |   3 -
 drivers/input/joystick/spaceball.c                 |   3 -
 drivers/input/joystick/spaceorb.c                  |   3 -
 drivers/input/joystick/stinger.c                   |   3 -
 drivers/input/joystick/tmdc.c                      |   3 -
 drivers/input/joystick/turbografx.c                |   3 -
 drivers/input/joystick/twidjoy.c                   |   3 -
 drivers/input/joystick/warrior.c                   |   3 -
 drivers/input/joystick/xpad.c                      | 455 +++++++++----
 drivers/input/joystick/zhenhua.c                   |   3 -
 drivers/input/keyboard/Kconfig                     |  18 +-
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/adp5588-keys.c              | 726 ++++++++++++++-------
 drivers/input/keyboard/amikbd.c                    |   3 -
 drivers/input/keyboard/applespi.c                  |   4 +-
 drivers/input/keyboard/atakbd.c                    |   3 -
 drivers/input/keyboard/atkbd.c                     |  16 +-
 drivers/input/keyboard/clps711x-keypad.c           |  13 +-
 drivers/input/keyboard/ep93xx_keypad.c             |   1 +
 drivers/input/keyboard/imx_keypad.c                |   1 +
 drivers/input/keyboard/lkkbd.c                     |  11 +-
 drivers/input/keyboard/lm8333.c                    |   8 +-
 drivers/input/keyboard/matrix_keypad.c             |   7 +-
 drivers/input/keyboard/mt6779-keypad.c             |  46 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  21 +
 drivers/input/keyboard/newtonkbd.c                 |   3 -
 drivers/input/keyboard/pinephone-keyboard.c        | 468 +++++++++++++
 drivers/input/keyboard/st-keyscan.c                |  10 +-
 drivers/input/keyboard/stowaway.c                  |   3 -
 drivers/input/keyboard/sunkbd.c                    |   3 -
 drivers/input/keyboard/tc3589x-keypad.c            |   2 +-
 drivers/input/keyboard/xtkbd.c                     |   3 -
 drivers/input/misc/Kconfig                         |  27 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/ibm-panel.c                     | 200 ++++++
 drivers/input/misc/ims-pcu.c                       |   2 +-
 drivers/input/misc/iqs7222.c                       |  16 +-
 drivers/input/misc/keyspan_remote.c                |   2 +-
 drivers/input/misc/rt5120-pwrkey.c                 | 120 ++++
 drivers/input/misc/twl4030-pwrbutton.c             |   1 +
 drivers/input/misc/twl4030-vibra.c                 |  13 +-
 drivers/input/mouse/elan_i2c_core.c                |   7 +-
 drivers/input/mouse/hgpk.c                         |   4 +-
 drivers/input/mouse/inport.c                       |   3 -
 drivers/input/mouse/logibm.c                       |   3 -
 drivers/input/mouse/pc110pad.c                     |   3 -
 drivers/input/mouse/psmouse-base.c                 |  22 +-
 drivers/input/mouse/sermouse.c                     |   3 -
 drivers/input/mouse/synaptics.c                    |   5 +-
 drivers/input/mouse/synaptics_usb.c                |   2 +-
 drivers/input/mouse/vsxxxaa.c                      |   7 +-
 drivers/input/rmi4/rmi_f03.c                       |   2 +-
 drivers/input/rmi4/rmi_f34.c                       |  32 +-
 drivers/input/rmi4/rmi_f34.h                       |  17 -
 drivers/input/rmi4/rmi_f34v7.c                     | 349 +++-------
 drivers/input/rmi4/rmi_f54.c                       |   8 +-
 drivers/input/serio/altera_ps2.c                   |   4 +-
 drivers/input/serio/ambakmi.c                      |   4 +-
 drivers/input/serio/ams_delta_serio.c              |   4 +-
 drivers/input/serio/apbps2.c                       |   2 +-
 drivers/input/serio/ct82c710.c                     |   5 +-
 drivers/input/serio/gscps2.c                       |   2 +-
 drivers/input/serio/hyperv-keyboard.c              |   4 +-
 .../serio/{i8042-x86ia64io.h => i8042-acpipnpio.h} |  18 +-
 drivers/input/serio/i8042-sparcio.h                |  27 +-
 drivers/input/serio/i8042.c                        |  14 +-
 drivers/input/serio/i8042.h                        |   4 +-
 drivers/input/serio/olpc_apsp.c                    |   8 +-
 drivers/input/serio/parkbd.c                       |   2 +-
 drivers/input/serio/pcips2.c                       |   4 +-
 drivers/input/serio/ps2-gpio.c                     |   4 +-
 drivers/input/serio/ps2mult.c                      |   2 +-
 drivers/input/serio/q40kbd.c                       |   7 +-
 drivers/input/serio/rpckbd.c                       |   7 +-
 drivers/input/serio/sa1111ps2.c                    |   4 +-
 drivers/input/serio/serio.c                        |   3 -
 drivers/input/serio/serport.c                      |   2 +-
 drivers/input/serio/sun4i-ps2.c                    |   4 +-
 drivers/input/tablet/acecad.c                      |   5 +-
 drivers/input/tablet/aiptek.c                      |  20 +-
 drivers/input/tablet/hanwang.c                     |   5 +-
 drivers/input/tablet/pegasus_notetaker.c           |   2 +-
 drivers/input/touchscreen/Kconfig                  |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   8 +-
 drivers/input/touchscreen/auo-pixcir-ts.c          | 155 ++---
 drivers/input/touchscreen/chipone_icn8505.c        |  30 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  12 +-
 drivers/input/touchscreen/gunze.c                  |   3 -
 drivers/input/touchscreen/sur40.c                  |   6 +-
 drivers/input/touchscreen/usbtouchscreen.c         |   2 +-
 drivers/input/touchscreen/wacom_w8001.c            |   6 +-
 include/linux/bma150.h                             |   4 +-
 include/linux/gameport.h                           |   2 +-
 include/linux/input/auo-pixcir-ts.h                |  44 --
 include/linux/platform_data/adp5588.h              | 171 -----
 include/uapi/linux/input-event-codes.h             |   1 +
 138 files changed, 2633 insertions(+), 1926 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/adi,adp5588.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.txt
 create mode 100644 Documentation/devicetree/bindings/input/hid-over-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/input/ibm,op-panel.yaml
 create mode 100644 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/pine64,pinephone-keyboard.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
 delete mode 100644 drivers/gpio/gpio-adp5588.c
 create mode 100644 drivers/input/keyboard/pinephone-keyboard.c
 create mode 100644 drivers/input/misc/ibm-panel.c
 create mode 100644 drivers/input/misc/rt5120-pwrkey.c
 rename drivers/input/serio/{i8042-x86ia64io.h => i8042-acpipnpio.h} (99%)
 delete mode 100644 include/linux/input/auo-pixcir-ts.h
 delete mode 100644 include/linux/platform_data/adp5588.h

Thanks.


-- 
Dmitry
