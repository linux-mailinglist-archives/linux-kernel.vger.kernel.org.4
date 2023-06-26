Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C17473E0AF
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 15:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbjFZNdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 09:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjFZNdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 09:33:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CE1E7D
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 06:33:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB68960EA9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 13:33:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5BFBC433C0;
        Mon, 26 Jun 2023 13:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687786407;
        bh=8a3oDp1tcdEtzTAIdQ7wBW+z2xNJiDUX4Oty8J3kPZ0=;
        h=From:To:Cc:Subject:Date:From;
        b=qLNw8gyZxv9Vnn+txCB0F6wDkF9y6G0Ay5sLYpVniHjTqDDgBpn/3AzFt5J39Gb4/
         wBM9jmhW42QNg2lOCAfF3e++dueMs4IXSBsZ4FCf8AkR1Dh27cK0JqcrAD0wDYsZwQ
         YicvW27WlgEMGn1wd7zJhzmYaCalKZTgOefQgTUog9j7nDJONPZRdhcEWPyOG4r2i2
         ulnGZq1QLkXroDEAen76Q1kYlzgaCMKTU7t3mOXMX6ibTo1DPrM33oHRJDSdawQh6V
         kvSGDDKqd0jnPSVvh6bJ9EyK0q9W0nld8Kggj0je0J1bZxLuMOMG9PSp3+cMdh92zP
         oHn222lmx6pJA==
