Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642536715B5
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 08:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjARH6s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 02:58:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjARHxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 02:53:30 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08EB34C24;
        Tue, 17 Jan 2023 23:27:54 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.137]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0Mb6pp-1p1sU22GL5-00KktW; Wed, 18 Jan 2023 08:27:42 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v4 07/17] arch: arm64: imx8qm: add can node in devicetree
Date:   Wed, 18 Jan 2023 08:26:45 +0100
Message-Id: <20230118072656.18845-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230118072656.18845-1-marcel@ziswiler.com>
References: <20230118072656.18845-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:BmX5IQtw9Cvs/zQcEaxYF//0vcAMqIX7xQcD6kZ7heXWI19Sw+A
 fmL64UlX+AU5unm1iffpM/YUazDqQJ/RubfXmSgUfODW43uX6pgcavw11/nTfVcRTs9bKrC
 NnwTVswt+PRdnYKHzJZ8FGcWEqK4D3tVAUzfS5uQRS01oNXBmtom6nXNlQaUJHjwLG0QDBk
 RCqkXx40xUle5SPBBtBrg==
UI-OutboundReport: notjunk:1;M01:P0:HIp150CjYdM=;tbMeHCysnKjaN/MWACEaN0OVmMT
 A6plwstfLpRIbgpOoougiS6zofltvCOB1h0Hqsac1jDfJhKAbu3zjdLrB2JNVNWXe5fjgtIIn
 +0C9/0bOWOAreTg1rMYmOo6JCQTZ98G3wUAC+kTEDRnr+Ru7yDyA1FajV5GJmoQHfQL+zAzVW
 IcXnOwd3/9QyrUj28gDF7Ac5P2dI+nG2E93GKajk+kHvQ2BiwtliOb3axW5Lz9rOXpTQD26mY
 xUkP14dRwc0ist+KyNnY+jiNHUPkRMWBvdvuOPNx238KkpGp5LcBY//gnFFCf2GYd/bkAf+hA
 QF23eTot20WL5JRWwlU+RVXSpjWc9lU/X+AlMcbuxvgTVelp/i+YVeu/cHhyZYuT8hrzAwZJa
 MOSyW/23UrLKE1GaWtYPJmW02EL8/Ynl/GenHCY6lIjwkum56fyuqdxGuC4Zgc4uS7ytQ6EK7
 V0P7d9RxzMwtzLggrbXhp9Dor71e5GPauTiF95/ZyFN8vvKbNlO+tVIRQxRGTW7B5tQtx16TD
 EZ5KoIbPO1mnifRIwJwtjuDYYYXoKVbfSRxRWuCLCarV4oUaBOgIafbWbmxPUu0QYq2vaYVsS
 gPSVTWrm3DTagh48LFg+MLIgeUjgvE4RgPgxIOzwFcDl5VKfPdQKcRLyAcC6MBDOp+uOAhUwj
 +30yeSrJAszbU+8EsPbGt67PuPxdh0hi9amgs7F+GQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joakim Zhang <qiangqing.zhang@nxp.com>

Add CAN node for imx8qm in devicetree.

Unlike on the i.MX 8QXP where the flexcan clocks are shared between
multiple CAN instances, the i.MX 8QM has separate flexcan clock slices.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

---

Changes in v4:
- New patch inspired by the following downstream patch:
  commit 117607e6a7b5 ("arm64: dts: imx8qm: add CAN node in devicetree")

 .../boot/dts/freescale/imx8qm-ss-dma.dtsi     | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
index bbe5f5ecfb92..e9b198c13b2f 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-dma.dtsi
@@ -16,6 +16,50 @@ uart4_lpcg: clock-controller@5a4a0000 {
 				     "uart4_lpcg_ipg_clk";
 		power-domains = <&pd IMX_SC_R_UART_4>;
 	};
+
+	can1_lpcg: clock-controller@5ace0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5ace0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_CAN_1 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>, <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "can1_lpcg_pe_clk",
+				     "can1_lpcg_ipg_clk",
+				     "can1_lpcg_chi_clk";
+		power-domains = <&pd IMX_SC_R_CAN_1>;
+	};
+
+	can2_lpcg: clock-controller@5acf0000 {
+		compatible = "fsl,imx8qxp-lpcg";
+		reg = <0x5acf0000 0x10000>;
+		#clock-cells = <1>;
+		clocks = <&clk IMX_SC_R_CAN_2 IMX_SC_PM_CLK_PER>,
+			 <&dma_ipg_clk>, <&dma_ipg_clk>;
+		clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>, <IMX_LPCG_CLK_5>;
+		clock-output-names = "can2_lpcg_pe_clk",
+				     "can2_lpcg_ipg_clk",
+				     "can2_lpcg_chi_clk";
+		power-domains = <&pd IMX_SC_R_CAN_2>;
+	};
+};
+
+&flexcan1 {
+	fsl,clk-source = /bits/ 8 <1>;
+};
+
+&flexcan2 {
+	clocks = <&can1_lpcg 1>,
+		 <&can1_lpcg 0>;
+	assigned-clocks = <&clk IMX_SC_R_CAN_1 IMX_SC_PM_CLK_PER>;
+	fsl,clk-source = /bits/ 8 <1>;
+};
+
+&flexcan3 {
+	clocks = <&can2_lpcg 1>,
+		 <&can2_lpcg 0>;
+	assigned-clocks = <&clk IMX_SC_R_CAN_2 IMX_SC_PM_CLK_PER>;
+	fsl,clk-source = /bits/ 8 <1>;
 };
 
 &lpuart0 {
-- 
2.35.1

