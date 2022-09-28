Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83B855EDA31
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 12:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiI1Kfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 06:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiI1KfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 06:35:17 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C55D5721D;
        Wed, 28 Sep 2022 03:35:13 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r6so1798556wru.8;
        Wed, 28 Sep 2022 03:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=HDGE3BR9ln+ux4q7b1ExkJuNxfN9nyI/TbiJnZO9UOo=;
        b=WOJgxjri3+/AUd0xF1vcFuvcE24djxF3JsVhCd6puXzQgcTPvHAZdRlkurw10lrBVv
         YjxuYfhel9IR+bg5E3jZheM5BPRTwhBzfZk5wPO5xj6oBhc3mTXdsgYS86OivbSG2hZu
         K3zjVVPPwnRq5M+vyOot/3SEEkszEwQMHH7i0gmcr9zVlnxpKyxUa+/MKI6N44lZ25Xb
         axw65yuScfBL0ICHPglOE5UKdX3sZ5ANjH2aAxazkullGDnQ0k5yuZolCQz+1f4I2EIj
         IHKa5VZKKrjhsQd5bvcUE56HKHj9Sf89ysB6lqZumQ8/Ffl1DCMfnx9DHWKcBzlHg+jP
         lFCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=HDGE3BR9ln+ux4q7b1ExkJuNxfN9nyI/TbiJnZO9UOo=;
        b=5h1G7VWToI0tJeOJiFqv4V3zfUIEOnFCv1VIkkChfIv7mdPDEQKOvdXNrnH6qzxEOf
         1MG+BKU2NGbAFDqsDa4Uxj88yeFITwfqVcewxyAtcxbrwP4Ck/BQiSrwEyJaFbNR2q0/
         fuuqj4qzOat7RTJECjpaMPzhdrwLCMueCoVwH3u8oz5KzV09U4Sur12DRNziL61+kIoX
         OmdZWaAGYXf0p4azRyL273AhmaE+1asX4YVHkl95YRutSZMbCEb/uIaozeZ2mS7ewyEb
         j5NCboZ3pB49CtR6XRQt1sgsR1raUi1UN6i3DxfAH6LxUDKHimkqazuAS9V/aqhfzHx/
         A/+Q==
X-Gm-Message-State: ACrzQf2qYdKzAkUaI4QvvIoK2ODNTmpYCqAV4L+kr1iJp8cTk6vmBiYM
        GNpV1lMhLqYZ721lFveDyuKvTvCMsSQ=
X-Google-Smtp-Source: AMsMyM7ECQ8GlBFJaZqLawHK9254tMEVFS5xrJMgXiZrCkuTJlDnZX+zXi2V5N1SHVu92c/Zd8IbMA==
X-Received: by 2002:a5d:63c1:0:b0:22c:ca44:fc24 with SMTP id c1-20020a5d63c1000000b0022cca44fc24mr1032336wrw.414.1664361311468;
        Wed, 28 Sep 2022 03:35:11 -0700 (PDT)
Received: from localhost.localdomain ([46.216.9.29])
        by smtp.googlemail.com with ESMTPSA id x4-20020adfdcc4000000b0022b11a27e39sm3974476wrm.1.2022.09.28.03.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 03:35:11 -0700 (PDT)
From:   Dzmitry Sankouski <dsankouski@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dzmitry Sankouski <dsankouski@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/2] arm64: dts: qcom: sagit: add initial device tree for sagit
Date:   Wed, 28 Sep 2022 13:33:18 +0300
Message-Id: <20220928103319.621698-2-dsankouski@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928103319.621698-1-dsankouski@gmail.com>
References: <20220928103319.621698-1-dsankouski@gmail.com>
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

New device support - Xiaomi Mi6 phone

What works:
- storage
- usb
- power regulators

