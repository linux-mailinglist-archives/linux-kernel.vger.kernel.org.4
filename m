Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91E5E960A
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbiIYUrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiIYUr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:47:28 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32622BE38;
        Sun, 25 Sep 2022 13:47:25 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id o2so7940604lfc.10;
        Sun, 25 Sep 2022 13:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=w9n5hA+zCQPnRUU0Y0WeWbcf+dsd5Y1yMjO2ClZKx1A=;
        b=oB/f/KDWQm2e0JcR0ZaIAgnEm2tNwyE+43LlEyiTnpF/EhHBAwaP3DRFe3UxR7JuPz
         sihFikA2t9jYQ/62WBQAJKIxjxgb4hVC1BSRzDNXFpWq61gVRl2hPh1mvJwnk0L+KPFD
         k/y39E4YExxdSwxEdrrRRw5yQ4dAPNp5HtG5mInSwzWlKWCTYG+a0KM1IWa7aCtow7QZ
         0goPnZPKZIQQS09JWyw8rZdr5Qpm9+sCR4Iuavdoo35tufACuSY/ROI3Ko01350k4V1V
         p7bZogQtF1whVkkrI8IO6yc8KmQrSM0mOqfipr3f20i2aIFrt81unLk65Jz1U72KZek6
         JGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=w9n5hA+zCQPnRUU0Y0WeWbcf+dsd5Y1yMjO2ClZKx1A=;
        b=iaUeNv9D/b4AYJwDfqQ3xPjhT/Rz+wTs+/VsWlbDJOYDUg4FnZ2a9VJlpNLitz2DwU
         R5hEyFPAydswEqxQeZKOk7Ct6d+NnXvBcNV53m93S9XiyysJZ/82fsggBFWj+sEbP5tG
         /tCGhkaYlvjvXtY5gry2qEp8bAOOaZHXduWxDlWvejL5yNgD7kRxfuKzi2n6bEVngIM3
         /MFVFQEnUV05Xf+3NVdlwi+UwGy+oB47sC2eHK45HBdanRV8KPLRfreWyC15f3DPvzCt
         fh6p1u6Abu27ETzQmNB7HrI1rph0ofI73EylIQHeyNCD86paVRQ/95oNMOdhmkM1J1+H
         Mjhw==
X-Gm-Message-State: ACrzQf2TKoJx/UBIQu41O6gDcnQQYa7ZST422PAeO+xckZw1BDUFEeb3
        X2+2E23XszsURkMwXLsdaFRiZoQb2lekkw==
X-Google-Smtp-Source: AMsMyM7iAwCbqsHXGNDRnjKi6A8yM6FJFMG0zTE1Gl0n3hYDebVp0oBs0PDjHabOFGG5afnqvjoNsw==
X-Received: by 2002:ac2:5b0f:0:b0:49c:949e:d8f7 with SMTP id v15-20020ac25b0f000000b0049c949ed8f7mr7273937lfn.336.1664138843774;
        Sun, 25 Sep 2022 13:47:23 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id c24-20020a196558000000b0049472efaf7asm2297667lfj.244.2022.09.25.13.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 13:47:23 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        soc@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 3/3] ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)
Date:   Sun, 25 Sep 2022 23:44:15 +0300
Message-Id: <20220925204416.715687-4-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
References: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Add a device tree for the Samsung Galaxy Tab 4 10.1 (SM-T530) wifi tablet
based on the apq8026 platform.

Currently supported are accelerometer sensor, hall sensor,
internal storage, physical buttons (power & volume), screen
(based on simple-framebuffer set up by the bootloader), sdcard,
touchscreen and USB.

Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
Changes in v5:
  - Rename pm8226-regulators node to fix issue reported by make dtbs_check

Changes in v4:
  - Move delete-node to memory-region
  - Move usb-switch node to blsp_i2c4

Changes in v3:
  - Fix sdhc_2 bus width
  - Reorder includes

Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id, not needed when lk2nd is used
  - Remove unused labels from reserved memory regions
  - Rename muic node
---
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 453 ++++++++++++++++++
 2 files changed, 454 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 05d8aef6e5d2..69f6bbcf90c6 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1027,6 +1027,7 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8016-sbc.dtb \
 	qcom-apq8026-asus-sparrow.dtb \
 	qcom-apq8026-lg-lenok.dtb \
