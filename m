Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A63725F3724
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 22:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJCUbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 16:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiJCUbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 16:31:33 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21297367BB;
        Mon,  3 Oct 2022 13:31:31 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m81so12488353oia.1;
        Mon, 03 Oct 2022 13:31:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PR4T7LMsdcRjt7dz/+IeKqTPm7enXJToV3tYpshuxMY=;
        b=vlVmL7pB6WRHS6YQR+MligLWaEvb8+kVHTJH/CHc8zc3VW3+2vSxwammsTwf+UklSs
         tA7wspBPondXDfjHM9kvFWP1Y2VJ7yd7Q3KSVqmomJrGeToUPZf23Rn28ZZVWFgPQRG9
         PUFkpaoH80/QvylUVF3isrYct+ciciOPxbro/LYqx3qGh/vAGv4QjemU1ycD6VStUuKV
         zZCCnxiGioZlOyG7J6VXPBTFnQ/fFZ2zAmmjnGlnD+G984QayMhrDFces9d7vR+YdOZu
         /FU0jBJPOEn2PacZ834E5/FSrMcAWEtQugBC7r8CcFpitWO7SiBTVMm0wQmjZ0xonR76
         puwA==
X-Gm-Message-State: ACrzQf10ZJvsy1/gHWyc3xSHvptu6zszSeSFi0pRGfXDW4gZt9lNcBfT
        XBtsHBu0wqYXXasnSc1dOtHg0MqIKA==
X-Google-Smtp-Source: AMsMyM7ZCjmdfvPKURk4mTNC3aTbQG8+cWGf+MPgHJmm2aKjoyFNOYtD2of3Lk+RG0iELCqVj0eFWw==
X-Received: by 2002:a05:6808:1a21:b0:353:d944:2bb1 with SMTP id bk33-20020a0568081a2100b00353d9442bb1mr391815oib.206.1664829090060;
        Mon, 03 Oct 2022 13:31:30 -0700 (PDT)
Received: from macbook.herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y40-20020a056870b02800b0012d130c2fdasm3211136oae.48.2022.10.03.13.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Oct 2022 13:31:29 -0700 (PDT)
Received: (nullmailer pid 2768020 invoked by uid 1000);
        Mon, 03 Oct 2022 20:31:29 -0000
Date:   Mon, 3 Oct 2022 15:31:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.1
Message-ID: <20221003203129.GA2767725-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull DT updates for 6.1.

Rob


