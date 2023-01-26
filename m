Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEF967C973
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237171AbjAZLJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:09:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237117AbjAZLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:09:25 -0500
Received: from mout.perfora.net (mout.perfora.net [74.208.4.194])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39A0410A0;
        Thu, 26 Jan 2023 03:09:23 -0800 (PST)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus002 [74.208.5.2]) with ESMTPSA (Nemesis) id 0LdHBn-1ov36z12NF-00iR7n;
 Thu, 26 Jan 2023 12:09:08 +0100
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     devicetree@vger.kernel.org
Cc:     linux-imx@nxp.com, Liu Ying <victor.liu@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Subject: [PATCH v5 05/10] arm64: dts: imx8qxp: add flexcan in adma
Date:   Thu, 26 Jan 2023 12:08:28 +0100
Message-Id: <20230126110833.264439-6-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230126110833.264439-1-marcel@ziswiler.com>
References: <20230126110833.264439-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fQWw0GOX+nKPn6Z3NSaSeEwe1U943hr8DyyHXIPa/bsUYvsHEtr
 +pEppte+ECkpMC1zG1kBn3l6Vxt/Pe5brnOBmN965w9xJpJitFWj2KadZJzPaOrhYKGyTJz
 3idB2HSgjvPPXDEWy7uEmcYFvI+Z2Txxyl2ibX4yn40XEve+Lba/uZzZaOtyf5ArQWd3d1P
 eBti9Pq4N6E5Q3zHTlUdQ==
UI-OutboundReport: notjunk:1;M01:P0:ZGgyyNtw80Q=;2HZ8Ryrc35DTl3hfRogXBaLyA6U
 QgZbQZ0V/4oqkrmBXSPTETFDq13goaWXD7mGcaoFPya8YB/WpYvMAqJZesQCnzcLSEvUgc/a2
 VL8YTfaXsPSsEn9a+KkUsV5rAhkvqEw6kuRbzcTsK0dSnfnxdxq4HNunPu6UsNGDfcSnVqVo/
 6HRT7FCDGvltL/7ItWRrQoD+VdXapfyjYzu54bzfbvlYJz5/CmqXNNC2vCFO1qjC+c3m0wg6A
 jHDaLBu+mU4Rpibh1bE13IfVzhsSF8njc8Naqw1ZUrdYdmclz2pchxzwIgWZcXFzxlfdlFEQ3
 KYlAhnCB0UIYBh5+o+kTDYfEDS93+DIbgnF3Xa0QWI+tZiXcWM/YZkR2YtLl9q6iCUhV5VhyQ
 Hwyz50uGneX7jJZYDE/IChZoiTQsakQlz+HJRqZnc0V1NQpTFk6lBFYdES4iD5sppxnLMrcHW
 AT2qmRKxdxf3+MImnBAbZfCtdvuAi9mmXcUqpvpUh5FTPBOLq1Qz5kOifVK/ugGVnWtDKlZIh
 0Ro4W/mqQmIKgG1M3CCLeVaj3TvX9FC3WLvaJrumhS6+dAloSNXd1Y1y2NReu8APprp0x3uPx
 mNwuY71LoYTBHpr+EgZJ1QTyfjBdRfZ2IRHEPKhT1yG/80aVSjvlo/Zutz6RjehyO0hyd8QCr
 M7cvxDEwjvrhxOSlvoFcHh1OKfGYg3C0oWgMpszUow==
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

(no changes since v4)

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

