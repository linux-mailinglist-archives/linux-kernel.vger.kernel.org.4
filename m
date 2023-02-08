Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01E7668E896
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbjBHG5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjBHG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:20 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E479126EF;
        Tue,  7 Feb 2023 22:57:18 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LsSYo-1oSMix0WMK-0121RJ; Wed, 08 Feb 2023 07:56:51 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shijie Qin <shijie.qin@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v7 00/10] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Wed,  8 Feb 2023 07:56:31 +0100
Message-Id: <20230208065641.23544-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ogkiQeyx0a/VLHWE1b4+puLZIP5vwoBlNtsLfWKVcahAQUsO5nq
 0O5UyflnNiKACjEebTeKXwlp6iFzeQ3nARl97eL2KI3CYCo/tXV7RKWmgO6SC7NVgDZcEWv
 jl27l06VIvLXJ9ZpUNqZAwH7fsZk2fXWnmAUTUXjw2MLukq+/stHS+J91St4iOCUTtRYieQ
 zd7TYD3kNuH9+vBAGigIw==
UI-OutboundReport: notjunk:1;M01:P0:16oADleP6u4=;Gps7lkggkZYx9KJ1SRCHtz+BxjZ
 1A5Z8TzqrG+O2xzmqtgb1d+Tzmc+Pp2yE72+eB8iXqYW+9xpJmgmXiO/p0JMyCcOvhBwsoskR
 pllu3TVF0w4OoYtl5kbFVuUnzRFMFg0wxFXFcK+T6OjtqOpkyO/78PTWapZx6CI8rKXR/Rpu6
 b+BLQM4USrSWOHsuCmviP0QMquLQfIfR0UWnpdvepIPsTNYgfA+82FfY6bwqZUBFyh2kpQdaI
 gR7hwBXc4I3CjQpEj9JiUslxFxCYlqh+bmNTDOdgVxDLF6dHFqCet6JeipdWQdQsPwJrBHmPc
 L5w3BqQ5jzWYTQnUquNc44pZODv9d3jBzcNU6Yea+bdj4rCg5Js8P/PPGTajUoiTE5mMzi4s0
 CDb0D7Zii9uhUp/nQ1kW4uvL7WT10ihrDuu7Ka5ykgNlhHDASVuR1WOT8KNRCPtzGDRVTYtP4
 W50X1AHxxPDjx5MuLZOBGIkOeo9v5gGZmOqGupGDYWpvDgeazCY2vIWNZQddATZqmdxyJCi8Q
 VPe+I0hyO61pGyp+WWWbZ1Y8KNHgnBPTOSuGJfmtfHjOacAfUqdlWFl7Y5au/NTS5zQhYmZsU
 RZL+kdTJ6JJsv3umv4Z2c094whXbMsTim8Jql5s49QOKlixygrj6pEXNP72ZY5BfM9J3PIOMv
 X+MkAfi/eSeFqUVkkIFGcco2Ap+ewJ5B3kWNqDwyGg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
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

Changes in v7:
- Re-order device tree properties according to various more or less
  undocumented rules as e.g. pointed out by Shawn. Thanks!

Changes in v6:
- Add Alexander's acked-by. Thanks!
- Add Alexander's tested-by. Thanks!
- Incorporate Shawn's review feedback. Thanks!

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
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1485 +++++++++++++++++
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
 18 files changed, 2754 insertions(+), 1 deletion(-)
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

