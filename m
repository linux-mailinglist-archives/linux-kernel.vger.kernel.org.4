Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446BA651F98
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 12:22:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233249AbiLTLWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 06:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLTLWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 06:22:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B52811A3E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 03:22:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A5D73B8101B
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 11:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1408AC433D2;
        Tue, 20 Dec 2022 11:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671535327;
        bh=W8/J1ftFt3N1rn7LERjEze6MCMqX8YzL7FOEuJKXkVg=;
        h=Date:From:To:Cc:Subject:From;
        b=CHHPJvXwmB0T/NAKu7SBmrQTaGk5KVhxHVuoGJUV6Y40dawpu1KiunQdtFSX35ymW
         I+Es2rc4yPh73OQa5yOIRpswOEQ2+VDUBVOBkwqwwfve906JmVsy83weB7qcbCQKMU
         CxK8LXEarF94W5j4fJLiYUSemGDlAwHIVz7cYzo3Y4d60Z/wz2N6l/tHlE1hNjajNJ
         zHg8TngXlA5lE/krWbc2n8Z0fopFDlA1xgNQFl5orJVtKk8sC7KF3vpvmAhIg0hAw+
         rIlCmnYJOqqPd9YnwPuKFobEbtb8HpCl4J3xNtbCX4LtWHZ1uQXt3IdXjLLAYost7P
         osFELRQrh0U0A==
Date:   Tue, 20 Dec 2022 11:22:02 +0000
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.2
Message-ID: <Y6Ga2ucNaEaPPw9P@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good morning Linus,

The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git tags/mfd-next-6.2

