Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61A446F4841
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 18:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjEBQWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 12:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjEBQWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 12:22:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B1A2D4A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 09:22:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 950DF609D1
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 16:22:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35CC9C433EF;
        Tue,  2 May 2023 16:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683044545;
        bh=GQ6XhvJ8/hSmaoKEvhXapuXYFf1bZToth02kEU0rxv8=;
        h=Date:From:To:Cc:Subject:From;
        b=GxEN5DXW0QTDeQ8ScjfakisTze0fgOG7QWc7IwBOgNPpK5L3izvJMYem3KAAPUnI5
         L2BqbATIC+wpx1/ZV/FhhsalaoDpbu0hCnBmFvQzLhqKY1OoUuGE1lagUVUELEL9Wr
         zGByu2Llsy4ohRKgO3rCx0mRP6ZZVcPFptgCzbmiLtHJrl6SgT/vuUReRL3+3O6Jmb
         Wdt3Kct8cTO1wvLsLG8+/iAGcwNio+cef0z3ZBJzPvEs3C/wrMMe/4lP2yZ9ZbUzi2
         OTcVyUf5GSerFO+mp3jBrzOvvA0l4+dy7PR46wI2azA9e0mQ/FsC7gupAftK0uIGU7
         DMUTRuWUY6vMQ==
Date:   Tue, 2 May 2023 17:22:21 +0100
From:   Lee Jones <lee@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lee Jones <lee@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] MFD for v6.4
Message-ID: <20230502162221.GI620451@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon Linus,

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/mfd.git mfd-next-6.4

for you to fetch changes up to 9e9ff39243ea8795a4833708613f884b39dc91f9:

  dt-bindings: mfd: ti,j721e-system-controller: Add SoC chip ID (2023-04-26 15:25:38 +0100)

----------------------------------------------------------------
 - New Drivers
   - Add support for  Renesas RZ/G2L MTU3

 - New Device Support
   - Add support for Lenovo Yoga Book X90F to Intel CHT WC
   - Add support for MAX5970 and MAX5978 to Simple MFD (I2C)
   - Add support for Meteor Lake PCH-S LPSS PCI to Intel LPSS PCI
   - Add support for AXP15060 PMIC to X-Powers PMIC collection

 - Remove Device Support
   - Remove support for Samsung 5M8751 and S5M8763 PMIC devices

 - New Functionality
   - Convert deprecated QCOM IRQ Chip to config registers
   - Add support for 32-bit address spaces to Renesas SMUs

 - Fix-ups
   - Make use of APIs / MACROs designed to simplify and demystify
   - Add / improve Device Tree bindings
   - Memory saving struct layout optimisations
   - Remove old / deprecated functionality
   - Factor out unassigned register addresses from ranges
   - Trivial: Spelling fixes, renames and coding style fixes
   - Rid 'defined but not used' warnings
   - Remove ineffective casts and pointer stubs

 - Bug Fixes
   - Fix incorrectly non-inverted mask/unmask IRQs on QCOM platforms
   - Remove MODULE_*() helpers from non-tristate drivers
   - Do not attempt to use out-of-range memory addresses associated with io_base
   - Provide missing export helpers
   - Fix remap bulk read optimisation fallout
   - Fix memory leak issues in error paths

----------------------------------------------------------------
Aidan MacDonald (4):
      mfd: qcom-pm8008: Fix swapped mask/unmask in irq chip
      mfd: qcom-pm8008: Convert irq chip to config regs
      mfd: qcom-pm8008: Use .get_irq_reg() for irq chip
      mfd: qcom-pm8008: Remove workaround for a regmap-irq quirk

Andreas Kemnade (1):
      leds: bd2606mvv: Driver for the Rohm 6 Channel i2c LED driver

Andrew Davis (1):
      dt-bindings: mfd: Add TI-Nspire misc registers

André Apitzsch (1):
      mfd: arizona-i2c: Add the missing device table IDs for OF

