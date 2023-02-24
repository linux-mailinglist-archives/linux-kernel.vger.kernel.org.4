Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D77106A16B5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 07:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjBXGoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 01:44:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXGoo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 01:44:44 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC8115543;
        Thu, 23 Feb 2023 22:44:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id pt11so16132064pjb.1;
        Thu, 23 Feb 2023 22:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMvJ+9R2IXvA+3E7x4xUQqSXCUz52mWqnaflQKOuAPc=;
        b=OCNK6YPbSOFDRpsR7w/FtXKFA822GS+sFJImmMSnfz1mcH22URF8hFiQdPcEkSX8rd
         mqnYe8ayYAHmj0/cz15Md8aiLs0FPH8Nx0f6kXJYsI4+5i6jUgg2d64N7WdmMxy2KbIW
         PqZIK5ZLQlmmTzs6xeqISpigMqdfIOT5ESLnQVbqEePRl5AO4plRd3srEhhMV3lDRoIM
         KVtLlt/nXOPF6H6h5n4jnueSceJTbp/jw6B+ZJeCgfQ6ldExiF9foUKO9stdb4U2iH4H
         IehyTqtP0DUfuYVyh8wGlmxTS+pXt1lybr7fEdhR5g2zSV0JRO0RHZZ5UMHRFyMr1nc+
         6fcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WMvJ+9R2IXvA+3E7x4xUQqSXCUz52mWqnaflQKOuAPc=;
        b=wlaQKF5y7xR2CC9NWMq9KyPw9FlUmaKyDiuu5MgXop2SL3v1UfGI/gKipQFBDpPB9z
         g/tk5EX2OruMMN3PB9ttmuU9uQUREKpVOgf8j0y+2FYpj27w1tlYCMJrUtuykXSf/jkh
         ow0GVOpTXEKqY52mFUOpnSEvNPd3MV62buZu9CWH0aTiKQGuSrGGhrc2ynnCf62CEsDk
         t67IXszLie8H3l9iqpxL8DVQWZ7cpQoaSwVBVnoVUXK5gTR9xD09looEgR6ueY03FWuR
         6WG1TYic5iaamPJQSgK9zW/U/oTaplretoRhT/ye0AqLx9ElvAR11CC7rJ4Aupt2YNJh
         n2sQ==
X-Gm-Message-State: AO0yUKW88EWOfdy5Krs5fd4NxSqGy39b0oKOEtjU8o2F/R4LYSGU0UPr
        YLH16hOgBLWHcGTdg08hN3HQZbrJdOc=
X-Google-Smtp-Source: AK7set//D/0TMj1Rc5Z25UnXWTY6BAu4hejMwKbxaW9VRaYNtx/i/gSv+WyoDdh71ze3uq5rnZE86g==
X-Received: by 2002:a17:90b:4c87:b0:234:b35b:f8e7 with SMTP id my7-20020a17090b4c8700b00234b35bf8e7mr14874253pjb.7.1677221081191;
        Thu, 23 Feb 2023 22:44:41 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:376e:8f04:aec6:9d37])
        by smtp.gmail.com with ESMTPSA id q89-20020a17090a756200b0022bfcf5d297sm792868pjk.9.2023.02.23.22.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 22:44:40 -0800 (PST)
Date:   Thu, 23 Feb 2023 22:44:37 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
Subject: [git pull] Input updates for v6.3-rc0
Message-ID: <Y/hc1bPMmOlD+vW2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git tags/input-for-v6.3-rc0

to receive updates for the input subsystem. You will get:

- a set of tweaks to iqs269a touch controller driver
- a fix for ads7846 driver to properly handle 7845 chip
- cap11xx driver will support cap1203, cap1293 and cap1298 models
- xpad driver will support 8BitDo Pro 2 Wired Controller
- input drivers have been switched to DEFINE_SIMPLE_DEV_PM_OPS()
  and pm_sleep_ptr()
- other miscellaneous fixes and tweaks

Note that you will get a merge conflict with ucb1400_ts driver that was
removed by Arnd.

Changelog:
---------

Arnd Bergmann (1):
      Input: ipaq-micro-ts - fix DEFINE_SIMPLE_DEV_PM_OPS typo

Dario Binacchi (1):
      Input: edt-ft5x06 - fix typo in a comment

Dmitry Torokhov (1):
      Input: exc3000 - properly stop timer on shutdown

