Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5626EE9DB
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 23:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236259AbjDYV6V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 17:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236172AbjDYV6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 17:58:18 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFA0DC;
        Tue, 25 Apr 2023 14:58:15 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-546db536a6bso3386577eaf.1;
        Tue, 25 Apr 2023 14:58:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682459894; x=1685051894;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dYSRBdFPA0OFQl/bbju00GCdH/nWb2YF65wOh+IkVso=;
        b=IDSDreDpysAUlQVBwXdiM3kP38NYXvIeV7P+00R6iD73xqXBux1Dm+wZqL0O08z8Ks
         ON7oN325JQ11MzcS659I8ib+mffXkcx/o2uS16fCN7MyyPyfxpbUp+hrnpE7Ur2ks8Rf
         PxTPLNsT+m0OxLdYO+zcwNzghiCtzUcXIN4BlshPrOI7cC6fni0OH5KQBV7PkpItDp+/
         BOnKVZ+N1xI2DS0gupv4JyVg+WGFIe1sLgqo0TH54WSsB+SZY5hfTNGxktHHhnU2ZSbz
         r0Zc4K5k/xqWamKkwTkA5nJwc4xIK1Lka38X0I4SbK3loP6fWd6xCBN1xipFQxO5D+To
         Fz8g==
X-Gm-Message-State: AAQBX9cS/HXMH49gDZUtf5GQm/80X7yCV1y2387xavz8A3tdzKYDi1s6
        huvC6GVnu5U9k5dbjQ5iHA==
X-Google-Smtp-Source: AKy350a7EyJ5x02oqN+V74OhNyE9ur0iSY2qUB11NEI2WN5hMKYmfblHGA81gFi/wt5r5sbf8x8juA==
X-Received: by 2002:a05:6808:140d:b0:38e:360:6c09 with SMTP id w13-20020a056808140d00b0038e03606c09mr10204807oiv.17.1682459894292;
        Tue, 25 Apr 2023 14:58:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q5-20020acac005000000b0038756901d1esm6074271oif.35.2023.04.25.14.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Apr 2023 14:58:14 -0700 (PDT)
Received: (nullmailer pid 2285141 invoked by uid 1000);
        Tue, 25 Apr 2023 21:58:13 -0000
Date:   Tue, 25 Apr 2023 16:58:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL 1/2] Devicetree updates for v6.4
Message-ID: <20230425215813.GA2283722-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull 1/2 DT updates. There's 2 conflicts between the ASoC and ata 
trees. The correct resolution is in linux-next.

Rob

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.4-1

for you to fetch changes up to 66ae0535167660e427f9fcadeee5d05646e2bb22:

  dt-bindings: rng: Drop unneeded quotes (2023-04-20 16:30:03 -0500)

----------------------------------------------------------------
Devicetree updates for v6.4, part 1:

Bindings:
- Convert Qcom IOMMU, Amlogic timer, Freescale sec-v4.0, Toshiba
  TC358764 display bridge, Parade PS8622 display bridge, and  Xilinx
  FPGA bindings to DT schema format

- Add qdu1000 and sa8775p SoC support to Qcom PDC interrupt controller

- Add MediaTek MT8365 UART and SYSIRQ bindings

- Add Arm Cortex-A78C and X1C core compatibles

- Add vendor prefix for Novatek

- Remove bindings for stih415, sti416, stid127 platforms

- Drop uneeded quotes in schema files. This is preparation for yamllint
  checking quoting for us.

- Add missing (unevaluated|additional)Properties constraints on child
  node schemas

- Clean-up schema comments formatting

- Fix I2C and SPI node bus names in schema examples

- Clean-up some display compatibles schema syntax

- Fix incorrect references to lvds.yaml

- Gather all cache controller bindings in a common directory

DT core:
- Convert unittest to new void .remove platform device hook

- kerneldoc fixes for DT address of_pci_range_to_resource/
  of_address_to_resource functions

----------------------------------------------------------------
Alain Volmat (3):
      dt-bindings: irqchip: sti: remove stih415/stih416 and stid127
      dt-bindings: net: dwmac: sti: remove stih415/sti416/stid127
      dt-bindings: reset: remove stih415/stih416 reset

