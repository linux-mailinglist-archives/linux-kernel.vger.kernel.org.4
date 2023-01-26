Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660F67C979
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237203AbjAZLKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237184AbjAZLJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:49 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87656AF7F;
        Thu, 26 Jan 2023 03:09:34 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MU0Mp-1pCROr3PGr-00QlgN;
 Thu, 26 Jan 2023 12:08:49 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
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
Subject: [PATCH v5 00/10] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Thu, 26 Jan 2023 12:08:23 +0100
Message-Id: <20230126110833.264439-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:315RMED9AmsBd8xMefe1WBFV2pMDlT3hh2Mvy9RltU1TnHJkqq+
 sq21sBjbo2Eo0He2utijlqVTKnDV0wvoYqKLEltQFsshzYa9XKalepGFcuuPoueNa5HVhaO
 qpiVaBlUOBs+DAQre86NvVCO0wOep0M9yEQ817hFDCYPQiKrakDoSuoo1h8DPXVk9uIAVo1
 T/1Go6Xu1xN2nzjdjZgkQ==
UI-OutboundReport: notjunk:1;M01:P0:E0bPnQdj/6g=;rI2TG3PQZaFRffl7pygP7f3IM2X
 mFKy9H7Sh9g1s65TPs9bc7xSY3LkpRR+ZnezU2qOh3tv24xqzJ+I48eo4wx/mZXYX/MPNuNmh
 8Cli2Qi5jQwH/+clFg+gbc982E2vJxRN/qLZDm2duFOFzfTpHiLQYJzTuKlfAfvx/NNhlr9Vz
 L5cy0YkuvU+qodD7u08b5aox3w0LBK/rH+BsvYPOYV/BFols/cG3PPu2WdsnV7/ZSstZQ4VKM
 ZruutaSdps/2w/CGxrHDz+ZS7+mjtt6bl7L54c80DkbGqi4abbYZNwGYzIGDp9X97bFP3ZRao
 vDM7ZskcGeiNJpz7OMU5mxOGaU+Aadbv+uRUliBhfgs3DorbEFshGO+7MRVKSKb7U7vgxzv//
 XQrbrK9VM57JULino7rQ8yMfTmf9T0cA70lSHFYvasmWSnTzoc/ECL+Poy2uYuZpnl1mz6W69
 RZm/TwhDWxITZTFX9hPx5v9gJrEpf3vLTSzi8+m5sTIBVmNziaU3pDWOEjYbmLRPkOZcc09NT
 hkj8nLx7JJb6a5J0eHB0c4+XVP87e7+FvcK0Q7mcWPl7D+dwNizVfdakTj2Zlu/CVnLNQLkVo
 y/ojxSitQT3jR9EoUKE0NPKYH2BRelAU0eSXILPH/SDUE0hiRZqSGKk3//vz1eYvqRhzi0/Dl
 lJRZS8xwHWMU5hD6kXR7lu0sg1cViCpO7dzrOjy1vw==
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
nodes, set lpspi0 max frequency to 60MHz, add missed LVDS lpi2c and PWM
power domains, add flexcan in adma, add can node in devicetree, add vpu
decoder and encoder, add toradex,apalis-imx8 et al. to dt-bindings and
finally, add initial support for Apalis iMX8 split into module and
carrier board parts.

Changes in v5:
- Update subject prefix as pointed out by Krzysztof. Thanks!
- Remove LVDS PWM support waiting for Liu's patches to land first.
- Remove bkl1_pwm functionality depending on the above.
- Squashing all Apalis iMX8 specific device tree patches. As outlined by
  Krzysztof reviewers may simply use b4 diff.

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
  arm64: dts: imx8qm: add can node in devicetree

Marcel Ziswiler (3):
  dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
  arm64: dts: freescale: add initial apalis imx8 aka quadmax module
    support
  arm64: dts: freescale: add apalis imx8 aka quadmax carrier board
    support

Max Krummenacher (1):
  arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes

Philippe Schenker (2):
  arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
  arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz

Zhou Peng (1):
  arm64: dts: imx8qm: add vpu decoder and encoder

 .../devicetree/bindings/arm/fsl.yaml          |   19 +
 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  144 ++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  220 +++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  270 +++
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1486 +++++++++++++++++
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
 arch/arm64/boot/dts/freescale/imx8qm.dtsi     |    4 +
 drivers/firmware/imx/scu-pd.c                 |    4 +
 18 files changed, 2755 insertions(+), 1 deletion(-)
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

-- 
2.36.1