From:   Mark Brown <broonie@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.5
Date:   Mon, 26 Jun 2023 14:33:17 +0100
Message-Id: <20230626133326.C5BFBC433C0@smtp.kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        PP_MIME_FAKE_ASCII_TEXT,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 45a3e24f65e90a047bef86f927ebdc4c710edaa1:

  Linux 6.4-rc7 (2023-06-18 14:06:27 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.5

for you to fetch changes up to 54e47eade73046e860634736d2651ddc118ca694:

  Add Renesas PMIC RAA215300 and built-in RTC (2023-06-24 01:57:59 +0100)

----------------------------------------------------------------
regulator: Updates for v6.5

This release is almost all drivers, there's some small improvements in
the core but otherwise everything is updates to drivers, mostly the
addition of new ones.

There's also a bunch of changes pulled in from the MFD subsystem as
dependencies, Rockchip and TI core MFD code that the regulator drivers
depend on.

I've also yet again managed to put a SPI commit in the regulator tree, I
don't know what it is about those two trees (this for spi-geni-qcom).

 - Support for Renesas RAA215300, Rockchip RK808, Texas Instruments
   TPS6594 and TPS6287x, and X-Powers AXP15060 and AXP313a

----------------------------------------------------------------
Axel Lin (1):
      regulator: tps6287x: Fix missing .n_voltages setting

Biju Das (2):
      regulator: dt-bindings: Add Renesas RAA215300 PMIC bindings
      regulator: Add Renesas PMIC RAA215300 driver

Chen-Yu Tsai (6):
      regulator: dt-bindings: mt6358: Merge ldo_vcn33_* regulators
      regulator: dt-bindings: mt6358: Drop *_sshub regulators
      regulator: mt6358: Merge VCN33_* regulators
      regulator: mt6358: Drop *_SSHUB regulators
      regulator: mt6358: Const-ify mt6358_regulator_info data structures
      regulator: mt6358: Use linear voltage helpers for single range regulators

ChiYuan Huang (1):
      regulator: helper: Document ramp_delay parameter of regulator_set_ramp_delay_regmap()

Fabio Estevam (1):
      dt-bindings: pfuze100.yaml: Add an entry for interrupts

Geert Uytterhoeven (2):
      regulator: core: Fix more error checking for debugfs_create_dir()
      regulator: core: Streamline debugfs operations

Jerome Neanne (1):
      regulator: tps6594-regulator: Add driver for TI TPS6594 regulators

Julien Panis (1):
      mfd: tps6594: Add driver for TI TPS6594 PMIC

Krzysztof Kozlowski (1):
      regulator: tps65219: Fix matching interrupts for their regulators

Marek Vasut (1):
      regulator: stm32-pwr: Fix regulator disabling

Mark Brown (12):
      regulator: Add support for TPS6287x
      mfd/pinctrl/regulator: Add RK806 Support
      regulator: Merge up v6.4-rc3
      regulator: Merge up fixes
      regulator: core: Fix error checking and messages
      regulator: Add X-Powers AXP15060/AXP313a PMIC
      spi-geni-qcom: Add new interfaces and utilise them
      TI TPS6594 PMIC support (RTC, pinctrl, regulators)
      regulator: mt6358: Remove bogus regulators and
      regulator: ltc3589: Use maple tree register cache
      regulator: ltc3676: Use maple tree register cache
      Add Renesas PMIC RAA215300 and built-in RTC

Martin Botka (2):
      mfd: axp20x: Add support for AXP313a PMIC
      regulator: axp20x: Add support for AXP313a variant

Mårten Lindahl (2):
      regulator: dt-bindings: Add bindings for TPS6287x
      regulator: Add support for TI TPS6287x regulators

Rob Herring (1):
      regulator: dt-bindings: pwm-regulator: Add missing type for "pwm-dutycycle-unit"

Sebastian Reichel (14):
      clk: RK808: Reduce 'struct rk808' usage
      mfd: rk808: Convert to device managed resources
      mfd: rk808: Use dev_err_probe
      mfd: rk808: Replace 'struct i2c_client' with 'struct device'
      mfd: rk808: Split into core and i2c
      mfd: rk8xx-i2c: Use device_get_match_data
      dt-bindings: mfd: Add rk806 binding
      mfd: rk8xx: Add rk806 support
      pinctrl: rk805: Add rk806 pinctrl support
      regulator: expose regulator_find_closest_bigger
      regulator: rk808: fix asynchronous probing
      regulator: rk808: cleanup parent device usage
      regulator: rk808: revert to synchronous probing
      regulator: rk808: add rk806 support

Shengyu Qu (1):
      regulator: axp20x: Add AXP15060 support

Uwe Kleine-König (2):
      regulator: Switch i2c drivers back to use .probe()
      regulator: Switch two more i2c drivers back to use .probe()

Vijaya Krishna Nivarthi (2):
      soc: qcom: geni-se: Add interfaces geni_se_tx_init_dma() and geni_se_rx_init_dma()
      spi: spi-geni-qcom: Do not do DMA map/unmap inside driver, use framework instead

 .../devicetree/bindings/mfd/rockchip,rk806.yaml    |  406 ++++++++
 .../bindings/regulator/mt6358-regulator.txt        |   34 +-
 .../devicetree/bindings/regulator/pfuze100.yaml    |    3 +
 .../bindings/regulator/pwm-regulator.yaml          |    1 +
 .../bindings/regulator/renesas,raa215300.yaml      |   85 ++
 .../devicetree/bindings/regulator/ti,tps62870.yaml |   52 +
 drivers/clk/Kconfig                                |    2 +-
 drivers/clk/clk-rk808.c                            |   34 +-
 drivers/input/misc/Kconfig                         |    2 +-
 drivers/mfd/Kconfig                                |   53 +-
 drivers/mfd/Makefile                               |    7 +-
 drivers/mfd/axp20x-i2c.c                           |    2 +
 drivers/mfd/axp20x.c                               |   78 +-
 drivers/mfd/{rk808.c => rk8xx-core.c}              |  352 +++----
 drivers/mfd/rk8xx-i2c.c                            |  185 ++++
 drivers/mfd/rk8xx-spi.c                            |  124 +++
 drivers/mfd/tps6594-core.c                         |  462 +++++++++
 drivers/mfd/tps6594-i2c.c                          |  244 +++++
 drivers/mfd/tps6594-spi.c                          |  129 +++
 drivers/pinctrl/Kconfig                            |    2 +-
 drivers/pinctrl/pinctrl-rk805.c                    |  189 +++-
 drivers/power/supply/Kconfig                       |    2 +-
 drivers/regulator/88pg86x.c                        |    2 +-
 drivers/regulator/Kconfig                          |   33 +-
 drivers/regulator/Makefile                         |    3 +
 drivers/regulator/act8865-regulator.c              |    2 +-
 drivers/regulator/ad5398.c                         |    2 +-
 drivers/regulator/axp20x-regulator.c               |  290 +++++-
 drivers/regulator/core.c                           |   30 +-
 drivers/regulator/da9121-regulator.c               |    2 +-
 drivers/regulator/da9210-regulator.c               |    2 +-
 drivers/regulator/da9211-regulator.c               |    2 +-
 drivers/regulator/fan53555.c                       |    2 +-
 drivers/regulator/fan53880.c                       |    2 +-
 drivers/regulator/helpers.c                        |   23 +-
 drivers/regulator/isl6271a-regulator.c             |    2 +-
 drivers/regulator/isl9305.c                        |    2 +-
 drivers/regulator/lp3971.c                         |    2 +-
 drivers/regulator/lp3972.c                         |    2 +-
 drivers/regulator/lp872x.c                         |    2 +-
 drivers/regulator/lp8755.c                         |    2 +-
 drivers/regulator/ltc3589.c                        |    4 +-
 drivers/regulator/ltc3676.c                        |    4 +-
 drivers/regulator/max1586.c                        |    2 +-
 drivers/regulator/max20086-regulator.c             |    2 +-
 drivers/regulator/max20411-regulator.c             |    2 +-
 drivers/regulator/max77826-regulator.c             |    2 +-
 drivers/regulator/max8649.c                        |    2 +-
 drivers/regulator/max8660.c                        |    2 +-
 drivers/regulator/max8893.c                        |    2 +-
 drivers/regulator/max8952.c                        |    2 +-
 drivers/regulator/max8973-regulator.c              |    2 +-
 drivers/regulator/mcp16502.c                       |    2 +-
 drivers/regulator/mp5416.c                         |    2 +-
 drivers/regulator/mp8859.c                         |    2 +-
 drivers/regulator/mp886x.c                         |    2 +-
 drivers/regulator/mpq7920.c                        |    2 +-
 drivers/regulator/mt6311-regulator.c               |    2 +-
 drivers/regulator/mt6358-regulator.c               |  221 ++---
 drivers/regulator/pca9450-regulator.c              |    2 +-
 drivers/regulator/pf8x00-regulator.c               |    2 +-
 drivers/regulator/pfuze100-regulator.c             |    2 +-
 drivers/regulator/pv88060-regulator.c              |    2 +-
 drivers/regulator/pv88080-regulator.c              |    2 +-
 drivers/regulator/pv88090-regulator.c              |    2 +-
 drivers/regulator/raa215300.c                      |  190 ++++
 drivers/regulator/rk808-regulator.c                |  399 +++++++-
 drivers/regulator/rpi-panel-attiny-regulator.c     |    2 +-
 drivers/regulator/rt4801-regulator.c               |    2 +-
 drivers/regulator/rt5190a-regulator.c              |    2 +-
 drivers/regulator/rt5739.c                         |    2 +-
 drivers/regulator/rt5759-regulator.c               |    2 +-
 drivers/regulator/rt6160-regulator.c               |    2 +-
 drivers/regulator/rt6190-regulator.c               |    2 +-
 drivers/regulator/rt6245-regulator.c               |    2 +-
 drivers/regulator/rtmv20-regulator.c               |    2 +-
 drivers/regulator/rtq2134-regulator.c              |    2 +-
 drivers/regulator/rtq6752-regulator.c              |    2 +-
 drivers/regulator/slg51000-regulator.c             |    2 +-
 drivers/regulator/stm32-pwr.c                      |    2 +-
 drivers/regulator/sy8106a-regulator.c              |    2 +-
 drivers/regulator/sy8824x.c                        |    2 +-
 drivers/regulator/sy8827n.c                        |    2 +-
 drivers/regulator/tps51632-regulator.c             |    2 +-
 drivers/regulator/tps62360-regulator.c             |    2 +-
 drivers/regulator/tps6286x-regulator.c             |    2 +-
 drivers/regulator/tps6287x-regulator.c             |  189 ++++
 drivers/regulator/tps65023-regulator.c             |    2 +-
 drivers/regulator/tps65132-regulator.c             |    2 +-
 drivers/regulator/tps65219-regulator.c             |    6 +-
 drivers/regulator/tps6594-regulator.c              |  615 ++++++++++++
 drivers/rtc/Kconfig                                |    2 +-
 drivers/soc/qcom/qcom-geni-se.c                    |   67 +-
 drivers/spi/spi-geni-qcom.c                        |  103 +-
 include/linux/mfd/axp20x.h                         |   32 +
 include/linux/mfd/rk808.h                          |  417 +++++++-
 include/linux/mfd/tps6594.h                        | 1020 ++++++++++++++++++++
 include/linux/regulator/driver.h                   |    2 +
 include/linux/regulator/mt6358-regulator.h         |   10 +-
 include/linux/soc/qcom/geni-se.h                   |    4 +
 sound/soc/codecs/Kconfig                           |    2 +-
 101 files changed, 5618 insertions(+), 608 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mfd/rockchip,rk806.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/renesas,raa215300.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps62870.yaml
 rename drivers/mfd/{rk808.c => rk8xx-core.c} (71%)
 create mode 100644 drivers/mfd/rk8xx-i2c.c
 create mode 100644 drivers/mfd/rk8xx-spi.c
 create mode 100644 drivers/mfd/tps6594-core.c
 create mode 100644 drivers/mfd/tps6594-i2c.c
 create mode 100644 drivers/mfd/tps6594-spi.c
 create mode 100644 drivers/regulator/raa215300.c
 create mode 100644 drivers/regulator/tps6287x-regulator.c
 create mode 100644 drivers/regulator/tps6594-regulator.c
 create mode 100644 include/linux/mfd/tps6594.h