Signed-off-by: Dzmitry Sankouski <dsankouski@gmail.com>
TO: linux-kernel@vger.kernel.org (open list)
CC: Andy Gross <agross@kernel.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Bjorn Andersson <bjorn.andersson@linaro.org> (maintainer:ARM/QUALCOMM SUPPORT)
CC: Konrad Dybcio <konrad.dybcio@somainline.org> (reviewer:ARM/QUALCOMM SUPPORT)
CC: Rob Herring <robh+dt@kernel.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org> (maintainer:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
CC: linux-arm-msm@vger.kernel.org (open list:ARM/QUALCOMM SUPPORT)
CC: devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS)
---
Changes for v2:
- remove memory nodes before redefining
- add board compatible to schema
- remove board msm-id, add chassis type
- remove common dtsi
- move resin to pm8998 dtsi file
- dts formatting
- unsupported properties removed
- add copyright
- rebase on latest master

 arch/arm64/boot/dts/qcom/Makefile             |   1 +
 .../boot/dts/qcom/msm8998-xiaomi-sagit.dts    | 682 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/pm8998.dtsi          |   6 +
 3 files changed, 689 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 1d86a33de528..0460aabf1b59 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -46,6 +46,7 @@ dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-oneplus-dumpling.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-lilac.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-maple.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-sony-xperia-yoshino-poplar.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= msm8998-xiaomi-sagit.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-1000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qcs404-evb-4000.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= qrb5165-rb5.dtb