Jeff LaBundy (7):
      Input: iqs269a - drop unused device node references
      Input: iqs269a - increase interrupt handler return delay
      Input: iqs269a - configure device with a single block write
      Input: iqs269a - do not poll during suspend or resume
      Input: iqs269a - do not poll during ATI
      Input: iqs626a - drop unused device node references
      dt-bindings: input: iqs626a: Redefine trackpad property types

Jiri Valek - 2N (2):
      dt-bindings: input: microchip,cap11xx: add cap1203, cap1293 and cap1298
      Input: cap11xx - add support for cap1203, cap1293 and cap1298

John Butler (1):
      Input: xpad - add 8BitDo Pro 2 Wired Controller support

Jonathan Cameron (85):
      Input: 88pm860x - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: da7280 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: drv260x - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: drv2665 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: drv2667 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: e3x0-button - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: gpio-vibra - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: iqs269a - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: iqs626a - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: kxtj9 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: max77693-haptic - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: max8925_onkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: max8997_haptic - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: palmas-pwrbutton - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pcfg8574_keypad - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pm8941-pwrkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pm8xxx-vibrator - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pmic8xxx-pwrkey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pwm-beeper - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pwm-vibra - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: regulator-haptic - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: rotary-encoder - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: stpmic1_onekey - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: twl4030-vibra - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: twl6030-vibra - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: elan_i2c_core - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: navpoint - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: synaptics_i2c - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ambakmi - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ad7877 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ads7846 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ar1021 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: atmel_mxt_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: auo-pixcir-ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: bu21013_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: bu21029 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: chipone_in8318 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: chipone_icn8505 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: cy8ctma140 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: cy8ctmg110_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: edt-ft5x06 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: eeti_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: egalax_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      input: ektf2127 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: elants_i2c - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: goodix - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: hideep - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ilitek_ts_i2c - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: imagis - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: imx6ul_tsc - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: iqs5xx - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: mcs5000_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: melfas_mip4 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      input: migor_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: mms114 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: msg2638 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: pixcir_i2c_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: raydium_i2c_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: silead - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: st1232 - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: surface3_spi - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ti_am335x_tsc - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ucb1400_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: wacom_i2c - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: wdt87xx_i2c - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: wm97xx - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: zforce_ts - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: zinitix - switch to DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: ipaq-micro-ts - use DEFINE_SIMPLE_DEV_PM_OPS() and pm_sleep_ptr()
      Input: cyapa - switch to SYSTEM_SLEEP/RUNTIME_PM_OPS() and pm_ptr()
      Input: axp20x-pek - switch to SYSTEM_SLEEP_PM_OPS() and pm_sleep_ptr()
      Input: samsung-keypad - switch to pm_ptr() and SYSTEM_SLEEP/RUNTIME_PM_OPS()
      Input: s6sy761 - switch to SYSTEM_SLEEP_/RUNTIME_PM_OPS() and pm_ptr()
      Input: rmi4 - switch to SYSTEM_SLEEP/RUNTIME_PM_OPS() and pm_ptr()
      Input: stmfts - switch to SYSTEM_SLEEP_/RUNTIME_PM_OPS() and pm_ptr()
      Input: ad714x - unify dev_pm_ops using EXPORT_SIMPLE_DEV_PM_OPS()
      Input: adxl34x - unify dev_pm_ops using EXPORT_SIMPLE_DEV_PM_OPS()
      Input: tsc200x - use EXPORT_GPL_SIMPLE_DEV_PM_OPS()
      Input: cyttsp4 - use EXPORT_GPL_RUNTIME_DEV_PM_OPS()
      Input: cyttsp - use EXPORT_GPL_SIMPLE_DEV_PM_OPS()
      Input: applespi - use pm_sleep_ptr() and SYSTEM_SLEEP_PM_OPS()
      Input: omap4-keyad - use pm_ptr() and RUNTIME_DEV_PM_OPS()
      Input: Use pm_sleep_ptr() to avoid need for ifdef CONFIG_PM_SLEEP
      Input: cma3000 - use pm_sleep_ptr() to allow removal of ifdef CONFIG_PM guards
      Input: wistron_btns - use pm_sleep_ptr() to allow removal of ifdef CONFIG_PM guards

Krzysztof Kozlowski (1):
      dt-bindings: input: touchscreen: st,stmfts: convert to dtschema

Luca Ellero (3):
      Input: ads7846 - don't report pressure for ads7845
      Input: ads7846 - always set last command to PWRDOWN
      Input: ads7846 - don't check penirq immediately for 7845

