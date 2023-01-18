Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639886715AF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjARH5t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:57:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjARHx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B632E5F;
        Tue, 17 Jan 2023 23:27:45 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LwJuC-1oevnl0WdC-01849n; Wed, 18 Jan 2023 08:27:11 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ming Qian <ming.qian@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Zhou Peng <eagle.zhou@nxp.com>
Subject: [PATCH v4 00/17] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Wed, 18 Jan 2023 08:26:38 +0100
Message-Id: <20230118072656.18845-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Pl6GOTSUiQJBx3PfR7nqmf9tnXyXEOUZd9HqKI7Md7g1YAjGVIb
 lqEX4klknu+IRlCgyBqiIyfGHslnNiuX2QU2W3rpvfZhVcgJ2PJCnFbw5KG6xhoYfEsE1yK
 v5gLFsyOBTFu0oOvam+xlJBUr8MJiFj0jQtruAxqjsrDa0o7dq1Vy7kmW0i/z6/Wmby1UXw
 YOf+LcKJcgSEHWqYYYdXQ==
UI-OutboundReport: notjunk:1;M01:P0:BhD8qwQtzCQ=;/MTU6rHTS8w2UVGYrceVLaFqr4g
 VMHrMjE5fK/9xyxTUIz5Aobs0upNmdzJYz4LfxYyY71IU86lu6R7Upum1bhRu3o6p+RbobpIE
 XRdfB1MR84fepnLLAkKWy9DnU8GRhzHtW/Os1GfetO9YGBlqSG3zHQAe9XcK5LhcjqLiY/lyE
 9zytBL3JsojN+/omDBK+Q1/M4b+hplWc4teXTDbQbOWRMjjf7Y6OX9GpnkEIOI1konBmse/ww
 jrJuiyR+yeGenB9zGxc4DrFn8tUOz6/WR8GQYN/dzQPIhGIKpyJkYUsKux9hBM9V2mDIIb81z
 XjbOBJZWqgciW2VnaJdy4kmglFAd5PifSKhYta8uKa8P+eQXOcxsui+ev/gB5YwYNea+i3eaR
 OBXqbAoRfoj32m8Lt0KixgXDWmdqpwYqwDyhHm1kfedVpWgmO3JTkWlByLP0oHtFNiUV4uZbd
 +UmBFlg8WpeepASnUUHdpuVcxpC1tvwD8jL5MZAKfylij2VfjZwgoN+McG+kOmDuE7AZ39Sj8
 j8WfRG00dITFrEYFPYCyHMprhWxru41RpgoKKRc24Bql7DioNYlIVdBkdqsG65VIl+tTTjqJ6
 4xe2ypsuPKTl2bl7Cj655LuxKUXOG300x6rqOl3G9fma4B6JLpzkRxHyGSQ8gbG7+aEbEwd7I
 5XoWHurskUV5yxty8Mqe5N+xAPUVk/VnpTOI5lWTtg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>


Add support for lsio_pwm0-3, add io-channel-cells property for ADC
nodes, set lpspi0 max frequency to 60MHz, add toradex,apalis-imx8 et al.
to dt-bindings and finally, add initial support for Apalis iMX8 split
into module and carrier board parts.

The following 6 patches added in v4 were only kept separate for review
purpose and may ultimately be squashed by the maintainer uppon
application (just like this carrier board one with the previous module
one):
- analogue audio comment
- add bkl1_pwm functionality
- add flexcan functionality
- enable messaging units
- fix reserved-memory node names
- enable vpu

Changes in v4:
- New patch inspired by the following downstream patch:
  commit 0c36c5b63c1e ("LF-3569-1 firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains")
  Avoiding the following being reported upon boot:
  [    1.309776] lvds0_pwm0_clk: failed to attached the power domain -2
  [    1.334097] lvds1_pwm0_clk: failed to attached the power domain -2
  ...
  [   15.281767] platform 57244000.pwm: deferred probe pending
  ...
  [   15.292630] platform backlight: deferred probe pending
