Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F96269E4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 15:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbiKLOTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 09:19:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbiKLOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 09:19:09 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E49418362;
        Sat, 12 Nov 2022 06:19:05 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id a5so11259617edb.11;
        Sat, 12 Nov 2022 06:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PFDaqGJ45XvPbPmyYrVRCHPTuzVkjaLszKXtT07fVNg=;
        b=KOFc8v7rCg+klvjjrpO3YKUbNAsqNMPichlUCPfZl1xAWoMR74Xj0HjbaC6tLjoAiR
         RSVRIr14SW6hZLCHEbuc3WtVRFqGLT2I6MPYTi+//yP0dy70BTl5sdgBT4ttPqIsKRip
         HCxiebju41uoIbejMh9R5OrFc7g41Ta+UTyWgD4G5o7X2OWUt2YTTfpQSIr+gs1veSx1
         Rya2fMjia+4PcV9Ay0Duh7zbNRTnHHIKkmY6McXjQXnYwqYFXQhdmfLMb+b6fRqB0DnV
         Cbg69OD9nFz3tL6c716seUtd8T8qmB/1IqyQFj5pwoZeW7XCjLcvJg+wXlfTOgqSx9zu
         ecjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PFDaqGJ45XvPbPmyYrVRCHPTuzVkjaLszKXtT07fVNg=;
        b=Js2hJKUOAfvXSTUrkroSxOFwlyYoDgX/FO1gESvVLfkwT7OlK1l0tytbqTmpZbjQ1b
         Ytz2vaQkFnziPA8cLC1+7G33dOsAxvNvSdZVbkerl4Gs19dn68OHvBYKXQWme/zhw6q3
         W1wmYk1IfHLBNRJACMNkba8T67ZS5d4TFC7GI7V7K5VVaVOyQ6o0FhrBTQrySOSEkMki
         PoC+G+CiQCl/JNfHD+sN29tsJlqhLPzktlLOPuLpg/Fna+GoRq4VJ1caFuhtrpZ34Azc
         s0KHoaOGUFEEua1JZXPVJg/2wzvpLxGlpSp8q6fH/PMJ94AxsTl9d4sMqGjW+2FHAUuU
         wpZg==
X-Gm-Message-State: ANoB5pnOvU46zEfrj7s0T3W2pATJlaPYqbr5EMpLbYCIEZ8n+8Pyi+6H
        SG9FqDq9nfSATidawKIq+aM=
X-Google-Smtp-Source: AA0mqf4bB8gQS3ToJQ+Sy3+AXgIasU2V7hyiLRWh4o5TBUYtKeZEfQuZDzrGhPfhVol15B/DUIDw3Q==
X-Received: by 2002:aa7:db85:0:b0:463:f3a:32ce with SMTP id u5-20020aa7db85000000b004630f3a32cemr5488298edt.366.1668262743959;
        Sat, 12 Nov 2022 06:19:03 -0800 (PST)
Received: from localhost.localdomain (83.31.120.236.ipv4.supernova.orange.pl. [83.31.120.236])
        by smtp.gmail.com with ESMTPSA id g21-20020a50ee15000000b004677b1b1a70sm1050148eds.61.2022.11.12.06.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 06:19:03 -0800 (PST)
From:   Maya Matuszczyk <maccraft123mc@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     =?UTF-8?q?Jo=C3=A3o=20H=20=2E=20Spies?= <jhlspies@gmail.com>,
        Chris Morgan <macroalpha82@gmail.com>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] arm64: dts: rockchip: Add Odroid Go Super
Date:   Sat, 12 Nov 2022 15:18:40 +0100
Message-Id: <20221112141840.516224-5-maccraft123mc@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221112141840.516224-1-maccraft123mc@gmail.com>
References: <20221112141840.516224-1-maccraft123mc@gmail.com>
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
supported in the Mainline Kernel.

Signed-off-by: Maya Matuszczyk <maccraft123mc@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../boot/dts/rockchip/rk3326-odroid-go3.dts   | 161 ++++++++++++++++++
 2 files changed, 162 insertions(+)
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
index 000000000000..4b6c896d8abd
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3326-odroid-go3.dts
@@ -0,0 +1,161 @@
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
+		status = "okay";
+		compatible = "gpio-mux";
+		pinctrl = <&mux_en_pins>;
+		#mux-control-cells = <0>;
+
+		mux-gpios = <&gpio3 RK_PB3 GPIO_ACTIVE_LOW>,
+			    <&gpio3 RK_PB0 GPIO_ACTIVE_LOW>;
+	};
+
+	joystick_mux: adc-mux {
+		status = "okay";
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
+};
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
+					<2 RK_PA0 RK_FUNC_GPIO &pcfg_pull_up>,
+					<2 RK_PA1 RK_FUNC_GPIO &pcfg_pull_up>,
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
+	};
+	joystick {
+		mux_en_pins: mux-pins {
+			rockchip,pins = <3 RK_PB5 RK_FUNC_GPIO &pcfg_output_low>;
+		};
+	};
+};
-- 
2.38.1

