Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE76467C970
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237122AbjAZLJZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbjAZLJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:19 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E97103E628;
        Thu, 26 Jan 2023 03:09:16 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Lx9WJ-1ob9iP2moj-016g4t;
 Thu, 26 Jan 2023 12:08:53 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: [PATCH v5 01/10] arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
Date:   Thu, 26 Jan 2023 12:08:24 +0100
Message-Id: <20230126110833.264439-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:DYzAsXLYntW0PlxYbyCZaZMvE1st9DvQVP946Oz8OMXgeRrza65
 sU10WjYLNQ64+tS1f1c/Z0rj/xGAyfvxy/m8biUul5v/iKtBFuQSvXqceBUq/dJp0fV5Ynj
 1xaCBiTBm2/z4Z8TZ6yA8nKHsaodhEa1c0j8CWI5ZKeIYToEhvebidm4qHZSbaVQ88C0cpJ
 zLxgzLVdkZpr3W1ELBv3A==
UI-OutboundReport: notjunk:1;M01:P0:qq8kEcB8Zko=;bCqKU9Plx1welAuRyTP1PyOwW/y
 gN1XKoVwbJsLQE8POp/4Fdfyq4MDmyP42JJvdso4iTGarwxoGtsF5ZHYIgUP8uOxcgInj/Ios
 HIzSprR3LR46L7RZ781HQDPzLxF8KDhOWboc7PjtthON3B2xkKF2tiedNgmLFFtGoyOq2i4LB
 IAjHN+43FyjbC8DE6/NBYGJskfIIFVWZHY1w4sjMeOvGOkZRElGSjypu3dU30tove7T+HKaKh
 iaFJcEoECna1//ep9mNCKpaOxy3PmBGidQmN8Dx6tMLMj/vv32EJV4dvPlPMi1l+QfYsTWyVE
 kDgtVWLHXXlD/UCIj7uXma9OYIOx0Mm8NNlF4iFs+8uFeIi2wTtTQYZfkQWfDFMSs7dmqevU3
 WTbP6oCQQQDUcEw7QgQb7ZKNzptsk0F1MZSaI18mGTpfWFecMG94L1JMUgdCUQ04Ny9rYTDJI
 G0nr2JkmPt+9b5Rbprpgaqa+vFRzv3H0alOcFzKWRcORkxNfg/xe7pMi2iX7AwV0KMmkjIX/0
 ctfAPmoc3g/4E43ndT3nfyhANF5T1a3c9HGBW+D2RGLbq1brjtYXeCWDvgK4qRKS5QeRMGzD5
 HrgZx4KDsE2uT/VxF8ibCA5AGB1DOuYDHfjnjO6Oessy9wZPZgC9kt6hyniWwjBkRc+RpTIgb
 XgMsB9/7YEqJAapErvQt6U6ZYXVo58serTHfgU1iHg==
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
2.36.1

