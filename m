Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9983B68E899
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjBHG5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbjBHG53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:29 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B5126EF;
        Tue,  7 Feb 2023 22:57:26 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0LgrQ0-1ommkQ0KE2-00oCMB; Wed, 08 Feb 2023 07:57:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v7 05/10] arm64: dts: imx8qxp: add flexcan in adma
Date:   Wed,  8 Feb 2023 07:56:36 +0100
Message-Id: <20230208065641.23544-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:e+4oXaJaC7ZRDTsJPAuc1ZGuyY+99oW8TkZwpi8in+0+BaPH0FD
 8PvCcrEo7BWzt/CRJNPHS1VRFlkcplDQMHITtBLvF4oCprvaJmqXyRCi94/n2lALYtQDN26
 ycJPpStQCsWsyzVbwXTR9odaCvAydzeCcFBhf97BxAp9pgxcz0cO1GzM1bC95vK5LKZGYv5
 INWnxi+hBj3emHXBXoF5g==
UI-OutboundReport: notjunk:1;M01:P0:dd8F53CH0j8=;Pv1NcLBR0Al7W7ZEss6nP9A+ZqD
 82yA0ofySuFQFzxyBT0NhRI7ABxdPYcDZ1wlmVxuGA19q3TTVD8bqNLda1Gc7gg+EdvrO3M8o
 8oPmHeGo4UPq1XDnB6qxxVYa7S0bz8otxFLNFSL0G5jMH7wYaP9ZYmUcat9ga68S3On5EVvNz
 YDStywBcb2js0DU/a9V3CEnjQgpL+KDvZO4yFqRTwBQvZSm4yv1lkwU9g+qos1rKFnpjPaBSH
 PTBXt93rqkq+y1k+DMvNrEvh6E7NXoVHkPIE62BMeP1Q18JjTOZWicXSgZRKeg/mhkBkQ/dB8
 UqlIpVDgw6Dks6qbKX2OVxkaFdHbS0BfiRWLoao4HN6I5ChlYyDwRaVYItSdwrHWmPaAxmDD0
 U9mM4UWbPR+kZfXRU44bgzJ6ljN0oLmIKfi59RaGbR7bTFP8jJkSG1B0ExQPFEllPNMWb03p0
 HNwqllArfoHHzrQy3xFZtYqRSGL7FJYWpDO4WN17UBzK69q2VGLqrKtEUcvh58Qb+5y3Iktct
 RezGVaxILwJbZRf5Jeoihja5AK6J6qglVH0oCr+FiSZ7vNUrk9rGCNN00Oa4wKycDfVxLvG3I
 zPFwUGabOBbNGF4hCMM9DAw5OTnRDicEUPHXSy5ZSKbSNWjvR/Xvl4nlg1E89p7YVHwvM8yFI
 vcv+J+TWkpinq/5H1rK8jlXAgBJ4xHiBs6lOZ+/svw==
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
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> # TQMa8XQP

---

(no changes since v6)

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

