Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881C3656065
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 07:29:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbiLZG3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 01:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiLZG3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 01:29:03 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786602717;
        Sun, 25 Dec 2022 22:29:02 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.224.88]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MYyF3-1pNBG31Bx5-00VflN;
 Mon, 26 Dec 2022 07:28:37 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Tim Harvey <tharvey@gateworks.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/5] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Mon, 26 Dec 2022 07:28:18 +0100
Message-Id: <20221226062824.53113-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:zWOs8xApvpqIG8s5SFmkYnLAIoUa1a2eUZ9VMOOL+tATVRXgIUt
 sMhcNzSqb1n25fja0k9YMefy30/NCbMsC2iVCcKHA+dvFg6GGQWdGoLYT2BIFA09KZkTha+
 7VVZBNInq8nmbSS/7+eKZPkPYp76aU76TcXenQmKgn4ZmfvLtc4iLxnweIdJbk/F1yKWP3W
 DHO2vZ/G/qFLmRVp1jnSw==
UI-OutboundReport: notjunk:1;M01:P0:WA1IJCENxCY=;msBFNFwKnfpxEEIWrovicaMEtC1
 TUemo4J9KoHaZICgQIMWaNVdvw2GDj1FVKhraRRSI1aMHAZq8YZsDXQUrQfLsRCa8L+gqFEz6
 oanpyQPgzAmIwYhMkxlt0ROGe/WpEfqkoOBwpkbNdFSI4vmjcSml+fWyUZoQrd2xxhNBRdTNr
 vhqWs5sGV+Kc6L4r9s8achLSA1hhwlTwQK8451mGch/qoyEzhCZ//i+Wxg2GVJ79rJ6sWQ9vE
 +1ho/pFWrWbqOeFCt9pUnjzG8z7pYqcg+/PxP7Rjn5znikBD2wq54ZSbJ++ih7rS07awuV6wd
 SWTODmNEoQW8j8q4alzUTN773Mv43kUwe0qEviXtc9KNpRGRHmfJ8h43ANxqz5rUdbyrRvbRD
 SG0KjsEahh3vA6DR0wt/V9R7QGbBYE89WfExaDPIW2r3t8yE8+IE0JBKF7rxUaTNGc8xukA5L
 XCRh3/E05JcTGNkc7r033QUYGlQEFQdqwPdt0OthlUzOTXpmTG6ES9fdnN67vADNEtBdw7JWb
 adtjeAY25y70CX6RW3vnLx3ja/50L5k4UypWsabCEQCPAlJ+AN5L7dA0/mq9wn3cAQCo8Bhae
 DYcL1ocPtwGRb8qvZARJ97XgoYq5WwdpYkaRnTqZ5S39aeBUvmbZKUJNwZ+ErhTg+ZxG5g0P0
 gDv9U+7Ld35a1uh9mffeTxh1KgKbIgZOWkicvVtK5g==
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
to dt-bindings and finally, add initial support for Apalis iMX8.


Marcel Ziswiler (2):
  dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
  arm64: dts: freescale: add initial support for apalis imx8 aka quadmax

Max Krummenacher (1):
  arm64: dts: fsl-imx8qm-device.dtsi: add io-channel-cells to adc nodes

Philippe Schenker (2):
  arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
  arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz

 .../devicetree/bindings/arm/fsl.yaml          |   12 +
 arch/arm64/boot/dts/freescale/Makefile        |    5 +
 .../boot/dts/freescale/imx8-apalis-eval.dtsi  |  146 ++
 .../dts/freescale/imx8-apalis-ixora-v1.1.dtsi |  214 +++
 .../dts/freescale/imx8-apalis-ixora-v1.2.dtsi |  264 +++
 .../boot/dts/freescale/imx8-apalis-v1.1.dtsi  | 1510 +++++++++++++++++
 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi |    4 +-
 .../boot/dts/freescale/imx8-ss-lsio.dtsi      |   48 +
 .../boot/dts/freescale/imx8qm-apalis-eval.dts |   16 +
 .../freescale/imx8qm-apalis-ixora-v1.1.dts    |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1-eval.dts |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.1.dts         |   16 +
 .../imx8qm-apalis-v1.1-ixora-v1.2.dts         |   16 +
 .../dts/freescale/imx8qm-apalis-v1.1.dtsi     |   17 +
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  342 ++++
 15 files changed, 2641 insertions(+), 1 deletion(-)
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

