Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE4385F6334
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 11:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbiJFJCM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 05:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbiJFJCJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 05:02:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9669B23BC2
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 02:02:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3088861871
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 09:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0666C433D6;
        Thu,  6 Oct 2022 09:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665046927;
        bh=hllBtVM3QDjklG1GsGd0zgLyfMHbKO2SG5igUogI4Xg=;
        h=Date:From:To:Cc:Subject:From;
        b=tPzRnYn3sRaama/MisYJDIb/5QbUj9D6PR/ep3J4Cd9sbHbUe+lZ0sWM3QeEBr8Mq
         asq/2Bcp9sce2dXcZYTBRKMWmpqgBtgStDbLwfP6qe3qvxFpzZVp2tSYSO6UjKMBQh
         uTWvPF6uz2ajQU3YaRWfpk8CxQhUYXQZCZq4euqEzxDFl/WhMkIr5cPvnD7SHsIRlC
         Z1GUoncbJUZGTU8ZTuPpaLKBWXZMnfUD4UiWlgzr4yX9c8qAeHeLP9Q8UX4+lvNoMc
         eoCChT4BuRSmKtpGg8P38cpRM557n1Amvo0y9EcYnSQKfMra1tnCFbDTD2hrwFIwBG
         q6qMRZrsGsU5w==
Date:   Thu, 6 Oct 2022 10:02:03 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.1
Message-ID: <Yz6Zi7B2RS16sXhT@google.com>
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

This PR is likely to conflict with Pinctrl.

Please take the changes made here; variable 'base' has been removed.

The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.1

for you to fetch changes up to 72a95859728a7866522e6633818bebc1c2519b17:

  mfd: syscon: Remove repetition of the regmap_get_val_endian() (2022-09-29 19:06:57 +0100)

----------------------------------------------------------------
 - Core Frameworks
   - Fix 'mfd_of_node_list' OF node entry resource leak

 - New Drivers
   - Add support for Ocelot VSC7512 Networking Chip
   - Add support for MediaTek MT6370 subPMIC
   - Add support for Richtek RT5120 (I2C) PMIC

 - New Device Support
   - Add support for Rockchip RV1126 and RK3588 to Syscon
   - Add support for Rockchip RK817 Battery Charger to RK808
   - Add support for Silergy SY7636a Voltage Regulator to Simple MFD
   - Add support for Qualcomm PMP8074 PMIC to QCOM SPMI
   - Add support for Secure Update to Intel M10 BMC

 - New Functionality
   - Provide SSP type to Intel's LPSS (PCI) SPI driver

 - Fix-ups
   - Remove legacy / unused code; stmpe, intel_soc_pmic_crc, syscon
   - Unify / simplify; intel_soc_pmic_crc
   - Trivial reordering / spelling, etc; Makefile, twl-core
   - Convert to managed resources; intel_soc_pmic_crc
   - Use appropriate APIs; intel_soc_pmic_crc
   - strscpy() conversion; htc-i2cpld, lpc_ich, mfd-core
   - GPIOD conversion; htc-i2cpld, stmpe
   - Add missing header file includes; twl4030-irq
   - DT goodies; stmpe, mediatek,mt6370, x-powers,axp152,
                 aspeed,ast2x00-scu, mediatek,mt8195-scpsys,
		 qcom,spmi-pmic, syscon, qcom,tcsr, rockchip,rk817,
		 sprd,ums512-glbreg, dlg,da9063

 - Bug Fixes
   - Properly check return values; sm501, htc-i2cpld
   - Repair Two-Wire Bus Mode; da9062-core
   - Fix error handling; intel_soc_pmic_core, fsl-imx25-tsadc,
                         lp8788, lp8788-irq

----------------------------------------------------------------
Alistair Francis (1):
      mfd: silergy,sy7636a: Add config option MFD_SY7636A

Allen-KH Cheng (1):
      dt-bindings: mfd: mediatek: Add scpsys compatible for mt8186