Bartosz Golaszewski (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add compatible for pmm8654au

Benjamin Bara (1):
      dt-bindings: mfd: dlg,da9063: Document voltage monitoring

Biju Das (5):
      dt-bindings: timer: Document RZ/G2L MTU3a bindings
      mfd: Add Renesas RZ/G2L MTU3a core driver
      Documentation: ABI: sysfs-bus-counter: add cascade_counts_enable and external_input_phase_clock_select
      counter: Add Renesas RZ/G2L MTU3a counter driver
      MAINTAINERS: Add entries for Renesas RZ/G2L MTU3a counter driver

Charles Keepax (1):
      mfd: arizona-spi: Add missing MODULE_DEVICE_TABLE

Christoph Niedermaier (2):
      mfd: da9062: Use MFD_CELL_OF macro
      mfd: da9062: Remove IRQ requirement

Christophe JAILLET (1):
      mfd: core: Reorder fields in 'struct mfd_cell' to save some memory

Colin Foster (1):
      mfd: ocelot-spi: Fix unsupported bulk read

Dan Carpenter (1):
      counter: rz-mtu3-cnt: Unlock on error in rz_mtu3_count_ceiling_write()

David Virag (2):
      mfd: sec: Remove PMICs without compatibles
      rtc: s5m: Drop S5M8763 support

Emil Renner Berthing (1):
      dt-bindings: mfd: syscon: Add StarFive JH7100 sysmain compatible

Geert Uytterhoeven (1):
      mfd: rsmu_spi: Remove unneeded casts of void *

Hans de Goede (2):
      mfd: intel_soc_pmic_chtwc: Add Lenovo Yoga Book X90F to intel_cht_wc_models
      mfd: axp20x: Fix axp288 writable-ranges

Jackie Liu (1):
      mfd: si476x-cmd: Fix several issues reported by codespell

Jacky Huang (1):
      dt-bindings: mfd: syscon: Add nuvoton,ma35d1-sys compatible

Jakob Hauser (1):
      mfd: rt5033: Fix comments and style in includes

Jarkko Nikula (1):
      mfd: intel-lpss: Add Intel Meteor Lake PCH-S LPSS PCI IDs

Johan Hovold (1):
      dt-bindings: mfd: qcom,spmi-pmic: Add nvram function

Konrad Dybcio (2):
      dt-bindings: mfd: qcom,spmi-pmic: Allow RRADC as adc@ subnode
      dt-bindings: mfd: qcom,spmi-pmic: Add PM2250

Krzysztof Kozlowski (5):
      dt-bindings: mfd: qcom,tcsr: Document SDX55 TCSR
      mfd: atmel-smc: Mark OF related data as maybe unused
      mfd: atc260x-i2c: Drop of_match_ptr for ID table
      dt-bindings: mfd: x-powers,axp152: Simplify disallowing properties
      dt-bindings: mfd: qcom,spmi-pmic: Document flash LED controller

Marcello Sylvester Bauer (1):
      dt-bindings: mfd: Add MAX5970 and MAX5978

Marijn Suijten (1):
      dt-bindings: mfd: qcom,spmi-pmic: Use generic ADC node name in examples

Martin Botka (1):
      dt-bindings: mfd: x-powers,axp152: Document the AXP313a variant

Matthias Schiffer (3):
      mfd: tqmx86: Do not access I2C_DETECT register through io_base
      mfd: tqmx86: Specify IO port register range more precisely
      mfd: tqmx86: Correct board names for TQMxE39x

Min Li (1):
      mfd: rsmu: Support 32-bit address space

Mukesh Ojha (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for sm8450

Nick Alcock (20):
      mfd: bcm2835-pm: Remove MODULE_LICENSE in non-modules
      mfd: intel_soc_pmic_crc: Remove MODULE_LICENSE in non-modules
      mfd: da9055: Do not cite as modular
      mfd: twl6040: Remove MODULE_LICENSE in non-modules
      mfd: twl4030-audio: Remove MODULE_LICENSE in non-modules
      mfd: lp8788: Remove MODULE_LICENSE in non-modules
      mfd: tps6586x: Remove MODULE_LICENSE in non-modules
      mfd: omap-usb-tll: Remove MODULE_LICENSE in non-modules
      mfd: omap-usb-host: Remove MODULE_LICENSE in non-modules
      mfd: ezx-pcap: Remove MODULE_LICENSE in non-modules
      mfd: tc3589x: Remove MODULE_LICENSE in non-modules
      mfd: 88pm860x: Remove MODULE_LICENSE in non-modules
      mfd: stmpe-spi: Remove MODULE_LICENSE in non-modules
      mfd: stmpe-i2c: Remove MODULE_LICENSE in non-modules
      mfd: da9055-i2c: Remove MODULE_LICENSE in non-modules
      mfd: da9055: Remove MODULE_LICENSE in non-modules
      mfd: da9052-spi: Remove MODULE_LICENSE in non-modules
      mfd: da9052-i2c: Remove MODULE_LICENSE in non-modules
      mfd: da9052: Remove MODULE_LICENSE in non-modules
      mfd: da903x: Remove MODULE_LICENSE in non-modules

Nishanth Menon (1):
      dt-bindings: mfd: ti,j721e-system-controller: Add SoC chip ID

Patrick Delaunay (1):
      dt-bindings: mfd: stm32: Remove unnecessary blank lines

Patrick Rudolph (1):
      mfd: max597x: Add support for MAX5970 and MAX5978

Poovendhan Selvaraj (1):
      dt-bindings: mfd: Add the tcsr compatible for IPQ9574

Qiang Ning (1):
      mfd: dln2: Fix memory leak in dln2_probe()

Rob Herring (3):
      mfd: various: Use of_property_present() for testing DT property presence
      mfd: various: Use of_property_read_bool() for boolean properties
      dt-bindings: mfd: Drop unneeded quotes in 'ref', 'id' and 'schema' entries

Rohit Agarwal (1):
      dt-bindings: mfd: qcom,tcsr: Add compatible for sdx65

Shengyu Qu (2):
      mfd: axp20x: Add support for AXP15060 PMIC
      dt-bindings: mfd: x-powers,axp152: Document the AXP15060 variant

Tom Rix (2):
      mfd: twl-core: Remove unused add_child() and add_numbered_child() functions
      mfd: omap-usb-tll: Remove unused usbtll_readb() function

Uwe Kleine-König (2):
      mfd: core: Remove .enable() and .disable() callbacks
      mfd: rsmu_i2c: Convert to i2c's .probe_new() again

William Breathitt Gray (1):
      regmap: Pass irq_drv_data as a parameter for set_type_config()

Ye Xiang (1):
      gpio: Add support for Intel LJCA USB GPIO driver

Ye Xingchen (6):
      mfd: hi6421-pmic: Use devm_platform_get_and_ioremap_resource()
      mfd: ipaq-micro: Use devm_platform_get_and_ioremap_resource()
      mfd: ssbi: Use devm_platform_get_and_ioremap_resource()
      mfd: sun4i-gpadc: Use devm_platform_get_and_ioremap_resource()
      mfd: atmel-flexcom: Use devm_platform_get_and_ioremap_resource()
      mfd: qcom_rpm: Use devm_platform_get_and_ioremap_resource()

 Documentation/ABI/testing/sysfs-bus-counter        |  32 +
 .../bindings/mfd/canaan,k210-sysctl.yaml           |   6 +-
 .../devicetree/bindings/mfd/dlg,da9063.yaml        |  17 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |  22 +-
 .../bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml   |   2 +-
 .../devicetree/bindings/mfd/maxim,max5970.yaml     | 151 ++++
 .../devicetree/bindings/mfd/qcom,spmi-pmic.yaml    |  15 +-
 .../devicetree/bindings/mfd/qcom,tcsr.yaml         |   4 +
 .../devicetree/bindings/mfd/qcom-pm8xxx.yaml       |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +
 .../bindings/mfd/ti,j721e-system-controller.yaml   |  11 +
 .../devicetree/bindings/mfd/ti,nspire-misc.yaml    |  51 ++
 .../devicetree/bindings/mfd/wlf,arizona.yaml       |   2 +-
 .../devicetree/bindings/mfd/x-powers,ac100.yaml    |   4 +-
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |  32 +-
 .../devicetree/bindings/mfd/xylon,logicvc.yaml     |   4 +-
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml | 302 +++++++
 MAINTAINERS                                        |   8 +
 drivers/base/regmap/regmap-irq.c                   |   8 +-
 drivers/counter/Kconfig                            |  11 +
 drivers/counter/Makefile                           |   1 +
 drivers/counter/rz-mtu3-cnt.c                      | 906 +++++++++++++++++++++
 drivers/gpio/Kconfig                               |  12 +
 drivers/gpio/Makefile                              |   1 +
 drivers/gpio/gpio-ljca.c                           | 454 +++++++++++
 drivers/leds/Kconfig                               |  14 +
 drivers/leds/Makefile                              |   1 +
 drivers/leds/leds-bd2606mvv.c                      | 160 ++++
 drivers/mfd/88pm860x-core.c                        |   4 +-
 drivers/mfd/Kconfig                                |  23 +-
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/arizona-i2c.c                          |   1 +
 drivers/mfd/arizona-spi.c                          |   1 +
 drivers/mfd/atc260x-i2c.c                          |   2 +-
 drivers/mfd/atmel-flexcom.c                        |   4 +-
 drivers/mfd/atmel-smc.c                            |   2 +-
 drivers/mfd/axp20x-i2c.c                           |   2 +
 drivers/mfd/axp20x.c                               | 108 +++
 drivers/mfd/bcm2835-pm.c                           |   3 +-
 drivers/mfd/da903x.c                               |   1 -
 drivers/mfd/da9052-core.c                          |   1 -
 drivers/mfd/da9052-i2c.c                           |   1 -
 drivers/mfd/da9052-spi.c                           |   1 -
 drivers/mfd/da9055-core.c                          |   1 -
 drivers/mfd/da9055-i2c.c                           |   1 -
 drivers/mfd/da9062-core.c                          | 176 ++--
 drivers/mfd/dln2.c                                 |   1 +
 drivers/mfd/ezx-pcap.c                             |   1 -
 drivers/mfd/hi6421-pmic-core.c                     |   4 +-
 drivers/mfd/intel-lpss-pci.c                       |  15 +
 drivers/mfd/intel_soc_pmic_chtwc.c                 |  14 +-
 drivers/mfd/intel_soc_pmic_crc.c                   |   1 -
 drivers/mfd/ipaq-micro.c                           |   4 +-
 drivers/mfd/khadas-mcu.c                           |   2 +-
 drivers/mfd/lp8788.c                               |   1 -
 drivers/mfd/mfd-core.c                             |  26 -
 drivers/mfd/ocelot-spi.c                           |   1 +
 drivers/mfd/omap-usb-host.c                        |   1 -
 drivers/mfd/omap-usb-tll.c                         |   6 -
 drivers/mfd/qcom-pm8008.c                          | 132 ++-
 drivers/mfd/qcom_rpm.c                             |   4 +-
 drivers/mfd/rsmu.h                                 |   2 +
 drivers/mfd/rsmu_i2c.c                             | 165 +++-
 drivers/mfd/rsmu_spi.c                             |  48 +-
 drivers/mfd/rz-mtu3.c                              | 391 +++++++++
 drivers/mfd/rz-mtu3.h                              | 147 ++++
 drivers/mfd/sec-core.c                             |  46 --
 drivers/mfd/sec-irq.c                              |  89 --
 drivers/mfd/si476x-cmd.c                           |  14 +-
 drivers/mfd/simple-mfd-i2c.c                       |  13 +
 drivers/mfd/ssbi.c                                 |   4 +-
 drivers/mfd/stmpe-i2c.c                            |   1 -
 drivers/mfd/stmpe-spi.c                            |   1 -
 drivers/mfd/stmpe.c                                |   2 +-
 drivers/mfd/sun4i-gpadc.c                          |   4 +-
 drivers/mfd/tc3589x.c                              |   1 -
 drivers/mfd/tps6586x.c                             |   1 -
 drivers/mfd/tqmx86.c                               |  52 +-
 drivers/mfd/twl-core.c                             |  65 --
 drivers/mfd/twl4030-audio.c                        |   1 -
 drivers/mfd/twl6040.c                              |   1 -
 drivers/mfd/wm8994-core.c                          |  19 +-
 drivers/rtc/rtc-s5m.c                              |  82 +-
 include/dt-bindings/mfd/stm32f4-rcc.h              |   1 -
 include/linux/mfd/axp20x.h                         |  85 ++
 include/linux/mfd/core.h                           |  20 +-
 include/linux/mfd/max597x.h                        |  96 +++
 include/linux/mfd/rsmu.h                           |   5 +-
 include/linux/mfd/rt5033-private.h                 |  17 +-
 include/linux/mfd/rt5033.h                         |   7 +-
 include/linux/mfd/rz-mtu3.h                        | 257 ++++++
 include/linux/mfd/samsung/core.h                   |   2 -
 include/linux/mfd/samsung/irq.h                    |  50 --
 include/linux/mfd/samsung/s5m8763.h                |  90 --
 include/linux/regmap.h                             |   6 +-
 97 files changed, 3718 insertions(+), 852 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/maxim,max5970.yaml
 create mode 100644 Documentation/devicetree/bindings/mfd/ti,nspire-misc.yaml
 create mode 100644 Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
 create mode 100644 drivers/counter/rz-mtu3-cnt.c
 create mode 100644 drivers/gpio/gpio-ljca.c
 create mode 100644 drivers/leds/leds-bd2606mvv.c
 create mode 100644 drivers/mfd/rz-mtu3.c
 create mode 100644 drivers/mfd/rz-mtu3.h
 create mode 100644 include/linux/mfd/max597x.h
 create mode 100644 include/linux/mfd/rz-mtu3.h
 delete mode 100644 include/linux/mfd/samsung/s5m8763.h

-- 
Lee Jones [李琼斯]