+	qcom-apq8026-samsung-matisse-wifi.dtb \
 	qcom-apq8060-dragonboard.dtb \
 	qcom-apq8064-cm-qs600.dtb \
 	qcom-apq8064-ifc6410.dtb \
diff --git a/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
new file mode 100644
index 000000000000..3029bc566832
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Matti Lehtimäki <matti.lehtimaki@gmail.com>
+ */
+
+/dts-v1/;
+
+#include <dt-bindings/input/input.h>
+#include "qcom-msm8226.dtsi"
+#include "qcom-pm8226.dtsi"
+
+/ {
+	model = "Samsung Galaxy Tab 4 10.1";
+	compatible = "samsung,matisse-wifi", "qcom,apq8026";
+	chassis-type = "tablet";
+
+	aliases {
+		mmc0 = &sdhc_1; /* SDC1 eMMC slot */
+		mmc1 = &sdhc_2; /* SDC2 SD card slot */
+		display0 = &framebuffer0;
+	};
+
+	chosen {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		stdout-path = "display0";
+
+		framebuffer0: framebuffer@3200000 {
+			compatible = "simple-framebuffer";
+			reg = <0x3200000 0x800000>;
+			width = <1280>;
+			height = <800>;
+			stride = <(1280 * 3)>;
+			format = "r8g8b8";
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 110 GPIO_ACTIVE_HIGH>;
+			interrupts = <&tlmm 110 IRQ_TYPE_EDGE_FALLING>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			debounce-interval = <15>;
+			wakeup-source;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		autorepeat;
+
+		key-home {
+			label = "Home";
+			gpios = <&tlmm 108 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_HOMEPAGE>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-down {
+			label = "Volume Down";
+			gpios = <&tlmm 107 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEDOWN>;
+			debounce-interval = <15>;
+		};
+
+		key-volume-up {
+			label = "Volume Up";
+			gpios = <&tlmm 106 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+		};
+	};
+
+	reg_tsp_1p8v: regulator-tsp-1p8v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_1p8v";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+
+		gpio = <&tlmm 31 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_en_default_state>;
+	};
+
+	reg_tsp_3p3v: regulator-tsp-3p3v {
+		compatible = "regulator-fixed";
+		regulator-name = "tsp_3p3v";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+
+		gpio = <&tlmm 73 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_en1_default_state>;
+	};
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		framebuffer@3200000 {
+			reg = <0x3200000 0x800000>;
+			no-map;
+		};
+
+		mpss@8400000 {
+			reg = <0x08400000 0x1f00000>;
+			no-map;
+		};
+
+		mba@a300000 {
+			reg = <0x0a300000 0x100000>;
+			no-map;
+		};
+
+		reserved@cb00000 {
+			reg = <0x0cb00000 0x700000>;
+			no-map;
+		};
+
+		wcnss@d200000 {
+			reg = <0x0d200000 0x700000>;
+			no-map;
+		};
+
+		adsp@d900000 {
+			reg = <0x0d900000 0x1800000>;
+			no-map;
+		};
+
+		venus@f100000 {
+			reg = <0x0f100000 0x500000>;
+			no-map;
+		};
+
+		/delete-node/ smem@3000000;
+		smem_region: smem@fa00000 {
+			reg = <0xfa00000 0x100000>;
+			no-map;
+		};
+
+		reserved@fb00000 {
+			reg = <0x0fb00000 0x260000>;
+			no-map;
+		};
+
+		rfsa@fd60000 {
+			reg = <0x0fd60000 0x20000>;
+			no-map;
+		};
+
+		rmtfs@fd80000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0fd80000 0x180000>;
+			no-map;
+
+			qcom,client-id = <1>;
+		};
+	};
+};
+
+&blsp1_i2c2 {
+	status = "okay";
+
+	accelerometer@1d {
+		compatible = "st,lis2hh12";
+		reg = <0x1d>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <54 IRQ_TYPE_LEVEL_HIGH>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&accel_int_default_state>;
+
+		st,drdy-int-pin = <1>;
+
+		vdd-supply = <&pm8226_l19>;
+		vddio-supply = <&pm8226_lvs1>;
+	};
+};
+
+&blsp1_i2c4 {
+	status = "okay";
+
+	muic: usb-switch@25 {
+		compatible = "siliconmitus,sm5502-muic";
+		reg = <0x25>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <67 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&muic_int_default_state>;
+	};
+};
+
+&blsp1_i2c5 {
+	status = "okay";
+
+	touchscreen@4a {
+		compatible = "atmel,maxtouch";
+		reg = <0x4a>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <17 IRQ_TYPE_LEVEL_LOW>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&tsp_int_rst_default_state>;
+
+		reset-gpios = <&pm8226_gpios 6 GPIO_ACTIVE_LOW>;
+
+		vdd-supply = <&reg_tsp_1p8v>;
+		vdda-supply = <&reg_tsp_3p3v>;
+	};
+};
+
+&rpm_requests {
+	regulators {
+		compatible = "qcom,rpm-pm8226-regulators";
+
+		pm8226_s3: s3 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_s4: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_s5: s5 {
+			regulator-min-microvolt = <1150000>;
+			regulator-max-microvolt = <1150000>;
+		};
+
+		pm8226_l1: l1 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1225000>;
+		};
+
+		pm8226_l2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l3: l3 {
+			regulator-min-microvolt = <750000>;
+			regulator-max-microvolt = <1337500>;
+			regulator-always-on;
+		};
+
+		pm8226_l4: l4 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l5: l5 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		pm8226_l6: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l7: l7 {
+			regulator-min-microvolt = <1850000>;
+			regulator-max-microvolt = <1850000>;
+		};
+
+		pm8226_l8: l8 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+
+		pm8226_l9: l9 {
+			regulator-min-microvolt = <2050000>;
+			regulator-max-microvolt = <2050000>;
+		};
+
+		pm8226_l10: l10 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l12: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l14: l14 {
+			regulator-min-microvolt = <2750000>;
+			regulator-max-microvolt = <2750000>;
+		};
+
+		pm8226_l15: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l16: l16 {
+			regulator-min-microvolt = <3000000>;
+			regulator-max-microvolt = <3350000>;
+		};
+
+		pm8226_l17: l17 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+
+			regulator-system-load = <200000>;
+			regulator-allow-set-load;
+			regulator-always-on;
+		};
+
+		pm8226_l18: l18 {
+			regulator-min-microvolt = <2950000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l19: l19 {
+			regulator-min-microvolt = <2850000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l20: l20 {
+			regulator-min-microvolt = <3075000>;
+			regulator-max-microvolt = <3075000>;
+		};
+
+		pm8226_l21: l21 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_l22: l22 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3000000>;
+		};
+
+		pm8226_l23: l23 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <3300000>;
+		};
+
+		pm8226_l24: l24 {
+			regulator-min-microvolt = <1300000>;
+			regulator-max-microvolt = <1350000>;
+		};
+
+		pm8226_l25: l25 {
+			regulator-min-microvolt = <1775000>;
+			regulator-max-microvolt = <2125000>;
+		};
+
+		pm8226_l26: l26 {
+			regulator-min-microvolt = <1225000>;
+			regulator-max-microvolt = <1300000>;
+		};
+
+		pm8226_l27: l27 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		pm8226_l28: l28 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <2950000>;
+		};
+
+		pm8226_lvs1: lvs1 {};
+	};
+};
+
+&sdhc_1 {
+	status = "okay";
+
+	vmmc-supply = <&pm8226_l17>;
+	vqmmc-supply = <&pm8226_l6>;
+
+	bus-width = <8>;
+	non-removable;
+};
+
+&sdhc_2 {
+	status = "okay";
+
+	vmmc-supply = <&pm8226_l18>;
+	vqmmc-supply = <&pm8226_l21>;
+
+	bus-width = <4>;
+	cd-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
+};
+
+&tlmm {
+	accel_int_default_state: accel-int-default-state {
+		pins = "gpio54";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	muic_int_default_state: muic-int-default-state {
+		pins = "gpio67";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en_default_state: tsp-en-default-state {
+		pins = "gpio31";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_en1_default_state: tsp-en1-default-state {
+		pins = "gpio73";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	tsp_int_rst_default_state: tsp-int-rst-default-state {
+		pins = "gpio17";
+		function = "gpio";
+		drive-strength = <10>;
+		bias-pull-up;
+	};
+};
+
+&usb {
+	status = "okay";
+	extcon = <&muic>, <&muic>;
+};
+
+&usb_hs_phy {
+	extcon = <&muic>;
+	v1p8-supply = <&pm8226_l10>;
+	v3p3-supply = <&pm8226_l20>;
+};
-- 
2.34.1

