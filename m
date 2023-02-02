Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9595B6882B0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233119AbjBBPfs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233405AbjBBPfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:35:08 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D570229155;
        Thu,  2 Feb 2023 07:34:33 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.225.17]) by mrelay.perfora.net
 (mreueus003 [74.208.5.2]) with ESMTPSA (Nemesis) id 0MH1qm-1pRTBi1KnC-00DkYX;
 Thu, 02 Feb 2023 16:33:04 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v6 06/10] arm64: dts: imx8qm: add can node in devicetree
Date:   Thu,  2 Feb 2023 16:32:16 +0100
Message-Id: <20230202153221.197308-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230202153221.197308-1-marcel@ziswiler.com>
References: <20230202153221.197308-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:TkZok3rwD78eDqxIodt4d4gtChvbiHJyp6+6V/Qm3cRV2GhBeVu
 04AuE1exiWTbQK0MnV2qb1YJfS5sxeTA6PaZCthTU4DhZRbgZF7bo3hdizOOBWTS2uCp5eJ
 QVbAaHthi/HWimF0ykGGIHDFsIe6C4rMUw+/qsjGaZRPaBS4Rn5uXqbJoBXDf0naOz9a++n
 dnowTL+7a6xM5QHpBLXyw==
UI-OutboundReport: notjunk:1;M01:P0:r8+85rFsXa8=;m1tOP5V5Yq74etH7BKgCPex/WaE
 y9L+0+CIbhDlgEuT0rKCyPBLmbgYTCmgkvpz3Duia3oNQYuTKDGPDLOmmftUxvxgHqcFntjfM
 v1mO9/vtiMIPD2P5cDMYVVTuABg6Hp3So1sNpHTnhuzWGnlLZX0IvLltZyqwYalAardCIeYxK
 9sEZiKsVVOaxSSDMbk8YTgAqOu8PAU4k80n7ReJAqb9UV8CaGfO0PiekrhnswtE42BN+E5IX5
 V0M9vlT7jVNGI0aI0CyUieOrZJ2sSdfjOBsAu0w+FupwMjM8EW6qjeI3kEdZtDLWjm+7QamPt
 CtbpI1EenZ1JnnK2kLaGJGzX46rALuaw5rBOI/EtqIbdHQxjgbeXyA7vh9qqkfq9N0ak0JKRw
 eX0oVnCYuKI4OnXLpRTcG9IgZhLVqSJ9YNUsx1gnjq8bcbXvVXXwlJ5hfA21HlJIOxXo/lHbL
 +Fv2QJR/JlqXPy8zpMlvCm+HCzSPerHvkw3Sx1T2g2bYacU988SfJWtJ5Wj1rin7A9uYMyNgb
 N2MWnkT51vyKK19TgFEC3+7wDkvW/SzoPzJe/t31TU1MbTnpeJ1vid6ogX9Ry0g0P0cxFFZOG
 A54Bm7ukW1EK5PlVP1srGKRjfA2skfRiz9nJN3wKwTmJ+6FKRPiMok80UArUnFQrRKPTLH+pS
 UBUSqxj69dOzNhCTB7emtSn+STtHjIhHEJKjgv7wQw==
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

(no changes since v5)

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

