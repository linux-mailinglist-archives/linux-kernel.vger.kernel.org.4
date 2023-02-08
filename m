Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7770568E89B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 07:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230491AbjBHG6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 01:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjBHG5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 01:57:51 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE31B43478;
        Tue,  7 Feb 2023 22:57:30 -0800 (PST)
Received: from toolbox.int.toradex.com ([213.55.227.109]) by
 mrelay.perfora.net (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id
 0MEXsd-1pNEcn4BTd-00Ffwu; Wed, 08 Feb 2023 07:57:17 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Subject: [PATCH v7 06/10] arm64: dts: imx8qm: add can node in devicetree
Date:   Wed,  8 Feb 2023 07:56:37 +0100
Message-Id: <20230208065641.23544-7-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:xHL40s+pKmz3N6B3E2W9qdvg/v0R7m/3H+ntD2+MZ3mS7/c8K2N
 jYKbFByFmjAPlhJjyyK3FsiNqgZfUNZcDI1k1lfF61jNxX8ZTeF3pjTbpE6GToMapRPPpAk
 hFeacNQJhQBf88GIakxZk6MeWLJkL0znLxAQQG4NDmQcD5KJVp6K81q+XfQ80LQrycSYI0I
 x9cIP9PKRB2EadKIOe8eA==
UI-OutboundReport: notjunk:1;M01:P0:V857Eo3TwnI=;aLAZyCtGMsW392yh7HRdIDLe2FJ
 eJt35NZvhiwahgVhIE5dQABhjOeakw5q5XCl30pp4lb21B96edxeKpkBLsZtlyjeebnxBLIda
 TcjTBaLQ8j4QRrkP6YeQXXu1G0KHg0Eh3wdmaH/5evyeoFOXmCCs9jALfD8Tnzt9wWLgiiTzh
 o4Fvyjs9gZY6i3eWYhYyU6JgHTMrMte7oYgrXMDIDgZkR+01zoz7WsONQvbaTlnYvCe7rZBWv
 p8pPYRNe1Vu69we1dFGzSvhO+P0QOgaEW3pA/vRpesD/df3bHz8WlplOx+/PyvP5fRCu3ueED
 UFAUPA3o/tZpjgOuPcWfOF4RU1/JPzHkBXdWezpPo0v+2pm6SCLbkSpROpeEA9msmrWyHN0i7
 eaC0EgX/LTEQio2St2VUYH1MDxWbjemvLgoF+DuA70tKRALOlgU7SCK8Gc53Li1gYRdBccLni
 zgtrmHKrRIp6gRpCbSuvmN5AJa8zpmi2DkZZLUzbsENz7tHPROTneQbAV1cacNiOp4EjlWu7f
 nnWFxB2M+MZI8JLMZNqmV7NMd+S+AM9EmflhueHZr7xjPDci9LUvVIqnp417uPAF1Sozov3QS
 baX1+F4CAmNCgepzaOQ4MPQoPyFxHkb2frLWxC0IFcfcFGCXrG27USBFZ9iOdsonwT/rgeQUF
 QeXHrVzKvvHMXDSDWVZyiE5xLALKhcp+IgGRYzK8TA==
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