Andy Shevchenko (13):
      mfd: intel-lpss: Provide an SSP type to the SPI driver
      mfd: intel_soc_pmic_crc: Merge Intel PMIC core to crc
      mfd: intel_soc_pmic: Move non-Intel Makefile entries to their own group
      mfd: intel_soc_pmic_crc: Use devm_regmap_add_irq_chip()
      mfd: intel_soc_pmic_crc: Convert to use i2c_get/set_clientdata()
      mfd: intel_soc_pmic_crc: Switch from CONFIG_PM_SLEEP guards to pm_sleep_ptr() etc
      mfd: intel_soc_pmic_crc: Drop redundant ACPI_PTR() and ifdeffery
      mfd: intel_soc_pmic_crc: Convert driver to use ->probe_new()
      mfd: intel_soc_pmic_crc: Replace intel_soc_pmic with crystal_cove
      mfd: intel_soc_pmic_crc: Update the copyright year
      mfd: intel_soc_pmic_chtdc_ti: Switch from __maybe_unused to pm_sleep_ptr() etc
      mfd: twl4030: Add missed linux/device.h header
      mfd: syscon: Remove repetition of the regmap_get_val_endian()

ChiYuan Huang (5):
      dt-bindings: mfd: Add MediaTek MT6370
      mfd: mt6370: Add MediaTek MT6370 support
      mfd: rt5120: Add Richtek PMIC support
      dt-binding: mfd: Add Richtek RT5120 PMIC support
      dt-bindings: mfd: mt6370: Fix the indentation in the example

Chris Morgan (3):
      mfd: rk808: Add Rockchip rk817 battery charger support
      dt-bindings: mfd: Add Rockchip rk817 battery charger support
      power: supply: Add charger driver for Rockchip RK817

Christophe JAILLET (4):
      mfd: intel_soc_pmic: Fix an error handling path in intel_soc_pmic_i2c_probe()
      mfd: fsl-imx25: Fix an error handling path in mx25_tsadc_setup_irq()
      mfd: lp8788: Fix an error handling path in lp8788_probe()
      mfd: lp8788: Fix an error handling path in lp8788_irq_init() and lp8788_irq_init()

Chunyan Zhang (1):
      dt-bindings: mfd: sprd: Add bindings for ums512 global registers

Colin Foster (8):
      mfd: ocelot: Add helper to get regmap from a resource
      net: mdio: mscc-miim: add ability to be used in a non-mmio configuration
      pinctrl: ocelot: add ability to be used in a non-mmio configuration
      pinctrl: microchip-sgpio: allow sgpio driver to be used as a module
      pinctrl: microchip-sgpio: add ability to be used in a non-mmio configuration
      resource: add define macro for register address resources
      dt-bindings: mfd: ocelot: Add bindings for VSC7512
      mfd: ocelot: Add support for the vsc7512 chip via spi

Conor Dooley (1):
      dt-bindings: mfd: dlg,da9063: Add missing regulator patterns

Dan Carpenter (1):
      mfd: fsl-imx25: Fix check for platform_get_irq() errors

Dmitry Torokhov (1):
      mfd: stmpe: Switch to using gpiod API

Francesco Dolcini (2):
      mfd: stmpe: Remove rotator block from probe
      mfd: stmpe: Probe sub-function by compatible

Jagan Teki (1):
      dt-bindings: mfd: syscon: Add Rockchip RV1126 QoS register

Jason Wang (1):
      mfd: twl-core: Fix double "to to" in comment.

Jens Hillenstedt (1):
      mfd: da9061: Fix Failed to set Two-Wire Bus Mode.

Jiasheng Jiang (1):
      mfd: sm501: Add check for platform_driver_register()