Randy Dunlap (1):
      Input: pmic8xxx-keypad - fix a Kconfig spelling mistake & hyphenation

Rayyan Ansari (1):
      Input: synaptics-rmi4 - fix SPI device ID

Richard Kjerstadius (1):
      Input: cyttsp5 - fix bitmask for touch buttons

joewu (吳仲振) (1):
      Input: cros_ec_keyb - add 3 buttons for monitor function

ye xingchen (7):
      Input: altera_ps2 - use devm_platform_get_and_ioremap_resource()
      Input: apbps2 - use devm_platform_get_and_ioremap_resource()
      Input: arc_ps2 - use devm_platform_get_and_ioremap_resource()
      Input: olpc_apsp - use devm_platform_get_and_ioremap_resource()
      Input: spear-keyboard - use devm_platform_get_and_ioremap_resource()
      Input: st-keyscan - use devm_platform_get_and_ioremap_resource()
      Input: tegra-kbc - use devm_platform_get_and_ioremap_resource()

Diffstat:
--------

 .../devicetree/bindings/input/iqs626a.yaml         |  94 ++++--
 .../bindings/input/microchip,cap11xx.yaml          |   3 +
 .../bindings/input/touchscreen/st,stmfts.txt       |  41 ---
 .../bindings/input/touchscreen/st,stmfts.yaml      |  72 +++++
 drivers/input/input.c                              |   7 +-
 drivers/input/joystick/xpad.c                      |   2 +
 drivers/input/keyboard/Kconfig                     |   2 +-
 drivers/input/keyboard/applespi.c                  |  10 +-
 drivers/input/keyboard/cap11xx.c                   |  19 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  15 +
 drivers/input/keyboard/omap4-keypad.c              |   6 +-
 drivers/input/keyboard/samsung-keypad.c            |  12 +-
 drivers/input/keyboard/spear-keyboard.c            |   4 +-
 drivers/input/keyboard/st-keyscan.c                |   4 +-
 drivers/input/keyboard/tegra-kbc.c                 |   4 +-
 drivers/input/misc/88pm860x_onkey.c                |   9 +-
 drivers/input/misc/ad714x-i2c.c                    |  14 +-
 drivers/input/misc/ad714x-spi.c                    |  14 +-
 drivers/input/misc/ad714x.c                        |  12 +-
 drivers/input/misc/ad714x.h                        |   4 +-
 drivers/input/misc/adxl34x-i2c.c                   |  25 +-
 drivers/input/misc/adxl34x-spi.c                   |  25 +-
 drivers/input/misc/adxl34x.c                       |  16 +-
 drivers/input/misc/adxl34x.h                       |   4 +-
 drivers/input/misc/axp20x-pek.c                    |  12 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |   6 +-
 drivers/input/misc/da7280.c                        |   8 +-
 drivers/input/misc/drv260x.c                       |   8 +-
 drivers/input/misc/drv2665.c                       |   8 +-
 drivers/input/misc/drv2667.c                       |   8 +-
 drivers/input/misc/e3x0-button.c                   |  10 +-
 drivers/input/misc/gpio-vibra.c                    |  10 +-
 drivers/input/misc/iqs269a.c                       | 335 ++++++++-------------
 drivers/input/misc/iqs626a.c                       | 164 +++++-----
 drivers/input/misc/kxtj9.c                         |   8 +-
 drivers/input/misc/max77693-haptic.c               |  11 +-
 drivers/input/misc/max8925_onkey.c                 |   9 +-
 drivers/input/misc/max8997_haptic.c                |   7 +-
 drivers/input/misc/palmas-pwrbutton.c              |  10 +-
 drivers/input/misc/pcf8574_keypad.c                |  16 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  10 +-
 drivers/input/misc/pm8xxx-vibrator.c               |   6 +-
 drivers/input/misc/pmic8xxx-pwrkey.c               |   8 +-
 drivers/input/misc/pwm-beeper.c                    |  10 +-
 drivers/input/misc/pwm-vibra.c                     |  10 +-
 drivers/input/misc/regulator-haptic.c              |   8 +-
 drivers/input/misc/rotary_encoder.c                |  10 +-
 drivers/input/misc/stpmic1_onkey.c                 |  12 +-
 drivers/input/misc/twl4030-vibra.c                 |  10 +-
 drivers/input/misc/twl6040-vibra.c                 |   7 +-
 drivers/input/misc/wistron_btns.c                  |   6 +-
 drivers/input/mouse/cyapa.c                        |  14 +-
 drivers/input/mouse/elan_i2c_core.c                |   8 +-
 drivers/input/mouse/navpoint.c                     |   9 +-
 drivers/input/mouse/synaptics_i2c.c                |  10 +-
 drivers/input/rmi4/rmi_i2c.c                       |  11 +-
 drivers/input/rmi4/rmi_smbus.c                     |  15 +-
 drivers/input/rmi4/rmi_spi.c                       |  13 +-
 drivers/input/serio/altera_ps2.c                   |   4 +-
 drivers/input/serio/ambakmi.c                      |   6 +-
 drivers/input/serio/apbps2.c                       |   4 +-
 drivers/input/serio/arc_ps2.c                      |   4 +-
 drivers/input/serio/olpc_apsp.c                    |   4 +-
 drivers/input/touchscreen/ad7877.c                 |   8 +-
 drivers/input/touchscreen/ads7846.c                |  31 +-
 drivers/input/touchscreen/ar1021_i2c.c             |   9 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   8 +-
 drivers/input/touchscreen/auo-pixcir-ts.c          |  10 +-
 drivers/input/touchscreen/bu21013_ts.c             |   8 +-
 drivers/input/touchscreen/bu21029_ts.c             |   8 +-
 drivers/input/touchscreen/chipone_icn8318.c        |   6 +-
 drivers/input/touchscreen/chipone_icn8505.c        |   8 +-
 drivers/input/touchscreen/cy8ctma140.c             |   9 +-
 drivers/input/touchscreen/cy8ctmg110_ts.c          |   9 +-
 drivers/input/touchscreen/cyttsp4_core.c           |   9 +-
 drivers/input/touchscreen/cyttsp4_i2c.c            |   2 +-
 drivers/input/touchscreen/cyttsp4_spi.c            |   2 +-
 drivers/input/touchscreen/cyttsp5.c                |   2 +-
 drivers/input/touchscreen/cyttsp_core.c            |   7 +-
 drivers/input/touchscreen/cyttsp_i2c.c             |   2 +-
 drivers/input/touchscreen/cyttsp_spi.c             |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  12 +-
 drivers/input/touchscreen/eeti_ts.c                |   8 +-
 drivers/input/touchscreen/egalax_ts.c              |   9 +-
 drivers/input/touchscreen/ektf2127.c               |  10 +-
 drivers/input/touchscreen/elants_i2c.c             |  10 +-
 drivers/input/touchscreen/exc3000.c                |  10 +
 drivers/input/touchscreen/goodix.c                 |   8 +-
 drivers/input/touchscreen/hideep.c                 |   8 +-
 drivers/input/touchscreen/ilitek_ts_i2c.c          |   8 +-
 drivers/input/touchscreen/imagis.c                 |   8 +-
 drivers/input/touchscreen/imx6ul_tsc.c             |  10 +-
 drivers/input/touchscreen/ipaq-micro-ts.c          |  11 +-
 drivers/input/touchscreen/iqs5xx.c                 |   8 +-
 drivers/input/touchscreen/mcs5000_ts.c             |   9 +-
 drivers/input/touchscreen/melfas_mip4.c            |   8 +-
 drivers/input/touchscreen/migor_ts.c               |   8 +-
 drivers/input/touchscreen/mms114.c                 |   8 +-
 drivers/input/touchscreen/msg2638.c                |   8 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |  10 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |  12 +-
 drivers/input/touchscreen/s6sy761.c                |  15 +-
 drivers/input/touchscreen/silead.c                 |   8 +-
 drivers/input/touchscreen/st1232.c                 |  10 +-
 drivers/input/touchscreen/stmfts.c                 |  14 +-
 drivers/input/touchscreen/surface3_spi.c           |  12 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   8 +-
 drivers/input/touchscreen/tsc2004.c                |   2 +-
 drivers/input/touchscreen/tsc2005.c                |   2 +-
 drivers/input/touchscreen/tsc200x-core.c           |   7 +-
 drivers/input/touchscreen/wacom_i2c.c              |   8 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   8 +-
 drivers/input/touchscreen/wm97xx-core.c            |  10 +-
 drivers/input/touchscreen/zforce_ts.c              |   8 +-
 drivers/input/touchscreen/zinitix.c                |   8 +-
 include/linux/platform_data/cros_ec_commands.h     |   3 +
 116 files changed, 810 insertions(+), 883 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.yaml

Thanks.


-- 
Dmitry
