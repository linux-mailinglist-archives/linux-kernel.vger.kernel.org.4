Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9402272FE0A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244535AbjFNMM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244487AbjFNMMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:12:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82642695
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:56 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f6255ad8aeso8505847e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 05:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686744715; x=1689336715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPvEmuwd6DGAowfXu00FN23lI8vD4oDdNvK0TJyc+E8=;
        b=Sx0COolsuS6zB6efJ1AbFAg5QuESp6fliBRSi6RmQaHCAMQ8wYspHoJjX34yViTrWT
         yGOjwJCYGSgqGrruKPCQ7bV/8LLOl8XKScHAZiJ5VbApRSw53rp1Rb3cwB1dgo2dSQVI
         lLO1EQj8bClh5s5hXXj3gqctsIBVtqA8z/4oF57g8Y03XROrAlfmwCPoWydmR9BkgAWy
         uFj1tmTCY1JGMqWdkepWfeC4mny51JINeCVS6Kc9CacEYX9SYJgVOSYBYElaD4ixYr5n
         0q7Hec83SkLmhX1px8drWE0ZJytsNmOn7LhpcfZwGSy7S3/n9AMFQ/l1hqhq7+pBl2FZ
         M0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744715; x=1689336715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPvEmuwd6DGAowfXu00FN23lI8vD4oDdNvK0TJyc+E8=;
        b=TKmiucvydJag8C357gAXqjV1QdfWJ2jlDZLtj7e+BkaKsgDBgI867FkUbjrXu/AUcQ
         GM3kuuFPXIwZAvcsSwf995T8ddTgP3Wh68pbXkblcQHfaYcVBoccocK98eDKSxVfnWQj
         6Zoiw6aL2a4d3lYL5/Klwr9z+U51CCGT9v9Qp5LSCMRYVGj0lXgQxYl+3dwMBDrRIBdD
         Lv9AK5fWlS6dgMj1D5vgNcPM8ygRS9Aa/WBPpf2+S9Zo0bYRmAcFazx+++/7MI55DSZk
         8YPYzossmIqUXFRoRNdVrK/GJj0gTJtodEiiIzotCfWD8MwNHHlfSqaoeKdgRjppa+Gl
         ZxNQ==
X-Gm-Message-State: AC+VfDwNWpKECxgV88oS9Vim3/uoTBTYrrrxYc8E2Z1Nt9bDmUgz4go+
        3f8L6eT4EN25ZcAOXFsRBD+iyA==
X-Google-Smtp-Source: ACHHUZ4OLdP8mOwcoPkCMusy4X2NOwbdNGtCOtn2xZ+AZR0XJJ1U7fEly+4XL2l331UX1VpTfVGptw==
X-Received: by 2002:a19:4f18:0:b0:4f7:6454:655d with SMTP id d24-20020a194f18000000b004f76454655dmr1516321lfb.0.1686744715070;
        Wed, 14 Jun 2023 05:11:55 -0700 (PDT)
Received: from [192.168.1.101] (abyj190.neoplus.adsl.tpnet.pl. [83.9.29.190])
        by smtp.gmail.com with ESMTPSA id d2-20020ac25ec2000000b004f24e797c55sm2109793lfq.25.2023.06.14.05.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 05:11:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 14 Jun 2023 14:11:46 +0200
Subject: [PATCH 1/4] arm64: dts: qcom: sm8250-edo: Add gpio line names for
 TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v1-1-cf88a0bac26c@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v1-0-cf88a0bac26c@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1686744712; l=10201;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Gs8EcWkCuXLPlTR/L3C8hsNX2wpikTOpGZoHLWzmzC8=;
 b=Bwd2ZNEk/nXA4VxudRLMD72Vb9WSOhVcHm+A3w5vLcCRGXfJw41oRP3zoUx4sxQOSz/bEDVAQ
 WdtwOiaCGjVBx3/466VcPFEJO32qQTKD3dYc6M5Ab4oS7gQavOBowhs
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX203&206 DTSIs to better document the hardware.

Diff between 203 and 206:
<                         "CAM_PWR_A_CS",
>                         "FRONTC_PWR_EN",
<                         "CAM4_MCLK",
<                         "TOF_RST_N",
>                         "NC",
>                         "NC",
<                         "WLC_I2C_SDA",
<                         "WLC_I2C_SCL", /* GPIO_120 */
>                         "NC",
>                         "NC",
<                         "WLC_INT_N",
>                         "NC",

Which makes sense, as 203 has a 3D iToF, slightly different camera
power wiring and WLC (WireLess Charging).

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../dts/qcom/sm8250-sony-xperia-edo-pdx203.dts     | 183 +++++++++++++++++++++
 .../dts/qcom/sm8250-sony-xperia-edo-pdx206.dts     | 183 +++++++++++++++++++++
 2 files changed, 366 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
index 356a81698731..84104d2b2010 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx203.dts
@@ -14,3 +14,186 @@ / {
 };
 
 /delete-node/ &vreg_l7f_1p8;