for you to fetch changes up to 37fecbb80721c4e72ba3e43d4f07ba9ec15b68fd:

  dt-bindings: mfd: da9062: Correct file name for watchdog (2022-12-08 14:42:01 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Ampere Computing SMpro
   - Add support for TI TPS65219 PMIC

 - New Functionality
   - Add support for multiple devices of the same type; rk808

 - Fix-ups
   - Convert a bunch of I2C class drivers over to .probe_new()
   - Remove superfluous includes; mc13xxx-*, palmas, timberdale
   - Use correct includes for GPIO handling; madera-core
   - Convert to GPIOD; twl6040
   - Remove unused platform data handling; twl6040
   - Device Tree changes; many
   - Remove unused drivers; dm355evm_msp, davinci_voicecodec, htc-i2cpld
   - Add support for modules; palmas
   - Enable COMPILE_TEST support; intel_soc_pmic*
   - Trivial: spelling / whitespace fixes; mc13xxx-spi
   - Replace old PM helpers with new ones; many
   - Convert deprecated mask_invert usage to unmask_base; many
   - Use devm_*() calls; qcom_rpm
   - MAINTAINER fix-ups
   - Make use of improved / replaced APIs; palmas, fsl-imx25-tsadc,
                                           stm32-lptimer, qcom_rpm, rohm-*

 - Bug Fixes
   - Add bounds / error checking; mt6360-core
   - No sleeping inside critical sections; axp20x
   - Fix missing dependencies; ROHM_BD957XMUF
   - Repair error paths; qcom-pm8008

----------------------------------------------------------------
Aidan MacDonald (18):
      mfd: 88pm800: Replace irqchip mask_invert with unmask_base
      mfd: atc260x: Replace irqchip mask_invert with unmask_base
      mfd: axp20x: Replace irqchip mask_invert with unmask_base
      mfd: gateworks-gsc: Replace irqchip mask_invert with unmask_base
      mfd: max14577: Replace irqchip mask_invert with unmask_base
      mfd: max77650: Remove useless type_invert flag
      mfd: max77693: Replace irqchip mask_invert with unmask_base
      mfd: max77843: Drop useless mask_invert flag on irqchip
      mfd: rn5t618: Replace irqchip mask_invert with unmask_base
      mfd: rohm-bd71828: Replace irqchip mask_invert with unmask_base
      mfd: rohm-bd718x7: Drop useless mask_invert flag on irqchip
      mfd: rt5033: Replace irqchip mask_invert with unmask_base
      mfd: rt5120: Replace irqchip mask_invert with unmask_base
      mfd: sprd-sc27xx-spi: Replace irqchip mask_invert with unmask_base
      mfd: stpmic1: Fix swapped mask/unmask in irq chip
      mfd: sun4i-gpadc: Replace irqchip mask_invert with unmask_base
      mfd: tps65090: Replace irqchip mask_invert with unmask_base
      mfd: wcd934x: Convert irq chip to config regs

Angel Iglesias (1):
      i2c: core: Introduce i2c_client_get_device_id helper function

AngeloGioacchino Del Regno (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for MSM8976

Arnd Bergmann (3):
      mfd: Remove dm355evm_msp driver
      mfd: Remove davinci voicecodec driver
      mfd: Remove htc-i2cpld driver

Bryan O'Donoghue (1):
      dt-bindings: mfd: qcom,spmi-pmic: Drop PWM reg dependency

ChiYuan Huang (1):
      mfd: mt6360: Add bounds checking in Regmap read/write call-backs

Christoph Niedermaier (2):
      dt-bindings: mfd: da9062: Move IRQ to optional properties
      dt-bindings: mfd: da9062: Correct file name for watchdog

Christophe JAILLET (2):
      mfd: qcom_rpm: Fix an error handling path in qcom_rpm_probe()
      mfd: qcom_rpm: Use devm_of_platform_populate() to simplify code

Colin Foster (2):
      dt-bindings: mfd: ocelot: Remove spi-max-frequency from required properties
      dt-bindings: mfd: ocelot: Remove unnecessary driver wording

Dmitry Torokhov (5):
      mfd: mc13xxx: Stop including of_gpio.h
      mfd: madera: Include correct gpio API
      mfd: palmas: Stop including of_gpio.h
      mfd: twl6040: Switch to using gpiod API
      mfd: twl6040: Drop twl6040_platform_data and associated definitions

Fabien Parent (1):
      dt-bindings: mfd: mt6397: Add binding for MT6357

Guillaume La Roque (1):
      mfd: palmas: Add support of module build for Ti palmas chip

Jean Delvare (1):
      mfd: Drop obsolete dependencies on COMPILE_TEST

Jerome Neanne (1):
      mfd: tps65219: Add driver for TI TPS65219 PMIC

Johan Hovold (1):
      dt-bindings: mfd: qcom,tcsr: Add sc8280xp binding

Jonathan Neuschäfer (2):
      mfd: mc13xxx-spi: Fix typo ("transfert")
      dt-bindings: mfd: syscon: Add nuvoton,wpcm450-shm

Krzysztof Kozlowski (1):
      dt-bindings: mfd: qcom,spmi-pmic: Use generic node name "gpio"

Luca Weiss (2):
      dt-bindings: mfd: qcom,spmi-pmic: Support more types
      dt-bindings: mfd: qcom,spmi-pmic: Rename extcon node name

Markus Schneider-Pargmann (1):
      Input: Add tps65219 interrupt driven powerbutton

Matt Ranostay (2):
      dt-bindings: mfd: ti,am3359-tscadc: Add missing power-domains property
      dt-bindings: mfd: ti,j721e-system-controller: Add compatible strings for other platforms

Matti Vaittinen (3):
      mfd: bd957x: Fix Kconfig dependency on REGMAP_IRQ
      dt-bindings: Fix maintainer email for a few ROHM ICs
      mfd: rohm: Use dev_err_probe()

Minghao Chi (2):
      mfd: fsl-imx25-tsadc: Use devm_platform_get_and_ioremap_resource()
      mfd: stm32-lptimer: Use devm_platform_get_and_ioremap_resource()

Neil Armstrong (3):
      dt-bindings: mfd: qcom-pm8xxx: Document qcom,pm8921 as fallback of qcom,pm8018
      mfd: qcom-pm8xxx: Drop unused PM8018 compatible
      mfd: rk808: Permit having multiple PMIC instances

Paul Cercueil (27):
      mfd: 88pm80x: Remove #ifdef guards for PM related functions
      mfd: aat2870: Remove #ifdef guards for PM related functions
      mfd: adp5520: Remove #ifdef guards for PM related functions
      mfd: max8925-i2c: Remove #ifdef guards for PM related functions
      mfd: mt6397-irq: Remove #ifdef guards for PM related functions
      mfd: pcf50633: Remove #ifdef guards for PM related functions
      mfd: rc5t583-irq: Remove #ifdef guards for PM related functions
      mfd: stpmic1: Remove #ifdef guards for PM related functions
      mfd: ucb1x00: Remove #ifdef guards for PM related functions
      mfd: 88pm860x: Remove #ifdef guards for PM related functions
      mfd: mcp-sa11x0: Remove #ifdef guards for PM related functions
      mfd: sec: Remove #ifdef guards for PM related functions
      mfd: sm501: Remove #ifdef guards for PM related functions
      mfd: tc6387xb: Remove #ifdef guards for PM related functions
      mfd: tps6586x: Remove #ifdef guards for PM related functions
      mfd: wm8994: Remove #ifdef guards for PM related functions
      mfd: max77620: Remove #ifdef guards for PM related functions
      mfd: t7l66xb: Remove #ifdef guards for PM related functions
      mfd: arizona: Remove #ifdef guards for PM related functions
      mfd: max14577: Remove #ifdef guards for PM related functions
      mfd: max77686: Remove #ifdef guards for PM related functions
      mfd: motorola-cpcap: Remove #ifdef guards for PM related functions
      mfd: sprd-sc27xx: Remove #ifdef guards for PM related functions
      mfd: stmfx: Remove #ifdef guards for PM related functions
      mfd: stmpe: Remove #ifdef guards for PM related functions
      mfd: tc3589x: Remove #ifdef guards for PM related functions
      mfd: tc6393xb: Remove #ifdef guards for PM related functions

Quan Nguyen (2):
      mfd: Add Ampere's Altra SMpro MFD driver
      dt-bindings: mfd: Add bindings for Ampere Altra SMPro MFD driver

Rafał Miłecki (1):
      dt-bindings: timer: Add Broadcom's BCMBCA timers

Randy Dunlap (1):
      mfd: intel_soc_pmic: Allow COMPILE_TEST or I2C_DESIGNWARE_PLATFORM

Samuel Holland (1):
      mfd: axp20x: Do not sleep in the power off handler

Thomas Gleixner (1):
      mfd: timberdale: Remove linux/msi.h include

Uwe Kleine-König (70):
      mfd: 88pm800: Convert to i2c's .probe_new()
      mfd: 88pm805: Convert to i2c's .probe_new()
      mfd: aat2870-core: Convert to i2c's .probe_new()
      mfd: act8945a: Convert to i2c's .probe_new()
      mfd: adp5520: Convert to i2c's .probe_new()
      mfd: arizona-i2c: Convert to i2c's .probe_new()
      mfd: as3711: Convert to i2c's .probe_new()
      mfd: as3722: Convert to i2c's .probe_new()
      mfd: atc260x-i2c: Convert to i2c's .probe_new()
      mfd: axp20x-i2c: Convert to i2c's .probe_new()
      mfd: bcm590xx: Convert to i2c's .probe_new()
      mfd: bd9571mwv: Convert to i2c's .probe_new()
      mfd: da903x: Convert to i2c's .probe_new()
      mfd: da9052-i2c: Convert to i2c's .probe_new()
      mfd: da9055-i2c: Convert to i2c's .probe_new()
      mfd: da9062-core: Convert to i2c's .probe_new()
      mfd: da9063-i2c: Convert to i2c's .probe_new()
      mfd: da9150-core: Convert to i2c's .probe_new()
      mfd: khadas-mcu: Convert to i2c's .probe_new()
      mfd: lm3533-core: Convert to i2c's .probe_new()
      mfd: lp3943: Convert to i2c's .probe_new()
      mfd: lp873x: Convert to i2c's .probe_new()
      mfd: lp87565: Convert to i2c's .probe_new()
      mfd: lp8788: Convert to i2c's .probe_new()
      mfd: madera-i2c: Convert to i2c's .probe_new()
      mfd: max14577: Convert to i2c's .probe_new()
      mfd: max77620: Convert to i2c's .probe_new()
      mfd: max77693: Convert to i2c's .probe_new()
      mfd: max77843: Convert to i2c's .probe_new()
      mfd: max8907: Convert to i2c's .probe_new()
      mfd: max8925-i2c: Convert to i2c's .probe_new()
      mfd: max8997: Convert to i2c's .probe_new()
      mfd: max8998: Convert to i2c's .probe_new()
      mfd: mc13xxx-i2c: Convert to i2c's .probe_new()
      mfd: menelaus: Convert to i2c's .probe_new()
      mfd: menf21bmc: Convert to i2c's .probe_new()
      mfd: palmas: Convert to i2c's .probe_new()
      mfd: pcf50633-core: Convert to i2c's .probe_new()
      mfd: rc5t583: Convert to i2c's .probe_new()
      mfd: retu-mfd: Convert to i2c's .probe_new()
      mfd: rk808: Convert to i2c's .probe_new()
      mfd: rohm-bd718x7: Convert to i2c's .probe_new()
      mfd: rsmu_i2c: Convert to i2c's .probe_new()
      mfd: rt5033: Convert to i2c's .probe_new()
      mfd: sec-core: Convert to i2c's .probe_new()
      mfd: si476x-i2c: Convert to i2c's .probe_new()
      mfd: sky81452: Convert to i2c's .probe_new()
      mfd: stmfx: Convert to i2c's .probe_new()
      mfd: stmpe-i2c: Convert to i2c's .probe_new()
      mfd: stpmic1: Convert to i2c's .probe_new()
      mfd: stw481x: Convert to i2c's .probe_new()
      mfd: tc3589x: Convert to i2c's .probe_new()
      mfd: ti-lmu: Convert to i2c's .probe_new()
      mfd: tps6105x: Convert to i2c's .probe_new()
      mfd: tps65010: Convert to i2c's .probe_new()
      mfd: tps6507x: Convert to i2c's .probe_new()
      mfd: tps65086: Convert to i2c's .probe_new()
      mfd: tps65090: Convert to i2c's .probe_new()
      mfd: tps65218: Convert to i2c's .probe_new()
      mfd: tps6586x: Convert to i2c's .probe_new()
      mfd: tps65910: Convert to i2c's .probe_new()
      mfd: tps65912-i2c: Convert to i2c's .probe_new()
      mfd: twl-core: Convert to i2c's .probe_new()
      mfd: twl6040: Convert to i2c's .probe_new()
      mfd: wl1273-core: Convert to i2c's .probe_new()
      mfd: wm831x-i2c: Convert to i2c's .probe_new()
      mfd: wm8350-i2c: Convert to i2c's .probe_new()
      mfd: wm8400-core: Convert to i2c's .probe_new()
      mfd: wm8994-core: Convert to i2c's .probe_new()
      mfd: rohm-bd9576: Convert to i2c's .probe_new()

Yang Yingliang (1):
      mfd: pm8008: Fix return value check in pm8008_probe()

ye xingchen (1):
      mfd: palmas: Use device_get_match_data() to simplify the code

 .../bindings/leds/rohm,bd71828-leds.yaml           |   2 +-
 .../devicetree/bindings/mfd/ampere,smpro.yaml      |  42 ++
 .../devicetree/bindings/mfd/brcm,twd.yaml          |   8 +
 Documentation/devicetree/bindings/mfd/da9062.txt   |  13 +-
 .../devicetree/bindings/mfd/mscc,ocelot.yaml       |   4 +-
 Documentation/devicetree/bindings/mfd/mt6397.txt   |   1 +
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  34 +-
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   2 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |  33 +-
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd9576-pmic.yaml  |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   1 +
 .../devicetree/bindings/mfd/ti,am3359-tscadc.yaml  |   3 +
 .../bindings/mfd/ti,j721e-system-controller.yaml   |   2 +
 .../bindings/power/supply/rohm,bd99954.yaml        |   2 +-
 .../bindings/regulator/rohm,bd71815-regulator.yaml |   2 +-
 .../bindings/regulator/rohm,bd71828-regulator.yaml |   2 +-
 .../bindings/regulator/rohm,bd71837-regulator.yaml |   2 +-
 .../bindings/regulator/rohm,bd71847-regulator.yaml |   2 +-
 .../bindings/regulator/rohm,bd9576-regulator.yaml  |   2 +-
 .../bindings/timer/brcm,bcmbca-timer.yaml          |  40 ++
 MAINTAINERS                                        |   1 +
 drivers/i2c/i2c-core-base.c                        |  14 +
 drivers/input/misc/Kconfig                         |  21 +-
 drivers/input/misc/Makefile                        |   2 +-
 drivers/input/misc/dm355evm_keys.c                 | 238 --------
 drivers/input/misc/tps65219-pwrbutton.c            | 148 +++++
 drivers/mfd/88pm800.c                              |  10 +-
 drivers/mfd/88pm805.c                              |   7 +-
 drivers/mfd/88pm80x.c                              |   5 +-
 drivers/mfd/88pm860x-core.c                        |   6 +-
 drivers/mfd/Kconfig                                |  69 +--
 drivers/mfd/Makefile                               |   6 +-
 drivers/mfd/aat2870-core.c                         |  13 +-
 drivers/mfd/act8945a.c                             |   5 +-
 drivers/mfd/adp5520.c                              |  12 +-
 drivers/mfd/arizona-core.c                         |  19 +-
 drivers/mfd/arizona-i2c.c                          |   8 +-
 drivers/mfd/arizona-spi.c                          |   2 +-
 drivers/mfd/as3711.c                               |   5 +-
 drivers/mfd/as3722.c                               |   5 +-
 drivers/mfd/atc260x-core.c                         |   6 +-
 drivers/mfd/atc260x-i2c.c                          |   5 +-
 drivers/mfd/axp20x-i2c.c                           |   5 +-
 drivers/mfd/axp20x.c                               |  23 +-
 drivers/mfd/bcm590xx.c                             |   5 +-
 drivers/mfd/bd9571mwv.c                            |   5 +-
 drivers/mfd/da903x.c                               |   6 +-
 drivers/mfd/da9052-i2c.c                           |   6 +-
 drivers/mfd/da9055-i2c.c                           |   5 +-
 drivers/mfd/da9062-core.c                          |   6 +-
 drivers/mfd/da9063-i2c.c                           |   6 +-
 drivers/mfd/da9150-core.c                          |   5 +-
 drivers/mfd/davinci_voicecodec.c                   | 136 -----
 drivers/mfd/dm355evm_msp.c                         | 454 ---------------
 drivers/mfd/fsl-imx25-tsadc.c                      |   4 +-
 drivers/mfd/gateworks-gsc.c                        |   3 +-
 drivers/mfd/htc-i2cpld.c                           | 627 ---------------------
 drivers/mfd/khadas-mcu.c                           |   5 +-
 drivers/mfd/lm3533-core.c                          |   5 +-
 drivers/mfd/lp3943.c                               |   4 +-
 drivers/mfd/lp873x.c                               |   5 +-
 drivers/mfd/lp87565.c                              |   5 +-
 drivers/mfd/lp8788.c                               |   4 +-
 drivers/mfd/madera-core.c                          |   3 +-
 drivers/mfd/madera-i2c.c                           |   6 +-
 drivers/mfd/max14577.c                             |  19 +-
 drivers/mfd/max77620.c                             |  15 +-
 drivers/mfd/max77650.c                             |   1 -
 drivers/mfd/max77686.c                             |   6 +-
 drivers/mfd/max77693.c                             |  12 +-
 drivers/mfd/max77843.c                             |   7 +-
 drivers/mfd/max8907.c                              |   5 +-
 drivers/mfd/max8925-i2c.c                          |  12 +-
 drivers/mfd/max8997.c                              |   6 +-
 drivers/mfd/max8998.c                              |   6 +-
 drivers/mfd/mc13xxx-i2c.c                          |   7 +-
 drivers/mfd/mc13xxx-spi.c                          |   3 +-
 drivers/mfd/mcp-sa11x0.c                           |   6 +-
 drivers/mfd/menelaus.c                             |   5 +-
 drivers/mfd/menf21bmc.c                            |   4 +-
 drivers/mfd/motorola-cpcap.c                       |   8 +-
 drivers/mfd/mt6360-core.c                          |  14 +-
 drivers/mfd/mt6397-irq.c                           |   6 +-
 drivers/mfd/palmas.c                               |  13 +-
 drivers/mfd/pcf50633-core.c                        |  27 +-
 drivers/mfd/pcf50633-irq.c                         |  13 +-
 drivers/mfd/qcom-pm8008.c                          |   4 +-
 drivers/mfd/qcom-pm8xxx.c                          |   1 -
 drivers/mfd/qcom_rpm.c                             |  16 +-
 drivers/mfd/rc5t583-irq.c                          |   7 +-
 drivers/mfd/rc5t583.c                              |   5 +-
 drivers/mfd/retu-mfd.c                             |   4 +-
 drivers/mfd/rk808.c                                |  31 +-
 drivers/mfd/rn5t618.c                              |   3 +-
 drivers/mfd/rohm-bd71828.c                         |  29 +-
 drivers/mfd/rohm-bd718x7.c                         |  27 +-
 drivers/mfd/rohm-bd9576.c                          |  22 +-
 drivers/mfd/rsmu_i2c.c                             |   6 +-
 drivers/mfd/rt5033.c                               |   8 +-
 drivers/mfd/rt5120.c                               |   3 +-
 drivers/mfd/sec-core.c                             |  12 +-
 drivers/mfd/si476x-i2c.c                           |   6 +-
 drivers/mfd/sky81452.c                             |   5 +-
 drivers/mfd/sm501.c                                |  10 +-
 drivers/mfd/smpro-core.c                           | 138 +++++
 drivers/mfd/sprd-sc27xx-spi.c                      |  10 +-
 drivers/mfd/stm32-lptimer.c                        |   4 +-
 drivers/mfd/stmfx.c                                |  11 +-
 drivers/mfd/stmpe-i2c.c                            |   9 +-
 drivers/mfd/stmpe-spi.c                            |   4 +-
 drivers/mfd/stmpe.c                                |   8 +-
 drivers/mfd/stpmic1.c                              |  16 +-
 drivers/mfd/stw481x.c                              |   5 +-
 drivers/mfd/sun4i-gpadc.c                          |   3 +-
 drivers/mfd/t7l66xb.c                              |   9 +-
 drivers/mfd/tc3589x.c                              |  13 +-
 drivers/mfd/tc6387xb.c                             |   9 +-
 drivers/mfd/tc6393xb.c                             |   9 +-
 drivers/mfd/ti-lmu.c                               |   5 +-
 drivers/mfd/timberdale.c                           |   1 -
 drivers/mfd/tps6105x.c                             |   5 +-
 drivers/mfd/tps65010.c                             |   6 +-
 drivers/mfd/tps6507x.c                             |   5 +-
 drivers/mfd/tps65086.c                             |   5 +-
 drivers/mfd/tps65090.c                             |   8 +-
 drivers/mfd/tps65218.c                             |   5 +-
 drivers/mfd/tps65219.c                             | 299 ++++++++++
 drivers/mfd/tps6586x.c                             |  11 +-
 drivers/mfd/tps65910.c                             |   6 +-
 drivers/mfd/tps65912-i2c.c                         |   5 +-
 drivers/mfd/twl-core.c                             |   5 +-
 drivers/mfd/twl6040.c                              |  34 +-
 drivers/mfd/ucb1x00-core.c                         |   7 +-
 drivers/mfd/wcd934x.c                              |  11 +-
 drivers/mfd/wl1273-core.c                          |   5 +-
 drivers/mfd/wm831x-i2c.c                           |   6 +-
 drivers/mfd/wm8350-i2c.c                           |   5 +-
 drivers/mfd/wm8400-core.c                          |   5 +-
 drivers/mfd/wm8994-core.c                          |  12 +-
 drivers/rtc/Kconfig                                |   6 -
 drivers/rtc/Makefile                               |   1 -
 drivers/rtc/rtc-dm355evm.c                         | 151 -----
 include/linux/htcpld.h                             |  23 -
 include/linux/i2c.h                                |   1 +
 include/linux/mfd/dm355evm_msp.h                   |  79 ---
 include/linux/mfd/palmas.h                         |   1 -
 include/linux/mfd/pcf50633/core.h                  |   6 +-
 include/linux/mfd/stmfx.h                          |   2 -
 include/linux/mfd/tps65219.h                       | 345 ++++++++++++
 include/linux/mfd/twl6040.h                        |  32 +-
 154 files changed, 1521 insertions(+), 2366 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/ampere,smpro.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/brcm,bcmbca-timer.yaml
 delete mode 100644 drivers/input/misc/dm355evm_keys.c
 create mode 100644 drivers/input/misc/tps65219-pwrbutton.c
 delete mode 100644 drivers/mfd/davinci_voicecodec.c
 delete mode 100644 drivers/mfd/dm355evm_msp.c
 delete mode 100644 drivers/mfd/htc-i2cpld.c
 create mode 100644 drivers/mfd/smpro-core.c
 create mode 100644 drivers/mfd/tps65219.c
 delete mode 100644 drivers/rtc/rtc-dm355evm.c
 delete mode 100644 include/linux/htcpld.h
 delete mode 100644 include/linux/mfd/dm355evm_msp.h
 create mode 100644 include/linux/mfd/tps65219.h
 
-- 
Lee Jones [李琼斯]
