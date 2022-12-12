Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B54F864A417
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 16:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232153AbiLLPYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 10:24:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbiLLPYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 10:24:31 -0500
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C510DF58;
        Mon, 12 Dec 2022 07:24:30 -0800 (PST)
Received: by mail-oo1-f49.google.com with SMTP id q6-20020a4aa886000000b004a083f945a6so1837221oom.6;
        Mon, 12 Dec 2022 07:24:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U9vvltcv5wxjWDhBIfy38FOJpmhKUapf8pGAmTOFydI=;
        b=XxhbmD20WuiNpjJdLRvJtFaKLk79emlhlhDkOz5sEd67JNzTVdObjDm5a/dXDW7OzF
         qhMbotgmJFRrSLUdT25wcaxtcEDN0VAGqD+zjhaRiL/+9IkA6ic6DrzHGahFct4y06cA
         dfkfQ5aeCxE5HbvZSid01uwalFn5bmU83fm8SOdI0vIFeO/rH0zVwC5OF6BzK7Udyhay
         fEO3lIsoXG4g3RBNvPEMqhgcwfjAUBJHQGg+FOQipfFD2tIBmm2FV7tjCt6sRVGXbybT
         pd1BBlewC7Ikud0D58fdGLWo4+2PLIA7TsTuki5jmMlcFUhVDF3lagC7YvaYZyRzQxKY
         pdew==
X-Gm-Message-State: ANoB5pkCz5nON19tiDjLP0VOQIW06qfm1VLV+lmph0T2mN6lczFf1JBe
        q9iAbirTFdD+2QY7EBPEwQ==
X-Google-Smtp-Source: AA0mqf5WDXCcM/VPC+bmUObEcmxV5mKI1uT3TCPIdYCTEx63Y3EIMn1xUuMxt6TmDaA7bT/cF8gxAg==
X-Received: by 2002:a05:6820:1524:b0:480:b5c7:b84a with SMTP id ay36-20020a056820152400b00480b5c7b84amr7462907oob.7.1670858669168;
        Mon, 12 Dec 2022 07:24:29 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z69-20020a4a4948000000b0049f3f5afcbasm32977ooa.13.2022.12.12.07.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 07:24:28 -0800 (PST)
Received: (nullmailer pid 993864 invoked by uid 1000);
        Mon, 12 Dec 2022 15:24:28 -0000
Date:   Mon, 12 Dec 2022 09:24:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.2
Message-ID: <20221212152428.GA948323-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull Devicetree updates for v6.2. There's a few fixes and 
cleanups on top that missed the last linux-next tree.

The 'dt/dtbo-rename' branch has also been pulled into the SoC tree DT 
changes.


Note that I'm planning a 2nd PR with a bunch of partially scripted 
binding changes as shown here[1]. It's a bunch of 1 line changes 
throughout the bindings that's easiest done as an end of the merge 
window thing. I'll send it once all the dependencies are merged.

Rob

[1] https://lore.kernel.org/all/20221121110615.97962-1-krzysztof.kozlowski@linaro.org/


