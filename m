Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E47A46715B0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjARH6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D089034C11;
        Tue, 17 Jan 2023 23:27:53 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LhPuw-1ovvVy0A6K-00mXA1; Wed, 18 Jan 2023 08:27:38 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 06/17] arm64: dts: imx8qxp: add flexcan in adma
Date:   Wed, 18 Jan 2023 08:26:44 +0100
Message-Id: <20230118072656.18845-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TmB1o5W7HRRHwDuvbBbkgN9WMvwI50MJW0sbWoXEGTwyqhXq51R
 7qJJSwFkRvJsYrFkja+yWBLgoJsB4gY+P3sQYuT65lXd49Dj8XGZ8aQw/z8P3CvOMQSKcp0
 bCVF8Pkp+UJNo7iV90Aqf6bX2vIruV/Gl9gLvJGCFovkumPOhuYODOkJkTkklK66AvM9Dxc
 x0yPG5euc3Dibg+Y9YSiw==
UI-OutboundReport: notjunk:1;M01:P0:IHteSycRHzE=;4Vdgdubryk8QLe4fVwBGViBmleE
 LCHWHSCkXOBwTRXtcWRLYe/On0+KXyNVcA5VELzSfc+S4n/hxIEKnvRSHCqsZlRpoUloEgk6B
 AGVAwzYBDsEpb4NGoIf6Ghcu5BZwUEm7btCCehRcNJAHUMqTwqPbpPew7omh3f1imcZ5urZT6
 4S1G7hPjFimWYzW/Byve+u/qg3VhrIL1tQYGjp2FanyMH2DQl6Spn1/VZtdiKV/Qqi2UuWQ5M
 9q7G/4dTs+UYw5+ns5mBVCudl9TUmaFvsPjVNKf/vv8OrWtFqr7qDTKnLRQwOBBdQ0nH85Z7W
 8m07u/uA/gKZz2jxViY5S3RKjHP4Oi4ED3YrvG6Cs2IvxnNvZ3iqsZDmM6Jf5y7mXrsq3WuHZ
 vr3YxC/WoIBElUkkN8gpCMKGa4p+cSW/bgISLkfQzt+q2NRH9ZWoMrGQ2k1waIv6Bc0cfoeTZ
 sNJ6Roic+WZB04II5ohDZ36XxjcPsLb69SwEZy6Bu1zCWZxuZKUeviCkXHqq5QgZe599loPiV
 FDofV2vaPSQV0AIqgriMimdIvtJ4v8OsoQ2AWJcSaVWTd/NqlFnw6N3/0gi3ZYh2XuEtOj50A
 QR/+A313e8fEdRvHX6zpIF4VXMxWB3hrUWoM5dQzBo4Ffvph1fr9gCHmufSJ45/O9KpfV2saH
 aku0QGB67oF4YJENNKvrG+eLDKSiNqvaanxjCQogkQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Add FlexCAN decive in adma subsystem.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch combining the following downstream patches:
  commit e8fe3f57223a ("arm64: dts: imx8qxp: add FlexCAN in adma")
  commit 4e90361f1ed3 ("arm64: dts: imx8qxp: add multi-pd support for CAN1/2")
  commit 899f516e61f8 ("arm64: dts: imx8: dma: fully switched to new clk binding")
  commit 8a28ca15a058 ("arm64: dts: imx8qxp: drop multi-pd for CAN device")
  commit c493402197dd ("arm64: dts: imx8: update CAN fsl,clk-source and fsl,scu-index property")

 .../arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
index 6ccf926b77a5..2dce8f2ee3ea 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
@@ -298,6 +298,65 @@ adc1: adc@5a890000 {
 		status = "disabled";
 	};
 
+	flexcan1: can@5a8d0000 {
+		compatible = "fsl,imx8qm-flexcan";
+		reg = <0x5a8d0000 0x10000>;
+		interrupts = <GIC_SPI 235 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		clocks = <&can0_lpcg 1>,
+			 <&can0_lpcg 0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <40000000>;
+		power-domains = <&pd IMX_SC_R_CAN_0>;
+		/* SLSlice[4] */
+		fsl,clk-source = /bits/ 8 <0>;
+		fsl,scu-index = /bits/ 8 <0>;
+		status = "disabled";
+	};
+
+	flexcan2: can@5a8e0000 {
+		compatible = "fsl,imx8qm-flexcan";
+		reg = <0x5a8e0000 0x10000>;
+		interrupts = <GIC_SPI 236 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		/* CAN0 clock and PD is shared among all CAN instances as
+		 * CAN1 shares CAN0's clock and to enable CAN0's clock it
+		 * has to be powered on.
+		 */
+		clocks = <&can0_lpcg 1>,
+			 <&can0_lpcg 0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <40000000>;
+		power-domains = <&pd IMX_SC_R_CAN_1>;
+		/* SLSlice[4] */
+		fsl,clk-source = /bits/ 8 <0>;
+		fsl,scu-index = /bits/ 8 <1>;
+		status = "disabled";
+	};
+
+	flexcan3: can@5a8f0000 {
+		compatible = "fsl,imx8qm-flexcan";
+		reg = <0x5a8f0000 0x10000>;
+		interrupts = <GIC_SPI 237 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-parent = <&gic>;
+		/* CAN0 clock and PD is shared among all CAN instances as
+		 * CAN2 shares CAN0's clock and to enable CAN0's clock it
+		 * has to be powered on.
+		 */
+		clocks = <&can0_lpcg 1>,
+			 <&can0_lpcg 0>;
+		clock-names = "ipg", "per";
+		assigned-clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>;
+		assigned-clock-rates = <40000000>;
+		power-domains = <&pd IMX_SC_R_CAN_2>;
+		/* SLSlice[4] */
+		fsl,clk-source = /bits/ 8 <0>;
+		fsl,scu-index = /bits/ 8 <2>;
+		status = "disabled";
+	};
+
 	i2c0_lpcg: clock-controller@5ac00000 {
 		compatible = "fsl,imx8qxp-lpcg";
 		reg = <0x5ac00000 0x10000>;
@@ -369,4 +428,17 @@ adc1_lpcg: clock-controller@5ac90000 {
 				     "adc1_lpcg_ipg_clk";
 		power-domains = <&pd IMX_SC_R_ADC_1>;
 	};
+
+	can0_lpcg: clock-controller@5acd0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5acd0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_CAN_0 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>, <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "can0_lpcg_pe_clk",
+				     "can0_lpcg_ipg_clk",
+				     "can0_lpcg_chi_clk";
+		power-domains = <&pd IMX_SC_R_CAN_0>;
+	};
 };
-- 
2.35.1

