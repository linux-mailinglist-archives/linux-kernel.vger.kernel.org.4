Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE4396659C5
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 12:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbjAKLIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 06:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbjAKLGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 06:06:44 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E95FB7;
        Wed, 11 Jan 2023 03:06:35 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MfprR-1oZsW716pl-00gICc;
 Wed, 11 Jan 2023 12:06:06 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH v3 0/6] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Wed, 11 Jan 2023 12:05:51 +0100
Message-Id: <20230111110558.349460-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zHV333CeqNSqZVjbRhh7DNu5+URnKNvB5/uzr0G+C/YDZouEox+
 jZ/HozYw50/SdXEP79h+0K89dNwbK/SFrW7ew1soq0sJ0er4aeakJTCQ2eX/phDI/cninxL
 sVFv7+pZY6jykTXq9Jbt8ubQGrEKxEF69TXk7XgofmFJsfy40fKy2T7z3BapmNTHrc92yz4
 /XJXzrQtdF6XHsy8yYb/Q==
UI-OutboundReport: notjunk:1;M01:P0:7VutKdI45q4=;AQujzV3M9I31fCLKS/IiYkf0zrC
 gYHk6CG2AgidSQNZAnEGP1znvoan4LGq3bmrvKl8c5+TYO7satxAV5xQoZYwUutDyvuBhluTI
 8QJ9uBKqpydGWKuM2vP9i8l3gN4JO6AKyVyJ0SFD7037ULvgXb5EkOtNJO95ARZDU6hM7wTFv
 t/u16VJum9Lg3P7RV9FMajF4hY5GPfsBfGdSQw+ha0ixdN0uHDWktUnxEpu9te414COw4vkLf
 M3Vh8S26StU5dSth8HMRR+TXb/MCqXvW0GcGJZpBFL2u6CCk1YjhwsD5o7iV+qWQ4rjJ36mxw
 RW6Qhg3ccoa043ZolkJUOE04p6wGv87Vs3+SA8qG7sdUTx2HHaNMZ7iH3IR3VfuN0xwhQaYP8
 kzz4uXcNV//v0LgBqplvdGLJemf89MXf9BySOB48HVMNIwrOSESnri9yvQYGXzDysW0xNS/F2
 6P50qC/3ede6UxfDF4A7zf9bCbIEuRUAjXxPVo5bqZGNr2PNt+Os0cx4YUOBap6AP3/U6RBhe
 oRB5WVVfcTImSURVnwHdwywYpWQoy2S7sWb01gfLvh9ArYyyTr752dOi5CetHfwW1P4BsKeSD
 wMbDLpt4U5EIrz4rGfIolwkO/M1g4Umwbfw0pYun8jP9qQwbM429jabvnJkKas7x0Bsg7VDOr
 4y1Yv1AY6xgblwl4l/mjOTggsaRMOvEWFUA+3x0G9A==
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
nodes, set lpspi0 max frequency to 60MHz, add toradex,apalis-imx8 et al.
to dt-bindings and finally, add initial support for Apalis iMX8 split
into module and carrier board parts.

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

Marcel Ziswiler (3):
  dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
  arm64: dts: freescale: add initial apalis imx8 aka quadmax module
    support
  arm64: dts: freescale: add initial apalis imx8 aka quadmax carrier
    board support

Max Krummenacher (1):
  arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes

Philippe Schenker (2):
  arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
  arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz

 .../devicetree/bindings/arm/fsl.yaml          |   19 +
 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  134 ++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  210 +++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  258 +++
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1439 +++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi |    4 +-
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   48 +
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   16 +
 .../freescale/imx8qm-apalis-ixora-v1.1.dts    |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.1.dts         |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.2.dts         |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     |   16 +
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  340 ++++
 15 files changed, 2552 insertions(+), 1 deletion(-)
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
2.35.1

