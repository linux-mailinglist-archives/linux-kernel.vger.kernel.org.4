Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1394069F914
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 17:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjBVQe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 11:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232506AbjBVQew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 11:34:52 -0500
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DD838E80;
        Wed, 22 Feb 2023 08:34:42 -0800 (PST)
Received: by mail-oo1-f48.google.com with SMTP id t5-20020a4ac885000000b005251f70a740so29550ooq.8;
        Wed, 22 Feb 2023 08:34:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g/SR73aUawVxhbH1sQFEYsvzVayf20Sq/WLFT+Ikiro=;
        b=4X9Q32x0WYZbjVSSM5NheH10HGB04aGALHr+u0BWuHLDok9gbk27EF2J/WHJqvbx+R
         T76ikvPyNQWk+Ed0dASrf8rKXChW//vQaipwv+lIpKt6qNPDLNDxvAaunQYRJXwUlRyQ
         o/uxroSyxemkiys6ZcehyfwRPTCwRzsrTtqr8j7MH6keN/lbmDUnz1cykoYrdCSPTKbt
         PfjVtpCaDp61fWM1Q8P0Dvfg5QilnjteNMlEiLLHda5GfPBfc8RLcl6knQdOMi7aRkFh
         ATLoJDCSRCGPJyXUKZqwiYLgvUjVGC51cvSVmhTgzETPgZ0+nDyn0UH+VaSMwyJupXXa
         nnpg==
X-Gm-Message-State: AO0yUKVB4kiGHqen5Wp0Edd7SiErLkllEN5pYk9GLPyegIggj/YsCYfP
        7IxObsLzfQVuTdQiuJv98GIOXaM93Q==
X-Google-Smtp-Source: AK7set+zMkCwBEwg+9S0s6AmTZGr7MAMM+uh7zL00IRmfT5ZXT+F7IHJ+Gggxh5Ut5pXKzn4lrbsWg==
X-Received: by 2002:a4a:942d:0:b0:520:f76:11e2 with SMTP id h42-20020a4a942d000000b005200f7611e2mr3670266ooi.9.1677083681939;
        Wed, 22 Feb 2023 08:34:41 -0800 (PST)
Received: from robh_at_kernel.org ([2605:ef80:80f1:516e:12e0:dc8f:f6a1:9049])
        by smtp.gmail.com with ESMTPSA id k4-20020a4aa5c4000000b0052037988717sm4800369oom.4.2023.02.22.08.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Feb 2023 08:34:41 -0800 (PST)
Received: (nullmailer pid 13694 invoked by uid 1000);
        Wed, 22 Feb 2023 16:34:40 -0000
Date:   Wed, 22 Feb 2023 10:34:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.3
Message-ID: <20230222163440.GA11643-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
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

Please pull DT updates for 6.3.

Rob


The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.3

for you to fetch changes up to 1ba7dfb905b3975bdb8b9d1f7793efcdfc59385b:

  dt-bindings: regulator: Add mps,mpq7932 power-management IC (2023-02-21 16:56:28 -0600)

----------------------------------------------------------------
Devicetree updates for v6.3:

DT core:
- Add node lifecycle unit tests

- Add of_property_present() helper aligned with fwnode API

- Print more information on reserved regions on boot

- Update dtc to upstream v1.6.1-66-gabbd523bae6e

- Use strscpy() to instead of strncpy() in DT core

- Add option for schema validation on %.dtb targets

Bindings:
- Add/fix support for listing multiple patterns in DT_SCHEMA_FILES

- Rework external memory controller/bus bindings to properly support
  controller specific child node properties

- Convert loongson,ls1x-intc, fcs,fusb302, sil,sii8620, Rockchip RK3399
  PCIe, Synquacer I2C, and Synquacer EXIU bindings to DT schema format

- Add RiscV SBI PMU event mapping binding

- Add missing contraints on Arm SCMI child node allowed properties

- Add a bunch of missing Socionext UniPhier glue block bindings and
  example fixes

- Various fixes for duplicate or conflicting type definitions on DT
  properties

----------------------------------------------------------------
Clément Léger (1):
      of/irq: add missing of_node_put() for interrupt parent node

Colin Foster (1):
      dt-bindings: memory-controllers: ti,gpmc: fix typo in description

Colin Ian King (1):
      of: dynamic: Fix spelling mistake "kojbect" -> "kobject"

Conor Dooley (2):
      dt-bindings: riscv: add SBI PMU event mappings
      dt-bindings: drop Sagar Kadam from SiFive binding maintainership

