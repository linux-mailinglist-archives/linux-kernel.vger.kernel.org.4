Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0A8865B6D2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 20:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236019AbjABTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 14:02:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235261AbjABTCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 14:02:05 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1A32E8
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 11:02:02 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id u12so26079223ljj.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 11:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eRENzn8p2H3N0iaqkrymXVoPVUflbqm/wr2bptlPmLs=;
        b=VmeFlcXSE14K2Em6HliCCtvgVTmhSd+MXZ4jOK0F6Mx2/R2qFRfL7Nj50kDppHKCBy
         fEAFiH9KDHLty64zTia+9d12Y831c8vU2Y+QYulUDSZxJH1XrXUJDKYqWfZhyEe+hvC+
         sSZEr/erJ7jDVj3XOpdlmtEwCpgWmQRJqGd1aYKkG5mAtYaV/oc1EgYL4HsKJcYdXxtq
         Tp/STrWoUEl8Ys3FuuUooaRX2CAT5MXYIrvDThA8F8otCrZyQ2vmf1BD1lskIweMnbZ1
         Jt+MzIpVvDM4pHwi2z9xw58r8j9ZEJg0eAHbMMrFMPSnma3zP+cx7McCY00g6wxIah2N
         sw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRENzn8p2H3N0iaqkrymXVoPVUflbqm/wr2bptlPmLs=;
        b=qHq+0qQ1ROzIzAC31ABb0AJNeInsGCsqZ1ecrO4zLjuc1pbpmDhn8QXAHJjcvxWgCx
         zcAPPqqptFMO+Uvfg3anoL54PitZs8dCpqI3bot5iBts8j+4Hfc42XCj5JI4aGfnsceQ
         CINC9Xe4DvJWkMxrPCBj5/y1lHAJTklerMx6mx9I9jySsSfznnDL30Cl15jDeYG4xEFd
         0SSRokMz4mgnkSxaTCpv5K8nGVmAy2wXkuSxzXYt8zZ9a5feTeTJpbBydbVPUNz13Cj+
         8mR++8k9rVTXYz3xNeW4iyaTz28QpqoJAgN5hzwANRcAiE0bhe8BJLPOfKQ7XI28vTcN
         1EAg==
X-Gm-Message-State: AFqh2kqZDSerhOh0h1jHeJhiLeGNS9cAD2DyA+bhuHv+9SakHCceZme5
        SBkggupp/bjAFXdjowouNoiJ6Q==
X-Google-Smtp-Source: AMrXdXvv90HMRs4lLv4hG7ivHdngN3mSXSA5OuGl0lWYVNdQDlf/bW1lnb2f6zOqtbG3vnUUe98v1g==
X-Received: by 2002:a05:651c:54b:b0:27f:b4b0:d44c with SMTP id q11-20020a05651c054b00b0027fb4b0d44cmr9021817ljp.24.1672686121180;
        Mon, 02 Jan 2023 11:02:01 -0800 (PST)
Received: from localhost.localdomain (abxi45.neoplus.adsl.tpnet.pl. [83.9.2.45])
        by smtp.gmail.com with ESMTPSA id y22-20020a2e9d56000000b0027965d3cc9fsm3317927ljj.47.2023.01.02.11.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 11:02:00 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO names
Date:   Mon,  2 Jan 2023 20:01:57 +0100
Message-Id: <20230102190157.970053-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Yoshino devices DTs to better document the hardware and
rename already-defined GPIO nodes to fit the "official" names.
Note that 4k_ is replaced with four_k_ in one pin, as labels can't start
with numbers.

Lilac and Poplar have identical pin assignments.

Diff between these two and maple:

TLMM:
-  "NC",
+  "TS_VDDIO_EN",

PMI8998:
-  "NC"
+  "USB_SWITCH_SEL"

-  "NC"
+  "4K_DISP_DCDC_EN"

PM8005:
-  "NC"
+  "EAR_EN"

Which is probably due to Maple being designed and released quite a bit
earlier than the other two and it having a super high tech true-4K
display.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../msm8998-sony-xperia-yoshino-maple.dts     | 179 +++++++++++-
 .../dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 260 +++++++++++++++---
 2 files changed, 406 insertions(+), 33 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
