Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499075F2246
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 11:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiJBJUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 05:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiJBJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 05:20:08 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2015255B6
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 02:20:05 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id q14so6045658lfo.11
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 02:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=QBZMAJAxMrPNHdg481WaBpLZQsXkH2r3O7VryTI9hk0=;
        b=qi4nRQ27xnDwuZ3QRzfJsJSv4jtM2Ws7l3abf446v0/Py/GkGXCnBVi7cHBTi6kk9e
         pawl/p4oi+DYf+4Vj3jPhj+abymzCrPLR33RAMLssOa4qCBCZ02kMPBlh5YSP7tB2mLs
         lg5if7onxMHTd0/ft6D1a3cjnvboAW4MkOPfgPt56Qhf0fdAJX2jMXE9CtFbIA7qN3JW
         CuLNuXciKscKePY8duK9eQ2LAkhY0Z2HfNUzyP54dbvFfmxOqh6HcNr11GRNVgwh+kNc
         eSnvK3cBw4kTeHX9JiXNpRQ2KGBrAQTv0pglA8Xmnlnt2XyENYBibsi2OwRChH/ksNZD
         GEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=QBZMAJAxMrPNHdg481WaBpLZQsXkH2r3O7VryTI9hk0=;
        b=Qv9zIu9/Cx07h+Vw9kUxG/xHbEDd+32mqBp7iuLBcqVTs81h33jJGe64kRzhC2fOZ2
         3xzyPXx5S4VPE651uPrZoPyGHsEaMcahPI1cCzoGj75+OjwHZicHRjYtuxPbkRFgR3LX
         xldZZLnaZRUKCBsuF6gTzayZ6gsII7bd8N7M5x5VYPVrQ4ayA55ia1pUqcXaoqde/Hn1
         7wEJPWL2ScI2cFjhSqG+wW4+nZ09Tc3/h6cg02+0bjEGtI4BW2/9OL667ZNcM6LVK4Kf
         5k5lPNj/oFWMXAM7S0TmkG4giZF+oMU3q9AgDpat88uJ3ROyji/yQm7musoZd4qRhT4L
         hKjA==
X-Gm-Message-State: ACrzQf0owFEQMTWZe3FRsUgX2iOn1jtIRqnKFbQawrZCb34DZ0ROIVQN
        k8++sn2oWNUGP2GM9zvZUUKKWg==
X-Google-Smtp-Source: AMsMyM67Wj5EIBWIC7X899ATo6pM3KIBNjWmewTjxbuE8WjsgI1MLkZ5OiExuBlRAf142PpRjhyPOQ==
X-Received: by 2002:a05:6512:3c8c:b0:498:f7ba:9a69 with SMTP id h12-20020a0565123c8c00b00498f7ba9a69mr5936982lfv.8.1664702404294;
        Sun, 02 Oct 2022 02:20:04 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id g5-20020a2eb5c5000000b0026bf43a4d72sm584474ljn.115.2022.10.02.02.20.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 02:20:03 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     =?UTF-8?q?Beno=C3=AEt=20Cousson?= <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ARM: dts: omap: correct indentation
Date:   Sun,  2 Oct 2022 11:20:02 +0200
Message-Id: <20221002092002.68880-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not use spaces for indentation.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi |  6 +--
 arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi |  6 +--
 arch/arm/boot/dts/omap3-cm-t3517.dts      | 12 ++---
 arch/arm/boot/dts/omap3-gta04.dtsi        |  6 +--
 arch/arm/boot/dts/omap3-ldp.dts           |  2 +-
 arch/arm/boot/dts/omap3-n900.dts          | 38 +++++++-------
 arch/arm/boot/dts/omap3-zoom3.dts         | 44 ++++++++--------
 arch/arm/boot/dts/omap4-cpu-thermal.dtsi  | 24 ++++-----
 arch/arm/boot/dts/omap5-cm-t54.dts        | 64 +++++++++++------------
 9 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
