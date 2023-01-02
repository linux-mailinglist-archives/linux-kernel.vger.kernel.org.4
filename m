Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF3365B5B4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236659AbjABRLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236596AbjABRLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:11:07 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CFBDC0C;
        Mon,  2 Jan 2023 09:10:57 -0800 (PST)
Received: from toolbox.int.toradex.com ([104.59.205.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MdsFf-1pSgIa2fqn-00PZd1;
 Mon, 02 Jan 2023 18:10:29 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Marcel Ziswiler <marcel.ziswiler@toradex.com>,
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
Subject: [PATCH v2 0/5] arm64: dts: freescale: prepare and add apalis imx8 support
Date:   Mon,  2 Jan 2023 18:10:17 +0100
Message-Id: <20230102171023.33853-1-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uRrOjMZNZWBp3dUiEgiGfZiEAVN6g34QVpW+6KWVQaF6K8Hth0M
 qoQyx7P7I7DoMwoTy8hxHi3Dnhw/O2i8qnbvObs8GEyIZnS4IJ0Uh2Ujs+DNafGIXxTua4I
 ylLdl5MhTTWHs6XSdSeLrufTZGDtUtTQ2u/o/052x/74AeMld65XG1Nj5s8bjJ+G5nE0/qU
 9pUKdZcNqiCwVN6SyZZxA==
UI-OutboundReport: notjunk:1;M01:P0:B+DowQIJX5I=;DTt9GKxRBQY8yiRmHpYcO58FYrp
 szPDM2YIdYg1RNLC0LSqIrEYdgEH0g3KDDMxVjaylrNjytfV/7u10GXRrKhf4ywOVnQvdPtGO
 6yZrDA/k9vFHsub75EA/T/eUFtaUvcjJwuSh6UmF47dUYLMiPmO5pgz1+g20oXG6OasYfADqN
 G+pCczLU5878XmH0aDxtC+ohYGgj4e2kjCSzc5jkjMLs9VSRWjEec1oGcbF8BQbFWmIvE61Bq
 uqPs78vVzIhHR0f/vhonmWibWku7r/xKoYMK9WdK1h2f0K59rC+oBB9xOf2hPWs3LisN9cz20
 Mvw/at/soK+TjyRLQBeV6qCz46FbZHhn4bbX0Ihypa/HsSK3CyZtpofIuXBd+IsTSbeOrcPa0
 +0XxFyPUGRYILGagOG9IU0KX+8OH1goXweiqC3R06ypaF6BP0bV/bhLv6Fba9OOHlEwQxRXsB
 h1fK0YmNqTAMy3e/xwyLcshFwHCNkZABjWaiAZQL1NvEB8bpPP4wVq+mj0/ziF6tQ5yN22gua
 vMvVCY4dIYn0uNfpDMW6k6D163u5KB0KTUcPrYy968z25nsqq+aDKjFC0fff4KwSydkC2MmJN
 wVGHgzdGSoTFeaeK60Tmp5/CDR8RaNM63s4oliBQ5hqZt+yZcpC0emfLOtaPHJidk9aUyO2Ic
 2bwOQ90hJ/Z8KieDrK7Ndvn2OVH+R5A2VlRspx2qow==
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
to dt-bindings and finally, add initial support for Apalis iMX8.

Changes in v2:
- Fixed missing space in the comment V1.1Module curtsey Max.
- Added Rob's ack.

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
 .../boot/dts/freescale/imx8qm-apalis.dtsi     |  340 ++++
 15 files changed, 2639 insertions(+), 1 deletion(-)
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

