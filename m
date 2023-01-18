Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CC567159E
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjARHzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjARHx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:28 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E4431E31;
        Tue, 17 Jan 2023 23:27:36 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MTjFe-1p9Lff1kqO-00QU41; Wed, 18 Jan 2023 08:27:16 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 01/17] arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
Date:   Wed, 18 Jan 2023 08:26:39 +0100
Message-Id: <20230118072656.18845-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:EibaPIfpv7KUPNuvZPNxGfELWGIEYyNvgVLXWedKZBWRUH2mkKx
 qu08SPQFa0Wn1YvL3Z4ExZ3b/09RjOytzqHHLWCg1mILHvfrO+pzu7TP3tAzAr9XBhJ7cw4
 58+pjhlvi9hjuDAVFPpPR7GGFvNOktB4iRKepZ58ZxJV2yaLMZfgq3ZND6354mwGAlRiSSf
 so4XlEmo5ZGFu5TGeOlkQ==
UI-OutboundReport: notjunk:1;M01:P0:NY9Rj/Eb4ko=;yP8Fg9T26Pfdk85MYd4tId1mGfs
 8SefZeJKRjl0hx18VMwHmDEMziygR52WWVmYFi/0t15LczX/ENSgcsLsEuTXtN8l27+ry0UQ0
 r8XxQZ1h1kkWvK2Cski2Auy46lwTTEj43oER+PeeWXMEupt/TXIj7+dInyQhmuWQbYcClFbyE
 pY9OEv6BbWjubFyAFmbgtss4BQWmOvGpwbHAPQzKxx8F8jkcfYVYQQSIfgILDuWhziAYXv/aY
 oDq/rs15wMQrpv2xkN9Sj1YRCT//gCccImw1apL1Gzf5mf/IvZ5ZrxY4lkNdqSQbuQzmGNNc3
 GOtK0VGfpIzfSiDHyjfxP6TDIRN+OaY3UrWBizx+YS9X+OEx02y03tMaV8iBJkYFX8FHS/nv1
 TOLE9vBfpNyEn1XldMkEDxfGzCnWePr0lOIE5BX1sTbIsarriF2qX7/XFQ9/aokZzj9YhdX9R
 kTX3xyeKB+ePniQq1ftX2WTYtO7n8rlgWCY20yuXODq0kquKXnLRfPPtF9bw+XLjYNtglLLtS
 L74UKjK3Sp3p92CqIJT+WzZzPaaA/X0eVa4NmlMRE55JEBHXZLNGPNBoAvSTrbCp5bzjw4IF9
 T4facesZZdiKENitZrK0ekMlSlECCJUqrOk/k4wntjN9H2MBFalmb9/5rAbebk0rCnXBGQloj
 L2dVGh/4uYX0acf7CF25Gud3uzb9cxZrR0MA0rQL4A==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philippe Schenker <philippe.schenker@toradex.com>

Add support for lsio_pwm0-3.

Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

(no changes since v1)

 .../boot/dts/freescale/imx8-ss-lsio.dtsi      | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
index 1f3d225e64ec..62b7f7a3e1bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-lsio.dtsi
@@ -28,6 +28,54 @@ lsio_bus_clk: clock-lsio-bus {
 		clock-output-names = "lsio_bus_clk";
 	};
 
+	lsio_pwm0: pwm@5d000000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d000000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm0_lpcg 4>,
+			 <&pwm0_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm1: pwm@5d010000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d010000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm1_lpcg 4>,
+			 <&pwm1_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_1 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm2: pwm@5d020000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d020000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm2_lpcg 4>,
+			 <&pwm2_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_2 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
+	lsio_pwm3: pwm@5d030000 {
+		compatible = "fsl,imx27-pwm";
+		reg = <0x5d030000 0x10000>;
+		clock-names = "ipg", "per";
+		clocks = <&pwm3_lpcg 4>,
+			 <&pwm3_lpcg 1>;
+		assigned-clocks = <&clk IMX_SC_R_PWM_3 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <24000000>;
+		#pwm-cells = <2>;
+		status = "disabled";
+	};
+
 	lsio_gpio0: gpio@5d080000 {
 		reg = <0x5d080000 0x10000>;
 		interrupts = <GIC_SPI 136 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.35.1