index ce6c235f68ec..3046ec572632 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc911x.dtsi
@@ -8,9 +8,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
index e7534fe9c53c..bc8961f3690f 100644
--- a/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
+++ b/arch/arm/boot/dts/omap-gpmc-smsc9221.dtsi
@@ -12,9 +12,9 @@
 
 / {
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
diff --git a/arch/arm/boot/dts/omap3-cm-t3517.dts b/arch/arm/boot/dts/omap3-cm-t3517.dts
index 3b8349094baa..f25c0a84a190 100644
--- a/arch/arm/boot/dts/omap3-cm-t3517.dts
+++ b/arch/arm/boot/dts/omap3-cm-t3517.dts
@@ -11,12 +11,12 @@ / {
 	model = "CompuLab CM-T3517";
 	compatible = "compulab,omap3-cm-t3517", "ti,am3517", "ti,omap3";
 
-	vmmc:  regulator-vmmc {
-                compatible = "regulator-fixed";
-                regulator-name = "vmmc";
-                regulator-min-microvolt = <3300000>;
-                regulator-max-microvolt = <3300000>;
-        };
+	vmmc: regulator-vmmc {
+		compatible = "regulator-fixed";
+		regulator-name = "vmmc";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
 
 	wl12xx_vmmc2: wl12xx_vmmc2 {
 		compatible = "regulator-fixed";
diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
index 28a6a9345be5..330bca6f8199 100644
--- a/arch/arm/boot/dts/omap3-gta04.dtsi
+++ b/arch/arm/boot/dts/omap3-gta04.dtsi
@@ -332,7 +332,7 @@ OMAP3_CORE1_IOPAD(0x2106, PIN_OUTPUT | MUX_MODE0)   /* dss_data21.dss_data21 */
 			OMAP3_CORE1_IOPAD(0x2108, PIN_OUTPUT | MUX_MODE0)   /* dss_data22.dss_data22 */
 			OMAP3_CORE1_IOPAD(0x210a, PIN_OUTPUT | MUX_MODE0)   /* dss_data23.dss_data23 */
 		>;
-       };
+	};
 
 	gps_pins: pinmux_gps_pins {
 		pinctrl-single,pins = <
@@ -853,8 +853,8 @@ &mcbsp4 { /* GSM voice PCM */
 };
 
 &hdqw1w {
-        pinctrl-names = "default";
-        pinctrl-0 = <&hdq_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&hdq_pins>;
 };
 
 /* image signal processor within OMAP3 SoC */
diff --git a/arch/arm/boot/dts/omap3-ldp.dts b/arch/arm/boot/dts/omap3-ldp.dts
index 36fc8805e0c1..85f33bbb566f 100644
--- a/arch/arm/boot/dts/omap3-ldp.dts
+++ b/arch/arm/boot/dts/omap3-ldp.dts
@@ -301,5 +301,5 @@ &usb_otg_hs {
 
 &vaux1 {
 	/* Needed for ads7846 */
-        regulator-name = "vcc";
+	regulator-name = "vcc";
 };
diff --git a/arch/arm/boot/dts/omap3-n900.dts b/arch/arm/boot/dts/omap3-n900.dts
index dd7971556449..98a67581bdd2 100644
--- a/arch/arm/boot/dts/omap3-n900.dts
+++ b/arch/arm/boot/dts/omap3-n900.dts
@@ -236,27 +236,27 @@ gpmc_pins: pinmux_gpmc_pins {
 		pinctrl-single,pins = <
 
 			/* address lines */
-                        OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
-                        OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
-                        OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
+			OMAP3_CORE1_IOPAD(0x207a, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a1.gpmc_a1 */
+			OMAP3_CORE1_IOPAD(0x207c, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a2.gpmc_a2 */
+			OMAP3_CORE1_IOPAD(0x207e, PIN_OUTPUT | MUX_MODE0)       /* gpmc_a3.gpmc_a3 */
 
 			/* data lines, gpmc_d0..d7 not muxable according to TRM */
-                        OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
-                        OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
-                        OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
-                        OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
-                        OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
-                        OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
-                        OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
-                        OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
+			OMAP3_CORE1_IOPAD(0x209e, PIN_INPUT | MUX_MODE0)        /* gpmc_d8.gpmc_d8 */
+			OMAP3_CORE1_IOPAD(0x20a0, PIN_INPUT | MUX_MODE0)        /* gpmc_d9.gpmc_d9 */
+			OMAP3_CORE1_IOPAD(0x20a2, PIN_INPUT | MUX_MODE0)        /* gpmc_d10.gpmc_d10 */
+			OMAP3_CORE1_IOPAD(0x20a4, PIN_INPUT | MUX_MODE0)        /* gpmc_d11.gpmc_d11 */
+			OMAP3_CORE1_IOPAD(0x20a6, PIN_INPUT | MUX_MODE0)        /* gpmc_d12.gpmc_d12 */
+			OMAP3_CORE1_IOPAD(0x20a8, PIN_INPUT | MUX_MODE0)        /* gpmc_d13.gpmc_d13 */
+			OMAP3_CORE1_IOPAD(0x20aa, PIN_INPUT | MUX_MODE0)        /* gpmc_d14.gpmc_d14 */
+			OMAP3_CORE1_IOPAD(0x20ac, PIN_INPUT | MUX_MODE0)        /* gpmc_d15.gpmc_d15 */
 
 			/*
 			 * gpmc_ncs0, gpmc_nadv_ale, gpmc_noe, gpmc_nwe, gpmc_wait0 not muxable
 			 * according to TRM. OneNAND seems to require PIN_INPUT on clock.
 			 */
-                        OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
-                        OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
-		>;
+			OMAP3_CORE1_IOPAD(0x20b0, PIN_OUTPUT | MUX_MODE0)       /* gpmc_ncs1.gpmc_ncs1 */
+			OMAP3_CORE1_IOPAD(0x20be, PIN_INPUT | MUX_MODE0)        /* gpmc_clk.gpmc_clk */
+			>;
 	};
 
 	i2c1_pins: pinmux_i2c1_pins {
@@ -738,12 +738,12 @@ tpa6130a2: tpa6130a2@60 {
 
 	si4713: si4713@63 {
 		compatible = "silabs,si4713";
-                reg = <0x63>;
+		reg = <0x63>;
 
-                interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
-                reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
-                vio-supply = <&vio>;
-                vdd-supply = <&vaux1>;
+		interrupts-extended = <&gpio2 21 IRQ_TYPE_EDGE_FALLING>; /* 53 */
+		reset-gpios = <&gpio6 3 GPIO_ACTIVE_HIGH>; /* 163 */
+		vio-supply = <&vio>;
+		vdd-supply = <&vaux1>;
 	};
 
 	bq24150a: bq24150a@6b {
diff --git a/arch/arm/boot/dts/omap3-zoom3.dts b/arch/arm/boot/dts/omap3-zoom3.dts
index 0482676d1830..ce58b1f208e8 100644
--- a/arch/arm/boot/dts/omap3-zoom3.dts
+++ b/arch/arm/boot/dts/omap3-zoom3.dts
@@ -23,9 +23,9 @@ memory@80000000 {
 	};
 
 	vddvario: regulator-vddvario {
-		  compatible = "regulator-fixed";
-		  regulator-name = "vddvario";
-		  regulator-always-on;
+		compatible = "regulator-fixed";
+		regulator-name = "vddvario";
+		regulator-always-on;
 	};
 
 	vdd33a: regulator-vdd33a {
@@ -84,28 +84,28 @@ OMAP3_CORE1_IOPAD(0x21d0, PIN_INPUT_PULLUP | MUX_MODE3)	/* mcspi1_cs1.sdmmc3_cmd
 
 	uart1_pins: pinmux_uart1_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
-                        OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
-                        OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
-                        OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
+			OMAP3_CORE1_IOPAD(0x2180, PIN_INPUT | MUX_MODE0)		/* uart1_cts.uart1_cts */
+			OMAP3_CORE1_IOPAD(0x217e, PIN_OUTPUT | MUX_MODE0)		/* uart1_rts.uart1_rts */
+			OMAP3_CORE1_IOPAD(0x2182, WAKEUP_EN | PIN_INPUT | MUX_MODE0) /* uart1_rx.uart1_rx */
+			OMAP3_CORE1_IOPAD(0x217c, PIN_OUTPUT | MUX_MODE0)		/* uart1_tx.uart1_tx */
 		>;
 	};
 
 	uart2_pins: pinmux_uart2_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
-                        OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
-                        OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
-                        OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
+			OMAP3_CORE1_IOPAD(0x2174, PIN_INPUT_PULLUP | MUX_MODE0)	/* uart2_cts.uart2_cts */
+			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT | MUX_MODE0)		/* uart2_rts.uart2_rts */
+			OMAP3_CORE1_IOPAD(0x217a, PIN_INPUT | MUX_MODE0)		/* uart2_rx.uart2_rx */
+			OMAP3_CORE1_IOPAD(0x2178, PIN_OUTPUT | MUX_MODE0)		/* uart2_tx.uart2_tx */
 		>;
 	};
 
 	uart3_pins: pinmux_uart3_pins {
 		pinctrl-single,pins = <
-                        OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
-                        OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
-                        OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
-                        OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
+			OMAP3_CORE1_IOPAD(0x219a, PIN_INPUT_PULLDOWN | MUX_MODE0)	/* uart3_cts_rctx.uart3_cts_rctx */
+			OMAP3_CORE1_IOPAD(0x219c, PIN_OUTPUT | MUX_MODE0)		/* uart3_rts_sd.uart3_rts_sd */
+			OMAP3_CORE1_IOPAD(0x219e, PIN_INPUT | MUX_MODE0)		/* uart3_rx_irrx.uart3_rx_irrx */
+			OMAP3_CORE1_IOPAD(0x21a0, PIN_OUTPUT | MUX_MODE0)		/* uart3_tx_irtx.uart3_tx_irtx */
 		>;
 	};
 
@@ -205,22 +205,22 @@ wlcore: wlcore@2 {
 };
 
 &uart1 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
 };
 
 &uart2 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart2_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
 };
 
 &uart3 {
-       pinctrl-names = "default";
-       pinctrl-0 = <&uart3_pins>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
 };
 
 &uart4 {
-       status = "disabled";
+	status = "disabled";
 };
 
 &usb_otg_hs {
diff --git a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
index 4d7eeb133dad..801b4f10350c 100644
--- a/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/omap4-cpu-thermal.dtsi
@@ -13,20 +13,20 @@ cpu_thermal: cpu_thermal {
 	polling-delay = <1000>; /* milliseconds */
 
 			/* sensor       ID */
-        thermal-sensors = <&bandgap     0>;
+	thermal-sensors = <&bandgap     0>;
 
 	cpu_trips: trips {
-                cpu_alert0: cpu_alert {
-                        temperature = <100000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "passive";
-                };
-                cpu_crit: cpu_crit {
-                        temperature = <125000>; /* millicelsius */
-                        hysteresis = <2000>; /* millicelsius */
-                        type = "critical";
-                };
-        };
+		cpu_alert0: cpu_alert {
+			temperature = <100000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "passive";
+		};
+		cpu_crit: cpu_crit {
+			temperature = <125000>; /* millicelsius */
+			hysteresis = <2000>; /* millicelsius */
+			type = "critical";
+		};
+	};
 
 	cpu_cooling_maps: cooling-maps {
 		map0 {
diff --git a/arch/arm/boot/dts/omap5-cm-t54.dts b/arch/arm/boot/dts/omap5-cm-t54.dts
index ca759b7b8a58..2d87b9fc230e 100644
--- a/arch/arm/boot/dts/omap5-cm-t54.dts
+++ b/arch/arm/boot/dts/omap5-cm-t54.dts
@@ -84,36 +84,36 @@ led1 {
 	};
 
 	lcd0: display {
-                compatible = "startek,startek-kd050c", "panel-dpi";
-                label = "lcd";
-
-                pinctrl-names = "default";
-                pinctrl-0 = <&lcd_pins>;
-
-                enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
-
-                panel-timing {
-                        clock-frequency = <33000000>;
-                        hactive = <800>;
-                        vactive = <480>;
-                        hfront-porch = <40>;
-                        hback-porch = <40>;
-                        hsync-len = <43>;
-                        vback-porch = <29>;
-                        vfront-porch = <13>;
-                        vsync-len = <3>;
-                        hsync-active = <0>;
-                        vsync-active = <0>;
-                        de-active = <1>;
-                        pixelclk-active = <1>;
-                };
-
-                port {
-                        lcd_in: endpoint {
-                                remote-endpoint = <&dpi_lcd_out>;
-                        };
-                };
-        };
+		compatible = "startek,startek-kd050c", "panel-dpi";
+		label = "lcd";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&lcd_pins>;
+
+		enable-gpios = <&gpio8 3 GPIO_ACTIVE_HIGH>;
+
+		panel-timing {
+			clock-frequency = <33000000>;
+			hactive = <800>;
+			vactive = <480>;
+			hfront-porch = <40>;
+			hback-porch = <40>;
+			hsync-len = <43>;
+			vback-porch = <29>;
+			vfront-porch = <13>;
+			vsync-len = <3>;
+			hsync-active = <0>;
+			vsync-active = <0>;
+			de-active = <1>;
+			pixelclk-active = <1>;
+		};
+
+		port {
+			lcd_in: endpoint {
+				remote-endpoint = <&dpi_lcd_out>;
+			};
+		};
+	};
 
 	hdmi0: connector0 {
 		compatible = "hdmi-connector";
@@ -644,8 +644,8 @@ &usbhsehci {
 };
 
 &usb3 {
-       extcon = <&extcon_usb3>;
-       vbus-supply = <&smps10_out1_reg>;
+	extcon = <&extcon_usb3>;
+	vbus-supply = <&smps10_out1_reg>;
 };
 
 &cpu0 {
-- 
2.34.1

