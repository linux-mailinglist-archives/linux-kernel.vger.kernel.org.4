Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BFB68CCA0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBGCfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:35:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjBGCfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:35:22 -0500
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 68B1D2BF2B;
        Mon,  6 Feb 2023 18:35:20 -0800 (PST)
Received: from unknown (HELO iyokan2-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Feb 2023 11:35:20 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan2-ex.css.socionext.com (Postfix) with ESMTP id 2FB502058B4F;
        Tue,  7 Feb 2023 11:35:20 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Tue, 7 Feb 2023 11:35:30 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id C03FEA8556;
        Tue,  7 Feb 2023 11:35:19 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/8] ARM: dts: uniphier: Align node names for SoC-dependent controller and PHYs with bindings
Date:   Tue,  7 Feb 2023 11:35:07 +0900
Message-Id: <20230207023514.29783-2-hayashi.kunihiko@socionext.com>
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
 arch/arm/boot/dts/uniphier-ld4.dtsi  | 22 +++++++--------
 arch/arm/boot/dts/uniphier-pro4.dtsi | 36 ++++++++++++------------
 arch/arm/boot/dts/uniphier-pro5.dtsi | 36 ++++++++++++------------
 arch/arm/boot/dts/uniphier-pxs2.dtsi | 42 ++++++++++++++--------------
 arch/arm/boot/dts/uniphier-sld8.dtsi | 22 +++++++--------
 5 files changed, 79 insertions(+), 79 deletions(-)

diff --git a/arch/arm/boot/dts/uniphier-ld4.dtsi b/arch/arm/boot/dts/uniphier-ld4.dtsi
index 9dceff12a633..06b9571345a2 100644
--- a/arch/arm/boot/dts/uniphier-ld4.dtsi
+++ b/arch/arm/boot/dts/uniphier-ld4.dtsi
@@ -207,33 +207,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-ld4-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
 