Bartosz Golaszewski (1):
      dt-bindings: interrupt-controller: qcom-pdc: add compatible for sa8775p

Bernhard Rosenkränzer (2):
      dt-bindings: irq: mtk, sysirq: add support for mt8365
      dt-bindings: serial: mediatek,uart: add MT8365

Conor Dooley (1):
      dt-bindings: move cache controller bindings to a cache directory

Fabio Estevam (1):
      dt-bindings: drm/bridge: ti-sn65dsi86: Fix the video-interfaces.yaml references

Geert Uytterhoeven (3):
      of: address: Document return value of of_address_to_resource()
      of: address: Fix documented return value of of_pci_range_to_resource()
      of: address: Reshuffle to remove forward declarations

Konrad Dybcio (2):
      dt-bindings: arm: Add Cortex-A78C and X1C
      dt-bindings: iommu: Convert QCOM IOMMU to YAML

Krzysztof Kozlowski (6):
      dt-bindings: display: bridge: parade,ps8622: convert to dtschema
      dt-bindings: display/bridge: toshiba,tc358764: convert to dtschema
      dt-bindings: vendor-prefixes: document Novatek
      dt-bindings: interrupt-controller: qcom,pdc: document qcom,qdu1000-pdc
      dt-bindings: display: mediatek: simplify compatibles syntax
      dt-bindings: display: simplify compatibles syntax

Nava kishore Manne (2):
      dt-bindings: fpga: xilinx-pr-decoupler: convert bindings to json-schema
      dt-bindings: fpga: xilinx-spi: convert bindings to json-schema

Neil Armstrong (1):
      dt-bindings: timer: convert timer/amlogic,meson6-timer.txt to dt-schema

Peng Fan (1):
      dt-bindings: crypto: sec-v4.0-mon: add snvs power off support

Rob Herring (19):
      dt-bindings: Fix SPI and I2C bus node names in examples
      dt-bindings: yamllint: Require a space after a comment '#'
      dt-bindings: crypto: fsl,sec-v4.0: Convert to DT schema
      dt-bindings: clock: Drop unneeded quotes
      dt-bindings: interrupt-controller: Drop unneeded quotes
      dt-bindings: ata: Drop unneeded quotes
      dt-bindings: reserved-memory: Drop unneeded quotes
      dt-bindings: PCI: Drop unneeded quotes
      dt-bindings: watchdog: Drop unneeded quotes
      dt-bindings: input: Drop unneeded quotes
      dt-bindings: reset: Drop unneeded quotes
      dt-bindings: mailbox: Drop unneeded quotes
      dt-bindings: Add missing (unevaluated|additional)Properties on child node schemas
      dt-bindings: timer: Drop unneeded quotes
      dt-bindings: display: Fix lvds.yaml references
      dt-bindings: i2c: samsung: Fix 'deprecated' value
      dt-bindings: soc: qcom: Drop unneeded quotes
      dt-bindings: arm/soc: mediatek: Drop unneeded quotes
      dt-bindings: rng: Drop unneeded quotes

Uwe Kleine-König (3):
      of: unittest: Drop call to platform_set_drvdata(..., NULL)
      of: unittest: Drop if blocks with always false condition
      of: unittest: Convert to platform remove callback returning void

