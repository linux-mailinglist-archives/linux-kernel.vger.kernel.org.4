Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31B0A6C91CE
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 01:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjCZAP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 20:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCZAP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 20:15:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C1AAF1A;
        Sat, 25 Mar 2023 17:15:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so3050922wms.1;
        Sat, 25 Mar 2023 17:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679789754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q1Sh3NFXp4ir6XRWRZRmPrz3mlgkVC//DmmZmhPglLQ=;
        b=cTeNRWdMSh5pTOokkcnUaOtpi4VuNmot+4UImkCbG4m4f5w+lbvpy0jHiVKBtbRywf
         UsBbU0WcoMonQoVoQoB81D4KH0H/3TM2/GhQUdpME7hKbjWzG+bh1MJ/gt1upWKQU6wA
         V292zK4q4cJitUXZdOEPjTTFutmf5wY6sVEO+8noChEMm2OULpJMv7JSuN1HiD9eigYz
         LMlJJPpexDwvll62T1m0+zG4iHE0s1OGLD2aDfQLYfwb6yAc7SBpQstHpNDFKtGe/fsy
         sLCbSgybnEFzgJq7uJULGRJK5GrYqSmnOzI/TrGWwD/Q4XuNSYMFg3rYr1IDuIhkFDkX
         Sehw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679789754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q1Sh3NFXp4ir6XRWRZRmPrz3mlgkVC//DmmZmhPglLQ=;
        b=GoZGfJPvr2jViVFqH6b39WpWINUXyIW06mxPZvK4bN+rZV9bb0h6v2gUQVJVDm/KGp
         tzIQjTDw7O/9ZBuY3tp+Wxj8kt0wMJ/TS4mn9y4wsxdV7xtrNF9bPRJooAmiIRR9ExWZ
         3dICSuqzoJIspdb9l276B+B39dPkCbapNN9UDeDKgUVQtwg3SgurLPGqg3IuirQWdeko
         LXdf8nS9+XPlZEonZMmORo0476oegTfwrXXr7jYqKTge2Dk65nYUnZuMRu67ttwZ0NXG
         /4JbGGRELfqWOeKUN5+nIyYz1gFGTDssoleig2603epCh7whJx+6Lm1zxl/HL2IgVvYZ
         rlOw==
X-Gm-Message-State: AO0yUKWhb7ZogXxfVJjlg2Xcr3plOyAoaX6dgaW+1iDlZznYq3j4czkC
        ysTCTj5kun0XylVMWrs2t7s=
X-Google-Smtp-Source: AK7set98FrLiXBnESouhNJWG0k7lNq42sINT3jklbIcKjXXBz8b4wtyYracAtxDC8x/RTNYK5Csq8w==
X-Received: by 2002:a05:600c:2312:b0:3dc:4fd7:31e9 with SMTP id 18-20020a05600c231200b003dc4fd731e9mr6552181wmo.7.1679789754500;
        Sat, 25 Mar 2023 17:15:54 -0700 (PDT)
Received: from wasp.lan (cpc126518-gtya5-2-0-cust190.4-4.cable.virginm.net. [86.19.196.191])
        by smtp.googlemail.com with ESMTPSA id t20-20020a05600c451400b003ee443bf0c7sm4173934wmo.16.2023.03.25.17.15.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 17:15:54 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, bigbeeshane@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: Add basic NanoPi R6S (RK3588S) Support
Date:   Sun, 26 Mar 2023 00:15:34 +0000
Message-Id: <20230326001535.149539-1-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds basic support for the NanoPi R6S SBC

Currently working :
  - UART
  - mmc storage (internal)
  - RGMII / GMAC 1Gb ethernet
  - SYS LED

Signed-off-by: Shane Francis <bigbeeshane@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3588s-nanopi-r6s.dts  | 126 ++++++++++++++++++
 2 files changed, 127 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 99a44c400d6a..39cad757d29d 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -91,3 +91,4 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-edgeble-neu6a-io.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-evb1-v10.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588-rock-5b.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-rock-5a.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3588s-nanopi-r6s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
new file mode 100644
index 000000000000..21b26539a855
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3588s-nanopi-r6s.dts
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+
+/dts-v1/;
+
+#include <dt-bindings/pinctrl/rockchip.h>
+#include <dt-bindings/gpio/gpio.h>
+#include "rk3588s.dtsi"
+
+/ {
+	model = "NanoPi R6S - RK3588S";
+	compatible = "friendlyelec,nanopi6", "rockchip,rk3588";
+	
+	aliases {
+		mmc0 = &sdhci;
+		serial2 = &uart2;
+	};
+
+	chosen {
+		stdout-path = "serial2:1500000n8";
+	};
+	
+	gpio_leds: gpio-leds {
+		compatible = "gpio-leds";
+
+		sys_led: led-0 {
+			gpios = <&gpio1 RK_PC1 GPIO_ACTIVE_HIGH>;
+			label = "sys_led";
+			linux,default-trigger = "heartbeat";
+			pinctrl-names = "default";
+			pinctrl-0 = <&sys_led_pin>;
+		};
+
+		wan_led: led-1 {
+			gpios = <&gpio1 RK_PC2 GPIO_ACTIVE_HIGH>;
+			label = "wan_led";
+			pinctrl-names = "default";
+			pinctrl-0 = <&wan_led_pin>;
+		};
+
+		lan1_led: led-2 {
+			gpios = <&gpio1 RK_PC3 GPIO_ACTIVE_HIGH>;
+			label = "lan1_led";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lan1_led_pin>;
+		};
+
+		lan2_led: led-3 {
+			gpios = <&gpio1 RK_PC4 GPIO_ACTIVE_HIGH>;
+			label = "lan2_led";
+			pinctrl-names = "default";
+			pinctrl-0 = <&lan2_led_pin>;
+		};
+	};
+};
+
+&pinctrl {
+	gpio-leds {
+		sys_led_pin: sys-led-pin {
+			rockchip,pins =
+				<1 RK_PC1 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		wan_led_pin: wan-led-pin {
+			rockchip,pins =
+				<1 RK_PC2 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		lan1_led_pin: lan1-led-pin {
+			rockchip,pins =
+				<1 RK_PC3 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+
+		lan2_led_pin: lan2-led-pin {
+			rockchip,pins =
+				<1 RK_PC4 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+
+	rtl8211f {
+		rtl8211f_rst: rtl8211f-rst {
+			rockchip,pins = <3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_none>;
+		};
+	};
+};
+
+&gmac1 {
+	clock_in_out = "output";
+	phy-handle = <&rgmii_phy1>;
+	phy-mode = "rgmii-rxid";
+	pinctrl-0 = <&gmac1_miim
+		     &gmac1_tx_bus2
+		     &gmac1_rx_bus2
+		     &gmac1_rgmii_clk
+		     &gmac1_rgmii_bus>;
+	pinctrl-names = "default";
+	tx_delay = <0x42>;
+	status = "okay";
+};
+
+&mdio1 {
+	rgmii_phy1: ethernet-phy@1 {
+		compatible = "ethernet-phy-id001c.c916";
+		reg = <0x1>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&rtl8211f_rst>;
+		reset-assert-us = <20000>;
+		reset-deassert-us = <100000>;
+		reset-gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&sdhci {
+	bus-width = <8>;
+	no-sdio;
+	no-sd;
+	non-removable;
+	max-frequency = <200000000>;
+	mmc-hs400-1_8v;
+	mmc-hs400-enhanced-strobe;
+	status = "okay";
+};
+
+&uart2 {
+	pinctrl-0 = <&uart2m0_xfer>;
+	status = "okay";
+};
-- 
2.40.0

