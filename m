Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8C996D3E44
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 09:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjDCHmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 03:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbjDCHm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 03:42:28 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052CCBBA8
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 00:42:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r29so28218394wra.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 00:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680507744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5lIMvCiOpXbjiA/H8m7sjsrgtjChRorDGbAszqv8dTw=;
        b=RZ5neoIUjL3gtmVC9SsbfcC9HNH1lmUqXYCwYiBpqTQaXggs3Zks/fOlRphVhClxEn
         QJ5nsah+fKVcblUF4uELFa7yco4YF7VUfpClFI9w+tMxKUELJ2EcmQrqB9o0Wu7bb4vz
         PJ17vPZ+/oZ7CvHTQ3BoxyNfYisSxFmnaGtxURakuKgMri5mDrT1JStLPuZ+8IhKtqMq
         d0n/PBjRPgAbWHTo2uHgQTEdFCYoK0cLpSJ56t0KE8M+mkq095sE/Y84CkNO3hJvcIFa
         kd6dnlrk4HD7f9gs7TabS048kon4Tc7o2DHEBWo6dOLTIdSHs29Wt2ileLCRhv8FHl5m
         dvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680507744;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5lIMvCiOpXbjiA/H8m7sjsrgtjChRorDGbAszqv8dTw=;
        b=6tK17NSQeRpBxcTCxmSoED2UjP6vBNz4zIOiRlTsJUdIe+CrbmiyL5LUMjcoYUlw+k
         A8k8fFyvMPMHWpOqz3gkZ1kAOU1SCCJvBQKPPwxwRUhsb0VOHZnWGLToPxAS9dzFEO55
         ezqDjoOfZimvmZgprmWKurvaHnko8GMdprgcOBoK+lOVgx1LG5SkH3EZvkZ0DX4+6fHM
         XhRLXWAD5fWFzwmrG/EryvVlgTMX/KW6Otb4SrkA4SzVBlxyRe5js1Y4ln21dvtdS2C4
         VpnPXV5QoCkb0/0Kq9dRqdSIT1vqmS6sfqbe05pQwRHa7h0pc7owksGqLiolZkt2NAI/
         SADw==
X-Gm-Message-State: AAQBX9dbnmBo0AMWbN1ZoP2Q0b5Th6Bac1TZ0x5IstMZfpfyGYZZ0A+P
        bBwgCZea9xaYGL5CbN1IPIT1EQ==
X-Google-Smtp-Source: AKy350Yniqdqc+Q5myV/H73Qhyh9BvslsjSTxkmlc/aqhCtpZ8+tchcyrqoWB2n2QIIhHWA81UE92w==
X-Received: by 2002:adf:e882:0:b0:2ce:a8f4:2b01 with SMTP id d2-20020adfe882000000b002cea8f42b01mr13253583wrm.32.1680507744351;
        Mon, 03 Apr 2023 00:42:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id q14-20020adff94e000000b002e62384d17dsm8180482wrr.21.2023.04.03.00.42.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 00:42:24 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 03 Apr 2023 09:42:18 +0200
Subject: [PATCH RFC v2 1/4] ARM: dts: oxnas: remove obsolete device tree
 files
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230331-topic-oxnas-upstream-remove-v2-1-e51078376f08@linaro.org>
References: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
In-Reply-To: <20230331-topic-oxnas-upstream-remove-v2-0-e51078376f08@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-oxnas@groups.io,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Golle <daniel@makrotopia.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to lack of maintainance and stall of development for a few years now,
and since no new features will ever be added upstream, remove support
for OX810 and OX820 devices.

Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Daniel Golle <daniel@makrotopia.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 arch/arm/boot/dts/Makefile                         |   3 -
 arch/arm/boot/dts/ox810se-wd-mbwe.dts              | 115 -------
 arch/arm/boot/dts/ox810se.dtsi                     | 357 ---------------------
 .../dts/ox820-cloudengines-pogoplug-series-3.dts   |  93 ------
 arch/arm/boot/dts/ox820.dtsi                       | 299 -----------------
 5 files changed, 867 deletions(-)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index efe4152e5846..ad83faecfdc6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1033,9 +1033,6 @@ dtb-$(CONFIG_ARCH_PXA) += \
 	pxa300-raumfeld-speaker-m.dtb \
 	pxa300-raumfeld-speaker-one.dtb \
 	pxa300-raumfeld-speaker-s.dtb