Cristian Ciocaltea (1):
      dt-bindings: Fix multi pattern support in DT_SCHEMA_FILES

Etienne Carriere (1):
      dt-binding: gpio: publish binding IDs under dual license

Frank Rowand (7):
      of: prepare to add processing of EXPECT_NOT to of_unittest_expect
      of: add processing of EXPECT_NOT to of_unittest_expect
      of: update kconfig unittest help
      of: unittest: add node lifecycle tests
      of: do not use "%pOF" printk format on node with refcount of zero
      of: add consistency check to of_node_release()
      of: dynamic: add lifecycle docbook info to node creation functions

Geert Uytterhoeven (1):
      of: reserved_mem: Use proper binary prefix

Johan Jonker (1):
      dt-bindings: usb: convert fcs,fusb302.txt to yaml

Keguang Zhang (1):
      dt-bindings: interrupt-controller: convert loongson,ls1x-intc.txt to json-schema

Konrad Dybcio (1):
      dt-bindings: arm: Add Cortex-A715 and X3

Krzysztof Kozlowski (9):
      dt-bindings: ufs: qcom,ufs: document required-opps
      dt-bindings: clock: qcom,videocc: correct clocks per variant
      dt-bindindgs: i2c: qcom,i2c-geni: document operating-points-v2
      dt-bindings: drop type for operating-points-v2
      dt-bindings: vendor-prefixes: document lineartechnology
      dt-bindings: display: bridge: sil,sii8620: convert to dtschema
      dt-bindings: intel,ixp4xx-expansion-bus: split out peripheral properties
      dt-bindings: reference MC peripheral properties in relevant devices
      dt-bindings: serial: restrict possible child node names

Kunihiko Hayashi (17):
      dt-bindings: clock: Fix node descriptions in uniphier-clock example
      dt-bindings: reset: Fix node descriptions in uniphier-reset example
      dt-bindings: pinctrl: Fix node descriptions in uniphier-pinctrl example
      dt-bindings: regulator: Fix node descriptions in uniphier-regulator example
      dt-bindings: watchdog: Fix node descriptions in uniphier-wdt example
      dt-bindings: thermal: Fix node descriptions in uniphier-thermal example
      dt-bindings: phy: Fix node descriptions in uniphier-phy example
      dt-bindings: nvmem: Fix node descriptions in uniphier-efuse example
      dt-bindings: soc: socionext: Add UniPhier system controller
      dt-bindings: soc: socionext: Add UniPhier SoC-glue logic
      dt-bindings: soc: socionext: Add UniPhier SoC-glue logic debug part
      dt-bindings: soc: socionext: Add UniPhier peripheral block
      dt-bindings: soc: socionext: Add UniPhier media I/O block
      dt-bindings: soc: socionext: Add UniPhier SD interface block
      dt-bindings: soc: socionext: Add UniPhier ADAMV block
      dt-bindings: soc: socionext: Add UniPhier DWC3 USB glue layer
      dt-bindings: soc: socionext: Add UniPhier AHCI glue layer

Martin Liu (1):
      of: reserved-mem: print out reserved-mem details during boot

Mukesh Ojha (1):
      dt-bindings: sram: qcom,imem: document sm8450

Ricardo Ribalda (1):
      of: overlay: Fix trivial typo

Rob Herring (16):
      kbuild: Optionally enable schema checks for %.dtb targets
      dt-bindings: interrupt-controller: Convert Synquacer EXIU to DT schema
      dt-bindings: i2c: Convert Synquacer I2C to DT schema
      dt-bindings: PCI: Convert Rockchip RK3399 PCIe to DT schema
      dt-bindings: soc: socionext,uniphier-soc-glue: Make child node names fixed names
      dt-bindings: display: msm: Drop type from 'memory-region'
      dt-bindings: interrupt-controller: brcm,bcm7120-l2-intc: Fix 'brcm,int-fwd-mask' differing type
      dt-bindings: PCI: ti,j721e-pci-host: Simplify 'device-id' schema
      dt-bindings: reserved-memory: Refine 'size' and 'alignment' types
      dt-bindings: ti,k3: Use common ti,k3-sci-common.yaml schema
      dt-bindings: phy: hisilicon: Fix 'hisilicon,eye-diagram-param' differing types
      dt-bindings: firmware: arm,scmi: Restrict protocol child node properties
      scripts/dtc: Update to upstream version v1.6.1-66-gabbd523bae6e
      of: Add of_property_present() helper
      of: Use of_property_present() helper
      of: Use preferred of_property_read_* functions

