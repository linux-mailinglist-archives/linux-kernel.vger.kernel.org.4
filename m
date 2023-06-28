Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7337740DBE
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 11:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232517AbjF1JvN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 05:51:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbjF1J1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6406835A3;
        Wed, 28 Jun 2023 02:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AEE561295;
        Wed, 28 Jun 2023 09:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980A1C433C0;
        Wed, 28 Jun 2023 09:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687944382;
        bh=Lx9Xt76G54ZFJhFI2oV8nPgG4Kl+891n1+GwVBPy80c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OYWfk+elVnHHtijl+pN0VcF/evS3puX2gPCrClKiZVtQZfez6SboZVxqzVo4jX6pf
         /m2ZeER7ixsk0QHqTNTUgwnDjD4Fp9yk74XYBYjYorOlCMvi7deKA+POxCOwoOoE6F
         K8Uj5K/lVG4QrNRpso2DGSvYFt3PX1PjosbeFHsU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        torvalds@linux-foundation.org, stable@vger.kernel.org
Cc:     lwn@lwn.net, jslaby@suse.cz,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.3.10
Date:   Wed, 28 Jun 2023 11:26:01 +0200
Message-ID: <2023062801-pope-dial-94f2@gregkh>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2023062800-broiling-robbing-f482@gregkh>
References: <2023062800-broiling-robbing-f482@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

diff --git a/Makefile b/Makefile
index f8ee72375885..47253ac6c85c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 3
-SUBLEVEL = 9
+SUBLEVEL = 10
 EXTRAVERSION =
 NAME = Hurr durr I'ma ninja sloth
 
diff --git a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
index 2fc9a5d5e0c0..625b9b311b49 100644
--- a/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
+++ b/arch/arm/boot/dts/am57xx-cl-som-am57x.dts
@@ -527,7 +527,7 @@ touchscreen@1 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <31 0>;
-		pendown-gpio = <&gpio1 31 0>;
+		pendown-gpio = <&gpio1 31 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm/boot/dts/at91sam9261ek.dts b/arch/arm/boot/dts/at91sam9261ek.dts
index 88869ca874d1..045cb253f23a 100644
--- a/arch/arm/boot/dts/at91sam9261ek.dts
+++ b/arch/arm/boot/dts/at91sam9261ek.dts
@@ -156,7 +156,7 @@ tsc2046@2 {
 					compatible = "ti,ads7843";
 					interrupts-extended = <&pioC 2 IRQ_TYPE_EDGE_BOTH>;
 					spi-max-frequency = <3000000>;
-					pendown-gpio = <&pioC 2 GPIO_ACTIVE_HIGH>;
+					pendown-gpio = <&pioC 2 GPIO_ACTIVE_LOW>;
 
 					ti,x-min = /bits/ 16 <150>;
 					ti,x-max = /bits/ 16 <3830>;
diff --git a/arch/arm/boot/dts/imx7d-pico-hobbit.dts b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
index d917dc4f2f22..6ad39dca7009 100644
--- a/arch/arm/boot/dts/imx7d-pico-hobbit.dts
+++ b/arch/arm/boot/dts/imx7d-pico-hobbit.dts
@@ -64,7 +64,7 @@ ads7846@0 {
 		interrupt-parent = <&gpio2>;
 		interrupts = <7 0>;
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio2 7 0>;
+		pendown-gpio = <&gpio2 7 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_3p3v>;
 		ti,x-min = /bits/ 16 <0>;
 		ti,x-max = /bits/ 16 <4095>;
diff --git a/arch/arm/boot/dts/imx7d-sdb.dts b/arch/arm/boot/dts/imx7d-sdb.dts
index f483bc0afe5e..234e5fc647b2 100644
--- a/arch/arm/boot/dts/imx7d-sdb.dts
+++ b/arch/arm/boot/dts/imx7d-sdb.dts
@@ -205,7 +205,7 @@ tsc2046@0 {
 		pinctrl-0 = <&pinctrl_tsc2046_pendown>;
 		interrupt-parent = <&gpio2>;
 		interrupts = <29 0>;
-		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 29 GPIO_ACTIVE_LOW>;
 		touchscreen-max-pressure = <255>;
 		wakeup-source;
 	};
diff --git a/arch/arm/boot/dts/omap3-cm-t3x.dtsi b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
index e61b8a2bfb7d..51baedf1603b 100644
--- a/arch/arm/boot/dts/omap3-cm-t3x.dtsi
+++ b/arch/arm/boot/dts/omap3-cm-t3x.dtsi
@@ -227,7 +227,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio2>;
 		interrupts = <25 0>;		/* gpio_57 */
-		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio2 25 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
index 3decc2d78a6c..a7f99ae0c1fe 100644
--- a/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
+++ b/arch/arm/boot/dts/omap3-devkit8000-lcd-common.dtsi
@@ -54,7 +54,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <27 0>;		/* gpio_27 */
-		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 27 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
index c595afe4181d..d310b5c7bac3 100644
--- a/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
+++ b/arch/arm/boot/dts/omap3-lilly-a83x.dtsi
@@ -311,7 +311,7 @@ tsc2046@0 {
 		interrupt-parent = <&gpio1>;
 		interrupts = <8 0>;   /* boot6 / gpio_8 */
 		spi-max-frequency = <1000000>;
-		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 8 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&reg_vcc3>;
 		pinctrl-names = "default";
 		pinctrl-0 = <&tsc2048_pins>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
index 1d6e88f99eb3..c3570acc35fa 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd35.dtsi
@@ -149,7 +149,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
index 7e30f9d45790..d95a0e130058 100644
--- a/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
+++ b/arch/arm/boot/dts/omap3-overo-common-lcd43.dtsi
@@ -160,7 +160,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio4>;
 		interrupts = <18 0>;			/* gpio_114 */
-		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio4 18 GPIO_ACTIVE_LOW>;
 
 		ti,x-min = /bits/ 16 <0x0>;
 		ti,x-max = /bits/ 16 <0x0fff>;
diff --git a/arch/arm/boot/dts/omap3-pandora-common.dtsi b/arch/arm/boot/dts/omap3-pandora-common.dtsi
index 559853764487..4c3b6bab179c 100644
--- a/arch/arm/boot/dts/omap3-pandora-common.dtsi
+++ b/arch/arm/boot/dts/omap3-pandora-common.dtsi
@@ -651,7 +651,7 @@ tsc2046@0 {
 		pinctrl-0 = <&penirq_pins>;
 		interrupt-parent = <&gpio3>;
 		interrupts = <30 IRQ_TYPE_NONE>;	/* GPIO_94 */
-		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio3 30 GPIO_ACTIVE_LOW>;
 		vcc-supply = <&vaux4>;
 
 		ti,x-min = /bits/ 16 <0>;
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index 2d87b9fc230e..af288d63a26a 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -354,7 +354,7 @@ ads7846@0 {
 
 		interrupt-parent = <&gpio1>;
 		interrupts = <15 0>;			/* gpio1_wk15 */
-		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_HIGH>;
+		pendown-gpio = <&gpio1 15 GPIO_ACTIVE_LOW>;
 
 
 		ti,x-min = /bits/ 16 <0x0>;
diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
index 8b5293e7fd2a..a0e767ff252c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dtsi
@@ -480,7 +480,6 @@ &swr0 {
 	wcd_rx: codec@0,4 {
 		compatible = "sdw20217010d00";
 		reg = <0 4>;
-		#sound-dai-cells = <1>;
 		qcom,rx-port-mapping = <1 2 3 4 5>;
 	};
 };
@@ -491,7 +490,6 @@ &swr1 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		#sound-dai-cells = <1>;
 		qcom,tx-port-mapping = <1 2 3 4>;
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
index 88204f794ccb..1080d701d45a 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280-qcard.dtsi
@@ -419,7 +419,6 @@ &swr0 {
 	wcd_rx: codec@0,4 {
 		compatible = "sdw20217010d00";
 		reg = <0 4>;
-		#sound-dai-cells = <1>;
 		qcom,rx-port-mapping = <1 2 3 4 5>;
 	};
 };
@@ -428,7 +427,6 @@ &swr1 {
 	wcd_tx: codec@0,3 {
 		compatible = "sdw20217010d00";
 		reg = <0 3>;
-		#sound-dai-cells = <1>;
 		qcom,tx-port-mapping = <1 2 3 4>;
 	};
 };
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
index 263ce40770dd..cddf6cd2fecb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
@@ -28,6 +28,16 @@ vcc_5v: vcc-5v-regulator {
 		regulator-max-microvolt = <5000000>;
 		vin-supply = <&vcc12v_dcin>;
 	};
+
+	vcc_sd_pwr: vcc-sd-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc_sd_pwr";
+		regulator-always-on;
+		regulator-boot-on;
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vcc3v3_sys>;
+	};
 };
 
 /* phy for pcie */
@@ -130,13 +140,7 @@ &saradc {
 };
 
 &sdmmc0 {
-	vmmc-supply = <&sdmmc_pwr>;
-	status = "okay";
-};
-
-&sdmmc_pwr {
-	regulator-min-microvolt = <3300000>;
-	regulator-max-microvolt = <3300000>;
+	vmmc-supply = <&vcc_sd_pwr>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
index 102e448bc026..31aa2b8efe39 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz.dtsi
@@ -104,16 +104,6 @@ vcc3v3_sys: vcc3v3-sys-regulator {
 		regulator-max-microvolt = <3300000>;
 		vin-supply = <&vcc5v0_sys>;
 	};
-
-	sdmmc_pwr: sdmmc-pwr-regulator {
-		compatible = "regulator-fixed";
-		enable-active-high;
-		gpio = <&gpio0 RK_PA5 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
-		pinctrl-0 = <&sdmmc_pwr_h>;
-		regulator-name = "sdmmc_pwr";
-		status = "disabled";
-	};
 };
 
 &cpu0 {
@@ -155,6 +145,19 @@ &gmac1m0_clkinout
 	status = "disabled";
 };
 
+&gpio0 {
+	nextrst-hog {
+		gpio-hog;
+		/*
+		 * GPIO_ACTIVE_LOW + output-low here means that the pin is set
+		 * to high, because output-low decides the value pre-inversion.
+		 */
+		gpios = <RK_PA5 GPIO_ACTIVE_LOW>;
+		line-name = "nEXTRST";
+		output-low;
+	};
+};
+
 &gpu {
 	mali-supply = <&vdd_gpu>;
 	status = "okay";
@@ -538,12 +541,6 @@ wifi_enable_h: wifi-enable-h {
 			rockchip,pins = <2 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
 		};
 	};
-
-	sdmmc-pwr {
-		sdmmc_pwr_h: sdmmc-pwr-h {
-			rockchip,pins = <0 RK_PA5 RK_FUNC_GPIO &pcfg_pull_none>;
-		};
-	};
 };
 
 &pmu_io_domains {
diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index ba67b58f05b7..f1be76a54ceb 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -94,9 +94,10 @@ pcie3x1: pcie@fe270000 {
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0400000 0x0 0x00400000>,
 		      <0x0 0xfe270000 0x0 0x00010000>,
-		      <0x3 0x7f000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x7ef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x40000000 0x0 0x3ef00000>;
+		      <0x0 0xf2000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf2100000 0x0 0xf2100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf2200000 0x0 0xf2200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x40000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X1_POWERUP>;
 		reset-names = "pipe";
@@ -146,9 +147,10 @@ pcie3x2: pcie@fe280000 {
 		power-domains = <&power RK3568_PD_PIPE>;
 		reg = <0x3 0xc0800000 0x0 0x00400000>,
 		      <0x0 0xfe280000 0x0 0x00010000>,
-		      <0x3 0xbf000000 0x0 0x01000000>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0xbef00000 0x0 0x00100000>,
-			 <0x02000000 0x0 0x00000000 0x3 0x80000000 0x0 0x3ef00000>;
+		      <0x0 0xf0000000 0x0 0x00100000>;
+		ranges = <0x01000000 0x0 0xf0100000 0x0 0xf0100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf0200000 0x0 0xf0200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x80000000 0x0 0x40000000>;
 		reg-names = "dbi", "apb", "config";
 		resets = <&cru SRST_PCIE30X2_POWERUP>;
 		reset-names = "pipe";
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index eed0059a68b8..3ee5d764ac63 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -952,7 +952,7 @@ pcie2x1: pcie@fe260000 {
 		compatible = "rockchip,rk3568-pcie";
 		reg = <0x3 0xc0000000 0x0 0x00400000>,
 		      <0x0 0xfe260000 0x0 0x00010000>,
-		      <0x3 0x3f000000 0x0 0x01000000>;
+		      <0x0 0xf4000000 0x0 0x00100000>;
 		reg-names = "dbi", "apb", "config";
 		interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
 			     <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>,
@@ -982,8 +982,9 @@ pcie2x1: pcie@fe260000 {
 		phys = <&combphy2 PHY_TYPE_PCIE>;
 		phy-names = "pcie-phy";
 		power-domains = <&power RK3568_PD_PIPE>;
-		ranges = <0x01000000 0x0 0x3ef00000 0x3 0x3ef00000 0x0 0x00100000
-			  0x02000000 0x0 0x00000000 0x3 0x00000000 0x0 0x3ef00000>;
+		ranges = <0x01000000 0x0 0xf4100000 0x0 0xf4100000 0x0 0x00100000>,
+			 <0x02000000 0x0 0xf4200000 0x0 0xf4200000 0x0 0x01e00000>,
+			 <0x03000000 0x0 0x40000000 0x3 0x00000000 0x0 0x40000000>;
 		resets = <&cru SRST_PCIE20_POWERUP>;
 		reset-names = "pipe";
 		#address-cells = <3>;
diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
index 9e3ecba3c4e6..d4a85c1db2e2 100644
--- a/arch/arm64/include/asm/sysreg.h
+++ b/arch/arm64/include/asm/sysreg.h
@@ -115,8 +115,14 @@
 #define SB_BARRIER_INSN			__SYS_BARRIER_INSN(0, 7, 31)
 
 #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
+#define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
+#define SYS_DC_IGDSW			sys_insn(1, 0, 7, 6, 6)
 #define SYS_DC_CSW			sys_insn(1, 0, 7, 10, 2)
+#define SYS_DC_CGSW			sys_insn(1, 0, 7, 10, 4)
+#define SYS_DC_CGDSW			sys_insn(1, 0, 7, 10, 6)
 #define SYS_DC_CISW			sys_insn(1, 0, 7, 14, 2)
+#define SYS_DC_CIGSW			sys_insn(1, 0, 7, 14, 4)
+#define SYS_DC_CIGDSW			sys_insn(1, 0, 7, 14, 6)
 
 /*
  * Automatically generated definitions for system registers, the
diff --git a/arch/arm64/kvm/hyp/include/hyp/switch.h b/arch/arm64/kvm/hyp/include/hyp/switch.h
index 33f4d4200329..168365167a13 100644
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -81,7 +81,12 @@ static inline void __activate_traps_common(struct kvm_vcpu *vcpu)
 	 * EL1 instead of being trapped to EL2.
 	 */
 	if (kvm_arm_support_pmu_v3()) {
+		struct kvm_cpu_context *hctxt;
+
 		write_sysreg(0, pmselr_el0);
+
+		hctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
+		ctxt_sys_reg(hctxt, PMUSERENR_EL0) = read_sysreg(pmuserenr_el0);
 		write_sysreg(ARMV8_PMU_USERENR_MASK, pmuserenr_el0);
 	}
 
@@ -105,8 +110,12 @@ static inline void __deactivate_traps_common(struct kvm_vcpu *vcpu)
 	write_sysreg(vcpu->arch.mdcr_el2_host, mdcr_el2);
 
 	write_sysreg(0, hstr_el2);
-	if (kvm_arm_support_pmu_v3())
-		write_sysreg(0, pmuserenr_el0);
+	if (kvm_arm_support_pmu_v3()) {
+		struct kvm_cpu_context *hctxt;
+
+		hctxt = &this_cpu_ptr(&kvm_host_data)->host_ctxt;
+		write_sysreg(ctxt_sys_reg(hctxt, PMUSERENR_EL0), pmuserenr_el0);
+	}
 
 	if (cpus_have_final_cap(ARM64_SME)) {
 		sysreg_clear_set_s(SYS_HFGRTR_EL2, 0,
diff --git a/arch/arm64/kvm/vgic/vgic-init.c b/arch/arm64/kvm/vgic/vgic-init.c
index c199ba2f192e..06ca3b722f26 100644
--- a/arch/arm64/kvm/vgic/vgic-init.c
+++ b/arch/arm64/kvm/vgic/vgic-init.c
@@ -446,6 +446,7 @@ int vgic_lazy_init(struct kvm *kvm)
 int kvm_vgic_map_resources(struct kvm *kvm)
 {
 	struct vgic_dist *dist = &kvm->arch.vgic;
+	enum vgic_type type;
 	gpa_t dist_base;
 	int ret = 0;
 
@@ -460,10 +461,13 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 	if (!irqchip_in_kernel(kvm))
 		goto out;
 
-	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2)
+	if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
 		ret = vgic_v2_map_resources(kvm);
-	else
+		type = VGIC_V2;
+	} else {
 		ret = vgic_v3_map_resources(kvm);
+		type = VGIC_V3;
+	}
 
 	if (ret) {
 		__kvm_vgic_destroy(kvm);
@@ -473,8 +477,7 @@ int kvm_vgic_map_resources(struct kvm *kvm)
 	dist_base = dist->vgic_dist_base;
 	mutex_unlock(&kvm->arch.config_lock);
 
-	ret = vgic_register_dist_iodev(kvm, dist_base,
-				       kvm_vgic_global_state.type);
+	ret = vgic_register_dist_iodev(kvm, dist_base, type);
 	if (ret) {
 		kvm_err("Unable to register VGIC dist MMIO regions\n");
 		kvm_vgic_destroy(kvm);
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index b05e833a022d..d46b6722710f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -7,7 +7,7 @@
 #
 
 OBJCOPYFLAGS    := -O binary
-LDFLAGS_vmlinux :=
+LDFLAGS_vmlinux := -z norelro
 ifeq ($(CONFIG_DYNAMIC_FTRACE),y)
 	LDFLAGS_vmlinux := --no-relax
 	KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
index 32573b4f9bd2..cc8cf5abea15 100644
--- a/arch/s390/purgatory/Makefile
+++ b/arch/s390/purgatory/Makefile
@@ -26,6 +26,7 @@ KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
 KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
 KBUILD_CFLAGS += -Os -m64 -msoft-float -fno-common
 KBUILD_CFLAGS += -fno-stack-protector
+KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
 KBUILD_AFLAGS := $(filter-out -DCC_USING_EXPOLINE,$(KBUILD_AFLAGS))
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index b39975977c03..fdc2e3abd615 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -305,6 +305,18 @@ ifeq ($(RETPOLINE_CFLAGS),)
 endif
 endif
 
+ifdef CONFIG_UNWINDER_ORC
+orc_hash_h := arch/$(SRCARCH)/include/generated/asm/orc_hash.h
+orc_hash_sh := $(srctree)/scripts/orc_hash.sh
+targets += $(orc_hash_h)
+quiet_cmd_orc_hash = GEN     $@
+      cmd_orc_hash = mkdir -p $(dir $@); \
+		     $(CONFIG_SHELL) $(orc_hash_sh) < $< > $@
+$(orc_hash_h): $(srctree)/arch/x86/include/asm/orc_types.h $(orc_hash_sh) FORCE
+	$(call if_changed,orc_hash)
+archprepare: $(orc_hash_h)
+endif
+
 archclean:
 	$(Q)rm -rf $(objtree)/arch/i386
 	$(Q)rm -rf $(objtree)/arch/x86_64
diff --git a/arch/x86/include/asm/Kbuild b/arch/x86/include/asm/Kbuild
index 1e51650b79d7..4f1ce5fc4e19 100644
--- a/arch/x86/include/asm/Kbuild
+++ b/arch/x86/include/asm/Kbuild
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 
+generated-y += orc_hash.h
 generated-y += syscalls_32.h
 generated-y += syscalls_64.h
 generated-y += syscalls_x32.h
diff --git a/arch/x86/include/asm/orc_header.h b/arch/x86/include/asm/orc_header.h
new file mode 100644
index 000000000000..07bacf3e160e
--- /dev/null
+++ b/arch/x86/include/asm/orc_header.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Copyright (c) Meta Platforms, Inc. and affiliates. */
+
+#ifndef _ORC_HEADER_H
+#define _ORC_HEADER_H
+
+#include <linux/types.h>
+#include <linux/compiler.h>
+#include <asm/orc_hash.h>
+
+/*
+ * The header is currently a 20-byte hash of the ORC entry definition; see
+ * scripts/orc_hash.sh.
+ */
+#define ORC_HEADER					\
+	__used __section(".orc_header") __aligned(4)	\
+	static const u8 orc_header[] = { ORC_HASH }
+
+#endif /* _ORC_HEADER_H */
diff --git a/arch/x86/kernel/apic/x2apic_phys.c b/arch/x86/kernel/apic/x2apic_phys.c
index 6bde05a86b4e..896bc41cb2ba 100644
--- a/arch/x86/kernel/apic/x2apic_phys.c
+++ b/arch/x86/kernel/apic/x2apic_phys.c
@@ -97,7 +97,10 @@ static void init_x2apic_ldr(void)
 
 static int x2apic_phys_probe(void)
 {
-	if (x2apic_mode && (x2apic_phys || x2apic_fadt_phys()))
+	if (!x2apic_mode)
+		return 0;
+
+	if (x2apic_phys || x2apic_fadt_phys())
 		return 1;
 
 	return apic == &apic_x2apic_phys;
diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index 37307b40f8da..c960f250624a 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -7,6 +7,9 @@
 #include <asm/unwind.h>
 #include <asm/orc_types.h>
 #include <asm/orc_lookup.h>
+#include <asm/orc_header.h>
+
+ORC_HEADER;
 
 #define orc_warn(fmt, ...) \
 	printk_deferred_once(KERN_WARNING "WARNING: " fmt, ##__VA_ARGS__)
diff --git a/arch/x86/mm/kaslr.c b/arch/x86/mm/kaslr.c
index 557f0fe25dff..37db264866b6 100644
--- a/arch/x86/mm/kaslr.c
+++ b/arch/x86/mm/kaslr.c
@@ -172,10 +172,10 @@ void __meminit init_trampoline_kaslr(void)
 		set_p4d(p4d_tramp,
 			__p4d(_KERNPG_TABLE | __pa(pud_page_tramp)));
 
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(p4d_page_tramp));
 	} else {
-		set_pgd(&trampoline_pgd_entry,
-			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp)));
+		trampoline_pgd_entry =
+			__pgd(_KERNPG_TABLE | __pa(pud_page_tramp));
 	}
 }
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 1056bbf55b17..438adb695daa 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2570,7 +2570,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
 	}
 
 	if (bpf_jit_enable > 1)
-		bpf_jit_dump(prog->len, proglen, pass + 1, image);
+		bpf_jit_dump(prog->len, proglen, pass + 1, rw_image);
 
 	if (image) {
 		if (!prog->is_func || extra_pass) {
diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index dd6d1c0117b1..581aa08e34a8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -907,6 +907,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	struct llist_head *lhead = per_cpu_ptr(blkcg->lhead, cpu);
 	struct llist_node *lnode;
 	struct blkg_iostat_set *bisc, *next_bisc;
+	unsigned long flags;
 
 	rcu_read_lock();
 
@@ -920,7 +921,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 	 * When flushing from cgroup, cgroup_rstat_lock is always held, so
 	 * this lock won't cause contention most of time.
 	 */
-	raw_spin_lock(&blkg_stat_lock);
+	raw_spin_lock_irqsave(&blkg_stat_lock, flags);
 
 	/*
 	 * Iterate only the iostat_cpu's queued in the lockless list.
@@ -946,7 +947,7 @@ static void __blkcg_rstat_flush(struct blkcg *blkcg, int cpu)
 			blkcg_iostat_update(parent, &blkg->iostat.cur,
 					    &blkg->iostat.last);
 	}
-	raw_spin_unlock(&blkg_stat_lock);
+	raw_spin_unlock_irqrestore(&blkg_stat_lock, flags);
 out:
 	rcu_read_unlock();
 }
diff --git a/drivers/acpi/acpica/achware.h b/drivers/acpi/acpica/achware.h
index 6f2787506b50..c1b6e7bf4fcb 100644
--- a/drivers/acpi/acpica/achware.h
+++ b/drivers/acpi/acpica/achware.h
@@ -101,8 +101,6 @@ acpi_status
 acpi_hw_get_gpe_status(struct acpi_gpe_event_info *gpe_event_info,
 		       acpi_event_status *event_status);
 
-acpi_status acpi_hw_disable_all_gpes(void);
-
 acpi_status acpi_hw_enable_all_runtime_gpes(void);
 
 acpi_status acpi_hw_enable_all_wakeup_gpes(void);
diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
index 4ca667251272..539c12fbd2f1 100644
--- a/drivers/acpi/sleep.c
+++ b/drivers/acpi/sleep.c
@@ -636,11 +636,19 @@ static int acpi_suspend_enter(suspend_state_t pm_state)
 	}
 
 	/*
-	 * Disable and clear GPE status before interrupt is enabled. Some GPEs
-	 * (like wakeup GPE) haven't handler, this can avoid such GPE misfire.
-	 * acpi_leave_sleep_state will reenable specific GPEs later
+	 * Disable all GPE and clear their status bits before interrupts are
+	 * enabled. Some GPEs (like wakeup GPEs) have no handlers and this can
+	 * prevent them from producing spurious interrups.
+	 *
+	 * acpi_leave_sleep_state() will reenable specific GPEs later.
+	 *
+	 * Because this code runs on one CPU with disabled interrupts (all of
+	 * the other CPUs are offline at this time), it need not acquire any
+	 * sleeping locks which may trigger an implicit preemption point even
+	 * if there is no contention, so avoid doing that by using a low-level
+	 * library routine here.
 	 */
-	acpi_disable_all_gpes();
+	acpi_hw_disable_all_gpes();
 	/* Allow EC transactions to happen. */
 	acpi_ec_unblock_transactions();
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 14c17c3bda4e..d37df499c9fa 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5348,7 +5348,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
 
 	mutex_init(&ap->scsi_scan_mutex);
 	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
-	INIT_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
+	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 	init_waitqueue_head(&ap->eh_wait_q);
 	init_completion(&ap->park_req_pending);
@@ -5954,6 +5954,7 @@ static void ata_port_detach(struct ata_port *ap)
 	WARN_ON(!(ap->pflags & ATA_PFLAG_UNLOADED));
 
 	cancel_delayed_work_sync(&ap->hotplug_task);
+	cancel_delayed_work_sync(&ap->scsi_rescan_task);
 
  skip_eh:
 	/* clean up zpodd on port removal */
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index a6c901811802..6f8d14191593 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -2984,7 +2984,7 @@ static int ata_eh_revalidate_and_attach(struct ata_link *link,
 			ehc->i.flags |= ATA_EHI_SETMODE;
 
 			/* schedule the scsi_rescan_device() here */
-			schedule_work(&(ap->scsi_rescan_task));
+			schedule_delayed_work(&ap->scsi_rescan_task, 0);
 		} else if (dev->class == ATA_DEV_UNKNOWN &&
 			   ehc->tries[dev->devno] &&
 			   ata_class_enabled(ehc->classes[dev->devno])) {
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index a9e768fdae4e..51673d95e5b2 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -4597,10 +4597,11 @@ int ata_scsi_user_scan(struct Scsi_Host *shost, unsigned int channel,
 void ata_scsi_dev_rescan(struct work_struct *work)
 {
 	struct ata_port *ap =
-		container_of(work, struct ata_port, scsi_rescan_task);
+		container_of(work, struct ata_port, scsi_rescan_task.work);
 	struct ata_link *link;
 	struct ata_device *dev;
 	unsigned long flags;
+	bool delay_rescan = false;
 
 	mutex_lock(&ap->scsi_scan_mutex);
 	spin_lock_irqsave(ap->lock, flags);
@@ -4614,6 +4615,21 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 			if (scsi_device_get(sdev))
 				continue;
 
+			/*
+			 * If the rescan work was scheduled because of a resume
+			 * event, the port is already fully resumed, but the
+			 * SCSI device may not yet be fully resumed. In such
+			 * case, executing scsi_rescan_device() may cause a
+			 * deadlock with the PM code on device_lock(). Prevent
+			 * this by giving up and retrying rescan after a short
+			 * delay.
+			 */
+			delay_rescan = sdev->sdev_gendev.power.is_suspended;
+			if (delay_rescan) {
+				scsi_device_put(sdev);
+				break;
+			}
+
 			spin_unlock_irqrestore(ap->lock, flags);
 			scsi_rescan_device(&(sdev->sdev_gendev));
 			scsi_device_put(sdev);
@@ -4623,4 +4639,8 @@ void ata_scsi_dev_rescan(struct work_struct *work)
 
 	spin_unlock_irqrestore(ap->lock, flags);
 	mutex_unlock(&ap->scsi_scan_mutex);
+
+	if (delay_rescan)
+		schedule_delayed_work(&ap->scsi_rescan_task,
+				      msecs_to_jiffies(5));
 }
diff --git a/drivers/base/regmap/regmap-spi-avmm.c b/drivers/base/regmap/regmap-spi-avmm.c
index 4c2b94b3e30b..6af692844c19 100644
--- a/drivers/base/regmap/regmap-spi-avmm.c
+++ b/drivers/base/regmap/regmap-spi-avmm.c
@@ -660,7 +660,7 @@ static const struct regmap_bus regmap_spi_avmm_bus = {
 	.reg_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.val_format_endian_default = REGMAP_ENDIAN_NATIVE,
 	.max_raw_read = SPI_AVMM_VAL_SIZE * MAX_READ_CNT,
-	.max_raw_write = SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
+	.max_raw_write = SPI_AVMM_REG_SIZE + SPI_AVMM_VAL_SIZE * MAX_WRITE_CNT,
 	.free_context = spi_avmm_bridge_ctx_free,
 };
 
diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 14491952047f..3b6b4cb400f4 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -2212,6 +2212,7 @@ static void null_destroy_dev(struct nullb *nullb)
 	struct nullb_device *dev = nullb->dev;
 
 	null_del_dev(nullb);
+	null_free_device_storage(dev, false);
 	null_free_dev(dev);
 }
 
diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 2b918e28acaa..b47358da92a2 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -348,63 +348,33 @@ static inline void virtblk_request_done(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
-static void virtblk_complete_batch(struct io_comp_batch *iob)
-{
-	struct request *req;
-
-	rq_list_for_each(&iob->req_list, req) {
-		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
-		virtblk_cleanup_cmd(req);
-	}
-	blk_mq_end_request_batch(iob);
-}
-
-static int virtblk_handle_req(struct virtio_blk_vq *vq,
-			      struct io_comp_batch *iob)
-{
-	struct virtblk_req *vbr;
-	int req_done = 0;
-	unsigned int len;
-
-	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
-		struct request *req = blk_mq_rq_from_pdu(vbr);
-
-		if (likely(!blk_should_fake_timeout(req->q)) &&
-		    !blk_mq_complete_request_remote(req) &&
-		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
-					 virtblk_complete_batch))
-			virtblk_request_done(req);
-		req_done++;
-	}
-
-	return req_done;
-}
-
 static void virtblk_done(struct virtqueue *vq)
 {
 	struct virtio_blk *vblk = vq->vdev->priv;
-	struct virtio_blk_vq *vblk_vq = &vblk->vqs[vq->index];
-	int req_done = 0;
+	bool req_done = false;
+	int qid = vq->index;
+	struct virtblk_req *vbr;
 	unsigned long flags;
-	DEFINE_IO_COMP_BATCH(iob);
+	unsigned int len;
 
-	spin_lock_irqsave(&vblk_vq->lock, flags);
+	spin_lock_irqsave(&vblk->vqs[qid].lock, flags);
 	do {
 		virtqueue_disable_cb(vq);
-		req_done += virtblk_handle_req(vblk_vq, &iob);
+		while ((vbr = virtqueue_get_buf(vblk->vqs[qid].vq, &len)) != NULL) {
+			struct request *req = blk_mq_rq_from_pdu(vbr);
 
+			if (likely(!blk_should_fake_timeout(req->q)))
+				blk_mq_complete_request(req);
+			req_done = true;
+		}
 		if (unlikely(virtqueue_is_broken(vq)))
 			break;
 	} while (!virtqueue_enable_cb(vq));
 
-	if (req_done) {
-		if (!rq_list_empty(iob.req_list))
-			iob.complete(&iob);
-
-		/* In case queue is stopped waiting for more buffers. */
+	/* In case queue is stopped waiting for more buffers. */
+	if (req_done)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
-	}
-	spin_unlock_irqrestore(&vblk_vq->lock, flags);
+	spin_unlock_irqrestore(&vblk->vqs[qid].lock, flags);
 }
 
 static void virtio_commit_rqs(struct blk_mq_hw_ctx *hctx)
@@ -1283,15 +1253,37 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 	}
 }
 
+static void virtblk_complete_batch(struct io_comp_batch *iob)
+{
+	struct request *req;
+
+	rq_list_for_each(&iob->req_list, req) {
+		virtblk_unmap_data(req, blk_mq_rq_to_pdu(req));
+		virtblk_cleanup_cmd(req);
+	}
+	blk_mq_end_request_batch(iob);
+}
+
 static int virtblk_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 {
 	struct virtio_blk *vblk = hctx->queue->queuedata;
 	struct virtio_blk_vq *vq = get_virtio_blk_vq(hctx);
+	struct virtblk_req *vbr;
 	unsigned long flags;
+	unsigned int len;
 	int found = 0;
 
 	spin_lock_irqsave(&vq->lock, flags);
-	found = virtblk_handle_req(vq, iob);
+
+	while ((vbr = virtqueue_get_buf(vq->vq, &len)) != NULL) {
+		struct request *req = blk_mq_rq_from_pdu(vbr);
+
+		found++;
+		if (!blk_mq_complete_request_remote(req) &&
+		    !blk_mq_add_to_batch(req, iob, virtblk_vbr_status(vbr),
+						virtblk_complete_batch))
+			virtblk_request_done(req);
+	}
 
 	if (found)
 		blk_mq_start_stopped_hw_queues(vblk->disk->queue, true);
diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis_core.c
index e05d2b227de3..55f6ff1e05aa 100644
--- a/drivers/char/tpm/tpm_tis_core.c
+++ b/drivers/char/tpm/tpm_tis_core.c
@@ -772,7 +772,9 @@ static irqreturn_t tis_int_handler(int dummy, void *dev_id)
 		wake_up_interruptible(&priv->int_queue);
 
 	/* Clear interrupts handled with TPM_EOI */
+	tpm_tis_request_locality(chip, 0);
 	rc = tpm_tis_write32(priv, TPM_INT_STATUS(priv->locality), interrupt);
+	tpm_tis_relinquish_locality(chip, 0);
 	if (rc < 0)
 		return IRQ_NONE;
 
diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 740d6e426ee9..1e946c3c1260 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -12,7 +12,6 @@
 #include <linux/shmem_fs.h>
 #include <linux/slab.h>
 #include <linux/udmabuf.h>
-#include <linux/hugetlb.h>
 #include <linux/vmalloc.h>
 #include <linux/iosys-map.h>
 
@@ -207,9 +206,7 @@ static long udmabuf_create(struct miscdevice *device,
 	struct udmabuf *ubuf;
 	struct dma_buf *buf;
 	pgoff_t pgoff, pgcnt, pgidx, pgbuf = 0, pglimit;
-	struct page *page, *hpage = NULL;
-	pgoff_t subpgoff, maxsubpgs;
-	struct hstate *hpstate;
+	struct page *page;
 	int seals, ret = -EINVAL;
 	u32 i, flags;
 
@@ -245,7 +242,7 @@ static long udmabuf_create(struct miscdevice *device,
 		if (!memfd)
 			goto err;
 		mapping = memfd->f_mapping;
-		if (!shmem_mapping(mapping) && !is_file_hugepages(memfd))
+		if (!shmem_mapping(mapping))
 			goto err;
 		seals = memfd_fcntl(memfd, F_GET_SEALS, 0);
 		if (seals == -EINVAL)
@@ -256,48 +253,16 @@ static long udmabuf_create(struct miscdevice *device,
 			goto err;
 		pgoff = list[i].offset >> PAGE_SHIFT;
 		pgcnt = list[i].size   >> PAGE_SHIFT;
-		if (is_file_hugepages(memfd)) {
-			hpstate = hstate_file(memfd);
-			pgoff = list[i].offset >> huge_page_shift(hpstate);
-			subpgoff = (list[i].offset &
-				    ~huge_page_mask(hpstate)) >> PAGE_SHIFT;
-			maxsubpgs = huge_page_size(hpstate) >> PAGE_SHIFT;
-		}
 		for (pgidx = 0; pgidx < pgcnt; pgidx++) {
-			if (is_file_hugepages(memfd)) {
-				if (!hpage) {
-					hpage = find_get_page_flags(mapping, pgoff,
-								    FGP_ACCESSED);
-					if (!hpage) {
-						ret = -EINVAL;
-						goto err;
-					}
-				}
-				page = hpage + subpgoff;
-				get_page(page);
-				subpgoff++;
-				if (subpgoff == maxsubpgs) {
-					put_page(hpage);
-					hpage = NULL;
-					subpgoff = 0;
-					pgoff++;
-				}
-			} else {
-				page = shmem_read_mapping_page(mapping,
-							       pgoff + pgidx);
-				if (IS_ERR(page)) {
-					ret = PTR_ERR(page);
-					goto err;
-				}
+			page = shmem_read_mapping_page(mapping, pgoff + pgidx);
+			if (IS_ERR(page)) {
+				ret = PTR_ERR(page);
+				goto err;
 			}
 			ubuf->pages[pgbuf++] = page;
 		}
 		fput(memfd);
 		memfd = NULL;
-		if (hpage) {
-			put_page(hpage);
-			hpage = NULL;
-		}
 	}
 
 	exp_info.ops  = &udmabuf_ops;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index abeff7dc0b58..34b9e7876538 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -361,24 +361,6 @@ static void __init efi_debugfs_init(void)
 static inline void efi_debugfs_init(void) {}
 #endif
 
-static void refresh_nv_rng_seed(struct work_struct *work)
-{
-	u8 seed[EFI_RANDOM_SEED_SIZE];
-
-	get_random_bytes(seed, sizeof(seed));
-	efi.set_variable(L"RandomSeed", &LINUX_EFI_RANDOM_SEED_TABLE_GUID,
-			 EFI_VARIABLE_NON_VOLATILE | EFI_VARIABLE_BOOTSERVICE_ACCESS |
-			 EFI_VARIABLE_RUNTIME_ACCESS, sizeof(seed), seed);
-	memzero_explicit(seed, sizeof(seed));
-}
-static int refresh_nv_rng_seed_notification(struct notifier_block *nb, unsigned long action, void *data)
-{
-	static DECLARE_WORK(work, refresh_nv_rng_seed);
-	schedule_work(&work);
-	return NOTIFY_DONE;
-}
-static struct notifier_block refresh_nv_rng_seed_nb = { .notifier_call = refresh_nv_rng_seed_notification };
-
 /*
  * We register the efi subsystem with the firmware subsystem and the
  * efivars subsystem with the efi subsystem, if the system was booted with
@@ -451,9 +433,6 @@ static int __init efisubsys_init(void)
 		platform_device_register_simple("efi_secret", 0, NULL, 0);
 #endif
 
-	if (efi_rt_services_supported(EFI_RT_SUPPORTED_SET_VARIABLE))
-		execute_with_initialized_rng(&refresh_nv_rng_seed_nb);
-
 	return 0;
 
 err_remove_group:
diff --git a/drivers/gpio/gpio-sifive.c b/drivers/gpio/gpio-sifive.c
index bc5660f61c57..0f1e1226ebbe 100644
--- a/drivers/gpio/gpio-sifive.c
+++ b/drivers/gpio/gpio-sifive.c
@@ -221,8 +221,12 @@ static int sifive_gpio_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	for (i = 0; i < ngpio; i++)
-		chip->irq_number[i] = platform_get_irq(pdev, i);
+	for (i = 0; i < ngpio; i++) {
+		ret = platform_get_irq(pdev, i);
+		if (ret < 0)
+			return ret;
+		chip->irq_number[i] = ret;
+	}
 
 	ret = bgpio_init(&chip->gc, dev, 4,
 			 chip->base + SIFIVE_GPIO_INPUT_VAL,
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4472214fcd43..ce8f71e06eb6 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1716,7 +1716,7 @@ static void gpiochip_irqchip_remove(struct gpio_chip *gc)
 	}
 
 	/* Remove all IRQ mappings and delete the domain */
-	if (gc->irq.domain) {
+	if (!gc->irq.domain_is_allocated_externally && gc->irq.domain) {
 		unsigned int irq;
 
 		for (offset = 0; offset < gc->ngpio; offset++) {
@@ -1762,6 +1762,15 @@ int gpiochip_irqchip_add_domain(struct gpio_chip *gc,
 
 	gc->to_irq = gpiochip_to_irq;
 	gc->irq.domain = domain;
+	gc->irq.domain_is_allocated_externally = true;
+
+	/*
+	 * Using barrier() here to prevent compiler from reordering
+	 * gc->irq.initialized before adding irqdomain.
+	 */
+	barrier();
+
+	gc->irq.initialized = true;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 289c261ffe87..2cbd6949804f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -350,6 +350,35 @@ static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
 		return false;
 }
 
+/**
+ * update_planes_and_stream_adapter() - Send planes to be updated in DC
+ *
+ * DC has a generic way to update planes and stream via
+ * dc_update_planes_and_stream function; however, DM might need some
+ * adjustments and preparation before calling it. This function is a wrapper
+ * for the dc_update_planes_and_stream that does any required configuration
+ * before passing control to DC.
+ */
+static inline bool update_planes_and_stream_adapter(struct dc *dc,
+						    int update_type,
+						    int planes_count,
+						    struct dc_stream_state *stream,
+						    struct dc_stream_update *stream_update,
+						    struct dc_surface_update *array_of_surface_update)
+{
+	/*
+	 * Previous frame finished and HW is ready for optimization.
+	 */
+	if (update_type == UPDATE_TYPE_FAST)
+		dc_post_update_surfaces_to_stream(dc);
+
+	return dc_update_planes_and_stream(dc,
+					   array_of_surface_update,
+					   planes_count,
+					   stream,
+					   stream_update);
+}
+
 /**
  * dm_pflip_high_irq() - Handle pageflip interrupt
  * @interrupt_params: ignored
@@ -2683,10 +2712,13 @@ static void dm_gpureset_commit_state(struct dc_state *dc_state,
 			bundle->surface_updates[m].surface->force_full_update =
 				true;
 		}
-		dc_commit_updates_for_stream(
-			dm->dc, bundle->surface_updates,
-			dc_state->stream_status->plane_count,
-			dc_state->streams[k], &bundle->stream_update, dc_state);
+
+		update_planes_and_stream_adapter(dm->dc,
+					 UPDATE_TYPE_FULL,
+					 dc_state->stream_status->plane_count,
+					 dc_state->streams[k],
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 	}
 
 cleanup:
@@ -8181,6 +8213,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		if (acrtc_state->abm_level != dm_old_crtc_state->abm_level)
 			bundle->stream_update.abm_level = &acrtc_state->abm_level;
 
+		mutex_lock(&dm->dc_lock);
+		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
+				acrtc_state->stream->link->psr_settings.psr_allow_active)
+			amdgpu_dm_psr_disable(acrtc_state->stream);
+		mutex_unlock(&dm->dc_lock);
+
 		/*
 		 * If FreeSync state on the stream has changed then we need to
 		 * re-adjust the min/max bounds now that DC doesn't handle this
@@ -8194,16 +8232,12 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 			spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 		}
 		mutex_lock(&dm->dc_lock);
-		if ((acrtc_state->update_type > UPDATE_TYPE_FAST) &&
-				acrtc_state->stream->link->psr_settings.psr_allow_active)
-			amdgpu_dm_psr_disable(acrtc_state->stream);
-
-		dc_commit_updates_for_stream(dm->dc,
-						     bundle->surface_updates,
-						     planes_count,
-						     acrtc_state->stream,
-						     &bundle->stream_update,
-						     dc_state);
+		update_planes_and_stream_adapter(dm->dc,
+					 acrtc_state->update_type,
+					 planes_count,
+					 acrtc_state->stream,
+					 &bundle->stream_update,
+					 bundle->surface_updates);
 
 		/**
 		 * Enable or disable the interrupts on the backend.
@@ -8741,12 +8775,11 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 
 		mutex_lock(&dm->dc_lock);
-		dc_commit_updates_for_stream(dm->dc,
-						     dummy_updates,
-						     status->plane_count,
-						     dm_new_crtc_state->stream,
-						     &stream_update,
-						     dc_state);
+		dc_update_planes_and_stream(dm->dc,
+					    dummy_updates,
+					    status->plane_count,
+					    dm_new_crtc_state->stream,
+					    &stream_update);
 		mutex_unlock(&dm->dc_lock);
 	}
 
diff --git a/drivers/gpu/drm/exynos/exynos_drm_g2d.c b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
index ec784e58da5c..414e585ec7dd 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_g2d.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_g2d.c
@@ -1335,7 +1335,7 @@ int exynos_g2d_exec_ioctl(struct drm_device *drm_dev, void *data,
 	/* Let the runqueue know that there is work to do. */
 	queue_work(g2d->g2d_workq, &g2d->runqueue_work);
 
-	if (runqueue_node->async)
+	if (req->async)
 		goto out;
 
 	wait_for_completion(&runqueue_node->complete);
diff --git a/drivers/gpu/drm/exynos/exynos_drm_vidi.c b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
index 4d56c8c799c5..f5e1adfcaa51 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_vidi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_vidi.c
@@ -469,8 +469,6 @@ static int vidi_remove(struct platform_device *pdev)
 	if (ctx->raw_edid != (struct edid *)fake_edid_info) {
 		kfree(ctx->raw_edid);
 		ctx->raw_edid = NULL;
-
-		return -EINVAL;
 	}
 
 	component_del(&pdev->dev, &vidi_component_ops);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 261fcbae88d7..75d79c311038 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -459,7 +459,6 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 	struct radeon_device *rdev = dev->dev_private;
 	struct drm_radeon_gem_set_domain *args = data;
 	struct drm_gem_object *gobj;
-	struct radeon_bo *robj;
 	int r;
 
 	/* for now if someone requests domain CPU -
@@ -472,13 +471,12 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 		up_read(&rdev->exclusive_lock);
 		return -ENOENT;
 	}
-	robj = gem_to_radeon_bo(gobj);
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
 	drm_gem_object_put(gobj);
 	up_read(&rdev->exclusive_lock);
-	r = radeon_gem_handle_lockup(robj->rdev, r);
+	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
 
diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index fb538a6c4add..aff4a21a46b6 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -2417,8 +2417,13 @@ static int wacom_parse_and_register(struct wacom *wacom, bool wireless)
 		goto fail_quirks;
 	}
 
-	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR)
+	if (features->device_type & WACOM_DEVICETYPE_WL_MONITOR) {
 		error = hid_hw_open(hdev);
+		if (error) {
+			hid_err(hdev, "hw open failed\n");
+			goto fail_quirks;
+		}
+	}
 
 	wacom_set_shared_values(wacom_wac);
 	devres_close_group(&hdev->dev, wacom);
diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index cc23b90cae02..d95e567a190d 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -829,11 +829,22 @@ static void vmbus_wait_for_unload(void)
 		if (completion_done(&vmbus_connection.unload_event))
 			goto completed;
 
-		for_each_online_cpu(cpu) {
+		for_each_present_cpu(cpu) {
 			struct hv_per_cpu_context *hv_cpu
 				= per_cpu_ptr(hv_context.cpu_context, cpu);
 
+			/*
+			 * In a CoCo VM the synic_message_page is not allocated
+			 * in hv_synic_alloc(). Instead it is set/cleared in
+			 * hv_synic_enable_regs() and hv_synic_disable_regs()
+			 * such that it is set only when the CPU is online. If
+			 * not all present CPUs are online, the message page
+			 * might be NULL, so skip such CPUs.
+			 */
 			page_addr = hv_cpu->synic_message_page;
+			if (!page_addr)
+				continue;
+
 			msg = (struct hv_message *)page_addr
 				+ VMBUS_MESSAGE_SINT;
 
@@ -867,11 +878,14 @@ static void vmbus_wait_for_unload(void)
 	 * maybe-pending messages on all CPUs to be able to receive new
 	 * messages after we reconnect.
 	 */
-	for_each_online_cpu(cpu) {
+	for_each_present_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			= per_cpu_ptr(hv_context.cpu_context, cpu);
 
 		page_addr = hv_cpu->synic_message_page;
+		if (!page_addr)
+			continue;
+
 		msg = (struct hv_message *)page_addr + VMBUS_MESSAGE_SINT;
 		msg->header.message_type = HVMSG_NONE;
 	}
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index d24dd65b33d4..b50cc83e8315 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1525,7 +1525,7 @@ static int vmbus_bus_init(void)
 	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vmbus:online",
 				hv_synic_init, hv_synic_cleanup);
 	if (ret < 0)
-		goto err_cpuhp;
+		goto err_alloc;
 	hyperv_cpuhp_online = ret;
 
 	ret = vmbus_connect();
@@ -1577,9 +1577,8 @@ static int vmbus_bus_init(void)
 
 err_connect:
 	cpuhp_remove_state(hyperv_cpuhp_online);
-err_cpuhp:
-	hv_synic_free();
 err_alloc:
+	hv_synic_free();
 	if (vmbus_irq == -1) {
 		hv_remove_vmbus_handler();
 	} else {
diff --git a/drivers/i2c/busses/i2c-designware-core.h b/drivers/i2c/busses/i2c-designware-core.h
index 050d8c63ad3c..0164d9216330 100644
--- a/drivers/i2c/busses/i2c-designware-core.h
+++ b/drivers/i2c/busses/i2c-designware-core.h
@@ -40,6 +40,7 @@
 #define DW_IC_CON_BUS_CLEAR_CTRL		BIT(11)
 
 #define DW_IC_DATA_CMD_DAT			GENMASK(7, 0)
+#define DW_IC_DATA_CMD_FIRST_DATA_BYTE		BIT(11)
 
 /*
  * Registers offset
diff --git a/drivers/i2c/busses/i2c-designware-slave.c b/drivers/i2c/busses/i2c-designware-slave.c
index cec25054bb24..2e079cf20bb5 100644
--- a/drivers/i2c/busses/i2c-designware-slave.c
+++ b/drivers/i2c/busses/i2c-designware-slave.c
@@ -176,6 +176,10 @@ static irqreturn_t i2c_dw_isr_slave(int this_irq, void *dev_id)
 
 		do {
 			regmap_read(dev->map, DW_IC_DATA_CMD, &tmp);
+			if (tmp & DW_IC_DATA_CMD_FIRST_DATA_BYTE)
+				i2c_slave_event(dev->slave,
+						I2C_SLAVE_WRITE_REQUESTED,
+						&val);
 			val = tmp;
 			i2c_slave_event(dev->slave, I2C_SLAVE_WRITE_RECEIVED,
 					&val);
diff --git a/drivers/i2c/busses/i2c-imx-lpi2c.c b/drivers/i2c/busses/i2c-imx-lpi2c.c
index a49b14d52a98..ff12018bc206 100644
--- a/drivers/i2c/busses/i2c-imx-lpi2c.c
+++ b/drivers/i2c/busses/i2c-imx-lpi2c.c
@@ -201,8 +201,8 @@ static void lpi2c_imx_stop(struct lpi2c_imx_struct *lpi2c_imx)
 /* CLKLO = I2C_CLK_RATIO * CLKHI, SETHOLD = CLKHI, DATAVD = CLKHI/2 */
 static int lpi2c_imx_config(struct lpi2c_imx_struct *lpi2c_imx)
 {
-	u8 prescale, filt, sethold, clkhi, clklo, datavd;
-	unsigned int clk_rate, clk_cycle;
+	u8 prescale, filt, sethold, datavd;
+	unsigned int clk_rate, clk_cycle, clkhi, clklo;
 	enum lpi2c_imx_pincfg pincfg;
 	unsigned int temp;
 
diff --git a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
index b21ffd6df927..5ef136c3ecb1 100644
--- a/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
+++ b/drivers/i2c/busses/i2c-mchp-pci1xxxx.c
@@ -1118,8 +1118,10 @@ static int pci1xxxx_i2c_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(pci1xxxx_i2c_pm_ops, pci1xxxx_i2c_suspend,
 			 pci1xxxx_i2c_resume);
 
-static void pci1xxxx_i2c_shutdown(struct pci1xxxx_i2c *i2c)
+static void pci1xxxx_i2c_shutdown(void *data)
 {
+	struct pci1xxxx_i2c *i2c = data;
+
 	pci1xxxx_i2c_config_padctrl(i2c, false);
 	pci1xxxx_i2c_configure_core_reg(i2c, false);
 }
@@ -1156,7 +1158,7 @@ static int pci1xxxx_i2c_probe_pci(struct pci_dev *pdev,
 	init_completion(&i2c->i2c_xfer_done);
 	pci1xxxx_i2c_init(i2c);
 
-	ret = devm_add_action(dev, (void (*)(void *))pci1xxxx_i2c_shutdown, i2c);
+	ret = devm_add_action(dev, pci1xxxx_i2c_shutdown, i2c);
 	if (ret)
 		return ret;
 
diff --git a/drivers/input/misc/soc_button_array.c b/drivers/input/misc/soc_button_array.c
index 09489380afda..e79f5497948b 100644
--- a/drivers/input/misc/soc_button_array.c
+++ b/drivers/input/misc/soc_button_array.c
@@ -108,6 +108,27 @@ static const struct dmi_system_id dmi_use_low_level_irq[] = {
 	{} /* Terminating entry */
 };
 
+/*
+ * Some devices have a wrong entry which points to a GPIO which is
+ * required in another driver, so this driver must not claim it.
+ */
+static const struct dmi_system_id dmi_invalid_acpi_index[] = {
+	{
+		/*
+		 * Lenovo Yoga Book X90F / X90L, the PNP0C40 home button entry
+		 * points to a GPIO which is not a home button and which is
+		 * required by the lenovo-yogabook driver.
+		 */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_SYS_VENDOR, "Intel Corporation"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "CHERRYVIEW D1 PLATFORM"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_VERSION, "YETI-11"),
+		},
+		.driver_data = (void *)1l,
+	},
+	{} /* Terminating entry */
+};
+
 /*
  * Get the Nth GPIO number from the ACPI object.
  */
@@ -137,6 +158,8 @@ soc_button_device_create(struct platform_device *pdev,
 	struct platform_device *pd;
 	struct gpio_keys_button *gpio_keys;
 	struct gpio_keys_platform_data *gpio_keys_pdata;
+	const struct dmi_system_id *dmi_id;
+	int invalid_acpi_index = -1;
 	int error, gpio, irq;
 	int n_buttons = 0;
 
@@ -154,10 +177,17 @@ soc_button_device_create(struct platform_device *pdev,
 	gpio_keys = (void *)(gpio_keys_pdata + 1);
 	n_buttons = 0;
 
+	dmi_id = dmi_first_match(dmi_invalid_acpi_index);
+	if (dmi_id)
+		invalid_acpi_index = (long)dmi_id->driver_data;
+
 	for (info = button_info; info->name; info++) {
 		if (info->autorepeat != autorepeat)
 			continue;
 
+		if (info->acpi_index == invalid_acpi_index)
+			continue;
+
 		error = soc_button_lookup_gpio(&pdev->dev, info->acpi_index, &gpio, &irq);
 		if (error || irq < 0) {
 			/*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index cd0e3fb78c3f..e9eac86cddbd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2069,10 +2069,6 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	int mode = DEFAULT_PGTABLE_LEVEL;
 	int ret;
 
-	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
-	if (!domain)
-		return NULL;
-
 	/*
 	 * Force IOMMU v1 page table when iommu=pt and
 	 * when allocating domain for pass-through devices.
@@ -2088,6 +2084,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		return NULL;
 	}
 
+	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
+	if (!domain)
+		return NULL;
+
 	switch (pgtable) {
 	case AMD_IOMMU_V1:
 		ret = protection_domain_init_v1(domain, mode);
diff --git a/drivers/media/cec/core/cec-adap.c b/drivers/media/cec/core/cec-adap.c
index 4f5ab3cae8a7..b1512f9c5895 100644
--- a/drivers/media/cec/core/cec-adap.c
+++ b/drivers/media/cec/core/cec-adap.c
@@ -1090,7 +1090,8 @@ void cec_received_msg_ts(struct cec_adapter *adap,
 	mutex_lock(&adap->lock);
 	dprintk(2, "%s: %*ph\n", __func__, msg->len, msg->msg);
 
-	adap->last_initiator = 0xff;
+	if (!adap->transmit_in_progress)
+		adap->last_initiator = 0xff;
 
 	/* Check if this message was for us (directed or broadcast). */
 	if (!cec_msg_is_broadcast(msg))
@@ -1582,7 +1583,7 @@ static void cec_claim_log_addrs(struct cec_adapter *adap, bool block)
  *
  * This function is called with adap->lock held.
  */
-static int cec_adap_enable(struct cec_adapter *adap)
+int cec_adap_enable(struct cec_adapter *adap)
 {
 	bool enable;
 	int ret = 0;
@@ -1592,6 +1593,9 @@ static int cec_adap_enable(struct cec_adapter *adap)
 	if (adap->needs_hpd)
 		enable = enable && adap->phys_addr != CEC_PHYS_ADDR_INVALID;
 
+	if (adap->devnode.unregistered)
+		enable = false;
+
 	if (enable == adap->is_enabled)
 		return 0;
 
diff --git a/drivers/media/cec/core/cec-core.c b/drivers/media/cec/core/cec-core.c
index af358e901b5f..7e153c5cad04 100644
--- a/drivers/media/cec/core/cec-core.c
+++ b/drivers/media/cec/core/cec-core.c
@@ -191,6 +191,8 @@ static void cec_devnode_unregister(struct cec_adapter *adap)
 	mutex_lock(&adap->lock);
 	__cec_s_phys_addr(adap, CEC_PHYS_ADDR_INVALID, false);
 	__cec_s_log_addrs(adap, NULL, false);
+	// Disable the adapter (since adap->devnode.unregistered is true)
+	cec_adap_enable(adap);
 	mutex_unlock(&adap->lock);
 
 	cdev_device_del(&devnode->cdev, &devnode->dev);
diff --git a/drivers/media/cec/core/cec-priv.h b/drivers/media/cec/core/cec-priv.h
index b78df931aa74..ed1f8c67626b 100644
--- a/drivers/media/cec/core/cec-priv.h
+++ b/drivers/media/cec/core/cec-priv.h
@@ -47,6 +47,7 @@ int cec_monitor_pin_cnt_inc(struct cec_adapter *adap);
 void cec_monitor_pin_cnt_dec(struct cec_adapter *adap);
 int cec_adap_status(struct seq_file *file, void *priv);
 int cec_thread_func(void *_adap);
+int cec_adap_enable(struct cec_adapter *adap);
 void __cec_s_phys_addr(struct cec_adapter *adap, u16 phys_addr, bool block);
 int __cec_s_log_addrs(struct cec_adapter *adap,
 		      struct cec_log_addrs *log_addrs, bool block);
diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
index 8648f7e63ca1..eea208856ce0 100644
--- a/drivers/mmc/host/bcm2835.c
+++ b/drivers/mmc/host/bcm2835.c
@@ -1403,8 +1403,8 @@ static int bcm2835_probe(struct platform_device *pdev)
 	host->max_clk = clk_get_rate(clk);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err;
 	}
 
diff --git a/drivers/mmc/host/litex_mmc.c b/drivers/mmc/host/litex_mmc.c
index 39c6707fdfdb..9af6b0902efe 100644
--- a/drivers/mmc/host/litex_mmc.c
+++ b/drivers/mmc/host/litex_mmc.c
@@ -649,6 +649,7 @@ static struct platform_driver litex_mmc_driver = {
 	.driver = {
 		.name = "litex-mmc",
 		.of_match_table = litex_match,
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 };
 module_platform_driver(litex_mmc_driver);
diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
index 2b963a81c2ad..2eda0e496225 100644
--- a/drivers/mmc/host/meson-gx-mmc.c
+++ b/drivers/mmc/host/meson-gx-mmc.c
@@ -1006,11 +1006,8 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 
 		if (data && !cmd->error)
 			data->bytes_xfered = data->blksz * data->blocks;
-		if (meson_mmc_bounce_buf_read(data) ||
-		    meson_mmc_get_next_command(cmd))
-			ret = IRQ_WAKE_THREAD;
-		else
-			ret = IRQ_HANDLED;
+
+		return IRQ_WAKE_THREAD;
 	}
 
 out:
@@ -1022,9 +1019,6 @@ static irqreturn_t meson_mmc_irq(int irq, void *dev_id)
 		writel(start, host->regs + SD_EMMC_START);
 	}
 
-	if (ret == IRQ_HANDLED)
-		meson_mmc_request_done(host->mmc, cmd->mrq);
-
 	return ret;
 }
 
@@ -1208,8 +1202,8 @@ static int meson_mmc_probe(struct platform_device *pdev)
 		return PTR_ERR(host->regs);
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0)
-		return -EINVAL;
+	if (host->irq < 0)
+		return host->irq;
 
 	cd_irq = platform_get_irq_optional(pdev, 1);
 	mmc_gpio_set_cd_irq(mmc, cd_irq);
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b9e5dfe74e5c..1c326e4307f4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1735,7 +1735,8 @@ static void mmci_set_max_busy_timeout(struct mmc_host *mmc)
 		return;
 
 	if (host->variant->busy_timeout && mmc->actual_clock)
-		max_busy_timeout = ~0UL / (mmc->actual_clock / MSEC_PER_SEC);
+		max_busy_timeout = U32_MAX / DIV_ROUND_UP(mmc->actual_clock,
+							  MSEC_PER_SEC);
 
 	mmc->max_busy_timeout = max_busy_timeout;
 }
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index edade0e54a0c..9785ec91654f 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2680,7 +2680,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 
 	host->irq = platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		ret = -EINVAL;
+		ret = host->irq;
 		goto host_free;
 	}
 
diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index 629efbe639c4..b4f6a0a2fcb5 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -704,7 +704,7 @@ static int mvsd_probe(struct platform_device *pdev)
 	}
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	mmc = mmc_alloc_host(sizeof(struct mvsd_host), &pdev->dev);
 	if (!mmc) {
diff --git a/drivers/mmc/host/omap.c b/drivers/mmc/host/omap.c
index 57d39283924d..cc2213ea324f 100644
--- a/drivers/mmc/host/omap.c
+++ b/drivers/mmc/host/omap.c
@@ -1343,7 +1343,7 @@ static int mmc_omap_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-		return -ENXIO;
+		return irq;
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	host->virt_base = devm_ioremap_resource(&pdev->dev, res);
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 4bd744755205..2db3a16e63c4 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1791,9 +1791,11 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	}
 
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	irq = platform_get_irq(pdev, 0);
-	if (res == NULL || irq < 0)
+	if (!res)
 		return -ENXIO;
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
 
 	base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(base))
diff --git a/drivers/mmc/host/owl-mmc.c b/drivers/mmc/host/owl-mmc.c
index 3dc143b03939..679b8b0b310e 100644
--- a/drivers/mmc/host/owl-mmc.c
+++ b/drivers/mmc/host/owl-mmc.c
@@ -638,7 +638,7 @@ static int owl_mmc_probe(struct platform_device *pdev)
 
 	owl_host->irq = platform_get_irq(pdev, 0);
 	if (owl_host->irq < 0) {
-		ret = -EINVAL;
+		ret = owl_host->irq;
 		goto err_release_channel;
 	}
 
diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 8f0e639236b1..edf2e6c14dc6 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -829,7 +829,7 @@ static int sdhci_acpi_probe(struct platform_device *pdev)
 	host->ops	= &sdhci_acpi_ops_dflt;
 	host->irq	= platform_get_irq(pdev, 0);
 	if (host->irq < 0) {
-		err = -EINVAL;
+		err = host->irq;
 		goto err_free;
 	}
 
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8ac81d57a3df..1877d583fe8c 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2479,6 +2479,9 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 		msm_host->ddr_config = DDR_CONFIG_POR_VAL;
 
 	of_property_read_u32(node, "qcom,dll-config", &msm_host->dll_config);
+
+	if (of_device_is_compatible(node, "qcom,msm8916-sdhci"))
+		host->quirks2 |= SDHCI_QUIRK2_BROKEN_64_BIT_DMA;
 }
 
 static int sdhci_msm_gcc_reset(struct device *dev, struct sdhci_host *host)
diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index d463e2fd5b1a..c79035727b20 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -65,8 +65,8 @@ static int sdhci_probe(struct platform_device *pdev)
 	host->hw_name = "sdhci";
 	host->ops = &sdhci_pltfm_ops;
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto err_host;
 	}
 	host->quirks = SDHCI_QUIRK_BROKEN_ADMA;
diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 0fd4c9d644dd..5cf53348372a 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1400,7 +1400,7 @@ static int sh_mmcif_probe(struct platform_device *pdev)
 	irq[0] = platform_get_irq(pdev, 0);
 	irq[1] = platform_get_irq_optional(pdev, 1);
 	if (irq[0] < 0)
-		return -ENXIO;
+		return irq[0];
 
 	reg = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(reg))
diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index 3db9f32d6a7b..69dcb8805e05 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1350,8 +1350,8 @@ static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
 		return ret;
 
 	host->irq = platform_get_irq(pdev, 0);
-	if (host->irq <= 0) {
-		ret = -EINVAL;
+	if (host->irq < 0) {
+		ret = host->irq;
 		goto error_disable_mmc;
 	}
 
diff --git a/drivers/mmc/host/usdhi6rol0.c b/drivers/mmc/host/usdhi6rol0.c
index 99515be6e5e5..2032e4e1ee68 100644
--- a/drivers/mmc/host/usdhi6rol0.c
+++ b/drivers/mmc/host/usdhi6rol0.c
@@ -1757,8 +1757,10 @@ static int usdhi6_probe(struct platform_device *pdev)
 	irq_cd = platform_get_irq_byname(pdev, "card detect");
 	irq_sd = platform_get_irq_byname(pdev, "data");
 	irq_sdio = platform_get_irq_byname(pdev, "SDIO");
-	if (irq_sd < 0 || irq_sdio < 0)
-		return -ENODEV;
+	if (irq_sd < 0)
+		return irq_sd;
+	if (irq_sdio < 0)
+		return irq_sdio;
 
 	mmc = mmc_alloc_host(sizeof(struct usdhi6_host), dev);
 	if (!mmc)
diff --git a/drivers/net/dsa/mt7530.c b/drivers/net/dsa/mt7530.c
index 0c81f5830b90..566545b6554b 100644
--- a/drivers/net/dsa/mt7530.c
+++ b/drivers/net/dsa/mt7530.c
@@ -419,6 +419,20 @@ static void mt7530_pll_setup(struct mt7530_priv *priv)
 	core_set(priv, CORE_TRGMII_GSW_CLK_CG, REG_GSWCK_EN);
 }
 
+/* If port 6 is available as a CPU port, always prefer that as the default,
+ * otherwise don't care.
+ */
+static struct dsa_port *
+mt753x_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp = dsa_to_port(ds, 6);
+
+	if (dsa_port_is_cpu(cpu_dp))
+		return cpu_dp;
+
+	return NULL;
+}
+
 /* Setup port 6 interface mode and TRGMII TX circuit */
 static int
 mt7530_pad_clk_setup(struct dsa_switch *ds, phy_interface_t interface)
@@ -991,6 +1005,18 @@ static void mt7530_setup_port5(struct dsa_switch *ds, phy_interface_t interface)
 	mutex_unlock(&priv->reg_mutex);
 }
 
+static void
+mt753x_trap_frames(struct mt7530_priv *priv)
+{
+	/* Trap BPDUs to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
+		   MT753X_BPDU_CPU_ONLY);
+
+	/* Trap LLDP frames with :0E MAC DA to the CPU port(s) */
+	mt7530_rmw(priv, MT753X_RGAC2, MT753X_R0E_PORT_FW_MASK,
+		   MT753X_R0E_PORT_FW(MT753X_BPDU_CPU_ONLY));
+}
+
 static int
 mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 {
@@ -1013,7 +1039,7 @@ mt753x_cpu_port_enable(struct dsa_switch *ds, int port)
 		   UNU_FFP(BIT(port)));
 
 	/* Set CPU port number */
-	if (priv->id == ID_MT7621)
+	if (priv->id == ID_MT7530 || priv->id == ID_MT7621)
 		mt7530_rmw(priv, MT7530_MFC, CPU_MASK, CPU_EN | CPU_PORT(port));
 
 	/* CPU port gets connected to all user ports of
@@ -2214,6 +2240,8 @@ mt7530_setup(struct dsa_switch *ds)
 
 	priv->p6_interface = PHY_INTERFACE_MODE_NA;
 
+	mt753x_trap_frames(priv);
+
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
 
@@ -2320,8 +2348,8 @@ mt7531_setup_common(struct dsa_switch *ds)
 			   BIT(cpu_dp->index));
 		break;
 	}
-	mt7530_rmw(priv, MT753X_BPC, MT753X_BPDU_PORT_FW_MASK,
-		   MT753X_BPDU_CPU_ONLY);
+
+	mt753x_trap_frames(priv);
 
 	/* Enable and reset MIB counters */
 	mt7530_mib_reset(ds);
@@ -3177,6 +3205,7 @@ static int mt753x_set_mac_eee(struct dsa_switch *ds, int port,
 static const struct dsa_switch_ops mt7530_switch_ops = {
 	.get_tag_protocol	= mtk_get_tag_protocol,
 	.setup			= mt753x_setup,
+	.preferred_default_local_cpu_port = mt753x_preferred_default_local_cpu_port,
 	.get_strings		= mt7530_get_strings,
 	.get_ethtool_stats	= mt7530_get_ethtool_stats,
 	.get_sset_count		= mt7530_get_sset_count,
diff --git a/drivers/net/dsa/mt7530.h b/drivers/net/dsa/mt7530.h
index 6b2fc6290ea8..31c0f7156b69 100644
--- a/drivers/net/dsa/mt7530.h
+++ b/drivers/net/dsa/mt7530.h
@@ -65,6 +65,11 @@ enum mt753x_id {
 #define MT753X_BPC			0x24
 #define  MT753X_BPDU_PORT_FW_MASK	GENMASK(2, 0)
 
+/* Register for :03 and :0E MAC DA frame control */
+#define MT753X_RGAC2			0x2c
+#define  MT753X_R0E_PORT_FW_MASK	GENMASK(18, 16)
+#define  MT753X_R0E_PORT_FW(x)		FIELD_PREP(MT753X_R0E_PORT_FW_MASK, x)
+
 enum mt753x_bpdu_port_fw {
 	MT753X_BPDU_FOLLOW_MFC,
 	MT753X_BPDU_CPU_EXCLUDE = 4,
diff --git a/drivers/net/ethernet/emulex/benet/be_main.c b/drivers/net/ethernet/emulex/benet/be_main.c
index 46fe3d74e2e9..7236c4f70cf5 100644
--- a/drivers/net/ethernet/emulex/benet/be_main.c
+++ b/drivers/net/ethernet/emulex/benet/be_main.c
@@ -1136,8 +1136,8 @@ static struct sk_buff *be_lancer_xmit_workarounds(struct be_adapter *adapter,
 	eth_hdr_len = ntohs(skb->protocol) == ETH_P_8021Q ?
 						VLAN_ETH_HLEN : ETH_HLEN;
 	if (skb->len <= 60 &&
-	    (lancer_chip(adapter) || skb_vlan_tag_present(skb)) &&
-	    is_ipv4_pkt(skb)) {
+	    (lancer_chip(adapter) || BE3_chip(adapter) ||
+	     skb_vlan_tag_present(skb)) && is_ipv4_pkt(skb)) {
 		ip = (struct iphdr *)ip_hdr(skb);
 		pskb_trim(skb, eth_hdr_len + ntohs(ip->tot_len));
 	}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
index ee104cf04392..438c3bfae762 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_action.c
@@ -1403,9 +1403,13 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 	}
 	case DR_ACTION_TYP_TNL_L3_TO_L2:
 	{
-		u8 hw_actions[ACTION_CACHE_LINE_SIZE] = {};
+		u8 *hw_actions;
 		int ret;
 
+		hw_actions = kzalloc(ACTION_CACHE_LINE_SIZE, GFP_KERNEL);
+		if (!hw_actions)
+			return -ENOMEM;
+
 		ret = mlx5dr_ste_set_action_decap_l3_list(dmn->ste_ctx,
 							  data, data_sz,
 							  hw_actions,
@@ -1413,6 +1417,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 							  &action->rewrite->num_of_actions);
 		if (ret) {
 			mlx5dr_dbg(dmn, "Failed creating decap l3 action list\n");
+			kfree(hw_actions);
 			return ret;
 		}
 
@@ -1420,6 +1425,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 								DR_CHUNK_SIZE_8);
 		if (!action->rewrite->chunk) {
 			mlx5dr_dbg(dmn, "Failed allocating modify header chunk\n");
+			kfree(hw_actions);
 			return -ENOMEM;
 		}
 
@@ -1433,6 +1439,7 @@ dr_action_create_reformat_action(struct mlx5dr_domain *dmn,
 		if (ret) {
 			mlx5dr_dbg(dmn, "Writing decap l3 actions to ICM failed\n");
 			mlx5dr_icm_free_chunk(action->rewrite->chunk);
+			kfree(hw_actions);
 			return ret;
 		}
 		return 0;
diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index c865a4be05ee..4a1b94e5a8ea 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -582,8 +582,7 @@ qcaspi_spi_thread(void *data)
 	while (!kthread_should_stop()) {
 		set_current_state(TASK_INTERRUPTIBLE);
 		if ((qca->intr_req == qca->intr_svc) &&
-		    (qca->txr.skb[qca->txr.head] == NULL) &&
-		    (qca->sync == QCASPI_SYNC_READY))
+		    !qca->txr.skb[qca->txr.head])
 			schedule();
 
 		set_current_state(TASK_RUNNING);
diff --git a/drivers/net/ethernet/sfc/ef10.c b/drivers/net/ethernet/sfc/ef10.c
index d30459dbfe8f..b63e47af6365 100644
--- a/drivers/net/ethernet/sfc/ef10.c
+++ b/drivers/net/ethernet/sfc/ef10.c
@@ -2950,7 +2950,7 @@ static u32 efx_ef10_extract_event_ts(efx_qword_t *event)
 	return tstamp;
 }
 
-static void
+static int
 efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 {
 	struct efx_nic *efx = channel->efx;
@@ -2958,13 +2958,14 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	unsigned int tx_ev_desc_ptr;
 	unsigned int tx_ev_q_label;
 	unsigned int tx_ev_type;
+	int work_done;
 	u64 ts_part;
 
 	if (unlikely(READ_ONCE(efx->reset_pending)))
-		return;
+		return 0;
 
 	if (unlikely(EFX_QWORD_FIELD(*event, ESF_DZ_TX_DROP_EVENT)))
-		return;
+		return 0;
 
 	/* Get the transmit queue */
 	tx_ev_q_label = EFX_QWORD_FIELD(*event, ESF_DZ_TX_QLABEL);
@@ -2973,8 +2974,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	if (!tx_queue->timestamping) {
 		/* Transmit completion */
 		tx_ev_desc_ptr = EFX_QWORD_FIELD(*event, ESF_DZ_TX_DESCR_INDX);
-		efx_xmit_done(tx_queue, tx_ev_desc_ptr & tx_queue->ptr_mask);
-		return;
+		return efx_xmit_done(tx_queue, tx_ev_desc_ptr & tx_queue->ptr_mask);
 	}
 
 	/* Transmit timestamps are only available for 8XXX series. They result
@@ -3000,6 +3000,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 	 * fields in the event.
 	 */
 	tx_ev_type = EFX_QWORD_FIELD(*event, ESF_EZ_TX_SOFT1);
+	work_done = 0;
 
 	switch (tx_ev_type) {
 	case TX_TIMESTAMP_EVENT_TX_EV_COMPLETION:
@@ -3016,6 +3017,7 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 		tx_queue->completed_timestamp_major = ts_part;
 
 		efx_xmit_done_single(tx_queue);
+		work_done = 1;
 		break;
 
 	default:
@@ -3026,6 +3028,8 @@ efx_ef10_handle_tx_event(struct efx_channel *channel, efx_qword_t *event)
 			  EFX_QWORD_VAL(*event));
 		break;
 	}
+
+	return work_done;
 }
 
 static void
@@ -3081,13 +3085,16 @@ static void efx_ef10_handle_driver_generated_event(struct efx_channel *channel,
 	}
 }
 
+#define EFX_NAPI_MAX_TX 512
+
 static int efx_ef10_ev_process(struct efx_channel *channel, int quota)
 {
 	struct efx_nic *efx = channel->efx;
 	efx_qword_t event, *p_event;
 	unsigned int read_ptr;
-	int ev_code;
+	int spent_tx = 0;
 	int spent = 0;
+	int ev_code;
 
 	if (quota <= 0)
 		return spent;
@@ -3126,7 +3133,11 @@ static int efx_ef10_ev_process(struct efx_channel *channel, int quota)
 			}
 			break;
 		case ESE_DZ_EV_CODE_TX_EV:
-			efx_ef10_handle_tx_event(channel, &event);
+			spent_tx += efx_ef10_handle_tx_event(channel, &event);
+			if (spent_tx >= EFX_NAPI_MAX_TX) {
+				spent = quota;
+				goto out;
+			}
 			break;
 		case ESE_DZ_EV_CODE_DRIVER_EV:
 			efx_ef10_handle_driver_event(channel, &event);
diff --git a/drivers/net/ethernet/sfc/ef100_nic.c b/drivers/net/ethernet/sfc/ef100_nic.c
index 4dc643b0d2db..7adde9639c8a 100644
--- a/drivers/net/ethernet/sfc/ef100_nic.c
+++ b/drivers/net/ethernet/sfc/ef100_nic.c
@@ -253,6 +253,8 @@ static void ef100_ev_read_ack(struct efx_channel *channel)
 		   efx_reg(channel->efx, ER_GZ_EVQ_INT_PRIME));
 }
 
+#define EFX_NAPI_MAX_TX 512
+
 static int ef100_ev_process(struct efx_channel *channel, int quota)
 {
 	struct efx_nic *efx = channel->efx;
@@ -260,6 +262,7 @@ static int ef100_ev_process(struct efx_channel *channel, int quota)
 	bool evq_phase, old_evq_phase;
 	unsigned int read_ptr;
 	efx_qword_t *p_event;
+	int spent_tx = 0;
 	int spent = 0;
 	bool ev_phase;
 	int ev_type;
@@ -295,7 +298,9 @@ static int ef100_ev_process(struct efx_channel *channel, int quota)
 			efx_mcdi_process_event(channel, p_event);
 			break;
 		case ESE_GZ_EF100_EV_TX_COMPLETION:
-			ef100_ev_tx(channel, p_event);
+			spent_tx += ef100_ev_tx(channel, p_event);
+			if (spent_tx >= EFX_NAPI_MAX_TX)
+				spent = quota;
 			break;
 		case ESE_GZ_EF100_EV_DRIVER:
 			netif_info(efx, drv, efx->net_dev,
diff --git a/drivers/net/ethernet/sfc/ef100_tx.c b/drivers/net/ethernet/sfc/ef100_tx.c
index 29ffaf35559d..849e5555bd12 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.c
+++ b/drivers/net/ethernet/sfc/ef100_tx.c
@@ -346,7 +346,7 @@ void ef100_tx_write(struct efx_tx_queue *tx_queue)
 	ef100_tx_push_buffers(tx_queue);
 }
 
-void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
+int ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
 {
 	unsigned int tx_done =
 		EFX_QWORD_FIELD(*p_event, ESF_GZ_EV_TXCMPL_NUM_DESC);
@@ -357,7 +357,7 @@ void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event)
 	unsigned int tx_index = (tx_queue->read_count + tx_done - 1) &
 				tx_queue->ptr_mask;
 
-	efx_xmit_done(tx_queue, tx_index);
+	return efx_xmit_done(tx_queue, tx_index);
 }
 
 /* Add a socket buffer to a TX queue
diff --git a/drivers/net/ethernet/sfc/ef100_tx.h b/drivers/net/ethernet/sfc/ef100_tx.h
index e9e11540fcde..d9a0819c5a72 100644
--- a/drivers/net/ethernet/sfc/ef100_tx.h
+++ b/drivers/net/ethernet/sfc/ef100_tx.h
@@ -20,7 +20,7 @@ void ef100_tx_init(struct efx_tx_queue *tx_queue);
 void ef100_tx_write(struct efx_tx_queue *tx_queue);
 unsigned int ef100_tx_max_skb_descs(struct efx_nic *efx);
 
-void ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event);
+int ef100_ev_tx(struct efx_channel *channel, const efx_qword_t *p_event);
 
 netdev_tx_t ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb);
 int __ef100_enqueue_skb(struct efx_tx_queue *tx_queue, struct sk_buff *skb,
diff --git a/drivers/net/ethernet/sfc/tx_common.c b/drivers/net/ethernet/sfc/tx_common.c
index 67e789b96c43..755aa92bf823 100644
--- a/drivers/net/ethernet/sfc/tx_common.c
+++ b/drivers/net/ethernet/sfc/tx_common.c
@@ -249,7 +249,7 @@ void efx_xmit_done_check_empty(struct efx_tx_queue *tx_queue)
 	}
 }
 
-void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
+int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 {
 	unsigned int fill_level, pkts_compl = 0, bytes_compl = 0;
 	unsigned int efv_pkts_compl = 0;
@@ -279,6 +279,8 @@ void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index)
 	}
 
 	efx_xmit_done_check_empty(tx_queue);
+
+	return pkts_compl + efv_pkts_compl;
 }
 
 /* Remove buffers put into a tx_queue for the current packet.
diff --git a/drivers/net/ethernet/sfc/tx_common.h b/drivers/net/ethernet/sfc/tx_common.h
index d87aecbc7bf1..1e9f42938aac 100644
--- a/drivers/net/ethernet/sfc/tx_common.h
+++ b/drivers/net/ethernet/sfc/tx_common.h
@@ -28,7 +28,7 @@ static inline bool efx_tx_buffer_in_use(struct efx_tx_buffer *buffer)
 }
 
 void efx_xmit_done_check_empty(struct efx_tx_queue *tx_queue);
-void efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index);
+int efx_xmit_done(struct efx_tx_queue *tx_queue, unsigned int index);
 
 void efx_enqueue_unwind(struct efx_tx_queue *tx_queue,
 			unsigned int insert_count);
diff --git a/drivers/net/ieee802154/mac802154_hwsim.c b/drivers/net/ieee802154/mac802154_hwsim.c
index 8445c2189d11..31cba9aa7636 100644
--- a/drivers/net/ieee802154/mac802154_hwsim.c
+++ b/drivers/net/ieee802154/mac802154_hwsim.c
@@ -685,7 +685,7 @@ static int hwsim_del_edge_nl(struct sk_buff *msg, struct genl_info *info)
 static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 {
 	struct nlattr *edge_attrs[MAC802154_HWSIM_EDGE_ATTR_MAX + 1];
-	struct hwsim_edge_info *einfo;
+	struct hwsim_edge_info *einfo, *einfo_old;
 	struct hwsim_phy *phy_v0;
 	struct hwsim_edge *e;
 	u32 v0, v1;
@@ -723,8 +723,10 @@ static int hwsim_set_edge_lqi(struct sk_buff *msg, struct genl_info *info)
 	list_for_each_entry_rcu(e, &phy_v0->edges, list) {
 		if (e->endpoint->idx == v1) {
 			einfo->lqi = lqi;
-			rcu_assign_pointer(e->info, einfo);
+			einfo_old = rcu_replace_pointer(e->info, einfo,
+							lockdep_is_held(&hwsim_phys_lock));
 			rcu_read_unlock();
+			kfree_rcu(einfo_old, rcu);
 			mutex_unlock(&hwsim_phys_lock);
 			return 0;
 		}
diff --git a/drivers/net/phy/dp83867.c b/drivers/net/phy/dp83867.c
index 9f7ff8820048..76fe7e7d9ac9 100644
--- a/drivers/net/phy/dp83867.c
+++ b/drivers/net/phy/dp83867.c
@@ -905,7 +905,7 @@ static int dp83867_phy_reset(struct phy_device *phydev)
 {
 	int err;
 
-	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESTART);
+	err = phy_write(phydev, DP83867_CTRL, DP83867_SW_RESET);
 	if (err < 0)
 		return err;
 
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 389f33a12534..8b3618d3da4a 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -1287,7 +1287,7 @@ EXPORT_SYMBOL_GPL(mdiobus_modify_changed);
  * @mask: bit mask of bits to clear
  * @set: bit mask of bits to set
  */
-int mdiobus_c45_modify_changed(struct mii_bus *bus, int devad, int addr,
+int mdiobus_c45_modify_changed(struct mii_bus *bus, int addr, int devad,
 			       u32 regnum, u16 mask, u16 set)
 {
 	int err;
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
index 25b2d41de4c1..3a6a7d62e883 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
@@ -547,6 +547,8 @@ static const struct iwl_dev_info iwl_dev_info_table[] = {
 	IWL_DEV_INFO(0x54F0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 	IWL_DEV_INFO(0x7A70, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
 	IWL_DEV_INFO(0x7A70, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
+	IWL_DEV_INFO(0x7AF0, 0x1691, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690s_name),
+	IWL_DEV_INFO(0x7AF0, 0x1692, iwlax411_2ax_cfg_so_gf4_a0, iwl_ax411_killer_1690i_name),
 
 	IWL_DEV_INFO(0x271C, 0x0214, iwl9260_2ac_cfg, iwl9260_1_name),
 	IWL_DEV_INFO(0x7E40, 0x1691, iwl_cfg_ma_a0_gf4_a0, iwl_ax411_killer_1690s_name),
diff --git a/drivers/nfc/nfcsim.c b/drivers/nfc/nfcsim.c
index 85bf8d586c70..0f6befe8be1e 100644
--- a/drivers/nfc/nfcsim.c
+++ b/drivers/nfc/nfcsim.c
@@ -336,10 +336,6 @@ static struct dentry *nfcsim_debugfs_root;
 static void nfcsim_debugfs_init(void)
 {
 	nfcsim_debugfs_root = debugfs_create_dir("nfcsim", NULL);
-
-	if (!nfcsim_debugfs_root)
-		pr_err("Could not create debugfs entry\n");
-
 }
 
 static void nfcsim_debugfs_remove(void)
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c015393beeee..8a632bf7f5a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -397,7 +397,16 @@ void nvme_complete_rq(struct request *req)
 	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
-	if (ctrl->kas)
+	/*
+	 * Completions of long-running commands should not be able to
+	 * defer sending of periodic keep alives, since the controller
+	 * may have completed processing such commands a long time ago
+	 * (arbitrarily close to command submission time).
+	 * req->deadline - req->timeout is the command submission time
+	 * in jiffies.
+	 */
+	if (ctrl->kas &&
+	    req->deadline - req->timeout >= ctrl->ka_last_check_time)
 		ctrl->comp_seen = true;
 
 	switch (nvme_decide_disposition(req)) {
@@ -1115,7 +1124,7 @@ u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_passthru_start, NVME_TARGET_PASSTHRU);
 
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status)
 {
 	if (effects & NVME_CMD_EFFECTS_CSE_MASK) {
@@ -1132,6 +1141,8 @@ void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
 		nvme_queue_scan(ctrl);
 		flush_work(&ctrl->scan_work);
 	}
+	if (ns)
+		return;
 
 	switch (cmd->common.opcode) {
 	case nvme_admin_set_features:
@@ -1161,9 +1172,25 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
+static unsigned long nvme_keep_alive_work_period(struct nvme_ctrl *ctrl)
+{
+	unsigned long delay = ctrl->kato * HZ / 2;
+
+	/*
+	 * When using Traffic Based Keep Alive, we need to run
+	 * nvme_keep_alive_work at twice the normal frequency, as one
+	 * command completion can postpone sending a keep alive command
+	 * by up to twice the delay between runs.
+	 */
+	if (ctrl->ctratt & NVME_CTRL_ATTR_TBKAS)
+		delay /= 2;
+	return delay;
+}
+
 static void nvme_queue_keep_alive_work(struct nvme_ctrl *ctrl)
 {
-	queue_delayed_work(nvme_wq, &ctrl->ka_work, ctrl->kato * HZ / 2);
+	queue_delayed_work(nvme_wq, &ctrl->ka_work,
+			   nvme_keep_alive_work_period(ctrl));
 }
 
 static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
@@ -1172,6 +1199,20 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 	struct nvme_ctrl *ctrl = rq->end_io_data;
 	unsigned long flags;
 	bool startka = false;
+	unsigned long rtt = jiffies - (rq->deadline - rq->timeout);
+	unsigned long delay = nvme_keep_alive_work_period(ctrl);
+
+	/*
+	 * Subtract off the keepalive RTT so nvme_keep_alive_work runs
+	 * at the desired frequency.
+	 */
+	if (rtt <= delay) {
+		delay -= rtt;
+	} else {
+		dev_warn(ctrl->device, "long keepalive RTT (%u ms)\n",
+			 jiffies_to_msecs(rtt));
+		delay = 0;
+	}
 
 	blk_mq_free_request(rq);
 
@@ -1182,6 +1223,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		return RQ_END_IO_NONE;
 	}
 
+	ctrl->ka_last_check_time = jiffies;
 	ctrl->comp_seen = false;
 	spin_lock_irqsave(&ctrl->lock, flags);
 	if (ctrl->state == NVME_CTRL_LIVE ||
@@ -1189,7 +1231,7 @@ static enum rq_end_io_ret nvme_keep_alive_end_io(struct request *rq,
 		startka = true;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 	if (startka)
-		nvme_queue_keep_alive_work(ctrl);
+		queue_delayed_work(nvme_wq, &ctrl->ka_work, delay);
 	return RQ_END_IO_NONE;
 }
 
@@ -1200,6 +1242,8 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	bool comp_seen = ctrl->comp_seen;
 	struct request *rq;
 
+	ctrl->ka_last_check_time = jiffies;
+
 	if ((ctrl->ctratt & NVME_CTRL_ATTR_TBKAS) && comp_seen) {
 		dev_dbg(ctrl->device,
 			"reschedule traffic based keep-alive timer\n");
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index d24ea2e05156..0264ec74a436 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -254,7 +254,7 @@ static int nvme_submit_user_cmd(struct request_queue *q,
 	blk_mq_free_request(req);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, cmd, ret);
+		nvme_passthru_end(ctrl, ns, effects, cmd, ret);
 
 	return ret;
 }
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2d4f59e0535..8657811f8b88 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -328,6 +328,7 @@ struct nvme_ctrl {
 	struct delayed_work ka_work;
 	struct delayed_work failfast_work;
 	struct nvme_command ka_cmd;
+	unsigned long ka_last_check_time;
 	struct work_struct fw_act_work;
 	unsigned long events;
 
@@ -1077,7 +1078,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode);
 int nvme_execute_rq(struct request *rq, bool at_head);
-void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects,
+void nvme_passthru_end(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u32 effects,
 		       struct nvme_command *cmd, int status);
 struct nvme_ctrl *nvme_ctrl_from_file(struct file *file);
 struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 511c980d538d..71a9c1cc57f5 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -243,7 +243,7 @@ static void nvmet_passthru_execute_cmd_work(struct work_struct *w)
 	blk_mq_free_request(rq);
 
 	if (effects)
-		nvme_passthru_end(ctrl, effects, req->cmd, status);
+		nvme_passthru_end(ctrl, ns, effects, req->cmd, status);
 }
 
 static enum rq_end_io_ret nvmet_passthru_req_done(struct request *rq,
diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index f33370b75628..e961424ed7d9 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -489,7 +489,10 @@ struct hv_pcibus_device {
 	struct fwnode_handle *fwnode;
 	/* Protocol version negotiated with the host */
 	enum pci_protocol_version_t protocol_version;
+
+	struct mutex state_lock;
 	enum hv_pcibus_state state;
+
 	struct hv_device *hdev;
 	resource_size_t low_mmio_space;
 	resource_size_t high_mmio_space;
@@ -553,19 +556,10 @@ struct hv_dr_state {
 	struct hv_pcidev_description func[];
 };
 
-enum hv_pcichild_state {
-	hv_pcichild_init = 0,
-	hv_pcichild_requirements,
-	hv_pcichild_resourced,
-	hv_pcichild_ejecting,
-	hv_pcichild_maximum
-};
-
 struct hv_pci_dev {
 	/* List protected by pci_rescan_remove_lock */
 	struct list_head list_entry;
 	refcount_t refs;
-	enum hv_pcichild_state state;
 	struct pci_slot *pci_slot;
 	struct hv_pcidev_description desc;
 	bool reported_missing;
@@ -643,6 +637,11 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 	pbus = pdev->bus;
 	hbus = container_of(pbus->sysdata, struct hv_pcibus_device, sysdata);
 	int_desc = data->chip_data;
+	if (!int_desc) {
+		dev_warn(&hbus->hdev->device, "%s() can not unmask irq %u\n",
+			 __func__, data->irq);
+		return;
+	}
 
 	spin_lock_irqsave(&hbus->retarget_msi_interrupt_lock, flags);
 
@@ -1911,12 +1910,6 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 		hv_pci_onchannelcallback(hbus);
 		spin_unlock_irqrestore(&channel->sched_lock, flags);
 
-		if (hpdev->state == hv_pcichild_ejecting) {
-			dev_err_once(&hbus->hdev->device,
-				     "the device is being ejected\n");
-			goto enable_tasklet;
-		}
-
 		udelay(100);
 	}
 
@@ -2522,6 +2515,8 @@ static void pci_devices_present_work(struct work_struct *work)
 	if (!dr)
 		return;
 
+	mutex_lock(&hbus->state_lock);
+
 	/* First, mark all existing children as reported missing. */
 	spin_lock_irqsave(&hbus->device_list_lock, flags);
 	list_for_each_entry(hpdev, &hbus->children, list_entry) {
@@ -2603,6 +2598,8 @@ static void pci_devices_present_work(struct work_struct *work)
 		break;
 	}
 
+	mutex_unlock(&hbus->state_lock);
+
 	kfree(dr);
 }
 
@@ -2751,7 +2748,7 @@ static void hv_eject_device_work(struct work_struct *work)
 	hpdev = container_of(work, struct hv_pci_dev, wrk);
 	hbus = hpdev->hbus;
 
-	WARN_ON(hpdev->state != hv_pcichild_ejecting);
+	mutex_lock(&hbus->state_lock);
 
 	/*
 	 * Ejection can come before or after the PCI bus has been set up, so
@@ -2789,6 +2786,8 @@ static void hv_eject_device_work(struct work_struct *work)
 	put_pcichild(hpdev);
 	put_pcichild(hpdev);
 	/* hpdev has been freed. Do not use it any more. */
+
+	mutex_unlock(&hbus->state_lock);
 }
 
 /**
@@ -2809,7 +2808,6 @@ static void hv_pci_eject_device(struct hv_pci_dev *hpdev)
 		return;
 	}
 
-	hpdev->state = hv_pcichild_ejecting;
 	get_pcichild(hpdev);
 	INIT_WORK(&hpdev->wrk, hv_eject_device_work);
 	queue_work(hbus->wq, &hpdev->wrk);
@@ -3238,8 +3236,10 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	struct pci_bus_d0_entry *d0_entry;
 	struct hv_pci_compl comp_pkt;
 	struct pci_packet *pkt;
+	bool retry = true;
 	int ret;
 
+enter_d0_retry:
 	/*
 	 * Tell the host that the bus is ready to use, and moved into the
 	 * powered-on state.  This includes telling the host which region
@@ -3266,6 +3266,38 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
 	if (ret)
 		goto exit;
 
+	/*
+	 * In certain case (Kdump) the pci device of interest was
+	 * not cleanly shut down and resource is still held on host
+	 * side, the host could return invalid device status.
+	 * We need to explicitly request host to release the resource
+	 * and try to enter D0 again.
+	 */
+	if (comp_pkt.completion_status < 0 && retry) {
+		retry = false;
+
+		dev_err(&hdev->device, "Retrying D0 Entry\n");
+
+		/*
+		 * Hv_pci_bus_exit() calls hv_send_resource_released()
+		 * to free up resources of its child devices.
+		 * In the kdump kernel we need to set the
+		 * wslot_res_allocated to 255 so it scans all child
+		 * devices to release resources allocated in the
+		 * normal kernel before panic happened.
+		 */
+		hbus->wslot_res_allocated = 255;
+
+		ret = hv_pci_bus_exit(hdev, true);
+
+		if (ret == 0) {
+			kfree(pkt);
+			goto enter_d0_retry;
+		}
+		dev_err(&hdev->device,
+			"Retrying D0 failed with ret %d\n", ret);
+	}
+
 	if (comp_pkt.completion_status < 0) {
 		dev_err(&hdev->device,
 			"PCI Pass-through VSP failed D0 Entry with status %x\n",
@@ -3308,6 +3340,24 @@ static int hv_pci_query_relations(struct hv_device *hdev)
 	if (!ret)
 		ret = wait_for_response(hdev, &comp);
 
+	/*
+	 * In the case of fast device addition/removal, it's possible that
+	 * vmbus_sendpacket() or wait_for_response() returns -ENODEV but we
+	 * already got a PCI_BUS_RELATIONS* message from the host and the
+	 * channel callback already scheduled a work to hbus->wq, which can be
+	 * running pci_devices_present_work() -> survey_child_resources() ->
+	 * complete(&hbus->survey_event), even after hv_pci_query_relations()
+	 * exits and the stack variable 'comp' is no longer valid; as a result,
+	 * a hang or a page fault may happen when the complete() calls
+	 * raw_spin_lock_irqsave(). Flush hbus->wq before we exit from
+	 * hv_pci_query_relations() to avoid the issues. Note: if 'ret' is
+	 * -ENODEV, there can't be any more work item scheduled to hbus->wq
+	 * after the flush_workqueue(): see vmbus_onoffer_rescind() ->
+	 * vmbus_reset_channel_cb(), vmbus_rescind_cleanup() ->
+	 * channel->rescind = true.
+	 */
+	flush_workqueue(hbus->wq);
+
 	return ret;
 }
 
@@ -3493,7 +3543,6 @@ static int hv_pci_probe(struct hv_device *hdev,
 	struct hv_pcibus_device *hbus;
 	u16 dom_req, dom;
 	char *name;
-	bool enter_d0_retry = true;
 	int ret;
 
 	/*
@@ -3529,6 +3578,7 @@ static int hv_pci_probe(struct hv_device *hdev,
 		return -ENOMEM;
 
 	hbus->bridge = bridge;
+	mutex_init(&hbus->state_lock);
 	hbus->state = hv_pcibus_init;
 	hbus->wslot_res_allocated = -1;
 
@@ -3633,49 +3683,15 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (ret)
 		goto free_fwnode;
 
-retry:
 	ret = hv_pci_query_relations(hdev);
 	if (ret)
 		goto free_irq_domain;
 
-	ret = hv_pci_enter_d0(hdev);
-	/*
-	 * In certain case (Kdump) the pci device of interest was
-	 * not cleanly shut down and resource is still held on host
-	 * side, the host could return invalid device status.
-	 * We need to explicitly request host to release the resource
-	 * and try to enter D0 again.
-	 * Since the hv_pci_bus_exit() call releases structures
-	 * of all its child devices, we need to start the retry from
-	 * hv_pci_query_relations() call, requesting host to send
-	 * the synchronous child device relations message before this
-	 * information is needed in hv_send_resources_allocated()
-	 * call later.
-	 */
-	if (ret == -EPROTO && enter_d0_retry) {
-		enter_d0_retry = false;
-
-		dev_err(&hdev->device, "Retrying D0 Entry\n");
-
-		/*
-		 * Hv_pci_bus_exit() calls hv_send_resources_released()
-		 * to free up resources of its child devices.
-		 * In the kdump kernel we need to set the
-		 * wslot_res_allocated to 255 so it scans all child
-		 * devices to release resources allocated in the
-		 * normal kernel before panic happened.
-		 */
-		hbus->wslot_res_allocated = 255;
-		ret = hv_pci_bus_exit(hdev, true);
-
-		if (ret == 0)
-			goto retry;
+	mutex_lock(&hbus->state_lock);
 
-		dev_err(&hdev->device,
-			"Retrying D0 failed with ret %d\n", ret);
-	}
+	ret = hv_pci_enter_d0(hdev);
 	if (ret)
-		goto free_irq_domain;
+		goto release_state_lock;
 
 	ret = hv_pci_allocate_bridge_windows(hbus);
 	if (ret)
@@ -3693,12 +3709,15 @@ static int hv_pci_probe(struct hv_device *hdev,
 	if (ret)
 		goto free_windows;
 
+	mutex_unlock(&hbus->state_lock);
 	return 0;
 
 free_windows:
 	hv_pci_free_bridge_windows(hbus);
 exit_d0:
 	(void) hv_pci_bus_exit(hdev, true);
+release_state_lock:
+	mutex_unlock(&hbus->state_lock);
 free_irq_domain:
 	irq_domain_remove(hbus->irq_domain);
 free_fwnode:
@@ -3948,20 +3967,26 @@ static int hv_pci_resume(struct hv_device *hdev)
 	if (ret)
 		goto out;
 
+	mutex_lock(&hbus->state_lock);
+
 	ret = hv_pci_enter_d0(hdev);
 	if (ret)
-		goto out;
+		goto release_state_lock;
 
 	ret = hv_send_resources_allocated(hdev);
 	if (ret)
-		goto out;
+		goto release_state_lock;
 
 	prepopulate_bars(hbus);
 
 	hv_pci_restore_msi_state(hbus);
 
 	hbus->state = hv_pcibus_installed;
+	mutex_unlock(&hbus->state_lock);
 	return 0;
+
+release_state_lock:
+	mutex_unlock(&hbus->state_lock);
 out:
 	vmbus_close(hdev->channel);
 	return ret;
diff --git a/drivers/platform/x86/amd/pmf/core.c b/drivers/platform/x86/amd/pmf/core.c
index dc9803e1a4b9..73d2357e32f8 100644
--- a/drivers/platform/x86/amd/pmf/core.c
+++ b/drivers/platform/x86/amd/pmf/core.c
@@ -297,6 +297,8 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 	/* Enable Static Slider */
 	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
 		amd_pmf_init_sps(dev);
+		dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
+		power_supply_reg_notifier(&dev->pwr_src_notifier);
 		dev_dbg(dev->dev, "SPS enabled and Platform Profiles registered\n");
 	}
 
@@ -315,8 +317,10 @@ static void amd_pmf_init_features(struct amd_pmf_dev *dev)
 
 static void amd_pmf_deinit_features(struct amd_pmf_dev *dev)
 {
-	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR))
+	if (is_apmf_func_supported(dev, APMF_FUNC_STATIC_SLIDER_GRANULAR)) {
+		power_supply_unreg_notifier(&dev->pwr_src_notifier);
 		amd_pmf_deinit_sps(dev);
+	}
 
 	if (is_apmf_func_supported(dev, APMF_FUNC_AUTO_MODE)) {
 		amd_pmf_deinit_auto_mode(dev);
@@ -399,9 +403,6 @@ static int amd_pmf_probe(struct platform_device *pdev)
 	apmf_install_handler(dev);
 	amd_pmf_dbgfs_register(dev);
 
-	dev->pwr_src_notifier.notifier_call = amd_pmf_pwr_src_notify_call;
-	power_supply_reg_notifier(&dev->pwr_src_notifier);
-
 	dev_info(dev->dev, "registered PMF device successfully\n");
 
 	return 0;
@@ -411,7 +412,6 @@ static int amd_pmf_remove(struct platform_device *pdev)
 {
 	struct amd_pmf_dev *dev = platform_get_drvdata(pdev);
 
-	power_supply_unreg_notifier(&dev->pwr_src_notifier);
 	amd_pmf_deinit_features(dev);
 	apmf_acpi_deinit(dev);
 	amd_pmf_dbgfs_unregister(dev);
diff --git a/drivers/platform/x86/intel/int3472/clk_and_regulator.c b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
index 1086c3d83494..399f0623ca1b 100644
--- a/drivers/platform/x86/intel/int3472/clk_and_regulator.c
+++ b/drivers/platform/x86/intel/int3472/clk_and_regulator.c
@@ -101,9 +101,11 @@ int skl_int3472_register_clock(struct int3472_discrete_device *int3472,
 
 	int3472->clock.ena_gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
 							     "int3472,clk-enable");
-	if (IS_ERR(int3472->clock.ena_gpio))
-		return dev_err_probe(int3472->dev, PTR_ERR(int3472->clock.ena_gpio),
-				     "getting clk-enable GPIO\n");
+	if (IS_ERR(int3472->clock.ena_gpio)) {
+		ret = PTR_ERR(int3472->clock.ena_gpio);
+		int3472->clock.ena_gpio = NULL;
+		return dev_err_probe(int3472->dev, ret, "getting clk-enable GPIO\n");
+	}
 
 	if (polarity == GPIO_ACTIVE_LOW)
 		gpiod_toggle_active_low(int3472->clock.ena_gpio);
@@ -199,8 +201,9 @@ int skl_int3472_register_regulator(struct int3472_discrete_device *int3472,
 	int3472->regulator.gpio = acpi_get_and_request_gpiod(path, agpio->pin_table[0],
 							     "int3472,regulator");
 	if (IS_ERR(int3472->regulator.gpio)) {
-		dev_err(int3472->dev, "Failed to get regulator GPIO line\n");
-		return PTR_ERR(int3472->regulator.gpio);
+		ret = PTR_ERR(int3472->regulator.gpio);
+		int3472->regulator.gpio = NULL;
+		return dev_err_probe(int3472->dev, ret, "getting regulator GPIO\n");
 	}
 
 	/* Ensure the pin is in output mode and non-active state */
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index d5c43e9b5128..c0d620ffea61 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -1376,6 +1376,7 @@ void ccw_device_set_notoper(struct ccw_device *cdev)
 enum io_sch_action {
 	IO_SCH_UNREG,
 	IO_SCH_ORPH_UNREG,
+	IO_SCH_UNREG_CDEV,
 	IO_SCH_ATTACH,
 	IO_SCH_UNREG_ATTACH,
 	IO_SCH_ORPH_ATTACH,
@@ -1408,7 +1409,7 @@ static enum io_sch_action sch_get_action(struct subchannel *sch)
 	}
 	if ((sch->schib.pmcw.pam & sch->opm) == 0) {
 		if (ccw_device_notify(cdev, CIO_NO_PATH) != NOTIFY_OK)
-			return IO_SCH_UNREG;
+			return IO_SCH_UNREG_CDEV;
 		return IO_SCH_DISC;
 	}
 	if (device_is_disconnected(cdev))
@@ -1470,6 +1471,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 	case IO_SCH_ORPH_ATTACH:
 		ccw_device_set_disconnected(cdev);
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 	case IO_SCH_UNREG:
 		if (!cdev)
@@ -1503,6 +1505,7 @@ static int io_subchannel_sch_event(struct subchannel *sch, int process)
 		if (rc)
 			goto out;
 		break;
+	case IO_SCH_UNREG_CDEV:
 	case IO_SCH_UNREG_ATTACH:
 		spin_lock_irqsave(sch->lock, flags);
 		sch_set_cdev(sch, NULL);
diff --git a/drivers/soundwire/dmi-quirks.c b/drivers/soundwire/dmi-quirks.c
index 58ea013fa918..2a1096dab63d 100644
--- a/drivers/soundwire/dmi-quirks.c
+++ b/drivers/soundwire/dmi-quirks.c
@@ -99,6 +99,13 @@ static const struct dmi_system_id adr_remap_quirk_table[] = {
 		},
 		.driver_data = (void *)intel_tgl_bios,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8709"),
+		},
+		.driver_data = (void *)intel_tgl_bios,
+	},
 	{
 		/* quirk used for NUC15 'Bishop County' LAPBC510 and LAPBC710 skews */
 		.matches = {
diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 30575ed20947..0dcdbd4e1ec3 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -1098,8 +1098,10 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 	}
 
 	sruntime = sdw_alloc_stream(dai->name);
-	if (!sruntime)
-		return -ENOMEM;
+	if (!sruntime) {
+		ret = -ENOMEM;
+		goto err_alloc;
+	}
 
 	ctrl->sruntime[dai->id] = sruntime;
 
@@ -1109,12 +1111,19 @@ static int qcom_swrm_startup(struct snd_pcm_substream *substream,
 		if (ret < 0 && ret != -ENOTSUPP) {
 			dev_err(dai->dev, "Failed to set sdw stream on %s\n",
 				codec_dai->name);
-			sdw_release_stream(sruntime);
-			return ret;
+			goto err_set_stream;
 		}
 	}
 
 	return 0;
+
+err_set_stream:
+	sdw_release_stream(sruntime);
+err_alloc:
+	pm_runtime_mark_last_busy(ctrl->dev);
+	pm_runtime_put_autosuspend(ctrl->dev);
+
+	return ret;
 }
 
 static void qcom_swrm_shutdown(struct snd_pcm_substream *substream,
diff --git a/drivers/spi/spi-fsl-lpspi.c b/drivers/spi/spi-fsl-lpspi.c
index 34488de55587..457fe6bc7e41 100644
--- a/drivers/spi/spi-fsl-lpspi.c
+++ b/drivers/spi/spi-fsl-lpspi.c
@@ -910,9 +910,14 @@ static int fsl_lpspi_probe(struct platform_device *pdev)
 	ret = fsl_lpspi_dma_init(&pdev->dev, fsl_lpspi, controller);
 	if (ret == -EPROBE_DEFER)
 		goto out_pm_get;
-
 	if (ret < 0)
 		dev_err(&pdev->dev, "dma setup error %d, use pio\n", ret);
+	else
+		/*
+		 * disable LPSPI module IRQ when enable DMA mode successfully,
+		 * to prevent the unexpected LPSPI module IRQ events.
+		 */
+		disable_irq(irq);
 
 	ret = devm_spi_register_controller(&pdev->dev, controller);
 	if (ret < 0) {
diff --git a/drivers/spi/spi-geni-qcom.c b/drivers/spi/spi-geni-qcom.c
index b106faf21a72..baf477383682 100644
--- a/drivers/spi/spi-geni-qcom.c
+++ b/drivers/spi/spi-geni-qcom.c
@@ -646,6 +646,8 @@ static int spi_geni_init(struct spi_geni_master *mas)
 			geni_se_select_mode(se, GENI_GPI_DMA);
 			dev_dbg(mas->dev, "Using GPI DMA mode for SPI\n");
 			break;
+		} else if (ret == -EPROBE_DEFER) {
+			goto out_pm;
 		}
 		/*
 		 * in case of failure to get gpi dma channel, we can still do the
diff --git a/drivers/target/iscsi/iscsi_target.c b/drivers/target/iscsi/iscsi_target.c
index 07e196b44b91..c70ce1fa399f 100644
--- a/drivers/target/iscsi/iscsi_target.c
+++ b/drivers/target/iscsi/iscsi_target.c
@@ -363,8 +363,6 @@ struct iscsi_np *iscsit_add_np(
 	init_completion(&np->np_restart_comp);
 	INIT_LIST_HEAD(&np->np_list);
 
-	timer_setup(&np->np_login_timer, iscsi_handle_login_thread_timeout, 0);
-
 	ret = iscsi_target_setup_login_socket(np, sockaddr);
 	if (ret != 0) {
 		kfree(np);
diff --git a/drivers/target/iscsi/iscsi_target_login.c b/drivers/target/iscsi/iscsi_target_login.c
index 274bdd7845ca..90b870f234f0 100644
--- a/drivers/target/iscsi/iscsi_target_login.c
+++ b/drivers/target/iscsi/iscsi_target_login.c
@@ -811,59 +811,6 @@ void iscsi_post_login_handler(
 	iscsit_dec_conn_usage_count(conn);
 }
 
-void iscsi_handle_login_thread_timeout(struct timer_list *t)
-{
-	struct iscsi_np *np = from_timer(np, t, np_login_timer);
-
-	spin_lock_bh(&np->np_thread_lock);
-	pr_err("iSCSI Login timeout on Network Portal %pISpc\n",
-			&np->np_sockaddr);
-
-	if (np->np_login_timer_flags & ISCSI_TF_STOP) {
-		spin_unlock_bh(&np->np_thread_lock);
-		return;
-	}
-
-	if (np->np_thread)
-		send_sig(SIGINT, np->np_thread, 1);
-
-	np->np_login_timer_flags &= ~ISCSI_TF_RUNNING;
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
-static void iscsi_start_login_thread_timer(struct iscsi_np *np)
-{
-	/*
-	 * This used the TA_LOGIN_TIMEOUT constant because at this
-	 * point we do not have access to ISCSI_TPG_ATTRIB(tpg)->login_timeout
-	 */
-	spin_lock_bh(&np->np_thread_lock);
-	np->np_login_timer_flags &= ~ISCSI_TF_STOP;
-	np->np_login_timer_flags |= ISCSI_TF_RUNNING;
-	mod_timer(&np->np_login_timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
-
-	pr_debug("Added timeout timer to iSCSI login request for"
-			" %u seconds.\n", TA_LOGIN_TIMEOUT);
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
-static void iscsi_stop_login_thread_timer(struct iscsi_np *np)
-{
-	spin_lock_bh(&np->np_thread_lock);
-	if (!(np->np_login_timer_flags & ISCSI_TF_RUNNING)) {
-		spin_unlock_bh(&np->np_thread_lock);
-		return;
-	}
-	np->np_login_timer_flags |= ISCSI_TF_STOP;
-	spin_unlock_bh(&np->np_thread_lock);
-
-	del_timer_sync(&np->np_login_timer);
-
-	spin_lock_bh(&np->np_thread_lock);
-	np->np_login_timer_flags &= ~ISCSI_TF_RUNNING;
-	spin_unlock_bh(&np->np_thread_lock);
-}
-
 int iscsit_setup_np(
 	struct iscsi_np *np,
 	struct sockaddr_storage *sockaddr)
@@ -1123,10 +1070,13 @@ static struct iscsit_conn *iscsit_alloc_conn(struct iscsi_np *np)
 	spin_lock_init(&conn->nopin_timer_lock);
 	spin_lock_init(&conn->response_queue_lock);
 	spin_lock_init(&conn->state_lock);
+	spin_lock_init(&conn->login_worker_lock);
+	spin_lock_init(&conn->login_timer_lock);
 
 	timer_setup(&conn->nopin_response_timer,
 		    iscsit_handle_nopin_response_timeout, 0);
 	timer_setup(&conn->nopin_timer, iscsit_handle_nopin_timeout, 0);
+	timer_setup(&conn->login_timer, iscsit_login_timeout, 0);
 
 	if (iscsit_conn_set_transport(conn, np->np_transport) < 0)
 		goto free_conn;
@@ -1304,7 +1254,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 		goto new_sess_out;
 	}
 
-	iscsi_start_login_thread_timer(np);
+	iscsit_start_login_timer(conn, current);
 
 	pr_debug("Moving to TARG_CONN_STATE_XPT_UP.\n");
 	conn->conn_state = TARG_CONN_STATE_XPT_UP;
@@ -1417,8 +1367,6 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 	if (ret < 0)
 		goto new_sess_out;
 
-	iscsi_stop_login_thread_timer(np);
-
 	if (ret == 1) {
 		tpg_np = conn->tpg_np;
 
@@ -1434,7 +1382,7 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 new_sess_out:
 	new_sess = true;
 old_sess_out:
-	iscsi_stop_login_thread_timer(np);
+	iscsit_stop_login_timer(conn);
 	tpg_np = conn->tpg_np;
 	iscsi_target_login_sess_out(conn, zero_tsih, new_sess);
 	new_sess = false;
@@ -1448,7 +1396,6 @@ static int __iscsi_target_login_thread(struct iscsi_np *np)
 	return 1;
 
 exit:
-	iscsi_stop_login_thread_timer(np);
 	spin_lock_bh(&np->np_thread_lock);
 	np->np_thread_state = ISCSI_NP_THREAD_EXIT;
 	spin_unlock_bh(&np->np_thread_lock);
diff --git a/drivers/target/iscsi/iscsi_target_nego.c b/drivers/target/iscsi/iscsi_target_nego.c
index 24040c118e49..fa3fb5f4e6bc 100644
--- a/drivers/target/iscsi/iscsi_target_nego.c
+++ b/drivers/target/iscsi/iscsi_target_nego.c
@@ -535,25 +535,6 @@ static void iscsi_target_login_drop(struct iscsit_conn *conn, struct iscsi_login
 	iscsi_target_login_sess_out(conn, zero_tsih, true);
 }
 
-struct conn_timeout {
-	struct timer_list timer;
-	struct iscsit_conn *conn;
-};
-
-static void iscsi_target_login_timeout(struct timer_list *t)
-{
-	struct conn_timeout *timeout = from_timer(timeout, t, timer);
-	struct iscsit_conn *conn = timeout->conn;
-
-	pr_debug("Entering iscsi_target_login_timeout >>>>>>>>>>>>>>>>>>>\n");
-
-	if (conn->login_kworker) {
-		pr_debug("Sending SIGINT to conn->login_kworker %s/%d\n",
-			 conn->login_kworker->comm, conn->login_kworker->pid);
-		send_sig(SIGINT, conn->login_kworker, 1);
-	}
-}
-
 static void iscsi_target_do_login_rx(struct work_struct *work)
 {
 	struct iscsit_conn *conn = container_of(work,
@@ -562,12 +543,15 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 	struct iscsi_np *np = login->np;
 	struct iscsi_portal_group *tpg = conn->tpg;
 	struct iscsi_tpg_np *tpg_np = conn->tpg_np;
-	struct conn_timeout timeout;
 	int rc, zero_tsih = login->zero_tsih;
 	bool state;
 
 	pr_debug("entering iscsi_target_do_login_rx, conn: %p, %s:%d\n",
 			conn, current->comm, current->pid);
+
+	spin_lock(&conn->login_worker_lock);
+	set_bit(LOGIN_FLAGS_WORKER_RUNNING, &conn->login_flags);
+	spin_unlock(&conn->login_worker_lock);
 	/*
 	 * If iscsi_target_do_login_rx() has been invoked by ->sk_data_ready()
 	 * before initial PDU processing in iscsi_target_start_negotiation()
@@ -597,19 +581,16 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 		goto err;
 	}
 
-	conn->login_kworker = current;
 	allow_signal(SIGINT);
-
-	timeout.conn = conn;
-	timer_setup_on_stack(&timeout.timer, iscsi_target_login_timeout, 0);
-	mod_timer(&timeout.timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
-	pr_debug("Starting login timer for %s/%d\n", current->comm, current->pid);
+	rc = iscsit_set_login_timer_kworker(conn, current);
+	if (rc < 0) {
+		/* The login timer has already expired */
+		pr_debug("iscsi_target_do_login_rx, login failed\n");
+		goto err;
+	}
 
 	rc = conn->conn_transport->iscsit_get_login_rx(conn, login);
-	del_timer_sync(&timeout.timer);
-	destroy_timer_on_stack(&timeout.timer);
 	flush_signals(current);
-	conn->login_kworker = NULL;
 
 	if (rc < 0)
 		goto err;
@@ -646,7 +627,17 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 		if (iscsi_target_sk_check_and_clear(conn,
 						    LOGIN_FLAGS_WRITE_ACTIVE))
 			goto err;
+
+		/*
+		 * Set the login timer thread pointer to NULL to prevent the
+		 * login process from getting stuck if the initiator
+		 * stops sending data.
+		 */
+		rc = iscsit_set_login_timer_kworker(conn, NULL);
+		if (rc < 0)
+			goto err;
 	} else if (rc == 1) {
+		iscsit_stop_login_timer(conn);
 		cancel_delayed_work(&conn->login_work);
 		iscsi_target_nego_release(conn);
 		iscsi_post_login_handler(np, conn, zero_tsih);
@@ -656,6 +647,7 @@ static void iscsi_target_do_login_rx(struct work_struct *work)
 
 err:
 	iscsi_target_restore_sock_callbacks(conn);
+	iscsit_stop_login_timer(conn);
 	cancel_delayed_work(&conn->login_work);
 	iscsi_target_login_drop(conn, login);
 	iscsit_deaccess_np(np, tpg, tpg_np);
@@ -1130,6 +1122,7 @@ int iscsi_target_locate_portal(
 	iscsi_target_set_sock_callbacks(conn);
 
 	login->np = np;
+	conn->tpg = NULL;
 
 	login_req = (struct iscsi_login_req *) login->req;
 	payload_length = ntoh24(login_req->dlength);
@@ -1197,7 +1190,6 @@ int iscsi_target_locate_portal(
 	 */
 	sessiontype = strncmp(s_buf, DISCOVERY, 9);
 	if (!sessiontype) {
-		conn->tpg = iscsit_global->discovery_tpg;
 		if (!login->leading_connection)
 			goto get_target;
 
@@ -1214,9 +1206,11 @@ int iscsi_target_locate_portal(
 		 * Serialize access across the discovery struct iscsi_portal_group to
 		 * process login attempt.
 		 */
+		conn->tpg = iscsit_global->discovery_tpg;
 		if (iscsit_access_np(np, conn->tpg) < 0) {
 			iscsit_tx_login_rsp(conn, ISCSI_STATUS_CLS_TARGET_ERR,
 				ISCSI_LOGIN_STATUS_SVC_UNAVAILABLE);
+			conn->tpg = NULL;
 			ret = -1;
 			goto out;
 		}
@@ -1368,14 +1362,30 @@ int iscsi_target_start_negotiation(
 	 * and perform connection cleanup now.
 	 */
 	ret = iscsi_target_do_login(conn, login);
-	if (!ret && iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_INITIAL_PDU))
-		ret = -1;
+	if (!ret) {
+		spin_lock(&conn->login_worker_lock);
+
+		if (iscsi_target_sk_check_and_clear(conn, LOGIN_FLAGS_INITIAL_PDU))
+			ret = -1;
+		else if (!test_bit(LOGIN_FLAGS_WORKER_RUNNING, &conn->login_flags)) {
+			if (iscsit_set_login_timer_kworker(conn, NULL) < 0) {
+				/*
+				 * The timeout has expired already.
+				 * Schedule login_work to perform the cleanup.
+				 */
+				schedule_delayed_work(&conn->login_work, 0);
+			}
+		}
+
+		spin_unlock(&conn->login_worker_lock);
+	}
 
 	if (ret < 0) {
 		iscsi_target_restore_sock_callbacks(conn);
 		iscsi_remove_failed_auth_entry(conn);
 	}
 	if (ret != 0) {
+		iscsit_stop_login_timer(conn);
 		cancel_delayed_work_sync(&conn->login_work);
 		iscsi_target_nego_release(conn);
 	}
diff --git a/drivers/target/iscsi/iscsi_target_util.c b/drivers/target/iscsi/iscsi_target_util.c
index 26dc8ed3045b..b14835fcb033 100644
--- a/drivers/target/iscsi/iscsi_target_util.c
+++ b/drivers/target/iscsi/iscsi_target_util.c
@@ -1040,6 +1040,57 @@ void iscsit_stop_nopin_timer(struct iscsit_conn *conn)
 	spin_unlock_bh(&conn->nopin_timer_lock);
 }
 
+void iscsit_login_timeout(struct timer_list *t)
+{
+	struct iscsit_conn *conn = from_timer(conn, t, login_timer);
+	struct iscsi_login *login = conn->login;
+
+	pr_debug("Entering iscsi_target_login_timeout >>>>>>>>>>>>>>>>>>>\n");
+
+	spin_lock_bh(&conn->login_timer_lock);
+	login->login_failed = 1;
+
+	if (conn->login_kworker) {
+		pr_debug("Sending SIGINT to conn->login_kworker %s/%d\n",
+			 conn->login_kworker->comm, conn->login_kworker->pid);
+		send_sig(SIGINT, conn->login_kworker, 1);
+	} else {
+		schedule_delayed_work(&conn->login_work, 0);
+	}
+	spin_unlock_bh(&conn->login_timer_lock);
+}
+
+void iscsit_start_login_timer(struct iscsit_conn *conn, struct task_struct *kthr)
+{
+	pr_debug("Login timer started\n");
+
+	conn->login_kworker = kthr;
+	mod_timer(&conn->login_timer, jiffies + TA_LOGIN_TIMEOUT * HZ);
+}
+
+int iscsit_set_login_timer_kworker(struct iscsit_conn *conn, struct task_struct *kthr)
+{
+	struct iscsi_login *login = conn->login;
+	int ret = 0;
+
+	spin_lock_bh(&conn->login_timer_lock);
+	if (login->login_failed) {
+		/* The timer has already expired */
+		ret = -1;
+	} else {
+		conn->login_kworker = kthr;
+	}
+	spin_unlock_bh(&conn->login_timer_lock);
+
+	return ret;
+}
+
+void iscsit_stop_login_timer(struct iscsit_conn *conn)
+{
+	pr_debug("Login timer stopped\n");
+	timer_delete_sync(&conn->login_timer);
+}
+
 int iscsit_send_tx_data(
 	struct iscsit_cmd *cmd,
 	struct iscsit_conn *conn,
diff --git a/drivers/target/iscsi/iscsi_target_util.h b/drivers/target/iscsi/iscsi_target_util.h
index 33ea799a0850..24b8e577575a 100644
--- a/drivers/target/iscsi/iscsi_target_util.h
+++ b/drivers/target/iscsi/iscsi_target_util.h
@@ -56,6 +56,10 @@ extern void iscsit_handle_nopin_timeout(struct timer_list *t);
 extern void __iscsit_start_nopin_timer(struct iscsit_conn *);
 extern void iscsit_start_nopin_timer(struct iscsit_conn *);
 extern void iscsit_stop_nopin_timer(struct iscsit_conn *);
+extern void iscsit_login_timeout(struct timer_list *t);
+extern void iscsit_start_login_timer(struct iscsit_conn *, struct task_struct *kthr);
+extern void iscsit_stop_login_timer(struct iscsit_conn *);
+extern int iscsit_set_login_timer_kworker(struct iscsit_conn *, struct task_struct *kthr);
 extern int iscsit_send_tx_data(struct iscsit_cmd *, struct iscsit_conn *, int);
 extern int iscsit_fe_sendpage_sg(struct iscsit_cmd *, struct iscsit_conn *);
 extern int iscsit_tx_login_rsp(struct iscsit_conn *, u8, u8);
diff --git a/drivers/thermal/intel/intel_soc_dts_iosf.c b/drivers/thermal/intel/intel_soc_dts_iosf.c
index 8c26f7b2316b..99b3c2ce4643 100644
--- a/drivers/thermal/intel/intel_soc_dts_iosf.c
+++ b/drivers/thermal/intel/intel_soc_dts_iosf.c
@@ -401,7 +401,7 @@ struct intel_soc_dts_sensors *intel_soc_dts_iosf_init(
 	spin_lock_init(&sensors->intr_notify_lock);
 	mutex_init(&sensors->dts_update_lock);
 	sensors->intr_type = intr_type;
-	sensors->tj_max = tj_max;
+	sensors->tj_max = tj_max * 1000;
 	if (intr_type == INTEL_SOC_DTS_INTERRUPT_NONE)
 		notification = false;
 	else
diff --git a/drivers/usb/gadget/udc/amd5536udc_pci.c b/drivers/usb/gadget/udc/amd5536udc_pci.c
index c80f9bd51b75..a36913ae31f9 100644
--- a/drivers/usb/gadget/udc/amd5536udc_pci.c
+++ b/drivers/usb/gadget/udc/amd5536udc_pci.c
@@ -170,6 +170,9 @@ static int udc_pci_probe(
 		retval = -ENODEV;
 		goto err_probe;
 	}
+
+	udc = dev;
+
 	return 0;
 
 err_probe:
diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
index 07181cd8d52e..ae2273196b0c 100644
--- a/drivers/vhost/net.c
+++ b/drivers/vhost/net.c
@@ -935,13 +935,18 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
 
 		err = sock->ops->sendmsg(sock, &msg, len);
 		if (unlikely(err < 0)) {
+			bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
+
 			if (zcopy_used) {
 				if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
 					vhost_net_ubuf_put(ubufs);
-				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
-					% UIO_MAXIOV;
+				if (retry)
+					nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
+						% UIO_MAXIOV;
+				else
+					vq->heads[ubuf->desc].len = VHOST_DMA_DONE_LEN;
 			}
-			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
+			if (retry) {
 				vhost_discard_vq_desc(vq, 1);
 				vhost_net_enable_vq(net, vq);
 				break;
diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
index 779fc4467716..22e6b23ac96f 100644
--- a/drivers/vhost/vdpa.c
+++ b/drivers/vhost/vdpa.c
@@ -385,7 +385,10 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 {
 	struct vdpa_device *vdpa = v->vdpa;
 	const struct vdpa_config_ops *ops = vdpa->config;
+	struct vhost_dev *d = &v->vdev;
+	u64 actual_features;
 	u64 features;
+	int i;
 
 	/*
 	 * It's not allowed to change the features after they have
@@ -400,6 +403,16 @@ static long vhost_vdpa_set_features(struct vhost_vdpa *v, u64 __user *featurep)
 	if (vdpa_set_features(vdpa, features))
 		return -EINVAL;
 
+	/* let the vqs know what has been configured */
+	actual_features = ops->get_driver_features(vdpa);
+	for (i = 0; i < d->nvqs; ++i) {
+		struct vhost_virtqueue *vq = d->vqs[i];
+
+		mutex_lock(&vq->mutex);
+		vq->acked_features = actual_features;
+		mutex_unlock(&vq->mutex);
+	}
+
 	return 0;
 }
 
diff --git a/fs/afs/write.c b/fs/afs/write.c
index 571f3b9a417e..ad46f4b3c0c8 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -731,6 +731,7 @@ static int afs_writepages_region(struct address_space *mapping,
 			 * (changing page->mapping to NULL), or even swizzled
 			 * back from swapper_space to tmpfs file mapping
 			 */
+try_again:
 			if (wbc->sync_mode != WB_SYNC_NONE) {
 				ret = folio_lock_killable(folio);
 				if (ret < 0) {
@@ -757,12 +758,14 @@ static int afs_writepages_region(struct address_space *mapping,
 #ifdef CONFIG_AFS_FSCACHE
 					folio_wait_fscache(folio);
 #endif
-				} else {
-					start += folio_size(folio);
+					goto try_again;
 				}
+
+				start += folio_size(folio);
 				if (wbc->sync_mode == WB_SYNC_NONE) {
 					if (skips >= 5 || need_resched()) {
 						*_next = start;
+						folio_batch_release(&fbatch);
 						_leave(" = 0 [%llx]", *_next);
 						return 0;
 					}
diff --git a/fs/btrfs/tree-log.c b/fs/btrfs/tree-log.c
index 200cea6e49e5..b91fa398b814 100644
--- a/fs/btrfs/tree-log.c
+++ b/fs/btrfs/tree-log.c
@@ -6163,7 +6163,7 @@ static int log_delayed_deletions_incremental(struct btrfs_trans_handle *trans,
 {
 	struct btrfs_root *log = inode->root->log_root;
 	const struct btrfs_delayed_item *curr;
-	u64 last_range_start;
+	u64 last_range_start = 0;
 	u64 last_range_end = 0;
 	struct btrfs_key key;
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 8e9a672320ab..1250d156619b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4086,16 +4086,17 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->status == TID_GOOD) {
+		spin_unlock(&tcon->tc_lock);
+		return 0;
+	}
+
 	if (tcon->status != TID_NEW &&
 	    tcon->status != TID_NEED_TCON) {
 		spin_unlock(&tcon->tc_lock);
 		return -EHOSTDOWN;
 	}
 
-	if (tcon->status == TID_GOOD) {
-		spin_unlock(&tcon->tc_lock);
-		return 0;
-	}
 	tcon->status = TID_IN_TCON;
 	spin_unlock(&tcon->tc_lock);
 
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index 2f93bf8c3325..2390b2fedd6a 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -575,16 +575,17 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->status == TID_GOOD) {
+		spin_unlock(&tcon->tc_lock);
+		return 0;
+	}
+
 	if (tcon->status != TID_NEW &&
 	    tcon->status != TID_NEED_TCON) {
 		spin_unlock(&tcon->tc_lock);
 		return -EHOSTDOWN;
 	}
 
-	if (tcon->status == TID_GOOD) {
-		spin_unlock(&tcon->tc_lock);
-		return 0;
-	}
 	tcon->status = TID_IN_TCON;
 	spin_unlock(&tcon->tc_lock);
 
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 02228a590cd5..a2a95cd113df 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3777,7 +3777,7 @@ SMB2_change_notify(const unsigned int xid, struct cifs_tcon *tcon,
 		if (*out_data == NULL) {
 			rc = -ENOMEM;
 			goto cnotify_exit;
-		} else
+		} else if (plen)
 			*plen = le32_to_cpu(smb_rsp->OutputBufferLength);
 	}
 
diff --git a/fs/gfs2/file.c b/fs/gfs2/file.c
index 300844f50dcd..cb62c8f07d1e 100644
--- a/fs/gfs2/file.c
+++ b/fs/gfs2/file.c
@@ -784,9 +784,13 @@ static inline bool should_fault_in_pages(struct iov_iter *i,
 	if (!user_backed_iter(i))
 		return false;
 
+	/*
+	 * Try to fault in multiple pages initially.  When that doesn't result
+	 * in any progress, fall back to a single page.
+	 */
 	size = PAGE_SIZE;
 	offs = offset_in_page(iocb->ki_pos);
-	if (*prev_count != count || !*window_size) {
+	if (*prev_count != count) {
 		size_t nr_dirtied;
 
 		nr_dirtied = max(current->nr_dirtied_pause -
@@ -870,6 +874,7 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	struct gfs2_inode *ip = GFS2_I(inode);
 	size_t prev_count = 0, window_size = 0;
 	size_t written = 0;
+	bool enough_retries;
 	ssize_t ret;
 
 	/*
@@ -913,11 +918,17 @@ static ssize_t gfs2_file_direct_write(struct kiocb *iocb, struct iov_iter *from,
 	if (ret > 0)
 		written = ret;
 
+	enough_retries = prev_count == iov_iter_count(from) &&
+			 window_size <= PAGE_SIZE;
 	if (should_fault_in_pages(from, iocb, &prev_count, &window_size)) {
 		gfs2_glock_dq(gh);
 		window_size -= fault_in_iov_iter_readable(from, window_size);
-		if (window_size)
-			goto retry;
+		if (window_size) {
+			if (!enough_retries)
+				goto retry;
+			/* fall back to buffered I/O */
+			ret = 0;
+		}
 	}
 out_unlock:
 	if (gfs2_holder_queued(gh))
diff --git a/fs/internal.h b/fs/internal.h
index dc4eb91a577a..071a7517f1a7 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -59,8 +59,6 @@ extern int finish_clean_context(struct fs_context *fc);
  */
 extern int filename_lookup(int dfd, struct filename *name, unsigned flags,
 			   struct path *path, struct path *root);
-extern int vfs_path_lookup(struct dentry *, struct vfsmount *,
-			   const char *, unsigned int, struct path *);
 int do_rmdir(int dfd, struct filename *name);
 int do_unlinkat(int dfd, struct filename *name);
 int may_linkat(struct mnt_idmap *idmap, const struct path *link);
diff --git a/fs/ksmbd/server.c b/fs/ksmbd/server.c
index dc76d7cf241f..14df83c20557 100644
--- a/fs/ksmbd/server.c
+++ b/fs/ksmbd/server.c
@@ -185,24 +185,31 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 		goto send;
 	}
 
-	if (conn->ops->check_user_session) {
-		rc = conn->ops->check_user_session(work);
-		if (rc < 0) {
-			command = conn->ops->get_cmd_val(work);
-			conn->ops->set_rsp_status(work,
-					STATUS_USER_SESSION_DELETED);
-			goto send;
-		} else if (rc > 0) {
-			rc = conn->ops->get_ksmbd_tcon(work);
+	do {
+		if (conn->ops->check_user_session) {
+			rc = conn->ops->check_user_session(work);
 			if (rc < 0) {
-				conn->ops->set_rsp_status(work,
-					STATUS_NETWORK_NAME_DELETED);
+				if (rc == -EINVAL)
+					conn->ops->set_rsp_status(work,
+						STATUS_INVALID_PARAMETER);
+				else
+					conn->ops->set_rsp_status(work,
+						STATUS_USER_SESSION_DELETED);
 				goto send;
+			} else if (rc > 0) {
+				rc = conn->ops->get_ksmbd_tcon(work);
+				if (rc < 0) {
+					if (rc == -EINVAL)
+						conn->ops->set_rsp_status(work,
+							STATUS_INVALID_PARAMETER);
+					else
+						conn->ops->set_rsp_status(work,
+							STATUS_NETWORK_NAME_DELETED);
+					goto send;
+				}
 			}
 		}
-	}
 
-	do {
 		rc = __process_request(work, conn, &command);
 		if (rc == SERVER_HANDLER_ABORT)
 			break;
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 0ffe663b7590..33b7e6c4ceff 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -351,9 +351,16 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	int command;
 	__u32 clc_len;  /* calculated length */
 	__u32 len = get_rfc1002_len(work->request_buf);
+	__u32 req_struct_size, next_cmd = le32_to_cpu(hdr->NextCommand);
 
-	if (le32_to_cpu(hdr->NextCommand) > 0)
-		len = le32_to_cpu(hdr->NextCommand);
+	if ((u64)work->next_smb2_rcv_hdr_off + next_cmd > len) {
+		pr_err("next command(%u) offset exceeds smb msg size\n",
+				next_cmd);
+		return 1;
+	}
+
+	if (next_cmd > 0)
+		len = next_cmd;
 	else if (work->next_smb2_rcv_hdr_off)
 		len -= work->next_smb2_rcv_hdr_off;
 
@@ -373,17 +380,9 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	}
 
 	if (smb2_req_struct_sizes[command] != pdu->StructureSize2) {
-		if (command != SMB2_OPLOCK_BREAK_HE &&
-		    (hdr->Status == 0 || pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2_LE)) {
-			/* error packets have 9 byte structure size */
-			ksmbd_debug(SMB,
-				    "Illegal request size %u for command %d\n",
-				    le16_to_cpu(pdu->StructureSize2), command);
-			return 1;
-		} else if (command == SMB2_OPLOCK_BREAK_HE &&
-			   hdr->Status == 0 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
-			   le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
+		if (command == SMB2_OPLOCK_BREAK_HE &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_20 &&
+		    le16_to_cpu(pdu->StructureSize2) != OP_BREAK_STRUCT_SIZE_21) {
 			/* special case for SMB2.1 lease break message */
 			ksmbd_debug(SMB,
 				    "Illegal request size %d for oplock break\n",
@@ -392,6 +391,14 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 		}
 	}
 
+	req_struct_size = le16_to_cpu(pdu->StructureSize2) +
+		__SMB2_HEADER_STRUCTURE_SIZE;
+	if (command == SMB2_LOCK_HE)
+		req_struct_size -= sizeof(struct smb2_lock_element);
+
+	if (req_struct_size > len + 1)
+		return 1;
+
 	if (smb2_calc_size(hdr, &clc_len))
 		return 1;
 
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 85783112e56a..9610b8a884d0 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -91,7 +91,6 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	int tree_id;
 
-	work->tcon = NULL;
 	if (cmd == SMB2_TREE_CONNECT_HE ||
 	    cmd ==  SMB2_CANCEL_HE ||
 	    cmd ==  SMB2_LOGOFF_HE) {
@@ -105,10 +104,28 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 	}
 
 	tree_id = le32_to_cpu(req_hdr->Id.SyncId.TreeId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate tree id in header with work->tcon->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->tcon) {
+			pr_err("The first operation in the compound does not have tcon\n");
+			return -EINVAL;
+		}
+		if (work->tcon->id != tree_id) {
+			pr_err("tree id(%u) is different with id(%u) in first operation\n",
+					tree_id, work->tcon->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	work->tcon = ksmbd_tree_conn_lookup(work->sess, tree_id);
 	if (!work->tcon) {
 		pr_err("Invalid tid %d\n", tree_id);
-		return -EINVAL;
+		return -ENOENT;
 	}
 
 	return 1;
@@ -547,7 +564,6 @@ int smb2_check_user_session(struct ksmbd_work *work)
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
 
-	work->sess = NULL;
 	/*
 	 * SMB2_ECHO, SMB2_NEGOTIATE, SMB2_SESSION_SETUP command do not
 	 * require a session id, so no need to validate user session's for
@@ -558,15 +574,33 @@ int smb2_check_user_session(struct ksmbd_work *work)
 		return 0;
 
 	if (!ksmbd_conn_good(conn))
-		return -EINVAL;
+		return -EIO;
 
 	sess_id = le64_to_cpu(req_hdr->SessionId);
+
+	/*
+	 * If request is not the first in Compound request,
+	 * Just validate session id in header with work->sess->id.
+	 */
+	if (work->next_smb2_rcv_hdr_off) {
+		if (!work->sess) {
+			pr_err("The first operation in the compound does not have sess\n");
+			return -EINVAL;
+		}
+		if (work->sess->id != sess_id) {
+			pr_err("session id(%llu) is different with the first operation(%lld)\n",
+					sess_id, work->sess->id);
+			return -EINVAL;
+		}
+		return 1;
+	}
+
 	/* Check for validity of user session */
 	work->sess = ksmbd_session_lookup_all(conn, sess_id);
 	if (work->sess)
 		return 1;
 	ksmbd_debug(SMB, "Invalid user session, Uid %llu\n", sess_id);
-	return -EINVAL;
+	return -ENOENT;
 }
 
 static void destroy_previous_session(struct ksmbd_conn *conn,
@@ -2277,7 +2311,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* delete the EA only when it exits */
 			if (rc > 0) {
 				rc = ksmbd_vfs_remove_xattr(idmap,
-							    path->dentry,
+							    path,
 							    attr_name);
 
 				if (rc < 0) {
@@ -2291,8 +2325,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			/* if the EA doesn't exist, just do nothing. */
 			rc = 0;
 		} else {
-			rc = ksmbd_vfs_setxattr(idmap,
-						path->dentry, attr_name, value,
+			rc = ksmbd_vfs_setxattr(idmap, path, attr_name, value,
 						le16_to_cpu(eabuf->EaValueLength), 0);
 			if (rc < 0) {
 				ksmbd_debug(SMB,
@@ -2349,8 +2382,7 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 		return -EBADF;
 	}
 
-	rc = ksmbd_vfs_setxattr(idmap, path->dentry,
-				xattr_stream_name, NULL, 0, 0);
+	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
 	return 0;
@@ -2378,7 +2410,7 @@ static int smb2_remove_smb_xattrs(const struct path *path)
 		if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN) &&
 		    !strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX,
 			     STREAM_PREFIX_LEN)) {
-			err = ksmbd_vfs_remove_xattr(idmap, path->dentry,
+			err = ksmbd_vfs_remove_xattr(idmap, path,
 						     name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n",
@@ -2425,8 +2457,7 @@ static void smb2_new_xattrs(struct ksmbd_tree_connect *tcon, const struct path *
 	da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 		XATTR_DOSINFO_ITIME;
 
-	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt),
-					    path->dentry, &da);
+	rc = ksmbd_vfs_set_dos_attrib_xattr(mnt_idmap(path->mnt), path, &da);
 	if (rc)
 		ksmbd_debug(SMB, "failed to store file attribute into xattr\n");
 }
@@ -2481,7 +2512,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2772,8 +2803,10 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
 	if (!rc) {
+		file_present = true;
+
 		if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
 			/*
 			 * If file exists with under flags, return access
@@ -2782,7 +2815,6 @@ int smb2_open(struct ksmbd_work *work)
 			if (req->CreateDisposition == FILE_OVERWRITE_IF_LE ||
 			    req->CreateDisposition == FILE_OPEN_IF_LE) {
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 
@@ -2790,26 +2822,23 @@ int smb2_open(struct ksmbd_work *work)
 				ksmbd_debug(SMB,
 					    "User does not have write permission\n");
 				rc = -EACCES;
-				path_put(&path);
 				goto err_out;
 			}
 		} else if (d_is_symlink(path.dentry)) {
 			rc = -EACCES;
-			path_put(&path);
 			goto err_out;
 		}
-	}
 
-	if (rc) {
+		file_present = true;
+		idmap = mnt_idmap(path.mnt);
+	} else {
 		if (rc != -ENOENT)
 			goto err_out;
 		ksmbd_debug(SMB, "can not get linux path for %s, rc = %d\n",
 			    name, rc);
 		rc = 0;
-	} else {
-		file_present = true;
-		idmap = mnt_idmap(path.mnt);
 	}
+
 	if (stream_name) {
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE) {
 			if (s_type == DATA_STREAM) {
@@ -2937,8 +2966,9 @@ int smb2_open(struct ksmbd_work *work)
 
 			if ((daccess & FILE_DELETE_LE) ||
 			    (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE)) {
-				rc = ksmbd_vfs_may_delete(idmap,
-							  path.dentry);
+				rc = inode_permission(idmap,
+						      d_inode(path.dentry->d_parent),
+						      MAY_EXEC | MAY_WRITE);
 				if (rc)
 					goto err_out;
 			}
@@ -3001,7 +3031,7 @@ int smb2_open(struct ksmbd_work *work)
 		struct inode *inode = d_inode(path.dentry);
 
 		posix_acl_rc = ksmbd_vfs_inherit_posix_acl(idmap,
-							   path.dentry,
+							   &path,
 							   d_inode(path.dentry->d_parent));
 		if (posix_acl_rc)
 			ksmbd_debug(SMB, "inherit posix acl failed : %d\n", posix_acl_rc);
@@ -3017,7 +3047,7 @@ int smb2_open(struct ksmbd_work *work)
 			if (rc) {
 				if (posix_acl_rc)
 					ksmbd_vfs_set_init_posix_acl(idmap,
-								     path.dentry);
+								     &path);
 
 				if (test_share_config_flag(work->tcon->share_conf,
 							   KSMBD_SHARE_FLAG_ACL_XATTR)) {
@@ -3057,7 +3087,7 @@ int smb2_open(struct ksmbd_work *work)
 
 					rc = ksmbd_vfs_set_sd_xattr(conn,
 								    idmap,
-								    path.dentry,
+								    &path,
 								    pntsd,
 								    pntsd_size);
 					kfree(pntsd);
@@ -3309,10 +3339,13 @@ int smb2_open(struct ksmbd_work *work)
 	}
 
 err_out:
-	if (file_present || created)
-		path_put(&path);
+	if (file_present || created) {
+		inode_unlock(d_inode(path.dentry->d_parent));
+		dput(path.dentry);
+	}
 	ksmbd_revert_fsids(work);
 err_out1:
+
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -5451,44 +5484,19 @@ int smb2_echo(struct ksmbd_work *work)
 
 static int smb2_rename(struct ksmbd_work *work,
 		       struct ksmbd_file *fp,
-		       struct mnt_idmap *idmap,
 		       struct smb2_file_rename_info *file_info,
 		       struct nls_table *local_nls)
 {
 	struct ksmbd_share_config *share = fp->tcon->share_conf;
-	char *new_name = NULL, *abs_oldname = NULL, *old_name = NULL;
-	char *pathname = NULL;
-	struct path path;
-	bool file_present = true;
-	int rc;
+	char *new_name = NULL;
+	int rc, flags = 0;
 
 	ksmbd_debug(SMB, "setting FILE_RENAME_INFO\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!pathname)
-		return -ENOMEM;
-
-	abs_oldname = file_path(fp->filp, pathname, PATH_MAX);
-	if (IS_ERR(abs_oldname)) {
-		rc = -EINVAL;
-		goto out;
-	}
-	old_name = strrchr(abs_oldname, '/');
-	if (old_name && old_name[1] != '\0') {
-		old_name++;
-	} else {
-		ksmbd_debug(SMB, "can't get last component in path %s\n",
-			    abs_oldname);
-		rc = -ENOENT;
-		goto out;
-	}
-
 	new_name = smb2_get_name(file_info->FileName,
 				 le32_to_cpu(file_info->FileNameLength),
 				 local_nls);
-	if (IS_ERR(new_name)) {
-		rc = PTR_ERR(new_name);
-		goto out;
-	}
+	if (IS_ERR(new_name))
+		return PTR_ERR(new_name);
 
 	if (strchr(new_name, ':')) {
 		int s_type;
@@ -5514,8 +5522,8 @@ static int smb2_rename(struct ksmbd_work *work,
 		if (rc)
 			goto out;
 
-		rc = ksmbd_vfs_setxattr(idmap,
-					fp->filp->f_path.dentry,
+		rc = ksmbd_vfs_setxattr(file_mnt_idmap(fp->filp),
+					&fp->filp->f_path,
 					xattr_stream_name,
 					NULL, 0, 0);
 		if (rc < 0) {
@@ -5529,47 +5537,18 @@ static int smb2_rename(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "new name %s\n", new_name);
-	rc = ksmbd_vfs_kern_path(work, new_name, LOOKUP_NO_SYMLINKS, &path, 1);
-	if (rc) {
-		if (rc != -ENOENT)
-			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
-
 	if (ksmbd_share_veto_filename(share, new_name)) {
 		rc = -ENOENT;
 		ksmbd_debug(SMB, "Can't rename vetoed file: %s\n", new_name);
 		goto out;
 	}
 
-	if (file_info->ReplaceIfExists) {
-		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, new_name);
-			if (rc) {
-				if (rc != -ENOTEMPTY)
-					rc = -EINVAL;
-				ksmbd_debug(SMB, "cannot delete %s, rc %d\n",
-					    new_name, rc);
-				goto out;
-			}
-		}
-	} else {
-		if (file_present &&
-		    strncmp(old_name, path.dentry->d_name.name, strlen(old_name))) {
-			rc = -EEXIST;
-			ksmbd_debug(SMB,
-				    "cannot rename already existing file\n");
-			goto out;
-		}
-	}
+	if (!file_info->ReplaceIfExists)
+		flags = RENAME_NOREPLACE;
 
-	rc = ksmbd_vfs_fp_rename(work, fp, new_name);
+	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
 out:
-	kfree(pathname);
-	if (!IS_ERR(new_name))
-		kfree(new_name);
+	kfree(new_name);
 	return rc;
 }
 
@@ -5581,7 +5560,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
 	struct path path;
-	bool file_present = true;
+	bool file_present = false;
 	int rc;
 
 	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
@@ -5609,18 +5588,17 @@ static int smb2_create_link(struct ksmbd_work *work,
 	}
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
-	rc = ksmbd_vfs_kern_path(work, link_name, LOOKUP_NO_SYMLINKS, &path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
+					&path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
-		file_present = false;
-	} else {
-		path_put(&path);
-	}
+	} else
+		file_present = true;
 
 	if (file_info->ReplaceIfExists) {
 		if (file_present) {
-			rc = ksmbd_vfs_remove_file(work, link_name);
+			rc = ksmbd_vfs_remove_file(work, &path);
 			if (rc) {
 				rc = -EINVAL;
 				ksmbd_debug(SMB, "cannot delete %s\n",
@@ -5640,6 +5618,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	if (rc)
 		rc = -EINVAL;
 out:
+	if (file_present) {
+		inode_unlock(d_inode(path.dentry->d_parent));
+		path_put(&path);
+	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
 	kfree(pathname);
@@ -5706,8 +5688,7 @@ static int set_file_basic_info(struct ksmbd_file *fp,
 		da.flags = XATTR_DOSINFO_ATTRIB | XATTR_DOSINFO_CREATE_TIME |
 			XATTR_DOSINFO_ITIME;
 
-		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap,
-						    filp->f_path.dentry, &da);
+		rc = ksmbd_vfs_set_dos_attrib_xattr(idmap, &filp->f_path, &da);
 		if (rc)
 			ksmbd_debug(SMB,
 				    "failed to restore file attribute in EA\n");
@@ -5817,12 +5798,6 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			   struct smb2_file_rename_info *rename_info,
 			   unsigned int buf_len)
 {
-	struct mnt_idmap *idmap;
-	struct ksmbd_file *parent_fp;
-	struct dentry *parent;
-	struct dentry *dentry = fp->filp->f_path.dentry;
-	int ret;
-
 	if (!(fp->daccess & FILE_DELETE_LE)) {
 		pr_err("no right to delete : 0x%x\n", fp->daccess);
 		return -EACCES;
@@ -5832,32 +5807,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 			le32_to_cpu(rename_info->FileNameLength))
 		return -EINVAL;
 
-	idmap = file_mnt_idmap(fp->filp);
-	if (ksmbd_stream_fd(fp))
-		goto next;
-
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	parent_fp = ksmbd_lookup_fd_inode(d_inode(parent));
-	inode_unlock(d_inode(parent));
-	dput(parent);
+	if (!le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
 
-	if (parent_fp) {
-		if (parent_fp->daccess & FILE_DELETE_LE) {
-			pr_err("parent dir is opened with delete access\n");
-			ksmbd_fd_put(work, parent_fp);
-			return -ESHARE;
-		}
-		ksmbd_fd_put(work, parent_fp);
-	}
-next:
-	return smb2_rename(work, fp, idmap, rename_info,
-			   work->conn->local_nls);
+	return smb2_rename(work, fp, rename_info, work->conn->local_nls);
 }
 
 static int set_file_disposition_info(struct ksmbd_file *fp,
@@ -7590,7 +7543,7 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 		da.attr = le32_to_cpu(fp->f_ci->m_fattr);
 		ret = ksmbd_vfs_set_dos_attrib_xattr(idmap,
-						     fp->filp->f_path.dentry, &da);
+						     &fp->filp->f_path, &da);
 		if (ret)
 			fp->f_ci->m_fattr = old_fattr;
 	}
diff --git a/fs/ksmbd/smbacl.c b/fs/ksmbd/smbacl.c
index 0a5862a61c77..ad919a4239d0 100644
--- a/fs/ksmbd/smbacl.c
+++ b/fs/ksmbd/smbacl.c
@@ -1162,8 +1162,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 			pntsd_size += sizeof(struct smb_acl) + nt_size;
 		}
 
-		ksmbd_vfs_set_sd_xattr(conn, idmap,
-				       path->dentry, pntsd, pntsd_size);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, pntsd_size);
 		kfree(pntsd);
 	}
 
@@ -1383,7 +1382,7 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 	newattrs.ia_valid |= ATTR_MODE;
 	newattrs.ia_mode = (inode->i_mode & ~0777) | (fattr.cf_mode & 0777);
 
-	ksmbd_vfs_remove_acl_xattrs(idmap, path->dentry);
+	ksmbd_vfs_remove_acl_xattrs(idmap, path);
 	/* Update posix acls */
 	if (IS_ENABLED(CONFIG_FS_POSIX_ACL) && fattr.cf_dacls) {
 		rc = set_posix_acl(idmap, path->dentry,
@@ -1414,9 +1413,8 @@ int set_info_sec(struct ksmbd_conn *conn, struct ksmbd_tree_connect *tcon,
 
 	if (test_share_config_flag(tcon->share_conf, KSMBD_SHARE_FLAG_ACL_XATTR)) {
 		/* Update WinACL in xattr */
-		ksmbd_vfs_remove_sd_xattrs(idmap, path->dentry);
-		ksmbd_vfs_set_sd_xattr(conn, idmap,
-				       path->dentry, pntsd, ntsd_len);
+		ksmbd_vfs_remove_sd_xattrs(idmap, path);
+		ksmbd_vfs_set_sd_xattr(conn, idmap, path, pntsd, ntsd_len);
 	}
 
 out:
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index f6a8b2659309..81489fdedd8e 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -18,8 +18,7 @@
 #include <linux/vmalloc.h>
 #include <linux/sched/xacct.h>
 #include <linux/crc32c.h>
-
-#include "../internal.h"	/* for vfs_path_lookup */
+#include <linux/namei.h>
 
 #include "glob.h"
 #include "oplock.h"
@@ -37,19 +36,6 @@
 #include "mgmt/user_session.h"
 #include "mgmt/user_config.h"
 
-static char *extract_last_component(char *path)
-{
-	char *p = strrchr(path, '/');
-
-	if (p && p[1] != '\0') {
-		*p = '\0';
-		p++;
-	} else {
-		p = NULL;
-	}
-	return p;
-}
-
 static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 				    struct inode *parent_inode,
 				    struct inode *inode)
@@ -63,65 +49,81 @@ static void ksmbd_vfs_inherit_owner(struct ksmbd_work *work,
 
 /**
  * ksmbd_vfs_lock_parent() - lock parent dentry if it is stable
- *
- * the parent dentry got by dget_parent or @parent could be
- * unstable, we try to lock a parent inode and lookup the
- * child dentry again.
- *
- * the reference count of @parent isn't incremented.
  */
-int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
-			  struct dentry *child)
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 {
-	struct dentry *dentry;
-	int ret = 0;
-
 	inode_lock_nested(d_inode(parent), I_MUTEX_PARENT);
-	dentry = lookup_one(idmap, child->d_name.name, parent,
-			    child->d_name.len);
-	if (IS_ERR(dentry)) {
-		ret = PTR_ERR(dentry);
-		goto out_err;
-	}
-
-	if (dentry != child) {
-		ret = -ESTALE;
-		dput(dentry);
-		goto out_err;
+	if (child->d_parent != parent) {
+		inode_unlock(d_inode(parent));
+		return -ENOENT;
 	}
 
-	dput(dentry);
 	return 0;
-out_err:
-	inode_unlock(d_inode(parent));
-	return ret;
 }
 
-int ksmbd_vfs_may_delete(struct mnt_idmap *idmap,
-			 struct dentry *dentry)
+static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
+					char *pathname, unsigned int flags,
+					struct path *path)
 {
-	struct dentry *parent;
-	int ret;
+	struct qstr last;
+	struct filename *filename;
+	struct path *root_share_path = &share_conf->vfs_path;
+	int err, type;
+	struct path parent_path;
+	struct dentry *d;
+
+	if (pathname[0] == '\0') {
+		pathname = share_conf->path;
+		root_share_path = NULL;
+	} else {
+		flags |= LOOKUP_BENEATH;
+	}
+
+	filename = getname_kernel(pathname);
+	if (IS_ERR(filename))
+		return PTR_ERR(filename);
+
+	err = vfs_path_parent_lookup(filename, flags,
+				     &parent_path, &last, &type,
+				     root_share_path);
+	if (err) {
+		putname(filename);
+		return err;
+	}
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
+	if (unlikely(type != LAST_NORM)) {
+		path_put(&parent_path);
+		putname(filename);
+		return -ENOENT;
 	}
 
-	ret = inode_permission(idmap, d_inode(parent),
-			       MAY_EXEC | MAY_WRITE);
+	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	if (IS_ERR(d))
+		goto err_out;
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	return ret;
+	if (d_is_negative(d)) {
+		dput(d);
+		goto err_out;
+	}
+
+	path->dentry = d;
+	path->mnt = share_conf->vfs_path.mnt;
+	path_put(&parent_path);
+	putname(filename);
+
+	return 0;
+
+err_out:
+	inode_unlock(parent_path.dentry->d_inode);
+	path_put(&parent_path);
+	putname(filename);
+	return -ENOENT;
 }
 
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess)
 {
-	struct dentry *parent;
 	int ret = 0;
 
 	*daccess = cpu_to_le32(FILE_READ_ATTRIBUTES | READ_CONTROL);
@@ -138,18 +140,9 @@ int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 	if (!inode_permission(idmap, d_inode(dentry), MAY_OPEN | MAY_EXEC))
 		*daccess |= FILE_EXECUTE_LE;
 
-	parent = dget_parent(dentry);
-	ret = ksmbd_vfs_lock_parent(idmap, parent, dentry);
-	if (ret) {
-		dput(parent);
-		return ret;
-	}
-
-	if (!inode_permission(idmap, d_inode(parent), MAY_EXEC | MAY_WRITE))
+	if (!inode_permission(idmap, d_inode(dentry->d_parent), MAY_EXEC | MAY_WRITE))
 		*daccess |= FILE_DELETE_LE;
 
-	inode_unlock(d_inode(parent));
-	dput(parent);
 	return ret;
 }
 
@@ -177,6 +170,10 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err;
+
 	mode |= S_IFREG;
 	err = vfs_create(mnt_idmap(path.mnt), d_inode(path.dentry),
 			 dentry, mode, true);
@@ -186,6 +183,9 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode)
 	} else {
 		pr_err("File(%s): creation failed (err:%d)\n", name, err);
 	}
+	mnt_drop_write(path.mnt);
+
+out_err:
 	done_path_create(&path, dentry);
 	return err;
 }
@@ -216,30 +216,35 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode)
 		return err;
 	}
 
+	err = mnt_want_write(path.mnt);
+	if (err)
+		goto out_err2;
+
 	idmap = mnt_idmap(path.mnt);
 	mode |= S_IFDIR;
 	err = vfs_mkdir(idmap, d_inode(path.dentry), dentry, mode);
-	if (err) {
-		goto out;
-	} else if (d_unhashed(dentry)) {
+	if (!err && d_unhashed(dentry)) {
 		struct dentry *d;
 
 		d = lookup_one(idmap, dentry->d_name.name, dentry->d_parent,
 			       dentry->d_name.len);
 		if (IS_ERR(d)) {
 			err = PTR_ERR(d);
-			goto out;
+			goto out_err1;
 		}
 		if (unlikely(d_is_negative(d))) {
 			dput(d);
 			err = -ENOENT;
-			goto out;
+			goto out_err1;
 		}
 
 		ksmbd_vfs_inherit_owner(work, d_inode(path.dentry), d_inode(d));
 		dput(d);
 	}
-out:
+
+out_err1:
+	mnt_drop_write(path.mnt);
+out_err2:
 	done_path_create(&path, dentry);
 	if (err)
 		pr_err("mkdir(%s): creation failed (err:%d)\n", name, err);
@@ -450,7 +455,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	memcpy(&stream_buf[*pos], buf, count);
 
 	err = ksmbd_vfs_setxattr(idmap,
-				 fp->filp->f_path.dentry,
+				 &fp->filp->f_path,
 				 fp->stream.name,
 				 (void *)stream_buf,
 				 size,
@@ -582,54 +587,37 @@ int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id)
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name)
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path)
 {
 	struct mnt_idmap *idmap;
-	struct path path;
-	struct dentry *parent;
+	struct dentry *parent = path->dentry->d_parent;
 	int err;
 
 	if (ksmbd_override_fsids(work))
 		return -ENOMEM;
 
-	err = ksmbd_vfs_kern_path(work, name, LOOKUP_NO_SYMLINKS, &path, false);
-	if (err) {
-		ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	idmap = mnt_idmap(path.mnt);
-	parent = dget_parent(path.dentry);
-	err = ksmbd_vfs_lock_parent(idmap, parent, path.dentry);
-	if (err) {
-		dput(parent);
-		path_put(&path);
-		ksmbd_revert_fsids(work);
-		return err;
-	}
-
-	if (!d_inode(path.dentry)->i_nlink) {
+	if (!d_inode(path->dentry)->i_nlink) {
 		err = -ENOENT;
 		goto out_err;
 	}
 
-	if (S_ISDIR(d_inode(path.dentry)->i_mode)) {
-		err = vfs_rmdir(idmap, d_inode(parent), path.dentry);
+	err = mnt_want_write(path->mnt);
+	if (err)
+		goto out_err;
+
+	idmap = mnt_idmap(path->mnt);
+	if (S_ISDIR(d_inode(path->dentry)->i_mode)) {
+		err = vfs_rmdir(idmap, d_inode(parent), path->dentry);
 		if (err && err != -ENOTEMPTY)
-			ksmbd_debug(VFS, "%s: rmdir failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "rmdir failed, err %d\n", err);
 	} else {
-		err = vfs_unlink(idmap, d_inode(parent), path.dentry, NULL);
+		err = vfs_unlink(idmap, d_inode(parent), path->dentry, NULL);
 		if (err)
-			ksmbd_debug(VFS, "%s: unlink failed, err %d\n", name,
-				    err);
+			ksmbd_debug(VFS, "unlink failed, err %d\n", err);
 	}
+	mnt_drop_write(path->mnt);
 
 out_err:
-	inode_unlock(d_inode(parent));
-	dput(parent);
-	path_put(&path);
 	ksmbd_revert_fsids(work);
 	return err;
 }
@@ -673,11 +661,16 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 		goto out3;
 	}
 
+	err = mnt_want_write(newpath.mnt);
+	if (err)
+		goto out3;
+
 	err = vfs_link(oldpath.dentry, mnt_idmap(newpath.mnt),
 		       d_inode(newpath.dentry),
 		       dentry, NULL);
 	if (err)
 		ksmbd_debug(VFS, "vfs_link failed err %d\n", err);
+	mnt_drop_write(newpath.mnt);
 
 out3:
 	done_path_create(&newpath, dentry);
@@ -688,149 +681,120 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const char *oldname,
 	return err;
 }
 
-static int ksmbd_validate_entry_in_use(struct dentry *src_dent)
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags)
 {
-	struct dentry *dst_dent;
+	struct dentry *old_parent, *new_dentry, *trap;
+	struct dentry *old_child = old_path->dentry;
+	struct path new_path;
+	struct qstr new_last;
+	struct renamedata rd;
+	struct filename *to;
+	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
+	struct ksmbd_file *parent_fp;
+	int new_type;
+	int err, lookup_flags = LOOKUP_NO_SYMLINKS;
+
+	if (ksmbd_override_fsids(work))
+		return -ENOMEM;
 
-	spin_lock(&src_dent->d_lock);
-	list_for_each_entry(dst_dent, &src_dent->d_subdirs, d_child) {
-		struct ksmbd_file *child_fp;
+	to = getname_kernel(newname);
+	if (IS_ERR(to)) {
+		err = PTR_ERR(to);
+		goto revert_fsids;
+	}
 
-		if (d_really_is_negative(dst_dent))
-			continue;
+retry:
+	err = vfs_path_parent_lookup(to, lookup_flags | LOOKUP_BENEATH,
+				     &new_path, &new_last, &new_type,
+				     &share_conf->vfs_path);
+	if (err)
+		goto out1;
 
-		child_fp = ksmbd_lookup_fd_inode(d_inode(dst_dent));
-		if (child_fp) {
-			spin_unlock(&src_dent->d_lock);
-			ksmbd_debug(VFS, "Forbid rename, sub file/dir is in use\n");
-			return -EACCES;
-		}
+	if (old_path->mnt != new_path.mnt) {
+		err = -EXDEV;
+		goto out2;
 	}
-	spin_unlock(&src_dent->d_lock);
 
-	return 0;
-}
+	err = mnt_want_write(old_path->mnt);
+	if (err)
+		goto out2;
 
-static int __ksmbd_vfs_rename(struct ksmbd_work *work,
-			      struct mnt_idmap *src_idmap,
-			      struct dentry *src_dent_parent,
-			      struct dentry *src_dent,
-			      struct mnt_idmap *dst_idmap,
-			      struct dentry *dst_dent_parent,
-			      struct dentry *trap_dent,
-			      char *dst_name)
-{
-	struct dentry *dst_dent;
-	int err;
+	trap = lock_rename_child(old_child, new_path.dentry);
 
-	if (!work->tcon->posix_extensions) {
-		err = ksmbd_validate_entry_in_use(src_dent);
-		if (err)
-			return err;
+	old_parent = dget(old_child->d_parent);
+	if (d_unhashed(old_child)) {
+		err = -EINVAL;
+		goto out3;
 	}
 
-	if (d_really_is_negative(src_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(dst_dent_parent))
-		return -ENOENT;
-	if (d_really_is_negative(src_dent))
-		return -ENOENT;
-	if (src_dent == trap_dent)
-		return -EINVAL;
-
-	if (ksmbd_override_fsids(work))
-		return -ENOMEM;
+	parent_fp = ksmbd_lookup_fd_inode(d_inode(old_child->d_parent));
+	if (parent_fp) {
+		if (parent_fp->daccess & FILE_DELETE_LE) {
+			pr_err("parent dir is opened with delete access\n");
+			err = -ESHARE;
+			ksmbd_fd_put(work, parent_fp);
+			goto out3;
+		}
+		ksmbd_fd_put(work, parent_fp);
+	}
 
-	dst_dent = lookup_one(dst_idmap, dst_name,
-			      dst_dent_parent, strlen(dst_name));
-	err = PTR_ERR(dst_dent);
-	if (IS_ERR(dst_dent)) {
-		pr_err("lookup failed %s [%d]\n", dst_name, err);
-		goto out;
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | LOOKUP_RENAME_TARGET);
+	if (IS_ERR(new_dentry)) {
+		err = PTR_ERR(new_dentry);
+		goto out3;
 	}
 
-	err = -ENOTEMPTY;
-	if (dst_dent != trap_dent && !d_really_is_positive(dst_dent)) {
-		struct renamedata rd = {
-			.old_mnt_idmap	= src_idmap,
-			.old_dir	= d_inode(src_dent_parent),
-			.old_dentry	= src_dent,
-			.new_mnt_idmap	= dst_idmap,
-			.new_dir	= d_inode(dst_dent_parent),
-			.new_dentry	= dst_dent,
-		};
-		err = vfs_rename(&rd);
+	if (d_is_symlink(new_dentry)) {
+		err = -EACCES;
+		goto out4;
 	}
-	if (err)
-		pr_err("vfs_rename failed err %d\n", err);
-	if (dst_dent)
-		dput(dst_dent);
-out:
-	ksmbd_revert_fsids(work);
-	return err;
-}
 
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname)
-{
-	struct mnt_idmap *idmap;
-	struct path dst_path;
-	struct dentry *src_dent_parent, *dst_dent_parent;
-	struct dentry *src_dent, *trap_dent, *src_child;
-	char *dst_name;
-	int err;
+	if ((flags & RENAME_NOREPLACE) && d_is_positive(new_dentry)) {
+		err = -EEXIST;
+		goto out4;
+	}
 
-	dst_name = extract_last_component(newname);
-	if (!dst_name) {
-		dst_name = newname;
-		newname = "";
+	if (old_child == trap) {
+		err = -EINVAL;
+		goto out4;
 	}
 
-	src_dent_parent = dget_parent(fp->filp->f_path.dentry);
-	src_dent = fp->filp->f_path.dentry;
+	if (new_dentry == trap) {
+		err = -ENOTEMPTY;
+		goto out4;
+	}
+
+	rd.old_mnt_idmap	= mnt_idmap(old_path->mnt),
+	rd.old_dir		= d_inode(old_parent),
+	rd.old_dentry		= old_child,
+	rd.new_mnt_idmap	= mnt_idmap(new_path.mnt),
+	rd.new_dir		= new_path.dentry->d_inode,
+	rd.new_dentry		= new_dentry,
+	rd.flags		= flags,
+	rd.delegated_inode	= NULL,
+	err = vfs_rename(&rd);
+	if (err)
+		ksmbd_debug(VFS, "vfs_rename failed err %d\n", err);
 
-	err = ksmbd_vfs_kern_path(work, newname,
-				  LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
-				  &dst_path, false);
-	if (err) {
-		ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname, err);
-		goto out;
+out4:
+	dput(new_dentry);
+out3:
+	dput(old_parent);
+	unlock_rename(old_parent, new_path.dentry);
+	mnt_drop_write(old_path->mnt);
+out2:
+	path_put(&new_path);
+
+	if (retry_estale(err, lookup_flags)) {
+		lookup_flags |= LOOKUP_REVAL;
+		goto retry;
 	}
-	dst_dent_parent = dst_path.dentry;
-
-	trap_dent = lock_rename(src_dent_parent, dst_dent_parent);
-	dget(src_dent);
-	dget(dst_dent_parent);
-	idmap = file_mnt_idmap(fp->filp);
-	src_child = lookup_one(idmap, src_dent->d_name.name, src_dent_parent,
-			       src_dent->d_name.len);
-	if (IS_ERR(src_child)) {
-		err = PTR_ERR(src_child);
-		goto out_lock;
-	}
-
-	if (src_child != src_dent) {
-		err = -ESTALE;
-		dput(src_child);
-		goto out_lock;
-	}
-	dput(src_child);
-
-	err = __ksmbd_vfs_rename(work,
-				 idmap,
-				 src_dent_parent,
-				 src_dent,
-				 mnt_idmap(dst_path.mnt),
-				 dst_dent_parent,
-				 trap_dent,
-				 dst_name);
-out_lock:
-	dput(src_dent);
-	dput(dst_dent_parent);
-	unlock_rename(src_dent_parent, dst_dent_parent);
-	path_put(&dst_path);
-out:
-	dput(src_dent_parent);
+out1:
+	putname(to);
+revert_fsids:
+	ksmbd_revert_fsids(work);
 	return err;
 }
 
@@ -960,19 +924,24 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags)
 {
 	int err;
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
 	err = vfs_setxattr(idmap,
-			   dentry,
+			   path->dentry,
 			   attr_name,
 			   attr_value,
 			   attr_size,
 			   flags);
 	if (err)
 		ksmbd_debug(VFS, "setxattr failed, err %d\n", err);
+	mnt_drop_write(path->mnt);
 	return err;
 }
 
@@ -1076,19 +1045,34 @@ int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 }
 
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, char *attr_name)
+			   const struct path *path, char *attr_name)
 {
-	return vfs_removexattr(idmap, dentry, attr_name);
+	int err;
+
+	err = mnt_want_write(path->mnt);
+	if (err)
+		return err;
+
+	err = vfs_removexattr(idmap, path->dentry, attr_name);
+	mnt_drop_write(path->mnt);
+
+	return err;
 }
 
-int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
-		     struct dentry *dir, struct dentry *dentry)
+int ksmbd_vfs_unlink(struct file *filp)
 {
 	int err = 0;
+	struct dentry *dir, *dentry = filp->f_path.dentry;
+	struct mnt_idmap *idmap = file_mnt_idmap(filp);
 
-	err = ksmbd_vfs_lock_parent(idmap, dir, dentry);
+	err = mnt_want_write(filp->f_path.mnt);
 	if (err)
 		return err;
+
+	dir = dget_parent(dentry);
+	err = ksmbd_vfs_lock_parent(dir, dentry);
+	if (err)
+		goto out;
 	dget(dentry);
 
 	if (S_ISDIR(d_inode(dentry)->i_mode))
@@ -1100,6 +1084,9 @@ int ksmbd_vfs_unlink(struct mnt_idmap *idmap,
 	inode_unlock(d_inode(dir));
 	if (err)
 		ksmbd_debug(VFS, "failed to delete, err %d\n", err);
+out:
+	dput(dir);
+	mnt_drop_write(filp->f_path.mnt);
 
 	return err;
 }
@@ -1202,7 +1189,7 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
 }
 
 /**
- * ksmbd_vfs_kern_path() - lookup a file and get path info
+ * ksmbd_vfs_kern_path_locked() - lookup a file and get path info
  * @name:	file path that is relative to share
  * @flags:	lookup flags
  * @path:	if lookup succeed, return path info
@@ -1210,24 +1197,20 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  *
  * Return:	0 on success, otherwise error
  */
-int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
-			unsigned int flags, struct path *path, bool caseless)
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
+	struct path parent_path;
 
-	flags |= LOOKUP_BENEATH;
-	err = vfs_path_lookup(share_conf->vfs_path.dentry,
-			      share_conf->vfs_path.mnt,
-			      name,
-			      flags,
-			      path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
 	if (!err)
-		return 0;
+		return err;
 
 	if (caseless) {
 		char *filepath;
-		struct path parent;
 		size_t path_len, remain_len;
 
 		filepath = kstrdup(name, GFP_KERNEL);
@@ -1237,10 +1220,10 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent = share_conf->vfs_path;
-		path_get(&parent);
+		parent_path = share_conf->vfs_path;
+		path_get(&parent_path);
 
-		while (d_can_lookup(parent.dentry)) {
+		while (d_can_lookup(parent_path.dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1249,12 +1232,11 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent, filename,
+			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
 						      filename_len,
 						      work->conn->um);
-			path_put(&parent);
 			if (err)
-				goto out;
+				goto out2;
 
 			next[0] = '\0';
 
@@ -1262,23 +1244,31 @@ int ksmbd_vfs_kern_path(struct ksmbd_work *work, char *name,
 					      share_conf->vfs_path.mnt,
 					      filepath,
 					      flags,
-					      &parent);
+					      path);
 			if (err)
-				goto out;
-			else if (is_last) {
-				*path = parent;
-				goto out;
-			}
+				goto out2;
+			else if (is_last)
+				goto out1;
+			path_put(&parent_path);
+			parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
 		}
 
-		path_put(&parent);
 		err = -EINVAL;
-out:
+out2:
+		path_put(&parent_path);
+out1:
 		kfree(filepath);
 	}
+
+	if (!err) {
+		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
+		if (err)
+			dput(path->dentry);
+		path_put(&parent_path);
+	}
 	return err;
 }
 
@@ -1300,13 +1290,13 @@ struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 }
 
 int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
-				struct dentry *dentry)
+				const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1314,6 +1304,10 @@ int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 		goto out;
 	}
 
+	err = mnt_want_write(path->mnt);
+	if (err)
+		goto out;
+
 	for (name = xattr_list; name - xattr_list < xattr_list_len;
 	     name += strlen(name) + 1) {
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
@@ -1322,25 +1316,26 @@ int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
 			     sizeof(XATTR_NAME_POSIX_ACL_ACCESS) - 1) ||
 		    !strncmp(name, XATTR_NAME_POSIX_ACL_DEFAULT,
 			     sizeof(XATTR_NAME_POSIX_ACL_DEFAULT) - 1)) {
-			err = vfs_remove_acl(idmap, dentry, name);
+			err = vfs_remove_acl(idmap, path->dentry, name);
 			if (err)
 				ksmbd_debug(SMB,
 					    "remove acl xattr failed : %s\n", name);
 		}
 	}
+	mnt_drop_write(path->mnt);
+
 out:
 	kvfree(xattr_list);
 	return err;
 }
 
-int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
-			       struct dentry *dentry)
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path)
 {
 	char *name, *xattr_list = NULL;
 	ssize_t xattr_list_len;
 	int err = 0;
 
-	xattr_list_len = ksmbd_vfs_listxattr(dentry, &xattr_list);
+	xattr_list_len = ksmbd_vfs_listxattr(path->dentry, &xattr_list);
 	if (xattr_list_len < 0) {
 		goto out;
 	} else if (!xattr_list_len) {
@@ -1353,7 +1348,7 @@ int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
 		ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
 
 		if (!strncmp(name, XATTR_NAME_SD, XATTR_NAME_SD_LEN)) {
-			err = ksmbd_vfs_remove_xattr(idmap, dentry, name);
+			err = ksmbd_vfs_remove_xattr(idmap, path, name);
 			if (err)
 				ksmbd_debug(SMB, "remove xattr failed : %s\n", name);
 		}
@@ -1430,13 +1425,14 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
-			   struct dentry *dentry,
+			   const struct path *path,
 			   struct smb_ntsd *pntsd, int len)
 {
 	int rc;
 	struct ndr sd_ndr = {0}, acl_ndr = {0};
 	struct xattr_ntacl acl = {0};
 	struct xattr_smb_acl *smb_acl, *def_smb_acl = NULL;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 
 	acl.version = 4;
@@ -1488,7 +1484,7 @@ int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 		goto out;
 	}
 
-	rc = ksmbd_vfs_setxattr(idmap, dentry,
+	rc = ksmbd_vfs_setxattr(idmap, path,
 				XATTR_NAME_SD, sd_ndr.data,
 				sd_ndr.offset, 0);
 	if (rc < 0)
@@ -1578,7 +1574,7 @@ int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 }
 
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da)
 {
 	struct ndr n;
@@ -1588,7 +1584,7 @@ int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	err = ksmbd_vfs_setxattr(idmap, dentry, XATTR_NAME_DOS_ATTRIBUTE,
+	err = ksmbd_vfs_setxattr(idmap, path, XATTR_NAME_DOS_ATTRIBUTE,
 				 (void *)n.data, n.offset, 0);
 	if (err)
 		ksmbd_debug(SMB, "failed to store dos attribute in xattr\n");
@@ -1825,10 +1821,11 @@ void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock)
 }
 
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct dentry *dentry)
+				 struct path *path)
 {
 	struct posix_acl_state acl_state;
 	struct posix_acl *acls;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 	int rc;
 
@@ -1858,6 +1855,11 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 		return -ENOMEM;
 	}
 	posix_state_to_acl(&acl_state, acls->a_entries);
+
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1869,16 +1871,20 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+	mnt_drop_write(path->mnt);
+
+out_err:
 	free_acl_state(&acl_state);
 	posix_acl_release(acls);
 	return rc;
 }
 
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct dentry *dentry, struct inode *parent_inode)
+				struct path *path, struct inode *parent_inode)
 {
 	struct posix_acl *acls;
 	struct posix_acl_entry *pace;
+	struct dentry *dentry = path->dentry;
 	struct inode *inode = d_inode(dentry);
 	int rc, i;
 
@@ -1897,6 +1903,10 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 		}
 	}
 
+	rc = mnt_want_write(path->mnt);
+	if (rc)
+		goto out_err;
+
 	rc = set_posix_acl(idmap, dentry, ACL_TYPE_ACCESS, acls);
 	if (rc < 0)
 		ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_ACCESS) failed, rc : %d\n",
@@ -1908,6 +1918,9 @@ int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
 			ksmbd_debug(SMB, "Set posix acl(ACL_TYPE_DEFAULT) failed, rc : %d\n",
 				    rc);
 	}
+	mnt_drop_write(path->mnt);
+
+out_err:
 	posix_acl_release(acls);
 	return rc;
 }
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index 9d676ab0cd25..8c0931d4d531 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -71,9 +71,7 @@ struct ksmbd_kstat {
 	__le32			file_attributes;
 };
 
-int ksmbd_vfs_lock_parent(struct mnt_idmap *idmap, struct dentry *parent,
-			  struct dentry *child);
-int ksmbd_vfs_may_delete(struct mnt_idmap *idmap, struct dentry *dentry);
+int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child);
 int ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
@@ -84,12 +82,12 @@ int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
 int ksmbd_vfs_fsync(struct ksmbd_work *work, u64 fid, u64 p_id);
-int ksmbd_vfs_remove_file(struct ksmbd_work *work, char *name);
+int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
-int ksmbd_vfs_fp_rename(struct ksmbd_work *work, struct ksmbd_file *fp,
-			char *newname);
+int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+		     char *newname, int flags);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
 		       struct ksmbd_file *fp, loff_t size);
 struct srv_copychunk;
@@ -110,15 +108,15 @@ ssize_t ksmbd_vfs_casexattr_len(struct mnt_idmap *idmap,
 				struct dentry *dentry, char *attr_name,
 				int attr_name_len);
 int ksmbd_vfs_setxattr(struct mnt_idmap *idmap,
-		       struct dentry *dentry, const char *attr_name,
+		       const struct path *path, const char *attr_name,
 		       void *attr_value, size_t attr_size, int flags);
 int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 				size_t *xattr_stream_name_size, int s_type);
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
-			   struct dentry *dentry, char *attr_name);
-int ksmbd_vfs_kern_path(struct ksmbd_work *work,
-			char *name, unsigned int flags, struct path *path,
-			bool caseless);
+			   const struct path *path, char *attr_name);
+int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
+			       unsigned int flags, struct path *path,
+			       bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
@@ -131,8 +129,7 @@ struct file_allocated_range_buffer;
 int ksmbd_vfs_fqar_lseek(struct ksmbd_file *fp, loff_t start, loff_t length,
 			 struct file_allocated_range_buffer *ranges,
 			 unsigned int in_count, unsigned int *out_count);
-int ksmbd_vfs_unlink(struct mnt_idmap *idmap, struct dentry *dir,
-		     struct dentry *dentry);
+int ksmbd_vfs_unlink(struct file *filp);
 void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat);
 int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 				struct mnt_idmap *idmap,
@@ -142,26 +139,25 @@ void ksmbd_vfs_posix_lock_wait(struct file_lock *flock);
 int ksmbd_vfs_posix_lock_wait_timeout(struct file_lock *flock, long timeout);
 void ksmbd_vfs_posix_lock_unblock(struct file_lock *flock);
 int ksmbd_vfs_remove_acl_xattrs(struct mnt_idmap *idmap,
-				struct dentry *dentry);
-int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap,
-			       struct dentry *dentry);
+				const struct path *path);
+int ksmbd_vfs_remove_sd_xattrs(struct mnt_idmap *idmap, const struct path *path);
 int ksmbd_vfs_set_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
-			   struct dentry *dentry,
+			   const struct path *path,
 			   struct smb_ntsd *pntsd, int len);
 int ksmbd_vfs_get_sd_xattr(struct ksmbd_conn *conn,
 			   struct mnt_idmap *idmap,
 			   struct dentry *dentry,
 			   struct smb_ntsd **pntsd);
 int ksmbd_vfs_set_dos_attrib_xattr(struct mnt_idmap *idmap,
-				   struct dentry *dentry,
+				   const struct path *path,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_get_dos_attrib_xattr(struct mnt_idmap *idmap,
 				   struct dentry *dentry,
 				   struct xattr_dos_attrib *da);
 int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
-				 struct dentry *dentry);
+				 struct path *path);
 int ksmbd_vfs_inherit_posix_acl(struct mnt_idmap *idmap,
-				struct dentry *dentry,
+				struct path *path,
 				struct inode *parent_inode);
 #endif /* __KSMBD_VFS_H__ */
diff --git a/fs/ksmbd/vfs_cache.c b/fs/ksmbd/vfs_cache.c
index 054a7d2e0f48..f41f8d6108ce 100644
--- a/fs/ksmbd/vfs_cache.c
+++ b/fs/ksmbd/vfs_cache.c
@@ -244,7 +244,6 @@ void ksmbd_release_inode_hash(void)
 
 static void __ksmbd_inode_close(struct ksmbd_file *fp)
 {
-	struct dentry *dir, *dentry;
 	struct ksmbd_inode *ci = fp->f_ci;
 	int err;
 	struct file *filp;
@@ -253,7 +252,7 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (ksmbd_stream_fd(fp) && (ci->m_flags & S_DEL_ON_CLS_STREAM)) {
 		ci->m_flags &= ~S_DEL_ON_CLS_STREAM;
 		err = ksmbd_vfs_remove_xattr(file_mnt_idmap(filp),
-					     filp->f_path.dentry,
+					     &filp->f_path,
 					     fp->stream.name);
 		if (err)
 			pr_err("remove xattr failed : %s\n",
@@ -263,11 +262,9 @@ static void __ksmbd_inode_close(struct ksmbd_file *fp)
 	if (atomic_dec_and_test(&ci->m_count)) {
 		write_lock(&ci->m_lock);
 		if (ci->m_flags & (S_DEL_ON_CLS | S_DEL_PENDING)) {
-			dentry = filp->f_path.dentry;
-			dir = dentry->d_parent;
 			ci->m_flags &= ~(S_DEL_ON_CLS | S_DEL_PENDING);
 			write_unlock(&ci->m_lock);
-			ksmbd_vfs_unlink(file_mnt_idmap(filp), dir, dentry);
+			ksmbd_vfs_unlink(filp);
 			write_lock(&ci->m_lock);
 		}
 		write_unlock(&ci->m_lock);
diff --git a/fs/namei.c b/fs/namei.c
index edfedfbccaef..c1d59ae5af83 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -254,6 +254,7 @@ getname_kernel(const char * filename)
 
 	return result;
 }
+EXPORT_SYMBOL(getname_kernel);
 
 void putname(struct filename *name)
 {
@@ -271,6 +272,7 @@ void putname(struct filename *name)
 	} else
 		__putname(name);
 }
+EXPORT_SYMBOL(putname);
 
 /**
  * check_acl - perform ACL permission checking
@@ -1581,8 +1583,9 @@ static struct dentry *lookup_dcache(const struct qstr *name,
  * when directory is guaranteed to have no in-lookup children
  * at all.
  */
-static struct dentry *__lookup_hash(const struct qstr *name,
-		struct dentry *base, unsigned int flags)
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags)
 {
 	struct dentry *dentry = lookup_dcache(name, base, flags);
 	struct dentry *old;
@@ -1606,6 +1609,7 @@ static struct dentry *__lookup_hash(const struct qstr *name,
 	}
 	return dentry;
 }
+EXPORT_SYMBOL(lookup_one_qstr_excl);
 
 static struct dentry *lookup_fast(struct nameidata *nd)
 {
@@ -2532,16 +2536,17 @@ static int path_parentat(struct nameidata *nd, unsigned flags,
 }
 
 /* Note: this does not consume "name" */
-static int filename_parentat(int dfd, struct filename *name,
-			     unsigned int flags, struct path *parent,
-			     struct qstr *last, int *type)
+static int __filename_parentat(int dfd, struct filename *name,
+			       unsigned int flags, struct path *parent,
+			       struct qstr *last, int *type,
+			       const struct path *root)
 {
 	int retval;
 	struct nameidata nd;
 
 	if (IS_ERR(name))
 		return PTR_ERR(name);
-	set_nameidata(&nd, dfd, name, NULL);
+	set_nameidata(&nd, dfd, name, root);
 	retval = path_parentat(&nd, flags | LOOKUP_RCU, parent);
 	if (unlikely(retval == -ECHILD))
 		retval = path_parentat(&nd, flags, parent);
@@ -2556,6 +2561,13 @@ static int filename_parentat(int dfd, struct filename *name,
 	return retval;
 }
 
+static int filename_parentat(int dfd, struct filename *name,
+			     unsigned int flags, struct path *parent,
+			     struct qstr *last, int *type)
+{
+	return __filename_parentat(dfd, name, flags, parent, last, type, NULL);
+}
+
 /* does lookup, returns the object with parent locked */
 static struct dentry *__kern_path_locked(struct filename *name, struct path *path)
 {
@@ -2571,7 +2583,7 @@ static struct dentry *__kern_path_locked(struct filename *name, struct path *pat
 		return ERR_PTR(-EINVAL);
 	}
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	d = __lookup_hash(&last, path->dentry, 0);
+	d = lookup_one_qstr_excl(&last, path->dentry, 0);
 	if (IS_ERR(d)) {
 		inode_unlock(path->dentry->d_inode);
 		path_put(path);
@@ -2599,6 +2611,24 @@ int kern_path(const char *name, unsigned int flags, struct path *path)
 }
 EXPORT_SYMBOL(kern_path);
 
+/**
+ * vfs_path_parent_lookup - lookup a parent path relative to a dentry-vfsmount pair
+ * @filename: filename structure
+ * @flags: lookup flags
+ * @parent: pointer to struct path to fill
+ * @last: last component
+ * @type: type of the last component
+ * @root: pointer to struct path of the base directory
+ */
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root)
+{
+	return  __filename_parentat(AT_FDCWD, filename, flags, parent, last,
+				    type, root);
+}
+EXPORT_SYMBOL(vfs_path_parent_lookup);
+
 /**
  * vfs_path_lookup - lookup a file path relative to a dentry-vfsmount pair
  * @dentry:  pointer to dentry of the base directory
@@ -2980,20 +3010,10 @@ static inline int may_create(struct mnt_idmap *idmap,
 	return inode_permission(idmap, dir, MAY_WRITE | MAY_EXEC);
 }
 
-/*
- * p1 and p2 should be directories on the same fs.
- */
-struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+static struct dentry *lock_two_directories(struct dentry *p1, struct dentry *p2)
 {
 	struct dentry *p;
 
-	if (p1 == p2) {
-		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
-		return NULL;
-	}
-
-	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
-
 	p = d_ancestor(p2, p1);
 	if (p) {
 		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
@@ -3012,8 +3032,64 @@ struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
 	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT2);
 	return NULL;
 }
+
+/*
+ * p1 and p2 should be directories on the same fs.
+ */
+struct dentry *lock_rename(struct dentry *p1, struct dentry *p2)
+{
+	if (p1 == p2) {
+		inode_lock_nested(p1->d_inode, I_MUTEX_PARENT);
+		return NULL;
+	}
+
+	mutex_lock(&p1->d_sb->s_vfs_rename_mutex);
+	return lock_two_directories(p1, p2);
+}
 EXPORT_SYMBOL(lock_rename);
 
+/*
+ * c1 and p2 should be on the same fs.
+ */
+struct dentry *lock_rename_child(struct dentry *c1, struct dentry *p2)
+{
+	if (READ_ONCE(c1->d_parent) == p2) {
+		/*
+		 * hopefully won't need to touch ->s_vfs_rename_mutex at all.
+		 */
+		inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+		/*
+		 * now that p2 is locked, nobody can move in or out of it,
+		 * so the test below is safe.
+		 */
+		if (likely(c1->d_parent == p2))
+			return NULL;
+
+		/*
+		 * c1 got moved out of p2 while we'd been taking locks;
+		 * unlock and fall back to slow case.
+		 */
+		inode_unlock(p2->d_inode);
+	}
+
+	mutex_lock(&c1->d_sb->s_vfs_rename_mutex);
+	/*
+	 * nobody can move out of any directories on this fs.
+	 */
+	if (likely(c1->d_parent != p2))
+		return lock_two_directories(c1->d_parent, p2);
+
+	/*
+	 * c1 got moved into p2 while we were taking locks;
+	 * we need p2 locked and ->s_vfs_rename_mutex unlocked,
+	 * for consistency with lock_rename().
+	 */
+	inode_lock_nested(p2->d_inode, I_MUTEX_PARENT);
+	mutex_unlock(&c1->d_sb->s_vfs_rename_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL(lock_rename_child);
+
 void unlock_rename(struct dentry *p1, struct dentry *p2)
 {
 	inode_unlock(p1->d_inode);
@@ -3806,7 +3882,8 @@ static struct dentry *filename_create(int dfd, struct filename *name,
 	if (last.name[last.len] && !want_dir)
 		create_flags = 0;
 	inode_lock_nested(path->dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path->dentry, reval_flag | create_flags);
+	dentry = lookup_one_qstr_excl(&last, path->dentry,
+				      reval_flag | create_flags);
 	if (IS_ERR(dentry))
 		goto unlock;
 
@@ -4166,7 +4243,7 @@ int do_rmdir(int dfd, struct filename *name)
 		goto exit2;
 
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (IS_ERR(dentry))
 		goto exit3;
@@ -4299,7 +4376,7 @@ int do_unlinkat(int dfd, struct filename *name)
 		goto exit2;
 retry_deleg:
 	inode_lock_nested(path.dentry->d_inode, I_MUTEX_PARENT);
-	dentry = __lookup_hash(&last, path.dentry, lookup_flags);
+	dentry = lookup_one_qstr_excl(&last, path.dentry, lookup_flags);
 	error = PTR_ERR(dentry);
 	if (!IS_ERR(dentry)) {
 
@@ -4863,7 +4940,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 retry_deleg:
 	trap = lock_rename(new_path.dentry, old_path.dentry);
 
-	old_dentry = __lookup_hash(&old_last, old_path.dentry, lookup_flags);
+	old_dentry = lookup_one_qstr_excl(&old_last, old_path.dentry,
+					  lookup_flags);
 	error = PTR_ERR(old_dentry);
 	if (IS_ERR(old_dentry))
 		goto exit3;
@@ -4871,7 +4949,8 @@ int do_renameat2(int olddfd, struct filename *from, int newdfd,
 	error = -ENOENT;
 	if (d_is_negative(old_dentry))
 		goto exit4;
-	new_dentry = __lookup_hash(&new_last, new_path.dentry, lookup_flags | target_flags);
+	new_dentry = lookup_one_qstr_excl(&new_last, new_path.dentry,
+					  lookup_flags | target_flags);
 	error = PTR_ERR(new_dentry);
 	if (IS_ERR(new_dentry))
 		goto exit4;
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 41ccd43cd979..afbf4bcefaf2 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -370,7 +370,15 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			struct folio *folio = fbatch.folios[i];
 
 			folio_lock(folio);
-			nilfs_clear_dirty_page(&folio->page, silent);
+
+			/*
+			 * This folio may have been removed from the address
+			 * space by truncation or invalidation when the lock
+			 * was acquired.  Skip processing in that case.
+			 */
+			if (likely(folio->mapping == mapping))
+				nilfs_clear_dirty_page(&folio->page, silent);
+
 			folio_unlock(folio);
 		}
 		folio_batch_release(&fbatch);
diff --git a/fs/nilfs2/segbuf.c b/fs/nilfs2/segbuf.c
index 1362ccb64ec7..6e59dc19a732 100644
--- a/fs/nilfs2/segbuf.c
+++ b/fs/nilfs2/segbuf.c
@@ -101,6 +101,12 @@ int nilfs_segbuf_extend_segsum(struct nilfs_segment_buffer *segbuf)
 	if (unlikely(!bh))
 		return -ENOMEM;
 
+	lock_buffer(bh);
+	if (!buffer_uptodate(bh)) {
+		memset(bh->b_data, 0, bh->b_size);
+		set_buffer_uptodate(bh);
+	}
+	unlock_buffer(bh);
 	nilfs_segbuf_add_segsum_buffer(segbuf, bh);
 	return 0;
 }
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index ac949fd7603f..c2553024bd25 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -981,10 +981,13 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	unsigned int isz, srsz;
 
 	bh_sr = NILFS_LAST_SEGBUF(&sci->sc_segbufs)->sb_super_root;
+
+	lock_buffer(bh_sr);
 	raw_sr = (struct nilfs_super_root *)bh_sr->b_data;
 	isz = nilfs->ns_inode_size;
 	srsz = NILFS_SR_BYTES(isz);
 
+	raw_sr->sr_sum = 0;  /* Ensure initialization within this update */
 	raw_sr->sr_bytes = cpu_to_le16(srsz);
 	raw_sr->sr_nongc_ctime
 		= cpu_to_le64(nilfs_doing_gc() ?
@@ -998,6 +1001,8 @@ static void nilfs_segctor_fill_in_super_root(struct nilfs_sc_info *sci,
 	nilfs_write_inode_common(nilfs->ns_sufile, (void *)raw_sr +
 				 NILFS_SR_SUFILE_OFFSET(isz), 1);
 	memset((void *)raw_sr + srsz, 0, nilfs->ns_blocksize - srsz);
+	set_buffer_uptodate(bh_sr);
+	unlock_buffer(bh_sr);
 }
 
 static void nilfs_redirty_inodes(struct list_head *head)
@@ -1780,6 +1785,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 	list_for_each_entry(segbuf, logs, sb_list) {
 		list_for_each_entry(bh, &segbuf->sb_segsum_buffers,
 				    b_assoc_buffers) {
+			clear_buffer_uptodate(bh);
 			if (bh->b_page != bd_page) {
 				if (bd_page)
 					end_page_writeback(bd_page);
@@ -1791,6 +1797,7 @@ static void nilfs_abort_logs(struct list_head *logs, int err)
 				    b_assoc_buffers) {
 			clear_buffer_async_write(bh);
 			if (bh == segbuf->sb_super_root) {
+				clear_buffer_uptodate(bh);
 				if (bh->b_page != bd_page) {
 					end_page_writeback(bd_page);
 					bd_page = bh->b_page;
diff --git a/fs/nilfs2/super.c b/fs/nilfs2/super.c
index 77f1e5778d1c..9ba4933087af 100644
--- a/fs/nilfs2/super.c
+++ b/fs/nilfs2/super.c
@@ -372,10 +372,31 @@ static int nilfs_move_2nd_super(struct super_block *sb, loff_t sb2off)
 		goto out;
 	}
 	nsbp = (void *)nsbh->b_data + offset;
-	memset(nsbp, 0, nilfs->ns_blocksize);
 
+	lock_buffer(nsbh);
 	if (sb2i >= 0) {
+		/*
+		 * The position of the second superblock only changes by 4KiB,
+		 * which is larger than the maximum superblock data size
+		 * (= 1KiB), so there is no need to use memmove() to allow
+		 * overlap between source and destination.
+		 */
 		memcpy(nsbp, nilfs->ns_sbp[sb2i], nilfs->ns_sbsize);
+
+		/*
+		 * Zero fill after copy to avoid overwriting in case of move
+		 * within the same block.
+		 */
+		memset(nsbh->b_data, 0, offset);
+		memset((void *)nsbp + nilfs->ns_sbsize, 0,
+		       nsbh->b_size - offset - nilfs->ns_sbsize);
+	} else {
+		memset(nsbh->b_data, 0, nsbh->b_size);
+	}
+	set_buffer_uptodate(nsbh);
+	unlock_buffer(nsbh);
+
+	if (sb2i >= 0) {
 		brelse(nilfs->ns_sbh[sb2i]);
 		nilfs->ns_sbh[sb2i] = nsbh;
 		nilfs->ns_sbp[sb2i] = nsbp;
diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
index 8e364cbdd14a..651c0fe56757 100644
--- a/include/acpi/acpixf.h
+++ b/include/acpi/acpixf.h
@@ -761,6 +761,7 @@ ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status
 						     acpi_event_status
 						     *event_status))
 ACPI_HW_DEPENDENT_RETURN_UINT32(u32 acpi_dispatch_gpe(acpi_handle gpe_device, u32 gpe_number))
+ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_hw_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_disable_all_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_runtime_gpes(void))
 ACPI_HW_DEPENDENT_RETURN_STATUS(acpi_status acpi_enable_all_wakeup_gpes(void))
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index d1f57e4868ed..7058b01e9f14 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -839,6 +839,9 @@
 
 #ifdef CONFIG_UNWINDER_ORC
 #define ORC_UNWIND_TABLE						\
+	.orc_header : AT(ADDR(.orc_header) - LOAD_OFFSET) {		\
+		BOUNDED_SECTION_BY(.orc_header, _orc_header)		\
+	}								\
 	. = ALIGN(4);							\
 	.orc_unwind_ip : AT(ADDR(.orc_unwind_ip) - LOAD_OFFSET) {	\
 		BOUNDED_SECTION_BY(.orc_unwind_ip, _orc_unwind_ip)	\
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index ccd8a512d854..b769ff6b00fd 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -244,6 +244,14 @@ struct gpio_irq_chip {
 	 */
 	bool initialized;
 
+	/**
+	 * @domain_is_allocated_externally:
+	 *
+	 * True it the irq_domain was allocated outside of gpiolib, in which
+	 * case gpiolib won't free the irq_domain itself.
+	 */
+	bool domain_is_allocated_externally;
+
 	/**
 	 * @init_hw: optional routine to initialize hardware before
 	 * an IRQ chip will be added. This is quite useful when
diff --git a/include/linux/libata.h b/include/linux/libata.h
index a759dfbdcc91..bb5dda3ec2db 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -836,7 +836,7 @@ struct ata_port {
 
 	struct mutex		scsi_scan_mutex;
 	struct delayed_work	hotplug_task;
-	struct work_struct	scsi_rescan_task;
+	struct delayed_work	scsi_rescan_task;
 
 	unsigned int		hsm_task_state;
 
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 0d797f3367ca..1463cbda4888 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -57,12 +57,20 @@ static inline int user_path_at(int dfd, const char __user *name, unsigned flags,
 	return user_path_at_empty(dfd, name, flags, path, NULL);
 }
 
+struct dentry *lookup_one_qstr_excl(const struct qstr *name,
+				    struct dentry *base,
+				    unsigned int flags);
 extern int kern_path(const char *, unsigned, struct path *);
 
 extern struct dentry *kern_path_create(int, const char *, struct path *, unsigned int);
 extern struct dentry *user_path_create(int, const char __user *, struct path *, unsigned int);
 extern void done_path_create(struct path *, struct dentry *);
 extern struct dentry *kern_path_locked(const char *, struct path *);
+int vfs_path_parent_lookup(struct filename *filename, unsigned int flags,
+			   struct path *parent, struct qstr *last, int *type,
+			   const struct path *root);
+int vfs_path_lookup(struct dentry *, struct vfsmount *, const char *,
+		    unsigned int, struct path *);
 
 extern struct dentry *try_lookup_one_len(const char *, struct dentry *, int);
 extern struct dentry *lookup_one_len(const char *, struct dentry *, int);
@@ -81,6 +89,7 @@ extern int follow_down(struct path *path, unsigned int flags);
 extern int follow_up(struct path *);
 
 extern struct dentry *lock_rename(struct dentry *, struct dentry *);
+extern struct dentry *lock_rename_child(struct dentry *, struct dentry *);
 extern void unlock_rename(struct dentry *, struct dentry *);
 
 extern int __must_check nd_jump_link(const struct path *path);
diff --git a/include/linux/regulator/pca9450.h b/include/linux/regulator/pca9450.h
index 3c01c2bf84f5..505c908dbb81 100644
--- a/include/linux/regulator/pca9450.h
+++ b/include/linux/regulator/pca9450.h
@@ -196,11 +196,11 @@ enum {
 
 /* PCA9450_REG_LDO3_VOLT bits */
 #define LDO3_EN_MASK			0xC0
-#define LDO3OUT_MASK			0x0F
+#define LDO3OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO4_VOLT bits */
 #define LDO4_EN_MASK			0xC0
-#define LDO4OUT_MASK			0x0F
+#define LDO4OUT_MASK			0x1F
 
 /* PCA9450_REG_LDO5_VOLT bits */
 #define LDO5L_EN_MASK			0xC0
diff --git a/include/net/dsa.h b/include/net/dsa.h
index a15f17a38eca..def06ef676dd 100644
--- a/include/net/dsa.h
+++ b/include/net/dsa.h
@@ -973,6 +973,14 @@ struct dsa_switch_ops {
 			       struct phy_device *phy);
 	void	(*port_disable)(struct dsa_switch *ds, int port);
 
+	/*
+	 * Compatibility between device trees defining multiple CPU ports and
+	 * drivers which are not OK to use by default the numerically smallest
+	 * CPU port of a switch for its local ports. This can return NULL,
+	 * meaning "don't know/don't care".
+	 */
+	struct dsa_port *(*preferred_default_local_cpu_port)(struct dsa_switch *ds);
+
 	/*
 	 * Port's MAC EEE settings
 	 */
diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 300bce4d67ce..730c63ceee56 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -472,7 +472,8 @@ struct nft_set_ops {
 	int				(*init)(const struct nft_set *set,
 						const struct nft_set_desc *desc,
 						const struct nlattr * const nla[]);
-	void				(*destroy)(const struct nft_set *set);
+	void				(*destroy)(const struct nft_ctx *ctx,
+						   const struct nft_set *set);
 	void				(*gc_init)(const struct nft_set *set);
 
 	unsigned int			elemsize;
@@ -809,6 +810,8 @@ int nft_set_elem_expr_clone(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_expr *expr_array[]);
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr);
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem);
 
 /**
  *	struct nft_set_gc_batch_head - nf_tables set garbage collection batch
@@ -901,6 +904,7 @@ struct nft_expr_type {
 
 enum nft_trans_phase {
 	NFT_TRANS_PREPARE,
+	NFT_TRANS_PREPARE_ERROR,
 	NFT_TRANS_ABORT,
 	NFT_TRANS_COMMIT,
 	NFT_TRANS_RELEASE
@@ -1009,7 +1013,10 @@ static inline struct nft_userdata *nft_userdata(const struct nft_rule *rule)
 	return (void *)&rule->data[rule->dlen];
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule);
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase);
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule);
 
 static inline void nft_set_elem_update_expr(const struct nft_set_ext *ext,
 					    struct nft_regs *regs,
@@ -1092,6 +1099,8 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 			 const struct nft_set_iter *iter,
 			 struct nft_set_elem *elem);
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set);
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain);
 
 enum nft_chain_types {
 	NFT_CHAIN_T_DEFAULT = 0,
@@ -1128,11 +1137,17 @@ int nft_chain_validate_dependency(const struct nft_chain *chain,
 int nft_chain_validate_hooks(const struct nft_chain *chain,
                              unsigned int hook_flags);
 
+static inline bool nft_chain_binding(const struct nft_chain *chain)
+{
+	return chain->flags & NFT_CHAIN_BINDING;
+}
+
 static inline bool nft_chain_is_bound(struct nft_chain *chain)
 {
 	return (chain->flags & NFT_CHAIN_BINDING) && chain->bound;
 }
 
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain);
 void nft_chain_del(struct nft_chain *chain);
 void nf_tables_chain_destroy(struct nft_ctx *ctx);
 
@@ -1550,6 +1565,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  *	struct nft_trans - nf_tables object update in transaction
  *
  *	@list: used internally
+ *	@binding_list: list of objects with possible bindings
  *	@msg_type: message type
  *	@put_net: ctx->net needs to be put
  *	@ctx: transaction context
@@ -1557,6 +1573,7 @@ static inline void nft_set_elem_clear_busy(struct nft_set_ext *ext)
  */
 struct nft_trans {
 	struct list_head		list;
+	struct list_head		binding_list;
 	int				msg_type;
 	bool				put_net;
 	struct nft_ctx			ctx;
@@ -1567,6 +1584,7 @@ struct nft_trans_rule {
 	struct nft_rule			*rule;
 	struct nft_flow_rule		*flow;
 	u32				rule_id;
+	bool				bound;
 };
 
 #define nft_trans_rule(trans)	\
@@ -1575,6 +1593,8 @@ struct nft_trans_rule {
 	(((struct nft_trans_rule *)trans->data)->flow)
 #define nft_trans_rule_id(trans)	\
 	(((struct nft_trans_rule *)trans->data)->rule_id)
+#define nft_trans_rule_bound(trans)	\
+	(((struct nft_trans_rule *)trans->data)->bound)
 
 struct nft_trans_set {
 	struct nft_set			*set;
@@ -1599,15 +1619,19 @@ struct nft_trans_set {
 	(((struct nft_trans_set *)trans->data)->gc_int)
 
 struct nft_trans_chain {
+	struct nft_chain		*chain;
 	bool				update;
 	char				*name;
 	struct nft_stats __percpu	*stats;
 	u8				policy;
+	bool				bound;
 	u32				chain_id;
 	struct nft_base_chain		*basechain;
 	struct list_head		hook_list;
 };
 
+#define nft_trans_chain(trans)	\
+	(((struct nft_trans_chain *)trans->data)->chain)
 #define nft_trans_chain_update(trans)	\
 	(((struct nft_trans_chain *)trans->data)->update)
 #define nft_trans_chain_name(trans)	\
@@ -1616,6 +1640,8 @@ struct nft_trans_chain {
 	(((struct nft_trans_chain *)trans->data)->stats)
 #define nft_trans_chain_policy(trans)	\
 	(((struct nft_trans_chain *)trans->data)->policy)
+#define nft_trans_chain_bound(trans)	\
+	(((struct nft_trans_chain *)trans->data)->bound)
 #define nft_trans_chain_id(trans)	\
 	(((struct nft_trans_chain *)trans->data)->chain_id)
 #define nft_trans_basechain(trans)	\
@@ -1692,6 +1718,7 @@ static inline int nft_request_module(struct net *net, const char *fmt, ...) { re
 struct nftables_pernet {
 	struct list_head	tables;
 	struct list_head	commit_list;
+	struct list_head	binding_list;
 	struct list_head	module_list;
 	struct list_head	notify_list;
 	struct mutex		commit_mutex;
diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 3e1f70e8e424..47ecf1d4719b 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1049,6 +1049,7 @@ struct xfrm_offload {
 struct sec_path {
 	int			len;
 	int			olen;
+	int			verified_cnt;
 
 	struct xfrm_state	*xvec[XFRM_MAX_DEPTH];
 	struct xfrm_offload	ovec[XFRM_MAX_OFFLOAD_DEPTH];
diff --git a/include/target/iscsi/iscsi_target_core.h b/include/target/iscsi/iscsi_target_core.h
index 229118156a1f..4c15420e8965 100644
--- a/include/target/iscsi/iscsi_target_core.h
+++ b/include/target/iscsi/iscsi_target_core.h
@@ -562,12 +562,13 @@ struct iscsit_conn {
 #define LOGIN_FLAGS_READ_ACTIVE		2
 #define LOGIN_FLAGS_WRITE_ACTIVE	3
 #define LOGIN_FLAGS_CLOSED		4
+#define LOGIN_FLAGS_WORKER_RUNNING	5
 	unsigned long		login_flags;
 	struct delayed_work	login_work;
 	struct iscsi_login	*login;
 	struct timer_list	nopin_timer;
 	struct timer_list	nopin_response_timer;
-	struct timer_list	transport_timer;
+	struct timer_list	login_timer;
 	struct task_struct	*login_kworker;
 	/* Spinlock used for add/deleting cmd's from conn_cmd_list */
 	spinlock_t		cmd_lock;
@@ -576,6 +577,8 @@ struct iscsit_conn {
 	spinlock_t		nopin_timer_lock;
 	spinlock_t		response_queue_lock;
 	spinlock_t		state_lock;
+	spinlock_t		login_timer_lock;
+	spinlock_t		login_worker_lock;
 	/* libcrypto RX and TX contexts for crc32c */
 	struct ahash_request	*conn_rx_hash;
 	struct ahash_request	*conn_tx_hash;
@@ -792,7 +795,6 @@ struct iscsi_np {
 	enum np_thread_state_table np_thread_state;
 	bool                    enabled;
 	atomic_t		np_reset_count;
-	enum iscsi_timer_flags_table np_login_timer_flags;
 	u32			np_exports;
 	enum np_flags_table	np_flags;
 	spinlock_t		np_thread_lock;
@@ -800,7 +802,6 @@ struct iscsi_np {
 	struct socket		*np_socket;
 	struct sockaddr_storage np_sockaddr;
 	struct task_struct	*np_thread;
-	struct timer_list	np_login_timer;
 	void			*np_context;
 	struct iscsit_transport *np_transport;
 	struct list_head	np_list;
diff --git a/include/trace/events/writeback.h b/include/trace/events/writeback.h
index 86b2a82da546..54e353c9f919 100644
--- a/include/trace/events/writeback.h
+++ b/include/trace/events/writeback.h
@@ -68,7 +68,7 @@ DECLARE_EVENT_CLASS(writeback_folio_template,
 		strscpy_pad(__entry->name,
 			    bdi_dev_name(mapping ? inode_to_bdi(mapping->host) :
 					 NULL), 32);
-		__entry->ino = mapping ? mapping->host->i_ino : 0;
+		__entry->ino = (mapping && mapping->host) ? mapping->host->i_ino : 0;
 		__entry->index = folio->index;
 	),
 
diff --git a/io_uring/net.c b/io_uring/net.c
index 05fd285ac75a..2cf671cef0b6 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -203,7 +203,7 @@ static int io_sendmsg_copy_hdr(struct io_kiocb *req,
 	ret = sendmsg_copy_msghdr(&iomsg->msg, sr->umsg, sr->msg_flags,
 					&iomsg->free_iov);
 	/* save msg_control as sys_sendmsg() overwrites it */
-	sr->msg_control = iomsg->msg.msg_control;
+	sr->msg_control = iomsg->msg.msg_control_user;
 	return ret;
 }
 
@@ -302,7 +302,7 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 
 	if (req_has_async_data(req)) {
 		kmsg = req->async_data;
-		kmsg->msg.msg_control = sr->msg_control;
+		kmsg->msg.msg_control_user = sr->msg_control;
 	} else {
 		ret = io_sendmsg_copy_hdr(req, &iomsg);
 		if (ret)
@@ -326,6 +326,8 @@ int io_sendmsg(struct io_kiocb *req, unsigned int issue_flags)
 		if (ret == -EAGAIN && (issue_flags & IO_URING_F_NONBLOCK))
 			return io_setup_async_msg(req, kmsg, issue_flags);
 		if (ret > 0 && io_net_retry(sock, flags)) {
+			kmsg->msg.msg_controllen = 0;
+			kmsg->msg.msg_control = NULL;
 			sr->done_io += ret;
 			req->flags |= REQ_F_PARTIAL_IO;
 			return io_setup_async_msg(req, kmsg, issue_flags);
@@ -787,16 +789,19 @@ int io_recvmsg(struct io_kiocb *req, unsigned int issue_flags)
 	flags = sr->msg_flags;
 	if (force_nonblock)
 		flags |= MSG_DONTWAIT;
-	if (flags & MSG_WAITALL)
-		min_ret = iov_iter_count(&kmsg->msg.msg_iter);
 
 	kmsg->msg.msg_get_inq = 1;
-	if (req->flags & REQ_F_APOLL_MULTISHOT)
+	if (req->flags & REQ_F_APOLL_MULTISHOT) {
 		ret = io_recvmsg_multishot(sock, sr, kmsg, flags,
 					   &mshot_finished);
-	else
+	} else {
+		/* disable partial retry for recvmsg with cmsg attached */
+		if (flags & MSG_WAITALL && !kmsg->msg.msg_controllen)
+			min_ret = iov_iter_count(&kmsg->msg.msg_iter);
+
 		ret = __sys_recvmsg_sock(sock, &kmsg->msg, sr->umsg,
 					 kmsg->uaddr, flags);
+	}
 
 	if (ret < min_ret) {
 		if (ret == -EAGAIN && force_nonblock) {
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 55306e801081..e346a518dfcf 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -977,8 +977,9 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_hash_bucket *bucket;
 	struct io_kiocb *preq;
 	int ret2, ret = 0;
-	bool locked;
+	bool locked = true;
 
+	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table, &bucket);
 	ret2 = io_poll_disarm(preq);
 	if (bucket)
@@ -990,12 +991,10 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 		goto out;
 	}
 
-	io_ring_submit_lock(ctx, issue_flags);
 	preq = io_poll_find(ctx, true, &cd, &ctx->cancel_table_locked, &bucket);
 	ret2 = io_poll_disarm(preq);
 	if (bucket)
 		spin_unlock(&bucket->lock);
-	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret2) {
 		ret = ret2;
 		goto out;
@@ -1019,7 +1018,7 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 		if (poll_update->update_user_data)
 			preq->cqe.user_data = poll_update->new_user_data;
 
-		ret2 = io_poll_add(preq, issue_flags);
+		ret2 = io_poll_add(preq, issue_flags & ~IO_URING_F_UNLOCKED);
 		/* successfully updated, don't complete poll request */
 		if (!ret2 || ret2 == -EIOCBQUEUED)
 			goto out;
@@ -1027,9 +1026,9 @@ int io_poll_remove(struct io_kiocb *req, unsigned int issue_flags)
 
 	req_set_fail(preq);
 	io_req_set_res(preq, -ECANCELED, 0);
-	locked = !(issue_flags & IO_URING_F_UNLOCKED);
 	io_req_task_complete(preq, &locked);
 out:
+	io_ring_submit_unlock(ctx, issue_flags);
 	if (ret < 0) {
 		req_set_fail(req);
 		return ret;
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 46bce5577fb4..3cc3232f8c33 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -735,13 +735,12 @@ static bool btf_name_offset_valid(const struct btf *btf, u32 offset)
 	return offset < btf->hdr.str_len;
 }
 
-static bool __btf_name_char_ok(char c, bool first, bool dot_ok)
+static bool __btf_name_char_ok(char c, bool first)
 {
 	if ((first ? !isalpha(c) :
 		     !isalnum(c)) &&
 	    c != '_' &&
-	    ((c == '.' && !dot_ok) ||
-	      c != '.'))
+	    c != '.')
 		return false;
 	return true;
 }
@@ -758,20 +757,20 @@ static const char *btf_str_by_offset(const struct btf *btf, u32 offset)
 	return NULL;
 }
 
-static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
+static bool __btf_name_valid(const struct btf *btf, u32 offset)
 {
 	/* offset must be valid */
 	const char *src = btf_str_by_offset(btf, offset);
 	const char *src_limit;
 
-	if (!__btf_name_char_ok(*src, true, dot_ok))
+	if (!__btf_name_char_ok(*src, true))
 		return false;
 
 	/* set a limit on identifier length */
 	src_limit = src + KSYM_NAME_LEN;
 	src++;
 	while (*src && src < src_limit) {
-		if (!__btf_name_char_ok(*src, false, dot_ok))
+		if (!__btf_name_char_ok(*src, false))
 			return false;
 		src++;
 	}
@@ -779,17 +778,14 @@ static bool __btf_name_valid(const struct btf *btf, u32 offset, bool dot_ok)
 	return !*src;
 }
 
-/* Only C-style identifier is permitted. This can be relaxed if
- * necessary.
- */
 static bool btf_name_valid_identifier(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, false);
+	return __btf_name_valid(btf, offset);
 }
 
 static bool btf_name_valid_section(const struct btf *btf, u32 offset)
 {
-	return __btf_name_valid(btf, offset, true);
+	return __btf_name_valid(btf, offset);
 }
 
 static const char *__btf_name_by_offset(const struct btf *btf, u32 offset)
@@ -4450,7 +4446,7 @@ static s32 btf_var_check_meta(struct btf_verifier_env *env,
 	}
 
 	if (!t->name_off ||
-	    !__btf_name_valid(env->btf, t->name_off, true)) {
+	    !__btf_name_valid(env->btf, t->name_off)) {
 		btf_verifier_log_type(env, t, "Invalid name");
 		return -EINVAL;
 	}
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index adc83cb82f37..8bd5e3741d41 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3412,6 +3412,11 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
 		return prog->enforce_expected_attach_type &&
 			prog->expected_attach_type != attach_type ?
 			-EINVAL : 0;
+	case BPF_PROG_TYPE_KPROBE:
+		if (prog->expected_attach_type == BPF_TRACE_KPROBE_MULTI &&
+		    attach_type != BPF_TRACE_KPROBE_MULTI)
+			return -EINVAL;
+		return 0;
 	default:
 		return 0;
 	}
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed149cc9f64..b03999013744 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3559,6 +3559,9 @@ static int check_stack_write_fixed_off(struct bpf_verifier_env *env,
 				return err;
 		}
 		save_register_state(state, spi, reg, size);
+		/* Break the relation on a narrowing spill. */
+		if (fls64(reg->umax_value) > BITS_PER_BYTE * size)
+			state->stack[spi].spilled_ptr.id = 0;
 	} else if (!reg && !(off % BPF_REG_SIZE) && is_bpf_st_mem(insn) &&
 		   insn->imm != 0 && env->bpf_capable) {
 		struct bpf_reg_state fake_reg = {};
@@ -16198,9 +16201,10 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	}
 
 	/* finally lock prog and jit images for all functions and
-	 * populate kallsysm
+	 * populate kallsysm. Begin at the first subprogram, since
+	 * bpf_prog_load will add the kallsyms for the main program.
 	 */
-	for (i = 0; i < env->subprog_cnt; i++) {
+	for (i = 1; i < env->subprog_cnt; i++) {
 		bpf_prog_lock_ro(func[i]);
 		bpf_prog_kallsyms_add(func[i]);
 	}
@@ -16226,6 +16230,8 @@ static int jit_subprogs(struct bpf_verifier_env *env)
 	prog->jited = 1;
 	prog->bpf_func = func[0]->bpf_func;
 	prog->jited_len = func[0]->jited_len;
+	prog->aux->extable = func[0]->aux->extable;
+	prog->aux->num_exentries = func[0]->aux->num_exentries;
 	prog->aux->func = func;
 	prog->aux->func_cnt = env->subprog_cnt;
 	bpf_prog_jit_attempt_done(prog);
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index fd57c1dca1cc..dad3eacf5126 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1788,7 +1788,7 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 {
 	struct cgroup *dcgrp = &dst_root->cgrp;
 	struct cgroup_subsys *ss;
-	int ssid, i, ret;
+	int ssid, ret;
 	u16 dfl_disable_ss_mask = 0;
 
 	lockdep_assert_held(&cgroup_mutex);
@@ -1832,7 +1832,8 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		struct cgroup_root *src_root = ss->root;
 		struct cgroup *scgrp = &src_root->cgrp;
 		struct cgroup_subsys_state *css = cgroup_css(scgrp, ss);
-		struct css_set *cset;
+		struct css_set *cset, *cset_pos;
+		struct css_task_iter *it;
 
 		WARN_ON(!css || cgroup_css(dcgrp, ss));
 
@@ -1850,9 +1851,22 @@ int rebind_subsystems(struct cgroup_root *dst_root, u16 ss_mask)
 		css->cgroup = dcgrp;
 
 		spin_lock_irq(&css_set_lock);
-		hash_for_each(css_set_table, i, cset, hlist)
+		WARN_ON(!list_empty(&dcgrp->e_csets[ss->id]));
+		list_for_each_entry_safe(cset, cset_pos, &scgrp->e_csets[ss->id],
+					 e_cset_node[ss->id]) {
 			list_move_tail(&cset->e_cset_node[ss->id],
 				       &dcgrp->e_csets[ss->id]);
+			/*
+			 * all css_sets of scgrp together in same order to dcgrp,
+			 * patch in-flight iterators to preserve correct iteration.
+			 * since the iterator is always advanced right away and
+			 * finished when it->cset_pos meets it->cset_head, so only
+			 * update it->cset_head is enough here.
+			 */
+			list_for_each_entry(it, &cset->task_iters, iters_node)
+				if (it->cset_head == &scgrp->e_csets[ss->id])
+					it->cset_head = &dcgrp->e_csets[ss->id];
+		}
 		spin_unlock_irq(&css_set_lock);
 
 		if (ss->css_rstat_flush) {
diff --git a/kernel/cgroup/legacy_freezer.c b/kernel/cgroup/legacy_freezer.c
index 936473203a6b..122dacb3a443 100644
--- a/kernel/cgroup/legacy_freezer.c
+++ b/kernel/cgroup/legacy_freezer.c
@@ -108,16 +108,18 @@ static int freezer_css_online(struct cgroup_subsys_state *css)
 	struct freezer *freezer = css_freezer(css);
 	struct freezer *parent = parent_freezer(freezer);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	freezer->state |= CGROUP_FREEZER_ONLINE;
 
 	if (parent && (parent->state & CGROUP_FREEZING)) {
 		freezer->state |= CGROUP_FREEZING_PARENT | CGROUP_FROZEN;
-		static_branch_inc(&freezer_active);
+		static_branch_inc_cpuslocked(&freezer_active);
 	}
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 	return 0;
 }
 
@@ -132,14 +134,16 @@ static void freezer_css_offline(struct cgroup_subsys_state *css)
 {
 	struct freezer *freezer = css_freezer(css);
 
+	cpus_read_lock();
 	mutex_lock(&freezer_mutex);
 
 	if (freezer->state & CGROUP_FREEZING)
-		static_branch_dec(&freezer_active);
+		static_branch_dec_cpuslocked(&freezer_active);
 
 	freezer->state = 0;
 
 	mutex_unlock(&freezer_mutex);
+	cpus_read_unlock();
 }
 
 static void freezer_css_free(struct cgroup_subsys_state *css)
diff --git a/kernel/time/tick-common.c b/kernel/time/tick-common.c
index 65b8658da829..e9138cd7a0f5 100644
--- a/kernel/time/tick-common.c
+++ b/kernel/time/tick-common.c
@@ -218,19 +218,8 @@ static void tick_setup_device(struct tick_device *td,
 		 * this cpu:
 		 */
 		if (tick_do_timer_cpu == TICK_DO_TIMER_BOOT) {
-			ktime_t next_p;
-			u32 rem;
-
 			tick_do_timer_cpu = cpu;
-
-			next_p = ktime_get();
-			div_u64_rem(next_p, TICK_NSEC, &rem);
-			if (rem) {
-				next_p -= rem;
-				next_p += TICK_NSEC;
-			}
-
-			tick_next_period = next_p;
+			tick_next_period = ktime_get();
 #ifdef CONFIG_NO_HZ_FULL
 			/*
 			 * The boot CPU may be nohz_full, in which case set
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index a46506f7ec6d..d6fb6a676bbb 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -161,8 +161,19 @@ static ktime_t tick_init_jiffy_update(void)
 	raw_spin_lock(&jiffies_lock);
 	write_seqcount_begin(&jiffies_seq);
 	/* Did we start the jiffies update yet ? */
-	if (last_jiffies_update == 0)
+	if (last_jiffies_update == 0) {
+		u32 rem;
+
+		/*
+		 * Ensure that the tick is aligned to a multiple of
+		 * TICK_NSEC.
+		 */
+		div_u64_rem(tick_next_period, TICK_NSEC, &rem);
+		if (rem)
+			tick_next_period += TICK_NSEC - rem;
+
 		last_jiffies_update = tick_next_period;
+	}
 	period = last_jiffies_update;
 	write_seqcount_end(&jiffies_seq);
 	raw_spin_unlock(&jiffies_lock);
diff --git a/mm/maccess.c b/mm/maccess.c
index 074f6b086671..518a25667323 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -5,6 +5,7 @@
 #include <linux/export.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <asm/tlb.h>
 
 bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 		size_t size)
@@ -113,11 +114,16 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 long copy_from_user_nofault(void *dst, const void __user *src, size_t size)
 {
 	long ret = -EFAULT;
-	if (access_ok(src, size)) {
-		pagefault_disable();
-		ret = __copy_from_user_inatomic(dst, src, size);
-		pagefault_enable();
-	}
+
+	if (!__access_ok(src, size))
+		return ret;
+
+	if (!nmi_uaccess_okay())
+		return ret;
+
+	pagefault_disable();
+	ret = __copy_from_user_inatomic(dst, src, size);
+	pagefault_enable();
 
 	if (ret)
 		return -EFAULT;
diff --git a/mm/memfd.c b/mm/memfd.c
index a0a7a37e8177..0382f001e2a0 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -375,12 +375,15 @@ SYSCALL_DEFINE2(memfd_create,
 
 		inode->i_mode &= ~0111;
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
-		*file_seals |= F_SEAL_EXEC;
+		if (file_seals) {
+			*file_seals &= ~F_SEAL_SEAL;
+			*file_seals |= F_SEAL_EXEC;
+		}
 	} else if (flags & MFD_ALLOW_SEALING) {
 		/* MFD_EXEC and MFD_ALLOW_SEALING are set */
 		file_seals = memfd_file_seals_ptr(file);
-		*file_seals &= ~F_SEAL_SEAL;
+		if (file_seals)
+			*file_seals &= ~F_SEAL_SEAL;
 	}
 
 	fd_install(fd, file);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index 36351a00c0e8..498de2c2f2c4 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -838,7 +838,7 @@ static int do_mprotect_pkey(unsigned long start, size_t len,
 	}
 	tlb_finish_mmu(&tlb);
 
-	if (!error && vma_iter_end(&vmi) < end)
+	if (!error && tmp < end)
 		error = -ENOMEM;
 
 out:
diff --git a/mm/usercopy.c b/mm/usercopy.c
index 4c3164beacec..83c164aba6e0 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -173,7 +173,7 @@ static inline void check_heap_object(const void *ptr, unsigned long n,
 		return;
 	}
 
-	if (is_vmalloc_addr(ptr)) {
+	if (is_vmalloc_addr(ptr) && !pagefault_disabled()) {
 		struct vmap_area *area = find_vmap_area(addr);
 
 		if (!area)
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 31ff782d368b..f908abba4d4a 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3046,11 +3046,20 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	 * allocation request, free them via vfree() if any.
 	 */
 	if (area->nr_pages != nr_small_pages) {
-		/* vm_area_alloc_pages() can also fail due to a fatal signal */
-		if (!fatal_signal_pending(current))
+		/*
+		 * vm_area_alloc_pages() can fail due to insufficient memory but
+		 * also:-
+		 *
+		 * - a pending fatal signal
+		 * - insufficient huge page-order pages
+		 *
+		 * Since we always retry allocations at order-0 in the huge page
+		 * case a warning for either is spurious.
+		 */
+		if (!fatal_signal_pending(current) && page_order == 0)
 			warn_alloc(gfp_mask, NULL,
-				"vmalloc error: size %lu, page order %u, failed to allocate pages",
-				area->nr_pages * PAGE_SIZE, page_order);
+				"vmalloc error: size %lu, failed to allocate pages",
+				area->nr_pages * PAGE_SIZE);
 		goto fail;
 	}
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 3fd71f343c9f..b34c48f802e9 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1362,12 +1362,6 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		__sock_set_mark(sk, val);
 		break;
 	case SO_RCVMARK:
-		if (!sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_RAW) &&
-		    !sockopt_ns_capable(sock_net(sk)->user_ns, CAP_NET_ADMIN)) {
-			ret = -EPERM;
-			break;
-		}
-
 		sock_valbool_flag(sk, SOCK_RCVMARK, valbool);
 		break;
 
diff --git a/net/dsa/dsa.c b/net/dsa/dsa.c
index e5f156940c67..6cd8607a3928 100644
--- a/net/dsa/dsa.c
+++ b/net/dsa/dsa.c
@@ -402,6 +402,24 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
 	return 0;
 }
 
+static struct dsa_port *
+dsa_switch_preferred_default_local_cpu_port(struct dsa_switch *ds)
+{
+	struct dsa_port *cpu_dp;
+
+	if (!ds->ops->preferred_default_local_cpu_port)
+		return NULL;
+
+	cpu_dp = ds->ops->preferred_default_local_cpu_port(ds);
+	if (!cpu_dp)
+		return NULL;
+
+	if (WARN_ON(!dsa_port_is_cpu(cpu_dp) || cpu_dp->ds != ds))
+		return NULL;
+
+	return cpu_dp;
+}
+
 /* Perform initial assignment of CPU ports to user ports and DSA links in the
  * fabric, giving preference to CPU ports local to each switch. Default to
  * using the first CPU port in the switch tree if the port does not have a CPU
@@ -409,12 +427,16 @@ static int dsa_tree_setup_default_cpu(struct dsa_switch_tree *dst)
  */
 static int dsa_tree_setup_cpu_ports(struct dsa_switch_tree *dst)
 {
-	struct dsa_port *cpu_dp, *dp;
+	struct dsa_port *preferred_cpu_dp, *cpu_dp, *dp;
 
 	list_for_each_entry(cpu_dp, &dst->ports, list) {
 		if (!dsa_port_is_cpu(cpu_dp))
 			continue;
 
+		preferred_cpu_dp = dsa_switch_preferred_default_local_cpu_port(cpu_dp->ds);
+		if (preferred_cpu_dp && preferred_cpu_dp != cpu_dp)
+			continue;
+
 		/* Prefer a local CPU port */
 		dsa_switch_for_each_port(dp, cpu_dp->ds) {
 			/* Prefer the first local CPU port found */
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index 3969fa805679..ee848be59e65 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -340,6 +340,9 @@ static int esp_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features_
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv4/xfrm4_input.c b/net/ipv4/xfrm4_input.c
index ad2afeef4f10..eac206a290d0 100644
--- a/net/ipv4/xfrm4_input.c
+++ b/net/ipv4/xfrm4_input.c
@@ -164,6 +164,7 @@ int xfrm4_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	kfree_skb(skb);
 	return 0;
 }
+EXPORT_SYMBOL(xfrm4_udp_encap_rcv);
 
 int xfrm4_rcv(struct sk_buff *skb)
 {
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 75c02992c520..772340268997 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -374,6 +374,9 @@ static int esp6_xmit(struct xfrm_state *x, struct sk_buff *skb,  netdev_features
 
 	secpath_reset(skb);
 
+	if (skb_needs_linearize(skb, skb->dev->features) &&
+	    __skb_linearize(skb))
+		return -ENOMEM;
 	return 0;
 }
 
diff --git a/net/ipv6/xfrm6_input.c b/net/ipv6/xfrm6_input.c
index 04cbeefd8982..4907ab241d6b 100644
--- a/net/ipv6/xfrm6_input.c
+++ b/net/ipv6/xfrm6_input.c
@@ -86,6 +86,9 @@ int xfrm6_udp_encap_rcv(struct sock *sk, struct sk_buff *skb)
 	__be32 *udpdata32;
 	__u16 encap_type = up->encap_type;
 
+	if (skb->protocol == htons(ETH_P_IP))
+		return xfrm4_udp_encap_rcv(sk, skb);
+
 	/* if this is not encapsulated socket, then just return now */
 	if (!encap_type)
 		return 1;
diff --git a/net/mptcp/pm_netlink.c b/net/mptcp/pm_netlink.c
index 5396907cc596..7b185a064acc 100644
--- a/net/mptcp/pm_netlink.c
+++ b/net/mptcp/pm_netlink.c
@@ -1047,6 +1047,7 @@ static int mptcp_pm_nl_create_listen_socket(struct sock *sk,
 	if (err)
 		return err;
 
+	inet_sk_state_store(newsk, TCP_LISTEN);
 	err = kernel_listen(ssock, backlog);
 	if (err)
 		return err;
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 0e7c194948cf..a08b7419062c 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -44,7 +44,7 @@ enum {
 static struct percpu_counter mptcp_sockets_allocated ____cacheline_aligned_in_smp;
 
 static void __mptcp_destroy_sock(struct sock *sk);
-static void __mptcp_check_send_data_fin(struct sock *sk);
+static void mptcp_check_send_data_fin(struct sock *sk);
 
 DEFINE_PER_CPU(struct mptcp_delegated_action, mptcp_delegated_actions);
 static struct net_device mptcp_napi_dev;
@@ -411,8 +411,7 @@ static bool mptcp_pending_data_fin_ack(struct sock *sk)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	return !__mptcp_check_fallback(msk) &&
-	       ((1 << sk->sk_state) &
+	return ((1 << sk->sk_state) &
 		(TCPF_FIN_WAIT1 | TCPF_CLOSING | TCPF_LAST_ACK)) &&
 	       msk->write_seq == READ_ONCE(msk->snd_una);
 }
@@ -570,9 +569,6 @@ static bool mptcp_check_data_fin(struct sock *sk)
 	u64 rcv_data_fin_seq;
 	bool ret = false;
 
-	if (__mptcp_check_fallback(msk))
-		return ret;
-
 	/* Need to ack a DATA_FIN received from a peer while this side
 	 * of the connection is in ESTABLISHED, FIN_WAIT1, or FIN_WAIT2.
 	 * msk->rcv_data_fin was set when parsing the incoming options
@@ -610,7 +606,8 @@ static bool mptcp_check_data_fin(struct sock *sk)
 		}
 
 		ret = true;
-		mptcp_send_ack(msk);
+		if (!__mptcp_check_fallback(msk))
+			mptcp_send_ack(msk);
 		mptcp_close_wake_up(sk);
 	}
 	return ret;
@@ -837,12 +834,12 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	return true;
 }
 
-static void __mptcp_flush_join_list(struct sock *sk)
+static void __mptcp_flush_join_list(struct sock *sk, struct list_head *join_list)
 {
 	struct mptcp_subflow_context *tmp, *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
-	list_for_each_entry_safe(subflow, tmp, &msk->join_list, node) {
+	list_for_each_entry_safe(subflow, tmp, join_list, node) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast(ssk);
 
@@ -1596,7 +1593,7 @@ void __mptcp_push_pending(struct sock *sk, unsigned int flags)
 	if (!mptcp_timer_pending(sk))
 		mptcp_reset_timer(sk);
 	if (do_check_data_fin)
-		__mptcp_check_send_data_fin(sk);
+		mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool first)
@@ -1696,7 +1693,13 @@ static int mptcp_sendmsg_fastopen(struct sock *sk, struct sock *ssk, struct msgh
 		if (ret && ret != -EINPROGRESS && ret != -ERESTARTSYS && ret != -EINTR)
 			*copied_syn = 0;
 	} else if (ret && ret != -EINPROGRESS) {
-		mptcp_disconnect(sk, 0);
+		/* The disconnect() op called by tcp_sendmsg_fastopen()/
+		 * __inet_stream_connect() can fail, due to looking check,
+		 * see mptcp_disconnect().
+		 * Attempt it again outside the problematic scope.
+		 */
+		if (!mptcp_disconnect(sk, 0))
+			sk->sk_socket->state = SS_UNCONNECTED;
 	}
 
 	return ret;
@@ -2360,7 +2363,10 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 
 	need_push = (flags & MPTCP_CF_PUSH) && __mptcp_retransmit_pending_data(sk);
 	if (!dispose_it) {
-		tcp_disconnect(ssk, 0);
+		/* The MPTCP code never wait on the subflow sockets, TCP-level
+		 * disconnect should never fail
+		 */
+		WARN_ON_ONCE(tcp_disconnect(ssk, 0));
 		msk->subflow->state = SS_UNCONNECTED;
 		mptcp_subflow_ctx_reset(subflow);
 		release_sock(ssk);
@@ -2379,13 +2385,6 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 		kfree_rcu(subflow, rcu);
 	} else {
 		/* otherwise tcp will dispose of the ssk and subflow ctx */
-		if (ssk->sk_state == TCP_LISTEN) {
-			tcp_set_state(ssk, TCP_CLOSE);
-			mptcp_subflow_queue_clean(sk, ssk);
-			inet_csk_listen_stop(ssk);
-			mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
-		}
-
 		__tcp_close(ssk, 0);
 
 		/* close acquired an extra ref */
@@ -2642,8 +2641,6 @@ static void mptcp_worker(struct work_struct *work)
 	if (unlikely((1 << state) & (TCPF_CLOSE | TCPF_LISTEN)))
 		goto unlock;
 
-	mptcp_check_data_fin_ack(sk);
-
 	mptcp_check_fastclose(msk);
 
 	mptcp_pm_nl_work(msk);
@@ -2651,7 +2648,8 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_EOF, &msk->flags))
 		mptcp_check_for_eof(msk);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
+	mptcp_check_data_fin_ack(sk);
 	mptcp_check_data_fin(sk);
 
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
@@ -2787,13 +2785,19 @@ void mptcp_subflow_shutdown(struct sock *sk, struct sock *ssk, int how)
 			break;
 		fallthrough;
 	case TCP_SYN_SENT:
-		tcp_disconnect(ssk, O_NONBLOCK);
+		WARN_ON_ONCE(tcp_disconnect(ssk, O_NONBLOCK));
 		break;
 	default:
 		if (__mptcp_check_fallback(mptcp_sk(sk))) {
 			pr_debug("Fallback");
 			ssk->sk_shutdown |= how;
 			tcp_shutdown(ssk, how);
+
+			/* simulate the data_fin ack reception to let the state
+			 * machine move forward
+			 */
+			WRITE_ONCE(mptcp_sk(sk)->snd_una, mptcp_sk(sk)->snd_nxt);
+			mptcp_schedule_work(sk);
 		} else {
 			pr_debug("Sending DATA_FIN on subflow %p", ssk);
 			tcp_send_ack(ssk);
@@ -2833,7 +2837,7 @@ static int mptcp_close_state(struct sock *sk)
 	return next & TCP_ACTION_FIN;
 }
 
-static void __mptcp_check_send_data_fin(struct sock *sk)
+static void mptcp_check_send_data_fin(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow;
 	struct mptcp_sock *msk = mptcp_sk(sk);
@@ -2851,19 +2855,6 @@ static void __mptcp_check_send_data_fin(struct sock *sk)
 
 	WRITE_ONCE(msk->snd_nxt, msk->write_seq);
 
-	/* fallback socket will not get data_fin/ack, can move to the next
-	 * state now
-	 */
-	if (__mptcp_check_fallback(msk)) {
-		WRITE_ONCE(msk->snd_una, msk->write_seq);
-		if ((1 << sk->sk_state) & (TCPF_CLOSING | TCPF_LAST_ACK)) {
-			inet_sk_state_store(sk, TCP_CLOSE);
-			mptcp_close_wake_up(sk);
-		} else if (sk->sk_state == TCP_FIN_WAIT1) {
-			inet_sk_state_store(sk, TCP_FIN_WAIT2);
-		}
-	}
-
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *tcp_sk = mptcp_subflow_tcp_sock(subflow);
 
@@ -2883,7 +2874,7 @@ static void __mptcp_wr_shutdown(struct sock *sk)
 	WRITE_ONCE(msk->write_seq, msk->write_seq + 1);
 	WRITE_ONCE(msk->snd_data_fin_enable, 1);
 
-	__mptcp_check_send_data_fin(sk);
+	mptcp_check_send_data_fin(sk);
 }
 
 static void __mptcp_destroy_sock(struct sock *sk)
@@ -2928,10 +2919,24 @@ static __poll_t mptcp_check_readable(struct mptcp_sock *msk)
 	return EPOLLIN | EPOLLRDNORM;
 }
 
-static void mptcp_listen_inuse_dec(struct sock *sk)
+static void mptcp_check_listen_stop(struct sock *sk)
 {
-	if (inet_sk_state_load(sk) == TCP_LISTEN)
-		sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	struct sock *ssk;
+
+	if (inet_sk_state_load(sk) != TCP_LISTEN)
+		return;
+
+	sock_prot_inuse_add(sock_net(sk), sk->sk_prot, -1);
+	ssk = mptcp_sk(sk)->first;
+	if (WARN_ON_ONCE(!ssk || inet_sk_state_load(ssk) != TCP_LISTEN))
+		return;
+
+	lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
+	mptcp_subflow_queue_clean(sk, ssk);
+	inet_csk_listen_stop(ssk);
+	mptcp_event_pm_listener(ssk, MPTCP_EVENT_LISTENER_CLOSED);
+	tcp_set_state(ssk, TCP_CLOSE);
+	release_sock(ssk);
 }
 
 bool __mptcp_close(struct sock *sk, long timeout)
@@ -2944,7 +2949,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 	WRITE_ONCE(sk->sk_shutdown, SHUTDOWN_MASK);
 
 	if ((1 << sk->sk_state) & (TCPF_LISTEN | TCPF_CLOSE)) {
-		mptcp_listen_inuse_dec(sk);
+		mptcp_check_listen_stop(sk);
 		inet_sk_state_store(sk, TCP_CLOSE);
 		goto cleanup;
 	}
@@ -3045,15 +3050,20 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 {
 	struct mptcp_sock *msk = mptcp_sk(sk);
 
+	/* Deny disconnect if other threads are blocked in sk_wait_event()
+	 * or inet_wait_for_connect().
+	 */
+	if (sk->sk_wait_pending)
+		return -EBUSY;
+
 	/* We are on the fastopen error path. We can't call straight into the
 	 * subflows cleanup code due to lock nesting (we are already under
-	 * msk->firstsocket lock). Do nothing and leave the cleanup to the
-	 * caller.
+	 * msk->firstsocket lock).
 	 */
 	if (msk->fastopening)
-		return 0;
+		return -EBUSY;
 
-	mptcp_listen_inuse_dec(sk);
+	mptcp_check_listen_stop(sk);
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_timer(sk);
@@ -3112,6 +3122,7 @@ struct sock *mptcp_sk_clone_init(const struct sock *sk,
 		inet_sk(nsk)->pinet6 = mptcp_inet6_sk(nsk);
 #endif
 
+	nsk->sk_wait_pending = 0;
 	__mptcp_init_sock(nsk);
 
 	msk = mptcp_sk(nsk);
@@ -3299,9 +3310,14 @@ static void mptcp_release_cb(struct sock *sk)
 	for (;;) {
 		unsigned long flags = (msk->cb_flags & MPTCP_FLAGS_PROCESS_CTX_NEED) |
 				      msk->push_pending;
+		struct list_head join_list;
+
 		if (!flags)
 			break;
 
+		INIT_LIST_HEAD(&join_list);
+		list_splice_init(&msk->join_list, &join_list);
+
 		/* the following actions acquire the subflow socket lock
 		 *
 		 * 1) can't be invoked in atomic scope
@@ -3312,8 +3328,9 @@ static void mptcp_release_cb(struct sock *sk)
 		msk->push_pending = 0;
 		msk->cb_flags &= ~flags;
 		spin_unlock_bh(&sk->sk_lock.slock);
+
 		if (flags & BIT(MPTCP_FLUSH_JOIN_LIST))
-			__mptcp_flush_join_list(sk);
+			__mptcp_flush_join_list(sk, &join_list);
 		if (flags & BIT(MPTCP_PUSH_PENDING))
 			__mptcp_push_pending(sk, 0);
 		if (flags & BIT(MPTCP_RETRANSMIT))
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index bb0301398d3b..8e0c35c59828 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1749,14 +1749,16 @@ static void subflow_state_change(struct sock *sk)
 {
 	struct mptcp_subflow_context *subflow = mptcp_subflow_ctx(sk);
 	struct sock *parent = subflow->conn;
+	struct mptcp_sock *msk;
 
 	__subflow_state_change(sk);
 
+	msk = mptcp_sk(parent);
 	if (subflow_simultaneous_connect(sk)) {
 		mptcp_propagate_sndbuf(parent, sk);
 		mptcp_do_fallback(sk);
-		mptcp_rcv_space_init(mptcp_sk(parent), sk);
-		pr_fallback(mptcp_sk(parent));
+		mptcp_rcv_space_init(msk, sk);
+		pr_fallback(msk);
 		subflow->conn_finished = 1;
 		mptcp_set_connected(parent);
 	}
@@ -1772,11 +1774,12 @@ static void subflow_state_change(struct sock *sk)
 
 	subflow_sched_work_if_closed(mptcp_sk(parent), sk);
 
-	if (__mptcp_check_fallback(mptcp_sk(parent)) &&
-	    !subflow->rx_eof && subflow_is_done(sk)) {
-		subflow->rx_eof = 1;
-		mptcp_subflow_eof(parent);
-	}
+	/* when the fallback subflow closes the rx side, trigger a 'dummy'
+	 * ingress data fin, so that the msk state will follow along
+	 */
+	if (__mptcp_check_fallback(msk) && subflow_is_done(sk) && msk->first == sk &&
+	    mptcp_update_rcv_data_fin(msk, READ_ONCE(msk->ack_seq), true))
+		mptcp_schedule_work(parent);
 }
 
 void mptcp_subflow_queue_clean(struct sock *listener_sk, struct sock *listener_ssk)
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 80448885c3d7..b452eb3ddcec 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -1225,6 +1225,7 @@ ip_vs_tunnel_xmit(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
@@ -1373,6 +1374,7 @@ ip_vs_tunnel_xmit_v6(struct sk_buff *skb, struct ip_vs_conn *cp,
 	skb->transport_header = skb->network_header;
 
 	skb_set_inner_ipproto(skb, next_protocol);
+	skb_set_inner_mac_header(skb, skb_inner_network_offset(skb));
 
 	if (tun_type == IP_VS_CONN_F_TUNNEL_TYPE_GUE) {
 		bool check = false;
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 8f63514656a1..398bb8fb30a5 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -153,6 +153,7 @@ static struct nft_trans *nft_trans_alloc_gfp(const struct nft_ctx *ctx,
 		return NULL;
 
 	INIT_LIST_HEAD(&trans->list);
+	INIT_LIST_HEAD(&trans->binding_list);
 	trans->msg_type = msg_type;
 	trans->ctx	= *ctx;
 
@@ -165,13 +166,20 @@ static struct nft_trans *nft_trans_alloc(const struct nft_ctx *ctx,
 	return nft_trans_alloc_gfp(ctx, msg_type, size, GFP_KERNEL);
 }
 
-static void nft_trans_destroy(struct nft_trans *trans)
+static void nft_trans_list_del(struct nft_trans *trans)
 {
 	list_del(&trans->list);
+	list_del(&trans->binding_list);
+}
+
+static void nft_trans_destroy(struct nft_trans *trans)
+{
+	nft_trans_list_del(trans);
 	kfree(trans);
 }
 
-static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+static void __nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set,
+				 bool bind)
 {
 	struct nftables_pernet *nft_net;
 	struct net *net = ctx->net;
@@ -185,16 +193,80 @@ static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
 		switch (trans->msg_type) {
 		case NFT_MSG_NEWSET:
 			if (nft_trans_set(trans) == set)
-				nft_trans_set_bound(trans) = true;
+				nft_trans_set_bound(trans) = bind;
 			break;
 		case NFT_MSG_NEWSETELEM:
 			if (nft_trans_elem_set(trans) == set)
-				nft_trans_elem_set_bound(trans) = true;
+				nft_trans_elem_set_bound(trans) = bind;
 			break;
 		}
 	}
 }
 
+static void nft_set_trans_bind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, true);
+}
+
+static void nft_set_trans_unbind(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	return __nft_set_trans_bind(ctx, set, false);
+}
+
+static void __nft_chain_trans_bind(const struct nft_ctx *ctx,
+				   struct nft_chain *chain, bool bind)
+{
+	struct nftables_pernet *nft_net;
+	struct net *net = ctx->net;
+	struct nft_trans *trans;
+
+	if (!nft_chain_binding(chain))
+		return;
+
+	nft_net = nft_pernet(net);
+	list_for_each_entry_reverse(trans, &nft_net->commit_list, list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWCHAIN:
+			if (nft_trans_chain(trans) == chain)
+				nft_trans_chain_bound(trans) = bind;
+			break;
+		case NFT_MSG_NEWRULE:
+			if (trans->ctx.chain == chain)
+				nft_trans_rule_bound(trans) = bind;
+			break;
+		}
+	}
+}
+
+static void nft_chain_trans_bind(const struct nft_ctx *ctx,
+				 struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, true);
+}
+
+int nf_tables_bind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	if (!nft_chain_binding(chain))
+		return 0;
+
+	if (nft_chain_binding(ctx->chain))
+		return -EOPNOTSUPP;
+
+	if (chain->bound)
+		return -EBUSY;
+
+	chain->bound = true;
+	chain->use++;
+	nft_chain_trans_bind(ctx, chain);
+
+	return 0;
+}
+
+void nf_tables_unbind_chain(const struct nft_ctx *ctx, struct nft_chain *chain)
+{
+	__nft_chain_trans_bind(ctx, chain, false);
+}
+
 static int nft_netdev_register_hooks(struct net *net,
 				     struct list_head *hook_list)
 {
@@ -294,6 +366,19 @@ static void nft_trans_commit_list_add_tail(struct net *net, struct nft_trans *tr
 {
 	struct nftables_pernet *nft_net = nft_pernet(net);
 
+	switch (trans->msg_type) {
+	case NFT_MSG_NEWSET:
+		if (!nft_trans_set_update(trans) &&
+		    nft_set_is_anonymous(nft_trans_set(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	case NFT_MSG_NEWCHAIN:
+		if (!nft_trans_chain_update(trans) &&
+		    nft_chain_binding(nft_trans_chain(trans)))
+			list_add_tail(&trans->binding_list, &nft_net->binding_list);
+		break;
+	}
+
 	list_add_tail(&trans->list, &nft_net->commit_list);
 }
 
@@ -340,8 +425,9 @@ static struct nft_trans *nft_trans_chain_add(struct nft_ctx *ctx, int msg_type)
 				ntohl(nla_get_be32(ctx->nla[NFTA_CHAIN_ID]));
 		}
 	}
-
+	nft_trans_chain(trans) = ctx->chain;
 	nft_trans_commit_list_add_tail(ctx->net, trans);
+
 	return trans;
 }
 
@@ -359,8 +445,7 @@ static int nft_delchain(struct nft_ctx *ctx)
 	return 0;
 }
 
-static void nft_rule_expr_activate(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nft_rule_expr_activate(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr;
 
@@ -373,9 +458,8 @@ static void nft_rule_expr_activate(const struct nft_ctx *ctx,
 	}
 }
 
-static void nft_rule_expr_deactivate(const struct nft_ctx *ctx,
-				     struct nft_rule *rule,
-				     enum nft_trans_phase phase)
+void nft_rule_expr_deactivate(const struct nft_ctx *ctx, struct nft_rule *rule,
+			      enum nft_trans_phase phase)
 {
 	struct nft_expr *expr;
 
@@ -497,6 +581,58 @@ static int nft_trans_set_add(const struct nft_ctx *ctx, int msg_type,
 	return __nft_trans_set_add(ctx, msg_type, set, NULL);
 }
 
+static void nft_setelem_data_deactivate(const struct net *net,
+					const struct nft_set *set,
+					struct nft_set_elem *elem);
+
+static int nft_mapelem_deactivate(const struct nft_ctx *ctx,
+				  struct nft_set *set,
+				  const struct nft_set_iter *iter,
+				  struct nft_set_elem *elem)
+{
+	nft_setelem_data_deactivate(ctx->net, set, elem);
+
+	return 0;
+}
+
+struct nft_set_elem_catchall {
+	struct list_head	list;
+	struct rcu_head		rcu;
+	void			*elem;
+};
+
+static void nft_map_catchall_deactivate(const struct nft_ctx *ctx,
+					struct nft_set *set)
+{
+	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	list_for_each_entry(catchall, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+		if (!nft_set_elem_active(ext, genmask))
+			continue;
+
+		elem.priv = catchall->elem;
+		nft_setelem_data_deactivate(ctx->net, set, &elem);
+		break;
+	}
+}
+
+static void nft_map_deactivate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_deactivate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+
+	nft_map_catchall_deactivate(ctx, set);
+}
+
 static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	int err;
@@ -505,6 +641,9 @@ static int nft_delset(const struct nft_ctx *ctx, struct nft_set *set)
 	if (err < 0)
 		return err;
 
+	if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+		nft_map_deactivate(ctx, set);
+
 	nft_deactivate_next(ctx->net, set);
 	ctx->table->use--;
 
@@ -2221,7 +2360,7 @@ static int nft_basechain_init(struct nft_base_chain *basechain, u8 family,
 	return 0;
 }
 
-static int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
+int nft_chain_add(struct nft_table *table, struct nft_chain *chain)
 {
 	int err;
 
@@ -2525,6 +2664,8 @@ static int nf_tables_updchain(struct nft_ctx *ctx, u8 genmask, u8 policy,
 	nft_trans_basechain(trans) = basechain;
 	INIT_LIST_HEAD(&nft_trans_chain_hooks(trans));
 	list_splice(&hook.list, &nft_trans_chain_hooks(trans));
+	if (nla[NFTA_CHAIN_HOOK])
+		module_put(hook.type->owner);
 
 	nft_trans_commit_list_add_tail(ctx->net, trans);
 
@@ -3427,8 +3568,7 @@ static int nf_tables_getrule(struct sk_buff *skb, const struct nfnl_info *info,
 	return err;
 }
 
-static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
-				   struct nft_rule *rule)
+void nf_tables_rule_destroy(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	struct nft_expr *expr, *next;
 
@@ -3445,7 +3585,7 @@ static void nf_tables_rule_destroy(const struct nft_ctx *ctx,
 	kfree(rule);
 }
 
-void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
+static void nf_tables_rule_release(const struct nft_ctx *ctx, struct nft_rule *rule)
 {
 	nft_rule_expr_deactivate(ctx, rule, NFT_TRANS_RELEASE);
 	nf_tables_rule_destroy(ctx, rule);
@@ -3533,12 +3673,6 @@ int nft_setelem_validate(const struct nft_ctx *ctx, struct nft_set *set,
 	return 0;
 }
 
-struct nft_set_elem_catchall {
-	struct list_head	list;
-	struct rcu_head		rcu;
-	void			*elem;
-};
-
 int nft_set_catchall_validate(const struct nft_ctx *ctx, struct nft_set *set)
 {
 	u8 genmask = nft_genmask_next(ctx->net);
@@ -3781,7 +3915,7 @@ static int nf_tables_newrule(struct sk_buff *skb, const struct nfnl_info *info,
 	if (flow)
 		nft_flow_rule_destroy(flow);
 err_release_rule:
-	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE);
+	nft_rule_expr_deactivate(&ctx, rule, NFT_TRANS_PREPARE_ERROR);
 	nf_tables_rule_destroy(&ctx, rule);
 err_release_expr:
 	for (i = 0; i < n; i++) {
@@ -4762,6 +4896,9 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 		if (info->nlh->nlmsg_flags & NLM_F_REPLACE)
 			return -EOPNOTSUPP;
 
+		if (nft_set_is_anonymous(set))
+			return -EOPNOTSUPP;
+
 		err = nft_set_expr_alloc(&ctx, set, nla, exprs, &num_exprs, flags);
 		if (err < 0)
 			return err;
@@ -4865,7 +5002,7 @@ static int nf_tables_newset(struct sk_buff *skb, const struct nfnl_info *info,
 	for (i = 0; i < set->num_exprs; i++)
 		nft_expr_destroy(&ctx, set->exprs[i]);
 err_set_destroy:
-	ops->destroy(set);
+	ops->destroy(&ctx, set);
 err_set_init:
 	kfree(set->name);
 err_set_name:
@@ -4880,7 +5017,7 @@ static void nft_set_catchall_destroy(const struct nft_ctx *ctx,
 
 	list_for_each_entry_safe(catchall, next, &set->catchall_list, list) {
 		list_del_rcu(&catchall->list);
-		nft_set_elem_destroy(set, catchall->elem, true);
+		nf_tables_set_elem_destroy(ctx, set, catchall->elem);
 		kfree_rcu(catchall, rcu);
 	}
 }
@@ -4895,7 +5032,7 @@ static void nft_set_destroy(const struct nft_ctx *ctx, struct nft_set *set)
 	for (i = 0; i < set->num_exprs; i++)
 		nft_expr_destroy(ctx, set->exprs[i]);
 
-	set->ops->destroy(set);
+	set->ops->destroy(ctx, set);
 	nft_set_catchall_destroy(ctx, set);
 	kfree(set->name);
 	kvfree(set);
@@ -5060,10 +5197,60 @@ static void nf_tables_unbind_set(const struct nft_ctx *ctx, struct nft_set *set,
 	}
 }
 
+static void nft_setelem_data_activate(const struct net *net,
+				      const struct nft_set *set,
+				      struct nft_set_elem *elem);
+
+static int nft_mapelem_activate(const struct nft_ctx *ctx,
+				struct nft_set *set,
+				const struct nft_set_iter *iter,
+				struct nft_set_elem *elem)
+{
+	nft_setelem_data_activate(ctx->net, set, elem);
+
+	return 0;
+}
+
+static void nft_map_catchall_activate(const struct nft_ctx *ctx,
+				      struct nft_set *set)
+{
+	u8 genmask = nft_genmask_next(ctx->net);
+	struct nft_set_elem_catchall *catchall;
+	struct nft_set_elem elem;
+	struct nft_set_ext *ext;
+
+	list_for_each_entry(catchall, &set->catchall_list, list) {
+		ext = nft_set_elem_ext(set, catchall->elem);
+		if (!nft_set_elem_active(ext, genmask))
+			continue;
+
+		elem.priv = catchall->elem;
+		nft_setelem_data_activate(ctx->net, set, &elem);
+		break;
+	}
+}
+
+static void nft_map_activate(const struct nft_ctx *ctx, struct nft_set *set)
+{
+	struct nft_set_iter iter = {
+		.genmask	= nft_genmask_next(ctx->net),
+		.fn		= nft_mapelem_activate,
+	};
+
+	set->ops->walk(ctx, set, &iter);
+	WARN_ON_ONCE(iter.err);
+
+	nft_map_catchall_activate(ctx, set);
+}
+
 void nf_tables_activate_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (nft_set_is_anonymous(set))
+	if (nft_set_is_anonymous(set)) {
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_activate(ctx, set);
+
 		nft_clear(ctx->net, set);
+	}
 
 	set->use++;
 }
@@ -5074,14 +5261,28 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 			      enum nft_trans_phase phase)
 {
 	switch (phase) {
-	case NFT_TRANS_PREPARE:
+	case NFT_TRANS_PREPARE_ERROR:
+		nft_set_trans_unbind(ctx, set);
 		if (nft_set_is_anonymous(set))
 			nft_deactivate_next(ctx->net, set);
 
+		set->use--;
+		break;
+	case NFT_TRANS_PREPARE:
+		if (nft_set_is_anonymous(set)) {
+			if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_deactivate(ctx, set);
+
+			nft_deactivate_next(ctx->net, set);
+		}
 		set->use--;
 		return;
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
+		if (nft_set_is_anonymous(set) &&
+		    set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(ctx, set);
+
 		set->use--;
 		fallthrough;
 	default:
@@ -5834,6 +6035,7 @@ static void nft_set_elem_expr_destroy(const struct nft_ctx *ctx,
 		__nft_set_elem_expr_destroy(ctx, expr);
 }
 
+/* Drop references and destroy. Called from gc, dynset and abort path. */
 void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 			  bool destroy_expr)
 {
@@ -5855,11 +6057,11 @@ void nft_set_elem_destroy(const struct nft_set *set, void *elem,
 }
 EXPORT_SYMBOL_GPL(nft_set_elem_destroy);
 
-/* Only called from commit path, nft_setelem_data_deactivate() already deals
- * with the refcounting from the preparation phase.
+/* Destroy element. References have been already dropped in the preparation
+ * path via nft_setelem_data_deactivate().
  */
-static void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
-				       const struct nft_set *set, void *elem)
+void nf_tables_set_elem_destroy(const struct nft_ctx *ctx,
+				const struct nft_set *set, void *elem)
 {
 	struct nft_set_ext *ext = nft_set_elem_ext(set, elem);
 
@@ -6492,7 +6694,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 	if (obj)
 		obj->use--;
 err_elem_userdata:
-	nf_tables_set_elem_destroy(ctx, set, elem.priv);
+	nft_set_elem_destroy(set, elem.priv, true);
 err_parse_data:
 	if (nla[NFTA_SET_ELEM_DATA] != NULL)
 		nft_data_release(&elem.data.val, desc.type);
@@ -6537,7 +6739,8 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 	if (IS_ERR(set))
 		return PTR_ERR(set);
 
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -6570,7 +6773,6 @@ static int nf_tables_newsetelem(struct sk_buff *skb,
 void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	if (type == NFT_DATA_VERDICT) {
 		switch (data->verdict.code) {
@@ -6578,15 +6780,6 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 		case NFT_GOTO:
 			chain = data->verdict.chain;
 			chain->use++;
-
-			if (!nft_chain_is_bound(chain))
-				break;
-
-			chain->table->use++;
-			list_for_each_entry(rule, &chain->rules, list)
-				chain->use++;
-
-			nft_chain_add(chain->table, chain);
 			break;
 		}
 	}
@@ -6821,7 +7014,9 @@ static int nf_tables_delsetelem(struct sk_buff *skb,
 	set = nft_set_lookup(table, nla[NFTA_SET_ELEM_LIST_SET], genmask);
 	if (IS_ERR(set))
 		return PTR_ERR(set);
-	if (!list_empty(&set->bindings) && set->flags & NFT_SET_CONSTANT)
+
+	if (!list_empty(&set->bindings) &&
+	    (set->flags & (NFT_SET_CONSTANT | NFT_SET_ANONYMOUS)))
 		return -EBUSY;
 
 	nft_ctx_init(&ctx, net, skb, info->nlh, family, table, NULL, nla);
@@ -7596,6 +7791,7 @@ void nf_tables_deactivate_flowtable(const struct nft_ctx *ctx,
 				    enum nft_trans_phase phase)
 {
 	switch (phase) {
+	case NFT_TRANS_PREPARE_ERROR:
 	case NFT_TRANS_PREPARE:
 	case NFT_TRANS_ABORT:
 	case NFT_TRANS_RELEASE:
@@ -8856,7 +9052,7 @@ static void nf_tables_trans_destroy_work(struct work_struct *w)
 	synchronize_rcu();
 
 	list_for_each_entry_safe(trans, next, &head, list) {
-		list_del(&trans->list);
+		nft_trans_list_del(trans);
 		nft_commit_release(trans);
 	}
 }
@@ -9223,6 +9419,27 @@ static int nf_tables_commit(struct net *net, struct sk_buff *skb)
 		return 0;
 	}
 
+	list_for_each_entry(trans, &nft_net->binding_list, binding_list) {
+		switch (trans->msg_type) {
+		case NFT_MSG_NEWSET:
+			if (!nft_trans_set_update(trans) &&
+			    nft_set_is_anonymous(nft_trans_set(trans)) &&
+			    !nft_trans_set_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound set\n");
+				return -EINVAL;
+			}
+			break;
+		case NFT_MSG_NEWCHAIN:
+			if (!nft_trans_chain_update(trans) &&
+			    nft_chain_binding(nft_trans_chain(trans)) &&
+			    !nft_trans_chain_bound(trans)) {
+				pr_warn_once("nftables ruleset with unbound chain\n");
+				return -EINVAL;
+			}
+			break;
+		}
+	}
+
 	/* 0. Validate ruleset, otherwise roll back for error reporting. */
 	if (nf_tables_validate(net) < 0)
 		return -EAGAIN;
@@ -9583,7 +9800,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 				kfree(nft_trans_chain_name(trans));
 				nft_trans_destroy(trans);
 			} else {
-				if (nft_chain_is_bound(trans->ctx.chain)) {
+				if (nft_trans_chain_bound(trans)) {
 					nft_trans_destroy(trans);
 					break;
 				}
@@ -9601,6 +9818,10 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWRULE:
+			if (nft_trans_rule_bound(trans)) {
+				nft_trans_destroy(trans);
+				break;
+			}
 			trans->ctx.chain->use--;
 			list_del_rcu(&nft_trans_rule(trans)->list);
 			nft_rule_expr_deactivate(&trans->ctx,
@@ -9635,6 +9856,9 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DESTROYSET:
 			trans->ctx.table->use++;
 			nft_clear(trans->ctx.net, nft_trans_set(trans));
+			if (nft_trans_set(trans)->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+				nft_map_activate(&trans->ctx, nft_trans_set(trans));
+
 			nft_trans_destroy(trans);
 			break;
 		case NFT_MSG_NEWSETELEM:
@@ -9715,7 +9939,7 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 
 	list_for_each_entry_safe_reverse(trans, next,
 					 &nft_net->commit_list, list) {
-		list_del(&trans->list);
+		nft_trans_list_del(trans);
 		nf_tables_abort_release(trans);
 	}
 
@@ -10164,22 +10388,12 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 static void nft_verdict_uninit(const struct nft_data *data)
 {
 	struct nft_chain *chain;
-	struct nft_rule *rule;
 
 	switch (data->verdict.code) {
 	case NFT_JUMP:
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 		chain->use--;
-
-		if (!nft_chain_is_bound(chain))
-			break;
-
-		chain->table->use--;
-		list_for_each_entry(rule, &chain->rules, list)
-			chain->use--;
-
-		nft_chain_del(chain);
 		break;
 	}
 }
@@ -10414,6 +10628,9 @@ static void __nft_release_table(struct net *net, struct nft_table *table)
 	list_for_each_entry_safe(set, ns, &table->sets, list) {
 		list_del(&set->list);
 		table->use--;
+		if (set->flags & (NFT_SET_MAP | NFT_SET_OBJECT))
+			nft_map_deactivate(&ctx, set);
+
 		nft_set_destroy(&ctx, set);
 	}
 	list_for_each_entry_safe(obj, ne, &table->objects, list) {
@@ -10498,6 +10715,7 @@ static int __net_init nf_tables_init_net(struct net *net)
 
 	INIT_LIST_HEAD(&nft_net->tables);
 	INIT_LIST_HEAD(&nft_net->commit_list);
+	INIT_LIST_HEAD(&nft_net->binding_list);
 	INIT_LIST_HEAD(&nft_net->module_list);
 	INIT_LIST_HEAD(&nft_net->notify_list);
 	mutex_init(&nft_net->commit_mutex);
diff --git a/net/netfilter/nfnetlink_osf.c b/net/netfilter/nfnetlink_osf.c
index ee6840bd5933..8f1bfa6ccc2d 100644
--- a/net/netfilter/nfnetlink_osf.c
+++ b/net/netfilter/nfnetlink_osf.c
@@ -439,3 +439,4 @@ module_init(nfnl_osf_init);
 module_exit(nfnl_osf_fini);
 
 MODULE_LICENSE("GPL");
+MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/netfilter/nft_immediate.c b/net/netfilter/nft_immediate.c
index c9d2f7c29f53..3d76ebfe8939 100644
--- a/net/netfilter/nft_immediate.c
+++ b/net/netfilter/nft_immediate.c
@@ -76,11 +76,9 @@ static int nft_immediate_init(const struct nft_ctx *ctx,
 		switch (priv->data.verdict.code) {
 		case NFT_JUMP:
 		case NFT_GOTO:
-			if (nft_chain_is_bound(chain)) {
-				err = -EBUSY;
-				goto err1;
-			}
-			chain->bound = true;
+			err = nf_tables_bind_chain(ctx, chain);
+			if (err < 0)
+				return err;
 			break;
 		default:
 			break;
@@ -98,6 +96,31 @@ static void nft_immediate_activate(const struct nft_ctx *ctx,
 				   const struct nft_expr *expr)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_activate(&chain_ctx, rule);
+
+			nft_clear(ctx->net, chain);
+			break;
+		default:
+			break;
+		}
+	}
 
 	return nft_data_hold(&priv->data, nft_dreg_to_type(priv->dreg));
 }
@@ -107,6 +130,43 @@ static void nft_immediate_deactivate(const struct nft_ctx *ctx,
 				     enum nft_trans_phase phase)
 {
 	const struct nft_immediate_expr *priv = nft_expr_priv(expr);
+	const struct nft_data *data = &priv->data;
+	struct nft_ctx chain_ctx;
+	struct nft_chain *chain;
+	struct nft_rule *rule;
+
+	if (priv->dreg == NFT_REG_VERDICT) {
+		switch (data->verdict.code) {
+		case NFT_JUMP:
+		case NFT_GOTO:
+			chain = data->verdict.chain;
+			if (!nft_chain_binding(chain))
+				break;
+
+			chain_ctx = *ctx;
+			chain_ctx.chain = chain;
+
+			list_for_each_entry(rule, &chain->rules, list)
+				nft_rule_expr_deactivate(&chain_ctx, rule, phase);
+
+			switch (phase) {
+			case NFT_TRANS_PREPARE_ERROR:
+				nf_tables_unbind_chain(ctx, chain);
+				fallthrough;
+			case NFT_TRANS_PREPARE:
+				nft_deactivate_next(ctx->net, chain);
+				break;
+			default:
+				nft_chain_del(chain);
+				chain->bound = false;
+				chain->table->use--;
+				break;
+			}
+			break;
+		default:
+			break;
+		}
+	}
 
 	if (phase == NFT_TRANS_COMMIT)
 		return;
@@ -131,15 +191,27 @@ static void nft_immediate_destroy(const struct nft_ctx *ctx,
 	case NFT_GOTO:
 		chain = data->verdict.chain;
 
-		if (!nft_chain_is_bound(chain))
+		if (!nft_chain_binding(chain))
+			break;
+
+		/* Rule construction failed, but chain is already bound:
+		 * let the transaction records release this chain and its rules.
+		 */
+		if (chain->bound) {
+			chain->use--;
 			break;
+		}
 
+		/* Rule has been deleted, release chain and its rules. */
 		chain_ctx = *ctx;
 		chain_ctx.chain = chain;
 
-		list_for_each_entry_safe(rule, n, &chain->rules, list)
-			nf_tables_rule_release(&chain_ctx, rule);
-
+		chain->use--;
+		list_for_each_entry_safe(rule, n, &chain->rules, list) {
+			chain->use--;
+			list_del(&rule->list);
+			nf_tables_rule_destroy(&chain_ctx, rule);
+		}
 		nf_tables_chain_destroy(&chain_ctx);
 		break;
 	default:
diff --git a/net/netfilter/nft_set_bitmap.c b/net/netfilter/nft_set_bitmap.c
index 96081ac8d2b4..1e5e7a181e0b 100644
--- a/net/netfilter/nft_set_bitmap.c
+++ b/net/netfilter/nft_set_bitmap.c
@@ -271,13 +271,14 @@ static int nft_bitmap_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_bitmap_destroy(const struct nft_set *set)
+static void nft_bitmap_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_bitmap *priv = nft_set_priv(set);
 	struct nft_bitmap_elem *be, *n;
 
 	list_for_each_entry_safe(be, n, &priv->list, head)
-		nft_set_elem_destroy(set, be, true);
+		nf_tables_set_elem_destroy(ctx, set, be);
 }
 
 static bool nft_bitmap_estimate(const struct nft_set_desc *desc, u32 features,
diff --git a/net/netfilter/nft_set_hash.c b/net/netfilter/nft_set_hash.c
index 76de6c8d9865..0b73cb0e752f 100644
--- a/net/netfilter/nft_set_hash.c
+++ b/net/netfilter/nft_set_hash.c
@@ -400,19 +400,31 @@ static int nft_rhash_init(const struct nft_set *set,
 	return 0;
 }
 
+struct nft_rhash_ctx {
+	const struct nft_ctx	ctx;
+	const struct nft_set	*set;
+};
+
 static void nft_rhash_elem_destroy(void *ptr, void *arg)
 {
-	nft_set_elem_destroy(arg, ptr, true);
+	struct nft_rhash_ctx *rhash_ctx = arg;
+
+	nf_tables_set_elem_destroy(&rhash_ctx->ctx, rhash_ctx->set, ptr);
 }
 
-static void nft_rhash_destroy(const struct nft_set *set)
+static void nft_rhash_destroy(const struct nft_ctx *ctx,
+			      const struct nft_set *set)
 {
 	struct nft_rhash *priv = nft_set_priv(set);
+	struct nft_rhash_ctx rhash_ctx = {
+		.ctx	= *ctx,
+		.set	= set,
+	};
 
 	cancel_delayed_work_sync(&priv->gc_work);
 	rcu_barrier();
 	rhashtable_free_and_destroy(&priv->ht, nft_rhash_elem_destroy,
-				    (void *)set);
+				    (void *)&rhash_ctx);
 }
 
 /* Number of buckets is stored in u32, so cap our result to 1U<<31 */
@@ -643,7 +655,8 @@ static int nft_hash_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_hash_destroy(const struct nft_set *set)
+static void nft_hash_destroy(const struct nft_ctx *ctx,
+			     const struct nft_set *set)
 {
 	struct nft_hash *priv = nft_set_priv(set);
 	struct nft_hash_elem *he;
@@ -653,7 +666,7 @@ static void nft_hash_destroy(const struct nft_set *set)
 	for (i = 0; i < priv->buckets; i++) {
 		hlist_for_each_entry_safe(he, next, &priv->table[i], node) {
 			hlist_del_rcu(&he->node);
-			nft_set_elem_destroy(set, he, true);
+			nf_tables_set_elem_destroy(ctx, set, he);
 		}
 	}
 }
diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index 15e451dc3fc4..0452ee586c1c 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -1974,12 +1974,16 @@ static void nft_pipapo_walk(const struct nft_ctx *ctx, struct nft_set *set,
 			    struct nft_set_iter *iter)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
+	struct net *net = read_pnet(&set->net);
 	struct nft_pipapo_match *m;
 	struct nft_pipapo_field *f;
 	int i, r;
 
 	rcu_read_lock();
-	m = rcu_dereference(priv->match);
+	if (iter->genmask == nft_genmask_cur(net))
+		m = rcu_dereference(priv->match);
+	else
+		m = priv->clone;
 
 	if (unlikely(!m))
 		goto out;
@@ -2148,10 +2152,12 @@ static int nft_pipapo_init(const struct nft_set *set,
 
 /**
  * nft_set_pipapo_match_destroy() - Destroy elements from key mapping array
+ * @ctx:	context
  * @set:	nftables API set representation
  * @m:		matching data pointing to key mapping array
  */
-static void nft_set_pipapo_match_destroy(const struct nft_set *set,
+static void nft_set_pipapo_match_destroy(const struct nft_ctx *ctx,
+					 const struct nft_set *set,
 					 struct nft_pipapo_match *m)
 {
 	struct nft_pipapo_field *f;
@@ -2168,15 +2174,17 @@ static void nft_set_pipapo_match_destroy(const struct nft_set *set,
 
 		e = f->mt[r].e;
 
-		nft_set_elem_destroy(set, e, true);
+		nf_tables_set_elem_destroy(ctx, set, e);
 	}
 }
 
 /**
  * nft_pipapo_destroy() - Free private data for set and all committed elements
+ * @ctx:	context
  * @set:	nftables API set representation
  */
-static void nft_pipapo_destroy(const struct nft_set *set)
+static void nft_pipapo_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_pipapo *priv = nft_set_priv(set);
 	struct nft_pipapo_match *m;
@@ -2186,7 +2194,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 	if (m) {
 		rcu_barrier();
 
-		nft_set_pipapo_match_destroy(set, m);
+		nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(m->scratch_aligned);
@@ -2203,7 +2211,7 @@ static void nft_pipapo_destroy(const struct nft_set *set)
 		m = priv->clone;
 
 		if (priv->dirty)
-			nft_set_pipapo_match_destroy(set, m);
+			nft_set_pipapo_match_destroy(ctx, set, m);
 
 #ifdef NFT_PIPAPO_ALIGN
 		free_percpu(priv->clone->scratch_aligned);
diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 2f114aa10f1a..5c05c9b990fb 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -664,7 +664,8 @@ static int nft_rbtree_init(const struct nft_set *set,
 	return 0;
 }
 
-static void nft_rbtree_destroy(const struct nft_set *set)
+static void nft_rbtree_destroy(const struct nft_ctx *ctx,
+			       const struct nft_set *set)
 {
 	struct nft_rbtree *priv = nft_set_priv(set);
 	struct nft_rbtree_elem *rbe;
@@ -675,7 +676,7 @@ static void nft_rbtree_destroy(const struct nft_set *set)
 	while ((node = priv->root.rb_node) != NULL) {
 		rb_erase(node, &priv->root);
 		rbe = rb_entry(node, struct nft_rbtree_elem, node);
-		nft_set_elem_destroy(set, rbe, true);
+		nf_tables_set_elem_destroy(ctx, set, rbe);
 	}
 }
 
diff --git a/net/netfilter/xt_osf.c b/net/netfilter/xt_osf.c
index e1990baf3a3b..dc9485854002 100644
--- a/net/netfilter/xt_osf.c
+++ b/net/netfilter/xt_osf.c
@@ -71,4 +71,3 @@ MODULE_AUTHOR("Evgeniy Polyakov <zbr@ioremap.net>");
 MODULE_DESCRIPTION("Passive OS fingerprint matching.");
 MODULE_ALIAS("ipt_osf");
 MODULE_ALIAS("ip6t_osf");
-MODULE_ALIAS_NFNL_SUBSYS(NFNL_SUBSYS_OSF);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 3f7311529cc0..34c90c9c2fca 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -2324,7 +2324,9 @@ static struct pernet_operations psched_net_ops = {
 	.exit = psched_net_exit,
 };
 
+#if IS_ENABLED(CONFIG_RETPOLINE)
 DEFINE_STATIC_KEY_FALSE(tc_skip_wrapper);
+#endif
 
 static int __init pktsched_init(void)
 {
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 6ef3021e1169..e79be1b3e74d 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -966,6 +966,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	if (ret < 0)
 		return ret;
 
+	sch_tree_lock(sch);
 	/* backup q->clg and q->loss_model */
 	old_clg = q->clg;
 	old_loss_model = q->loss_model;
@@ -974,7 +975,7 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 		ret = get_loss_clg(q, tb[TCA_NETEM_LOSS]);
 		if (ret) {
 			q->loss_model = old_loss_model;
-			return ret;
+			goto unlock;
 		}
 	} else {
 		q->loss_model = CLG_RANDOM;
@@ -1041,6 +1042,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	/* capping jitter to the range acceptable by tabledist() */
 	q->jitter = min_t(s64, abs(q->jitter), INT_MAX);
 
+unlock:
+	sch_tree_unlock(sch);
 	return ret;
 
 get_table_failure:
@@ -1050,7 +1053,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	 */
 	q->clg = old_clg;
 	q->loss_model = old_loss_model;
-	return ret;
+
+	goto unlock;
 }
 
 static int netem_init(struct Qdisc *sch, struct nlattr *opt,
diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 436d29640ac2..9f294a20dcec 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -131,6 +131,7 @@ struct sec_path *secpath_set(struct sk_buff *skb)
 	memset(sp->ovec, 0, sizeof(sp->ovec));
 	sp->olen = 0;
 	sp->len = 0;
+	sp->verified_cnt = 0;
 
 	return sp;
 }
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 1f99dc469027..35279c220bd7 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -310,6 +310,52 @@ static void xfrmi_scrub_packet(struct sk_buff *skb, bool xnet)
 	skb->mark = 0;
 }
 
+static int xfrmi_input(struct sk_buff *skb, int nexthdr, __be32 spi,
+		       int encap_type, unsigned short family)
+{
+	struct sec_path *sp;
+
+	sp = skb_sec_path(skb);
+	if (sp && (sp->len || sp->olen) &&
+	    !xfrm_policy_check(NULL, XFRM_POLICY_IN, skb, family))
+		goto discard;
+
+	XFRM_SPI_SKB_CB(skb)->family = family;
+	if (family == AF_INET) {
+		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct iphdr, daddr);
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip4 = NULL;
+	} else {
+		XFRM_SPI_SKB_CB(skb)->daddroff = offsetof(struct ipv6hdr, daddr);
+		XFRM_TUNNEL_SKB_CB(skb)->tunnel.ip6 = NULL;
+	}
+
+	return xfrm_input(skb, nexthdr, spi, encap_type);
+discard:
+	kfree_skb(skb);
+	return 0;
+}
+
+static int xfrmi4_rcv(struct sk_buff *skb)
+{
+	return xfrmi_input(skb, ip_hdr(skb)->protocol, 0, 0, AF_INET);
+}
+
+static int xfrmi6_rcv(struct sk_buff *skb)
+{
+	return xfrmi_input(skb, skb_network_header(skb)[IP6CB(skb)->nhoff],
+			   0, 0, AF_INET6);
+}
+
+static int xfrmi4_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
+{
+	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET);
+}
+
+static int xfrmi6_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
+{
+	return xfrmi_input(skb, nexthdr, spi, encap_type, AF_INET6);
+}
+
 static int xfrmi_rcv_cb(struct sk_buff *skb, int err)
 {
 	const struct xfrm_mode *inner_mode;
@@ -945,8 +991,8 @@ static struct pernet_operations xfrmi_net_ops = {
 };
 
 static struct xfrm6_protocol xfrmi_esp6_protocol __read_mostly = {
-	.handler	=	xfrm6_rcv,
-	.input_handler	=	xfrm_input,
+	.handler	=	xfrmi6_rcv,
+	.input_handler	=	xfrmi6_input,
 	.cb_handler	=	xfrmi_rcv_cb,
 	.err_handler	=	xfrmi6_err,
 	.priority	=	10,
@@ -996,8 +1042,8 @@ static struct xfrm6_tunnel xfrmi_ip6ip_handler __read_mostly = {
 #endif
 
 static struct xfrm4_protocol xfrmi_esp4_protocol __read_mostly = {
-	.handler	=	xfrm4_rcv,
-	.input_handler	=	xfrm_input,
+	.handler	=	xfrmi4_rcv,
+	.input_handler	=	xfrmi4_input,
 	.cb_handler	=	xfrmi_rcv_cb,
 	.err_handler	=	xfrmi4_err,
 	.priority	=	10,
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 6d15788b5123..e7617c9959c3 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1831,6 +1831,7 @@ int xfrm_policy_flush(struct net *net, u8 type, bool task_valid)
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
+		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -1869,6 +1870,7 @@ int xfrm_dev_policy_flush(struct net *net, struct net_device *dev,
 
 		__xfrm_policy_unlink(pol, dir);
 		spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
+		xfrm_dev_policy_delete(pol);
 		cnt++;
 		xfrm_audit_policy_delete(pol, 1, task_valid);
 		xfrm_policy_kill(pol);
@@ -3349,6 +3351,13 @@ xfrm_policy_ok(const struct xfrm_tmpl *tmpl, const struct sec_path *sp, int star
 		if (xfrm_state_ok(tmpl, sp->xvec[idx], family, if_id))
 			return ++idx;
 		if (sp->xvec[idx]->props.mode != XFRM_MODE_TRANSPORT) {
+			if (idx < sp->verified_cnt) {
+				/* Secpath entry previously verified, consider optional and
+				 * continue searching
+				 */
+				continue;
+			}
+
 			if (start == -1)
 				start = -2-idx;
 			break;
@@ -3723,6 +3732,9 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		 * Order is _important_. Later we will implement
 		 * some barriers, but at the moment barriers
 		 * are implied between each two transformations.
+		 * Upon success, marks secpath entries as having been
+		 * verified to allow them to be skipped in future policy
+		 * checks (e.g. nested tunnels).
 		 */
 		for (i = xfrm_nr-1, k = 0; i >= 0; i--) {
 			k = xfrm_policy_ok(tpp[i], sp, k, family, if_id);
@@ -3741,6 +3753,8 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 		}
 
 		xfrm_pols_put(pols, npols);
+		sp->verified_cnt = k;
+
 		return 1;
 	}
 	XFRM_INC_STATS(net, LINUX_MIB_XFRMINPOLBLOCK);
diff --git a/scripts/gfp-translate b/scripts/gfp-translate
index b2ce416d944b..6c9aed17cf56 100755
--- a/scripts/gfp-translate
+++ b/scripts/gfp-translate
@@ -63,11 +63,11 @@ fi
 
 # Extract GFP flags from the kernel source
 TMPFILE=`mktemp -t gfptranslate-XXXXXX` || exit 1
-grep -q ___GFP $SOURCE/include/linux/gfp.h
+grep -q ___GFP $SOURCE/include/linux/gfp_types.h
 if [ $? -eq 0 ]; then
-	grep "^#define ___GFP" $SOURCE/include/linux/gfp.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
+	grep "^#define ___GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/u$//' | grep -v GFP_BITS > $TMPFILE
 else
-	grep "^#define __GFP" $SOURCE/include/linux/gfp.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
+	grep "^#define __GFP" $SOURCE/include/linux/gfp_types.h | sed -e 's/(__force gfp_t)//' | sed -e 's/u)/)/' | grep -v GFP_BITS | sed -e 's/)\//) \//' > $TMPFILE
 fi
 
 # Parse the flags
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9466b6a2abae..5b3964b39709 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1985,6 +1985,11 @@ static void add_header(struct buffer *b, struct module *mod)
 	buf_printf(b, "#include <linux/vermagic.h>\n");
 	buf_printf(b, "#include <linux/compiler.h>\n");
 	buf_printf(b, "\n");
+	buf_printf(b, "#ifdef CONFIG_UNWINDER_ORC\n");
+	buf_printf(b, "#include <asm/orc_header.h>\n");
+	buf_printf(b, "ORC_HEADER;\n");
+	buf_printf(b, "#endif\n");
+	buf_printf(b, "\n");
 	buf_printf(b, "BUILD_SALT;\n");
 	buf_printf(b, "BUILD_LTO_INFO;\n");
 	buf_printf(b, "\n");
diff --git a/scripts/orc_hash.sh b/scripts/orc_hash.sh
new file mode 100644
index 000000000000..466611aa0053
--- /dev/null
+++ b/scripts/orc_hash.sh
@@ -0,0 +1,16 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Meta Platforms, Inc. and affiliates.
+
+set -e
+
+printf '%s' '#define ORC_HASH '
+
+awk '
+/^#define ORC_(REG|TYPE)_/ { print }
+/^struct orc_entry {$/ { p=1 }
+p { print }
+/^}/ { p=0 }' |
+	sha1sum |
+	cut -d " " -f 1 |
+	sed 's/\([0-9a-f]\{2\}\)/0x\1,/g'
diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 920e44ba998a..eb049014f87a 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9594,6 +9594,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x10ec, 0x124c, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1252, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
 	SND_PCI_QUIRK(0x10ec, 0x1254, "Intel Reference board", ALC295_FIXUP_CHROME_BOOK),
+	SND_PCI_QUIRK(0x10ec, 0x12cc, "Intel Reference board", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0x10f7, 0x8338, "Panasonic CF-SZ6", ALC269_FIXUP_HEADSET_MODE),
 	SND_PCI_QUIRK(0x144d, 0xc109, "Samsung Ativ book 9 (NP900X3G)", ALC269_FIXUP_INV_DMIC),
 	SND_PCI_QUIRK(0x144d, 0xc169, "Samsung Notebook 9 Pen (NP930SBE-K01US)", ALC298_FIXUP_SAMSUNG_AMP),
@@ -9814,6 +9815,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x8086, 0x2074, "Intel NUC 8", ALC233_FIXUP_INTEL_NUC8_DMIC),
 	SND_PCI_QUIRK(0x8086, 0x2080, "Intel NUC 8 Rugged", ALC256_FIXUP_INTEL_NUC8_RUGGED),
 	SND_PCI_QUIRK(0x8086, 0x2081, "Intel NUC 10", ALC256_FIXUP_INTEL_NUC10),
+	SND_PCI_QUIRK(0x8086, 0x3038, "Intel NUC 13", ALC225_FIXUP_HEADSET_JACK),
 	SND_PCI_QUIRK(0xf111, 0x0001, "Framework Laptop", ALC295_FIXUP_FRAMEWORK_LAPTOP_MIC_NO_PRESENCE),
 
 #if 0
diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 84b401b685f7..c1ca3ceac5f2 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -171,6 +171,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "21CL"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "21EF"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
diff --git a/sound/soc/codecs/nau8824.c b/sound/soc/codecs/nau8824.c
index 4f19fd9b65d1..5a4db8944d06 100644
--- a/sound/soc/codecs/nau8824.c
+++ b/sound/soc/codecs/nau8824.c
@@ -1903,6 +1903,30 @@ static const struct dmi_system_id nau8824_quirk_table[] = {
 		},
 		.driver_data = (void *)(NAU8824_MONO_SPEAKER),
 	},
+	{
+		/* Positivo CW14Q01P */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "CW14Q01P"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo K1424G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "K1424G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
+	{
+		/* Positivo N14ZP74G */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Positivo Tecnologia SA"),
+			DMI_MATCH(DMI_BOARD_NAME, "N14ZP74G"),
+		},
+		.driver_data = (void *)(NAU8824_JD_ACTIVE_HIGH),
+	},
 	{}
 };
 
diff --git a/sound/soc/codecs/wcd938x-sdw.c b/sound/soc/codecs/wcd938x-sdw.c
index 402286dfaea4..9c10200ff34b 100644
--- a/sound/soc/codecs/wcd938x-sdw.c
+++ b/sound/soc/codecs/wcd938x-sdw.c
@@ -1190,7 +1190,6 @@ static const struct regmap_config wcd938x_regmap_config = {
 	.readable_reg = wcd938x_readable_register,
 	.writeable_reg = wcd938x_writeable_register,
 	.volatile_reg = wcd938x_volatile_register,
-	.can_multi_write = true,
 };
 
 static const struct sdw_slave_ops wcd9380_slave_ops = {
diff --git a/sound/soc/fsl/fsl_sai.c b/sound/soc/fsl/fsl_sai.c
index 990bba0be1fb..8a64f3c1d155 100644
--- a/sound/soc/fsl/fsl_sai.c
+++ b/sound/soc/fsl/fsl_sai.c
@@ -491,14 +491,21 @@ static int fsl_sai_set_bclk(struct snd_soc_dai *dai, bool tx, u32 freq)
 	regmap_update_bits(sai->regmap, reg, FSL_SAI_CR2_MSEL_MASK,
 			   FSL_SAI_CR2_MSEL(sai->mclk_id[tx]));
 
-	if (savediv == 1)
+	if (savediv == 1) {
 		regmap_update_bits(sai->regmap, reg,
 				   FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
 				   FSL_SAI_CR2_BYP);
-	else
+		if (fsl_sai_dir_is_synced(sai, adir))
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI, FSL_SAI_CR2_BCI);
+		else
+			regmap_update_bits(sai->regmap, FSL_SAI_xCR2(tx, ofs),
+					   FSL_SAI_CR2_BCI, 0);
+	} else {
 		regmap_update_bits(sai->regmap, reg,
 				   FSL_SAI_CR2_DIV_MASK | FSL_SAI_CR2_BYP,
 				   savediv / 2 - 1);
+	}
 
 	if (sai->soc_data->max_register >= FSL_SAI_MCTL) {
 		/* SAI is in master mode at this point, so enable MCLK */
diff --git a/sound/soc/fsl/fsl_sai.h b/sound/soc/fsl/fsl_sai.h
index 197748a888d5..a53c4f0e25fa 100644
--- a/sound/soc/fsl/fsl_sai.h
+++ b/sound/soc/fsl/fsl_sai.h
@@ -116,6 +116,7 @@
 
 /* SAI Transmit and Receive Configuration 2 Register */
 #define FSL_SAI_CR2_SYNC	BIT(30)
+#define FSL_SAI_CR2_BCI		BIT(28)
 #define FSL_SAI_CR2_MSEL_MASK	(0x3 << 26)
 #define FSL_SAI_CR2_MSEL_BUS	0
 #define FSL_SAI_CR2_MSEL_MCLK1	BIT(26)
diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index e98932c16754..5f8468ff3656 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -416,6 +416,7 @@ static int __simple_for_each_link(struct asoc_simple_priv *priv,
 
 			if (ret < 0) {
 				of_node_put(codec);
+				of_node_put(plat);
 				of_node_put(np);
 				goto error;
 			}
diff --git a/tools/testing/selftests/net/fcnal-test.sh b/tools/testing/selftests/net/fcnal-test.sh
index 21ca91473c09..ee6880ac3e5e 100755
--- a/tools/testing/selftests/net/fcnal-test.sh
+++ b/tools/testing/selftests/net/fcnal-test.sh
@@ -92,6 +92,13 @@ NSC_CMD="ip netns exec ${NSC}"
 
 which ping6 > /dev/null 2>&1 && ping6=$(which ping6) || ping6=$(which ping)
 
+# Check if FIPS mode is enabled
+if [ -f /proc/sys/crypto/fips_enabled ]; then
+	fips_enabled=`cat /proc/sys/crypto/fips_enabled`
+else
+	fips_enabled=0
+fi
+
 ################################################################################
 # utilities
 
@@ -1216,7 +1223,7 @@ ipv4_tcp_novrf()
 	run_cmd nettest -d ${NSA_DEV} -r ${a}
 	log_test_addr ${a} $? 1 "No server, device client, local conn"
 
-	ipv4_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv4_tcp_md5_novrf
 }
 
 ipv4_tcp_vrf()
@@ -1270,9 +1277,11 @@ ipv4_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv4_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv4_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
@@ -2772,7 +2781,7 @@ ipv6_tcp_novrf()
 		log_test_addr ${a} $? 1 "No server, device client, local conn"
 	done
 
-	ipv6_tcp_md5_novrf
+	[ "$fips_enabled" = "1" ] || ipv6_tcp_md5_novrf
 }
 
 ipv6_tcp_vrf()
@@ -2842,9 +2851,11 @@ ipv6_tcp_vrf()
 	log_test_addr ${a} $? 1 "Global server, local connection"
 
 	# run MD5 tests
-	setup_vrf_dup
-	ipv6_tcp_md5
-	cleanup_vrf_dup
+	if [ "$fips_enabled" = "0" ]; then
+		setup_vrf_dup
+		ipv6_tcp_md5
+		cleanup_vrf_dup
+	fi
 
 	#
 	# enable VRF global server
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
index c5095da7f6bf..aec752a22e9e 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1d.sh
@@ -93,12 +93,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br2
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br2
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
diff --git a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
index 9ff22f28032d..0cf4c47a46f9 100755
--- a/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
+++ b/tools/testing/selftests/net/forwarding/mirror_gre_bridge_1q.sh
@@ -90,12 +90,16 @@ cleanup()
 
 test_gretap()
 {
+	ip neigh replace 192.0.2.130 lladdr $(mac_get $h3) \
+		 nud permanent dev br1
 	full_test_span_gre_dir gt4 ingress 8 0 "mirror to gretap"
 	full_test_span_gre_dir gt4 egress 0 8 "mirror to gretap"
 }
 
 test_ip6gretap()
 {
+	ip neigh replace 2001:db8:2::2 lladdr $(mac_get $h3) \
+		nud permanent dev br1
 	full_test_span_gre_dir gt6 ingress 8 0 "mirror to ip6gretap"
 	full_test_span_gre_dir gt6 egress 0 8 "mirror to ip6gretap"
 }
diff --git a/tools/testing/selftests/net/mptcp/config b/tools/testing/selftests/net/mptcp/config
index 38021a0dd527..6032f9b23c4c 100644
--- a/tools/testing/selftests/net/mptcp/config
+++ b/tools/testing/selftests/net/mptcp/config
@@ -1,3 +1,4 @@
+CONFIG_KALLSYMS=y
 CONFIG_MPTCP=y
 CONFIG_IPV6=y
 CONFIG_MPTCP_IPV6=y
diff --git a/tools/testing/selftests/net/mptcp/diag.sh b/tools/testing/selftests/net/mptcp/diag.sh
index 4eacdb1ab962..fa9e09ad97d9 100755
--- a/tools/testing/selftests/net/mptcp/diag.sh
+++ b/tools/testing/selftests/net/mptcp/diag.sh
@@ -55,16 +55,20 @@ __chk_nr()
 {
 	local command="$1"
 	local expected=$2
-	local msg nr
+	local msg="$3"
+	local skip="${4:-SKIP}"
+	local nr
 
-	shift 2
-	msg=$*
 	nr=$(eval $command)
 
 	printf "%-50s" "$msg"
 	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
+		if [ $nr = "$skip" ] && ! mptcp_lib_expect_all_features; then
+			echo "[ skip ] Feature probably not supported"
+		else
+			echo "[ fail ] expected $expected found $nr"
+			ret=$test_cnt
+		fi
 	else
 		echo "[  ok  ]"
 	fi
@@ -76,12 +80,12 @@ __chk_msk_nr()
 	local condition=$1
 	shift 1
 
-	__chk_nr "ss -inmHMN $ns | $condition" $*
+	__chk_nr "ss -inmHMN $ns | $condition" "$@"
 }
 
 chk_msk_nr()
 {
-	__chk_msk_nr "grep -c token:" $*
+	__chk_msk_nr "grep -c token:" "$@"
 }
 
 wait_msk_nr()
@@ -119,37 +123,26 @@ wait_msk_nr()
 
 chk_msk_fallback_nr()
 {
-		__chk_msk_nr "grep -c fallback" $*
+	__chk_msk_nr "grep -c fallback" "$@"
 }
 
 chk_msk_remote_key_nr()
 {
-		__chk_msk_nr "grep -c remote_key" $*
+	__chk_msk_nr "grep -c remote_key" "$@"
 }
 
 __chk_listen()
 {
 	local filter="$1"
 	local expected=$2
+	local msg="$3"
 
-	shift 2
-	msg=$*
-
-	nr=$(ss -N $ns -Ml "$filter" | grep -c LISTEN)
-	printf "%-50s" "$msg"
-
-	if [ $nr != $expected ]; then
-		echo "[ fail ] expected $expected found $nr"
-		ret=$test_cnt
-	else
-		echo "[  ok  ]"
-	fi
+	__chk_nr "ss -N $ns -Ml '$filter' | grep -c LISTEN" "$expected" "$msg" 0
 }
 
 chk_msk_listen()
 {
 	lport=$1
-	local msg="check for listen socket"
 
 	# destination port search should always return empty list
 	__chk_listen "dport $lport" 0 "listen match for dport $lport"
@@ -167,10 +160,9 @@ chk_msk_listen()
 chk_msk_inuse()
 {
 	local expected=$1
+	local msg="$2"
 	local listen_nr
 
-	shift 1
-
 	listen_nr=$(ss -N "${ns}" -Ml | grep -c LISTEN)
 	expected=$((expected + listen_nr))
 
@@ -181,7 +173,7 @@ chk_msk_inuse()
 		sleep 0.1
 	done
 
-	__chk_nr get_msk_inuse $expected $*
+	__chk_nr get_msk_inuse $expected "$msg" 0
 }
 
 # $1: ns, $2: port
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.c b/tools/testing/selftests/net/mptcp/mptcp_connect.c
index b25a31445ded..c7f9ebeebc2c 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.c
@@ -106,8 +106,8 @@ static struct cfg_sockopt_types cfg_sockopt_types;
 static void die_usage(void)
 {
 	fprintf(stderr, "Usage: mptcp_connect [-6] [-c cmsg] [-f offset] [-i file] [-I num] [-j] [-l] "
-		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-j] [-l] [-r num] "
-		"[-s MPTCP|TCP] [-S num] [-r num] [-t num] [-T num] [-u] [-w sec] connect_address\n");
+		"[-m mode] [-M mark] [-o option] [-p port] [-P mode] [-r num] [-R num] "
+		"[-s MPTCP|TCP] [-S num] [-t num] [-T num] [-w sec] connect_address\n");
 	fprintf(stderr, "\t-6 use ipv6\n");
 	fprintf(stderr, "\t-c cmsg -- test cmsg type <cmsg>\n");
 	fprintf(stderr, "\t-f offset -- stop the I/O after receiving and sending the specified amount "
@@ -126,13 +126,13 @@ static void die_usage(void)
 	fprintf(stderr, "\t-p num -- use port num\n");
 	fprintf(stderr,
 		"\t-P [saveWithPeek|saveAfterPeek] -- save data with/after MSG_PEEK form tcp socket\n");
-	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
-	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-r num -- enable slow mode, limiting each write to num bytes "
 		"-- for remove addr tests\n");
 	fprintf(stderr, "\t-R num -- set SO_RCVBUF to num\n");
 	fprintf(stderr, "\t-s [MPTCP|TCP] -- use mptcp(default) or tcp sockets\n");
 	fprintf(stderr, "\t-S num -- set SO_SNDBUF to num\n");
+	fprintf(stderr, "\t-t num -- set poll timeout to num\n");
+	fprintf(stderr, "\t-T num -- set expected runtime to num ms\n");
 	fprintf(stderr, "\t-w num -- wait num sec before closing the socket\n");
 	exit(1);
 }
diff --git a/tools/testing/selftests/net/mptcp/mptcp_connect.sh b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
index c1f7bac19942..773dd770a567 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_connect.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_connect.sh
@@ -144,6 +144,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -695,6 +696,15 @@ run_test_transparent()
 		return 0
 	fi
 
+	# IP(V6)_TRANSPARENT has been added after TOS support which came with
+	# the required infrastructure in MPTCP sockopt code. To support TOS, the
+	# following function has been exported (T). Not great but better than
+	# checking for a specific kernel version.
+	if ! mptcp_lib_kallsyms_has "T __ip_sock_set_tos$"; then
+		echo "INFO: ${msg} not supported by the kernel: SKIP"
+		return
+	fi
+
 ip netns exec "$listener_ns" nft -f /dev/stdin <<"EOF"
 flush ruleset
 table inet mangle {
@@ -767,6 +777,11 @@ run_tests_peekmode()
 
 run_tests_mptfo()
 {
+	if ! mptcp_lib_kallsyms_has "mptcp_fastopen_"; then
+		echo "INFO: TFO not supported by the kernel: SKIP"
+		return
+	fi
+
 	echo "INFO: with MPTFO start"
 	ip netns exec "$ns1" sysctl -q net.ipv4.tcp_fastopen=2
 	ip netns exec "$ns2" sysctl -q net.ipv4.tcp_fastopen=1
@@ -787,6 +802,11 @@ run_tests_disconnect()
 	local old_cin=$cin
 	local old_sin=$sin
 
+	if ! mptcp_lib_kallsyms_has "mptcp_pm_data_reset$"; then
+		echo "INFO: Full disconnect not supported: SKIP"
+		return
+	fi
+
 	cat $cin $cin $cin > "$cin".disconnect
 
 	# force do_transfer to cope with the multiple tranmissions
diff --git a/tools/testing/selftests/net/mptcp/mptcp_join.sh b/tools/testing/selftests/net/mptcp/mptcp_join.sh
index 4152370298bf..11ea1406d79f 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_join.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_join.sh
@@ -8,6 +8,10 @@
 
 . "$(dirname "${0}")/mptcp_lib.sh"
 
+# ShellCheck incorrectly believes that most of the code here is unreachable
+# because it's invoked by variable name, see how the "tests" array is used
+#shellcheck disable=SC2317
+
 ret=0
 sin=""
 sinfail=""
@@ -21,6 +25,8 @@ capout=""
 ns1=""
 ns2=""
 ksft_skip=4
+iptables="iptables"
+ip6tables="ip6tables"
 timeout_poll=30
 timeout_test=$((timeout_poll * 2 + 1))
 capture=0
@@ -78,7 +84,7 @@ init_partial()
 		ip netns add $netns || exit $ksft_skip
 		ip -net $netns link set lo up
 		ip netns exec $netns sysctl -q net.mptcp.enabled=1
-		ip netns exec $netns sysctl -q net.mptcp.pm_type=0
+		ip netns exec $netns sysctl -q net.mptcp.pm_type=0 2>/dev/null || true
 		ip netns exec $netns sysctl -q net.ipv4.conf.all.rp_filter=0
 		ip netns exec $netns sysctl -q net.ipv4.conf.default.rp_filter=0
 		if [ $checksum -eq 1 ]; then
@@ -136,13 +142,18 @@ cleanup_partial()
 check_tools()
 {
 	mptcp_lib_check_mptcp
+	mptcp_lib_check_kallsyms
 
 	if ! ip -Version &> /dev/null; then
 		echo "SKIP: Could not run test without ip tool"
 		exit $ksft_skip
 	fi
 
-	if ! iptables -V &> /dev/null; then
+	# Use the legacy version if available to support old kernel versions
+	if iptables-legacy -V &> /dev/null; then
+		iptables="iptables-legacy"
+		ip6tables="ip6tables-legacy"
+	elif ! iptables -V &> /dev/null; then
 		echo "SKIP: Could not run all tests without iptables tool"
 		exit $ksft_skip
 	fi
@@ -181,6 +192,32 @@ cleanup()
 	cleanup_partial
 }
 
+# $1: msg
+print_title()
+{
+	printf "%03u %-36s %s" "${TEST_COUNT}" "${TEST_NAME}" "${1}"
+}
+
+# [ $1: fail msg ]
+mark_as_skipped()
+{
+	local msg="${1:-"Feature not supported"}"
+
+	mptcp_lib_fail_if_expected_feature "${msg}"
+
+	print_title "[ skip ] ${msg}"
+	printf "\n"
+}
+
+# $@: condition
+continue_if()
+{
+	if ! "${@}"; then
+		mark_as_skipped
+		return 1
+	fi
+}
+
 skip_test()
 {
 	if [ "${#only_tests_ids[@]}" -eq 0 ] && [ "${#only_tests_names[@]}" -eq 0 ]; then
@@ -224,6 +261,19 @@ reset()
 	return 0
 }
 
+# $1: test name ; $2: counter to check
+reset_check_counter()
+{
+	reset "${1}" || return 1
+
+	local counter="${2}"
+
+	if ! nstat -asz "${counter}" | grep -wq "${counter}"; then
+		mark_as_skipped "counter '${counter}' is not available"
+		return 1
+	fi
+}
+
 # $1: test name
 reset_with_cookies()
 {
@@ -243,17 +293,21 @@ reset_with_add_addr_timeout()
 
 	reset "${1}" || return 1
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
-	ip netns exec $ns2 $tables -A OUTPUT -p tcp \
-		-m tcp --tcp-option 30 \
-		-m bpf --bytecode \
-		"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
-		-j DROP
+
+	if ! ip netns exec $ns2 $tables -A OUTPUT -p tcp \
+			-m tcp --tcp-option 30 \
+			-m bpf --bytecode \
+			"$CBPF_MPTCP_SUBOPTION_ADD_ADDR" \
+			-j DROP; then
+		mark_as_skipped "unable to set the 'add addr' rule"
+		return 1
+	fi
 }
 
 # $1: test name
@@ -297,22 +351,17 @@ reset_with_allow_join_id0()
 #     tc action pedit offset 162 out of bounds
 #
 # Netfilter is used to mark packets with enough data.
-reset_with_fail()
+setup_fail_rules()
 {
-	reset "${1}" || return 1
-
-	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
-	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
-
 	check_invert=1
 	validate_checksum=1
-	local i="$2"
-	local ip="${3:-4}"
+	local i="$1"
+	local ip="${2:-4}"
 	local tables
 
-	tables="iptables"
+	tables="${iptables}"
 	if [ $ip -eq 6 ]; then
-		tables="ip6tables"
+		tables="${ip6tables}"
 	fi
 
 	ip netns exec $ns2 $tables \
@@ -322,15 +371,32 @@ reset_with_fail()
 		-p tcp \
 		-m length --length 150:9999 \
 		-m statistic --mode nth --packet 1 --every 99999 \
-		-j MARK --set-mark 42 || exit 1
+		-j MARK --set-mark 42 || return ${ksft_skip}
 
-	tc -n $ns2 qdisc add dev ns2eth$i clsact || exit 1
+	tc -n $ns2 qdisc add dev ns2eth$i clsact || return ${ksft_skip}
 	tc -n $ns2 filter add dev ns2eth$i egress \
 		protocol ip prio 1000 \
 		handle 42 fw \
 		action pedit munge offset 148 u8 invert \
 		pipe csum tcp \
-		index 100 || exit 1
+		index 100 || return ${ksft_skip}
+}
+
+reset_with_fail()
+{
+	reset_check_counter "${1}" "MPTcpExtInfiniteMapTx" || return 1
+	shift
+
+	ip netns exec $ns1 sysctl -q net.mptcp.checksum_enabled=1
+	ip netns exec $ns2 sysctl -q net.mptcp.checksum_enabled=1
+
+	local rc=0
+	setup_fail_rules "${@}" || rc=$?
+
+	if [ ${rc} -eq ${ksft_skip} ]; then
+		mark_as_skipped "unable to set the 'fail' rules"
+		return 1
+	fi
 }
 
 reset_with_events()
@@ -345,6 +411,25 @@ reset_with_events()
 	evts_ns2_pid=$!
 }
 
+reset_with_tcp_filter()
+{
+	reset "${1}" || return 1
+	shift
+
+	local ns="${!1}"
+	local src="${2}"
+	local target="${3}"
+
+	if ! ip netns exec "${ns}" ${iptables} \
+			-A INPUT \
+			-s "${src}" \
+			-p tcp \
+			-j "${target}"; then
+		mark_as_skipped "unable to set the filter rules"
+		return 1
+	fi
+}
+
 fail_test()
 {
 	ret=1
@@ -377,8 +462,9 @@ check_transfer()
 
 	local line
 	if [ -n "$bytes" ]; then
+		local out_size
 		# when truncating we must check the size explicitly
-		local out_size=$(wc -c $out | awk '{print $1}')
+		out_size=$(wc -c $out | awk '{print $1}')
 		if [ $out_size -ne $bytes ]; then
 			echo "[ FAIL ] $what output file has wrong size ($out_size, $bytes)"
 			fail_test
@@ -462,11 +548,25 @@ wait_local_port_listen()
 	done
 }
 
-rm_addr_count()
+# $1: ns ; $2: counter
+get_counter()
 {
-	local ns=${1}
+	local ns="${1}"
+	local counter="${2}"
+	local count
+
+	count=$(ip netns exec ${ns} nstat -asz "${counter}" | awk 'NR==1 {next} {print $2}')
+	if [ -z "${count}" ]; then
+		mptcp_lib_fail_if_expected_feature "${counter} counter"
+		return 1
+	fi
 
-	ip netns exec ${ns} nstat -as | grep MPTcpExtRmAddr | awk '{print $2}'
+	echo "${count}"
+}
+
+rm_addr_count()
+{
+	get_counter "${1}" "MPTcpExtRmAddr"
 }
 
 # $1: ns, $2: old rm_addr counter in $ns
@@ -489,11 +589,11 @@ wait_mpj()
 	local ns="${1}"
 	local cnt old_cnt
 
-	old_cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+	old_cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 
 	local i
 	for i in $(seq 10); do
-		cnt=$(ip netns exec ${ns} nstat -as | grep MPJoinAckRx | awk '{print $2}')
+		cnt=$(get_counter ${ns} "MPTcpExtMPJoinAckRx")
 		[ "$cnt" = "${old_cnt}" ] || break
 		sleep 0.1
 	done
@@ -513,6 +613,7 @@ kill_events_pids()
 
 kill_tests_wait()
 {
+	#shellcheck disable=SC2046
 	kill -SIGUSR1 $(ip netns pids $ns2) $(ip netns pids $ns1)
 	wait
 }
@@ -692,15 +793,6 @@ pm_nl_check_endpoint()
 	fi
 }
 
-filter_tcp_from()
-{
-	local ns="${1}"
-	local src="${2}"
-	local target="${3}"
-
-	ip netns exec "${ns}" iptables -A INPUT -s "${src}" -p tcp -j "${target}"
-}
-
 do_transfer()
 {
 	local listener_ns="$1"
@@ -1151,12 +1243,13 @@ chk_csum_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "sum"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns1} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns1" ]; then
 		extra_msg="$extra_msg ns1=$count"
 	fi
-	if { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns1 ] && [ $allow_multi_errors_ns1 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns1"
 		fail_test
@@ -1165,12 +1258,13 @@ chk_csum_nr()
 		echo -n "[ ok ]"
 	fi
 	echo -n " - csum  "
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtDataCsumErr | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns2} "MPTcpExtDataCsumErr")
 	if [ "$count" != "$csum_ns2" ]; then
 		extra_msg="$extra_msg ns2=$count"
 	fi
-	if { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 0 ]; } ||
 	   { [ "$count" -lt $csum_ns2 ] && [ $allow_multi_errors_ns2 -eq 1 ]; }; then
 		echo "[fail] got $count data checksum error[s] expected $csum_ns2"
 		fail_test
@@ -1212,12 +1306,13 @@ chk_fail_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ftx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFailTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFailTx")
 	if [ "$count" != "$fail_tx" ]; then
 		extra_msg="$extra_msg,tx=$count"
 	fi
-	if { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_tx" ] && [ $allow_tx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_tx" ] && [ $allow_tx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] TX expected $fail_tx"
 		fail_test
@@ -1227,12 +1322,13 @@ chk_fail_nr()
 	fi
 
 	echo -n " - failrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFailRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFailRx")
 	if [ "$count" != "$fail_rx" ]; then
 		extra_msg="$extra_msg,rx=$count"
 	fi
-	if { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif { [ "$count" != "$fail_rx" ] && [ $allow_rx_lost -eq 0 ]; } ||
 	   { [ "$count" -gt "$fail_rx" ] && [ $allow_rx_lost -eq 1 ]; }; then
 		echo "[fail] got $count MP_FAIL[s] RX expected $fail_rx"
 		fail_test
@@ -1264,10 +1360,11 @@ chk_fclose_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "ctx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPFastcloseTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_tx" ] && extra_msg="$extra_msg,tx=$count"
-	if [ "$count" != "$fclose_tx" ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPFastcloseTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_tx" ]; then
+		extra_msg="$extra_msg,tx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] TX expected $fclose_tx"
 		fail_test
 		dump_stats=1
@@ -1276,10 +1373,11 @@ chk_fclose_nr()
 	fi
 
 	echo -n " - fclzrx"
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPFastcloseRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	[ "$count" != "$fclose_rx" ] && extra_msg="$extra_msg,rx=$count"
-	if [ "$count" != "$fclose_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPFastcloseRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$fclose_rx" ]; then
+		extra_msg="$extra_msg,rx=$count"
 		echo "[fail] got $count MP_FASTCLOSE[s] RX expected $fclose_rx"
 		fail_test
 		dump_stats=1
@@ -1310,9 +1408,10 @@ chk_rst_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rtx"
-	count=$(ip netns exec $ns_tx nstat -as | grep MPTcpExtMPRstTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ $count -lt $rst_tx ]; then
+	count=$(get_counter ${ns_tx} "MPTcpExtMPRstTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ $count -lt $rst_tx ]; then
 		echo "[fail] got $count MP_RST[s] TX expected $rst_tx"
 		fail_test
 		dump_stats=1
@@ -1321,9 +1420,10 @@ chk_rst_nr()
 	fi
 
 	echo -n " - rstrx "
-	count=$(ip netns exec $ns_rx nstat -as | grep MPTcpExtMPRstRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" -lt "$rst_rx" ]; then
+	count=$(get_counter ${ns_rx} "MPTcpExtMPRstRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" -lt "$rst_rx" ]; then
 		echo "[fail] got $count MP_RST[s] RX expected $rst_rx"
 		fail_test
 		dump_stats=1
@@ -1344,9 +1444,10 @@ chk_infi_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "itx"
-	count=$(ip netns exec $ns2 nstat -as | grep InfiniteMapTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_tx" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtInfiniteMapTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$infi_tx" ]; then
 		echo "[fail] got $count infinite map[s] TX expected $infi_tx"
 		fail_test
 		dump_stats=1
@@ -1355,9 +1456,10 @@ chk_infi_nr()
 	fi
 
 	echo -n " - infirx"
-	count=$(ip netns exec $ns1 nstat -as | grep InfiniteMapRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$infi_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtInfiniteMapRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$infi_rx" ]; then
 		echo "[fail] got $count infinite map[s] RX expected $infi_rx"
 		fail_test
 		dump_stats=1
@@ -1389,9 +1491,10 @@ chk_join_nr()
 	fi
 
 	printf "%03u %-36s %s" "${TEST_COUNT}" "${title}" "syn"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinSynRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinSynRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_nr" ]; then
 		echo "[fail] got $count JOIN[s] syn expected $syn_nr"
 		fail_test
 		dump_stats=1
@@ -1401,9 +1504,10 @@ chk_join_nr()
 
 	echo -n " - synack"
 	with_cookie=$(ip netns exec $ns2 sysctl -n net.ipv4.tcp_syncookies)
-	count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinSynAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$syn_ack_nr" ]; then
+	count=$(get_counter ${ns2} "MPTcpExtMPJoinSynAckRx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$syn_ack_nr" ]; then
 		# simult connections exceeding the limit with cookie enabled could go up to
 		# synack validation as the conn limit can be enforced reliably only after
 		# the subflow creation
@@ -1419,9 +1523,10 @@ chk_join_nr()
 	fi
 
 	echo -n " - ack"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinAckRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$ack_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPJoinAckRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$ack_nr" ]; then
 		echo "[fail] got $count JOIN[s] ack expected $ack_nr"
 		fail_test
 		dump_stats=1
@@ -1453,12 +1558,12 @@ chk_stale_nr()
 	local recover_nr
 
 	printf "%-${nr_blank}s %-18s" " " "stale"
-	stale_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowStale | awk '{print $2}')
-	[ -z "$stale_nr" ] && stale_nr=0
-	recover_nr=$(ip netns exec $ns nstat -as | grep MPTcpExtSubflowRecover | awk '{print $2}')
-	[ -z "$recover_nr" ] && recover_nr=0
 
-	if [ $stale_nr -lt $stale_min ] ||
+	stale_nr=$(get_counter ${ns} "MPTcpExtSubflowStale")
+	recover_nr=$(get_counter ${ns} "MPTcpExtSubflowRecover")
+	if [ -z "$stale_nr" ] || [ -z "$recover_nr" ]; then
+		echo "[skip]"
+	elif [ $stale_nr -lt $stale_min ] ||
 	   { [ $stale_max -gt 0 ] && [ $stale_nr -gt $stale_max ]; } ||
 	   [ $((stale_nr - recover_nr)) -ne $stale_delta ]; then
 		echo "[fail] got $stale_nr stale[s] $recover_nr recover[s], " \
@@ -1494,12 +1599,12 @@ chk_add_nr()
 	timeout=$(ip netns exec $ns1 sysctl -n net.mptcp.add_addr_timeout)
 
 	printf "%-${nr_blank}s %s" " " "add"
-	count=$(ip netns exec $ns2 nstat -as MPTcpExtAddAddr | grep MPTcpExtAddAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-
+	count=$(get_counter ${ns2} "MPTcpExtAddAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
 	# if the test configured a short timeout tolerate greater then expected
 	# add addrs options, due to retransmissions
-	if [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
+	elif [ "$count" != "$add_nr" ] && { [ "$timeout" -gt 1 ] || [ "$count" -lt "$add_nr" ]; }; then
 		echo "[fail] got $count ADD_ADDR[s] expected $add_nr"
 		fail_test
 		dump_stats=1
@@ -1508,9 +1613,10 @@ chk_add_nr()
 	fi
 
 	echo -n " - echo  "
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtEchoAdd | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$echo_nr" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtEchoAdd")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$echo_nr" ]; then
 		echo "[fail] got $count ADD_ADDR echo[s] expected $echo_nr"
 		fail_test
 		dump_stats=1
@@ -1520,9 +1626,10 @@ chk_add_nr()
 
 	if [ $port_nr -gt 0 ]; then
 		echo -n " - pt "
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtPortAdd | awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$port_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtPortAdd")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$port_nr" ]; then
 			echo "[fail] got $count ADD_ADDR[s] with a port-number expected $port_nr"
 			fail_test
 			dump_stats=1
@@ -1531,10 +1638,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a different \
 				port-number expected $syn_nr"
 			fail_test
@@ -1544,10 +1651,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - synack"
-		count=$(ip netns exec $ns2 nstat -as | grep MPTcpExtMPJoinPortSynAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$syn_ack_nr" ]; then
+		count=$(get_counter ${ns2} "MPTcpExtMPJoinPortSynAckRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$syn_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] synack with a different \
 				port-number expected $syn_ack_nr"
 			fail_test
@@ -1557,10 +1664,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPJoinPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMPJoinPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a different \
 				port-number expected $ack_nr"
 			fail_test
@@ -1570,10 +1677,10 @@ chk_add_nr()
 		fi
 
 		printf "%-${nr_blank}s %s" " " "syn"
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortSynRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_syn_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortSynRx")
+		if [ -z "$count" ]; then
+			echo -n "[skip]"
+		elif [ "$count" != "$mis_syn_nr" ]; then
 			echo "[fail] got $count JOIN[s] syn with a mismatched \
 				port-number expected $mis_syn_nr"
 			fail_test
@@ -1583,10 +1690,10 @@ chk_add_nr()
 		fi
 
 		echo -n " - ack   "
-		count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMismatchPortAckRx |
-			awk '{print $2}')
-		[ -z "$count" ] && count=0
-		if [ "$count" != "$mis_ack_nr" ]; then
+		count=$(get_counter ${ns1} "MPTcpExtMismatchPortAckRx")
+		if [ -z "$count" ]; then
+			echo "[skip]"
+		elif [ "$count" != "$mis_ack_nr" ]; then
 			echo "[fail] got $count JOIN[s] ack with a mismatched \
 				port-number expected $mis_ack_nr"
 			fail_test
@@ -1630,9 +1737,10 @@ chk_rm_nr()
 	fi
 
 	printf "%-${nr_blank}s %s" " " "rm "
-	count=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmAddr | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$rm_addr_nr" ]; then
+	count=$(get_counter ${addr_ns} "MPTcpExtRmAddr")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$rm_addr_nr" ]; then
 		echo "[fail] got $count RM_ADDR[s] expected $rm_addr_nr"
 		fail_test
 		dump_stats=1
@@ -1641,29 +1749,27 @@ chk_rm_nr()
 	fi
 
 	echo -n " - rmsf  "
-	count=$(ip netns exec $subflow_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ -n "$simult" ]; then
+	count=$(get_counter ${subflow_ns} "MPTcpExtRmSubflow")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ -n "$simult" ]; then
 		local cnt suffix
 
-		cnt=$(ip netns exec $addr_ns nstat -as | grep MPTcpExtRmSubflow | awk '{print $2}')
+		cnt=$(get_counter ${addr_ns} "MPTcpExtRmSubflow")
 
 		# in case of simult flush, the subflow removal count on each side is
 		# unreliable
-		[ -z "$cnt" ] && cnt=0
 		count=$((count + cnt))
 		[ "$count" != "$rm_subflow_nr" ] && suffix="$count in [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 		if [ $count -ge "$rm_subflow_nr" ] && \
 		   [ "$count" -le "$((rm_subflow_nr *2 ))" ]; then
-			echo "[ ok ] $suffix"
+			echo -n "[ ok ] $suffix"
 		else
 			echo "[fail] got $count RM_SUBFLOW[s] expected in range [$rm_subflow_nr:$((rm_subflow_nr*2))]"
 			fail_test
 			dump_stats=1
 		fi
-		return
-	fi
-	if [ "$count" != "$rm_subflow_nr" ]; then
+	elif [ "$count" != "$rm_subflow_nr" ]; then
 		echo "[fail] got $count RM_SUBFLOW[s] expected $rm_subflow_nr"
 		fail_test
 		dump_stats=1
@@ -1684,9 +1790,10 @@ chk_prio_nr()
 	local dump_stats
 
 	printf "%-${nr_blank}s %s" " " "ptx"
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioTx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_tx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioTx")
+	if [ -z "$count" ]; then
+		echo -n "[skip]"
+	elif [ "$count" != "$mp_prio_nr_tx" ]; then
 		echo "[fail] got $count MP_PRIO[s] TX expected $mp_prio_nr_tx"
 		fail_test
 		dump_stats=1
@@ -1695,9 +1802,10 @@ chk_prio_nr()
 	fi
 
 	echo -n " - prx   "
-	count=$(ip netns exec $ns1 nstat -as | grep MPTcpExtMPPrioRx | awk '{print $2}')
-	[ -z "$count" ] && count=0
-	if [ "$count" != "$mp_prio_nr_rx" ]; then
+	count=$(get_counter ${ns1} "MPTcpExtMPPrioRx")
+	if [ -z "$count" ]; then
+		echo "[skip]"
+	elif [ "$count" != "$mp_prio_nr_rx" ]; then
 		echo "[fail] got $count MP_PRIO[s] RX expected $mp_prio_nr_rx"
 		fail_test
 		dump_stats=1
@@ -1725,7 +1833,7 @@ chk_subflow_nr()
 
 	cnt1=$(ss -N $ns1 -tOni | grep -c token)
 	cnt2=$(ss -N $ns2 -tOni | grep -c token)
-	if [ "$cnt1" != "$subflow_nr" -o "$cnt2" != "$subflow_nr" ]; then
+	if [ "$cnt1" != "$subflow_nr" ] || [ "$cnt2" != "$subflow_nr" ]; then
 		echo "[fail] got $cnt1:$cnt2 subflows expected $subflow_nr"
 		fail_test
 		dump_stats=1
@@ -1773,7 +1881,7 @@ wait_attempt_fail()
 	while [ $time -lt $timeout_ms ]; do
 		local cnt
 
-		cnt=$(ip netns exec $ns nstat -as TcpAttemptFails | grep TcpAttemptFails | awk '{print $2}')
+		cnt=$(get_counter ${ns} "TcpAttemptFails")
 
 		[ "$cnt" = 1 ] && return 1
 		time=$((time + 100))
@@ -1866,23 +1974,23 @@ subflows_error_tests()
 	fi
 
 	# multiple subflows, with subflow creation error
-	if reset "multi subflows, with failing subflow"; then
+	if reset_with_tcp_filter "multi subflows, with failing subflow" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
 
 	# multiple subflows, with subflow timeout on MPJ
-	if reset "multi subflows, with subflow timeout"; then
+	if reset_with_tcp_filter "multi subflows, with subflow timeout" ns1 10.0.3.2 DROP &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 DROP
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 1 1 1
 	fi
@@ -1890,11 +1998,11 @@ subflows_error_tests()
 	# multiple subflows, check that the endpoint corresponding to
 	# closed subflow (due to reset) is not reused if additional
 	# subflows are added later
-	if reset "multi subflows, fair usage on close"; then
+	if reset_with_tcp_filter "multi subflows, fair usage on close" ns1 10.0.3.2 REJECT &&
+	   continue_if mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow
-		filter_tcp_from $ns1 10.0.3.2 REJECT
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow &
 
 		# mpj subflow will be in TW after the reset
@@ -1994,11 +2102,18 @@ signal_address_tests()
 		# the peer could possibly miss some addr notification, allow retransmission
 		ip netns exec $ns1 sysctl -q net.mptcp.add_addr_timeout=1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
-		chk_join_nr 3 3 3
 
-		# the server will not signal the address terminating
-		# the MPC subflow
-		chk_add_nr 3 3
+		# It is not directly linked to the commit introducing this
+		# symbol but for the parent one which is linked anyway.
+		if ! mptcp_lib_kallsyms_has "mptcp_pm_subflow_check_next$"; then
+			chk_join_nr 3 3 2
+			chk_add_nr 4 4
+		else
+			chk_join_nr 3 3 3
+			# the server will not signal the address terminating
+			# the MPC subflow
+			chk_add_nr 3 3
+		fi
 	fi
 }
 
@@ -2239,7 +2354,12 @@ remove_tests()
 		pm_nl_add_endpoint $ns2 10.0.4.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 -8 -8 slow
 		chk_join_nr 3 3 3
-		chk_rm_nr 0 3 simult
+
+		if mptcp_lib_kversion_ge 5.18; then
+			chk_rm_nr 0 3 simult
+		else
+			chk_rm_nr 3 3
+		fi
 	fi
 
 	# addresses flush
@@ -2477,7 +2597,8 @@ v4mapped_tests()
 
 mixed_tests()
 {
-	if reset "IPv4 sockets do not use IPv6 addresses"; then
+	if reset "IPv4 sockets do not use IPv6 addresses" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 dead:beef:2::1 flags signal
@@ -2486,7 +2607,8 @@ mixed_tests()
 	fi
 
 	# Need an IPv6 mptcp socket to allow subflows of both families
-	if reset "simult IPv4 and IPv6 subflows"; then
+	if reset "simult IPv4 and IPv6 subflows" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags signal
@@ -2495,7 +2617,8 @@ mixed_tests()
 	fi
 
 	# cross families subflows will not be created even in fullmesh mode
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 1x1" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 1 4
 		pm_nl_add_endpoint $ns2 dead:beef:2::2 flags subflow,fullmesh
@@ -2506,7 +2629,8 @@ mixed_tests()
 
 	# fullmesh still tries to create all the possibly subflows with
 	# matching family
-	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2"; then
+	if reset "simult IPv4 and IPv6 subflows, fullmesh 2x2" &&
+	   continue_if mptcp_lib_kversion_ge 6.3; then
 		pm_nl_set_limits $ns1 0 4
 		pm_nl_set_limits $ns2 2 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -2519,7 +2643,8 @@ mixed_tests()
 backup_tests()
 {
 	# single subflow, backup
-	if reset "single subflow, backup"; then
+	if reset "single subflow, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_set_limits $ns2 0 1
 		pm_nl_add_endpoint $ns2 10.0.3.2 flags subflow,backup
@@ -2529,7 +2654,8 @@ backup_tests()
 	fi
 
 	# single address, backup
-	if reset "single address, backup"; then
+	if reset "single address, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
 		pm_nl_set_limits $ns2 1 1
@@ -2540,7 +2666,8 @@ backup_tests()
 	fi
 
 	# single address with port, backup
-	if reset "single address with port, backup"; then
+	if reset "single address with port, backup" &&
+	   continue_if mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 0 1
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal port 10100
 		pm_nl_set_limits $ns2 1 1
@@ -2550,14 +2677,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc backup"; then
+	if reset "mpc backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc backup both sides"; then
+	if reset "mpc backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow,backup
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow,backup
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow
@@ -2565,14 +2694,16 @@ backup_tests()
 		chk_prio_nr 1 1
 	fi
 
-	if reset "mpc switch to backup"; then
+	if reset "mpc switch to backup" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
 		chk_join_nr 0 0 0
 		chk_prio_nr 0 1
 	fi
 
-	if reset "mpc switch to backup both sides"; then
+	if reset "mpc switch to backup both sides" &&
+	   continue_if mptcp_lib_kallsyms_doesnt_have "mptcp_subflow_send_ack$"; then
 		pm_nl_add_endpoint $ns1 10.0.1.1 flags subflow
 		pm_nl_add_endpoint $ns2 10.0.1.2 flags subflow
 		run_tests $ns1 $ns2 10.0.1.1 0 0 0 slow backup
@@ -2598,38 +2729,41 @@ verify_listener_events()
 	local family
 	local saddr
 	local sport
+	local name
 
 	if [ $e_type = $LISTENER_CREATED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CREATE_LISTENER %s:%s"\
-			$e_saddr $e_sport
+		name="LISTENER_CREATED"
 	elif [ $e_type = $LISTENER_CLOSED ]; then
-		stdbuf -o0 -e0 printf "\t\t\t\t\t CLOSE_LISTENER %s:%s "\
-			$e_saddr $e_sport
+		name="LISTENER_CLOSED"
+	else
+		name="$e_type"
 	fi
 
-	type=$(grep "type:$e_type," $evt |
-	       sed --unbuffered -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
-	family=$(grep "type:$e_type," $evt |
-		 sed --unbuffered -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
-	sport=$(grep "type:$e_type," $evt |
-		sed --unbuffered -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
+	printf "%-${nr_blank}s %s %s:%s " " " "$name" "$e_saddr" "$e_sport"
+
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		printf "[skip]: event not supported\n"
+		return
+	fi
+
+	type=$(grep "type:$e_type," $evt | sed -n 's/.*\(type:\)\([[:digit:]]*\).*$/\2/p;q')
+	family=$(grep "type:$e_type," $evt | sed -n 's/.*\(family:\)\([[:digit:]]*\).*$/\2/p;q')
+	sport=$(grep "type:$e_type," $evt | sed -n 's/.*\(sport:\)\([[:digit:]]*\).*$/\2/p;q')
 	if [ $family ] && [ $family = $AF_INET6 ]; then
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr6:\)\([0-9a-f:.]*\).*$/\2/p;q')
 	else
-		saddr=$(grep "type:$e_type," $evt |
-			sed --unbuffered -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
+		saddr=$(grep "type:$e_type," $evt | sed -n 's/.*\(saddr4:\)\([0-9.]*\).*$/\2/p;q')
 	fi
 
 	if [ $type ] && [ $type = $e_type ] &&
 	   [ $family ] && [ $family = $e_family ] &&
 	   [ $saddr ] && [ $saddr = $e_saddr ] &&
 	   [ $sport ] && [ $sport = $e_sport ]; then
-		stdbuf -o0 -e0 printf "[ ok ]\n"
+		echo "[ ok ]"
 		return 0
 	fi
 	fail_test
-	stdbuf -o0 -e0 printf "[fail]\n"
+	echo "[fail]"
 }
 
 add_addr_ports_tests()
@@ -2935,7 +3069,8 @@ fullmesh_tests()
 	fi
 
 	# set fullmesh flag
-	if reset "set fullmesh flag test"; then
+	if reset "set fullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -2945,7 +3080,8 @@ fullmesh_tests()
 	fi
 
 	# set nofullmesh flag
-	if reset "set nofullmesh flag test"; then
+	if reset "set nofullmesh flag test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow,fullmesh
 		pm_nl_set_limits $ns2 4 4
@@ -2955,7 +3091,8 @@ fullmesh_tests()
 	fi
 
 	# set backup,fullmesh flags
-	if reset "set backup,fullmesh flags test"; then
+	if reset "set backup,fullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags subflow
 		pm_nl_set_limits $ns2 4 4
@@ -2966,7 +3103,8 @@ fullmesh_tests()
 	fi
 
 	# set nobackup,nofullmesh flags
-	if reset "set nobackup,nofullmesh flags test"; then
+	if reset "set nobackup,nofullmesh flags test" &&
+	   continue_if mptcp_lib_kversion_ge 5.18; then
 		pm_nl_set_limits $ns1 4 4
 		pm_nl_set_limits $ns2 4 4
 		pm_nl_add_endpoint $ns2 10.0.2.2 flags subflow,backup,fullmesh
@@ -2979,14 +3117,14 @@ fullmesh_tests()
 
 fastclose_tests()
 {
-	if reset "fastclose test"; then
+	if reset_check_counter "fastclose test" "MPTcpExtMPFastcloseTx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_client
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1
 		chk_rst_nr 1 1 invert
 	fi
 
-	if reset "fastclose server test"; then
+	if reset_check_counter "fastclose server test" "MPTcpExtMPFastcloseRx"; then
 		run_tests $ns1 $ns2 10.0.1.1 1024 0 fastclose_server
 		chk_join_nr 0 0 0
 		chk_fclose_nr 1 1 invert
@@ -3024,7 +3162,8 @@ fail_tests()
 userspace_tests()
 {
 	# userspace pm type prevents add_addr
-	if reset "userspace pm type prevents add_addr"; then
+	if reset "userspace pm type prevents add_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3035,7 +3174,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not echo add_addr without daemon
-	if reset "userspace pm no echo w/o daemon"; then
+	if reset "userspace pm no echo w/o daemon" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 2
 		pm_nl_set_limits $ns2 0 2
@@ -3046,7 +3186,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type rejects join
-	if reset "userspace pm type rejects join"; then
+	if reset "userspace pm type rejects join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3056,7 +3197,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type does not send join
-	if reset "userspace pm type does not send join"; then
+	if reset "userspace pm type does not send join" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3066,7 +3208,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents mp_prio
-	if reset "userspace pm type prevents mp_prio"; then
+	if reset "userspace pm type prevents mp_prio" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
@@ -3077,7 +3220,8 @@ userspace_tests()
 	fi
 
 	# userspace pm type prevents rm_addr
-	if reset "userspace pm type prevents rm_addr"; then
+	if reset "userspace pm type prevents rm_addr" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
@@ -3089,7 +3233,8 @@ userspace_tests()
 	fi
 
 	# userspace pm add & remove address
-	if reset_with_events "userspace pm add & remove address"; then
+	if reset_with_events "userspace pm add & remove address" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns1
 		pm_nl_set_limits $ns2 1 1
 		run_tests $ns1 $ns2 10.0.1.1 0 userspace_1 0 slow
@@ -3100,7 +3245,8 @@ userspace_tests()
 	fi
 
 	# userspace pm create destroy subflow
-	if reset_with_events "userspace pm create destroy subflow"; then
+	if reset_with_events "userspace pm create destroy subflow" &&
+	   continue_if mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
 		set_userspace_pm $ns2
 		pm_nl_set_limits $ns1 0 1
 		run_tests $ns1 $ns2 10.0.1.1 0 0 userspace_1 slow
@@ -3112,8 +3258,10 @@ userspace_tests()
 
 endpoint_tests()
 {
+	# subflow_rebuild_header is needed to support the implicit flag
 	# userspace pm type prevents add_addr
-	if reset "implicit EP"; then
+	if reset "implicit EP" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 2 2
 		pm_nl_set_limits $ns2 2 2
 		pm_nl_add_endpoint $ns1 10.0.2.1 flags signal
@@ -3133,7 +3281,8 @@ endpoint_tests()
 		kill_tests_wait
 	fi
 
-	if reset "delete and re-add"; then
+	if reset "delete and re-add" &&
+	   mptcp_lib_kallsyms_has "subflow_rebuild_header$"; then
 		pm_nl_set_limits $ns1 1 1
 		pm_nl_set_limits $ns2 1 1
 		pm_nl_add_endpoint $ns2 10.0.2.2 id 2 dev ns2eth2 flags subflow
diff --git a/tools/testing/selftests/net/mptcp/mptcp_lib.sh b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
index 3286536b79d5..f32045b23b89 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_lib.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_lib.sh
@@ -38,3 +38,67 @@ mptcp_lib_check_mptcp() {
 		exit ${KSFT_SKIP}
 	fi
 }
+
+mptcp_lib_check_kallsyms() {
+	if ! mptcp_lib_has_file "/proc/kallsyms"; then
+		echo "SKIP: CONFIG_KALLSYMS is missing"
+		exit ${KSFT_SKIP}
+	fi
+}
+
+# Internal: use mptcp_lib_kallsyms_has() instead
+__mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	mptcp_lib_check_kallsyms
+
+	grep -q " ${sym}" /proc/kallsyms
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_has() {
+	local sym="${1}"
+
+	if __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol not found"
+}
+
+# $1: part of a symbol to look at, add '$' at the end for full name
+mptcp_lib_kallsyms_doesnt_have() {
+	local sym="${1}"
+
+	if ! __mptcp_lib_kallsyms_has "${sym}"; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "${sym} symbol has been found"
+}
+
+# !!!AVOID USING THIS!!!
+# Features might not land in the expected version and features can be backported
+#
+# $1: kernel version, e.g. 6.3
+mptcp_lib_kversion_ge() {
+	local exp_maj="${1%.*}"
+	local exp_min="${1#*.}"
+	local v maj min
+
+	# If the kernel has backported features, set this env var to 1:
+	if [ "${SELFTESTS_MPTCP_LIB_NO_KVERSION_CHECK:-}" = "1" ]; then
+		return 0
+	fi
+
+	v=$(uname -r | cut -d'.' -f1,2)
+	maj=${v%.*}
+	min=${v#*.}
+
+	if   [ "${maj}" -gt "${exp_maj}" ] ||
+	   { [ "${maj}" -eq "${exp_maj}" ] && [ "${min}" -ge "${exp_min}" ]; }; then
+		return 0
+	fi
+
+	mptcp_lib_fail_if_expected_feature "kernel version ${1} lower than ${v}"
+}
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
index ae61f39556ca..b35148edbf02 100644
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.c
@@ -87,6 +87,10 @@ struct so_state {
 	uint64_t tcpi_rcv_delta;
 };
 
+#ifndef MIN
+#define MIN(a, b) ((a) < (b) ? (a) : (b))
+#endif
+
 static void die_perror(const char *msg)
 {
 	perror(msg);
@@ -349,13 +353,14 @@ static void do_getsockopt_tcp_info(struct so_state *s, int fd, size_t r, size_t
 			xerror("getsockopt MPTCP_TCPINFO (tries %d, %m)");
 
 		assert(olen <= sizeof(ti));
-		assert(ti.d.size_user == ti.d.size_kernel);
-		assert(ti.d.size_user == sizeof(struct tcp_info));
+		assert(ti.d.size_kernel > 0);
+		assert(ti.d.size_user ==
+		       MIN(ti.d.size_kernel, sizeof(struct tcp_info)));
 		assert(ti.d.num_subflows == 1);
 
 		assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 		olen -= sizeof(struct mptcp_subflow_data);
-		assert(olen == sizeof(struct tcp_info));
+		assert(olen == ti.d.size_user);
 
 		if (ti.ti[0].tcpi_bytes_sent == w &&
 		    ti.ti[0].tcpi_bytes_received == r)
@@ -401,13 +406,14 @@ static void do_getsockopt_subflow_addrs(int fd)
 		die_perror("getsockopt MPTCP_SUBFLOW_ADDRS");
 
 	assert(olen <= sizeof(addrs));
-	assert(addrs.d.size_user == addrs.d.size_kernel);
-	assert(addrs.d.size_user == sizeof(struct mptcp_subflow_addrs));
+	assert(addrs.d.size_kernel > 0);
+	assert(addrs.d.size_user ==
+	       MIN(addrs.d.size_kernel, sizeof(struct mptcp_subflow_addrs)));
 	assert(addrs.d.num_subflows == 1);
 
 	assert(olen > (socklen_t)sizeof(struct mptcp_subflow_data));
 	olen -= sizeof(struct mptcp_subflow_data);
-	assert(olen == sizeof(struct mptcp_subflow_addrs));
+	assert(olen == addrs.d.size_user);
 
 	llen = sizeof(local);
 	ret = getsockname(fd, (struct sockaddr *)&local, &llen);
diff --git a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
index ff5adbb9c7f2..f295a371ff14 100755
--- a/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
+++ b/tools/testing/selftests/net/mptcp/mptcp_sockopt.sh
@@ -87,6 +87,7 @@ cleanup()
 }
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
@@ -186,9 +187,14 @@ do_transfer()
 		local_addr="0.0.0.0"
 	fi
 
+	cmsg="TIMESTAMPNS"
+	if mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		cmsg+=",TCPINQ"
+	fi
+
 	timeout ${timeout_test} \
 		ip netns exec ${listener_ns} \
-			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -l -M 1 -p $port -s ${srv_proto} -c "${cmsg}" \
 				${local_addr} < "$sin" > "$sout" &
 	local spid=$!
 
@@ -196,7 +202,7 @@ do_transfer()
 
 	timeout ${timeout_test} \
 		ip netns exec ${connector_ns} \
-			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c TIMESTAMPNS,TCPINQ \
+			$mptcp_connect -t ${timeout_poll} -M 2 -p $port -s ${cl_proto} -c "${cmsg}" \
 				$connect_addr < "$cin" > "$cout" &
 
 	local cpid=$!
@@ -253,6 +259,11 @@ do_mptcp_sockopt_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_diag_fill_info$"; then
+		echo "INFO: MPTCP sockopt not supported: SKIP"
+		return
+	fi
+
 	ip netns exec "$ns_sbox" ./mptcp_sockopt
 	lret=$?
 
@@ -307,6 +318,11 @@ do_tcpinq_tests()
 {
 	local lret=0
 
+	if ! mptcp_lib_kallsyms_has "mptcp_ioctl$"; then
+		echo "INFO: TCP_INQ not supported: SKIP"
+		return
+	fi
+
 	local args
 	for args in "-t tcp" "-r tcp"; do
 		do_tcpinq_test $args
diff --git a/tools/testing/selftests/net/mptcp/pm_netlink.sh b/tools/testing/selftests/net/mptcp/pm_netlink.sh
index 32f7533e0919..d02e0d63a8f9 100755
--- a/tools/testing/selftests/net/mptcp/pm_netlink.sh
+++ b/tools/testing/selftests/net/mptcp/pm_netlink.sh
@@ -73,8 +73,12 @@ check()
 }
 
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "defaults addr list"
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
+
+default_limits="$(ip netns exec $ns1 ./pm_nl_ctl limits)"
+if mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
 subflows 2" "defaults limits"
+fi
 
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.1
 ip netns exec $ns1 ./pm_nl_ctl add 10.0.1.2 flags subflow dev lo
@@ -121,12 +125,10 @@ ip netns exec $ns1 ./pm_nl_ctl flush
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "" "flush addrs"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 9 1
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "rcv addrs above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "rcv addrs above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 1 9
-check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 0
-subflows 2" "subflows above hard limit"
+check "ip netns exec $ns1 ./pm_nl_ctl limits" "$default_limits" "subflows above hard limit"
 
 ip netns exec $ns1 ./pm_nl_ctl limits 8 8
 check "ip netns exec $ns1 ./pm_nl_ctl limits" "accept 8
@@ -176,14 +178,19 @@ subflow,backup 10.0.1.1" "set flags (backup)"
 ip netns exec $ns1 ./pm_nl_ctl set 10.0.1.1 flags nobackup
 check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nobackup)"
+
+# fullmesh support has been added later
 ip netns exec $ns1 ./pm_nl_ctl set id 1 flags fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+if ip netns exec $ns1 ./pm_nl_ctl dump | grep -q "fullmesh" ||
+   mptcp_lib_expect_all_features; then
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,fullmesh 10.0.1.1" "          (fullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags nofullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow 10.0.1.1" "          (nofullmesh)"
-ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
-check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
+	ip netns exec $ns1 ./pm_nl_ctl set id 1 flags backup,fullmesh
+	check "ip netns exec $ns1 ./pm_nl_ctl dump" "id 1 flags \
 subflow,backup,fullmesh 10.0.1.1" "          (backup,fullmesh)"
+fi
 
 exit $ret
diff --git a/tools/testing/selftests/net/mptcp/userspace_pm.sh b/tools/testing/selftests/net/mptcp/userspace_pm.sh
index 8092399d911f..98d9e4d2d3fc 100755
--- a/tools/testing/selftests/net/mptcp/userspace_pm.sh
+++ b/tools/testing/selftests/net/mptcp/userspace_pm.sh
@@ -4,11 +4,17 @@
 . "$(dirname "${0}")/mptcp_lib.sh"
 
 mptcp_lib_check_mptcp
+mptcp_lib_check_kallsyms
+
+if ! mptcp_lib_has_file '/proc/sys/net/mptcp/pm_type'; then
+	echo "userspace pm tests are not supported by the kernel: SKIP"
+	exit ${KSFT_SKIP}
+fi
 
 ip -Version > /dev/null 2>&1
 if [ $? -ne 0 ];then
 	echo "SKIP: Cannot not run test without ip tool"
-	exit 1
+	exit ${KSFT_SKIP}
 fi
 
 ANNOUNCED=6        # MPTCP_EVENT_ANNOUNCED
@@ -909,6 +915,11 @@ test_listener()
 {
 	print_title "Listener tests"
 
+	if ! mptcp_lib_kallsyms_has "mptcp_event_pm_listener$"; then
+		stdbuf -o0 -e0 printf "LISTENER events                                            \t[SKIP] Not supported\n"
+		return
+	fi
+
 	# Capture events on the network namespace running the client
 	:>$client_evts
 
diff --git a/tools/testing/selftests/net/tls.c b/tools/testing/selftests/net/tls.c
index 2cbb12736596..c0ad8385441f 100644
--- a/tools/testing/selftests/net/tls.c
+++ b/tools/testing/selftests/net/tls.c
@@ -25,6 +25,8 @@
 #define TLS_PAYLOAD_MAX_LEN 16384
 #define SOL_TLS 282
 
+static int fips_enabled;
+
 struct tls_crypto_info_keys {
 	union {
 		struct tls12_crypto_info_aes_gcm_128 aes128;
@@ -235,7 +237,7 @@ FIXTURE_VARIANT(tls)
 {
 	uint16_t tls_version;
 	uint16_t cipher_type;
-	bool nopad;
+	bool nopad, fips_non_compliant;
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_gcm)
@@ -254,24 +256,28 @@ FIXTURE_VARIANT_ADD(tls, 12_chacha)
 {
 	.tls_version = TLS_1_2_VERSION,
 	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_chacha)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_CHACHA20_POLY1305,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_sm4_gcm)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_SM4_GCM,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 13_sm4_ccm)
 {
 	.tls_version = TLS_1_3_VERSION,
 	.cipher_type = TLS_CIPHER_SM4_CCM,
+	.fips_non_compliant = true,
 };
 
 FIXTURE_VARIANT_ADD(tls, 12_aes_ccm)
@@ -311,6 +317,9 @@ FIXTURE_SETUP(tls)
 	int one = 1;
 	int ret;
 
+	if (fips_enabled && variant->fips_non_compliant)
+		SKIP(return, "Unsupported cipher in FIPS mode");
+
 	tls_crypto_info_init(variant->tls_version, variant->cipher_type,
 			     &tls12);
 
@@ -1820,4 +1829,17 @@ TEST(tls_v6ops) {
 	close(sfd);
 }
 
+static void __attribute__((constructor)) fips_check(void) {
+	int res;
+	FILE *f;
+
+	f = fopen("/proc/sys/crypto/fips_enabled", "r");
+	if (f) {
+		res = fscanf(f, "%d", &fips_enabled);
+		if (res != 1)
+			ksft_print_msg("ERROR: Couldn't read /proc/sys/crypto/fips_enabled\n");
+		fclose(f);
+	}
+}
+
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index 184da81f554f..452638ae8aed 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -264,60 +264,60 @@ setup_xfrm()
 	ip -netns host1 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST1_4} dst ${HOST2_4} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_4} dst ${h2_4}
 
 
 	ip -netns host1 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4} ${devarg}
 
 	ip -netns host2 xfrm state add src ${HOST2_4} dst ${HOST1_4} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_4} dst ${h1_4}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST1_6} dst ${HOST2_6} \
 	    proto esp spi ${SPI_1} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_1} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_1} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_1} 96 \
+	    enc 'cbc(aes)' ${ENC_1} \
 	    sel src ${h1_6} dst ${h2_6}
 
 
 	ip -6 -netns host1 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6} ${devarg}
 
 	ip -6 -netns host2 xfrm state add src ${HOST2_6} dst ${HOST1_6} \
 	    proto esp spi ${SPI_2} reqid 0 mode tunnel \
 	    replay-window 4 replay-oseq 0x4 \
-	    auth-trunc 'hmac(md5)' ${AUTH_2} 96 \
-	    enc 'cbc(des3_ede)' ${ENC_2} \
+	    auth-trunc 'hmac(sha1)' ${AUTH_2} 96 \
+	    enc 'cbc(aes)' ${ENC_2} \
 	    sel src ${h2_6} dst ${h1_6}
 }
 
diff --git a/tools/virtio/ringtest/main.h b/tools/virtio/ringtest/main.h
index b68920d52750..d18dd317e27f 100644
--- a/tools/virtio/ringtest/main.h
+++ b/tools/virtio/ringtest/main.h
@@ -8,6 +8,7 @@
 #ifndef MAIN_H
 #define MAIN_H
 
+#include <assert.h>
 #include <stdbool.h>
 
 extern int param;
@@ -95,6 +96,8 @@ extern unsigned ring_size;
 #define cpu_relax() asm ("rep; nop" ::: "memory")
 #elif defined(__s390x__)
 #define cpu_relax() barrier()
+#elif defined(__aarch64__)
+#define cpu_relax() asm ("yield" ::: "memory")
 #else
 #define cpu_relax() assert(0)
 #endif
@@ -112,6 +115,8 @@ static inline void busy_wait(void)
 
 #if defined(__x86_64__) || defined(__i386__)
 #define smp_mb()     asm volatile("lock; addl $0,-132(%%rsp)" ::: "memory", "cc")
+#elif defined(__aarch64__)
+#define smp_mb()     asm volatile("dmb ish" ::: "memory")
 #else
 /*
  * Not using __ATOMIC_SEQ_CST since gcc docs say they are only synchronized
@@ -136,10 +141,16 @@ static inline void busy_wait(void)
 
 #if defined(__i386__) || defined(__x86_64__) || defined(__s390x__)
 #define smp_wmb() barrier()
+#elif defined(__aarch64__)
+#define smp_wmb() asm volatile("dmb ishst" ::: "memory")
 #else
 #define smp_wmb() smp_release()
 #endif
 
+#ifndef __always_inline
+#define __always_inline inline __attribute__((always_inline))
+#endif
+
 static __always_inline
 void __read_once_size(const volatile void *p, void *res, int size)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4ec97f72f8ce..9386e415e6b1 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -683,6 +683,24 @@ static __always_inline int kvm_handle_hva_range_no_flush(struct mmu_notifier *mn
 
 	return __kvm_handle_hva_range(kvm, &range);
 }
+
+static bool kvm_change_spte_gfn(struct kvm *kvm, struct kvm_gfn_range *range)
+{
+	/*
+	 * Skipping invalid memslots is correct if and only change_pte() is
+	 * surrounded by invalidate_range_{start,end}(), which is currently
+	 * guaranteed by the primary MMU.  If that ever changes, KVM needs to
+	 * unmap the memslot instead of skipping the memslot to ensure that KVM
+	 * doesn't hold references to the old PFN.
+	 */
+	WARN_ON_ONCE(!READ_ONCE(kvm->mn_active_invalidate_count));
+
+	if (range->slot->flags & KVM_MEMSLOT_INVALID)
+		return false;
+
+	return kvm_set_spte_gfn(kvm, range);
+}
+
 static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 					struct mm_struct *mm,
 					unsigned long address,
@@ -704,7 +722,7 @@ static void kvm_mmu_notifier_change_pte(struct mmu_notifier *mn,
 	if (!READ_ONCE(kvm->mmu_invalidate_in_progress))
 		return;
 
-	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_set_spte_gfn);
+	kvm_handle_hva_range(mn, address, address + 1, pte, kvm_change_spte_gfn);
 }
 
 void kvm_mmu_invalidate_begin(struct kvm *kvm, unsigned long start,
