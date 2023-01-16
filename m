Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6BF166C333
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbjAPPBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjAPPAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:00:38 -0500
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6A5222FC;
        Mon, 16 Jan 2023 06:51:05 -0800 (PST)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 43043419A2;
        Mon, 16 Jan 2023 19:51:01 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1673880661; bh=EeQme+Y7wPUZgaKbwIjmLGrZt7uYay5b/nTjAhiMOqM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TkNgDg31r//ecgXVCVrL1XadzHsxPGEgjhKmjDYUfAHDYeqXXx+xbVYtSPei6u7og
         XSbLkgD2kblgeRHt28q+n/R5J+9eS/jc63kf+ZiwgaF6OOm6dxIJEHB3HmSunYHNdI
         z5LKLgOYk2pc4tA1ROLsaybR6sGy3BZlnW9IZAqHlTdV1gvZ9J9ktqu4y5jj82ra7G
         wvefmtbL6rl/d4DHVLyOpSXk4bYXGO6DEluAADz3n7LsSO1mVhgzk6OsFF1fC/Unhr
         kC9BTjHZrzQL8eYYi7S1PpTC8c4nZGSsTp72GPUe7/34Lb+1xyHzL38A8/jYCR8rDl
         0YAbpr8NPqkXw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 2/4] arm64: dts: qcom: msm/apq8x16-*: Reorder the pinctrl properties.
Date:   Mon, 16 Jan 2023 19:50:51 +0500
Message-Id: <20230116145053.1412501-3-nikita@trvn.ru>
In-Reply-To: <20230116145053.1412501-1-nikita@trvn.ru>
References: <20230116145053.1412501-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With other property lists that have -names properties, the -names is put
last. However pinctrl-names in most msm8916 dts files was first instead.

Reorder the pinctrl properties to be in line with other lists.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 arch/arm64/boot/dts/qcom/apq8016-sbc.dts      | 18 +++++------
 .../boot/dts/qcom/msm8916-acer-a1-724.dts     | 12 +++----
 .../boot/dts/qcom/msm8916-alcatel-idol347.dts | 22 ++++++-------
 .../arm64/boot/dts/qcom/msm8916-asus-z00l.dts | 16 +++++-----
 .../arm64/boot/dts/qcom/msm8916-huawei-g7.dts | 24 +++++++-------
 .../boot/dts/qcom/msm8916-longcheer-l8150.dts | 20 ++++++------
 .../boot/dts/qcom/msm8916-longcheer-l8910.dts | 12 +++----
 .../qcom/msm8916-samsung-a2015-common.dtsi    | 32 +++++++++----------
 .../boot/dts/qcom/msm8916-samsung-a3u-eur.dts |  8 ++---
 .../boot/dts/qcom/msm8916-samsung-a5u-eur.dts |  4 +--
 .../qcom/msm8916-samsung-e2015-common.dtsi    |  4 +--
 .../dts/qcom/msm8916-samsung-grandmax.dts     |  2 +-
 .../boot/dts/qcom/msm8916-samsung-j5.dts      |  6 ++--
 .../dts/qcom/msm8916-samsung-serranove.dts    | 32 +++++++++----------
 .../dts/qcom/msm8916-wingtech-wt88047.dts     | 14 ++++----
 arch/arm64/boot/dts/qcom/msm8916.dtsi         | 32 +++++++++----------
 16 files changed, 129 insertions(+), 129 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