-			mio_clk: clock {
+			mio_clk: clock-controller {
 				compatible = "socionext,uniphier-ld4-mio-clock";
 				#clock-cells = <1>;
 			};
 
-			mio_rst: reset {
+			mio_rst: reset-controller {
 				compatible = "socionext,uniphier-ld4-mio-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-ld4-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-ld4-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-ld4-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -334,7 +334,7 @@ usb2: usb@5a820100 {
 			has-transaction-translator;
 		};
 
-		soc-glue@5f800000 {
+		syscon@5f800000 {
 			compatible = "socionext,uniphier-ld4-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -344,7 +344,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-ld4-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -393,17 +393,17 @@ aidet: interrupt-controller@61830000 {
 			#interrupt-cells = <2>;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-ld4-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-ld4-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-ld4-reset";
 				#reset-cells = <1>;
 			};
diff --git a/arch/arm/boot/dts/uniphier-pro4.dtsi b/arch/arm/boot/dts/uniphier-pro4.dtsi
index a309e64c57c8..064f98b61525 100644
--- a/arch/arm/boot/dts/uniphier-pro4.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro4.dtsi
@@ -241,33 +241,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-pro4-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
 
-			mio_clk: clock {
+			mio_clk: clock-controller {
 				compatible = "socionext,uniphier-pro4-mio-clock";
 				#clock-cells = <1>;
 			};
 
-			mio_rst: reset {
+			mio_rst: reset-controller {
 				compatible = "socionext,uniphier-pro4-mio-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-pro4-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-pro4-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-pro4-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -375,7 +375,7 @@ usb3: usb@5a810100 {
 			has-transaction-translator;
 		};
 
-		soc_glue: soc-glue@5f800000 {
+		soc_glue: syscon@5f800000 {
 			compatible = "socionext,uniphier-pro4-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -384,7 +384,7 @@ pinctrl: pinctrl {
 				compatible = "socionext,uniphier-pro4-pinctrl";
 			};
 
-			usb-controller {
+			usb-hub {
 				compatible = "socionext,uniphier-pro4-usb2-phy";
 				#address-cells = <1>;
 				#size-cells = <0>;
@@ -412,13 +412,13 @@ usb_phy3: phy@3 {
 				};
 			};
 
-			sg_clk: clock {
+			sg_clk: clock-controller {
 				compatible = "socionext,uniphier-pro4-sg-clock";
 				#clock-cells = <1>;
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-pro4-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -480,17 +480,17 @@ intc: interrupt-controller@60001000 {
 			interrupt-controller;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-pro4-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-pro4-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-pro4-reset";
 				#reset-cells = <1>;
 			};
@@ -549,7 +549,7 @@ ahci0_rst: reset-controller@0 {
 				#reset-cells = <1>;
 			};
 
-			ahci0_phy: sata-phy@10 {
+			ahci0_phy: phy@10 {
 				compatible = "socionext,uniphier-pro4-ahci-phy";
 				reg = <0x10 0x40>;
 				clock-names = "link", "gio";
@@ -595,7 +595,7 @@ ahci1_rst: reset-controller@0 {
 				#reset-cells = <1>;
 			};
 
-			ahci1_phy: sata-phy@10 {
+			ahci1_phy: phy@10 {
 				compatible = "socionext,uniphier-pro4-ahci-phy";
 				reg = <0x10 0x40>;
 				clock-names = "link", "gio";
@@ -642,7 +642,7 @@ usb0_vbus: regulator@0 {
 				resets = <&sys_rst 12>, <&sys_rst 14>;
 			};
 
-			usb0_ssphy: ss-phy@10 {
+			usb0_ssphy: phy@10 {
 				compatible = "socionext,uniphier-pro4-usb3-ssphy";
 				reg = <0x10 0x10>;
 				#phy-cells = <0>;
@@ -653,7 +653,7 @@ usb0_ssphy: ss-phy@10 {
 				vbus-supply = <&usb0_vbus>;
 			};
 
-			usb0_rst: reset@40 {
+			usb0_rst: reset-controller@40 {
 				compatible = "socionext,uniphier-pro4-usb3-reset";
 				reg = <0x40 0x4>;
 				#reset-cells = <1>;
@@ -696,7 +696,7 @@ usb1_vbus: regulator@0 {
 				resets = <&sys_rst 12>, <&sys_rst 15>;
 			};
 
-			usb1_rst: reset@40 {
+			usb1_rst: reset-controller@40 {
 				compatible = "socionext,uniphier-pro4-usb3-reset";
 				reg = <0x40 0x4>;
 				#reset-cells = <1>;
diff --git a/arch/arm/boot/dts/uniphier-pro5.dtsi b/arch/arm/boot/dts/uniphier-pro5.dtsi
index 100edd7438d8..2af4fa19bf14 100644
--- a/arch/arm/boot/dts/uniphier-pro5.dtsi
+++ b/arch/arm/boot/dts/uniphier-pro5.dtsi
@@ -341,39 +341,39 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-pro5-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
 
-			sd_clk: clock {
+			sd_clk: clock-controller {
 				compatible = "socionext,uniphier-pro5-sd-clock";
 				#clock-cells = <1>;
 			};
 
-			sd_rst: reset {
+			sd_rst: reset-controller {
 				compatible = "socionext,uniphier-pro5-sd-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-pro5-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-pro5-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-pro5-peri-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		soc-glue@5f800000 {
+		syscon@5f800000 {
 			compatible = "socionext,uniphier-pro5-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -383,7 +383,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-pro5-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -455,17 +455,17 @@ intc: interrupt-controller@60001000 {
 			interrupt-controller;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-pro5-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-pro5-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-pro5-reset";
 				#reset-cells = <1>;
 			};
@@ -493,7 +493,7 @@ usb-controller@65b00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
 
-			usb0_rst: reset@0 {
+			usb0_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pro5-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -512,7 +512,7 @@ usb0_vbus0: regulator@100 {
 				resets = <&sys_rst 12>, <&sys_rst 14>;
 			};
 
-			usb0_hsphy0: hs-phy@280 {
+			usb0_hsphy0: phy@280 {
 				compatible = "socionext,uniphier-pro5-usb3-hsphy";
 				reg = <0x280 0x10>;
 				#phy-cells = <0>;
@@ -523,7 +523,7 @@ usb0_hsphy0: hs-phy@280 {
 				vbus-supply = <&usb0_vbus0>;
 			};
 
-			usb0_ssphy0: ss-phy@380 {
+			usb0_ssphy0: phy@380 {
 				compatible = "socionext,uniphier-pro5-usb3-ssphy";
 				reg = <0x380 0x10>;
 				#phy-cells = <0>;
@@ -557,7 +557,7 @@ usb-controller@65d00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
 
-			usb1_rst: reset@0 {
+			usb1_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pro5-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -585,7 +585,7 @@ usb1_vbus1: regulator@110 {
 				resets = <&sys_rst 12>, <&sys_rst 15>;
 			};
 
-			usb1_hsphy0: hs-phy@280 {
+			usb1_hsphy0: phy@280 {
 				compatible = "socionext,uniphier-pro5-usb3-hsphy";
 				reg = <0x280 0x10>;
 				#phy-cells = <0>;
@@ -596,7 +596,7 @@ usb1_hsphy0: hs-phy@280 {
 				vbus-supply = <&usb1_vbus0>;
 			};
 
-			usb1_hsphy1: hs-phy@290 {
+			usb1_hsphy1: phy@290 {
 				compatible = "socionext,uniphier-pro5-usb3-hsphy";
 				reg = <0x290 0x10>;
 				#phy-cells = <0>;
@@ -607,7 +607,7 @@ usb1_hsphy1: hs-phy@290 {
 				vbus-supply = <&usb1_vbus1>;
 			};
 
-			usb1_ssphy0: ss-phy@380 {
+			usb1_ssphy0: phy@380 {
 				compatible = "socionext,uniphier-pro5-usb3-ssphy";
 				reg = <0x380 0x10>;
 				#phy-cells = <0>;
diff --git a/arch/arm/boot/dts/uniphier-pxs2.dtsi b/arch/arm/boot/dts/uniphier-pxs2.dtsi
index ca4dccf56a67..050e9b7c83f1 100644
--- a/arch/arm/boot/dts/uniphier-pxs2.dtsi
+++ b/arch/arm/boot/dts/uniphier-pxs2.dtsi
@@ -422,33 +422,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		sdctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-pxs2-sdctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x400>;
 
-			sd_clk: clock {
+			sd_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs2-sd-clock";
 				#clock-cells = <1>;
 			};
 
-			sd_rst: reset {
+			sd_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs2-sd-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-pxs2-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs2-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs2-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -488,7 +488,7 @@ sd: mmc@5a400000 {
 			sd-uhs-sdr50;
 		};
 
-		soc_glue: soc-glue@5f800000 {
+		soc_glue: syscon@5f800000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -498,7 +498,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-pxs2-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -555,17 +555,17 @@ intc: interrupt-controller@60001000 {
 			interrupt-controller;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-pxs2-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-pxs2-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-pxs2-reset";
 				#reset-cells = <1>;
 			};
@@ -628,7 +628,7 @@ ahci_rst: reset-controller@0 {
 				#reset-cells = <1>;
 			};
 
-			ahci_phy: sata-phy@10 {
+			ahci_phy: phy@10 {
 				compatible = "socionext,uniphier-pxs2-ahci-phy";
 				reg = <0x10 0x10>;
 				clock-names = "link";
@@ -662,7 +662,7 @@ usb-controller@65b00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65b00000 0x400>;
 
-			usb0_rst: reset@0 {
+			usb0_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pxs2-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -690,7 +690,7 @@ usb0_vbus1: regulator@110 {
 				resets = <&sys_rst 14>;
 			};
 
-			usb0_hsphy0: hs-phy@200 {
+			usb0_hsphy0: phy@200 {
 				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
 				reg = <0x200 0x10>;
 				#phy-cells = <0>;
@@ -701,7 +701,7 @@ usb0_hsphy0: hs-phy@200 {
 				vbus-supply = <&usb0_vbus0>;
 			};
 
-			usb0_hsphy1: hs-phy@210 {
+			usb0_hsphy1: phy@210 {
 				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
 				reg = <0x210 0x10>;
 				#phy-cells = <0>;
@@ -712,7 +712,7 @@ usb0_hsphy1: hs-phy@210 {
 				vbus-supply = <&usb0_vbus1>;
 			};
 
-			usb0_ssphy0: ss-phy@300 {
+			usb0_ssphy0: phy@300 {
 				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
 				reg = <0x300 0x10>;
 				#phy-cells = <0>;
@@ -723,7 +723,7 @@ usb0_ssphy0: ss-phy@300 {
 				vbus-supply = <&usb0_vbus0>;
 			};
 
-			usb0_ssphy1: ss-phy@310 {
+			usb0_ssphy1: phy@310 {
 				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
 				reg = <0x310 0x10>;
 				#phy-cells = <0>;
@@ -757,7 +757,7 @@ usb-controller@65d00000 {
 			#size-cells = <1>;
 			ranges = <0 0x65d00000 0x400>;
 
-			usb1_rst: reset@0 {
+			usb1_rst: reset-controller@0 {
 				compatible = "socionext,uniphier-pxs2-usb3-reset";
 				reg = <0x0 0x4>;
 				#reset-cells = <1>;
@@ -785,7 +785,7 @@ usb1_vbus1: regulator@110 {
 				resets = <&sys_rst 15>;
 			};
 
-			usb1_hsphy0: hs-phy@200 {
+			usb1_hsphy0: phy@200 {
 				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
 				reg = <0x200 0x10>;
 				#phy-cells = <0>;
@@ -796,7 +796,7 @@ usb1_hsphy0: hs-phy@200 {
 				vbus-supply = <&usb1_vbus0>;
 			};
 
-			usb1_hsphy1: hs-phy@210 {
+			usb1_hsphy1: phy@210 {
 				compatible = "socionext,uniphier-pxs2-usb3-hsphy";
 				reg = <0x210 0x10>;
 				#phy-cells = <0>;
@@ -807,7 +807,7 @@ usb1_hsphy1: hs-phy@210 {
 				vbus-supply = <&usb1_vbus1>;
 			};
 
-			usb1_ssphy0: ss-phy@300 {
+			usb1_ssphy0: phy@300 {
 				compatible = "socionext,uniphier-pxs2-usb3-ssphy";
 				reg = <0x300 0x10>;
 				#phy-cells = <0>;
diff --git a/arch/arm/boot/dts/uniphier-sld8.dtsi b/arch/arm/boot/dts/uniphier-sld8.dtsi
index 67b12dfe513b..b4453f9fe981 100644
--- a/arch/arm/boot/dts/uniphier-sld8.dtsi
+++ b/arch/arm/boot/dts/uniphier-sld8.dtsi
@@ -211,33 +211,33 @@ smpctrl@59801000 {
 			reg = <0x59801000 0x400>;
 		};
 
-		mioctrl@59810000 {
+		syscon@59810000 {
 			compatible = "socionext,uniphier-sld8-mioctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59810000 0x800>;
 
-			mio_clk: clock {
+			mio_clk: clock-controller {
 				compatible = "socionext,uniphier-sld8-mio-clock";
 				#clock-cells = <1>;
 			};
 
-			mio_rst: reset {
+			mio_rst: reset-controller {
 				compatible = "socionext,uniphier-sld8-mio-reset";
 				#reset-cells = <1>;
 			};
 		};
 
-		perictrl@59820000 {
+		syscon@59820000 {
 			compatible = "socionext,uniphier-sld8-perictrl",
 				     "simple-mfd", "syscon";
 			reg = <0x59820000 0x200>;
 
-			peri_clk: clock {
+			peri_clk: clock-controller {
 				compatible = "socionext,uniphier-sld8-peri-clock";
 				#clock-cells = <1>;
 			};
 
-			peri_rst: reset {
+			peri_rst: reset-controller {
 				compatible = "socionext,uniphier-sld8-peri-reset";
 				#reset-cells = <1>;
 			};
@@ -338,7 +338,7 @@ usb2: usb@5a820100 {
 			has-transaction-translator;
 		};
 
-		soc-glue@5f800000 {
+		syscon@5f800000 {
 			compatible = "socionext,uniphier-sld8-soc-glue",
 				     "simple-mfd", "syscon";
 			reg = <0x5f800000 0x2000>;
@@ -348,7 +348,7 @@ pinctrl: pinctrl {
 			};
 		};
 
-		soc-glue@5f900000 {
+		syscon@5f900000 {
 			compatible = "socionext,uniphier-sld8-soc-glue-debug",
 				     "simple-mfd";
 			#address-cells = <1>;
@@ -397,17 +397,17 @@ aidet: interrupt-controller@61830000 {
 			#interrupt-cells = <2>;
 		};
 
-		sysctrl@61840000 {
+		syscon@61840000 {
 			compatible = "socionext,uniphier-sld8-sysctrl",
 				     "simple-mfd", "syscon";
 			reg = <0x61840000 0x10000>;
 
-			sys_clk: clock {
+			sys_clk: clock-controller {
 				compatible = "socionext,uniphier-sld8-clock";
 				#clock-cells = <1>;
 			};
 
-			sys_rst: reset {
+			sys_rst: reset-controller {
 				compatible = "socionext,uniphier-sld8-reset";
 				#reset-cells = <1>;
 			};
-- 
2.25.1