The following changes since commit 9abf2313adc1ca1b6180c508c25f22f9395cc780:

  Linux 6.1-rc1 (2022-10-16 15:36:24 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2

for you to fetch changes up to 580f9896e088b399fc79f1421e56a1b68f0450b5:

  dt-bindings: leds: Add missing references to common LED schema (2022-12-11 19:06:39 -0600)

----------------------------------------------------------------
Devicetree updates for v6.2:

DT Bindings:
- Various LED binding conversions and clean-ups. Convert the ir-spi-led,
  pwm-ir-tx, and gpio-ir-tx LED bindings to schemas. Consistently
  reference LED common.yaml or multi-led schemas and disallow undefined
  properties.

- Convert IDT 89HPESx, pwm-clock, st,stmipid02, Xilinx PCIe hosts,
  and fsl,imx-fb bindings to schema

- Add ata-generic, Broadcom u-boot environment, and dynamic MTD
  sub-partitions bindings.

- Make all SPI based displays reference spi-peripheral-props.yaml

- Fix some schema property regex's which should be fixed strings or were
  missing start/end anchors

- Remove 'status' in examples, again...

DT Core:
- Fix a possible NULL dereference in overlay functions

- Fix kexec reading 32-bit "linux,initrd-{start,end}" values (which
  never worked)

- Add of_address_count() helper to count number of 'reg' entries

- Support .dtso extension for DT overlay source files. Rename staging
  and unittest overlay files.

- Update dtc to upstream v1.6.1-63-g55778a03df61

----------------------------------------------------------------
Adam Skladowski (1):
      dt-bindings: thermal: tsens: Add SM6115 compatible

Alexander Stein (1):
      dt-bindings: lcdif: Fix constraints for imx8mp

Alexandre Torgue (1):
      scripts: dtc: only show unique unit address warning for enabled nodes

Andrew Davis (3):
      kbuild: Allow DTB overlays to built from .dtso named source files
      kbuild: Allow DTB overlays to built into .dtbo.S files
      staging: pi433: overlay: Rename overlay source file from .dts to .dtso

André Apitzsch (1):
      dt-bindings: leds: sgm3140: Document ocp8110 compatible

Christian Göttsche (1):
      of: declare string literals const

Frank Rowand (1):
      of: overlay: rename overlay source files from .dts to .dtso

Geert Uytterhoeven (1):
      dt-bindings: iommu: renesas,ipmmu-vmsa: R-Car V3U is R-Car Gen4

Krzysztof Kozlowski (10):
      dt-bindings: display: panel: use spi-peripheral-props.yaml
      dt-bindings: leds: use unevaluatedProperties for common.yaml
      dt-bindings: leds: lp55xx: allow label
      dt-bindings: leds: lp55xx: switch to preferred 'gpios' suffix
      dt-bindings: leds: lp55xx: rework to match multi-led
      dt-bindings: leds: mt6360: rework to match multi-led
      dt-bindings: leds: irled: gpio-ir-tx: convert to DT schema
      dt-bindings: leds: irled: pwm-ir-tx: convert to DT schema
      dt-bindings: leds: irled: ir-spi-led: convert to DT schema
      dt-bindings: Drop Jee Heng Sia

Luca Weiss (1):
      dt-bindings: qcom,pdc: Add missing compatibles

Marek Vasut (1):
      dt-bindings: media: st,stmipid02: Convert the text bindings to YAML

Matt Ranostay (1):
      dt-bindings: ufs: cdns,ufshc: add missing dma-coherent field

Rafał Miłecki (2):
      dt-bindings: mtd: partitions: u-boot: allow dynamic subpartitions
      dt-bindings: nvmem: u-boot,env: add Broadcom's variant binding

Rob Herring (15):
      dt-bindings: misc: Convert IDT 89HPESx to DT schema
      dt-bindings: clock: Convert pwm-clock to DT schema
      dt-bindings: Remove "status" from schema examples, again
      dt-bindings: ata: Add 'ata-generic' binding
      Merge branch 'dt/dtbo-rename' into dt/next
      scripts/dtc: Update to upstream version v1.6.1-63-g55778a03df61
      dt-bindings: thermal: thermal-idle: Fix example paths
      dt-bindings: Drop type from 'cpus' property
      dt-bindings: Move fixed string node names under 'properties'
      dt-bindings: Add missing start and/or end of line regex anchors
      of/kexec: Fix reading 32-bit "linux,initrd-{start,end}" values
      dt-bindings: thermal: cooling-devices: Add missing cache related properties
      media: dt-bindings: atmel,isc: Drop unneeded unevaluatedProperties
      dt-bindings: leds: intel,lgm: Add missing 'led-gpios' property
      dt-bindings: leds: Add missing references to common LED schema

Thippeswamy Havalige (2):
      dt-bindings: PCI: xilinx-pcie: Convert to YAML schemas of Xilinx AXI PCIe Root Port Bridge
      dt-bindings: PCI: xilinx-nwl: Convert to YAML schemas of Xilinx NWL PCIe Root Port Bridge

Uwe Kleine-König (2):
      of: unittest: Convert to i2c's .probe_new()
      dt-bindings: display: Convert fsl,imx-fb.txt to dt-schema

Yang Yingliang (2):
      of/address: introduce of_address_count() helper
      of/platform: use of_address_count() helper

ruanjinjie (1):
      of: overlay: fix null pointer dereferencing in find_dup_cset_node_entry() and find_dup_cset_prop()

 .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |   1 -
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |  54 +++----
 .../devicetree/bindings/ata/ata-generic.yaml       |  58 +++++++
 .../devicetree/bindings/clock/pwm-clock.txt        |  26 ---
 .../devicetree/bindings/clock/pwm-clock.yaml       |  45 ++++++
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |   2 +-
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  29 +++-
 .../devicetree/bindings/display/imx/fsl,imx-fb.txt |  57 -------
 .../bindings/display/imx/fsl,imx-lcdc.yaml         | 102 ++++++++++++
 .../bindings/display/panel/ilitek,ili9163.yaml     |   3 +-
 .../bindings/display/panel/ilitek,ili9341.yaml     |   1 +
 .../bindings/display/panel/nec,nl8048hl11.yaml     |   3 +-
 .../bindings/display/panel/samsung,lms380kf01.yaml |   5 +-
 .../bindings/display/panel/samsung,lms397kf04.yaml |   3 +-
 .../bindings/display/panel/samsung,s6d27a1.yaml    |   4 +-
 .../bindings/display/panel/tpo,tpg110.yaml         |   1 +
 .../display/tegra/nvidia,tegra124-dpaux.yaml       |   1 -
 .../display/tegra/nvidia,tegra186-display.yaml     |   2 -
 .../devicetree/bindings/dma/snps,dw-axi-dmac.yaml  |   1 -
 .../devicetree/bindings/hwmon/adt7475.yaml         |   4 +-
 .../bindings/iio/addac/adi,ad74413r.yaml           |   1 -
 .../bindings/interrupt-controller/apple,aic.yaml   |   1 -
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   4 +
 .../bindings/iommu/renesas,ipmmu-vmsa.yaml         |   6 +-
 .../devicetree/bindings/leds/irled/gpio-ir-tx.txt  |  14 --
 .../devicetree/bindings/leds/irled/gpio-ir-tx.yaml |  36 +++++
 .../devicetree/bindings/leds/irled/ir-spi-led.yaml |  61 +++++++
 .../devicetree/bindings/leds/irled/pwm-ir-tx.txt   |  13 --
 .../devicetree/bindings/leds/irled/pwm-ir-tx.yaml  |  34 ++++
 .../devicetree/bindings/leds/irled/spi-ir-led.txt  |  29 ----
 .../devicetree/bindings/leds/issi,is31fl319x.yaml  |   1 +
 .../devicetree/bindings/leds/leds-aw2013.yaml      |   1 +
 .../devicetree/bindings/leds/leds-gpio.yaml        |   2 +-
 .../devicetree/bindings/leds/leds-lgm.yaml         |  10 +-
 .../devicetree/bindings/leds/leds-lp50xx.yaml      |   8 +
 .../devicetree/bindings/leds/leds-lp55xx.yaml      |  47 +++++-
 .../devicetree/bindings/leds/leds-max77650.yaml    |   9 +-
 .../devicetree/bindings/leds/leds-mt6360.yaml      |  43 ++++-
 .../devicetree/bindings/leds/leds-pwm.yaml         |   2 +-
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    |  12 +-
 .../devicetree/bindings/leds/leds-rt4505.yaml      |   1 +
 .../devicetree/bindings/leds/leds-sgm3140.yaml     |   5 +-
 .../bindings/leds/rohm,bd71828-leds.yaml           |  16 +-
 .../devicetree/bindings/leds/ti,tca6507.yaml       |   2 +-
 .../devicetree/bindings/media/atmel,isc.yaml       |   4 +-
 .../bindings/media/i2c/st,st-mipid02.txt           |  82 ----------
 .../bindings/media/i2c/st,st-mipid02.yaml          | 176 +++++++++++++++++++++
 .../devicetree/bindings/misc/idt,89hpesx.yaml      |  72 +++++++++
 .../devicetree/bindings/misc/idt_89hpesx.txt       |  44 ------
 .../devicetree/bindings/mtd/partitions/u-boot.yaml |   7 +
 .../devicetree/bindings/net/cdns,macb.yaml         |   1 -
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   1 -
 .../devicetree/bindings/nvmem/u-boot,env.yaml      |  21 +++
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |   4 +-
 .../bindings/pci/mediatek,mt7621-pcie.yaml         |   2 +-
 .../bindings/pci/renesas,pci-rcar-gen2.yaml        |   2 +-
 .../devicetree/bindings/pci/xilinx-nwl-pcie.txt    |  73 ---------
 .../devicetree/bindings/pci/xilinx-pcie.txt        |  88 -----------
 .../bindings/pci/xlnx,axi-pcie-host.yaml           |  88 +++++++++++
 .../devicetree/bindings/pci/xlnx,nwl-pcie.yaml     | 149 +++++++++++++++++
 .../devicetree/bindings/perf/arm,dsu-pmu.yaml      |   3 -
 .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |  15 +-
 .../devicetree/bindings/power/renesas,apmu.yaml    |   6 +-
 .../devicetree/bindings/regulator/max8660.yaml     |   2 +-
 .../bindings/regulator/maxim,max77802.yaml         |   2 +-
 .../devicetree/bindings/regulator/regulator.yaml   |   2 +-
 .../bindings/regulator/rohm,bd9576-regulator.yaml  |   2 +-
 .../devicetree/bindings/regulator/ti,tps65219.yaml |  14 +-
 .../bindings/sound/intel,keembay-i2s.yaml          |   3 +-
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |  64 ++++----
 .../bindings/spi/nvidia,tegra210-quad.yaml         |   2 +-
 .../devicetree/bindings/thermal/qcom-lmh.yaml      |   2 +-
 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 .../bindings/thermal/thermal-cooling-devices.yaml  |   4 +
 .../devicetree/bindings/thermal/thermal-idle.yaml  | 154 +++++++++---------
 .../devicetree/bindings/ufs/cdns,ufshc.yaml        |   2 +
 MAINTAINERS                                        |   4 +-
 drivers/of/kexec.c                                 |  10 +-
 drivers/of/overlay.c                               |   4 +-
 drivers/of/platform.c                              |   5 +-
 drivers/of/unittest-data/Makefile                  |  66 ++++----
 .../of/unittest-data/{overlay.dts => overlay.dtso} |   0
 .../{overlay_0.dts => overlay_0.dtso}              |   0
 .../{overlay_1.dts => overlay_1.dtso}              |   0
 .../{overlay_10.dts => overlay_10.dtso}            |   0
 .../{overlay_11.dts => overlay_11.dtso}            |   0
 .../{overlay_12.dts => overlay_12.dtso}            |   0
 .../{overlay_13.dts => overlay_13.dtso}            |   0
 .../{overlay_15.dts => overlay_15.dtso}            |   0
 .../{overlay_16.dts => overlay_16.dtso}            |   0
 .../{overlay_17.dts => overlay_17.dtso}            |   0
 .../{overlay_18.dts => overlay_18.dtso}            |   0
 .../{overlay_19.dts => overlay_19.dtso}            |   0
 .../{overlay_2.dts => overlay_2.dtso}              |   0
 .../{overlay_20.dts => overlay_20.dtso}            |   0
 .../{overlay_3.dts => overlay_3.dtso}              |   0
 .../{overlay_4.dts => overlay_4.dtso}              |   0
 .../{overlay_5.dts => overlay_5.dtso}              |   0
 .../{overlay_6.dts => overlay_6.dtso}              |   0
 .../{overlay_7.dts => overlay_7.dtso}              |   0
 .../{overlay_8.dts => overlay_8.dtso}              |   0
 .../{overlay_9.dts => overlay_9.dtso}              |   0
 ..._dup_node.dts => overlay_bad_add_dup_node.dtso} |   0
 ..._dup_prop.dts => overlay_bad_add_dup_prop.dtso} |   0
 ...ay_bad_phandle.dts => overlay_bad_phandle.dtso} |   0
 ...rlay_bad_symbol.dts => overlay_bad_symbol.dtso} |   0
 .../{overlay_base.dts => overlay_base.dtso}        |   0
 .../{overlay_gpio_01.dts => overlay_gpio_01.dtso}  |   0
 ...{overlay_gpio_02a.dts => overlay_gpio_02a.dtso} |   0
 ...{overlay_gpio_02b.dts => overlay_gpio_02b.dtso} |   0
 .../{overlay_gpio_03.dts => overlay_gpio_03.dtso}  |   0
 ...{overlay_gpio_04a.dts => overlay_gpio_04a.dtso} |   0
 ...{overlay_gpio_04b.dts => overlay_gpio_04b.dtso} |   0
 .../{testcases.dts => testcases.dtso}              |   0
 drivers/of/unittest.c                              |  58 ++++---
 .../{pi433-overlay.dts => pi433-overlay.dtso}      |   0
 .../pi433/Documentation/devicetree/pi433.txt       |   6 +-
 include/linux/of.h                                 |   4 +-
 include/linux/of_address.h                         |  11 ++
 scripts/Makefile.lib                               |  35 +++-
 scripts/dtc/checks.c                               |  15 +-
 scripts/dtc/dtc-lexer.l                            |   2 +-
 scripts/dtc/dtc-parser.y                           |  13 ++
 scripts/dtc/libfdt/fdt.c                           |  20 ++-
 scripts/dtc/libfdt/fdt.h                           |   4 +-
 scripts/dtc/libfdt/fdt_addresses.c                 |   2 +-
 scripts/dtc/libfdt/fdt_overlay.c                   |  29 +---
 scripts/dtc/libfdt/fdt_ro.c                        |   2 +-
 scripts/dtc/libfdt/libfdt.h                        |  25 +++
 scripts/dtc/livetree.c                             |  39 ++++-
 scripts/dtc/util.c                                 |  15 +-
 scripts/dtc/util.h                                 |   4 +-
 scripts/dtc/version_gen.h                          |   2 +-
 134 files changed, 1444 insertions(+), 785 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/ata/ata-generic.yaml
 delete mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.txt
 create mode 100644 Documentation/devicetree/bindings/clock/pwm-clock.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx-lcdc.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.txt
 create mode 100644 Documentation/devicetree/bindings/leds/irled/gpio-ir-tx.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.txt
 create mode 100644 Documentation/devicetree/bindings/leds/irled/pwm-ir-tx.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/irled/spi-ir-led.txt
 delete mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.txt
 create mode 100644 Documentation/devicetree/bindings/media/i2c/st,st-mipid02.yaml
 create mode 100644 Documentation/devicetree/bindings/misc/idt,89hpesx.yaml
 delete mode 100644 Documentation/devicetree/bindings/misc/idt_89hpesx.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-nwl-pcie.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/xilinx-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,axi-pcie-host.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/xlnx,nwl-pcie.yaml
 rename drivers/of/unittest-data/{overlay.dts => overlay.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_0.dts => overlay_0.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_1.dts => overlay_1.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_10.dts => overlay_10.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_11.dts => overlay_11.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_12.dts => overlay_12.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_13.dts => overlay_13.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_15.dts => overlay_15.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_16.dts => overlay_16.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_17.dts => overlay_17.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_18.dts => overlay_18.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_19.dts => overlay_19.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_2.dts => overlay_2.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_20.dts => overlay_20.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_3.dts => overlay_3.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_4.dts => overlay_4.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_5.dts => overlay_5.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_6.dts => overlay_6.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_7.dts => overlay_7.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_8.dts => overlay_8.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_9.dts => overlay_9.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_node.dts => overlay_bad_add_dup_node.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_add_dup_prop.dts => overlay_bad_add_dup_prop.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_phandle.dts => overlay_bad_phandle.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_bad_symbol.dts => overlay_bad_symbol.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_base.dts => overlay_base.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_01.dts => overlay_gpio_01.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02a.dts => overlay_gpio_02a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_02b.dts => overlay_gpio_02b.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_03.dts => overlay_gpio_03.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04a.dts => overlay_gpio_04a.dtso} (100%)
 rename drivers/of/unittest-data/{overlay_gpio_04b.dts => overlay_gpio_04b.dtso} (100%)
 rename drivers/of/unittest-data/{testcases.dts => testcases.dtso} (100%)
 rename drivers/staging/pi433/Documentation/devicetree/{pi433-overlay.dts => pi433-overlay.dtso} (100%)