index 20fe0394a3c1..e813b41f6db8 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
@@ -22,7 +22,7 @@ disp_dvdd_vreg: disp-dvdd-vreg {
 		enable-active-high;
 		gpio = <&pmi8998_gpio 10 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&disp_dvdd_en>;
+		pinctrl-0 = <&four_k_disp_dcdc_en>;
 	};
 };
 
@@ -37,8 +37,30 @@ &lab {
 	qcom,soft-start-us = <200>;
 };
 
+&pm8005_gpio {
+	gpio-line-names = "EAR_EN", /* GPIO_1 */
+			  "NC",
+			  "SLB",
+			  "OPTION_1_PM8005";
+};
+
 &pmi8998_gpio {
-	disp_dvdd_en: disp-dvdd-en-active-state {
+	gpio-line-names = "MAIN_CAM_PWR_IO_EN", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "TYPEC_UUSB_SEL",
+			  "VIB_LDO_EN",
+			  "NC",
+			  "DISPLAY_TYPE_SEL",
+			  "USB_SWITCH_SEL",
+			  "NC",
+			  "4K_DISP_DCDC_EN", /* GPIO_10 */
+			  "NC",
+			  "DIV_CLK3",
+			  "SPMI_I2C_SEL",
+			  "NC";
+
+	four_k_disp_dcdc_en: 4k-disp-dcdc-en-state {
 		pins = "gpio10";
 		function = "normal";
 		bias-disable;
@@ -49,6 +71,159 @@ disp_dvdd_en: disp-dvdd-en-active-state {
 	};
 };
 
+&tlmm {
+	gpio-line-names = "", /* GPIO_0 */
+			  "",
+			  "",
+			  "",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "MDP_VSYNC_P", /* GPIO_10 */
+			  "RGBC_IR_INT",
+			  "NFC_VEN",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "NC",
+			  "NC",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "MAIN_CAM_PWR_EN",
+			  "TOF_INT_N",
+			  "NC",
+			  "NC",
+			  "CHAT_CAM_PWR_EN",
+			  "NC",
+			  "TOF_RESET_N",
+			  "CAM2_RSTN",
+			  "NC",
+			  "CAM1_RSTN", /* GPIO_30 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "CC_DIR",
+			  "UIM2_DETECT_EN",
+			  "FP_RESET_N", /* GPIO_40 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_RXD",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "NC",
+			  "CODEC_INT2_N",
+			  "CODEC_INT1_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "TRAY2_DET_DS",
+			  "CODEC_RST_N",
+			  "WSA_L_EN",
+			  "WSA_R_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "LPASS_SLIMBUS_CLK", /* GPIO_70 */
+			  "LPASS_SLIMBUS_DATA0",
+			  "LPASS_SLIMBUS_DATA1",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_80 */
+			  "SW_SERVICE",
+			  "TX_GTR_THRES_IN",
+			  "HW_ID0",
+			  "HW_ID1",
+			  "NC",
+			  "NC",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_RESET_N",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NFC_IRQ",
+			  "NFC_DWLD_EN",
+			  "DISP_RESET_N",
+			  "TRAY2_DET",
+			  "CAM_SOF",
+			  "RFFE6_CLK",
+			  "RFFE6_DATA",
+			  "DEBUG_GPIO0",
+			  "DEBUG_GPIO1", /* GPIO_100 */
+			  "GRFC4",
+			  "NC",
+			  "NC",
+			  "RSVD",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RST",
+			  "UIM1_PRESENT",
+			  "UIM_BATT_ALARM",
+			  "RSVD",
+			  "NC",
+			  "NC",
+			  "ACCEL_INT",
+			  "GYRO_INT",
+			  "COMPASS_INT",
+			  "ALS_PROX_INT_N", /* GPIO_120 */
+			  "FP_INT_N",
+			  "NC",
+			  "BAROMETER_INT",
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "NC",
+			  "NC",
+			  "USB_DETECT_EN",
+			  "NC",
+			  "QLINK_REQUEST", /* GPIO_130 */
+			  "QLINK_ENABLE",
+			  "NC",
+			  "TS_VDDIO_EN",
+			  "WMSS_RESET_N",
+			  "PA_INDICATOR_OR",
+			  "NC",
+			  "RFFE3_DATA",
+			  "RFFE3_CLK",
+			  "RFFE4_DATA",
+			  "RFFE4_CLK", /* GPIO_140 */
+			  "RFFE5_DATA",
+			  "RFFE5_CLK",
+			  "GNSS_EN",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD",
+			  "RFFE2_DATA",
+			  "RFFE2_CLK",
+			  "RFFE1_DATA",
+			  "RFFE1_CLK";
+};
+
 &vreg_l22a_2p85 {
 	regulator-min-microvolt = <2704000>;
 	regulator-max-microvolt = <2704000>;
diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
index 5da87baa2b23..a083361a7bc4 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -21,7 +21,7 @@ / {
 	clocks {
 		div1_mclk: divclk1 {
 			compatible = "gpio-gate-clock";
-			pinctrl-0 = <&audio_mclk_pin>;
+			pinctrl-0 = <&div_clk1>;
 			pinctrl-names = "default";
 			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
 			#clock-cells = <0>;
@@ -46,7 +46,7 @@ cam0_vdig_vreg: cam0-vdig {
 		enable-active-high;
 		gpio = <&tlmm 21 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam0_vdig_default>;
+		pinctrl-0 = <&main_cam_pwr_en>;
 	};
 
 	cam1_vdig_vreg: cam1-vdig {
@@ -56,7 +56,7 @@ cam1_vdig_vreg: cam1-vdig {
 		enable-active-high;
 		gpio = <&tlmm 25 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam1_vdig_default>;
+		pinctrl-0 = <&chat_cam_pwr_en>;
 		vin-supply = <&vreg_s3a_1p35>;
 	};
 
@@ -67,7 +67,7 @@ cam_vio_vreg: cam-vio-vreg {
 		enable-active-high;
 		gpio = <&pmi8998_gpio 1 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&cam_vio_default>;
+		pinctrl-0 = <&main_cam_pwr_io_en>;
 		vin-supply = <&vreg_lvs1a_1p8>;
 	};
 
@@ -92,15 +92,14 @@ extcon_usb: extcon-usb {
 		id-gpio = <&tlmm 38 GPIO_ACTIVE_HIGH>;
 		vbus-gpio = <&tlmm 128 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&usb_extcon_active &usb_vbus_active>;
+		pinctrl-0 = <&cc_dir_default &usb_detect_en>;
 	};
 
 	gpio-keys {
 		compatible = "gpio-keys";
 		label = "Side buttons";
 		pinctrl-names = "default";
-		pinctrl-0 = <&vol_down_pin_a>, <&cam_focus_pin_a>,
-			    <&cam_snapshot_pin_a>;
+		pinctrl-0 = <&vol_down_n &focus_n &snapshot_n>;
 		button-vol-down {
 			label = "Volume Down";
 			gpios = <&pm8998_gpio 5 GPIO_ACTIVE_LOW>;
@@ -131,7 +130,7 @@ gpio-hall-sensor {
 		compatible = "gpio-keys";
 		label = "Hall sensors";
 		pinctrl-names = "default";
-		pinctrl-0 = <&hall_sensor0_default>;
+		pinctrl-0 = <&acc_cover_open>;
 
 		event-hall-sensor0 {
 			label = "Cover Hall Sensor";
@@ -189,7 +188,7 @@ vibrator {
 		compatible = "gpio-vibrator";
 		enable-gpios = <&pmi8998_gpio 5 GPIO_ACTIVE_HIGH>;
 		pinctrl-names = "default";
-		pinctrl-0 = <&vib_default>;
+		pinctrl-0 = <&vib_ldo_en>;
 	};
 };
 
@@ -263,7 +262,7 @@ proximity@29 {
 		vdd-supply = <&cam_vio_vreg>;
 
 		pinctrl-names = "default";
-		pinctrl-0 = <&tof_int &tof_reset>;
+		pinctrl-0 = <&tof_int_n &tof_reset>;
 	};
 };
 
@@ -292,6 +291,13 @@ &lab {
 	regulator-soft-start;
 };
 
+&pm8005_gpio {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "SLB",
+			  "OPTION_1_PM8005";
+};
+
 &pm8005_regulators {
 	/* VDD_GFX supply */
 	pm8005_s1: s1 {
@@ -304,7 +310,34 @@ pm8005_s1: s1 {
 };
 
 &pm8998_gpio {
-	vol_down_pin_a: vol-down-active-state {
+	gpio-line-names = "UIM_BATT_ALARM", /* GPIO_1 */
+			  "NC",
+			  "WLAN_SW_CTRL (DISALLOWED)",
+			  "SSC_PWR_EN",
+			  "VOL_DOWN_N",
+			  "VOL_UP_N",
+			  "SNAPSHOT_N",
+			  "FOCUS_N",
+			  "FLASH_THERM",
+			  "", /* GPIO_10 */
+			  "",
+			  "",
+			  "DIV_CLK1",
+			  "NC",
+			  "NC (DISALLOWED)",
+			  "DIV_CLK3",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC (DISALLOWED)", /* GPIO_20 */
+			  "NFC_CLK_REQ",
+			  "NC (DISALLOWED)",
+			  "WCSS_PWR_REQ",
+			  "OPTION_1 (DISALLOWED)",
+			  "OPTION_2 (DISALLOWED)",
+			  "PM_SLB (DISALLOWED)";
+
+	vol_down_n: vol-down-n-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -312,7 +345,7 @@ vol_down_pin_a: vol-down-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_focus_pin_a: cam-focus-btn-active-state {
+	focus_n: focus-n-state {
 		pins = "gpio7";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -320,7 +353,7 @@ cam_focus_pin_a: cam-focus-btn-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	cam_snapshot_pin_a: cam-snapshot-btn-active-state {
+	snapshot_n: snapshot-n-state {
 		pins = "gpio8";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-pull-up;
@@ -328,7 +361,7 @@ cam_snapshot_pin_a: cam-snapshot-btn-active-state {
 		qcom,drive-strength = <PMIC_GPIO_STRENGTH_NO>;
 	};
 
-	audio_mclk_pin: audio-mclk-pin-active-state {
+	div_clk1: div-clk1-state {
 		pins = "gpio13";
 		function = "func2";
 		power-source = <0>;
@@ -336,7 +369,22 @@ audio_mclk_pin: audio-mclk-pin-active-state {
 };
 
 &pmi8998_gpio {
-	cam_vio_default: cam-vio-active-state {
+	gpio-line-names = "MAIN_CAM_PWR_IO_EN", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "TYPEC_UUSB_SEL",
+			  "VIB_LDO_EN",
+			  "NC",
+			  "DISPLAY_TYPE_SEL",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "DIV_CLK3",
+			  "SPMI_I2C_SEL",
+			  "NC";
+
+	main_cam_pwr_io_en: main-cam-pwr-io-en-state {
 		pins = "gpio1";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
@@ -346,7 +394,7 @@ cam_vio_default: cam-vio-active-state {
 		power-source = <1>;
 	};
 
-	vib_default: vib-en-state {
+	vib_ldo_en: vib-ldo-en-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
 		bias-disable;
@@ -595,8 +643,158 @@ &sdhc2 {
 
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
-
-	mdp_vsync_n: mdp-vsync-n-state {
+	gpio-line-names = "", /* GPIO_0 */
+			  "",
+			  "",
+			  "",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "MDP_VSYNC_P", /* GPIO_10 */
+			  "RGBC_IR_INT",
+			  "NFC_VEN",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "NC",
+			  "NC",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "MAIN_CAM_PWR_EN",
+			  "TOF_INT_N",
+			  "NC",
+			  "NC",
+			  "CHAT_CAM_PWR_EN",
+			  "NC",
+			  "TOF_RESET_N",
+			  "CAM2_RSTN",
+			  "NC",
+			  "CAM1_RSTN", /* GPIO_30 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "CC_DIR",
+			  "UIM2_DETECT_EN",
+			  "FP_RESET_N", /* GPIO_40 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_RXD",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "NC",
+			  "CODEC_INT2_N",
+			  "CODEC_INT1_N",
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "TRAY2_DET_DS",
+			  "CODEC_RST_N",
+			  "WSA_L_EN",
+			  "WSA_R_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "LPASS_SLIMBUS_CLK", /* GPIO_70 */
+			  "LPASS_SLIMBUS_DATA0",
+			  "LPASS_SLIMBUS_DATA1",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "NC",
+			  "RF_LCD_ID_EN",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_80 */
+			  "SW_SERVICE",
+			  "TX_GTR_THRES_IN",
+			  "HW_ID0",
+			  "HW_ID1",
+			  "NC",
+			  "NC",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_RESET_N",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NFC_IRQ",
+			  "NFC_DWLD_EN",
+			  "DISP_RESET_N",
+			  "TRAY2_DET",
+			  "CAM_SOF",
+			  "RFFE6_CLK",
+			  "RFFE6_DATA",
+			  "DEBUG_GPIO0",
+			  "DEBUG_GPIO1", /* GPIO_100 */
+			  "GRFC4",
+			  "NC",
+			  "NC",
+			  "RSVD",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RST",
+			  "UIM1_PRESENT",
+			  "UIM_BATT_ALARM",
+			  "RSVD",
+			  "NC",
+			  "NC",
+			  "ACCEL_INT",
+			  "GYRO_INT",
+			  "COMPASS_INT",
+			  "ALS_PROX_INT_N", /* GPIO_120 */
+			  "FP_INT_N",
+			  "NC",
+			  "BAROMETER_INT",
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "NC",
+			  "NC",
+			  "USB_DETECT_EN",
+			  "NC",
+			  "QLINK_REQUEST", /* GPIO_130 */
+			  "QLINK_ENABLE",
+			  "NC",
+			  "NC",
+			  "WMSS_RESET_N",
+			  "PA_INDICATOR_OR",
+			  "NC",
+			  "RFFE3_DATA",
+			  "RFFE3_CLK",
+			  "RFFE4_DATA",
+			  "RFFE4_CLK", /* GPIO_140 */
+			  "RFFE5_DATA",
+			  "RFFE5_CLK",
+			  "GNSS_EN",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD",
+			  "RFFE2_DATA",
+			  "RFFE2_CLK",
+			  "RFFE1_DATA",
+			  "RFFE1_CLK";
+
+	mdp_vsync_p: mdp-vsync-p-state {
 		pins = "gpio10";
 		function = "mdp_vsync_a";
 		drive-strength = <2>;
@@ -611,14 +809,14 @@ nfc_ven: nfc-ven-state {
 		output-low;
 	};
 
-	msm_mclk0_default: msm-mclk0-active-state {
+	cam_mclk0_active: cam-mclk0-active-state {
 		pins = "gpio13";
 		function = "cam_mclk";
 		drive-strength = <2>;
 		bias-disable;
 	};
 
-	msm_mclk1_default: msm-mclk1-active-state {
+	cam_mclk1_active: cam-mclk1-active-state {
 		pins = "gpio14";
 		function = "cam_mclk";
 		drive-strength = <2>;
@@ -639,14 +837,14 @@ cci1_default: cci1-default-state {
 		drive-strength = <2>;
 	};
 
-	cam0_vdig_default: cam0-vdig-default-state {
+	main_cam_pwr_en: main-cam-pwr-en-default-state {
 		pins = "gpio21";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	tof_int: tof-int-state {
+	tof_int_n: tof-int-n-state {
 		pins = "gpio22";
 		function = "gpio";
 		bias-pull-up;
@@ -654,28 +852,28 @@ tof_int: tof-int-state {
 		input-enable;
 	};
 
-	cam1_vdig_default: cam1-vdig-default-state {
+	chat_cam_pwr_en: chat-cam-pwr-en-default-state {
 		pins = "gpio25";
 		function = "gpio";
 		bias-disable;
 		drive-strength = <2>;
 	};
 
-	usb_extcon_active: usb-extcon-active-state {
-		pins = "gpio38";
+	tof_reset: tof-reset-state {
+		pins = "gpio27";
 		function = "gpio";
 		bias-disable;
-		drive-strength = <16>;
+		drive-strength = <2>;
 	};
 
-	tof_reset: tof-reset-state {
-		pins = "gpio27";
+	cc_dir_default: cc-dir-active-state {
+		pins = "gpio38";
 		function = "gpio";
 		bias-disable;
-		drive-strength = <2>;
+		drive-strength = <16>;
 	};
 
-	hall_sensor0_default: acc-cover-open-state {
+	acc_cover_open: acc-cover-open-state {
 		pins = "gpio124";
 		function = "gpio";
 		bias-disable;
@@ -690,7 +888,7 @@ ts_int_n: ts-int-n-state {
 		bias-pull-up;
 	};
 
-	usb_vbus_active: usb-vbus-active-state {
+	usb_detect_en: usb-detect-en-active-state {
 		pins = "gpio128";
 		function = "gpio";
 		bias-disable;
-- 
2.39.0

