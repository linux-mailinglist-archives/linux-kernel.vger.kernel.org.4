Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34AA06C9779
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 20:42:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCZSm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 14:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjCZSmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 14:42:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13A6B49C6;
        Sun, 26 Mar 2023 11:42:21 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id t4so1254084wra.7;
        Sun, 26 Mar 2023 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679856139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgqnsrfkL76jzLCKncLrfF0GPI0QEM+cSOxrzCexZZU=;
        b=hC22Y0WScJ9Cj6pJ2gJ2fMMG5IJh8x48S8c1+WLaEYj56YSt9sc96yd3bblaj8g0AA
         r+2BEE8KlRM9pxoyqu/lb/RFWeu4Uzet1mL/tZ3xSnlBwpJgs+bfG3L6gWRaV/qDrqRZ
         i8fOYQmzft2IAfllxnl8+PirkVkpHxADSRptcvQbYa9C4uS/pHAqP5lLenK8N0puSpeZ
         Q/UBoqHxReAriskymU+VgABR+085MnYKz2rKjfoNcdIKLjFkTTecZn2PBca07WM8Gx+F
         H10Rb2PMYFG3F8AimsGLuD+43Q0JIlz8I3g7VlUZ6/iwbstEPJCEbY/EQZaiB+oXNYt2
         gfuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679856139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wgqnsrfkL76jzLCKncLrfF0GPI0QEM+cSOxrzCexZZU=;
        b=JqmczeCjkcYkweMacQLMsydonMFfLqG2Zi3Jp5jpQ5Jhak5r2Mv1vTZnRJ7PYyYKfx
         jYKOwbwEMukDrMQxTKEPdGJ2+z4XQlSgdCzwet1Balm2y4cc8W0VKgZnpGuXcCk+aZLw
         gp1AzCGzIvEeqQ85re6N3EdewXeZ2kIRgjstYhBhKScnFJZcvbBiRvfHO4uVLHwech4Z
         hYfXpPKWUQpuO6LLQiS2rhr6I2fxsyYuJnLo3UA68X2qogczEvUTSKwTRgI9jdfXsvFs
         CMQDA/D4MrbJoXEUkDNYQdM35MfPC/91i1KWoN8v2I/pBYO6XTb3hoSp/sy9kDuPe7Jd
         ti0g==
X-Gm-Message-State: AAQBX9drcl27+OyW6lh9IVGz8H4rWwDblAqmsi25oVJAHVAj7dT/Gy9+
        6dLKguiUZKJqO4PnnQ3OmHY=
X-Google-Smtp-Source: AKy350YSItVYu2768t2b/EWfC5QuV3MRJMX9O0GqKeFGuDCXabJgUE/oz5TTL5YU+uHD0hv75IDl/Q==
X-Received: by 2002:a5d:4e90:0:b0:2ce:a85d:5319 with SMTP id e16-20020a5d4e90000000b002cea85d5319mr8434686wru.39.1679856139274;
        Sun, 26 Mar 2023 11:42:19 -0700 (PDT)
Received: from wasp.lan (cpc126518-gtya5-2-0-cust190.4-4.cable.virginm.net. [86.19.196.191])
        by smtp.googlemail.com with ESMTPSA id a6-20020a056000100600b002c8ed82c56csm23194725wrx.116.2023.03.26.11.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Mar 2023 11:42:19 -0700 (PDT)
From:   Shane Francis <bigbeeshane@gmail.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        heiko@sntech.de, bigbeeshane@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] arm64: dts: Add basic NanoPi R6S (RK3588S) Support
Date:   Sun, 26 Mar 2023 19:40:38 +0100
Message-Id: <20230326184040.33008-1-bigbeeshane@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230326001535.149539-1-bigbeeshane@gmail.com>
References: <20230326001535.149539-1-bigbeeshane@gmail.com>
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
index 000000000000..c9e9df669e11
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
+	compatible = "friendlyarm,nanopi6", "rockchip,rk3588";
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

