Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6D665B5AF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236520AbjABRLp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:11:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbjABRLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:11:02 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201A95F4E;
        Mon,  2 Jan 2023 09:10:52 -0800 (PST)
Received: from toolbox.int.toradex.com ([104.59.205.51]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Ld04c-1oUZCY3QDg-00iGew;
 Mon, 02 Jan 2023 18:10:31 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com,
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
Subject: [PATCH v2 1/5] arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
Date:   Mon,  2 Jan 2023 18:10:18 +0100
Message-Id: <20230102171023.33853-2-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230102171023.33853-1-marcel@ziswiler.com>
References: <20230102171023.33853-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:h21lIyVYKz/bo6KJX2h0v+41TuDI/KYU4WoQMv5amhvFQbtN41m
 /jEvshjexIOA3o/RzunTg8qdstuDwdXcwYRI4dnrlzgh8gUbA3e5/+6zXC5nxZB86eUxDg6
 H9YC6oWNhxOIbsg33a+aV8PUuUaAqwhk5EgW0cZsARRxR15Kj4xVRV0taSugdf0uGS73icD
 6Oo1aAYs9Y/6IQ1b/lfiQ==
UI-OutboundReport: notjunk:1;M01:P0:C01kr2S4BaU=;tLJf4/6JxFNR2R+Y+pYf38xpO++
 xQwZ8TnOeUCf6bTFsHx10VBOIhyd1gpuVyfXKZ2Nt/+UQdXGP3uG1bZLa0sRFOSOa3pK01nU5
 668hZ+USDTILb564uXBIURqt3rjx67ne6cNH3Npz1sVufw2rUj1bQwaXx1CJP4zyT4L9e4d+e
 vLBluis/Ftt79Gb/iu0To2B5VAkpwsSK3Sh/rP4OoIdg4L9/6jY6ZaoBmdQGxo16qi0m8z33d
 vqX+jBP1SIQ6nipuEHYZDDSCE0zAp95hESNwWiCkozRnpVkSl5VbIOQG6wFQV6Yr1UsM288DJ
 fGsFCF9dyrQ+qBSLxVdr66dmc/vH3q9sniXEWXYxeS43J5aMDs+V27lznI7NJDhRhXR9PlHsU
 XROmFxJuZ5M/zsHi7JjmJxiWkl6qZLars76uz9XlaBN5qXgCp0hnxktuuqjFOnRUO5/KbwEpB
 I+XwV20EMCfH39TqrUsYJd4DvOJJ+bhBFfIr3mmGS0ArqA6Ukuf7IhjaIAnqaxKwqzmmGDpQA
 1+dK0CyUxIFWwQv5PWrPvtXmb+15FeswOzo9OM5g8eNz39jkhuYODrRJOB+qawWGGbH209H6G
 hN5JPCA4yXlBvVHxKKKZMjRCm6nnLxgQruUt1/unlTcFo2/Ra8MmJXNMX5vlqDCuV5P04NS8O
 n3ePctfTs3Hkr2tV6WX7y5rGYnqdGpIXn9/v0CalaQ==
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

