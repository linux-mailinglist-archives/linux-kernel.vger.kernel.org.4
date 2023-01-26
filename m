Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A247A67C977
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbjAZLJ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237097AbjAZLJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:44 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811306DB38;
        Thu, 26 Jan 2023 03:09:29 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0Mgd8b-1ozjXs27gV-00O2eX;
 Thu, 26 Jan 2023 12:09:12 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v5 06/10] arm64: dts: imx8qm: add can node in devicetree
Date:   Thu, 26 Jan 2023 12:08:29 +0100
Message-Id: <20230126110833.264439-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/R5v948UBvLjE3YqWG5zlKLdocWEsvQ74cCBMPwQKZsmV358jND
 xyln0QwZph9WBneQqSYKBFtNO0NUkmKY3H2vmyqZac5mRGPg3Lrfrq5y5dse6uF4z5tlhxn
 yrceYhcGL09Ml8prETnOnSXLqpQeieRsSL+u7UREP7iTewfCvdjw0ymJ813/V9DRa1IKft5
 +eV1KLM/VfXNYixX6h0ow==
UI-OutboundReport: notjunk:1;M01:P0:S+CkQfZUBFk=;NqlqlqONLmRGnkSwE/aCD+nzxNV
 LFGr/JwoOHya+UW9fAo6obbBO83ooPX8tuEyrknMUyy6a0Bo1AdJDrPi+bMr3fjsKOO84uWki
 ZG5nj1gL+SOJrXLKUxvW4V2nOOGtlLOPj/bPwb5TA0Ea53BtGQ5TJT+4uLU4Elazac6TPlpMI
 bpU1N9nXimdY8kdV9ONYMDB+zAbNHVoW2fujtaz3DXd7IgTJj+dyehu3H4+v5sQo3m+Cvhm0T
 2SiHUNrZGvvMD+cRpD5KCUnnjYHAvn4sWFGESDivGFWvBLToaDQ+wicrhOULB6QEpE5hrHeig
 siwqG+UB2J32GSUklHPWQuzcv1A6+mkn58oHCS788EvbCgje09/c3e07G8w+AlJIPGzL7jOQK
 n8/cAbxrfZ/VwKaUaPTy2Rb9cxTyWaaeQ5i6zBkxy910fcCdSJZXTzlqw+beMg3bHRgHIslP9
 vxui8AGdp8UNwW3+U7m7vknsxR4UaL22W/h0YC4pkQuLM7Dau7v0GvhzFuuymWNEYrPBvUyg+
 vVTDpV2R6F8aD5BO/F2TXDDkgpFkDUbKsV+HDWi5/2E2ffD1vk4vqs1pwBsKWFPePFO+JoKsA
 v7gblBfrghkhXTtleNEqorkYbX87gUNVl+EDlJcu//5KUkd5mqssI1eibscsdamLAtf9m8mMI
 gmXyyQBTy+u412pboHBK/EDOYGm0Jsq1aZrecNe+DC7g4pn68XzyiK4QLjtu6ag=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Changes in v5:
- Update subject prefix as pointed out by Krzysztof. Thanks!

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
2.36.1