index 110d22f6968b..6203ed92e4c0 100644
--- a/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
+++ b/arch/arm64/boot/dts/qcom/apq8016-sbc.dts
@@ -76,8 +76,8 @@ usb2513 {
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 121 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 
 	hdmi-out {
@@ -95,8 +95,8 @@ gpio-keys {
 		compatible = "gpio-keys";
 		autorepeat;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&msm_key_volp_n_default>;
+		pinctrl-names = "default";
 
 		button {
 			label = "Volume Up";
@@ -106,10 +106,10 @@ button {
 	};
 
 	leds {
-		pinctrl-names = "default";
 		pinctrl-0 = <&msmgpio_leds>,
 			    <&pm8916_gpios_leds>,
 			    <&pm8916_mpps_leds>;
+		pinctrl-names = "default";
 
 		compatible = "gpio-leds";
 
@@ -197,9 +197,9 @@ adv_bridge: bridge@39 {
 		v1p2-supply = <&pm8916_l6>;
 		v3p3-supply = <&pm8916_l17>;
 
-		pinctrl-names = "default","sleep";
 		pinctrl-0 = <&adv7533_int_active &adv7533_switch_active>;
 		pinctrl-1 = <&adv7533_int_suspend &adv7533_switch_suspend>;
+		pinctrl-names = "default","sleep";
 		#sound-dai-cells = <1>;
 
 		status = "okay";
@@ -279,8 +279,8 @@ camera_rear@3b {
 
 		enable-gpios = <&msmgpio 34 GPIO_ACTIVE_HIGH>;
 		reset-gpios = <&msmgpio 35 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&camera_rear_default>;
+		pinctrl-names = "default";
 
 		clocks = <&gcc GCC_CAMSS_MCLK0_CLK>;
 		clock-names = "xclk";
@@ -333,17 +333,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
@@ -395,9 +395,9 @@ codec {
 &usb {
 	extcon = <&usb_id>, <&usb_id>;
 
-	pinctrl-names = "default", "device";
 	pinctrl-0 = <&usb_sw_sel_pm &usb_hub_reset_pm>;
 	pinctrl-1 = <&usb_sw_sel_pm_device &usb_hub_reset_pm_device>;
+	pinctrl-names = "default", "device";
 
 	status = "okay";
 };
@@ -829,8 +829,8 @@ &pm8916_mpps {
 		"BT_LED_CTRL",
 		"GPIO-F"; /* LS_EXP_GPIO_F, LSEC pin 28 */
 
-	pinctrl-names = "default";
 	pinctrl-0 = <&ls_exp_gpio_f>;
+	pinctrl-names = "default";
 
 	ls_exp_gpio_f: pm8916-mpp4-state {
 		pins = "mpp4";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
index ed3fa7b3575b..04bbdc76889c 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-acer-a1-724.dts
@@ -32,8 +32,8 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -47,8 +47,8 @@ button-volume-up {
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -64,8 +64,8 @@ accelerometer@10 {
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
 
 		mount-matrix = "0", "-1", "0",
 			       "-1", "0", "0",
@@ -100,8 +100,8 @@ touchscreen@38 {
 		touchscreen-size-x = <720>;
 		touchscreen-size-y = <1280>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -123,17 +123,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_HIGH>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
index 20301eaa3b95..a5690354a2dd 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-alcatel-idol347.dts
@@ -23,8 +23,8 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -38,8 +38,8 @@ button-volume-up {
 	gpio-leds {
 		compatible = "gpio-leds";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
 
 		led-0 {
 			gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
@@ -51,8 +51,8 @@ led-0 {
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 69 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -69,8 +69,8 @@ touchscreen@26 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <13 IRQ_TYPE_EDGE_FALLING>;
 		reset-gpios = <&msmgpio 100 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&ts_int_reset_default>;
+		pinctrl-names = "default";
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l5>;
 		touchscreen-size-x = <2048>;
@@ -87,8 +87,8 @@ magnetometer@c {
 		vdd-supply = <&pm8916_l17>;
 		vid-supply = <&pm8916_l6>;
 		reset-gpios = <&msmgpio 8 GPIO_ACTIVE_LOW>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&mag_reset_default>;
+		pinctrl-names = "default";
 		mount-matrix = "0", "1", "0",
 			       "-1", "0", "0",
 			       "0", "0", "1";
@@ -101,8 +101,8 @@ accelerometer@f {
 		vddio-supply = <&pm8916_l6>;
 		interrupt-parent = <&msmgpio>;
 		interrupts = <31 IRQ_TYPE_EDGE_RISING>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
 		mount-matrix = "-1", "0", "0",
 			       "0", "1", "0",
 			       "0", "0", "-1";
@@ -113,8 +113,8 @@ proximity@48 {
 		reg = <0x48>;
 		interrupt-parent = <&msmgpio>;
 		interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&proximity_int_default>;
+		pinctrl-names = "default";
 	};
 
 	gyroscope@68 {
@@ -125,8 +125,8 @@ gyroscope@68 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <97 IRQ_TYPE_EDGE_RISING>,
 			     <98 IRQ_TYPE_EDGE_RISING>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&gyro_int_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -137,8 +137,8 @@ led-controller@68 {
 		compatible = "si-en,sn3190";
 		reg = <0x68>;
 		shutdown-gpios = <&msmgpio 89 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&led_enable_default &led_shutdown_default>;
+		pinctrl-names = "default";
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -165,17 +165,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
index a0f868854d53..9b6265d428ce 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-asus-z00l.dts
@@ -23,8 +23,8 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -54,15 +54,15 @@ reg_sd_vmmc: regulator-sdcard-vmmc {
 
 		startup-delay-us = <200>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&sd_vmmc_en_default>;
+		pinctrl-names = "default";
 	};
 
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpios = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -78,8 +78,8 @@ magnetometer@c {
 
 		reset-gpios = <&msmgpio 112 GPIO_ACTIVE_LOW>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&mag_reset_default>;
+		pinctrl-names = "default";
 	};
 
 	imu@68 {
@@ -92,8 +92,8 @@ imu@68 {
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&imu_default>;
+		pinctrl-names = "default";
 
 		mount-matrix = "1",  "0", "0",
 			       "0", "-1", "0",
@@ -119,8 +119,8 @@ touchscreen@38 {
 		touchscreen-size-x = <720>;
 		touchscreen-size-y = <1280>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -133,9 +133,9 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
@@ -143,9 +143,9 @@ &sdhc_1 {
 &sdhc_2 {
 	vmmc-supply = <&reg_sd_vmmc>;
 
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
 	status = "okay";
diff --git a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
index 2d266fd417f8..ac8b80de1a31 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-huawei-g7.dts
@@ -36,8 +36,8 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -51,8 +51,8 @@ button-volume-up {
 	leds {
 		compatible = "gpio-leds";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_leds_default>;
+		pinctrl-names = "default";
 
 		led-0 {
 			gpios = <&msmgpio 8 GPIO_ACTIVE_HIGH>;
@@ -79,8 +79,8 @@ led-2 {
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 117 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -96,8 +96,8 @@ magnetometer@c {
 
 		reset-gpios = <&msmgpio 36 GPIO_ACTIVE_LOW>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&mag_reset_default>;
+		pinctrl-names = "default";
 	};
 
 	accelerometer@1e {
@@ -110,8 +110,8 @@ accelerometer@1e {
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&accel_irq_default>;
+		pinctrl-names = "default";
 
 		mount-matrix = "-1", "0", "0",
 				"0", "1", "0",
@@ -131,16 +131,16 @@ proximity@39 {
 		led-max-microamp = <100000>;
 		amstaos,proximity-diodes = <1>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&prox_irq_default>;
+		pinctrl-names = "default";
 	};
 
 	regulator@3e {
 		compatible = "ti,tps65132";
 		reg = <0x3e>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&reg_lcd_en_default>;
+		pinctrl-names = "default";
 
 		reg_lcd_pos: outp {
 			regulator-name = "outp";
@@ -175,8 +175,8 @@ rmi4@70 {
 		vdd-supply = <&pm8916_l17>;
 		vio-supply = <&pm8916_l16>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&ts_irq_default>;
+		pinctrl-names = "default";
 
 		syna,startup-delay-ms = <100>;
 
@@ -205,8 +205,8 @@ nfc@28 {
 		enable-gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
 		firmware-gpios = <&msmgpio 2 GPIO_ACTIVE_HIGH>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&nfc_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -232,17 +232,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdhc2_cd_default>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdhc2_cd_default>;
+	pinctrl-names = "default", "sleep";
 
 	/*
 	 * The Huawei device tree sets cd-gpios = <&msmgpio 38 GPIO_ACTIVE_HIGH>.
@@ -269,9 +269,9 @@ &sound {
 		"AMIC2", "MIC BIAS External2",
 		"AMIC3", "MIC BIAS External1";
 
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&cdc_pdm_lines_act>;
 	pinctrl-1 = <&cdc_pdm_lines_sus>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
index f63f0fb797b4..8fbbfc98900d 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8150.dts
@@ -34,8 +34,8 @@ wcnss_mem: wcnss@8b600000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -56,8 +56,8 @@ reg_ctp: regulator-ctp {
 		gpio = <&msmgpio 17 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&ctp_pwr_en_default>;
+		pinctrl-names = "default";
 	};
 
 	flash-led-controller {
@@ -65,8 +65,8 @@ flash-led-controller {
 		flash-gpios = <&msmgpio 31 GPIO_ACTIVE_HIGH>;
 		enable-gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&camera_flash_default>;
+		pinctrl-names = "default";
 
 		flash_led: led {
 			function = LED_FUNCTION_FLASH;
@@ -126,8 +126,8 @@ accelerometer@10 {
 		 * interrupts = <116 IRQ_TYPE_EDGE_RISING>;
 		 */
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
 
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
@@ -144,8 +144,8 @@ magnetometer@12 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <113 IRQ_TYPE_EDGE_RISING>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&magn_int_default>;
+		pinctrl-names = "default";
 
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
@@ -159,8 +159,8 @@ light-sensor@23 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <115 IRQ_TYPE_EDGE_FALLING>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&light_int_default>;
+		pinctrl-names = "default";
 
 		vdd-supply = <&pm8916_l17>;
 		vio-supply = <&pm8916_l6>;
@@ -174,8 +174,8 @@ gyroscope@68 {
 		interrupts = <23 IRQ_TYPE_EDGE_RISING>,
 			     <22 IRQ_TYPE_EDGE_RISING>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gyro_int_default>;
+		pinctrl-names = "default";
 
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
@@ -197,8 +197,8 @@ rmi4@20 {
 		vdd-supply = <&reg_ctp>;
 		vio-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tp_int_default>;
+		pinctrl-names = "default";
 
 		syna,startup-delay-ms = <10>;
 
@@ -236,17 +236,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	non-removable;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
index 4d627d06f87b..b776a2b4a317 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-longcheer-l8910.dts
@@ -23,8 +23,8 @@ chosen {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -44,16 +44,16 @@ led-0 {
 			default-state = "off";
 			function = LED_FUNCTION_KBD_BACKLIGHT;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&button_backlight_default>;
+			pinctrl-names = "default";
 		};
 	};
 
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -69,8 +69,8 @@ magnetometer@d {
 
 		reset-gpios = <&msmgpio 111 GPIO_ACTIVE_LOW>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&mag_reset_default>;
+		pinctrl-names = "default";
 	};
 
 	imu@68 {
@@ -104,17 +104,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
index 13c586079e50..dd0e2e586ac1 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a2015-common.dtsi
@@ -29,16 +29,16 @@ clk_pwm: pwm {
 
 		clocks = <&gcc GCC_GP2_CLK>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&motor_pwm_default>;
+		pinctrl-names = "default";
 		status = "disabled";
 	};
 
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -58,8 +58,8 @@ button-home {
 	gpio-hall-sensor {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_hall_sensor_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Hall Effect Sensor";
 
@@ -86,8 +86,8 @@ reg_motor_vdd: regulator-motor-vdd {
 		gpio = <&msmgpio 76 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&motor_en_default>;
+		pinctrl-names = "default";
 	};
 
 	reg_vdd_tsp_a: regulator-vdd-tsp-a {
@@ -99,8 +99,8 @@ reg_vdd_tsp_a: regulator-vdd-tsp-a {
 		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tsp_en_default>;
+		pinctrl-names = "default";
 	};
 
 	i2c-muic {
@@ -108,8 +108,8 @@ i2c-muic {
 		sda-gpios = <&msmgpio 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&muic_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -121,8 +121,8 @@ muic: extcon@25 {
 			interrupt-parent = <&msmgpio>;
 			interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&muic_int_default>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -131,8 +131,8 @@ i2c-tkey {
 		sda-gpios = <&msmgpio 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 17 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -150,8 +150,8 @@ touchkey: touchkey@20 {
 
 			linux,keycodes = <KEY_APPSELECT KEY_BACK>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&tkey_default>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -160,8 +160,8 @@ i2c-nfc {
 		sda-gpios = <&msmgpio 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&nfc_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -178,8 +178,8 @@ nfc@27 {
 
 			clocks = <&rpmcc RPM_SMD_BB_CLK2_PIN>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&nfc_default &nfc_clk_req>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -206,8 +206,8 @@ accelerometer: accelerometer@10 {
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l5>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&accel_int_default>;
+		pinctrl-names = "default";
 	};
 
 	magnetometer@12 {
@@ -228,8 +228,8 @@ battery@35 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <121 IRQ_TYPE_EDGE_BOTH>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&fg_alert_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -238,9 +238,9 @@ &blsp1_uart2 {
 };
 
 &dsi0 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&mdss_default>;
 	pinctrl-1 = <&mdss_sleep>;
+	pinctrl-names = "default", "sleep";
 };
 
 &mdss {
@@ -257,17 +257,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
index c691cca2eb45..2eb06cf626dc 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a3u-eur.dts
@@ -18,8 +18,8 @@ reg_panel_vdd3: regulator-panel-vdd3 {
 		gpio = <&msmgpio 9 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&panel_vdd3_default>;
+		pinctrl-names = "default";
 	};
 
 	reg_touch_key: regulator-touch-key {
@@ -31,8 +31,8 @@ reg_touch_key: regulator-touch-key {
 		gpio = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_en_default>;
+		pinctrl-names = "default";
 	};
 
 	reg_key_led: regulator-key-led {
@@ -44,8 +44,8 @@ reg_key_led: regulator-key-led {
 		gpio = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_led_en_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -76,8 +76,8 @@ touchscreen@20 {
 		vcca-supply = <&reg_vdd_tsp_a>;
 		vdd-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&ts_int_default>;
+		pinctrl-names = "default";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
index 3dd819458785..179c872091d8 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-a5u-eur.dts
@@ -18,8 +18,8 @@ reg_touch_key: regulator-touch-key {
 		gpio = <&msmgpio 97 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_en_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -45,8 +45,8 @@ touchscreen@48 {
 		avdd-supply = <&reg_vdd_tsp_a>;
 		vdd-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&ts_int_default>;
+		pinctrl-names = "default";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
index c95f0b4bc61f..6c04ca97e98a 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-e2015-common.dtsi
@@ -21,8 +21,8 @@ muic: extcon@14 {
 			interrupt-parent = <&msmgpio>;
 			interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&muic_int_default>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -35,8 +35,8 @@ reg_touch_key: regulator-touch-key {
 		gpio = <&msmgpio 97 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_en_default>;
+		pinctrl-names = "default";
 	};
 };
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
index 4cbd68b89448..f5ca2d30881f 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-grandmax.dts
@@ -35,8 +35,8 @@ led-keyled {
 
 			gpios = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&gpio_leds_default>;
+			pinctrl-names = "default";
 		};
 	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
index 8eb68bb6607c..882ed9c65d88 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-j5.dts
@@ -29,8 +29,8 @@ tz-apps@85500000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -67,17 +67,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on &sdc2_cd_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off &sdc2_cd_off>;
+	pinctrl-names = "default", "sleep";
 
 	cd-gpios = <&msmgpio 38 GPIO_ACTIVE_LOW>;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
index 34bee5211413..249519635ba6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-samsung-serranove.dts
@@ -46,8 +46,8 @@ tz-apps@85500000 {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -67,8 +67,8 @@ button-home {
 	gpio-hall-sensor {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_hall_sensor_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Hall Effect Sensor";
 
@@ -90,8 +90,8 @@ reg_vdd_tsp: regulator-vdd-tsp {
 		gpio = <&msmgpio 73 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tsp_en_default>;
+		pinctrl-names = "default";
 	};
 
 	reg_touch_key: regulator-touch-key {
@@ -103,8 +103,8 @@ reg_touch_key: regulator-touch-key {
 		gpio = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_en_default>;
+		pinctrl-names = "default";
 	};
 
 	reg_key_led: regulator-key-led {
@@ -116,8 +116,8 @@ reg_key_led: regulator-key-led {
 		gpio = <&msmgpio 60 GPIO_ACTIVE_HIGH>;
 		enable-active-high;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_led_en_default>;
+		pinctrl-names = "default";
 	};
 
 	i2c-muic {
@@ -125,8 +125,8 @@ i2c-muic {
 		sda-gpios = <&msmgpio 105 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 106 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&muic_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -138,8 +138,8 @@ muic: extcon@14 {
 			interrupt-parent = <&msmgpio>;
 			interrupts = <12 IRQ_TYPE_EDGE_FALLING>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&muic_irq_default>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -148,8 +148,8 @@ i2c-tkey {
 		sda-gpios = <&msmgpio 16 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 17 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tkey_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -167,8 +167,8 @@ touchkey@20 {
 
 			linux,keycodes = <KEY_APPSELECT KEY_BACK>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&tkey_default>;
+			pinctrl-names = "default";
 		};
 	};
 
@@ -177,8 +177,8 @@ i2c-nfc {
 		sda-gpios = <&msmgpio 0 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 		scl-gpios = <&msmgpio 1 (GPIO_ACTIVE_HIGH|GPIO_OPEN_DRAIN)>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&nfc_i2c_default>;
+		pinctrl-names = "default";
 
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -193,8 +193,8 @@ nfc@2b {
 			enable-gpios = <&msmgpio 20 GPIO_ACTIVE_HIGH>;
 			firmware-gpios = <&msmgpio 49 GPIO_ACTIVE_HIGH>;
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&nfc_default>;
+			pinctrl-names = "default";
 		};
 	};
 };
@@ -209,8 +209,8 @@ imu@6b {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <115 IRQ_TYPE_EDGE_RISING>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&imu_irq_default>;
+		pinctrl-names = "default";
 	};
 
 	magnetometer@2e {
@@ -233,8 +233,8 @@ battery@35 {
 		interrupt-parent = <&msmgpio>;
 		interrupts = <121 IRQ_TYPE_EDGE_FALLING>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&fg_alert_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -254,8 +254,8 @@ touchscreen@20 {
 		vdd-supply = <&reg_vdd_tsp>;
 		vddo-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&tsp_irq_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -281,17 +281,17 @@ iris {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	non-removable;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
index 24a5c3486beb..e542b48a4fad 100644
--- a/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
+++ b/arch/arm64/boot/dts/qcom/msm8916-wingtech-wt88047.dts
@@ -28,8 +28,8 @@ flash-led-controller {
 		enable-gpios = <&msmgpio 31 GPIO_ACTIVE_HIGH>;
 		flash-gpios = <&msmgpio 32 GPIO_ACTIVE_HIGH>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&camera_flash_default>;
+		pinctrl-names = "default";
 
 		flash_led: led {
 			function = LED_FUNCTION_FLASH;
@@ -40,8 +40,8 @@ flash_led: led {
 	gpio-keys {
 		compatible = "gpio-keys";
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&gpio_keys_default>;
+		pinctrl-names = "default";
 
 		label = "GPIO Buttons";
 
@@ -55,8 +55,8 @@ button-volume-up {
 	usb_id: usb-id {
 		compatible = "linux,extcon-usb-gpio";
 		id-gpio = <&msmgpio 110 GPIO_ACTIVE_HIGH>;
-		pinctrl-names = "default";
 		pinctrl-0 = <&usb_id_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -73,8 +73,8 @@ imu@68 {
 		vdd-supply = <&pm8916_l17>;
 		vddio-supply = <&pm8916_l6>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&imu_default>;
+		pinctrl-names = "default";
 
 		mount-matrix = "1",  "0", "0",
 			       "0", "-1", "0",
@@ -101,8 +101,8 @@ touchscreen@38 {
 		touchscreen-size-x = <720>;
 		touchscreen-size-y = <1280>;
 
-		pinctrl-names = "default";
 		pinctrl-0 = <&touchscreen_default>;
+		pinctrl-names = "default";
 	};
 };
 
@@ -158,17 +158,17 @@ &pronto {
 };
 
 &sdhc_1 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on>;
 	pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	status = "okay";
 };
 
 &sdhc_2 {
-	pinctrl-names = "default", "sleep";
 	pinctrl-0 = <&sdc2_clk_on &sdc2_cmd_on &sdc2_data_on>;
 	pinctrl-1 = <&sdc2_clk_off &sdc2_cmd_off &sdc2_data_off>;
+	pinctrl-names = "default", "sleep";
 
 	non-removable;
 
diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index cf248e10660b..aeae56f88ed6 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1182,8 +1182,8 @@ cci: cci@1b0c000 {
 			assigned-clocks = <&gcc GCC_CAMSS_CCI_AHB_CLK>,
 					  <&gcc GCC_CAMSS_CCI_CLK>;
 			assigned-clock-rates = <80000000>, <19200000>;
-			pinctrl-names = "default";
 			pinctrl-0 = <&cci0_default>;
+			pinctrl-names = "default";
 			status = "disabled";
 
 			cci_i2c0: i2c-bus@0 {
@@ -1532,9 +1532,9 @@ blsp1_uart1: serial@78af000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 0>, <&blsp_dma 1>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart1_default>;
 			pinctrl-1 = <&blsp1_uart1_sleep>;
+			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};
 
@@ -1546,9 +1546,9 @@ blsp1_uart2: serial@78b0000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 2>, <&blsp_dma 3>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&blsp1_uart2_default>;
 			pinctrl-1 = <&blsp1_uart2_sleep>;
+			pinctrl-names = "default", "sleep";
 			status = "disabled";
 		};
 
@@ -1561,9 +1561,9 @@ blsp_i2c1: i2c@78b5000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c1_default>;
 			pinctrl-1 = <&i2c1_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1578,9 +1578,9 @@ blsp_spi1: spi@78b5000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 4>, <&blsp_dma 5>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi1_default>;
 			pinctrl-1 = <&spi1_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1595,9 +1595,9 @@ blsp_i2c2: i2c@78b6000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c2_default>;
 			pinctrl-1 = <&i2c2_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1612,9 +1612,9 @@ blsp_spi2: spi@78b6000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 6>, <&blsp_dma 7>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi2_default>;
 			pinctrl-1 = <&spi2_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1629,9 +1629,9 @@ blsp_i2c3: i2c@78b7000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c3_default>;
 			pinctrl-1 = <&i2c3_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1646,9 +1646,9 @@ blsp_spi3: spi@78b7000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 8>, <&blsp_dma 9>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi3_default>;
 			pinctrl-1 = <&spi3_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1663,9 +1663,9 @@ blsp_i2c4: i2c@78b8000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c4_default>;
 			pinctrl-1 = <&i2c4_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1680,9 +1680,9 @@ blsp_spi4: spi@78b8000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 10>, <&blsp_dma 11>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi4_default>;
 			pinctrl-1 = <&spi4_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1697,9 +1697,9 @@ blsp_i2c5: i2c@78b9000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c5_default>;
 			pinctrl-1 = <&i2c5_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1714,9 +1714,9 @@ blsp_spi5: spi@78b9000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 12>, <&blsp_dma 13>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi5_default>;
 			pinctrl-1 = <&spi5_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1731,9 +1731,9 @@ blsp_i2c6: i2c@78ba000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c6_default>;
 			pinctrl-1 = <&i2c6_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1748,9 +1748,9 @@ blsp_spi6: spi@78ba000 {
 			clock-names = "core", "iface";
 			dmas = <&blsp_dma 14>, <&blsp_dma 15>;
 			dma-names = "tx", "rx";
-			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&spi6_default>;
 			pinctrl-1 = <&spi6_sleep>;
+			pinctrl-names = "default", "sleep";
 			#address-cells = <1>;
 			#size-cells = <0>;
 			status = "disabled";
@@ -1818,8 +1818,8 @@ pronto: remoteproc@a21b000 {
 			qcom,smem-states = <&wcnss_smp2p_out 0>;
 			qcom,smem-state-names = "stop";
 
-			pinctrl-names = "default";
 			pinctrl-0 = <&wcnss_pin_a>;
+			pinctrl-names = "default";
 
 			status = "disabled";
 
-- 
2.38.1