Krzysztof Kozlowski (9):
      dt-bindings: mfd: qcom,spmi-pmic: Add missing compatibles
      dt-bindings: mfd: syscon: Require specific compatible also for simple-mfd
      dt-bindings: mfd: qcom,spmi-pmic: Extend example
      dt-bindings: mfd: qcom,spmi-pmic: Fix regulator node schema
      dt-bindings: mfd: qcom,spmi-pmic: Fix TM ADC node schema on PM8998
      dt-bindings: mfd: qcom,tcsr: Add several devices
      MAINTAINERS: Drop Robert Jones
      dt-bindings: mfd: syscon: Drop ref from reg-io-width
      dt-bindings: mfd: qcom,tcsr: Drop simple-mfd from IPQ6018

Linus Walleij (1):
      mfd/omap1: htc-i2cpld: Convert to a pure GPIO driver

Luca Weiss (1):
      mfd: qcom-spmi-pmic: Add pm7250b compatible

Michal Oleszczyk (1):
      mfd: core: Delete corresponding OF node entries from list on MFD removal

Peng Wu (1):
      mfd: htc-i2cpld: Fix an IS_ERR() vs NULL bug in htcpld_core_probe()

Rob Herring (2):
      dt-bindings: mfd: aspeed,ast2x00-scu: Convert to DT schema format
      dt-bindings: mfd: Add missing (unevaluated|additional)Properties on child nodes

Robert Marko (2):
      dt-bindings: mfd: qcom-spmi-pmic: Add support for PMP8074
      mfd: qcom-spmi-pmic: Add support for PMP8074

Russ Weight (1):
      mfd: intel-m10-bmc: Add d5005 bmc secure update driver

Samuel Holland (1):
      dt-bindings: mfd: x-powers,axp152: Document the AXP228 variant

Sebastian Reichel (1):
      dt-bindings: mfd: syscon: Add rk3588 QoS register compatible

Tinghan Shen (1):
      dt-bindings: mfd: mt8195: Add bindings for MediaTek SCPSYS

Wolfram Sang (1):
      mfd: Move from strlcpy with unused retval to strscpy