+
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "CAM_PWR_A_CS",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "CAM4_MCLK",
+			  "TOF_RST_N",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL", /* GPIO_120 */
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "WLC_INT_N",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
index 01fe3974ee72..fae6568cb79e 100644
--- a/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
+++ b/arch/arm64/boot/dts/qcom/sm8250-sony-xperia-edo-pdx206.dts
@@ -30,6 +30,189 @@ g-assist-key {
 	};
 };
 
+&tlmm {
+	gpio-line-names = "AP_CTI_IN", /* GPIO_0 */
+			  "MDM2AP_ERR_FATAL",
+			  "AP_CTI_OUT",
+			  "MDM2AP_STATUS",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_PWR_REQ",
+			  "DVDT_WRT_DET_AND",
+			  "SPK_AMP_RESET_N", /* GPIO_10 */
+			  "SPK_AMP_INT_N",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "NC",
+			  "TX_GTR_THRES_IN",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_20 */
+			  "HST_BT_EN",
+			  "RGBC_IR_PWR_EN",
+			  "FP_INT_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK", /* GPIO_30 */
+			  "NFC_ESE_SPI_CS_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "SDM_DEBUG_UART_TX",
+			  "SDM_DEBUG_UART_RX",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "TS_INT_N",
+			  "FP_SPI_MISO", /* GPIO_40 */
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "DISP_ERR_FG",
+			  "UIM2_DETECT_EN",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_50 */
+			  "NC",
+			  "MDM_UART_CTS",
+			  "MDM_UART_RFR",
+			  "MDM_UART_TX",
+			  "MDM_UART_RX",
+			  "AP2MDM_STATUS",
+			  "AP2MDM_ERR_FATAL",
+			  "MDM_IPC_HS_UART_TX",
+			  "MDM_IPC_HS_UART_RX",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "USB_CC_DIR",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "CAM_PWR_B_CS",
+			  "NC", /* GPIO_70 */
+			  "FRONTC_PWR_EN",
+			  "SBU_SW_SEL",
+			  "SBU_SW_OE",
+			  "FP_RESET_N",
+			  "FP_RESET_N",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "TRAY_DET",
+			  "CAM2_RST_N",
+			  "PCIE0_RST_N",
+			  "PCIE0_CLK_REQ_N", /* GPIO_80 */
+			  "PCIE0_WAKE_N",
+			  "DVDT_ENABLE",
+			  "DVDT_WRT_DET_OR",
+			  "NC",
+			  "PCIE2_RST_N",
+			  "PCIE2_CLK_REQ_N",
+			  "PCIE2_WAKE_N",
+			  "MDM_VFR_IRQ0",
+			  "MDM_VFR_IRQ1",
+			  "SW_SERVICE", /* GPIO_90 */
+			  "CAM_SOF",
+			  "CAM1_RST_N",
+			  "CAM0_RST_N",
+			  "CAM0_MCLK",
+			  "CAM1_MCLK",
+			  "CAM2_MCLK",
+			  "CAM3_MCLK",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_100 */
+			  "CCI0_I2C_SDA",
+			  "CCI0_I2C_SCL",
+			  "CCI1_I2C_SDA",
+			  "CCI1_I2C_SCL_",
+			  "CCI2_I2C_SDA",
+			  "CCI2_I2C_SCL",
+			  "CCI3_I2C_SDA",
+			  "CCI3_I2C_SCL",
+			  "CAM3_RST_N",
+			  "NFC_DWL_REQ", /* GPIO_110 */
+			  "NFC_IRQ",
+			  "XVS",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "ACC_COVER_OPEN",
+			  "ALS_PROX_INT_N",
+			  "ACCEL_INT",
+			  "WLAN_SW_CTRL",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "UDON_SWITCH_SEL",
+			  "WDOG_DISABLE",
+			  "BAROMETER_INT",
+			  "NC", /* GPIO_130 */
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "BT_SLIMBUS_CLK",
+			  "BT_SLIMBUS_DATA",
+			  "HW_ID_0",
+			  "HW_ID_1",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0", /* GPIO_150 */
+			  "WCD_SWR_RX_DATA1",
+			  "SDM_DMIC_CLK1",
+			  "SDM_DMIC_DATA1",
+			  "SDM_DMIC_CLK2",
+			  "SDM_DMIC_DATA2",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "SPK_AMP_I2S_ASP_DIN",
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "COMPASS_I2C_SDA", /* GPIO_160 */
+			  "COMPASS_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N",
+			  "NC",
+			  "NC",
+			  "SSC_SENSOR_I2C_SDA", /* GPIO_170 */
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HST_BLE_SNS_UART6_TX",
+			  "HST_BLE_SNS_UART6_RX",
+			  "HST_WLAN_UART_TX",
+			  "HST_WLAN_UART_RX";
+};
+
 &vreg_l2f_1p3 {
 	regulator-min-microvolt = <1200000>;
 	regulator-max-microvolt = <1200000>;

-- 
2.41.0

