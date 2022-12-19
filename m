Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032CC6515A9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 23:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbiLSWic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 17:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiLSWi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 17:38:29 -0500
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29FC35F6C;
        Mon, 19 Dec 2022 14:38:27 -0800 (PST)
Received: by mail-oi1-f175.google.com with SMTP id r205so8203552oib.9;
        Mon, 19 Dec 2022 14:38:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uRciVK5LvluJ+J175lfJTWt/bvLPBXtEYRWCJrezoT8=;
        b=KNjTGFszpNEVTjQ06EA2s4UgIdXMWzdKPKA/zjLHCPd/elpDIWnUOGXY6Q1pK0oNis
         xJ6yygKdZf1rVokdhLHmowIBfClwAuckhTlNH9S4cJlQz6fJEZjlvd7HhV7nklZ26Apj
         Y9rhFL6HdNfkHvk9wIAuyMNQWT/SyN6G3whNcv2HBhlR/3cVQ869TFpmxxDwUp4FMe4b
         bKApdmQU8QnTAJtWPEOBfnlWxwNXsKJzAy4jTD6m1C5a7JPEtXcqDFCgX/45OGg2fE3W
         jZwqq/LLC2tlQ4BPi8cSEwRcUI/scDyhhKRQJTHhUvF7PyA7TrQ1eiMfR9xHkpOBDwW0
         9/JA==
X-Gm-Message-State: ANoB5pmB0gF9cwEWHe3bkmcb4vnxhr4bOo9JWuH3LwuYa8hVbHQqP35I
        pJauB+C1J9YYSr2RCiY1vk2vellW0Q==
X-Google-Smtp-Source: AA0mqf7RDUCSdB8p+oEzqkVBtBIhwSSNh9d7ztKEkuynIyqh6bi6ELfEdark9L6N7FOUxw+gJIsvZg==
X-Received: by 2002:aca:ac8e:0:b0:35e:2d5c:6114 with SMTP id v136-20020acaac8e000000b0035e2d5c6114mr17648978oie.25.1671489506067;
        Mon, 19 Dec 2022 14:38:26 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id 36-20020a9d02a7000000b0066f7e1188f0sm4899752otl.68.2022.12.19.14.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 14:38:25 -0800 (PST)
Received: (nullmailer pid 2513869 invoked by uid 1000);
        Mon, 19 Dec 2022 22:38:25 -0000
Date:   Mon, 19 Dec 2022 16:38:25 -0600
From:   Rob Herring <robh@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [GIT PULL] Devicetree updates for v6.2, part 2
Message-ID: <20221219223825.GA2497163-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull a 2nd batch of DT updates. This is mostly the treewide 
clean-up from Krzysztof I mentioned in my first PR. There's also a 
couple of fixes and things that fell thru the cracks.

I must say this has been a nice merge window without bindings dumped in 
at the last minute introducing warnings.

Rob


The following changes since commit 71a7507afbc3f27c346898f13ab9bfd918613c34:

  Merge tag 'driver-core-6.2-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core (2022-12-16 03:54:54 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git tags/devicetree-for-6.2-2

for you to fetch changes up to 3367934dd3035afa72ac79ae649f142a530df157:

  dt-bindings: drop redundant part of title (manual) (2022-12-16 12:51:43 -0600)

----------------------------------------------------------------
Devicetree updates for v6.2, part 2:

- Treewide dropping of redundant 'binding' or 'schema' from schema
  titles. This will be followed up with a automated check to catch
  these.

- Re-sort vendor-prefies

- Convert GPIO based watchdog to schema

- Handle all the variations for clocks, resets, power domains in i.MX
  PCIe binding

- Document missing 'power-domains' property in mxsfb

- Fix error with path references in Tegra XUSB example

- Honor CONFIG_CMDLINE* even without /chosen node

----------------------------------------------------------------
Alexander Sverdlin (1):
      of: fdt: Honor CONFIG_CMDLINE* even without /chosen node

Krzysztof Kozlowski (11):
      dt-bindings: vendor-prefixes: sort entries alphabetically
      dt-bindings: hwmon: ntc-thermistor: drop Naveen Krishna Chatradhi from maintainers
      dt-bindings: drop redundant part of title of shared bindings
      dt-bindings: memory-controllers: ti,gpmc-child: drop redundant part of title
      dt-bindings: clock: st,stm32mp1-rcc: add proper title
      dt-bindings: drop redundant part of title (end)
      dt-bindings: drop redundant part of title (end, part two)
      dt-bindings: drop redundant part of title (end, part three)
      dt-bindings: drop redundant part of title (beginning)
      dt-bindings: clock: drop redundant part of title
      dt-bindings: drop redundant part of title (manual)

Marek Vasut (5):
      dt-bindings: mxsfb: Document i.MX8M/i.MX6SX/i.MX6SL power-domains property
      dt-bindings: imx6q-pcie: Handle various clock configurations
      dt-bindings: imx6q-pcie: Handle various PD configurations
      dt-bindings: imx6q-pcie: Handle more resets on legacy platforms
      dt-bindings: watchdog: gpio: Convert bindings to YAML