Saravanan Sekar (1):
      dt-bindings: regulator: Add mps,mpq7932 power-management IC

Thomas Weißschuh (1):
      of: make of_node_ktype constant

Xu Panda (1):
      of: base: use strscpy() to instead of strncpy()

 Documentation/devicetree/bindings/Makefile         |   2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../bindings/ata/intel,ixp4xx-compact-flash.yaml   |   1 +
 .../devicetree/bindings/clock/qcom,videocc.yaml    |  59 ++++++-
 .../bindings/clock/sifive/fu540-prci.yaml          |   1 -
 .../bindings/clock/socionext,uniphier-clock.yaml   |  39 +----
 .../bindings/display/bridge/sil,sii8620.yaml       | 108 ++++++++++++
 .../bindings/display/bridge/sil-sii8620.txt        |  33 ----
 .../bindings/display/msm/dp-controller.yaml        |   3 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +-
 .../bindings/display/tegra/nvidia,tegra20-dc.yaml  |   3 +-
 .../bindings/display/tegra/nvidia,tegra20-dsi.yaml |   3 +-
 .../bindings/display/tegra/nvidia,tegra20-epp.yaml |   3 +-
 .../display/tegra/nvidia,tegra20-gr2d.yaml         |   3 +-
 .../display/tegra/nvidia,tegra20-gr3d.yaml         |   3 +-
 .../display/tegra/nvidia,tegra20-hdmi.yaml         |   3 +-
 .../display/tegra/nvidia,tegra20-host1x.yaml       |   3 +-
 .../bindings/display/tegra/nvidia,tegra20-mpe.yaml |   3 +-
 .../bindings/display/tegra/nvidia,tegra20-tvo.yaml |   3 +-
 .../bindings/display/tegra/nvidia,tegra20-vi.yaml  |   3 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |   9 +-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |  43 +++--
 .../bindings/fuse/nvidia,tegra20-fuse.yaml         |   3 +-
 .../devicetree/bindings/i2c/i2c-synquacer.txt      |  29 ----
 .../bindings/i2c/qcom,i2c-geni-qcom.yaml           |   2 +
 .../bindings/i2c/socionext,synquacer-i2c.yaml      |  58 +++++++
 .../interrupt-controller/brcm,bcm7120-l2-intc.yaml |   3 +-
 .../interrupt-controller/loongson,ls1x-intc.txt    |  24 ---
 .../interrupt-controller/loongson,ls1x-intc.yaml   |  51 ++++++
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   1 -
 .../socionext,synquacer-exiu.txt                   |  31 ----
 .../socionext,synquacer-exiu.yaml                  |  53 ++++++
 .../intel,ixp4xx-expansion-bus-controller.yaml     |  66 +-------
 .../intel,ixp4xx-expansion-peripheral-props.yaml   |  80 +++++++++
 .../memory-controllers/mc-peripheral-props.yaml    |   1 +
 .../bindings/memory-controllers/ti,gpmc.yaml       |   2 +-
 .../bindings/mmc/nvidia,tegra20-sdhci.yaml         |   3 +-
 .../devicetree/bindings/mtd/mtd-physmap.yaml       |   1 +
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   | 101 ++++++------
 .../bindings/pci/rockchip,rk3399-pcie-common.yaml  |  69 ++++++++
 .../bindings/pci/rockchip,rk3399-pcie-ep.yaml      |  68 ++++++++
 .../bindings/pci/rockchip,rk3399-pcie.yaml         | 132 +++++++++++++++
 .../devicetree/bindings/pci/rockchip-pcie-ep.txt   |  62 -------
 .../devicetree/bindings/pci/rockchip-pcie-host.txt | 135 ---------------
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |  14 +-
 .../devicetree/bindings/perf/riscv,pmu.yaml        | 161 ++++++++++++++++++
 .../bindings/phy/hisilicon,hi3660-usb3.yaml        |   3 +-
 .../bindings/phy/hisilicon,hi3670-usb3.yaml        |   3 +-
 .../bindings/phy/socionext,uniphier-ahci-phy.yaml  |  24 +--
 .../bindings/phy/socionext,uniphier-usb2-phy.yaml  |  41 ++---
 .../phy/socionext,uniphier-usb3hs-phy.yaml         |  29 ++--
 .../phy/socionext,uniphier-usb3ss-phy.yaml         |  26 +--
 .../pinctrl/socionext,uniphier-pinctrl.yaml        |  17 +-
 .../devicetree/bindings/power/power-domain.yaml    |   3 -
 .../bindings/pwm/nvidia,tegra20-pwm.yaml           |   3 +-
 .../devicetree/bindings/pwm/pwm-sifive.yaml        |   1 -
 .../devicetree/bindings/regulator/mps,mpq7932.yaml |  68 ++++++++
 .../regulator/socionext,uniphier-regulator.yaml    |  21 +--
 .../bindings/reserved-memory/reserved-memory.yaml  |  12 +-
 .../reset/socionext,uniphier-glue-reset.yaml       |  23 +--
 .../bindings/reset/socionext,uniphier-reset.yaml   |  52 +-----
 .../devicetree/bindings/riscv/sifive,ccache0.yaml  |   3 +-
 Documentation/devicetree/bindings/serial/8250.yaml |   1 +
 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 .../soc/socionext/socionext,uniphier-adamv.yaml    |  50 ++++++
 .../socionext/socionext,uniphier-ahci-glue.yaml    |  77 +++++++++
 .../socionext/socionext,uniphier-dwc3-glue.yaml    | 106 ++++++++++++
 .../soc/socionext/socionext,uniphier-mioctrl.yaml  |  65 ++++++++
 .../soc/socionext/socionext,uniphier-perictrl.yaml |  64 +++++++
 .../soc/socionext/socionext,uniphier-sdctrl.yaml   |  61 +++++++
 .../socionext,uniphier-soc-glue-debug.yaml         |  68 ++++++++
 .../soc/socionext/socionext,uniphier-soc-glue.yaml | 114 +++++++++++++
 .../soc/socionext/socionext,uniphier-sysctrl.yaml  | 104 ++++++++++++
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |  13 +-
 .../devicetree/bindings/sram/qcom,imem.yaml        |   1 +
 .../thermal/socionext,uniphier-thermal.yaml        |  15 +-
 .../devicetree/bindings/ufs/qcom,ufs.yaml          |   3 +
 .../devicetree/bindings/usb/fcs,fusb302.txt        |  34 ----
 .../devicetree/bindings/usb/fcs,fusb302.yaml       |  67 ++++++++
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/maxim,max63xx.yaml           |   1 +
 .../bindings/watchdog/socionext,uniphier-wdt.yaml  |  10 +-
 MAINTAINERS                                        |   7 +-
 Makefile                                           |   9 +-
 drivers/of/Kconfig                                 |  14 +-
 drivers/of/base.c                                  |   3 +-
 drivers/of/dynamic.c                               |  31 +++-
 drivers/of/irq.c                                   |  12 +-
 drivers/of/kobj.c                                  |   2 +-
 drivers/of/of_reserved_mem.c                       |  10 ++
 drivers/of/overlay.c                               |   2 +-
 drivers/of/platform.c                              |   7 +-
 drivers/of/property.c                              |   4 +-
 drivers/of/unittest-data/testcases_common.dtsi     |   1 +
 drivers/of/unittest-data/tests-lifecycle.dtsi      |   8 +
 drivers/of/unittest.c                              | 150 ++++++++++++++++-
 include/dt-bindings/gpio/gpio.h                    |   2 +-
 include/linux/of.h                                 |  30 +++-
 scripts/dtc/dtc-parser.y                           |  11 +-
 scripts/dtc/libfdt/fdt.h                           |   4 +-
 scripts/dtc/of_unittest_expect                     | 183 ++++++++++++++++++---
 scripts/dtc/version_gen.h                          |   2 +-
 102 files changed, 2336 insertions(+), 825 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/sil,sii8620.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/sil-sii8620.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-synquacer.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/socionext,synquacer-i2c.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/loongson,ls1x-intc.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/socionext,synquacer-exiu.yaml
 rename Documentation/devicetree/bindings/{bus => memory-controllers}/intel,ixp4xx-expansion-bus-controller.yaml (57%)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/intel,ixp4xx-expansion-peripheral-props.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
 delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
 create mode 100644 Documentation/devicetree/bindings/perf/riscv,pmu.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/mps,mpq7932.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-adamv.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-ahci-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-dwc3-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-mioctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-perictrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sdctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue-debug.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-soc-glue.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/socionext/socionext,uniphier-sysctrl.yaml
 delete mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.txt
 create mode 100644 Documentation/devicetree/bindings/usb/fcs,fusb302.yaml
 create mode 100644 drivers/of/unittest-data/tests-lifecycle.dtsi