Yang Yingliang (1):
      mfd: ocelot-spi: Add missing MODULE_DEVICE_TABLE

 .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     |   40 +
 .../bindings/mfd/allwinner,sun8i-a23-prcm.yaml     |   10 +
 .../bindings/mfd/aspeed,ast2x00-scu.yaml           |  110 ++
 .../devicetree/bindings/mfd/aspeed-scu.txt         |   48 -
 .../devicetree/bindings/mfd/cirrus,lochnagar.yaml  |    5 +
 .../devicetree/bindings/mfd/dlg,da9063.yaml        |    7 +-
 .../devicetree/bindings/mfd/gateworks-gsc.yaml     |    5 +-
 .../devicetree/bindings/mfd/maxim,max14577.yaml    |    1 +
 .../devicetree/bindings/mfd/maxim,max77843.yaml    |    1 +
 .../devicetree/bindings/mfd/mediatek,mt6370.yaml   |  280 +++++
 .../bindings/mfd/mediatek,mt8195-scpsys.yaml       |   68 ++
 .../devicetree/bindings/mfd/mscc,ocelot.yaml       |  160 +++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  114 +-
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   38 +-
 .../devicetree/bindings/mfd/richtek,rt5120.yaml    |  178 +++
 .../devicetree/bindings/mfd/rockchip,rk817.yaml    |   52 +
 .../devicetree/bindings/mfd/silergy,sy7636a.yaml   |    1 +
 .../bindings/mfd/sprd,ums512-glbreg.yaml           |   71 ++
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |    4 +
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |    3 +
 .../devicetree/bindings/mfd/st,stmfx.yaml          |    1 +
 .../devicetree/bindings/mfd/stericsson,ab8500.yaml |   22 +
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   17 +-
 .../devicetree/bindings/mfd/ti,tps65086.yaml       |    1 +
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |    4 +
 .../bindings/power/mediatek,power-controller.yaml  |    2 +-
 MAINTAINERS                                        |    8 +-
 arch/arm/boot/dts/tegra30-apalis-v1.1.dtsi         |    2 +-
 arch/arm/boot/dts/tegra30-apalis.dtsi              |    2 +-
 arch/arm/boot/dts/tegra30-colibri.dtsi             |    2 +-
 arch/arm/mach-omap1/board-htcherald.c              |    9 -
 drivers/hwmon/Kconfig                              |    1 +
 drivers/mfd/Kconfig                                |   65 +-
 drivers/mfd/Makefile                               |   15 +-
 drivers/mfd/da9062-core.c                          |    1 +
 drivers/mfd/fsl-imx25-tsadc.c                      |   34 +-
 drivers/mfd/htc-i2cpld.c                           |   60 +-
 drivers/mfd/intel-lpss-pci.c                       |  141 ++-
 drivers/mfd/intel-m10-bmc.c                        |    1 +
 drivers/mfd/intel_soc_pmic_chtdc_ti.c              |    8 +-
 drivers/mfd/intel_soc_pmic_core.c                  |  160 ---
 drivers/mfd/intel_soc_pmic_core.h                  |   25 -
 drivers/mfd/intel_soc_pmic_crc.c                   |  141 ++-
 drivers/mfd/lp8788-irq.c                           |    3 +
 drivers/mfd/lp8788.c                               |   12 +-
 drivers/mfd/lpc_ich.c                              |    2 +-
 drivers/mfd/mfd-core.c                             |    9 +-
 drivers/mfd/mt6370.c                               |  312 +++++
 drivers/mfd/mt6370.h                               |   99 ++
 drivers/mfd/ocelot-core.c                          |  161 +++
 drivers/mfd/ocelot-spi.c                           |  300 +++++
 drivers/mfd/ocelot.h                               |   49 +
 drivers/mfd/qcom-spmi-pmic.c                       |    1 +
 drivers/mfd/rk808.c                                |   16 +-
 drivers/mfd/rt5120.c                               |  124 ++
 drivers/mfd/sm501.c                                |    7 +-
 drivers/mfd/stmpe.c                                |   49 +-
 drivers/mfd/syscon.c                               |    8 -
 drivers/mfd/twl-core.c                             |    2 +-
 drivers/mfd/twl4030-irq.c                          |    1 +
 drivers/net/mdio/mdio-mscc-miim.c                  |   42 +-
 drivers/pinctrl/Kconfig                            |    5 +-
 drivers/pinctrl/pinctrl-microchip-sgpio.c          |   14 +-
 drivers/pinctrl/pinctrl-ocelot.c                   |   16 +-
 drivers/power/supply/Kconfig                       |    6 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/rk817_charger.c               | 1211 ++++++++++++++++++++
 drivers/regulator/Kconfig                          |    1 +
 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h  |   18 +
 include/linux/htcpld.h                             |    2 -
 include/linux/ioport.h                             |    5 +
 include/linux/mfd/ocelot.h                         |   62 +
 include/linux/mfd/rk808.h                          |   91 ++
 73 files changed, 4071 insertions(+), 476 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/aspeed,ast2x00-scu.yaml
 delete mode 100644 Documentation/devicetree/bindings/mfd/aspeed-scu.txt
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt6370.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/mscc,ocelot.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/richtek,rt5120.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
 delete mode 100644 drivers/mfd/intel_soc_pmic_core.c
 delete mode 100644 drivers/mfd/intel_soc_pmic_core.h
 create mode 100644 drivers/mfd/mt6370.c
 create mode 100644 drivers/mfd/mt6370.h
 create mode 100644 drivers/mfd/ocelot-core.c
 create mode 100644 drivers/mfd/ocelot-spi.c
 create mode 100644 drivers/mfd/ocelot.h
 create mode 100644 drivers/mfd/rt5120.c
 create mode 100644 drivers/power/supply/rk817_charger.c
 create mode 100644 include/dt-bindings/iio/adc/mediatek,mt6370_adc.h
 create mode 100644 include/linux/mfd/ocelot.h

-- 
Lee Jones [李琼斯]
