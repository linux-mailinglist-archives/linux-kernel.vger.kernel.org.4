Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E196269F9
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234927AbiKLOek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLOe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:34:29 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6E41A83E;
        Sat, 12 Nov 2022 06:34:28 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id k2so18598982ejr.2;
        Sat, 12 Nov 2022 06:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chpLDI1QSiEujTU6BUSwWuhdcchu9pHjD9dEecC+fDc=;
        b=Z36zkDNXIw39tXfGbxvC3hH5k7QB6qo89v4qXKriZSvt/h71FcN/vNhxbLQqpKWYIl
         Yi5fBTrIl4kavfqgTpJksDkTuvlTfqBmRh3zT8DXAG8s7bcMcGGojnlfxHQZxPXzSEij
         XlJX8KR3Vx5PETBwWTRAfvG4jUjIdPOy+eTe+Cy33k7daLC0yKq+Xj82tGpCVjIwONDR
         zDiYzmIcqN0tdFBDeTkTxkNDIanjcSTQUEfv0/ruI/AIBjdi706V9ETaAOhIpaHJMQPf
         lP67Tmiih4dNhRAiJDcP3zIXrhrTLfAdMnYsqPl+Yd4x7p4T1JnZpAeT0DmgbkHR4gSQ
         Hh4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chpLDI1QSiEujTU6BUSwWuhdcchu9pHjD9dEecC+fDc=;
        b=jez/UdOjI3S6PopUJ0krwhn10PZf9e3zLFDFq+JIWm3Wd4pLNLaSikk7f6HdjcTrat
         99xo+rbSNVArQA3+nLmEayotqFWO0TtFaAAquH6bYt4vBCMgjDjarlF7GM46ERI8z+YN
         WyiaRwCh+Usmpo9oO9s1msJDvRLPtkt53gSelc/Ii+vfUOL0JAu3F4BG8o4pCx14y+IW
         QVaggRr2lcyH+s0WdaxnM3FQ14FwCBiiobZ7gpJ4sbkr/kLPRSrtCMeFR+WykNhIYx+8
         4BUgjqRJfy9HP0QEO7hlFMRIEPebPM+EXDbNfBORBQLo5aYZ5PGiP0QHiAQL4cQWevaz
         kn5A==
X-Gm-Message-State: ANoB5pkJWGpVdzS6AkNJ7WZtsdFvksgZ/5B0GV+FtN6j/ntUXRZtp6PL
        Iowr4WqR7jkZ03BQA79j7e8=
X-Google-Smtp-Source: AA0mqf4/Z3ZEI5C+JdfBtf9KnykoTaQmkzAa0DSzuJ0RyyKKNOMrFEf91T4clrl0ZigK34Ae7IH+Xw==
X-Received: by 2002:a17:907:8dcd:b0:78a:efde:b84a with SMTP id tg13-20020a1709078dcd00b0078aefdeb84amr5271217ejc.744.1668263667241;
        Sat, 12 Nov 2022 06:34:27 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id l9-20020a1709063d2900b0077a11b79b9bsm1974668ejf.133.2022.11.12.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:34:27 -0800 (PST)
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
Subject: [PATCH v3 3/5] arm64: dts: rockchip: Add Odroid Go Advance Black Edition
Date:   Sat, 12 Nov 2022 15:34:09 +0100
Message-Id: <20221112143411.517906-4-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112143411.517906-1-maccraft123mc@gmail.com>
References: <20221112143411.517906-1-maccraft123mc@gmail.com>
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

This device is a minor revision of the origin Odroid Go Advance, with
added two more buttons and a WiFi card

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3326-odroid-go2-v11.dts    | 156 ++++++++++++++++++
 2 files changed, 157 insertions(+)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 8c15593c0ca4..12446f531d29 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-roc-cc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3308-rock-pi-s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3318-a95x-z2.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3326-odroid-go2-v11.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-a1.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-evb.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3328-nanopi-r2s.dtb
diff --git a/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
new file mode 100644
index 000000000000..139c898e590e
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go2-v11.dts
@@ -0,0 +1,156 @@
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
+	model = "ODROID-GO Advance Black Edition";
+	compatible = "hardkernel,rk3326-odroid-go2-v11", "rockchip,rk3326";
+
+	aliases {
+		mmc1 = &sdio;
+	};
+
+	analog_sticks: adc-joystick {
+		compatible = "adc-joystick";
+		io-channels = <&saradc 1>,
+			      <&saradc 2>;
+		poll-interval = <60>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		axis@0 {
+			reg = <0>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <172 772>;
+			linux,code = <ABS_X>;
+			};
+
+		axis@1 {
+			reg = <1>;
+			abs-flat = <10>;
+			abs-fuzz = <10>;
+			abs-range = <278 815>;
+			linux,code = <ABS_Y>;
+		};
+	};
+
+	battery: battery {
+		compatible = "simple-battery";
+		charge-full-design-microamp-hours = <3000000>;
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
+	wifi_pwrseq: wifi-pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		pinctrl-names = "default";
+		pinctrl-0 = <&wifi_pwrseq_pins>;
+		reset-gpios = <&gpio3 RK_PB1 GPIO_ACTIVE_LOW>;
+	};
+};
+
+&builtin_gamepad {
+	button-sw20 {
+		gpios = <&gpio3 RK_PB7 GPIO_ACTIVE_LOW>;
+		label = "TOP-LEFT 2";
+		linux,code = <BTN_TL2>;
+	};
+	button-sw21 {
+		gpios = <&gpio3 RK_PB2 GPIO_ACTIVE_LOW>;
+		label = "TOP-RIGHT 2";
+		linux,code = <BTN_TR2>;
+	};
+};
+
+&internal_display {
+	compatible = "elida,kd35t133";
+};
+
+&rk817 {
+	regulators {
+		vcc_wifi: LDO_REG9 {
+			regulator-name = "vcc_wifi";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+
+			regulator-state-mem {
+				regulator-on-in-suspend;
+				regulator-suspend-microvolt = <3300000>;
+			};
+		};
+	};
+};
+
+&rk817_charger {
+	monitored-battery = <&battery>;
+};
+
+&sdio {
+	bus-width = <4>;
+	cap-sd-highspeed;
+	cap-sdio-irq;
+	disable-wp;
+	keep-power-in-suspend;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	non-removable;
+	vmmc-supply = <&vcc_wifi>;
+	#address-cells = <1>;
+	#size-cells = <0>;
+	status = "okay";
+
+	esp8089: wifi@1 {
+		compatible = "esp,esp8089";
+		reg = <1>;
+	};
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
+					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA3 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA4 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA5 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA6 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA7 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB2 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB7 RK_FUNC_GPIO &pcfg_pull_up>;
+		};
+	};
+
+	wifi {
+		wifi_pwrseq_pins: wifi-pwrseq-pins {
+			rockchip,pins = <3 RK_PB1 RK_FUNC_GPIO &pcfg_pull_up>,
+					<3 RK_PB6 RK_FUNC_GPIO &pcfg_output_high>;
+		};
+	};
+};
-- 
2.38.1

