Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28DD162E7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 23:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241068AbiKQWBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 17:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241029AbiKQWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 17:00:52 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3249EDFEB;
        Thu, 17 Nov 2022 14:00:11 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id s24so4473646ljs.11;
        Thu, 17 Nov 2022 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qaZSsdOnB9sUglqg5vGvlywLc7zhkEPQAtk0X5ibqas=;
        b=qTGXTCZCLnke4XAPx182yaFiRFt3BIskJv52LZ3PveulrAqTik/z49E4qPaS8Syvtq
         mj0JZev9nQKOMK8C5RS9B6f06iIJ6tBcF4MRs7pqxg/pDXEJ5TAKXnUPh1hjiP/iESMX
         Q2HRT7ePK/JGKWyD3RFr3zox3MqXu50pESO/kXInLJp2kg9ssr9/tcmQ6tW79aL1Tx7c
         JI8hE4c7GPMToKu7+ugupWQt4XmZY2N+VGfoNGcJ7DdQuT+2Ygh154HLAXIv8Ii9gBx2
         xRwajVh2YKpS0TfCqb0g7Oy9bXUGWttL51fQYaPmrxhaGPD2gZKCDpl16lKqcqU9fpJ3
         VBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qaZSsdOnB9sUglqg5vGvlywLc7zhkEPQAtk0X5ibqas=;
        b=qfjzLtbgf937A0dBioOee4DZ2QN+WwT+jXWgmrstkVmmNpbCc8AFD8pmuiGrxq64a2
         QkKWvNilA5Qf9bvEhmepvGV4lVV4ijti4bx+Y8apo2b93ocMsKTr2VFgf9227PrUFxj2
         l8pyrkGZ+DCn5viQCZ4PJp5DAaC4z3k6pLY84woVSFNy/sSTG7g6dPA4RcPxFtgX3S3e
         I3XC7BjwmLYZMexeN1kvkxXNO0pzarLqbEYgCOYo9MIOn7jescP8uiAbjXC2NLcJtVcY
         wbdFzQ9bbZgZl6vjjbM7OM02J3nfcx6VVut2L2ckLTLB/kdtwrJdsAeiW8YZHkmDb2bn
         fDdw==
X-Gm-Message-State: ANoB5pm01v5tY+H/oNe+Q3NujjaD6Cbo5PDHrLhWhnUQx4yQpddeD7Ge
        7kd2k+F5th/k+SrJi2/USAf3JtLKfmZcjA==
X-Google-Smtp-Source: AA0mqf73T8ra5V5adE1dRAwBrlN7TXlwwh58/Oo49cJ4d1lbhGVH0KfmNaWLcxKm+iWB17prGrxZGQ==
X-Received: by 2002:a05:651c:110a:b0:26d:e85b:92af with SMTP id e10-20020a05651c110a00b0026de85b92afmr1544680ljo.464.1668722409307;
        Thu, 17 Nov 2022 14:00:09 -0800 (PST)
Received: from localhost.localdomain (79.191.9.185.ipv4.supernova.orange.pl. [79.191.9.185])
        by smtp.gmail.com with ESMTPSA id q29-20020ac25a1d000000b00497aa190523sm342985lfn.248.2022.11.17.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 14:00:09 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/5] arm64: dts: rockchip: Add Odroid Go Super
Date:   Thu, 17 Nov 2022 22:59:53 +0100
Message-Id: <20221117215954.4114202-5-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221117215954.4114202-1-maccraft123mc@gmail.com>
References: <20221117215954.4114202-1-maccraft123mc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This device is another revision of Odroid Go Advance, with added two
volume buttons, a second analog stick and a bigger screen that isn't yet
supported in the mainline kernel.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3326-odroid-go3.dts   | 185 ++++++++++++++++++
 2 files changed, 186 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 12446f531d29..142c83d2e5aa 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -9,6 +9,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go3.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