The following changes since commit 568035b01cfb107af8d2e4bd2fb9aea22cf5b868:

  Linux 6.0-rc1 (2022-08-14 15:50:18 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.1

for you to fetch changes up to 7a7f58575483a74db4cc2c1e37f21ddda057083d:

  of: base: Shift refcount decrement in of_find_last_cache_level() (2022-10-03 11:21:37 -0500)

----------------------------------------------------------------
Devicetree updates for v6.1:

DT core:

- Fix node refcounting in of_find_last_cache_level()

- Constify device_node in of_device_compatible_match()

- Fix 'dma-ranges' handling in bus controller nodes

- Fix handling of initrd start > end

- Improve error reporting in of_irq_init()

- Taint kernel on DT unittest running

- Use strscpy instead of strlcpy

- Add a build target, dt_compatible_check, to check for
  compatible strings used in kernel sources against compatible strings
  in DT schemas.

- Handle DT_SCHEMA_FILES changes when rebuilding

DT bindings:

- LED bindings for MT6370 PMIC

- Convert Mediatek mtk-gce mailbox, MIPS CPU interrupt controller,
  mt7621 I2C, virtio,pci-iommu, nxp,tda998x, QCom fastrpc, qcom,pdc,
  and arm,versatile-sysreg to DT schema format

- Add nvmem cells to u-boot,env schema

- Add more LED_COLOR_ID definitions

- Require 'opp-table' uses to be a node

- Various schema fixes to match QEMU 'virt' DT usage

- Tree wide dropping of redundant 'Device Tree Binding' in schema titles

- More (unevaluated|additional)Properties fixes in schema child nodes

- Drop various redundant minItems equal to maxItems

----------------------------------------------------------------
Abel Vesa (2):
      dt-bindings: misc: fastrpc convert bindings to yaml
      dt-bindings: misc: fastrpc: Document memory-region property

Alexander Sverdlin (1):
      of: irq: Report individual failures in of_irq_init()

Alice Chen (1):
      dt-bindings: leds: Add MediaTek MT6370 flashlight

Andrew Davis (1):
      dt-bindings: rng: omap_rng: Drop requirement for clocks

Andrew Lunn (1):
      dt-bindings: Remove 'Device Tree Bindings' from end of title:

AngeloGioacchino Del Regno (1):
      dt-bindings: mailbox: Convert mtk-gce to DT schema

ChiYuan Huang (1):
      dt-bindings: leds: mt6370: Add MediaTek MT6370 current sink type LED indicator

Dmitry Baryshkov (1):
      kbuild: take into account DT_SCHEMA_FILES changes while checking dtbs

Dmitry Torokhov (1):
      of: base: make of_device_compatible_match() accept const device node

Frank Rowand (1):
      of: unittest: taint the kernel when of unittest runs

Geert Uytterhoeven (1):
      dt-bindings: display: bridge: nxp,tda998x: Convert to json-schema

Iskren Chernev (1):
      dt-bindings: arm: cpus: Add kryo240 compatible

Jayesh Choudhary (1):
      dt-bindings: crypto: ti,sa2ul: drop dma-coherent property

Jean-Philippe Brucker (4):
      dt-bindings: interrupt-controller: arm,gic-v3: Make 'interrupts' optional
      dt-bindings: interrupt-controller: arm,gic: Support two address and size cells
      dt-bindings: timer: arm,arch_timer: Allow dual compatible string
      dt-bindings: virtio: Convert virtio,pci-iommu to DT schema

Krzysztof Kozlowski (21):
      dt-bindings: memory-controllers: fsl,imx8m-ddrc: restrict opp-table to objects
      dt-bindings: interconnect: restrict opp-table to objects
      dt-bindings: gpu: arm,mali: restrict opp-table to objects
      dt-bindings: display: synopsys,dw-hdmi: drop ref from reg-io-width
      dt-bindings: display: drop minItems equal to maxItems
      dt-bindings: socionext,uniphier-system-cache: drop minItems equal to maxItems
      dt-bindings: ata: drop minItems equal to maxItems
      dt-bindings: crypto: drop minItems equal to maxItems
      dt-bindings: nvmem: qfprom: add IPQ8064 and SDM630 compatibles
      dt-bindings: leds: qcom-wled: fix number of addresses
      dt-bindings: misc: qcom,fastrpc: correct qcom,nsessions name
      dt-bindings: misc: qcom,fastrpc: add compute iommus
      dt-bindings: misc: qcom,fastrpc: restrict channel names
      dt-bindings: misc: qcom,fastrpc: correct example for GLINK edge
      dt-bindings: remoteproc: qcom,glink-edge: require channels in children
      dt-bindings: soc: qcom: smd: restrict child name to smd-edge
      dt-bindings: remoteproc: qcom,smd-edge: define children
      dt-bindings: phy: hisilicon,hi3660-usb3: simplify example
      dt-bindings: phy: hisilicon,hi3670-usb3: simplify example
      dt-bindings: remoteproc: qcom,pil-info: add missing imem compatible
      dt-bindings: remoteproc: qcom,adsp: enforce smd-edge schema

Luca Weiss (1):
      dt-bindings: qcom,pdc: convert to YAML

Marek Bykowski (1):
      of/fdt: Don't calculate initrd size from DT if start > end

Marek Vasut (1):
      dt-bindings: display: st,stm32-dsi: Handle data-lanes in DSI port node

Olliver Schinagl (1):
      dt-bindings: leds: Expand LED_COLOR_ID definitions

Peng Fan (1):
      dt-bindings: power: gpcv2: correct patternProperties

Pierre Gondois (1):
      of: base: Shift refcount decrement in of_find_last_cache_level()

Rafał Miłecki (1):
      dt-bindings: nvmem: u-boot,env: add basic NVMEM cells

Rob Herring (10):
      dt-bindings: arm: psci: Relax and simplify compatible constraints
      dt-bindings: display: arm,versatile-tft-panel: Drop erroneous properties in example
      dt-bindings: arm,versatile-sysreg: Convert to DT schema format
      dt-bindings: display: adi,adv75xx: Add missing graph schema references
      dt-bindings: display: Add missing (unevaluated|additional)Properties on child nodes
      media: dt-bindings: Add missing (unevaluated|additional)Properties on child nodes
      dt-bindings: power: Add missing (unevaluated|additional)Properties on child nodes
      dt-bindings: timer: Add missing (unevaluated|additional)Properties on child nodes
      dt-bindings: remoteproc: Add missing (unevaluated|additional)Properties on child nodes
      dt: Add a check for undocumented compatible strings in kernel

Robin Murphy (1):
      of: Fix "dma-ranges" handling for bus controllers

Sergio Paracuellos (2):
      dt-bindings: i2c: migrate mt7621 text bindings to YAML
      dt-bindings: interrupt-controller: migrate MIPS CPU interrupt controller text bindings to YAML

Tony Lindgren (1):
      dt-bindings: timer: Add power-domains for TI timer-dm on K3

Wolfram Sang (1):
      of: move from strlcpy with unused retval to strscpy

Yuan Can (1):
      of: fdt: Remove unused struct fdt_scan_status

 Documentation/devicetree/bindings/Makefile         |   3 +
 Documentation/devicetree/bindings/arm/actions.yaml |   2 +-
 Documentation/devicetree/bindings/arm/airoha.yaml  |   2 +-
 Documentation/devicetree/bindings/arm/altera.yaml  |   2 +-
 .../devicetree/bindings/arm/amazon,al.yaml         |   2 +-
 Documentation/devicetree/bindings/arm/amlogic.yaml |   2 +-
 Documentation/devicetree/bindings/arm/apple.yaml   |   2 +-
 .../devicetree/bindings/arm/arm,cci-400.yaml       |   2 +-
 .../devicetree/bindings/arm/arm,corstone1000.yaml  |   2 +-
 .../devicetree/bindings/arm/arm,integrator.yaml    |   2 +-
 .../devicetree/bindings/arm/arm,realview.yaml      |   2 +-
 .../bindings/arm/arm,versatile-sysreg.yaml         |  35 +++++
 .../devicetree/bindings/arm/arm,versatile.yaml     |   2 +-
 .../devicetree/bindings/arm/arm,vexpress-juno.yaml |   2 +-
 .../devicetree/bindings/arm/atmel-at91.yaml        |   2 +-
 Documentation/devicetree/bindings/arm/axxia.yaml   |   2 +-
 Documentation/devicetree/bindings/arm/bitmain.yaml |   2 +-
 Documentation/devicetree/bindings/arm/calxeda.yaml |   2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   1 +
 .../devicetree/bindings/arm/digicolor.yaml         |   2 +-
 Documentation/devicetree/bindings/arm/fsl.yaml     |   2 +-
 .../devicetree/bindings/arm/intel,keembay.yaml     |   2 +-
 .../devicetree/bindings/arm/intel,socfpga.yaml     |   2 +-
 .../devicetree/bindings/arm/intel-ixp4xx.yaml      |   2 +-
 .../devicetree/bindings/arm/mediatek.yaml          |   2 +-
 .../bindings/arm/mediatek/mediatek,mmsys.yaml      |   3 +-
 .../devicetree/bindings/arm/microchip,sparx5.yaml  |   2 +-
 Documentation/devicetree/bindings/arm/moxart.yaml  |   2 +-
 .../bindings/arm/nvidia,tegra194-ccplex.yaml       |   2 +-
 Documentation/devicetree/bindings/arm/psci.yaml    |  11 +-
 Documentation/devicetree/bindings/arm/qcom.yaml    |   2 +-
 Documentation/devicetree/bindings/arm/rda.yaml     |   2 +-
 Documentation/devicetree/bindings/arm/realtek.yaml |   2 +-
 Documentation/devicetree/bindings/arm/renesas.yaml |   2 +-
 .../devicetree/bindings/arm/rockchip.yaml          |   2 +-
 .../socionext/socionext,uniphier-system-cache.yaml |   1 -
 Documentation/devicetree/bindings/arm/spear.yaml   |   2 +-
 Documentation/devicetree/bindings/arm/sti.yaml     |   2 +-
 Documentation/devicetree/bindings/arm/sunxi.yaml   |   2 +-
 Documentation/devicetree/bindings/arm/tegra.yaml   |   2 +-
 Documentation/devicetree/bindings/arm/tesla.yaml   |   2 +-
 Documentation/devicetree/bindings/arm/toshiba.yaml |   2 +-
 Documentation/devicetree/bindings/arm/ux500.yaml   |   2 +-
 .../devicetree/bindings/arm/versatile-sysreg.txt   |  10 --
 Documentation/devicetree/bindings/arm/vt8500.yaml  |   2 +-
 Documentation/devicetree/bindings/arm/xilinx.yaml  |   2 +-
 .../devicetree/bindings/ata/brcm,sata-brcm.yaml    |   1 -
 .../bindings/ata/cortina,gemini-sata-bridge.yaml   |   2 -
 .../devicetree/bindings/ata/sata_highbank.yaml     |   1 -
 .../bindings/bus/allwinner,sun50i-a64-de2.yaml     |   2 +-
 .../bindings/bus/allwinner,sun8i-a23-rsb.yaml      |   2 +-
 Documentation/devicetree/bindings/bus/palmbus.yaml |   2 +-
 .../bindings/clock/airoha,en7523-scu.yaml          |   2 +-
 .../clock/allwinner,sun4i-a10-ahb-clk.yaml         |   2 +-
 .../clock/allwinner,sun4i-a10-apb0-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-apb1-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-axi-clk.yaml         |   2 +-
 .../bindings/clock/allwinner,sun4i-a10-ccu.yaml    |   2 +-
 .../clock/allwinner,sun4i-a10-cpu-clk.yaml         |   2 +-
 .../clock/allwinner,sun4i-a10-display-clk.yaml     |   2 +-
 .../clock/allwinner,sun4i-a10-gates-clk.yaml       |   2 +-
 .../clock/allwinner,sun4i-a10-mbus-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-mmc-clk.yaml         |   2 +-
 .../clock/allwinner,sun4i-a10-mod0-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-mod1-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-osc-clk.yaml         |   2 +-
 .../clock/allwinner,sun4i-a10-pll1-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-pll3-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-pll5-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-pll6-clk.yaml        |   2 +-
 .../clock/allwinner,sun4i-a10-tcon-ch0-clk.yaml    |   2 +-
 .../clock/allwinner,sun4i-a10-usb-clk.yaml         |   2 +-
 .../bindings/clock/allwinner,sun4i-a10-ve-clk.yaml |   2 +-
 .../clock/allwinner,sun5i-a13-ahb-clk.yaml         |   2 +-
 .../clock/allwinner,sun6i-a31-pll6-clk.yaml        |   2 +-
 .../clock/allwinner,sun7i-a20-gmac-clk.yaml        |   2 +-
 .../clock/allwinner,sun7i-a20-out-clk.yaml         |   2 +-
 .../clock/allwinner,sun8i-a83t-de2-clk.yaml        |   2 +-
 .../clock/allwinner,sun8i-h3-bus-gates-clk.yaml    |   2 +-
 .../clock/allwinner,sun9i-a80-ahb-clk.yaml         |   2 +-
 .../clock/allwinner,sun9i-a80-apb0-clk.yaml        |   2 +-
 .../clock/allwinner,sun9i-a80-cpus-clk.yaml        |   2 +-
 .../clock/allwinner,sun9i-a80-de-clks.yaml         |   2 +-
 .../bindings/clock/allwinner,sun9i-a80-gt-clk.yaml |   2 +-
 .../clock/allwinner,sun9i-a80-mmc-config-clk.yaml  |   2 +-
 .../clock/allwinner,sun9i-a80-pll4-clk.yaml        |   2 +-
 .../clock/allwinner,sun9i-a80-usb-clks.yaml        |   2 +-
 .../clock/allwinner,sun9i-a80-usb-mod-clk.yaml     |   2 +-
 .../clock/allwinner,sun9i-a80-usb-phy-clk.yaml     |   2 +-
 .../bindings/clock/amlogic,meson8-ddr-clkc.yaml    |   2 +-
 .../bindings/clock/brcm,bcm2711-dvp.yaml           |   2 +-
 .../devicetree/bindings/clock/canaan,k210-clk.yaml |   2 +-
 .../bindings/clock/mediatek,mt7621-sysc.yaml       |   2 +-
 .../bindings/clock/sprd,sc9863a-clk.yaml           |   2 +-
 .../bindings/clock/toshiba,tmpv770x-pipllct.yaml   |   2 +-
 .../bindings/clock/toshiba,tmpv770x-pismu.yaml     |   2 +-
 .../crypto/allwinner,sun4i-a10-crypto.yaml         |   2 +-
 .../bindings/crypto/intel,keembay-ocs-aes.yaml     |   2 +-
 .../bindings/crypto/intel,keembay-ocs-ecc.yaml     |   2 +-
 .../bindings/crypto/intel,keembay-ocs-hcu.yaml     |   2 +-
 .../bindings/crypto/samsung-slimsss.yaml           |   1 -
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |  13 --
 .../bindings/crypto/xlnx,zynqmp-aes.yaml           |   2 +-
 .../allwinner,sun4i-a10-display-backend.yaml       |   2 +-
 .../allwinner,sun4i-a10-display-engine.yaml        |   2 +-
 .../allwinner,sun4i-a10-display-frontend.yaml      |   2 +-
 .../bindings/display/allwinner,sun4i-a10-hdmi.yaml |   2 +-
 .../bindings/display/allwinner,sun4i-a10-tcon.yaml |   2 +-
 .../display/allwinner,sun4i-a10-tv-encoder.yaml    |   2 +-
 .../bindings/display/allwinner,sun6i-a31-drc.yaml  |   2 +-
 .../display/allwinner,sun6i-a31-mipi-dsi.yaml      |   2 +-
 .../display/allwinner,sun8i-a83t-de2-mixer.yaml    |   2 +-
 .../display/allwinner,sun8i-a83t-dw-hdmi.yaml      |   2 +-
 .../display/allwinner,sun8i-a83t-hdmi-phy.yaml     |   2 +-
 .../display/allwinner,sun8i-r40-tcon-top.yaml      |   2 +-
 .../bindings/display/allwinner,sun9i-a80-deu.yaml  |   2 +-
 .../devicetree/bindings/display/arm,komeda.yaml    |   1 +
 .../bindings/display/brcm,bcm2711-hdmi.yaml        |   2 +-
 .../bindings/display/bridge/adi,adv7511.yaml       |  14 +-
 .../bindings/display/bridge/adi,adv7533.yaml       |  14 +-
 .../bindings/display/bridge/fsl,ldb.yaml           |   1 -
 .../bindings/display/bridge/lvds-codec.yaml        |   1 +
 .../bindings/display/bridge/nxp,tda998x.yaml       | 109 ++++++++++++++++
 .../bindings/display/bridge/synopsys,dw-hdmi.yaml  |   1 -
 .../devicetree/bindings/display/bridge/tda998x.txt |  54 --------
 .../bindings/display/ilitek,ili9486.yaml           |   2 +-
 .../bindings/display/msm/dsi-controller-main.yaml  |   2 -
 .../bindings/display/msm/dsi-phy-10nm.yaml         |   2 -
 .../devicetree/bindings/display/msm/gpu.yaml       |   1 +
 .../display/panel/arm,versatile-tft-panel.yaml     |   3 -
 .../display/samsung/samsung,exynos5433-decon.yaml  |   2 -
 .../display/samsung/samsung,exynos5433-mic.yaml    |   1 -
 .../display/samsung/samsung,exynos7-decon.yaml     |   2 +-
 .../bindings/display/samsung/samsung,fimd.yaml     |   2 +-
 .../bindings/display/simple-framebuffer.yaml       |   2 +-
 .../bindings/display/sitronix,st7735r.yaml         |   2 +-
 .../devicetree/bindings/display/st,stm32-dsi.yaml  |  17 ++-
 .../display/tegra/nvidia,tegra20-gr3d.yaml         |   1 -
 .../bindings/display/tegra/nvidia,tegra20-mpe.yaml |   2 -
 .../bindings/dma/allwinner,sun4i-a10-dma.yaml      |   2 +-
 .../bindings/dma/allwinner,sun50i-a64-dma.yaml     |   2 +-
 .../bindings/dma/allwinner,sun6i-a31-dma.yaml      |   2 +-
 .../bindings/dma/nvidia,tegra186-gpc-dma.yaml      |   2 +-
 .../bindings/fpga/xilinx-zynq-fpga-mgr.yaml        |   2 +-
 .../bindings/fpga/xlnx,zynqmp-pcap-fpga.yaml       |   2 +-
 .../devicetree/bindings/gnss/brcm,bcm4751.yaml     |   2 +-
 .../devicetree/bindings/gnss/mediatek.yaml         |   2 +-
 .../devicetree/bindings/gnss/sirfstar.yaml         |   2 +-
 .../devicetree/bindings/gnss/u-blox,neo-6m.yaml    |   2 +-
 .../devicetree/bindings/gpio/gpio-zynq.yaml        |   2 +-
 .../bindings/gpio/microchip,mpfs-gpio.yaml         |   2 +-
 .../bindings/gpio/x-powers,axp209-gpio.yaml        |   2 +-
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |   3 +-
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |   3 +-
 .../bindings/hwmon/adi,axi-fan-control.yaml        |   2 +-
 .../devicetree/bindings/hwmon/iio-hwmon.yaml       |   2 +-
 .../bindings/i2c/allwinner,sun6i-a31-p2wi.yaml     |   2 +-
 .../devicetree/bindings/i2c/aspeed,i2c.yaml        |   2 +-
 .../devicetree/bindings/i2c/cdns,i2c-r1p10.yaml    |   2 +-
 .../devicetree/bindings/i2c/i2c-mt7621.txt         |  25 ----
 .../bindings/i2c/marvell,mv64xxx-i2c.yaml          |   2 +-
 .../bindings/i2c/mediatek,mt7621-i2c.yaml          |  61 +++++++++
 .../devicetree/bindings/i2c/microchip,corei2c.yaml |   2 +-
 .../bindings/i2c/nuvoton,npcm7xx-i2c.yaml          |   2 +-
 .../bindings/i2c/xlnx,xps-iic-2.00.a.yaml          |   2 +-
 .../devicetree/bindings/i3c/mipi-i3c-hci.yaml      |   2 +-
 .../input/allwinner,sun4i-a10-lradc-keys.yaml      |   2 +-
 .../devicetree/bindings/input/imx-keypad.yaml      |   2 +-
 .../bindings/input/mediatek,mt6779-keypad.yaml     |   2 +-
 .../bindings/input/regulator-haptic.yaml           |   2 +-
 .../bindings/input/sprd,sc27xx-vibrator.yaml       |   2 +-
 .../bindings/interconnect/fsl,imx8m-noc.yaml       |   3 +-
 .../bindings/interconnect/mediatek,cci.yaml        |   3 +-
 .../bindings/interconnect/qcom,msm8998-bwmon.yaml  |   3 +-
 .../allwinner,sun4i-a10-ic.yaml                    |   2 +-
 .../allwinner,sun6i-a31-r-intc.yaml                |   2 +-
 .../allwinner,sun7i-a20-sc-nmi.yaml                |   2 +-
 .../bindings/interrupt-controller/arm,gic-v3.yaml  |   1 -
 .../bindings/interrupt-controller/arm,gic.yaml     |   4 +-
 .../interrupt-controller/idt,32434-pic.yaml        |   2 +-
 .../mti,cpu-interrupt-controller.yaml              |  46 +++++++
 .../bindings/interrupt-controller/qcom,pdc.txt     |  78 -----------
 .../bindings/interrupt-controller/qcom,pdc.yaml    |  87 +++++++++++++
 .../interrupt-controller/st,stm32-exti.yaml        |   2 +-
 .../bindings/iommu/allwinner,sun50i-h6-iommu.yaml  |   2 +-
 .../bindings/leds/backlight/qcom-wled.yaml         |   9 +-
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  |  41 ++++++
 .../bindings/leds/mediatek,mt6370-indicator.yaml   |  81 ++++++++++++
 .../bindings/mailbox/mediatek,gce-mailbox.yaml     |  85 ++++++++++++
 .../devicetree/bindings/mailbox/mtk-gce.txt        |  82 ------------
 .../devicetree/bindings/media/allegro,al5e.yaml    |   2 +-
 .../bindings/media/allwinner,sun4i-a10-csi.yaml    |   2 +-
 .../bindings/media/allwinner,sun4i-a10-ir.yaml     |   2 +-
 .../media/allwinner,sun4i-a10-video-engine.yaml    |   2 +-
 .../bindings/media/allwinner,sun6i-a31-csi.yaml    |   2 +-
 .../media/allwinner,sun6i-a31-mipi-csi2.yaml       |   2 +-
 .../media/allwinner,sun8i-a83t-de2-rotate.yaml     |   2 +-
 .../media/allwinner,sun8i-a83t-mipi-csi2.yaml      |   2 +-
 .../media/allwinner,sun8i-h3-deinterlace.yaml      |   2 +-
 .../bindings/media/mediatek-jpeg-decoder.yaml      |   2 +-
 .../bindings/media/mediatek-jpeg-encoder.yaml      |   2 +-
 .../bindings/media/microchip,csi2dc.yaml           |   2 +
 .../devicetree/bindings/media/nxp,imx8-jpeg.yaml   |   2 +-
 .../bindings/media/qcom,msm8916-venus.yaml         |   1 +
 .../bindings/media/qcom,msm8996-venus.yaml         |   1 +
 .../bindings/media/qcom,sc7180-venus.yaml          |   1 +
 .../bindings/media/qcom,sc7280-venus.yaml          |   1 +
 .../bindings/media/qcom,sdm660-venus.yaml          |   1 +
 .../bindings/media/qcom,sdm845-venus-v2.yaml       |   1 +
 .../bindings/media/qcom,sdm845-venus.yaml          |   1 +
 .../bindings/media/qcom,sm8250-venus.yaml          |   1 +
 Documentation/devicetree/bindings/media/rc.yaml    |   2 +-
 .../devicetree/bindings/media/rockchip,vdec.yaml   |   2 +-
 .../devicetree/bindings/media/ti,cal.yaml          |   2 +-
 .../devicetree/bindings/media/ti,vpe.yaml          |   2 +-
 .../memory-controllers/fsl/imx8m-ddrc.yaml         |   3 +-
 .../bindings/mfd/allwinner,sun4i-a10-ts.yaml       |   2 +-
 .../bindings/mfd/allwinner,sun6i-a31-prcm.yaml     |   2 +-
 .../bindings/mfd/allwinner,sun8i-a23-prcm.yaml     |   2 +-
 .../bindings/mfd/brcm,bcm6318-gpio-sysctl.yaml     |   2 +-
 .../bindings/mfd/brcm,bcm63268-gpio-sysctl.yaml    |   2 +-
 .../bindings/mfd/brcm,bcm6328-gpio-sysctl.yaml     |   2 +-
 .../bindings/mfd/brcm,bcm6358-gpio-sysctl.yaml     |   2 +-
 .../bindings/mfd/brcm,bcm6362-gpio-sysctl.yaml     |   2 +-
 .../bindings/mfd/brcm,bcm6368-gpio-sysctl.yaml     |   2 +-
 .../bindings/mfd/canaan,k210-sysctl.yaml           |   2 +-
 .../devicetree/bindings/mfd/khadas,mcu.yaml        |   2 +-
 Documentation/devicetree/bindings/mfd/syscon.yaml  |   2 +-
 .../bindings/mfd/ti,j721e-system-controller.yaml   |   2 +-
 .../devicetree/bindings/mfd/x-powers,ac100.yaml    |   2 +-
 .../devicetree/bindings/mfd/x-powers,axp152.yaml   |   2 +-
 Documentation/devicetree/bindings/mips/cpu_irq.txt |  47 -------
 Documentation/devicetree/bindings/mips/ralink.yaml |   2 +-
 .../devicetree/bindings/mips/realtek-rtl.yaml      |   2 +-
 .../devicetree/bindings/misc/qcom,fastrpc.txt      |  88 -------------
 .../devicetree/bindings/misc/qcom,fastrpc.yaml     | 144 +++++++++++++++++++++
 .../bindings/mmc/allwinner,sun4i-a10-mmc.yaml      |   2 +-
 .../bindings/mmc/amlogic,meson-mx-sdhc.yaml        |   2 +-
 .../devicetree/bindings/mmc/mmc-card.yaml          |   2 +-
 .../devicetree/bindings/mmc/rockchip-dw-mshc.yaml  |   2 +-
 .../bindings/mtd/allwinner,sun4i-a10-nand.yaml     |   2 +-
 .../bindings/mtd/arasan,nand-controller.yaml       |   2 +-
 .../bindings/mtd/arm,pl353-nand-r2p1.yaml          |   2 +-
 .../devicetree/bindings/mtd/intel,lgm-nand.yaml    |   2 +-
 Documentation/devicetree/bindings/mtd/mtd.yaml     |   2 +-
 .../bindings/mtd/mxicy,nand-ecc-engine.yaml        |   2 +-
 .../devicetree/bindings/mtd/renesas-nandc.yaml     |   2 +-
 .../devicetree/bindings/mtd/spi-nand.yaml          |   2 +-
 .../bindings/net/allwinner,sun4i-a10-emac.yaml     |   2 +-
 .../bindings/net/allwinner,sun4i-a10-mdio.yaml     |   2 +-
 .../bindings/net/allwinner,sun7i-a20-gmac.yaml     |   2 +-
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml    |   2 +-
 .../devicetree/bindings/net/brcm,amac.yaml         |   2 +-
 .../devicetree/bindings/net/intel,dwmac-plat.yaml  |   2 +-
 .../devicetree/bindings/net/nxp,dwmac-imx.yaml     |   2 +-
 .../devicetree/bindings/net/qcom,ipq4019-mdio.yaml |   2 +-
 .../devicetree/bindings/net/realtek-bluetooth.yaml |   2 +-
 .../devicetree/bindings/net/snps,dwmac.yaml        |   2 +-
 .../bindings/net/sunplus,sp7021-emac.yaml          |   2 +-
 .../devicetree/bindings/net/ti,cpsw-switch.yaml    |   2 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml        |   2 +-
 .../devicetree/bindings/net/ti,k3-am654-cpts.yaml  |   2 +-
 .../devicetree/bindings/net/vertexcom-mse102x.yaml |   2 +-
 .../bindings/nvmem/allwinner,sun4i-a10-sid.yaml    |   2 +-
 .../devicetree/bindings/nvmem/imx-iim.yaml         |   2 +-
 .../devicetree/bindings/nvmem/imx-ocotp.yaml       |   2 +-
 .../devicetree/bindings/nvmem/nintendo-otp.yaml    |   2 +-
 .../devicetree/bindings/nvmem/nvmem-consumer.yaml  |   2 +-
 Documentation/devicetree/bindings/nvmem/nvmem.yaml |   2 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   2 +
 .../devicetree/bindings/nvmem/rockchip-efuse.yaml  |   2 +-
 .../devicetree/bindings/nvmem/u-boot,env.yaml      |  13 ++
 .../opp/allwinner,sun50i-h6-operating-points.yaml  |   2 +-
 .../devicetree/bindings/pci/brcm,stb-pcie.yaml     |   2 +-
 .../bindings/pci/microchip,pcie-host.yaml          |   2 +-
 .../bindings/pci/samsung,exynos-pcie.yaml          |   2 +-
 .../bindings/pci/toshiba,visconti-pcie.yaml        |   2 +-
 .../devicetree/bindings/peci/peci-aspeed.yaml      |   2 +-
 .../devicetree/bindings/peci/peci-controller.yaml  |   2 +-
 .../bindings/phy/allwinner,sun4i-a10-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun50i-a64-usb-phy.yaml |   2 +-
 .../bindings/phy/allwinner,sun50i-h6-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun5i-a13-usb-phy.yaml  |   2 +-
 .../phy/allwinner,sun6i-a31-mipi-dphy.yaml         |   2 +-
 .../bindings/phy/allwinner,sun6i-a31-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun8i-a23-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun8i-a83t-usb-phy.yaml |   2 +-
 .../bindings/phy/allwinner,sun8i-h3-usb-phy.yaml   |   2 +-
 .../bindings/phy/allwinner,sun8i-r40-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun8i-v3s-usb-phy.yaml  |   2 +-
 .../bindings/phy/allwinner,sun9i-a80-usb-phy.yaml  |   2 +-
 .../devicetree/bindings/phy/cdns,dphy-rx.yaml      |   2 +-
 .../devicetree/bindings/phy/cdns,dphy.yaml         |   2 +-
 .../devicetree/bindings/phy/fsl,imx8-pcie-phy.yaml |   2 +-
 .../bindings/phy/hisilicon,hi3660-usb3.yaml        |  22 +---
 .../bindings/phy/hisilicon,hi3670-usb3.yaml        |  26 ++--
 .../bindings/phy/intel,lgm-emmc-phy.yaml           |   2 +-
 .../devicetree/bindings/phy/intel,lgm-usb-phy.yaml |   2 +-
 .../bindings/phy/lantiq,vrx200-pcie-phy.yaml       |   2 +-
 .../bindings/phy/mediatek,mt7621-pci-phy.yaml      |   2 +-
 .../devicetree/bindings/phy/mediatek,tphy.yaml     |   2 +-
 .../devicetree/bindings/phy/mediatek,xsphy.yaml    |   2 +-
 .../bindings/phy/phy-rockchip-naneng-combphy.yaml  |   2 +-
 .../bindings/phy/rockchip-inno-csi-dphy.yaml       |   2 +-
 .../bindings/phy/rockchip-mipi-dphy-rx0.yaml       |   2 +-
 .../bindings/phy/samsung,exynos-pcie-phy.yaml      |   2 +-
 .../devicetree/bindings/phy/samsung,ufs-phy.yaml   |   2 +-
 .../devicetree/bindings/phy/xlnx,zynqmp-psgtr.yaml |   2 +-
 .../pinctrl/allwinner,sun4i-a10-pinctrl.yaml       |   2 +-
 .../bindings/pinctrl/canaan,k210-fpioa.yaml        |   2 +-
 .../bindings/pinctrl/intel,pinctrl-keembay.yaml    |   2 +-
 .../bindings/pinctrl/intel,pinctrl-thunderbay.yaml |   2 +-
 .../bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt6779-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt6797-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt7622-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt7986-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/mediatek,mt8183-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/starfive,jh7100-pinctrl.yaml  |   2 +-
 .../bindings/pinctrl/sunplus,sp7021-pinctrl.yaml   |   2 +-
 .../bindings/power/domain-idle-state.yaml          |  10 ++
 .../devicetree/bindings/power/fsl,imx-gpc.yaml     |  14 ++
 .../devicetree/bindings/power/fsl,imx-gpcv2.yaml   |  16 ++-
 .../devicetree/bindings/ptp/ptp-idt82p33.yaml      |   2 +-
 .../devicetree/bindings/ptp/ptp-idtcm.yaml         |   2 +-
 .../bindings/pwm/allwinner,sun4i-a10-pwm.yaml      |   2 +-
 .../devicetree/bindings/pwm/intel,keembay-pwm.yaml |   2 +-
 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   2 +-
 .../bindings/regulator/silergy,sy8106a.yaml        |   2 +-
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   1 +
 .../bindings/remoteproc/qcom,glink-edge.yaml       |   8 +-
 .../bindings/remoteproc/qcom,pil-info.yaml         |   2 +-
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   |   1 +
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   |   1 +
 .../bindings/remoteproc/qcom,sc7280-wpss-pil.yaml  |   1 +
 .../bindings/remoteproc/qcom,smd-edge.yaml         |  34 ++++-
 .../bindings/reserved-memory/google,open-dice.yaml |   2 +-
 .../bindings/reserved-memory/memory-region.yaml    |   2 +-
 .../reserved-memory/nvidia,tegra210-emc-table.yaml |   2 +-
 .../bindings/reserved-memory/reserved-memory.yaml  |   2 +-
 .../reset/allwinner,sun6i-a31-clock-reset.yaml     |   2 +-
 .../devicetree/bindings/reset/canaan,k210-rst.yaml |   2 +-
 .../bindings/reset/starfive,jh7100-reset.yaml      |   2 +-
 .../devicetree/bindings/riscv/microchip.yaml       |   2 +-
 .../devicetree/bindings/rng/omap_rng.yaml          |  11 --
 .../bindings/rtc/allwinner,sun4i-a10-rtc.yaml      |   2 +-
 .../bindings/rtc/allwinner,sun6i-a31-rtc.yaml      |   2 +-
 .../bindings/rtc/atmel,at91rm9200-rtc.yaml         |   2 +-
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml        |   2 +-
 .../bindings/rtc/microchip,mfps-rtc.yaml           |   2 +-
 .../bindings/rtc/microcrystal,rv3032.yaml          |   2 +-
 .../devicetree/bindings/rtc/mstar,msc313-rtc.yaml  |   2 +-
 .../devicetree/bindings/serial/cdns,uart.yaml      |   2 +-
 .../bindings/serial/sunplus,sp7021-uart.yaml       |   2 +-
 .../bindings/serio/allwinner,sun4i-a10-ps2.yaml    |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smd.yaml     |  29 +----
 .../devicetree/bindings/sound/adi,max98396.yaml    |   2 +-
 .../devicetree/bindings/sound/ak4375.yaml          |   2 +-
 .../devicetree/bindings/sound/ak4613.yaml          |   2 +-
 .../devicetree/bindings/sound/ak4642.yaml          |   2 +-
 .../bindings/sound/allwinner,sun4i-a10-codec.yaml  |   2 +-
 .../bindings/sound/allwinner,sun4i-a10-i2s.yaml    |   2 +-
 .../bindings/sound/allwinner,sun4i-a10-spdif.yaml  |   2 +-
 .../sound/allwinner,sun50i-a64-codec-analog.yaml   |   2 +-
 .../sound/allwinner,sun8i-a23-codec-analog.yaml    |   2 +-
 .../bindings/sound/allwinner,sun8i-a33-codec.yaml  |   2 +-
 .../bindings/sound/audio-graph-card.yaml           |   2 +-
 .../bindings/sound/audio-graph-card2.yaml          |   2 +-
 .../devicetree/bindings/sound/audio-graph.yaml     |   2 +-
 .../bindings/sound/intel,keembay-i2s.yaml          |   2 +-
 .../devicetree/bindings/sound/linux,bt-sco.yaml    |   2 +-
 .../devicetree/bindings/sound/linux,spdif-dit.yaml |   2 +-
 .../devicetree/bindings/sound/mchp,spdifrx.yaml    |   2 +-
 .../devicetree/bindings/sound/mchp,spdiftx.yaml    |   2 +-
 .../devicetree/bindings/sound/mt6359.yaml          |   2 +-
 .../bindings/sound/nvidia,tegra186-asrc.yaml       |   2 +-
 .../bindings/sound/nvidia,tegra186-dspk.yaml       |   2 +-
 .../bindings/sound/nvidia,tegra210-admaif.yaml     |   2 +-
 .../bindings/sound/nvidia,tegra210-adx.yaml        |   2 +-
 .../bindings/sound/nvidia,tegra210-ahub.yaml       |   2 +-
 .../bindings/sound/nvidia,tegra210-amx.yaml        |   2 +-
 .../bindings/sound/nvidia,tegra210-dmic.yaml       |   2 +-
 .../bindings/sound/nvidia,tegra210-i2s.yaml        |   2 +-
 .../bindings/sound/nvidia,tegra210-mixer.yaml      |   2 +-
 .../bindings/sound/nvidia,tegra210-mvc.yaml        |   2 +-
 .../bindings/sound/nvidia,tegra210-sfc.yaml        |   2 +-
 .../devicetree/bindings/sound/renesas,rsnd.yaml    |   2 +-
 .../bindings/sound/simple-audio-amplifier.yaml     |   2 +-
 .../devicetree/bindings/sound/simple-card.yaml     |   2 +-
 .../devicetree/bindings/sound/sound-dai.yaml       |   2 +-
 .../devicetree/bindings/sound/test-component.yaml  |   2 +-
 .../devicetree/bindings/sound/wlf,wm8940.yaml      |   2 +-
 .../devicetree/bindings/sound/wlf,wm8978.yaml      |   2 +-
 .../bindings/spi/allwinner,sun4i-a10-spi.yaml      |   2 +-
 .../bindings/spi/allwinner,sun6i-a31-spi.yaml      |   2 +-
 .../devicetree/bindings/spi/mxicy,mx25f0a-spi.yaml |   2 +-
 .../devicetree/bindings/spi/spi-cadence.yaml       |   2 +-
 .../devicetree/bindings/spi/spi-xilinx.yaml        |   2 +-
 .../devicetree/bindings/spi/spi-zynqmp-qspi.yaml   |   2 +-
 .../bindings/spmi/mtk,spmi-mtk-pmif.yaml           |   2 +-
 .../sram/allwinner,sun4i-a10-system-control.yaml   |   2 +-
 .../bindings/thermal/allwinner,sun8i-a83t-ths.yaml |   2 +-
 .../bindings/timer/allwinner,sun4i-a10-timer.yaml  |   2 +-
 .../timer/allwinner,sun5i-a13-hstimer.yaml         |   2 +-
 .../devicetree/bindings/timer/arm,arch_timer.yaml  |  11 +-
 .../bindings/timer/arm,arch_timer_mmio.yaml        |   1 +
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   4 +
 .../bindings/timer/mstar,msc313e-timer.yaml        |   2 +-
 .../bindings/timer/rockchip,rk-timer.yaml          |   2 +-
 .../devicetree/bindings/timer/ti,timer-dm.yaml     |  17 ++-
 .../devicetree/bindings/timer/xlnx,xps-timer.yaml  |   2 +-
 .../bindings/timestamp/hte-consumer.yaml           |   2 +-
 .../bindings/ufs/samsung,exynos-ufs.yaml           |   2 +-
 .../bindings/usb/allwinner,sun4i-a10-musb.yaml     |   2 +-
 .../devicetree/bindings/usb/brcm,bcm7445-ehci.yaml |   2 +-
 .../devicetree/bindings/usb/brcm,usb-pinmap.yaml   |   2 +-
 .../devicetree/bindings/usb/generic-ehci.yaml      |   2 +-
 .../devicetree/bindings/usb/generic-ohci.yaml      |   2 +-
 .../devicetree/bindings/usb/generic-xhci.yaml      |   2 +-
 .../devicetree/bindings/usb/mediatek,mtk-xhci.yaml |   2 +-
 .../devicetree/bindings/usb/mediatek,mtu3.yaml     |   2 +-
 .../devicetree/bindings/usb/mediatek,musb.yaml     |   2 +-
 .../bindings/usb/microchip,mpfs-musb.yaml          |   2 +-
 .../devicetree/bindings/usb/smsc,usb3503.yaml      |   2 +-
 Documentation/devicetree/bindings/usb/usb-drd.yaml |   2 +-
 Documentation/devicetree/bindings/usb/usb-hcd.yaml |   2 +-
 .../devicetree/bindings/usb/usb-xhci.yaml          |   2 +-
 Documentation/devicetree/bindings/usb/usb.yaml     |   2 +-
 Documentation/devicetree/bindings/virtio/iommu.txt |  66 ----------
 .../devicetree/bindings/virtio/pci-iommu.yaml      | 101 +++++++++++++++
 Documentation/devicetree/bindings/w1/w1-gpio.yaml  |   2 +-
 .../bindings/watchdog/allwinner,sun4i-a10-wdt.yaml |   2 +-
 .../bindings/watchdog/mstar,msc313e-wdt.yaml       |   2 +-
 MAINTAINERS                                        |   4 +-
 Makefile                                           |   4 +
 drivers/of/address.c                               |   4 +-
 drivers/of/base.c                                  |   7 +-
 drivers/of/device.c                                |   9 +-
 drivers/of/fdt.c                                   |  17 +--
 drivers/of/irq.c                                   |   3 +
 drivers/of/of_private.h                            |   5 +
 drivers/of/unittest.c                              |   5 +-
 include/dt-bindings/leds/common.h                  |   7 +-
 include/linux/of.h                                 |   4 +-
 scripts/Makefile.lib                               |  14 +-
 scripts/dtc/dt-extract-compatibles                 |  69 ++++++++++
 446 files changed, 1469 insertions(+), 993 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/versatile-sysreg.txt
 create mode 100644 Documentation/devicetree/bindings/display/bridge/nxp,tda998x.yaml
 delete mode 100644 Documentation/devicetree/bindings/display/bridge/tda998x.txt
 delete mode 100644 Documentation/devicetree/bindings/i2c/i2c-mt7621.txt
 create mode 100644 Documentation/devicetree/bindings/i2c/mediatek,mt7621-i2c.yaml
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mti,cpu-interrupt-controller.yaml
 delete mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-indicator.yaml
 create mode 100644 Documentation/devicetree/bindings/mailbox/mediatek,gce-mailbox.yaml
 delete mode 100644 Documentation/devicetree/bindings/mailbox/mtk-gce.txt
 delete mode 100644 Documentation/devicetree/bindings/mips/cpu_irq.txt
 delete mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.txt
 create mode 100644 Documentation/devicetree/bindings/misc/qcom,fastrpc.yaml
 delete mode 100644 Documentation/devicetree/bindings/virtio/iommu.txt
 create mode 100644 Documentation/devicetree/bindings/virtio/pci-iommu.yaml
 create mode 100755 scripts/dtc/dt-extract-compatibles