- New patch combining the following downstream patches limitted to LVDS
  PWM functionality for now:
  commit 036c6b28a186 ("arm64: imx8qm.dtsi: Add LVDS0/1 subsystems support")
  commit c3d29611d9d4 ("arm64: imx8qm-ss-lvds.dtsi: Add pwm_lvds0/1 support")
  commit baf1b0f22f8a ("LF-882-1 arm64: imx8qm-ss-lvds.dtsi: Separate ipg clock for lvds0/1 subsystems")
- New patch combining the following downstream patches:
  commit e8fe3f57223a ("arm64: dts: imx8qxp: add FlexCAN in adma")
  commit 4e90361f1ed3 ("arm64: dts: imx8qxp: add multi-pd support for CAN1/2")
  commit 899f516e61f8 ("arm64: dts: imx8: dma: fully switched to new clk binding")
  commit 8a28ca15a058 ("arm64: dts: imx8qxp: drop multi-pd for CAN device")
  commit c493402197dd ("arm64: dts: imx8: update CAN fsl,clk-source and fsl,scu-index property")
- New patch inspired by the following downstream patch:
  commit 117607e6a7b5 ("arm64: dts: imx8qm: add CAN node in devicetree")
- New patch combining the following downstream patches:
  commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
  commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")
- Shorten subject.
- New patch adding comment about analogue audio being another todo.
- New patch adding Apalis BKL1_PWM functionality.
- New patch adding flexcan functionality.
- New patch enabling messaging units aka MUs.
- New patch fixing reserved-memory node names.
- New patch enabling VPU functionality.

Changes in v3:
- Fix subject as pointed out by Shawn. Thanks!
- Properly accommodate for -v1.1 modules curtsey Francesco.
- Only use V1.1 compatible for V1.1 module dtsi.
- Split patch into separate module and carrier boards parts as suggested
  by Shawn.
- Put reg after compatible as requested by Shawn.
- Move atmel_mxt_ts and rtc_i2c into module dtsi to save such
  duplications as suggested by Shawn.
- Change iomuxc pinctrl indent style as suggested by Shawn.
- Change led node names to the preferred first form as suggested by
  Shawn. While at it also add color (yikes), default-state and function
  properties and remove the deprecated label property.
- Put enable-active-high properties after the gpio ones as suggested by
  Shawn. Thanks!
- Remove adc node's vref-supply and accompanying reg_vref_1v8 regulator
  node.
- Rename gpio-hogs adherring to dt schema naming convention.

Changes in v2:
- Fixed missing space in the comment V1.1Module curtsey Max.
- Added Rob's ack.

Clark Wang (1):
  firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains

Joakim Zhang (2):
  arm64: dts: imx8qxp: add flexcan in adma
  arch: arm64: imx8qm: add can node in devicetree

Liu Ying (1):
  arm64: dts: imx8qm: add pwm_lvds0/1 support

Marcel Ziswiler (9):
  dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
  arm64: dts: freescale: add initial apalis imx8 aka quadmax module
    support
  arm64: dts: freescale: add apalis imx8 aka quadmax carrier board
    support
  arm64: dts: freescale: apalis-imx8: analogue audio comment
  arm64: dts: freescale: apalis-imx8: add bkl1_pwm functionality
  arm64: dts: freescale: apalis-imx8: add flexcan functionality
  arm64: dts: freescale: apalis-imx8: enable messaging units
  arm64: dts: freescale: apalis-imx8: fix reserved-memory node names
  arm64: dts: freescale: apalis-imx8: enable vpu

Max Krummenacher (1):
  arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes

Philippe Schenker (2):
  arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
  arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz

Zhou Peng (1):
  arm64: dts: imx8qm: add vpu decoder and encoder

 .../devicetree/bindings/arm/fsl.yaml          |   19 +
 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  149 ++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  225 +++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  275 +++
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1491 +++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi |   76 +-
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   48 +
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   16 +
 .../freescale/imx8qm-apalis-ixora-v1.1.dts    |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.1.dts         |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.2.dts         |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     |   16 +
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  340 ++++
 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     |   44 +
 .../boot/dts/freescale/imx8qm-ss-lvds.dtsi    |   83 +
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |    5 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 19 files changed, 2859 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-eval.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-ixora-v1.2.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-eval.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.1.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1-ixora-v1.2.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis-v1.1.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-apalis.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8qm-ss-lvds.dtsi

-- 
2.35.1

