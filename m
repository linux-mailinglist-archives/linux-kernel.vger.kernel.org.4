Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76856736A4C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 13:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjFTLFx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 07:05:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231864AbjFTLFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 07:05:43 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55AED10E2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2b4790ff688so30529671fa.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 04:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687259137; x=1689851137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPvEmuwd6DGAowfXu00FN23lI8vD4oDdNvK0TJyc+E8=;
        b=dcs3OAaGMnHCgtnmUbthgD886FptzIpNBnn+isu+QGHHEnqLxQosAogUEgDyW7zRMH
         Bovz5elSFsfnJEZ8dSbCqO3sBNI5TZmX5necIIUvCnDxTw3wau+OBCm15HosglyUil7u
         7TW8pnPhGzzgGJCecSFlq41jjAz4HV1oSCWGzf9d/6GmqQqxp/5W0oNkB5qsvnVNigGK
         B9OR2W7S7GqztI0MJmYgu+q/Vm5g90Sl03n8hTFJO6Tsy7YuPl/r9R5xNu1j2Qq2WMnU
         BRxVY/8Pb3g3TXzVFFzTeS+DS/G8qhSRL6OWz77lDc6qR7Iz1LZtTlILakwd2EN0rNOs
         tylQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687259137; x=1689851137;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iPvEmuwd6DGAowfXu00FN23lI8vD4oDdNvK0TJyc+E8=;
        b=WrhQ6czHk0q8vlzqq77PNmQg1sol3huQ7TeDihM63b7jAl/FhXR9IfllClZjH3pdlX
         yNHjyuDeluJ2QBpNfSgAQaINMUB+mYWs0g4XEZbilJ6Qp9f0VEo7GqCdUX4urz/XujDn
         A/M7m6VfAziewTuiZeogvCvrSDxIDXAYvO9xprVsZY//DDdtVKlFFGJMwz17ojUe5Vb2
         9XMa5BRV+mi06qc+68z9OvnkyDv4uCOd+zwNEi96WuL7silO7q7GyFJYKyCCM3uHB6K8
         5cjMnG0pn9iKcZ2a8H/m8QY8fxqjw8PN9t3pC2YxfNof9dhLrEm+NqLQlXnBIbFCW1EW
         yUEA==
X-Gm-Message-State: AC+VfDyZEHZXvGY3W2foTQ4ocpr8pUf3cCQ737Gk4Kd2/ejt6kERZtf3
        mGe5U9+J4ojL8UzlicmOiOwkYA==
X-Google-Smtp-Source: ACHHUZ6JKNfPdSk15UF/nFaEF6y7mYpRU7bk5PoZUcHQepQYWFDO/J2fk8oRiLjHOKI1+tCSrstw5w==
X-Received: by 2002:a2e:8058:0:b0:2b4:5ced:b26c with SMTP id p24-20020a2e8058000000b002b45cedb26cmr6195052ljg.49.1687259137092;
        Tue, 20 Jun 2023 04:05:37 -0700 (PDT)
Received: from [192.168.1.101] (abxj193.neoplus.adsl.tpnet.pl. [83.9.3.193])
        by smtp.gmail.com with ESMTPSA id 11-20020a05651c008b00b002ac7b0fc473sm369047ljq.38.2023.06.20.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:05:36 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 20 Jun 2023 13:05:34 +0200
Subject: [PATCH v2 1/4] arm64: dts: qcom: sm8250-edo: Add gpio line names
 for TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230614-topic-edo_pinsgpiopmic-v2-1-6f90bba54c53@linaro.org>
References: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
In-Reply-To: <20230614-topic-edo_pinsgpiopmic-v2-0-6f90bba54c53@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687259134; l=10201;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=Gs8EcWkCuXLPlTR/L3C8hsNX2wpikTOpGZoHLWzmzC8=;
 b=zZsFu1FeRWGlWTjZPkCzaGj5Gp7ERJUg5bp5PmDETKjzstQAaHqvsBhtTDcF7vp3h66uZC2OG
 u04YvLrZa/JDssC0dbZsbT468zzg4/ZnjfhzpR1S7ULBOjf7Z+cHd3s
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