Thierry Reding (1):
      dt-bindings: usb: tegra-xusb: Remove path references

 .../devicetree/bindings/arm/bcm/bcm2835.yaml       |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm11351.yaml |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm21664.yaml |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm23550.yaml |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcm4708.yaml  |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,bcmbca.yaml   |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,cygnus.yaml   |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,hr2.yaml      |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,ns2.yaml      |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,nsp.yaml      |   2 +-
 .../devicetree/bindings/arm/bcm/brcm,stingray.yaml |   2 +-
 .../bindings/arm/bcm/brcm,vulcan-soc.yaml          |   2 +-
 .../devicetree/bindings/arm/cci-control-port.yaml  |   2 +-
 Documentation/devicetree/bindings/arm/cpus.yaml    |   2 +-
 .../bindings/arm/firmware/linaro,optee-tz.yaml     |   2 +-
 .../bindings/arm/hisilicon/hisilicon.yaml          |   2 +-
 .../bindings/arm/keystone/ti,k3-sci-common.yaml    |   2 +-
 .../devicetree/bindings/arm/keystone/ti,sci.yaml   |   2 +-
 .../bindings/arm/marvell/armada-7k-8k.yaml         |   2 +-
 .../devicetree/bindings/arm/mrvl/mrvl.yaml         |   2 +-
 .../devicetree/bindings/arm/mstar/mstar.yaml       |   2 +-
 .../devicetree/bindings/arm/npcm/npcm.yaml         |   2 +-
 .../devicetree/bindings/arm/nxp/lpc32xx.yaml       |   2 +-
 .../bindings/arm/socionext/milbeaut.yaml           |   2 +-
 .../bindings/arm/socionext/uniphier.yaml           |   2 +-
 Documentation/devicetree/bindings/arm/sp810.yaml   |   2 +-
 .../devicetree/bindings/arm/sprd/sprd.yaml         |   2 +-
 .../devicetree/bindings/arm/stm32/st,mlahb.yaml    |   2 +-
 .../bindings/arm/stm32/st,stm32-syscon.yaml        |   2 +-
 .../devicetree/bindings/arm/stm32/stm32.yaml       |   2 +-
 .../arm/sunxi/allwinner,sun6i-a31-cpuconfig.yaml   |   2 +-
 .../arm/sunxi/allwinner,sun9i-a80-prcm.yaml        |   2 +-
 .../arm/tegra/nvidia,tegra-ccplex-cluster.yaml     |   2 +-
 .../bindings/arm/tegra/nvidia,tegra194-cbb.yaml    |   2 +-
 .../bindings/arm/tegra/nvidia,tegra234-cbb.yaml    |   2 +-
 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   2 +-
 .../devicetree/bindings/arm/ti/ti,davinci.yaml     |   2 +-
 .../devicetree/bindings/arm/vexpress-config.yaml   |   2 +-
 .../devicetree/bindings/arm/vexpress-sysreg.yaml   |   2 +-
 .../bindings/ata/allwinner,sun4i-a10-ahci.yaml     |   2 +-
 .../bindings/ata/allwinner,sun8i-r40-ahci.yaml     |   2 +-
 Documentation/devicetree/bindings/bus/ti-sysc.yaml |   2 +-
 .../devicetree/bindings/clock/adi,axi-clkgen.yaml  |   2 +-
 .../devicetree/bindings/clock/calxeda.yaml         |   2 +-
 .../bindings/clock/cirrus,cs2000-cp.yaml           |   2 +-
 .../devicetree/bindings/clock/fixed-clock.yaml     |   2 +-
 .../bindings/clock/fixed-factor-clock.yaml         |   2 +-
 .../bindings/clock/fixed-mmio-clock.yaml           |   2 +-
 .../devicetree/bindings/clock/fsl,plldig.yaml      |   2 +-
 .../devicetree/bindings/clock/fsl,sai-clock.yaml   |   2 +-
 .../devicetree/bindings/clock/fsl,scu-clk.yaml     |   2 +-
 .../devicetree/bindings/clock/idt,versaclock5.yaml |   2 +-
 .../devicetree/bindings/clock/imx1-clock.yaml      |   2 +-
 .../devicetree/bindings/clock/imx21-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx23-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx25-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx27-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx28-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx31-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx35-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx5-clock.yaml      |   2 +-
 .../devicetree/bindings/clock/imx6q-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx6sl-clock.yaml    |   2 +-
 .../devicetree/bindings/clock/imx6sll-clock.yaml   |   2 +-
 .../devicetree/bindings/clock/imx6sx-clock.yaml    |   2 +-
 .../devicetree/bindings/clock/imx6ul-clock.yaml    |   2 +-
 .../devicetree/bindings/clock/imx7d-clock.yaml     |   2 +-
 .../bindings/clock/imx7ulp-pcc-clock.yaml          |   2 +-
 .../bindings/clock/imx7ulp-scg-clock.yaml          |   2 +-
 .../devicetree/bindings/clock/imx8m-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imx8qxp-lpcg.yaml    |   2 +-
 .../bindings/clock/imx8ulp-cgc-clock.yaml          |   2 +-
 .../bindings/clock/imx8ulp-pcc-clock.yaml          |   2 +-
 .../devicetree/bindings/clock/imx93-clock.yaml     |   2 +-
 .../devicetree/bindings/clock/imxrt1050-clock.yaml |   2 +-
 .../devicetree/bindings/clock/ingenic,cgu.yaml     |   2 +-
 .../devicetree/bindings/clock/intel,agilex.yaml    |   2 +-
 .../devicetree/bindings/clock/intel,cgu-lgm.yaml   |   2 +-
 .../devicetree/bindings/clock/intel,easic-n5x.yaml |   2 +-
 .../devicetree/bindings/clock/intel,stratix10.yaml |   2 +-
 .../bindings/clock/microchip,mpfs-clkcfg.yaml      |   2 +-
 .../devicetree/bindings/clock/milbeaut-clock.yaml  |   2 +-
 .../bindings/clock/nuvoton,npcm845-clk.yaml        |   2 +-
 .../bindings/clock/qcom,dispcc-sc8280xp.yaml       |   2 +-
 .../devicetree/bindings/clock/qcom,gcc.yaml        |   2 +-
 .../devicetree/bindings/clock/qcom,rpmhcc.yaml     |   2 +-
 .../devicetree/bindings/clock/renesas,9series.yaml |   2 +-
 .../bindings/clock/renesas,versaclock7.yaml        |   2 +-
 .../bindings/clock/rockchip,rk3568-cru.yaml        |   2 +-
 .../devicetree/bindings/clock/st,stm32mp1-rcc.yaml |   2 +-
 .../devicetree/bindings/clock/ti,lmk04832.yaml     |   2 +-
 .../devicetree/bindings/clock/ti,sci-clk.yaml      |   2 +-
 .../devicetree/bindings/clock/ti/ti,clksel.yaml    |   2 +-
 .../devicetree/bindings/cpu/idle-states.yaml       |   2 +-
 .../bindings/cpufreq/cpufreq-mediatek-hw.yaml      |   2 +-
 .../bindings/cpufreq/qcom-cpufreq-nvmem.yaml       |   2 +-
 .../devicetree/bindings/crypto/st,stm32-crc.yaml   |   2 +-
 .../devicetree/bindings/crypto/st,stm32-cryp.yaml  |   2 +-
 .../devicetree/bindings/crypto/st,stm32-hash.yaml  |   2 +-
 .../devicetree/bindings/display/arm,hdlcd.yaml     |   2 +-
 .../devicetree/bindings/display/arm,malidp.yaml    |   2 +-
 .../bindings/display/bridge/anx6345.yaml           |   2 +-
 .../bindings/display/bridge/chrontel,ch7033.yaml   |   2 +-
 .../display/bridge/ingenic,jz4780-hdmi.yaml        |   2 +-
 .../bindings/display/bridge/intel,keembay-dsi.yaml |   2 +-
 .../bindings/display/bridge/ite,it6505.yaml        |   2 +-
 .../bindings/display/bridge/ite,it66121.yaml       |   2 +-
 .../devicetree/bindings/display/bridge/ps8640.yaml |   2 +-
 .../bindings/display/bridge/toshiba,tc358767.yaml  |   2 +-
 .../bindings/display/bridge/toshiba,tc358775.yaml  |   2 +-
 .../devicetree/bindings/display/fsl,lcdif.yaml     |  15 ++-
 .../devicetree/bindings/display/ingenic,ipu.yaml   |   2 +-
 .../devicetree/bindings/display/ingenic,lcd.yaml   |   2 +-
 .../bindings/display/intel,keembay-display.yaml    |   2 +-
 .../bindings/display/intel,keembay-msscam.yaml     |   2 +-
 .../bindings/display/mediatek/mediatek,cec.yaml    |   2 +-
 .../bindings/display/mediatek/mediatek,dsi.yaml    |   2 +-
 .../display/mediatek/mediatek,hdmi-ddc.yaml        |   2 +-
 .../bindings/display/mediatek/mediatek,hdmi.yaml   |   2 +-
 .../devicetree/bindings/display/msm/gmu.yaml       |   2 +-
 .../devicetree/bindings/display/msm/gpu.yaml       |   2 +-
 .../bindings/display/panel/display-timings.yaml    |   2 +-
 .../bindings/display/panel/ilitek,ili9163.yaml     |   2 +-
 .../display/panel/olimex,lcd-olinuxino.yaml        |   2 +-
 .../bindings/display/panel/panel-lvds.yaml         |   2 +-
 .../bindings/display/panel/panel-timing.yaml       |   2 +-
 .../bindings/display/panel/visionox,rm69299.yaml   |   2 +-
 .../devicetree/bindings/dma/dma-common.yaml        |   2 +-
 .../devicetree/bindings/dma/dma-controller.yaml    |   2 +-
 .../devicetree/bindings/dma/dma-router.yaml        |   2 +-
 .../devicetree/bindings/dma/ingenic,dma.yaml       |   2 +-
 .../devicetree/bindings/dma/st,stm32-dma.yaml      |   2 +-
 .../devicetree/bindings/dma/st,stm32-dmamux.yaml   |   2 +-
 .../devicetree/bindings/dma/st,stm32-mdma.yaml     |   2 +-
 .../devicetree/bindings/dma/ti/k3-bcdma.yaml       |   2 +-
 .../devicetree/bindings/dma/ti/k3-pktdma.yaml      |   2 +-
 .../devicetree/bindings/dma/ti/k3-udma.yaml        |   2 +-
 .../bindings/dma/xilinx/xlnx,zynqmp-dpdma.yaml     |   2 +-
 .../devicetree/bindings/edac/dmc-520.yaml          |   2 +-
 .../bindings/eeprom/microchip,93lc46b.yaml         |   2 +-
 .../devicetree/bindings/example-schema.yaml        |   2 +-
 .../devicetree/bindings/firmware/arm,scmi.yaml     |   2 +-
 .../devicetree/bindings/firmware/arm,scpi.yaml     |   2 +-
 .../bindings/firmware/qemu,fw-cfg-mmio.yaml        |   2 +-
 .../devicetree/bindings/gpio/gpio-tpic2810.yaml    |   2 +-
 .../devicetree/bindings/gpio/ti,omap-gpio.yaml     |   2 +-
 .../devicetree/bindings/gpu/brcm,bcm-v3d.yaml      |   2 +-
 .../bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml |   2 +-
 .../bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml |   2 +-
 .../bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml |   2 +-
 .../bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml |   2 +-
 .../devicetree/bindings/gpu/vivante,gc.yaml        |   2 +-
 .../bindings/hwlock/st,stm32-hwspinlock.yaml       |   2 +-
 .../devicetree/bindings/hwmon/moortec,mr75203.yaml |   2 +-
 .../devicetree/bindings/hwmon/ntc-thermistor.yaml  |   1 -
 .../devicetree/bindings/i2c/i2c-gpio.yaml          |   2 +-
 Documentation/devicetree/bindings/i2c/i2c-pxa.yaml |   2 +-
 .../devicetree/bindings/i2c/ingenic,i2c.yaml       |   2 +-
 .../devicetree/bindings/i2c/st,nomadik-i2c.yaml    |   2 +-
 .../devicetree/bindings/i2c/ti,omap4-i2c.yaml      |   2 +-
 Documentation/devicetree/bindings/i3c/i3c.yaml     |   2 +-
 Documentation/devicetree/bindings/iio/adc/adc.yaml |   2 +-
 .../bindings/iio/adc/allwinner,sun8i-a33-ths.yaml  |   2 +-
 .../devicetree/bindings/iio/adc/ingenic,adc.yaml   |   2 +-
 .../bindings/iio/adc/motorola,cpcap-adc.yaml       |   2 +-
 .../bindings/iio/adc/nxp,imx8qxp-adc.yaml          |   2 +-
 .../bindings/iio/adc/nxp,lpc1850-adc.yaml          |   2 +-
 .../bindings/iio/adc/sigma-delta-modulator.yaml    |   2 +-
 .../bindings/iio/adc/sprd,sc2720-adc.yaml          |   2 +-
 .../devicetree/bindings/iio/adc/st,stm32-adc.yaml  |   2 +-
 .../bindings/iio/adc/ti,palmas-gpadc.yaml          |   2 +-
 .../bindings/iio/adc/x-powers,axp209-adc.yaml      |   2 +-
 .../bindings/iio/dac/nxp,lpc1850-dac.yaml          |   2 +-
 .../devicetree/bindings/iio/dac/st,stm32-dac.yaml  |   2 +-
 .../bindings/iio/multiplexer/io-channel-mux.yaml   |   2 +-
 .../devicetree/bindings/input/fsl,scu-key.yaml     |   2 +-
 .../devicetree/bindings/input/gpio-keys.yaml       |   2 +-
 Documentation/devicetree/bindings/input/input.yaml |   2 +-
 .../devicetree/bindings/input/matrix-keymap.yaml   |   2 +-
 .../bindings/input/microchip,cap11xx.yaml          |   2 +-
 .../bindings/input/pine64,pinephone-keyboard.yaml  |   2 +-
 .../input/touchscreen/chipone,icn8318.yaml         |   2 +-
 .../input/touchscreen/cypress,cy8ctma140.yaml      |   2 +-
 .../input/touchscreen/cypress,cy8ctma340.yaml      |   2 +-
 .../bindings/input/touchscreen/edt-ft5x06.yaml     |   2 +-
 .../bindings/input/touchscreen/goodix.yaml         |   2 +-
 .../bindings/input/touchscreen/himax,hx83112b.yaml |   2 +-
 .../bindings/input/touchscreen/hycon,hy46xx.yaml   |   2 +-
 .../input/touchscreen/imagis,ist3038c.yaml         |   2 +-
 .../bindings/input/touchscreen/melfas,mms114.yaml  |   2 +-
 .../bindings/input/touchscreen/mstar,msg2638.yaml  |   2 +-
 .../input/touchscreen/pixcir,pixcir_ts.yaml        |   2 +-
 .../bindings/input/touchscreen/silead,gsl1680.yaml |   2 +-
 .../bindings/input/touchscreen/ti,tsc2005.yaml     |   2 +-
 .../bindings/input/touchscreen/touchscreen.yaml    |   2 +-
 .../bindings/input/touchscreen/zinitix,bt400.yaml  |   2 +-
 .../interrupt-controller/ingenic,intc.yaml         |   2 +-
 .../bindings/interrupt-controller/mrvl,intc.yaml   |   2 +-
 .../interrupt-controller/nuvoton,wpcm450-aic.yaml  |   2 +-
 .../interrupt-controller/realtek,rtl-intc.yaml     |   2 +-
 .../interrupt-controller/renesas,irqc.yaml         |   2 +-
 .../devicetree/bindings/ipmi/ipmi-ipmb.yaml        |   2 +-
 .../devicetree/bindings/ipmi/ipmi-smic.yaml        |   2 +-
 .../bindings/leds/backlight/gpio-backlight.yaml    |   2 +-
 .../bindings/leds/backlight/led-backlight.yaml     |   2 +-
 .../bindings/leds/backlight/pwm-backlight.yaml     |   2 +-
 .../bindings/leds/backlight/qcom-wled.yaml         |   2 +-
 .../devicetree/bindings/leds/issi,is31fl319x.yaml  |   2 +-
 .../devicetree/bindings/leds/register-bit-led.yaml |   2 +-
 .../devicetree/bindings/leds/regulator-led.yaml    |   2 +-
 .../bindings/mailbox/qcom,apcs-kpss-global.yaml    |   2 +-
 .../devicetree/bindings/mailbox/sprd-mailbox.yaml  |   2 +-
 .../devicetree/bindings/mailbox/st,stm32-ipcc.yaml |   2 +-
 .../bindings/media/allwinner,sun6i-a31-isp.yaml    |   2 +-
 .../bindings/media/i2c/dongwoon,dw9768.yaml        |   2 +-
 .../devicetree/bindings/media/i2c/ov8856.yaml      |   2 +-
 .../bindings/media/i2c/ovti,ov02a10.yaml           |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov5640.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov5645.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov5648.yaml |   2 +-
 .../devicetree/bindings/media/i2c/ovti,ov8865.yaml |   2 +-
 .../bindings/media/i2c/st,st-vgxy61.yaml           |   2 +-
 .../bindings/media/marvell,mmp2-ccic.yaml          |   2 +-
 .../devicetree/bindings/media/renesas,ceu.yaml     |   2 +-
 .../devicetree/bindings/media/st,stm32-cec.yaml    |   2 +-
 .../devicetree/bindings/media/st,stm32-dcmi.yaml   |   2 +-
 .../devicetree/bindings/media/st,stm32-dma2d.yaml  |   2 +-
 .../bindings/media/video-interface-devices.yaml    |   2 +-
 .../bindings/media/video-interfaces.yaml           |   2 +-
 .../memory-controllers/calxeda-ddr-ctrlr.yaml      |   2 +-
 .../ingenic,nemc-peripherals.yaml                  |   2 +-
 .../bindings/memory-controllers/ingenic,nemc.yaml  |   2 +-
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   2 +-
 .../bindings/memory-controllers/ti,gpmc-child.yaml |   2 +-
 .../bindings/memory-controllers/ti,gpmc.yaml       |   2 +-
 .../devicetree/bindings/mfd/actions,atc260x.yaml   |   2 +-
 .../devicetree/bindings/mfd/ene-kb3930.yaml        |   2 +-
 .../devicetree/bindings/mfd/ene-kb930.yaml         |   2 +-
 .../devicetree/bindings/mfd/fsl,imx8qxp-csr.yaml   |   2 +-
 .../devicetree/bindings/mfd/qcom,pm8008.yaml       |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71815-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71828-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71837-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd71847-pmic.yaml |   2 +-
 .../devicetree/bindings/mfd/rohm,bd9576-pmic.yaml  |   2 +-
 .../devicetree/bindings/mfd/st,stm32-lptimer.yaml  |   2 +-
 .../devicetree/bindings/mfd/st,stm32-timers.yaml   |   2 +-
 .../devicetree/bindings/mfd/st,stmfx.yaml          |   2 +-
 .../devicetree/bindings/mfd/st,stpmic1.yaml        |   2 +-
 Documentation/devicetree/bindings/mips/cpus.yaml   |   2 +-
 .../devicetree/bindings/mips/ingenic/devices.yaml  |   2 +-
 .../bindings/mips/lantiq/lantiq,dma-xway.yaml      |   2 +-
 .../devicetree/bindings/mips/loongson/devices.yaml |   2 +-
 .../devicetree/bindings/misc/olpc,xo1.75-ec.yaml   |   2 +-
 .../devicetree/bindings/mmc/arasan,sdhci.yaml      |   2 +-
 .../bindings/mmc/brcm,sdhci-brcmstb.yaml           |   2 +-
 .../devicetree/bindings/mmc/ingenic,mmc.yaml       |   2 +-
 .../bindings/mmc/microchip,dw-sparx5-sdhci.yaml    |   2 +-
 .../devicetree/bindings/mmc/mmc-controller.yaml    |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.yaml   |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-sd8787.yaml |   2 +-
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.yaml |   2 +-
 Documentation/devicetree/bindings/mmc/mtk-sd.yaml  |   2 +-
 .../devicetree/bindings/mmc/sdhci-pxa.yaml         |   2 +-
 .../bindings/mmc/snps,dwcmshc-sdhci.yaml           |   2 +-
 .../devicetree/bindings/mmc/synopsys-dw-mshc.yaml  |   2 +-
 .../devicetree/bindings/mtd/gpmi-nand.yaml         |   2 +-
 .../devicetree/bindings/mtd/ingenic,nand.yaml      |   2 +-
 .../bindings/mtd/microchip,mchp48l640.yaml         |   2 +-
 .../devicetree/bindings/mtd/mxc-nand.yaml          |   2 +-
 .../devicetree/bindings/mtd/nand-chip.yaml         |   2 +-
 .../devicetree/bindings/mtd/nand-controller.yaml   |   2 +-
 .../bindings/mtd/partitions/qcom,smem-part.yaml    |   2 +-
 .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   2 +-
 .../devicetree/bindings/mux/gpio-mux.yaml          |   2 +-
 .../devicetree/bindings/mux/mux-consumer.yaml      |   2 +-
 .../devicetree/bindings/mux/mux-controller.yaml    |   2 +-
 Documentation/devicetree/bindings/mux/reg-mux.yaml |   2 +-
 .../devicetree/bindings/net/asix,ax88178.yaml      |   2 +-
 .../net/bluetooth/bluetooth-controller.yaml        |   2 +-
 .../devicetree/bindings/net/brcm,bcmgenet.yaml     |   2 +-
 .../bindings/net/can/allwinner,sun4i-a10-can.yaml  |   2 +-
 .../devicetree/bindings/net/can/bosch,c_can.yaml   |   2 +-
 .../devicetree/bindings/net/can/bosch,m_can.yaml   |   2 +-
 .../bindings/net/can/can-controller.yaml           |   2 +-
 .../bindings/net/can/can-transceiver.yaml          |   2 +-
 .../devicetree/bindings/net/can/ctu,ctucanfd.yaml  |   2 +-
 .../bindings/net/can/microchip,mcp251xfd.yaml      |   4 +-
 .../devicetree/bindings/net/dsa/arrow,xrs700x.yaml |   2 +-
 .../devicetree/bindings/net/dsa/dsa-port.yaml      |   2 +-
 Documentation/devicetree/bindings/net/dsa/dsa.yaml |   2 +-
 .../bindings/net/dsa/hirschmann,hellcreek.yaml     |   2 +-
 .../bindings/net/dsa/microchip,lan937x.yaml        |   2 +-
 .../devicetree/bindings/net/dsa/mscc,ocelot.yaml   |   2 +-
 .../devicetree/bindings/net/dsa/nxp,sja1105.yaml   |   2 +-
 .../devicetree/bindings/net/engleder,tsnep.yaml    |   2 +-
 .../bindings/net/ethernet-controller.yaml          |   2 +-
 .../devicetree/bindings/net/ethernet-phy.yaml      |   2 +-
 .../bindings/net/fsl,qoriq-mc-dpmac.yaml           |   2 +-
 .../devicetree/bindings/net/ingenic,mac.yaml       |   2 +-
 .../bindings/net/mctp-i2c-controller.yaml          |   2 +-
 Documentation/devicetree/bindings/net/mdio.yaml    |   2 +-
 .../devicetree/bindings/net/microchip,lan95xx.yaml |   2 +-
 .../bindings/net/wireless/esp,esp8089.yaml         |   2 +-
 .../bindings/net/wireless/ieee80211.yaml           |   2 +-
 .../bindings/net/wireless/mediatek,mt76.yaml       |   2 +-
 .../bindings/net/wireless/microchip,wilc1000.yaml  |   2 +-
 .../bindings/net/wireless/qca,ath9k.yaml           |   2 +-
 .../bindings/net/wireless/qcom,ath11k.yaml         |   2 +-
 .../bindings/net/wireless/silabs,wfx.yaml          |   2 +-
 .../devicetree/bindings/nvmem/fsl,scu-ocotp.yaml   |   2 +-
 .../bindings/nvmem/ingenic,jz4780-efuse.yaml       |   2 +-
 .../devicetree/bindings/nvmem/qcom,qfprom.yaml     |   2 +-
 .../devicetree/bindings/nvmem/qcom,spmi-sdam.yaml  |   2 +-
 .../bindings/nvmem/socionext,uniphier-efuse.yaml   |   2 +-
 .../devicetree/bindings/nvmem/st,stm32-romem.yaml  |   2 +-
 Documentation/devicetree/bindings/opp/opp-v1.yaml  |   2 +-
 .../devicetree/bindings/opp/opp-v2-base.yaml       |   2 +-
 .../devicetree/bindings/opp/opp-v2-kryo-cpu.yaml   |   2 +-
 .../devicetree/bindings/opp/opp-v2-qcom-level.yaml |   2 +-
 Documentation/devicetree/bindings/opp/opp-v2.yaml  |   2 +-
 .../devicetree/bindings/pci/fsl,imx6q-pcie.yaml    | 104 +++++++++++++++++++--
 Documentation/devicetree/bindings/pci/pci-ep.yaml  |   2 +-
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml      |   2 +-
 .../devicetree/bindings/phy/brcm,ns2-pcie-phy.yaml |   2 +-
 .../devicetree/bindings/phy/calxeda-combophy.yaml  |   2 +-
 .../bindings/phy/fsl,imx8mq-usb-phy.yaml           |   2 +-
 .../devicetree/bindings/phy/fsl,lynx-28g.yaml      |   2 +-
 .../devicetree/bindings/phy/ingenic,phy-usb.yaml   |   2 +-
 .../bindings/phy/intel,keembay-phy-usb.yaml        |   2 +-
 .../bindings/phy/intel,phy-thunderbay-emmc.yaml    |   2 +-
 .../bindings/phy/marvell,mmp3-usb-phy.yaml         |   2 +-
 .../devicetree/bindings/phy/mediatek,dsi-phy.yaml  |   2 +-
 .../devicetree/bindings/phy/mediatek,hdmi-phy.yaml |   2 +-
 .../devicetree/bindings/phy/mediatek,ufs-phy.yaml  |   2 +-
 .../bindings/phy/phy-cadence-sierra.yaml           |   2 +-
 .../bindings/phy/phy-cadence-torrent.yaml          |   2 +-
 .../devicetree/bindings/phy/phy-stm32-usbphyc.yaml |   2 +-
 .../devicetree/bindings/phy/phy-tegra194-p2u.yaml  |   2 +-
 .../devicetree/bindings/phy/qcom,usb-hs-phy.yaml   |   2 +-
 .../bindings/phy/ti,phy-am654-serdes.yaml          |   2 +-
 .../devicetree/bindings/phy/ti,phy-gmii-sel.yaml   |   2 +-
 .../bindings/phy/transmit-amplitude.yaml           |   2 +-
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml          |   2 +-
 .../bindings/pinctrl/ingenic,pinctrl.yaml          |   2 +-
 .../devicetree/bindings/pinctrl/intel,lgm-io.yaml  |   2 +-
 .../devicetree/bindings/pinctrl/pincfg-node.yaml   |   2 +-
 .../devicetree/bindings/pinctrl/pinmux-node.yaml   |   2 +-
 .../devicetree/bindings/power/avs/qcom,cpr.yaml    |   2 +-
 .../bindings/power/domain-idle-state.yaml          |   2 +-
 .../devicetree/bindings/power/fsl,scu-pd.yaml      |   2 +-
 .../bindings/power/reset/xlnx,zynqmp-power.yaml    |   2 +-
 .../devicetree/bindings/power/supply/bq2415x.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq24190.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq24257.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq24735.yaml  |   2 +-
 .../devicetree/bindings/power/supply/bq25890.yaml  |   2 +-
 .../bindings/power/supply/dlg,da9150-charger.yaml  |   2 +-
 .../power/supply/dlg,da9150-fuel-gauge.yaml        |   2 +-
 .../bindings/power/supply/ingenic,battery.yaml     |   2 +-
 .../devicetree/bindings/power/supply/isp1704.yaml  |   2 +-
 .../bindings/power/supply/lltc,lt3651-charger.yaml |   2 +-
 .../bindings/power/supply/lltc,ltc294x.yaml        |   2 +-
 .../bindings/power/supply/maxim,ds2760.yaml        |   2 +-
 .../bindings/power/supply/maxim,max14656.yaml      |   2 +-
 .../bindings/power/supply/richtek,rt9455.yaml      |   2 +-
 .../bindings/power/supply/sc2731-charger.yaml      |   2 +-
 .../bindings/power/supply/sc27xx-fg.yaml           |   2 +-
 .../bindings/power/supply/ti,lp8727.yaml           |   2 +-
 .../devicetree/bindings/pwm/microchip,corepwm.yaml |   2 +-
 .../bindings/regulator/pwm-regulator.yaml          |   2 +-
 .../bindings/regulator/st,stm32-booster.yaml       |   2 +-
 .../bindings/regulator/st,stm32-vrefbuf.yaml       |   2 +-
 .../remoteproc/amlogic,meson-mx-ao-arc.yaml        |   2 +-
 .../bindings/remoteproc/fsl,imx-rproc.yaml         |   2 +-
 .../bindings/remoteproc/ingenic,vpu.yaml           |   2 +-
 .../devicetree/bindings/remoteproc/mtk,scp.yaml    |   2 +-
 .../devicetree/bindings/remoteproc/qcom,adsp.yaml  |   2 +-
 .../bindings/remoteproc/qcom,pil-info.yaml         |   2 +-
 .../bindings/remoteproc/renesas,rcar-rproc.yaml    |   2 +-
 .../bindings/remoteproc/st,stm32-rproc.yaml        |   2 +-
 .../bindings/reserved-memory/shared-dma-pool.yaml  |   2 +-
 .../devicetree/bindings/reset/ti,sci-reset.yaml    |   2 +-
 .../bindings/reset/ti,tps380x-reset.yaml           |   2 +-
 Documentation/devicetree/bindings/riscv/cpus.yaml  |   2 +-
 .../devicetree/bindings/rng/ingenic,rng.yaml       |   2 +-
 .../devicetree/bindings/rng/ingenic,trng.yaml      |   2 +-
 .../devicetree/bindings/rng/intel,ixp46x-rng.yaml  |   2 +-
 .../bindings/rng/silex-insight,ba431-rng.yaml      |   2 +-
 .../devicetree/bindings/rng/st,stm32-rng.yaml      |   2 +-
 .../bindings/rng/xiphera,xip8001b-trng.yaml        |   2 +-
 .../devicetree/bindings/rtc/epson,rx8900.yaml      |   2 +-
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml       |   2 +-
 .../devicetree/bindings/rtc/ingenic,rtc.yaml       |   2 +-
 .../devicetree/bindings/rtc/renesas,rzn1-rtc.yaml  |   2 +-
 Documentation/devicetree/bindings/rtc/rtc.yaml     |   2 +-
 .../devicetree/bindings/rtc/sa1100-rtc.yaml        |   2 +-
 .../devicetree/bindings/rtc/st,stm32-rtc.yaml      |   2 +-
 Documentation/devicetree/bindings/serial/8250.yaml |   2 +-
 .../devicetree/bindings/serial/8250_omap.yaml      |   2 +-
 .../bindings/serial/brcm,bcm7271-uart.yaml         |   2 +-
 .../devicetree/bindings/serial/ingenic,uart.yaml   |   2 +-
 .../devicetree/bindings/serial/rs485.yaml          |   2 +-
 .../devicetree/bindings/serial/serial.yaml         |   2 +-
 .../devicetree/bindings/serial/st,stm32-uart.yaml  |   2 +-
 .../devicetree/bindings/serio/ps2-gpio.yaml        |   2 +-
 .../devicetree/bindings/soc/mediatek/mtk-svs.yaml  |   2 +-
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml           |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,apr.yaml     |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,smem.yaml    |   2 +-
 .../devicetree/bindings/soc/qcom/qcom,spm.yaml     |   2 +-
 .../devicetree/bindings/soc/qcom/qcom-stats.yaml   |   2 +-
 .../bindings/soc/samsung/exynos-usi.yaml           |   2 +-
 .../devicetree/bindings/soc/ti/sci-pm-domain.yaml  |   2 +-
 .../bindings/sound/audio-graph-port.yaml           |   2 +-
 .../devicetree/bindings/sound/cirrus,cs42l51.yaml  |   2 +-
 .../devicetree/bindings/sound/ingenic,aic.yaml     |   2 +-
 .../devicetree/bindings/sound/ingenic,codec.yaml   |   2 +-
 .../bindings/sound/marvell,mmp-sspa.yaml           |   2 +-
 .../devicetree/bindings/sound/qcom,lpass-cpu.yaml  |   2 +-
 .../bindings/sound/qcom,lpass-rx-macro.yaml        |   2 +-
 .../bindings/sound/qcom,lpass-tx-macro.yaml        |   2 +-
 .../bindings/sound/qcom,lpass-va-macro.yaml        |   2 +-
 .../bindings/sound/qcom,lpass-wsa-macro.yaml       |   2 +-
 .../devicetree/bindings/sound/qcom,q6apm-dai.yaml  |   2 +-
 .../bindings/sound/qcom,q6dsp-lpass-clocks.yaml    |   2 +-
 .../bindings/sound/qcom,q6dsp-lpass-ports.yaml     |   2 +-
 .../devicetree/bindings/sound/qcom,wcd934x.yaml    |   2 +-
 .../bindings/sound/qcom,wcd938x-sdw.yaml           |   2 +-
 .../devicetree/bindings/sound/qcom,wcd938x.yaml    |   2 +-
 .../devicetree/bindings/sound/qcom,wsa881x.yaml    |   2 +-
 .../devicetree/bindings/sound/qcom,wsa883x.yaml    |   2 +-
 .../devicetree/bindings/sound/realtek,rt1015p.yaml |   2 +-
 .../devicetree/bindings/sound/realtek,rt5682s.yaml |   2 +-
 .../devicetree/bindings/sound/ti,src4xxx.yaml      |   2 +-
 .../bindings/soundwire/soundwire-controller.yaml   |   2 +-
 .../bindings/spi/aspeed,ast2600-fmc.yaml           |   2 +-
 .../devicetree/bindings/spi/ingenic,spi.yaml       |   2 +-
 .../devicetree/bindings/spi/marvell,mmp2-ssp.yaml  |   2 +-
 .../devicetree/bindings/spi/omap-spi.yaml          |   2 +-
 .../devicetree/bindings/spi/spi-controller.yaml    |   2 +-
 .../devicetree/bindings/spi/spi-gpio.yaml          |   2 +-
 .../devicetree/bindings/spi/st,stm32-qspi.yaml     |   2 +-
 .../devicetree/bindings/spi/st,stm32-spi.yaml      |   2 +-
 .../bindings/thermal/fsl,scu-thermal.yaml          |   2 +-
 .../devicetree/bindings/thermal/imx-thermal.yaml   |   2 +-
 .../bindings/thermal/imx8mm-thermal.yaml           |   2 +-
 .../devicetree/bindings/thermal/sprd-thermal.yaml  |   2 +-
 .../bindings/thermal/st,stm32-thermal.yaml         |   2 +-
 .../bindings/thermal/thermal-cooling-devices.yaml  |   2 +-
 .../devicetree/bindings/thermal/thermal-idle.yaml  |   2 +-
 .../bindings/thermal/thermal-sensor.yaml           |   2 +-
 .../devicetree/bindings/thermal/thermal-zones.yaml |   2 +-
 .../bindings/thermal/ti,am654-thermal.yaml         |   2 +-
 .../bindings/thermal/ti,j72xx-thermal.yaml         |   2 +-
 .../devicetree/bindings/timer/ingenic,sysost.yaml  |   2 +-
 .../devicetree/bindings/timer/ingenic,tcu.yaml     |   2 +-
 .../devicetree/bindings/timer/mrvl,mmp-timer.yaml  |   2 +-
 .../devicetree/bindings/timer/st,stm32-timer.yaml  |   2 +-
 .../devicetree/bindings/trivial-devices.yaml       |   2 +-
 .../devicetree/bindings/usb/analogix,anx7411.yaml  |   2 +-
 .../devicetree/bindings/usb/cdns,usb3.yaml         |   2 +-
 Documentation/devicetree/bindings/usb/dwc2.yaml    |   2 +-
 .../devicetree/bindings/usb/faraday,fotg210.yaml   |   2 +-
 .../devicetree/bindings/usb/ingenic,musb.yaml      |   2 +-
 .../bindings/usb/marvell,pxau2o-ehci.yaml          |   2 +-
 .../devicetree/bindings/usb/maxim,max33359.yaml    |   2 +-
 .../bindings/usb/mediatek,mt6360-tcpc.yaml         |   2 +-
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml |   2 +-
 .../bindings/usb/nvidia,tegra124-xusb.yaml         |   4 +-
 .../bindings/usb/nvidia,tegra186-xusb.yaml         |   4 +-
 .../bindings/usb/nvidia,tegra194-xusb.yaml         |   8 +-
 .../bindings/usb/nvidia,tegra210-xusb.yaml         |   8 +-
 .../devicetree/bindings/usb/nxp,isp1760.yaml       |   2 +-
 .../devicetree/bindings/usb/realtek,rts5411.yaml   |   2 +-
 .../devicetree/bindings/usb/richtek,rt1719.yaml    |   2 +-
 .../devicetree/bindings/usb/st,stusb160x.yaml      |   2 +-
 .../devicetree/bindings/usb/ti,j721e-usb.yaml      |   2 +-
 .../devicetree/bindings/usb/ti,tps6598x.yaml       |   2 +-
 .../devicetree/bindings/usb/ti,usb8041.yaml        |   2 +-
 .../devicetree/bindings/usb/usb-device.yaml        |   2 +-
 .../devicetree/bindings/usb/willsemi,wusb3801.yaml |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml       |  64 ++++++-------
 .../devicetree/bindings/virtio/virtio-device.yaml  |   2 +-
 .../devicetree/bindings/watchdog/fsl,scu-wdt.yaml  |   2 +-
 .../devicetree/bindings/watchdog/gpio-wdt.txt      |  28 ------
 .../bindings/watchdog/linux,wdt-gpio.yaml          |  55 +++++++++++
 .../bindings/watchdog/st,stm32-iwdg.yaml           |   2 +-
 .../devicetree/bindings/watchdog/watchdog.yaml     |   2 +-
 drivers/of/fdt.c                                   |  40 ++++----
 490 files changed, 703 insertions(+), 588 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/watchdog/gpio-wdt.txt
 create mode 100644 Documentation/devicetree/bindings/watchdog/linux,wdt-gpio.yaml