new file mode 100644
index 000000000000..69aecc5c76b5
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
@@ -0,0 +1,185 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Copyright (c) 2019 Hardkernel Co., Ltd
+ * Copyright (c) 2020 Theobroma Systems Design und Consulting GmbH
+ * Copyright (c) 2022 Maya Matuszczyk <maccraft123mc@gmail.com>
+ */
+
+/dts-v1/;
+#include "rk3326-odroid-go.dtsi"
+
+/ {
+	model = "ODROID-GO Super";
+	compatible = "hardkernel,rk3326-odroid-go3", "rockchip,rk3326";
+
+	joystick_mux_controller: mux-controller {
+		compatible = "gpio-mux";
+		pinctrl = <&mux_en_pins>;
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>,
+			    <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	};
+
+	joystick_mux: adc-mux {
+		compatible = "io-channel-mux";
+		io-channels = <&saradc 1>;
+		io-channel-names = "parent";
+		#io-channel-cells = <1>;
+
+		mux-controls = <&joystick_mux_controller>;
+
+		channels = "0", "1", "2", "3";
+	};
+
+	analog_sticks: adc-joystick {
+		compatible = "adc-joystick";
+		io-channels = <&joystick_mux 0>,
+			      <&joystick_mux 1>,
+			      <&joystick_mux 2>,
+			      <&joystick_mux 3>;
+		poll-interval = <60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <180 800>;
+			linux,code = <ABS_X>;
+		};
+
+		axis@1 {
+			reg = <1>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <180 800>;
+			linux,code = <ABS_RX>;
+		};
+		axis@2 {
+			reg = <2>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <180 800>;
+			linux,code = <ABS_Y>;
+		};
+
+		axis@3 {
+			reg = <3>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <180 800>;
+			linux,code = <ABS_RY>;
+		};
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <4000000>;
+		charge-term-current-microamp = <300000>;
+		constant-charge-current-max-microamp = <2000000>;
+		constant-charge-voltage-max-microvolt = <4200000>;
+		factory-internal-resistance-micro-ohms = <180000>;
+		voltage-max-design-microvolt = <4100000>;
+		voltage-min-design-microvolt = <3500000>;
+
+		ocv-capacity-celsius = <20>;
+		ocv-capacity-table-0 =  <4046950 100>, <4001920 95>, <3967900 90>, <3919950 85>,
+					<3888450 80>, <3861850 75>, <3831540 70>, <3799130 65>,
+					<3768190 60>, <3745650 55>, <3726610 50>, <3711630 45>,
+					<3696720 40>, <3685660 35>, <3674950 30>, <3663050 25>,
+					<3649470 20>, <3635260 15>, <3616920 10>, <3592440 5>,
+					<3574170 0>;
+	};
+
+	gpio-keys-vol {
+		compatible = "gpio-keys";
+		autorepeat;
+		pinctrl-0 = <&btn_pins_vol>;
+		pinctrl-names = "default";
+
+		button-vol-down {
+			gpios = <&gpio2 RK_PA1 GPIO_ACTIVE_LOW>;
+			label = "VOLUMEDOWN";
+			linux,code = <KEY_VOLUMEDOWN>;
+		};
+
+		button-volume-up {
+			gpios = <&gpio2 RK_PA0 GPIO_ACTIVE_LOW>;
+			label = "VOLUMEUP";
+			linux,code = <KEY_VOLUMEUP>;
+		};
+	};
+};
+
+/* f1 and f2 conflict with volume buttons */
+/delete-node/ &btn_f1;
+/delete-node/ &btn_f2;
+
+&builtin_gamepad {
+	button-sw19 {
+		gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
+		label = "SELECT";
+		linux,code = <BTN_SELECT>;
+	};
+	/* note that TR2 and TL2 are swapped */
+	button-sw20 {
+		gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+		label = "TOP-RIGHT 2";
+		linux,code = <BTN_TR2>;
+	};
+	button-sw21 {
+		gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+		label = "TOP-LEFT 2";
+		linux,code = <BTN_TL2>;
+	};
+	button-sw22 {
+		gpios = <&gpio3 RK_PB4 GPIO_ACTIVE_LOW>;
+		label = "START";
+		linux,code = <BTN_START>;
+	};
+};
+
+&internal_display {
+	status = "disabled";
+};
+
+&rk817_charger {
+	monitored-battery = <&battery>;
+};
+
+&pinctrl {
+	btns {
+		btn_pins: btn-pins {
+			rockchip,pins = <1 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<1 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+
+		btn_pins_vol: btn-pins-vol {
+			rockchip,pins = <2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+	joystick {
+		mux_en_pins: mux-pins {
+			rockchip,pins = <3 RK_PB5 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+};
-- 
2.38.1