Vignesh Raghavendra (1):
      dt-bindings: irqchip: ti,sci-inta: Add optional power-domains property

 Documentation/devicetree/bindings/.yamllint        |   2 +-
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |   1 +
 .../arm/bcm/raspberrypi,bcm2835-firmware.yaml      |   5 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +
 .../bindings/arm/mediatek/mediatek,infracfg.yaml   |   4 +-
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |   4 +-
 .../arm/mediatek/mediatek,mt7622-pcie-mirror.yaml  |   4 +-
 .../bindings/arm/mediatek/mediatek,mt7622-wed.yaml |   4 +-
 .../arm/mediatek/mediatek,mt7986-wed-pcie.yaml     |   4 +-
 .../arm/mediatek/mediatek,mt8186-clock.yaml        |   4 +-
 .../arm/mediatek/mediatek,mt8186-sys-clock.yaml    |   4 +-
 .../arm/mediatek/mediatek,mt8192-clock.yaml        |   4 +-
 .../arm/mediatek/mediatek,mt8192-sys-clock.yaml    |   4 +-
 .../arm/mediatek/mediatek,mt8195-clock.yaml        |   4 +-
 .../arm/mediatek/mediatek,mt8195-sys-clock.yaml    |   4 +-
 .../bindings/arm/mediatek/mediatek,pericfg.yaml    |   4 +-
 .../bindings/arm/tegra/nvidia,tegra20-pmc.yaml     |   4 +
 .../devicetree/bindings/ata/ahci-common.yaml       |   6 +-
 .../devicetree/bindings/ata/ahci-platform.yaml     |   2 +-
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml |   4 +-
 .../bindings/auxdisplay/holtek,ht16k33.yaml        |   2 +-
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |   1 +
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |   1 +
 Documentation/devicetree/bindings/bus/palmbus.yaml |   1 +
 .../baikal,bt1-l2-ctl.yaml                         |   2 +-
 .../l2cache.txt => cache/freescale-l2cache.txt}    |   0
 .../devicetree/bindings/{arm => cache}/l2c2x0.yaml |   2 +-
 .../marvell,feroceon-cache.txt}                    |   0
 .../marvell,tauros2-cache.txt}                     |   0
 .../bindings/{arm/msm => cache}/qcom,llcc.yaml     |   2 +-
 .../bindings/{riscv => cache}/sifive,ccache0.yaml  |   2 +-
 .../socionext,uniphier-system-cache.yaml           |   2 +-
 .../bindings/chrome/google,cros-ec-typec.yaml      |   2 +-
 .../chrome/google,cros-kbd-led-backlight.yaml      |   2 +-
 .../devicetree/bindings/clock/arm,syscon-icst.yaml |   4 +-
 .../bindings/clock/mediatek,apmixedsys.yaml        |   4 +-
 .../bindings/clock/mediatek,topckgen.yaml          |   4 +-
 .../devicetree/bindings/clock/qcom,a53pll.yaml     |   4 +-
 .../bindings/clock/renesas,cpg-mssr.yaml           |   4 +-
 .../clock/renesas,rcar-usb2-clock-sel.yaml         |   4 +-
 .../bindings/clock/renesas,rzg2l-cpg.yaml          |   4 +-
 .../bindings/clock/samsung,exynos850-clock.yaml    |   2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |   4 +-
 .../devicetree/bindings/clock/sprd,ums512-clk.yaml |   4 +-
 .../devicetree/bindings/clock/ti,lmk04832.yaml     |   2 +-
 .../bindings/clock/xlnx,clocking-wizard.yaml       |   4 +-
 .../bindings/crypto/fsl,sec-v4.0-mon.yaml          | 156 ++++++
 .../devicetree/bindings/crypto/fsl,sec-v4.0.yaml   | 266 ++++++++++
 .../devicetree/bindings/crypto/fsl-sec4.txt        | 553 ---------------------
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |   4 +-
 .../bindings/display/bridge/analogix,anx7625.yaml  |   5 +-
 .../bindings/display/bridge/anx6345.yaml           |   2 +-
 .../bindings/display/bridge/lontium,lt8912b.yaml   |   2 +-
 .../bindings/display/bridge/nxp,ptn3460.yaml       |   2 +-
 .../bindings/display/bridge/parade,ps8622.yaml     | 115 +++++
 .../devicetree/bindings/display/bridge/ps8622.txt  |  31 --
 .../devicetree/bindings/display/bridge/ps8640.yaml |   2 +-
 .../bindings/display/bridge/sil,sii9234.yaml       |   2 +-
 .../bindings/display/bridge/ti,dlpc3433.yaml       |   2 +-
 .../bindings/display/bridge/ti,sn65dsi86.yaml      |   6 +-
 .../bindings/display/bridge/toshiba,tc358762.yaml  |   2 +-
 .../bindings/display/bridge/toshiba,tc358764.txt   |  35 --
 .../bindings/display/bridge/toshiba,tc358764.yaml  |  89 ++++
 .../bindings/display/bridge/toshiba,tc358768.yaml  |   2 +-
 .../bindings/display/mediatek/mediatek,ccorr.yaml  |   7 +-
 .../bindings/display/mediatek/mediatek,color.yaml  |  10 +-
 .../bindings/display/mediatek/mediatek,dither.yaml |   4 +-
 .../bindings/display/mediatek/mediatek,dsc.yaml    |   4 +-
 .../bindings/display/mediatek/mediatek,gamma.yaml  |   7 +-
 .../bindings/display/mediatek/mediatek,merge.yaml  |   7 +-
 .../bindings/display/mediatek/mediatek,od.yaml     |   7 +-
 .../bindings/display/mediatek/mediatek,ovl-2l.yaml |   7 +-
 .../bindings/display/mediatek/mediatek,ovl.yaml    |  13 +-
 .../display/mediatek/mediatek,postmask.yaml        |   4 +-
 .../bindings/display/mediatek/mediatek,rdma.yaml   |  13 +-
 .../bindings/display/mediatek/mediatek,split.yaml  |   4 +-
 .../bindings/display/mediatek/mediatek,ufoe.yaml   |   4 +-
 .../bindings/display/mediatek/mediatek,wdma.yaml   |   4 +-
 .../devicetree/bindings/display/msm/qcom,mdp5.yaml |   2 +-
 .../devicetree/bindings/display/msm/qcom,mdss.yaml |   4 +
 .../display/panel/advantech,idk-1110wr.yaml        |   2 +-
 .../display/panel/innolux,ee101ia-01d.yaml         |   2 +-
 .../display/panel/mitsubishi,aa104xd12.yaml        |   2 +-
 .../display/panel/mitsubishi,aa121td01.yaml        |   2 +-
 .../bindings/display/panel/nec,nl8048hl11.yaml     |   2 +-
 .../bindings/display/panel/panel-lvds.yaml         |   2 +-
 .../bindings/display/panel/sgd,gktw70sdae4se.yaml  |   2 +-
 .../bindings/display/panel/sharp,lq101r1sx01.yaml  |   4 +-
 .../bindings/display/solomon,ssd1307fb.yaml        |  28 +-
 Documentation/devicetree/bindings/eeprom/at25.yaml |   2 +-
 .../devicetree/bindings/example-schema.yaml        |   2 +
 .../bindings/extcon/extcon-usbc-cros-ec.yaml       |   2 +-
 .../bindings/extcon/extcon-usbc-tusb320.yaml       |   2 +-
 .../bindings/fpga/xilinx-pr-decoupler.txt          |  54 --
 .../bindings/fpga/xilinx-slave-serial.txt          |  51 --
 .../bindings/fpga/xlnx,fpga-slave-serial.yaml      |  80 +++
 .../bindings/fpga/xlnx,pr-decoupler.yaml           |  64 +++
 .../devicetree/bindings/gpio/gpio-pca9570.yaml     |   2 +-
 .../devicetree/bindings/gpio/gpio-pca95xx.yaml     |   8 +-
 .../bindings/gpio/x-powers,axp209-gpio.yaml        |   1 +
 .../devicetree/bindings/hwmon/adi,ltc2992.yaml     |   1 +
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |   2 +-
 .../bindings/i2c/google,cros-ec-i2c-tunnel.yaml    |   2 +-
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |   2 +-
 .../devicetree/bindings/input/adc-joystick.yaml    |   4 +-
 .../bindings/input/google,cros-ec-keyb.yaml        |   2 +-
 .../devicetree/bindings/input/imx-keypad.yaml      |   2 +-
 .../devicetree/bindings/input/matrix-keymap.yaml   |   2 +-
 .../bindings/input/mediatek,mt6779-keypad.yaml     |   2 +-
 .../bindings/input/microchip,cap11xx.yaml          |   4 +-
 .../devicetree/bindings/input/pwm-vibrator.yaml    |   4 +-
 .../bindings/input/regulator-haptic.yaml           |   4 +-
 .../devicetree/bindings/input/snvs-pwrkey.txt      |   1 -
 .../input/touchscreen/elan,elants_i2c.yaml         |   4 +-
 .../devicetree/bindings/interconnect/qcom,rpm.yaml |   1 +
 .../interrupt-controller/actions,owl-sirq.yaml     |   4 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   2 +
 .../bindings/interrupt-controller/arm,gic.yaml     |   4 +-
 .../interrupt-controller/fsl,irqsteer.yaml         |   4 +-
 .../interrupt-controller/intel,ce4100-ioapic.yaml  |   4 +-
 .../interrupt-controller/intel,ce4100-lapic.yaml   |   4 +-
 .../intel,ixp4xx-interrupt.yaml                    |   4 +-
 .../interrupt-controller/loongson,htpic.yaml       |   4 +-
 .../interrupt-controller/loongson,htvec.yaml       |   4 +-
 .../interrupt-controller/loongson,liointc.yaml     |   8 +-
 .../interrupt-controller/loongson,pch-msi.yaml     |  10 +-
 .../interrupt-controller/loongson,pch-pic.yaml     |   6 +-
 .../interrupt-controller/mediatek,sysirq.txt       |   1 +
 .../bindings/interrupt-controller/mrvl,intc.yaml   |   4 +-
 .../mscc,ocelot-icpu-intr.yaml                     |   4 +-
 .../bindings/interrupt-controller/qcom,pdc.yaml    |   4 +-
 .../interrupt-controller/sifive,plic-1.0.0.yaml    |   2 +-
 .../interrupt-controller/st,sti-irq-syscfg.txt     |   9 +-
 .../bindings/interrupt-controller/ti,sci-inta.yaml |   3 +
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 -----
 .../devicetree/bindings/iommu/qcom,iommu.yaml      | 113 +++++
 .../bindings/leds/cznic,turris-omnia-leds.yaml     |   2 +-
 .../devicetree/bindings/leds/issi,is31fl319x.yaml  |   2 +-
 .../devicetree/bindings/leds/leds-aw2013.yaml      |   2 +-
 .../devicetree/bindings/leds/leds-rt4505.yaml      |   2 +-
 .../devicetree/bindings/leds/ti,tca6507.yaml       |   2 +-
 .../bindings/mailbox/amlogic,meson-gxbb-mhu.yaml   |   4 +-
 .../bindings/mailbox/microchip,mpfs-mailbox.yaml   |   4 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   4 +-
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |   4 +-
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |   4 +-
 .../bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml  |   5 +-
 .../bindings/media/i2c/aptina,mt9p031.yaml         |   2 +-
 .../bindings/media/i2c/aptina,mt9v111.yaml         |   2 +-
 .../devicetree/bindings/media/i2c/imx219.yaml      |   2 +-
 .../devicetree/bindings/media/i2c/imx258.yaml      |   4 +-
 .../bindings/media/i2c/maxim,max9286.yaml          |   7 +
 .../devicetree/bindings/media/i2c/mipi-ccs.yaml    |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov5648.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov772x.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov8865.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov9282.yaml |   2 +-
 .../devicetree/bindings/media/i2c/rda,rda5807.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx214.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx274.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx334.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx335.yaml |   2 +-
 .../devicetree/bindings/media/i2c/sony,imx412.yaml |   2 +-
 .../devicetree/bindings/media/renesas,vin.yaml     |   4 +-
 .../devicetree/bindings/media/ti,cal.yaml          |   4 +-
 .../bindings/memory-controllers/arm,pl35x-smc.yaml |   1 +
 .../bindings/memory-controllers/exynos-srom.yaml   |   1 +
 .../intel,ixp4xx-expansion-bus-controller.yaml     |   1 +
 .../memory-controllers/nvidia,tegra124-emc.yaml    |   1 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   1 +
 .../devicetree/bindings/mfd/actions,atc260x.yaml   |   2 +-
 .../devicetree/bindings/mfd/google,cros-ec.yaml    |   6 +-
 .../devicetree/bindings/mfd/mediatek,mt6357.yaml   |   1 +
 .../devicetree/bindings/mfd/mediatek,mt6370.yaml   |   2 +
 .../devicetree/bindings/mfd/ti,tps65086.yaml       |   2 +-
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   4 +-
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      |   1 +
 Documentation/devicetree/bindings/mtd/mtd.yaml     |   1 +
 .../devicetree/bindings/net/asix,ax88796c.yaml     |   2 +-
 .../devicetree/bindings/net/brcm,bcmgenet.yaml     |   2 -
 .../bindings/net/can/microchip,mcp251xfd.yaml      |   2 +-
 .../bindings/net/cortina,gemini-ethernet.yaml      |   6 +-
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml |   2 +-
 .../devicetree/bindings/net/mdio-gpio.yaml         |   4 +-
 .../bindings/net/nfc/samsung,s3fwrn5.yaml          |   2 +-
 .../devicetree/bindings/net/sti-dwmac.txt          |   3 +-
 .../devicetree/bindings/net/vertexcom-mse102x.yaml |   2 +-
 .../bindings/net/wireless/ti,wlcore.yaml           |  10 +-
 .../devicetree/bindings/pci/cdns,cdns-pcie-ep.yaml |   2 +-
 .../bindings/pci/cdns,cdns-pcie-host.yaml          |   2 +-
 .../devicetree/bindings/pci/cdns-pcie-ep.yaml      |   8 +-
 .../devicetree/bindings/pci/cdns-pcie-host.yaml    |   8 +-
 .../devicetree/bindings/pci/cdns-pcie.yaml         |   4 +-
 .../bindings/pci/intel,keembay-pcie-ep.yaml        |   4 +-
 .../bindings/pci/intel,keembay-pcie.yaml           |   4 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   2 +-
 .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml   |   6 +-
 .../devicetree/bindings/pci/ti,j721e-pci-host.yaml |   6 +-
 .../phy/marvell,armada-cp110-utmi-phy.yaml         |   2 +-
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   2 +-
 .../bindings/phy/qcom,sc7180-qmp-usb3-dp-phy.yaml  |   2 +-
 .../bindings/pinctrl/pinctrl-mt8192.yaml           |   2 +-
 .../devicetree/bindings/pinctrl/pinmux-node.yaml   |   2 +-
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq2415x.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq24190.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq24257.yaml  |   4 +-
 .../devicetree/bindings/power/supply/bq24735.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq2515x.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq25890.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq25980.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq27xxx.yaml  |  15 +-
 .../bindings/power/supply/lltc,ltc294x.yaml        |   2 +-
 .../bindings/power/supply/ltc4162-l.yaml           |   2 +-
 .../bindings/power/supply/maxim,max14656.yaml      |   2 +-
 .../bindings/power/supply/maxim,max17040.yaml      |   4 +-
 .../bindings/power/supply/maxim,max17042.yaml      |   2 +-
 .../bindings/power/supply/richtek,rt9455.yaml      |   2 +-
 .../bindings/power/supply/ti,lp8727.yaml           |   3 +-
 .../bindings/regulator/active-semi,act8865.yaml    |   2 +-
 .../regulator/google,cros-ec-regulator.yaml        |   2 +-
 .../bindings/regulator/nxp,pca9450-regulator.yaml  |   8 +-
 .../bindings/regulator/nxp,pf8x00-regulator.yaml   |   2 +-
 .../bindings/regulator/rohm,bd71828-regulator.yaml |  20 +-
 .../bindings/regulator/rohm,bd71837-regulator.yaml |   6 +-
 .../bindings/regulator/rohm,bd71847-regulator.yaml |   6 +-
 .../bindings/remoteproc/qcom,msm8916-mss-pil.yaml  |   2 +
 .../bindings/reserved-memory/google,open-dice.yaml |   2 +-
 .../reserved-memory/nvidia,tegra210-emc-table.yaml |   2 +-
 .../devicetree/bindings/reserved-memory/phram.yaml |   4 +-
 .../bindings/reserved-memory/qcom,cmd-db.yaml      |   6 +-
 .../bindings/reserved-memory/qcom,rmtfs-mem.yaml   |   6 +-
 .../bindings/reserved-memory/ramoops.yaml          |   6 +-
 .../bindings/reserved-memory/shared-dma-pool.yaml  |   2 +-
 .../reset/amlogic,meson-axg-audio-arb.yaml         |   4 +-
 .../bindings/reset/amlogic,meson-reset.yaml        |   4 +-
 .../bindings/reset/bitmain,bm1880-reset.yaml       |   4 +-
 .../bindings/reset/brcm,bcm6345-reset.yaml         |   4 +-
 .../reset/brcm,bcm7216-pcie-sata-rescal.yaml       |   4 +-
 .../bindings/reset/brcm,brcmstb-reset.yaml         |   4 +-
 .../bindings/reset/marvell,berlin2-reset.yaml      |   4 +-
 .../devicetree/bindings/reset/microchip,rst.yaml   |   6 +-
 .../bindings/reset/qca,ar7100-reset.yaml           |   4 +-
 .../devicetree/bindings/reset/renesas,rst.yaml     |   4 +-
 .../devicetree/bindings/reset/sunplus,reset.yaml   |   4 +-
 .../devicetree/bindings/rng/amlogic,meson-rng.yaml |   4 +-
 .../devicetree/bindings/rng/brcm,iproc-rng200.yaml |   4 +-
 Documentation/devicetree/bindings/rng/mtk-rng.yaml |   4 +-
 .../devicetree/bindings/rng/ti,keystone-rng.yaml   |   2 +-
 Documentation/devicetree/bindings/rtc/snvs-rtc.txt |   1 -
 .../devicetree/bindings/serial/mediatek,uart.yaml  |   1 +
 .../devicetree/bindings/soc/imx/fsl,imx93-src.yaml |   3 +-
 .../devicetree/bindings/soc/mediatek/devapc.yaml   |   4 +-
 .../soc/microchip/atmel,at91rm9200-tcb.yaml        |   1 +
 .../devicetree/bindings/soc/qcom/qcom,apr.yaml     |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,eud.yaml     |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,geni-se.yaml |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,smd-rpm.yaml |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,smem.yaml    |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,spm.yaml     |   4 +-
 .../devicetree/bindings/soc/qcom/qcom,wcnss.yaml   |   2 +-
 .../devicetree/bindings/soc/renesas/renesas.yaml   |   2 +-
 .../devicetree/bindings/soc/ti/ti,pruss.yaml       |   3 +-
 .../bindings/sound/amlogic,axg-tdm-iface.yaml      |   2 +-
 .../devicetree/bindings/sound/everest,es8316.yaml  |   2 +-
 .../bindings/sound/marvell,mmp-sspa.yaml           |   1 +
 .../bindings/sound/qcom,lpass-rx-macro.yaml        |   4 +-
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |   4 +-
 .../bindings/sound/qcom,lpass-va-macro.yaml        |   4 +-
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |   2 +-
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |   1 +
 .../devicetree/bindings/sound/samsung,odroid.yaml  |   2 +
 .../devicetree/bindings/sound/simple-card.yaml     |  24 +-
 .../devicetree/bindings/sound/tas2562.yaml         |   2 +-
 .../devicetree/bindings/sound/tas2770.yaml         |   2 +-
 .../devicetree/bindings/sound/tas27xx.yaml         |   2 +-
 .../devicetree/bindings/sound/tas5805m.yaml        |   2 +-
 .../devicetree/bindings/sound/tlv320adcx140.yaml   |   2 +-
 .../devicetree/bindings/sound/zl38060.yaml         |   2 +-
 .../bindings/soundwire/qcom,soundwire.yaml         |   1 +
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   1 +
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   1 +
 .../bindings/spi/microchip,mpfs-spi.yaml           |   2 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |   1 +
 .../sram/allwinner,sun4i-a10-system-control.yaml   |  10 +-
 .../devicetree/bindings/sram/qcom,ocmem.yaml       |   1 +
 .../devicetree/bindings/thermal/thermal-zones.yaml |   1 +
 .../bindings/timer/amlogic,meson6-timer.txt        |  22 -
 .../bindings/timer/amlogic,meson6-timer.yaml       |  54 ++
 .../bindings/timer/arm,arch_timer_mmio.yaml        |   2 +-
 .../devicetree/bindings/timer/cdns,ttc.yaml        |   2 +-
 .../bindings/timer/intel,ixp4xx-timer.yaml         |   4 +-
 .../bindings/timer/nvidia,tegra-timer.yaml         |   4 +-
 .../bindings/timer/nvidia,tegra186-timer.yaml      |   4 +-
 .../devicetree/bindings/timer/st,nomadik-mtu.yaml  |   4 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   2 +-
 .../devicetree/bindings/usb/maxim,max3420-udc.yaml |   2 +-
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         |   2 +-
 .../devicetree/bindings/usb/qcom,dwc3.yaml         |   1 +
 .../devicetree/bindings/usb/richtek,rt1711h.yaml   |   2 +-
 .../devicetree/bindings/usb/richtek,rt1719.yaml    |   2 +-
 .../devicetree/bindings/usb/st,stusb160x.yaml      |   2 +-
 .../devicetree/bindings/usb/ti,hd3ss3220.yaml      |   2 +-
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |   2 +
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |   2 +-
 .../devicetree/bindings/watchdog/apple,wdt.yaml    |   2 +-
 .../devicetree/bindings/watchdog/arm-smc-wdt.yaml  |   2 +-
 .../bindings/watchdog/atmel,sama5d4-wdt.yaml       |   2 +-
 .../bindings/watchdog/brcm,bcm7038-wdt.yaml        |   2 +-
 .../bindings/watchdog/faraday,ftwdt010.yaml        |   2 +-
 .../bindings/watchdog/fsl-imx7ulp-wdt.yaml         |   2 +-
 .../bindings/watchdog/maxim,max63xx.yaml           |   2 +-
 .../devicetree/bindings/watchdog/renesas,wdt.yaml  |   2 +-
 .../devicetree/bindings/watchdog/snps,dw-wdt.yaml  |   2 +-
 .../bindings/watchdog/socionext,uniphier-wdt.yaml  |   2 +-
 .../bindings/watchdog/st,stm32-iwdg.yaml           |   2 +-
 .../devicetree/bindings/watchdog/ti,rti-wdt.yaml   |   2 +-
 MAINTAINERS                                        |   4 +-
 drivers/of/address.c                               | 271 +++++-----
 drivers/of/unittest.c                              |  21 +-
 include/dt-bindings/reset/stih415-resets.h         |  28 --
 include/dt-bindings/reset/stih416-resets.h         |  52 --
 323 files changed, 1612 insertions(+), 1590 deletions(-)
 rename Documentation/devicetree/bindings/{memory-controllers => cache}/baikal,bt1-l2-ctl.yaml (95%)
 rename Documentation/devicetree/bindings/{powerpc/fsl/l2cache.txt => cache/freescale-l2cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm => cache}/l2c2x0.yaml (99%)
 rename Documentation/devicetree/bindings/{arm/mrvl/feroceon.txt => cache/marvell,feroceon-cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/mrvl/tauros2.txt => cache/marvell,tauros2-cache.txt} (100%)
 rename Documentation/devicetree/bindings/{arm/msm => cache}/qcom,llcc.yaml (96%)
 rename Documentation/devicetree/bindings/{riscv => cache}/sifive,ccache0.yaml (98%)
 rename Documentation/devicetree/bindings/{arm/socionext => cache}/socionext,uniphier-system-cache.yaml (96%)
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0-mon.yaml
 create mode 100644 Documentation/devicetree/bindings/crypto/fsl,sec-v4.0.yaml
 delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-sec4.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/parade,ps8622.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/ps8622.txt
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/toshiba,tc358764.yaml
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-pr-decoupler.txt
 delete mode 100644 Documentation/devicetree/bindings/fpga/xilinx-slave-serial.txt
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,fpga-slave-serial.yaml
 create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,pr-decoupler.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/snvs-pwrkey.txt
 delete mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.txt
 create mode 100644 Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/snvs-rtc.txt
 delete mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/amlogic,meson6-timer.yaml
 delete mode 100644 include/dt-bindings/reset/stih415-resets.h
 delete mode 100644 include/dt-bindings/reset/stih416-resets.h