diff --git a/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
new file mode 100644
index 000000000000..0cd56eff5b89
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8998-xiaomi-sagit.dts
@@ -0,0 +1,682 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Xiaomi Mi 6 (sagit) device tree source based on msm8998-mtp.dtsi
+ *
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2022, Degdag Mohamed <degdagmohamed@gmail.com>
+ * Copyright (c) 2022, Dzmitry Sankouski <dsankouski@gmail.com>
+ */
+
+/dts-v1/;
+
+#include "msm8998.dtsi"
+#include "pm8005.dtsi"
+#include "pm8998.dtsi"
+#include "pmi8998.dtsi"
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/leds/common.h>
+#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
+
+/*
+ * Delete following upstream (msm8998.dtsi) reserved
+ * memory mappings which are different in this device.
+ */
+/delete-node/ &mpss_mem;
+/delete-node/ &venus_mem;
+/delete-node/ &mba_mem;
+/delete-node/ &slpi_mem;
+/delete-node/ &ipa_fw_mem;
+/delete-node/ &ipa_gsi_mem;
+/delete-node/ &gpu_mem;
+/delete-node/ &wlan_msa_mem;
+
+/ {
+	model = "Xiaomi Mi 6";
+	compatible = "xiaomi,sagit", "qcom,msm8998";
+	chassis-type = "handset";
+	/* Required for bootloader to select correct board */
+	qcom,board-id = <30 0>;
+
+	reserved-memory {
+		/*
+		 * The following memory regions on downstream are "dynamically allocated"
+		 * but given the same addresses every time. Hard code them as these addresses
+		 * are where the Xiaomi signed firmware expects them to be.
+		 */
+		ipa_fws_region: ipa@f7800000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xf7800000 0x0 0x5000>;
+			no-map;
+		};
+
+		zap_shader_region: gpu@f7900000 {
+			compatible = "shared-dma-pool";
+			reg = <0x0 0xf7900000 0x0 0x2000>;
+			no-map;
+		};
+
+		mpss_mem: memory@8d000000 {
+			reg = <0x0 0x8d000000 0x0 0x7000000>;
+			no-map;
+		};
+
+		venus_mem: memory@94000000 {
+			reg = <0x0 0x94000000 0x0 0x500000>;
+			no-map;
+		};
+
+		mba_mem: memory@94500000 {
+			reg = <0x0 0x94500000 0x0 0x200000>;
+			no-map;
+		};
+
+		slpi_mem: memory@94700000 {
+			reg = <0x0 0x94700000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_fw_mem: memory@95600000 {
+			reg = <0x0 0x95600000 0x0 0x10000>;
+			no-map;
+		};
+
+		ipa_gsi_mem: memory@95610000 {
+			reg = <0x0 0x95610000 0x0 0x5000>;
+			no-map;
+		};
+
+		gpu_mem: memory@95615000 {
+			reg = <0x0 0x95615000 0x0 0x100000>;
+			no-map;
+		};
+
+		wlan_msa_mem: memory@95715000 {
+			reg = <0x0 0x95715000 0x0 0x100000>;
+			no-map;
+		};
+	};
+
+	gpio-keys {
+		compatible = "gpio-keys";
+		label = "Volume buttons";
+		autorepeat;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&vol_up_key_default>;
+
+		key-vol-up {
+			label = "Volume up";
+			gpios = <&pm8998_gpio 6 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_VOLUMEUP>;
+			debounce-interval = <15>;
+			wakeup-source;
+		};
+	};
+
+	gpio-hall-sensor {
+		compatible = "gpio-keys";
+		label = "Hall effect sensor";
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&hall_sensor_default>;
+
+		event-hall-sensor {
+			label = "Hall Effect Sensor";
+			gpios = <&tlmm 124 GPIO_ACTIVE_LOW>;
+			linux,input-type = <EV_SW>;
+			linux,code = <SW_LID>;
+			linux,can-disable;
+			wakeup-source;
+		};
+	};
+
+	vph_pwr: vph-pwr-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "vph_pwr";
+		regulator-min-microvolt = <3700000>;
+		regulator-max-microvolt = <3700000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	disp_vddts_vreg: disp-vddts-regulator {
+		compatible = "regulator-fixed";
+		regulator-name = "disp-vddts-regulator";
+		gpio = <&tlmm 50 GPIO_ACTIVE_HIGH>;
+		enable-active-high;
+		regulator-boot-on;
+	};
+};
+
+&blsp1_i2c5 {
+	pinctrl-names = "default", "sleep";
+	status = "okay";
+
+	touchscreen@20 {
+		compatible = "syna,rmi4-i2c";
+		reg = <0x20>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <125 IRQ_TYPE_EDGE_FALLING>;
+
+		pinctrl-names = "default", "sleep";
+		pinctrl-0 = <&ts_active>;
+		pinctrl-1 = <&ts_int_suspend &ts_reset_suspend>;
+
+		vdd-supply = <&disp_vddts_vreg>;
+		vio-supply = <&vreg_l6a_1p8>;
+
+		syna,reset-delay-ms = <20>;
+		syna,startup-delay-ms = <20>;
+
+		rmi4-f01@1 {
+			reg = <0x01>;
+			syna,nosleep-mode = <1>;
+		};
+
+		rmi4-f12@12 {
+			reg = <0x12>;
+			touchscreen-x-mm = <64>;
+			touchscreen-y-mm = <114>;
+			syna,sensor-type = <1>;
+			syna,rezero-wait-ms = <20>;
+		};
+
+		rmi4-f1a@1a {
+			reg = <0x1a>;
+			syna,codes = <KEY_BACK KEY_APPSELECT>;
+		};
+	};
+};
+
+&blsp1_i2c5_sleep {
+	/delete-property/ bias-pull-up;
+	bias-disable;
+};
+
+&blsp1_uart3 {
+	status = "okay";
+
+	bluetooth {
+		compatible = "qcom,wcn3990-bt";
+
+		vddio-supply = <&vreg_s4a_1p8>;
+		vddxo-supply = <&vreg_l7a_1p8>;
+		vddrf-supply = <&vreg_l17a_1p3>;
+		vddch0-supply = <&vreg_l25a_3p3>;
+		max-speed = <3200000>;
+	};
+};
+
+&blsp1_uart3_on {
+	rx {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-up on 46 (RX). This is needed to
+		 * avoid garbage data when the TX pin of the Bluetooth
+		 * module is in tri-state (module powered off or not
+		 * driving the signal yet).
+		 */
+		bias-pull-up;
+	};
+
+	cts {
+		/delete-property/ bias-disable;
+		/*
+		 * Configure a pull-down on 47 (CTS) to match the pull
+		 * of the Bluetooth module.
+		 */
+		bias-pull-down;
+	};
+};
+
+&blsp2_uart1 {
+	status = "okay";
+};
+
+&pm8005_lsid1 {
+	pm8005-regulators {
+		compatible = "qcom,pm8005-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+
+		pm8005_s1: s1 { /* VDD_GFX supply */
+			regulator-min-microvolt = <524000>;
+			regulator-max-microvolt = <1100000>;
+			regulator-enable-ramp-delay = <500>;
+
+			/* hack until we rig up the gpu consumer */
+			regulator-always-on;
+		};
+	};
+};
+
+&pm8998_gpio {
+	vol_up_key_default: vol-up-key-default-state {
+		pins = "gpio6";
+		function = "normal";
+		bias-pull-up;
+		input-enable;
+		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
+	};
+
+	audio_mclk_pin: audio-mclk-pin-active-state {
+		pins = "gpio13";
+		function = "func2";
+		power-source = <0>;
+	};
+};
+
+&qusb2phy {
+	status = "okay";
+
+	vdda-pll-supply = <&vreg_l12a_1p8>;
+	vdda-phy-dpdm-supply = <&vreg_l24a_3p075>;
+};
+
+&rpm_requests {
+	pm8998-regulators {
+		compatible = "qcom,rpm-pm8998-regulators";
+
+		vdd_s1-supply = <&vph_pwr>;
+		vdd_s2-supply = <&vph_pwr>;
+		vdd_s3-supply = <&vph_pwr>;
+		vdd_s4-supply = <&vph_pwr>;
+		vdd_s5-supply = <&vph_pwr>;
+		vdd_s6-supply = <&vph_pwr>;
+		vdd_s7-supply = <&vph_pwr>;
+		vdd_s8-supply = <&vph_pwr>;
+		vdd_s9-supply = <&vph_pwr>;
+		vdd_s10-supply = <&vph_pwr>;
+		vdd_s11-supply = <&vph_pwr>;
+		vdd_s12-supply = <&vph_pwr>;
+		vdd_s13-supply = <&vph_pwr>;
+		vdd_l1_l27-supply = <&vreg_s7a_1p025>;
+		vdd_l2_l8_l17-supply = <&vreg_s3a_1p35>;
+		vdd_l3_l11-supply = <&vreg_s7a_1p025>;
+		vdd_l4_l5-supply = <&vreg_s7a_1p025>;
+		vdd_l6-supply = <&vreg_s5a_2p04>;
+		vdd_l7_l12_l14_l15-supply = <&vreg_s5a_2p04>;
+		vdd_l9-supply = <&vreg_bob>;
+		vdd_l10_l23_l25-supply = <&vreg_bob>;
+		vdd_l13_l19_l21-supply = <&vreg_bob>;
+		vdd_l16_l28-supply = <&vreg_bob>;
+		vdd_l18_l22-supply = <&vreg_bob>;
+		vdd_l20_l24-supply = <&vreg_bob>;
+		vdd_l26-supply = <&vreg_s3a_1p35>;
+		vdd_lvs1_lvs2-supply = <&vreg_s4a_1p8>;
+
+		vreg_s3a_1p35: s3 {
+			regulator-min-microvolt = <1352000>;
+			regulator-max-microvolt = <1352000>;
+		};
+
+		vreg_s4a_1p8: s4 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_s5a_2p04: s5 {
+			regulator-min-microvolt = <1904000>;
+			regulator-max-microvolt = <2040000>;
+		};
+
+		vreg_s7a_1p025: s7 {
+			regulator-min-microvolt = <900000>;
+			regulator-max-microvolt = <1028000>;
+		};
+
+		vreg_l1a_0p875: l1 {
+			regulator-min-microvolt = <880000>;
+			regulator-max-microvolt = <880000>;
+		};
+
+		vreg_l2a_1p2: l2 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_l3a_1p0: l3 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l5a_0p8: l5 {
+			regulator-min-microvolt = <800000>;
+			regulator-max-microvolt = <800000>;
+		};
+
+		vreg_l6a_1p8: l6 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l7a_1p8: l7 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l8a_1p2: l8 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+		};
+
+		vreg_l9a_1p8: l9 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l10a_1p8: l10 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l11a_1p0: l11 {
+			regulator-min-microvolt = <1000000>;
+			regulator-max-microvolt = <1000000>;
+		};
+
+		vreg_l12a_1p8: l12 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l13a_2p95: l13 {
+			regulator-min-microvolt = <1808000>;
+			regulator-max-microvolt = <2960000>;
+		};
+
+		vreg_l14a_1p8: l14 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l15a_1p8: l15 {
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+		};
+
+		vreg_l16a_2p7: l16 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+		};
+
+		vreg_l17a_1p3: l17 {
+			regulator-min-microvolt = <1304000>;
+			regulator-max-microvolt = <1304000>;
+		};
+
+		vreg_l18a_2p7: l18 {
+			regulator-min-microvolt = <2704000>;
+			regulator-max-microvolt = <2704000>;
+		};
+
+		vreg_l19a_3p0: l19 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+		};
+
+		vreg_l20a_2p95: l20 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l21a_2p95: l21 {
+			regulator-min-microvolt = <2960000>;
+			regulator-max-microvolt = <2960000>;
+			regulator-system-load = <800000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l22a_2p85: l22 {
+			regulator-min-microvolt = <2864000>;
+			regulator-max-microvolt = <2864000>;
+		};
+
+		vreg_l23a_3p3: l23 {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3312000>;
+		};
+
+		vreg_l24a_3p075: l24 {
+			regulator-min-microvolt = <3088000>;
+			regulator-max-microvolt = <3088000>;
+		};
+
+		vreg_l25a_3p3: l25 {
+			regulator-min-microvolt = <3104000>;
+			regulator-max-microvolt = <3312000>;
+		};
+
+		vreg_l26a_1p2: l26 {
+			regulator-min-microvolt = <1200000>;
+			regulator-max-microvolt = <1200000>;
+			regulator-allow-set-load;
+		};
+
+		vreg_l28_3p0: l28 {
+			regulator-min-microvolt = <3008000>;
+			regulator-max-microvolt = <3008000>;
+		};
+
+		vreg_lvs1a_1p8: lvs1 { };
+
+		vreg_lvs2a_1p8: lvs2 { };
+	};
+
+	pmi8998-regulators {
+		compatible = "qcom,rpm-pmi8998-regulators";
+
+		vdd_bob-supply = <&vph_pwr>;
+
+		vreg_bob: bob {
+			regulator-min-microvolt = <3312000>;
+			regulator-max-microvolt = <3600000>;
+		};
+	};
+};
+
+&tlmm {
+	gpio-reserved-ranges = <0 4>, <81 4>;
+
+	cci1_default: cci1-default {
+		pins = "gpio18", "gpio19";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cci1_default: cci1-default {
+		pins = "gpio19", "gpio20";
+		function = "cci_i2c";
+		bias-disable;
+		drive-strength = <2>;
+	};
+
+	cdc_reset_n: cdc-reset-n {
+		pins = "gpio64";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <16>;
+		output-high;
+	};
+
+	hall_sensor_default: hall-sensor-default {
+		pins = "gpio124";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+		input-enable;
+	};
+
+	mdss_dsi_active: mdss-dsi-active {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-disable;
+	};
+
+	mdss_dsi_suspend: mdss-dsi-suspend {
+		pins = "gpio94";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdss_te_active: mdss-te-active {
+		pins = "gpio10";
+		function = "mdp_vsync_a";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	mdss_te_suspend: mdss-te-suspend {
+		pins = "gpio10";
+		function = "mdp_vsync_a";
+		drive-strength = <2>;
+		bias-pull-down;
+	};
+
+	msm_mclk0_default: msm-mclk0-active {
+		pins = "gpio13";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	msm_mclk1_default: msm-mclk1-active {
+		pins = "gpio14";
+		function = "cam_mclk";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	nfc_int_active: nfc-int-active {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_int_suspend: nfc-int-suspend {
+		pins = "gpio92";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_enable_active: nfc-enable-active {
+		pins = "gpio12", "gpio116";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-pull-up;
+	};
+
+	nfc_enable_suspend: nfc-enable-suspend {
+		pins = "gpio12", "gpio116";
+		function = "gpio";
+		drive-strength = <6>;
+		bias-disable;
+	};
+
+	ts_active: ts-active {
+		pins = "gpio89", "gpio125";
+		function = "gpio";
+		drive-strength = <16>;
+		bias-pull-up;
+		input-enable;
+	};
+
+	ts_int_suspend: ts-int-suspend {
+		pins = "gpio125";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	ts_reset_suspend: ts-reset-suspend {
+		pins = "gpio89";
+		function = "gpio";
+		drive-strength = <2>;
+		bias-disable;
+	};
+
+	wcd_int_n: wcd-int-n {
+		pins = "gpio54";
+		function = "gpio";
+		bias-pull-down;
+		drive-strength = <2>;
+		input-enable;
+	};
+
+	wsa_leftspk_pwr_n: wsa-leftspk-pwr-n {
+		pins = "gpio65";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+
+	wsa_rightspk_pwr_n: wsa-rightspk-pwr-n {
+		pins = "gpio66";
+		function = "gpio";
+		bias-disable;
+		drive-strength = <2>;
+		output-low;
+	};
+};
+
+&pm8998_resin {
+	debounce = <15625>;
+	linux,code = <KEY_VOLUMEDOWN>;
+};
+
+&ufshc {
+	status = "okay";
+
+	vcc-supply = <&vreg_l20a_2p95>;
+	vccq-supply = <&vreg_l26a_1p2>;
+	vccq2-supply = <&vreg_s4a_1p8>;
+	vcc-max-microamp = <750000>;
+	vccq-max-microamp = <560000>;
+	vccq2-max-microamp = <750000>;
+};
+
+&ufsphy {
+	status = "okay";
+
+	vdda-phy-supply = <&vreg_l1a_0p875>;
+	vdda-pll-supply = <&vreg_l2a_1p2>;
+	vddp-ref-clk-supply = <&vreg_l26a_1p2>;
+};
+
+&usb3 {
+	status = "okay";
+
+	/* Disable USB3 clock requirement as the device only supports USB2 */
+	qcom,select-utmi-as-pipe-clk;
+};
+
+&usb3_dwc3 {
+	/* Drop the unused USB 3 PHY */
+	phys = <&qusb2phy>;
+	phy-names = "usb2-phy";
+
+	/* Fastest mode for USB 2 */
+	maximum-speed = "high-speed";
+
+	/* Force to peripheral until we can switch modes */
+	dr_mode = "peripheral";
+};
+
+&wifi {
+	status = "okay";
+	vdd-0.8-cx-mx-supply = <&vreg_l5a_0p8>;
+	vdd-1.8-xo-supply = <&vreg_l7a_1p8>;
+	vdd-1.3-rfa-supply = <&vreg_l17a_1p3>;
+	vdd-3.3-ch0-supply = <&vreg_l25a_3p3>;
+};
diff --git a/arch/arm64/boot/dts/qcom/pm8998.dtsi b/arch/arm64/boot/dts/qcom/pm8998.dtsi
index d09f2954b6f9..4551af463081 100644
--- a/arch/arm64/boot/dts/qcom/pm8998.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8998.dtsi
@@ -52,6 +52,12 @@ pm8998_pwrkey: pwrkey {
 				bias-pull-up;
 				linux,code = <KEY_POWER>;
 			};
+
+			pm8998_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				bias-pull-up;
+				interrupts = <GIC_SPI 0x8 1 IRQ_TYPE_EDGE_BOTH>;
+			};
 		};
 
 		pm8998_temp: temp-alarm@2400 {
-- 
2.30.2

