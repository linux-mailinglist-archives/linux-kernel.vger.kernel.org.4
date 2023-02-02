Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF8ED6882D6
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232171AbjBBPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232940AbjBBPjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:39:44 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46F323C7D;
        Thu,  2 Feb 2023 07:39:22 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MEovc-1pPHKo0GjK-00FxTh;
 Thu, 02 Feb 2023 16:33:00 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
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
Subject: [PATCH v6 05/10] arm64: dts: imx8qxp: add flexcan in adma
Date:   Thu,  2 Feb 2023 16:32:15 +0100
Message-Id: <20230202153221.197308-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:hVpPGSSdqpj7zPNz82c0jzvaidawDWXxruHfRDfxUAbPCFzD5yl
 dTUapQCqAOifspwfwoNrG9UhQlWgzMNN+1rUADisFDW/8Jd9wNKmGvhzJR2HtKvn+YLIGD4
 9nyN5ItlE2iv+PAweoApThnnpZzJb8Er/98SazV67ruIL2RvNwxFlWJevpKV1WXwD4cR2d8
 FK/zzW3srVCAj/MrdrIYA==
UI-OutboundReport: notjunk:1;M01:P0:W44o0CjZzCk=;nHA9RDqEMsxlHnZ6Wi4VXC0Iczl
 SMdvdiVpFSLs/yCbW+nTlIb0eHX+R/8oVN5cNQT+prsMnzOfbJBAruROjIkaCNxWfHSIkg4UN
 WOM5mu0nFTtergoM902Z6jzjSZnqTGPzlhiSRl1uebnylG45+b9GiBtYyikrpAWns92LYXZBP
 bDFGoehz+ymOXSH6SQl5x5PKSc4wsqKcThNMLEqTFbqgfivPLAmRvT9VKvNX497tqXn1i4DJF
 I+PsCzir+55v9S0PA1onomYNsLPxh+B2rqvaZD0oZLitN+RJBpFVQFEbSKmN0Fr8YfL14NcXL
 kflMZ2VhFgou0qRtQVOclBqwTBUxW1rn8khQNaDV06YKaxjos7w7z8lXOX/lq/tdFFTe5jfag
 fsnzax0Ql6ZsWGQCz4Il4cxGkcyima4mmH8he7azDW4KtEoLFAwPcpO/pvrBftRuRJ3K6RnOz
 060eKw4+A811W2p+xzJMCrY9eRBcKGWff+wec+MPmlAhcp44TNpzzBA8oIaA89potRwX98LEE
 WjuIlXf8i45NTHMnEu0WJHKq1KVfJZJ7izpSJCI94ICWLPj8ulkmNrDBgT/28zTQrCyzhIKlc
 gghn5yxF/nhPMERXBy/dojb/xmiTbEbPXrZm57VQdvSJgUbg63dnSSa6lm4kItTevOeF+ZiUB
 R2NW0YZAvIpQE0OCpkog3N/iE4C1Rpxe+G0PvcfvCg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Add FlexCAN decive in adma subsystem.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8XQP

---

Changes in v6:
- Add Alexander's tested-by. Thanks!

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
2.36.1

