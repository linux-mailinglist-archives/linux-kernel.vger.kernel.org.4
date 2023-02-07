Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA21168CCA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbjBGCfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBGCf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:27 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4500034C1B;
        Mon,  6 Feb 2023 18:35:23 -0800 (PST)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:21 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 31FC12020780;
        Tue,  7 Feb 2023 11:35:21 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:31 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 87232A8556;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 5/8] arm64: dts: uniphier: Align node names for SoC-dependent controller and PHYs with bindings
Date:   Tue,  7 Feb 2023 11:35:11 +0900
Message-Id: <20230207023514.29783-6-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
References: <20230207023514.29783-1-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The node names for SoC-dependent controllers and PHYs should be
generic ones according to the DT schemas.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 .../boot/dts/socionext/uniphier-ld11.dtsi     | 32 +++++++--------
 .../boot/dts/socionext/uniphier-ld20.dtsi     | 40 +++++++++----------
 .../boot/dts/socionext/uniphier-pxs3.dtsi     | 40 +++++++++----------
 3 files changed, 56 insertions(+), 56 deletions(-)

diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
index 1c76b4375b2e..148d9092572a 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld11.dtsi
@@ -313,12 +313,12 @@ evea_hp: endpoint {
 			};
 		};
 
-		adamv@57920000 {
+		syscon@57920000 {
 			compatible = "socionext,uniphier-ld11-adamv",
 				     "simple-mfd", "syscon";
 			reg = <0x57920000 0x1000>;
 
-			adamv_rst: reset {
+			adamv_rst: reset-controller {
 				compatible = "socionext,uniphier-ld11-adamv-reset";
 				#reset-cells = <1>;
 			};
@@ -417,28 +417,28 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-ld11-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
 
-			sd_rst: reset {
+			sd_rst: reset-controller {
 				compatible = "socionext,uniphier-ld11-sd-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-ld11-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-ld11-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-ld11-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -511,24 +511,24 @@ usb2: usb@5a820100 {
 			has-transaction-translator;
 		};
 
-		mioctrl@5b3e0000 {
+		syscon@5b3e0000 {
 			compatible = "socionext,uniphier-ld11-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x5b3e0000 0x800>;
 
-			mio_clk: clock {
+			mio_clk: clock-controller {
 				compatible = "socionext,uniphier-ld11-mio-clock";
 				#clock-cells = <1>;
 			};
 
-			mio_rst: reset {
+			mio_rst: reset-controller {
 				compatible = "socionext,uniphier-ld11-mio-reset";
 				#reset-cells = <1>;
 				resets = <&sys_rst 7>;
 			};
 		};
 
-		soc_glue: soc-glue@5f800000 {
+		soc_glue: syscon@5f800000 {
 			compatible = "socionext,uniphier-ld11-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -537,7 +537,7 @@ pinctrl: pinctrl {
 				compatible = "socionext,uniphier-ld11-pinctrl";
 			};
 
-			usb-controller {
+			usb-hub {
 				compatible = "socionext,uniphier-ld11-usb2-phy";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -559,7 +559,7 @@ usb_phy2: phy@2 {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld11-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -601,17 +601,17 @@ gic: interrupt-controller@5fe00000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-ld11-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-ld11-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-ld11-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
index 9308458f9611..c83265c9b520 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-ld20.dtsi
@@ -444,12 +444,12 @@ evea_hp: endpoint {
 			};
 		};
 
-		adamv@57920000 {
+		syscon@57920000 {
 			compatible = "socionext,uniphier-ld20-adamv",
 				     "simple-mfd", "syscon";
 			reg = <0x57920000 0x1000>;
 
-			adamv_rst: reset {
+			adamv_rst: reset-controller {
 				compatible = "socionext,uniphier-ld20-adamv-reset";
 				#reset-cells = <1>;
 			};
@@ -548,33 +548,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-ld20-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
 
-			sd_clk: clock {
+			sd_clk: clock-controller {
 				compatible = "socionext,uniphier-ld20-sd-clock";
 				#clock-cells = <1>;
 			};
 
-			sd_rst: reset {
+			sd_rst: reset-controller {
 				compatible = "socionext,uniphier-ld20-sd-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-ld20-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-ld20-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-ld20-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -613,7 +613,7 @@ sd: mmc@5a400000 {
 			cap-sd-highspeed;
 		};
 
-		soc_glue: soc-glue@5f800000 {
+		soc_glue: syscon@5f800000 {
 			compatible = "socionext,uniphier-ld20-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -623,7 +623,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld20-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -709,17 +709,17 @@ gic: interrupt-controller@5fe00000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-ld20-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-ld20-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-ld20-reset";
 				#reset-cells = <1>;
 			};
@@ -782,7 +782,7 @@ usb-controller@65b00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
 
-			usb_rst: reset@0 {
+			usb_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-ld20-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -828,7 +828,7 @@ usb_vbus3: regulator@130 {
 				resets = <&sys_rst 14>;
 			};
 
-			usb_hsphy0: hs-phy@200 {
+			usb_hsphy0: phy@200 {
 				compatible = "socionext,uniphier-ld20-usb3-hsphy";
 				reg = <0x200 0x10>;
 				#phy-cells = <0>;
@@ -842,7 +842,7 @@ usb_hsphy0: hs-phy@200 {
 					      <&usb_hs_i0>;
 			};
 
-			usb_hsphy1: hs-phy@210 {
+			usb_hsphy1: phy@210 {
 				compatible = "socionext,uniphier-ld20-usb3-hsphy";
 				reg = <0x210 0x10>;
 				#phy-cells = <0>;
@@ -856,7 +856,7 @@ usb_hsphy1: hs-phy@210 {
 					      <&usb_hs_i0>;
 			};
 
-			usb_hsphy2: hs-phy@220 {
+			usb_hsphy2: phy@220 {
 				compatible = "socionext,uniphier-ld20-usb3-hsphy";
 				reg = <0x220 0x10>;
 				#phy-cells = <0>;
@@ -870,7 +870,7 @@ usb_hsphy2: hs-phy@220 {
 					      <&usb_hs_i2>;
 			};
 
-			usb_hsphy3: hs-phy@230 {
+			usb_hsphy3: phy@230 {
 				compatible = "socionext,uniphier-ld20-usb3-hsphy";
 				reg = <0x230 0x10>;
 				#phy-cells = <0>;
@@ -884,7 +884,7 @@ usb_hsphy3: hs-phy@230 {
 					      <&usb_hs_i2>;
 			};
 
-			usb_ssphy0: ss-phy@300 {
+			usb_ssphy0: phy@300 {
 				compatible = "socionext,uniphier-ld20-usb3-ssphy";
 				reg = <0x300 0x10>;
 				#phy-cells = <0>;
@@ -895,7 +895,7 @@ usb_ssphy0: ss-phy@300 {
 				vbus-supply = <&usb_vbus0>;
 			};
 
-			usb_ssphy1: ss-phy@310 {
+			usb_ssphy1: phy@310 {
 				compatible = "socionext,uniphier-ld20-usb3-ssphy";
 				reg = <0x310 0x10>;
 				#phy-cells = <0>;
diff --git a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
index b0c29510a7da..dd60cc04d6fb 100644
--- a/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
+++ b/arch/arm64/boot/dts/socionext/uniphier-pxs3.dtsi
@@ -370,33 +370,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-pxs3-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
 
-			sd_clk: clock {
+			sd_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs3-sd-clock";
 				#clock-cells = <1>;
 			};
 
-			sd_rst: reset {
+			sd_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs3-sd-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-pxs3-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs3-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs3-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -439,7 +439,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr50;
 		};
 
-		soc_glue: soc-glue@5f800000 {
+		soc_glue: syscon@5f800000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -449,7 +449,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-pxs3-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -535,17 +535,17 @@ gic: interrupt-controller@5fe00000 {
 			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-pxs3-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs3-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs3-reset";
 				#reset-cells = <1>;
 			};
@@ -707,7 +707,7 @@ usb-controller@65b00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
 
-			usb0_rst: reset@0 {
+			usb0_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pxs3-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -735,7 +735,7 @@ usb0_vbus1: regulator@110 {
 				resets = <&sys_rst 12>;
 			};
 
-			usb0_hsphy0: hs-phy@200 {
+			usb0_hsphy0: phy@200 {
 				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
 				reg = <0x200 0x10>;
 				#phy-cells = <0>;
@@ -749,7 +749,7 @@ usb0_hsphy0: hs-phy@200 {
 					      <&usb_hs_i0>;
 			};
 
-			usb0_hsphy1: hs-phy@210 {
+			usb0_hsphy1: phy@210 {
 				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
 				reg = <0x210 0x10>;
 				#phy-cells = <0>;
@@ -763,7 +763,7 @@ usb0_hsphy1: hs-phy@210 {
 					      <&usb_hs_i0>;
 			};
 
-			usb0_ssphy0: ss-phy@300 {
+			usb0_ssphy0: phy@300 {
 				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
 				reg = <0x300 0x10>;
 				#phy-cells = <0>;
@@ -774,7 +774,7 @@ usb0_ssphy0: ss-phy@300 {
 				vbus-supply = <&usb0_vbus0>;
 			};
 
-			usb0_ssphy1: ss-phy@310 {
+			usb0_ssphy1: phy@310 {
 				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
 				reg = <0x310 0x10>;
 				#phy-cells = <0>;
@@ -809,7 +809,7 @@ usb-controller@65d00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
 
-			usb1_rst: reset@0 {
+			usb1_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pxs3-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -837,7 +837,7 @@ usb1_vbus1: regulator@110 {
 				resets = <&sys_rst 13>;
 			};
 
-			usb1_hsphy0: hs-phy@200 {
+			usb1_hsphy0: phy@200 {
 				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
 				reg = <0x200 0x10>;
 				#phy-cells = <0>;
@@ -852,7 +852,7 @@ usb1_hsphy0: hs-phy@200 {
 					      <&usb_hs_i2>;
 			};
 
-			usb1_hsphy1: hs-phy@210 {
+			usb1_hsphy1: phy@210 {
 				compatible = "socionext,uniphier-pxs3-usb3-hsphy";
 				reg = <0x210 0x10>;
 				#phy-cells = <0>;
@@ -867,7 +867,7 @@ usb1_hsphy1: hs-phy@210 {
 					      <&usb_hs_i2>;
 			};
 
-			usb1_ssphy0: ss-phy@300 {
+			usb1_ssphy0: phy@300 {
 				compatible = "socionext,uniphier-pxs3-usb3-ssphy";
 				reg = <0x300 0x10>;
 				#phy-cells = <0>;
-- 
2.25.1