-dtb-$(CONFIG_ARCH_OXNAS) += \
-	ox810se-wd-mbwe.dtb \
-	ox820-cloudengines-pogoplug-series-3.dtb
 dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8016-sbc.dtb \
 	qcom-apq8026-asus-sparrow.dtb \
diff --git a/arch/arm/boot/dts/ox810se-wd-mbwe.dts b/arch/arm/boot/dts/ox810se-wd-mbwe.dts
deleted file mode 100644
index c59e06ff2423..000000000000
--- a/arch/arm/boot/dts/ox810se-wd-mbwe.dts
+++ /dev/null
@@ -1,115 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * wd-mbwe.dtsi - Device tree file for Western Digital My Book World Edition
- *
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-/dts-v1/;
-#include "ox810se.dtsi"
-
-/ {
-	model = "Western Digital My Book World Edition";
-
-	compatible = "wd,mbwe", "oxsemi,ox810se";
-
-	chosen {
-		bootargs = "console=ttyS1,115200n8 earlyprintk=serial";
-	};
-
-	memory {
-		/* 128Mbytes DDR */
-		reg = <0x48000000 0x8000000>;
-	};
-
-	aliases {
-		serial1 = &uart1;
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-	};
-
-	gpio-keys-polled {
-		compatible = "gpio-keys-polled";
-		#address-cells = <1>;
-		#size-cells = <0>;
-		poll-interval = <100>;
-
-		power {
-			label = "power";
-			gpios = <&gpio0 0 1>;
-			linux,code = <0x198>;
-		};
-
-		recovery {
-			label = "recovery";
-			gpios = <&gpio0 4 1>;
-			linux,code = <0xab>;
-		};
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		a0 {
-			label = "activity0";
-			gpios = <&gpio0 25 0>;
-			default-state = "keep";
-		};
-
-		a1 {
-			label = "activity1";
-			gpios = <&gpio0 26 0>;
-			default-state = "keep";
-		};
-
-		a2 {
-			label = "activity2";
-			gpios = <&gpio0 5 0>;
-			default-state = "keep";
-		};
-
-		a3 {
-			label = "activity3";
-			gpios = <&gpio0 6 0>;
-			default-state = "keep";
-		};
-
-		a4 {
-			label = "activity4";
-			gpios = <&gpio0 7 0>;
-			default-state = "keep";
-		};
-
-		a5 {
-			label = "activity5";
-			gpios = <&gpio1 2 0>;
-			default-state = "keep";
-		};
-	};
-
-	i2c-gpio {
-		compatible = "i2c-gpio";
-		gpios = <&gpio0 3 0 /* sda */
-			 &gpio0 2 0 /* scl */
-			 >;
-		i2c-gpio,delay-us = <2>;        /* ~100 kHz */
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		rtc0: rtc@48 {
-			compatible = "st,m41t00";
-			reg = <0x68>;
-		};
-	};
-};
-
-&etha {
-	status = "okay";
-};
-
-&uart1 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart1>;
-};
diff --git a/arch/arm/boot/dts/ox810se.dtsi b/arch/arm/boot/dts/ox810se.dtsi
deleted file mode 100644
index 96c0745f7b70..000000000000
--- a/arch/arm/boot/dts/ox810se.dtsi
+++ /dev/null
@@ -1,357 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * ox810se.dtsi - Device tree file for Oxford Semiconductor OX810SE SoC
- *
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#include <dt-bindings/clock/oxsemi,ox810se.h>
-#include <dt-bindings/reset/oxsemi,ox810se.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "oxsemi,ox810se";
-
-	cpus {
-		#address-cells = <0>;
-		#size-cells = <0>;
-
-		cpu {
-			device_type = "cpu";
-			compatible = "arm,arm926ej-s";
-			clocks = <&armclk>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		/* Max 256MB @ 0x48000000 */
-		reg = <0x48000000 0x10000000>;
-	};
-
-	clocks {
-		osc: oscillator {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <25000000>;
-		};
-
-		gmacclk: gmacclk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
-
-		rpsclk: rpsclk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <1>;
-			clock-mult = <1>;
-			clocks = <&osc>;
-		};
-
-		pll400: pll400 {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <733333333>;
-		};
-
-		sysclk: sysclk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-			clocks = <&pll400>;
-		};
-
-		armclk: armclk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-			clocks = <&pll400>;
-		};
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges;
-		interrupt-parent = <&intc>;
-
-		etha: ethernet@40400000 {
-			compatible = "oxsemi,ox810se-dwmac", "snps,dwmac";
-			reg = <0x40400000 0x2000>;
-			interrupts = <8>;
-			interrupt-names = "macirq";
-			mac-address = [000000000000]; /* Filled in by U-Boot */
-			phy-mode = "rgmii";
-
-			clocks = <&stdclk 6>, <&gmacclk>;
-			clock-names = "gmac", "stmmaceth";
-			resets = <&reset 6>;
-
-			/* Regmap for sys registers */
-			oxsemi,sys-ctrl = <&sys>;
-
-			status = "disabled";
-		};
-
-		apb-bridge@44000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0 0x44000000 0x1000000>;
-
-			pinctrl: pinctrl {
-				compatible = "oxsemi,ox810se-pinctrl";
-
-				/* Regmap for sys registers */
-				oxsemi,sys-ctrl = <&sys>;
-
-				pinctrl_uart0: uart0 {
-					uart0a {
-						pins = "gpio31";
-						function = "fct3";
-					};
-					uart0b {
-						pins = "gpio32";
-						function = "fct3";
-					};
-				};
-
-				pinctrl_uart0_modem: uart0_modem {
-					uart0c {
-						pins = "gpio27";
-						function = "fct3";
-					};
-					uart0d {
-						pins = "gpio28";
-						function = "fct3";
-					};
-					uart0e {
-						pins = "gpio29";
-						function = "fct3";
-					};
-					uart0f {
-						pins = "gpio30";
-						function = "fct3";
-					};
-					uart0g {
-						pins = "gpio33";
-						function = "fct3";
-					};
-					uart0h {
-						pins = "gpio34";
-						function = "fct3";
-					};
-				};
-
-				pinctrl_uart1: uart1 {
-					uart1a {
-						pins = "gpio20";
-						function = "fct3";
-					};
-					uart1b {
-						pins = "gpio22";
-						function = "fct3";
-					};
-				};
-
-				pinctrl_uart1_modem: uart1_modem {
-					uart1c {
-						pins = "gpio8";
-						function = "fct3";
-					};
-					uart1d {
-						pins = "gpio9";
-						function = "fct3";
-					};
-					uart1e {
-						pins = "gpio23";
-						function = "fct3";
-					};
-					uart1f {
-						pins = "gpio24";
-						function = "fct3";
-					};
-					uart1g {
-						pins = "gpio25";
-						function = "fct3";
-					};
-					uart1h {
-						pins = "gpio26";
-						function = "fct3";
-					};
-				};
-
-				pinctrl_uart2: uart2 {
-					uart2a {
-						pins = "gpio6";
-						function = "fct3";
-					};
-					uart2b {
-						pins = "gpio7";
-						function = "fct3";
-					};
-				};
-
-				pinctrl_uart2_modem: uart2_modem {
-					uart2c {
-						pins = "gpio0";
-						function = "fct3";
-					};
-					uart2d {
-						pins = "gpio1";
-						function = "fct3";
-					};
-					uart2e {
-						pins = "gpio2";
-						function = "fct3";
-					};
-					uart2f {
-						pins = "gpio3";
-						function = "fct3";
-					};
-					uart2g {
-						pins = "gpio4";
-						function = "fct3";
-					};
-					uart2h {
-						pins = "gpio5";
-						function = "fct3";
-					};
-				};
-			};
-
-			gpio0: gpio@0 {
-				compatible = "oxsemi,ox810se-gpio";
-				reg = <0x000000 0x100000>;
-				interrupts = <21>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				ngpios = <32>;
-				oxsemi,gpio-bank = <0>;
-				gpio-ranges = <&pinctrl 0 0 32>;
-			};
-
-			gpio1: gpio@100000 {
-				compatible = "oxsemi,ox810se-gpio";
-				reg = <0x100000 0x100000>;
-				interrupts = <22>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				ngpios = <3>;
-				oxsemi,gpio-bank = <1>;
-				gpio-ranges = <&pinctrl 0 32 3>;
-			};
-
-			uart0: serial@200000 {
-			       compatible = "ns16550a";
-			       reg = <0x200000 0x100000>;
-			       clocks = <&sysclk>;
-			       interrupts = <23>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       resets = <&reset RESET_UART1>;
-			};
-
-			uart1: serial@300000 {
-			       compatible = "ns16550a";
-			       reg = <0x300000 0x100000>;
-			       clocks = <&sysclk>;
-			       interrupts = <24>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       resets = <&reset RESET_UART2>;
-			};
-
-			uart2: serial@900000 {
-			       compatible = "ns16550a";
-			       reg = <0x900000 0x100000>;
-			       clocks = <&sysclk>;
-			       interrupts = <29>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       resets = <&reset RESET_UART3>;
-			};
-
-			uart3: serial@a00000 {
-			       compatible = "ns16550a";
-			       reg = <0xa00000 0x100000>;
-			       clocks = <&sysclk>;
-			       interrupts = <30>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       resets = <&reset RESET_UART4>;
-			};
-		};
-
-		apb-bridge@45000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0 0x45000000 0x1000000>;
-
-			sys: sys-ctrl@0 {
-				compatible = "oxsemi,ox810se-sys-ctrl", "syscon", "simple-mfd";
-				reg = <0x000000 0x100000>;
-
-				reset: reset-controller {
-					compatible = "oxsemi,ox810se-reset";
-					#reset-cells = <1>;
-				};
-
-				stdclk: stdclk {
-					compatible = "oxsemi,ox810se-stdclk";
-					#clock-cells = <1>;
-				};
-			};
-
-			rps@300000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "simple-bus";
-				ranges = <0 0x300000 0x100000>;
-
-				intc: interrupt-controller@0 {
-					compatible = "oxsemi,ox810se-rps-irq";
-					interrupt-controller;
-					reg = <0 0x200>;
-					#interrupt-cells = <1>;
-					valid-mask = <0xffffffff>;
-					clear-mask = <0xffffffff>;
-				};
-
-				timer0: timer@200 {
-					compatible = "oxsemi,ox810se-rps-timer";
-					reg = <0x200 0x40>;
-					clocks = <&rpsclk>;
-					interrupts = <4 5>;
-				};
-			};
-		};
-	};
-};
diff --git a/arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts b/arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
deleted file mode 100644
index c3daceccde55..000000000000
--- a/arch/arm/boot/dts/ox820-cloudengines-pogoplug-series-3.dts
+++ /dev/null
@@ -1,93 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * cloudengines-pogoplug-series-3.dtsi - Device tree file for Cloud Engines PogoPlug Series 3
- *
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-/dts-v1/;
-#include "ox820.dtsi"
-
-/ {
-	model = "Cloud Engines PogoPlug Series 3";
-
-	compatible = "cloudengines,pogoplugv3", "oxsemi,ox820";
-
-	chosen {
-		bootargs = "earlyprintk";
-		stdout-path = "serial0:115200n8";
-	};
-
-	memory {
-		/* 128Mbytes DDR */
-		reg = <0x60000000 0x8000000>;
-	};
-
-	aliases {
-		serial0 = &uart0;
-		gpio0 = &gpio0;
-		gpio1 = &gpio1;
-	};
-
-	leds {
-		compatible = "gpio-leds";
-
-		blue {
-			label = "pogoplug:blue";
-			gpios = <&gpio0 2 0>;
-			default-state = "keep";
-		};
-
-		orange {
-			label = "pogoplug:orange";
-			gpios = <&gpio1 16 1>;
-			default-state = "keep";
-		};
-
-		green {
-			label = "pogoplug:green";
-			gpios = <&gpio1 17 1>;
-			default-state = "keep";
-		};
-	};
-};
-
-&uart0 {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_uart0>;
-};
-
-&nandc {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_nand>;
-
-	nand@0 {
-		reg = <0>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-		nand-ecc-mode = "soft";
-		nand-ecc-algo = "hamming";
-
-		partition@0 {
-			label = "boot";
-			reg = <0x00000000 0x00e00000>;
-			read-only;
-		};
-
-		partition@e00000 {
-			label = "ubi";
-			reg = <0x00e00000 0x07200000>;
-		};
-	};
-};
-
-&etha {
-	status = "okay";
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_etha_mdio>;
-};
diff --git a/arch/arm/boot/dts/ox820.dtsi b/arch/arm/boot/dts/ox820.dtsi
deleted file mode 100644
index dde4364892bf..000000000000
--- a/arch/arm/boot/dts/ox820.dtsi
+++ /dev/null
@@ -1,299 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * ox820.dtsi - Device tree file for Oxford Semiconductor OX820 SoC
- *
- * Copyright (C) 2016 Neil Armstrong <narmstrong@baylibre.com>
- */
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
-#include <dt-bindings/clock/oxsemi,ox820.h>
-#include <dt-bindings/reset/oxsemi,ox820.h>
-
-/ {
-	#address-cells = <1>;
-	#size-cells = <1>;
-	compatible = "oxsemi,ox820";
-
-	cpus {
-		#address-cells = <1>;
-		#size-cells = <0>;
-		enable-method = "oxsemi,ox820-smp";
-
-		cpu@0 {
-			device_type = "cpu";
-			compatible = "arm,arm11mpcore";
-			clocks = <&armclk>;
-			reg = <0>;
-		};
-
-		cpu@1 {
-			device_type = "cpu";
-			compatible = "arm,arm11mpcore";
-			clocks = <&armclk>;
-			reg = <1>;
-		};
-	};
-
-	memory {
-		device_type = "memory";
-		/* Max 512MB @ 0x60000000 */
-		reg = <0x60000000 0x20000000>;
-	};
-
-	clocks {
-		osc: oscillator {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <25000000>;
-		};
-
-		gmacclk: gmacclk {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <125000000>;
-		};
-
-		sysclk: sysclk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <4>;
-			clock-mult = <1>;
-			clocks = <&osc>;
-		};
-
-		plla: plla {
-			compatible = "fixed-clock";
-			#clock-cells = <0>;
-			clock-frequency = <850000000>;
-		};
-
-		armclk: armclk {
-			compatible = "fixed-factor-clock";
-			#clock-cells = <0>;
-			clock-div = <2>;
-			clock-mult = <1>;
-			clocks = <&plla>;
-		};
-	};
-
-	soc {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		compatible = "simple-bus";
-		ranges;
-		interrupt-parent = <&gic>;
-
-		nandc: nand-controller@41000000 {
-			compatible = "oxsemi,ox820-nand";
-			reg = <0x41000000 0x100000>;
-			clocks = <&stdclk CLK_820_NAND>;
-			resets = <&reset RESET_NAND>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-			status = "disabled";
-		};
-
-		etha: ethernet@40400000 {
-			compatible = "oxsemi,ox820-dwmac", "snps,dwmac";
-			reg = <0x40400000 0x2000>;
-			interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-				     <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
-			interrupt-names = "macirq", "eth_wake_irq";
-			mac-address = [000000000000]; /* Filled in by U-Boot */
-			phy-mode = "rgmii";
-
-			clocks = <&stdclk CLK_820_ETHA>, <&gmacclk>;
-			clock-names = "gmac", "stmmaceth";
-			resets = <&reset RESET_MAC>;
-
-			/* Regmap for sys registers */
-			oxsemi,sys-ctrl = <&sys>;
-
-			status = "disabled";
-		};
-
-		apb-bridge@44000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0 0x44000000 0x1000000>;
-
-			pinctrl: pinctrl {
-				compatible = "oxsemi,ox820-pinctrl";
-
-				/* Regmap for sys registers */
-				oxsemi,sys-ctrl = <&sys>;
-
-				pinctrl_uart0: uart0 {
-					uart0 {
-						pins = "gpio30", "gpio31";
-						function = "fct5";
-					};
-				};
-
-				pinctrl_uart0_modem: uart0_modem {
-					uart0_modem_a {
-						pins = "gpio24", "gpio24", "gpio26", "gpio27";
-						function = "fct4";
-					};
-					uart0_modem_b {
-						pins = "gpio28", "gpio29";
-						function = "fct5";
-					};
-				};
-
-				pinctrl_uart1: uart1 {
-					uart1 {
-						pins = "gpio7", "gpio8";
-						function = "fct4";
-					};
-				};
-
-				pinctrl_uart1_modem: uart1_modem {
-					uart1_modem {
-						pins = "gpio5", "gpio6", "gpio40", "gpio41", "gpio42", "gpio43";
-						function = "fct4";
-					};
-				};
-
-				pinctrl_etha_mdio: etha_mdio {
-					etha_mdio {
-						pins = "gpio3", "gpio4";
-						function = "fct1";
-					};
-				};
-
-				pinctrl_nand: nand {
-					nand {
-						pins = "gpio12", "gpio13", "gpio14", "gpio15",
-						     "gpio16", "gpio17", "gpio18", "gpio19",
-						     "gpio20", "gpio21", "gpio22", "gpio23",
-						     "gpio24";
-						function = "fct1";
-					};
-				};
-			};
-
-			gpio0: gpio@0 {
-				compatible = "oxsemi,ox820-gpio";
-				reg = <0x000000 0x100000>;
-				interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				ngpios = <32>;
-				oxsemi,gpio-bank = <0>;
-				gpio-ranges = <&pinctrl 0 0 32>;
-			};
-
-			gpio1: gpio@100000 {
-				compatible = "oxsemi,ox820-gpio";
-				reg = <0x100000 0x100000>;
-				interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-				#gpio-cells = <2>;
-				gpio-controller;
-				interrupt-controller;
-				#interrupt-cells = <2>;
-				ngpios = <18>;
-				oxsemi,gpio-bank = <1>;
-				gpio-ranges = <&pinctrl 0 32 18>;
-			};
-
-			uart0: serial@200000 {
-			       compatible = "ns16550a";
-			       reg = <0x200000 0x100000>;
-			       interrupts = <GIC_SPI 23 IRQ_TYPE_LEVEL_HIGH>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       clocks = <&sysclk>;
-			       resets = <&reset RESET_UART1>;
-			};
-
-			uart1: serial@300000 {
-			       compatible = "ns16550a";
-			       reg = <0x200000 0x100000>;
-			       interrupts = <GIC_SPI 24 IRQ_TYPE_LEVEL_HIGH>;
-			       reg-shift = <0>;
-			       fifo-size = <16>;
-			       reg-io-width = <1>;
-			       current-speed = <115200>;
-			       no-loopback-test;
-			       status = "disabled";
-			       clocks = <&sysclk>;
-			       resets = <&reset RESET_UART2>;
-			};
-
-			rps@400000 {
-				#address-cells = <1>;
-				#size-cells = <1>;
-				compatible = "simple-bus";
-				ranges = <0 0x400000 0x100000>;
-
-				intc: interrupt-controller@0 {
-					compatible = "oxsemi,ox820-rps-irq", "oxsemi,ox810se-rps-irq";
-					interrupt-controller;
-					reg = <0 0x200>;
-					interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
-					#interrupt-cells = <1>;
-					valid-mask = <0xffffffff>;
-					clear-mask = <0xffffffff>;
-				};
-
-				timer0: timer@200 {
-					compatible = "oxsemi,ox820-rps-timer";
-					reg = <0x200 0x40>;
-					clocks = <&sysclk>;
-					interrupt-parent = <&intc>;
-					interrupts = <4>;
-				};
-			};
-
-			sys: sys-ctrl@e00000 {
-				compatible = "oxsemi,ox820-sys-ctrl", "syscon", "simple-mfd";
-				reg = <0xe00000 0x200000>;
-
-				reset: reset-controller {
-					compatible = "oxsemi,ox820-reset", "oxsemi,ox810se-reset";
-					#reset-cells = <1>;
-				};
-
-				stdclk: stdclk {
-					compatible = "oxsemi,ox820-stdclk", "oxsemi,ox810se-stdclk";
-					#clock-cells = <1>;
-				};
-			};
-		};
-
-		apb-bridge@47000000 {
-			#address-cells = <1>;
-			#size-cells = <1>;
-			compatible = "simple-bus";
-			ranges = <0 0x47000000 0x1000000>;
-
-			scu: scu@0 {
-				compatible = "arm,arm11mp-scu";
-				reg = <0x0 0x100>;
-			};
-
-			local-timer@600 {
-				compatible = "arm,arm11mp-twd-timer";
-				reg = <0x600 0x20>;
-				interrupts = <GIC_PPI 13 (GIC_CPU_MASK_RAW(3)|IRQ_TYPE_LEVEL_HIGH)>;
-				clocks = <&armclk>;
-			};
-
-			gic: interrupt-controller@1000 {
-				compatible = "arm,arm11mp-gic";
-				interrupt-controller;
-				#interrupt-cells = <3>;
-				reg = <0x1000 0x1000>,
-				      <0x100 0x500>;
-			};
-		};
-	};
-};

-- 
2.34.1

