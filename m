Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E839F6B964D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 14:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbjCNNcn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 09:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjCNNcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 09:32:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BFD4A90AD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:44 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id o8so46140lfo.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 06:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678800519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oyXgn9YP7XQ9gyU7T+fvTMc6wV6dOwpxjNcYcLnoGbg=;
        b=s69HBAsoNavmod/now9GOTOEMdL/zB0iVEDHVpTyUXw251UeBd+FEkP2hMW8fw5L2P
         ymC9qoVHrhbiRW3xdNrxqXcPicNIyW9ZmTylSYsKX4ckSzduuZw1BpSYqwEGQN6US2Vj
         wLwtv5T+Z8MD40BLbYmodWeMbT22u5aKxcWGyZLvI4ngQAzwzF7ubf/MYexiBzn+YCiB
         0pICB09PX13Hh5N6jTRwmgdhmKDWziXuy7G2uVXKbbI6YcKVhuaMoYCNP6u6C9ZA8Eg0
         jb6TEGGYPCAMgEx6++/pU8epv15HMoh4LViu2bJIXKUB9i/zvEF6gntLnnbKi17r4A/K
         kNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678800519;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyXgn9YP7XQ9gyU7T+fvTMc6wV6dOwpxjNcYcLnoGbg=;
        b=zHV2Rkg8al1RLaYnIZwB/j++t8gVmIo1yMMBns6AgDuydBSlo9c5sP8eqRGkj7sBpR
         HhDmZA91IzNlJykWYTyNIy+ILlpxVNrYmBU4yJgX/gLRSR9Qt9L0KUmOat5WpJCnDo0Y
         rVJ+RdKtJfSVZ6HP+d1Z6BZSpK82AWkU4BPkwqMbzYwexXt6bDp0YTJA+3Em3sJjvYyj
         ZN0dMuuokb634OiLDLwXGZkxqh8Ek0dcc9f4GpKsQCYrQ3AvWelX+m2JAjaJ5NOc5Ma1
         6Kw2h8mCUeOJPwJ0GAyNEhAq+3qCz5g3pOlN1yfyzLDGyRiopa0865SjEt99QYuIzwKe
         9CeQ==
X-Gm-Message-State: AO0yUKXmlX2yHizzIXNwnh47D4nC0CwWEbIFRujjBe6WoJfhrLZUeOlD
        SlnDYIwYn6jfMfqj0+MG1UT5sw==
X-Google-Smtp-Source: AK7set/cplHkbnPUztaeewmI3otmWr7GZvxoAIvNm1iSgFCpdOw9hCdYgD1NRqYEJsRbjD/oyaCbbQ==
X-Received: by 2002:a19:5502:0:b0:4e8:3d24:de6f with SMTP id n2-20020a195502000000b004e83d24de6fmr710458lfe.14.1678800519537;
        Tue, 14 Mar 2023 06:28:39 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id s9-20020a19ad49000000b004dda74eccafsm406012lfd.68.2023.03.14.06.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Mar 2023 06:28:39 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 14 Mar 2023 14:28:34 +0100
Subject: [PATCH v2 1/2] arm64: dts: qcom: msm8998-yoshino: Use SONY GPIO
 names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230314-topic-yoshino_gpio-v2-1-4cb80e187e38@linaro.org>
References: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
In-Reply-To: <20230314-topic-yoshino_gpio-v2-0-4cb80e187e38@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678800516; l=10116;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=gF+fxT2+OAPtuTsh5Ywse84/vBNT5S+3gtRjqt/JgRw=;
 b=oz198pZymYJj5LiruV4EKUWyPiB8T/J0vUHfITFOCJHROsT0IQXv6QZu7EXJdtlAfk7jm6S0f9RN
 UdyJ3DqeAs8/91MwO/9QtE8p1vJZDJvY9ogbVv/pL5k1yJ/eOhBg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the Yoshino devices DTs to better document the hardware.

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
 .../dts/qcom/msm8998-sony-xperia-yoshino-maple.dts | 175 ++++++++++++++++++
 .../boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi | 199 +++++++++++++++++++++
 2 files changed, 374 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
index 1868ad649415..8b6a718835c7 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-maple.dts
@@ -37,7 +37,29 @@ &lab {
 	qcom,soft-start-us = <200>;
 };
 
+&pm8005_gpios {
+	gpio-line-names = "EAR_EN", /* GPIO_1 */
+			  "NC",
+			  "SLB",
+			  "OPTION_1_PM8005";
+};
+
 &pmi8998_gpios {
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
 	disp_dvdd_en: disp-dvdd-en-active-state {
 		pins = "gpio10";
 		function = "normal";
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
index 820414758888..ede12a583236 100644
--- a/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino.dtsi
@@ -292,6 +292,13 @@ &lab {
 	regulator-soft-start;
 };
 
+&pm8005_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "SLB",
+			  "OPTION_1_PM8005";
+};
+
 &pm8005_regulators {
 	/* VDD_GFX supply */
 	pm8005_s1: s1 {
@@ -304,6 +311,33 @@ pm8005_s1: s1 {
 };
 
 &pm8998_gpios {
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
 	vol_down_pin_a: vol-down-active-state {
 		pins = "gpio5";
 		function = PMIC_GPIO_FUNC_NORMAL;
@@ -336,6 +370,21 @@ audio_mclk_pin: audio-mclk-pin-active-state {
 };
 
 &pmi8998_gpios {
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
 	cam_vio_default: cam-vio-active-state {
 		pins = "gpio1";
 		function = PMIC_GPIO_FUNC_NORMAL;
@@ -590,6 +639,156 @@ &sdhc2 {
 
 &tlmm {
 	gpio-reserved-ranges = <0 4>, <81 4>;
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
 
 	mdp_vsync_n: mdp-vsync-n-state {
 		pins = "gpio10";

-- 
2.39.2

