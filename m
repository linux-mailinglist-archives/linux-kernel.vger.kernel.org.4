Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E49386DDCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 15:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjDKNt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 09:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjDKNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 09:49:24 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E319C196
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:22 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id e11so10439699lfc.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681220961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IAFw3fMJjti2alnnAGY+IeTKktvF3qFkCOaKWG5QWSY=;
        b=WRa7CazXjjJEJXl876blpsDg5LqH8uSiuxVf2N3NUjmI8lIG3dSZwuOIKbsXp5xaky
         kKyLaTN3L1LfnsPyOF9j+J8RizCg8taElaPZ9+w+IFgLiWbPrR9XU/JT9t+ZhHC0DIGu
         WgMAGuKdVLnHKsdMD4MRWS9WS4T/dovhKsFopFMsIDhfJhL9RsPnpq4P3fEEnE0OyK8b
         Er2uBmFau5l9CYi9qqjv+HMH66+voGE4/GkQxTx1DLzqQ0PbEyH5U+pUexr0WskB3Pnt
         f/ygwD5XZsQFn5Q+kilSAFpZpqRBhvZFcpi0gb1JsINAvrCM6fNDwkjlpTfcacCGfg6y
         1fTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681220961;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IAFw3fMJjti2alnnAGY+IeTKktvF3qFkCOaKWG5QWSY=;
        b=1x0ADv0kxaIvV502ikhQbYs7wLRqTezjAHgLEHxn1+NwZ0dmyTqCe0qagqXOTpkbRt
         VrKnUoWO/xd7izOWLhqA0M3BD0YjLtyhX+WkC2J4X28W/OgyYoWmfFXnqXdy5Jf+OF++
         oyRbc1XfETDN465ENXDGDpcMUYOQ7WMEbu03qe/8qPoeTJOuf+RAvYhAKAcN4m/MFR41
         Iw2hM7CbpWjrhIwQmPyFTpmLmujpkTjnWdniYNlue4qUDmPGUVHgjEDFEw+zhSbPgCEi
         sFaLsSKk7xP9+EAg4RDfzyIhtNrs6D0DMuz4rkVMaVnKQwA8aMnhmUdb4iBACjytGYJH
         N/sA==
X-Gm-Message-State: AAQBX9cCrxEG3LgOPrHHRvaEi5clEw+z86gUu6+dpbjWnUlu6DJS0XTk
        5snUKYD1MuBChz0cLPfbrvXGURJ5kmq1RGBanns=
X-Google-Smtp-Source: AKy350aKbACSA75Hrpt+WM6cgJ8Dh160cvzKZPFVcG8TQt2POSMW8KiAr8CyFAxawyK/U16zskQnFg==
X-Received: by 2002:ac2:4890:0:b0:4e9:8016:bfcc with SMTP id x16-20020ac24890000000b004e98016bfccmr2778559lfc.30.1681220961198;
        Tue, 11 Apr 2023 06:49:21 -0700 (PDT)
Received: from [192.168.1.101] (abxj23.neoplus.adsl.tpnet.pl. [83.9.3.23])
        by smtp.gmail.com with ESMTPSA id y9-20020ac255a9000000b004eb2d6160a4sm2563707lfg.32.2023.04.11.06.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 06:49:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 11 Apr 2023 15:49:16 +0200
Subject: [PATCH 2/4] arm64: dts: qcom: sm8150-kumano: Add GPIO line names
 for TLMM
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-kumano_dts0-v1-2-f1852c2a2378@linaro.org>
References: <20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org>
In-Reply-To: <20230315-topic-kumano_dts0-v1-0-f1852c2a2378@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681220957; l=4866;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=ya68rGYBf4fVp2YMimU7MDqmgtfsOC1t4pU81IxkjEQ=;
 b=spVA1wPmMxRJpi+tkk9mbJiznGcQzcy9f6rtKcKuIUg+GPz5ZaaZBzBo5sI3qYmAOpBHw+R0PiCQ
 9/P6/4UADYj6jg2uxywK6xVPSrA1xLrHK/6OanxeCAb+Y4unqHMq
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=0.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the common DTSI to better document the hardware.

The pin assignment for TLMM is identical on both devices. Great job!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi   | 175 +++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
index 6753c65d75bc..d1a3ab836019 100644
--- a/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150-sony-xperia-kumano.dtsi
@@ -541,6 +541,181 @@ &qupv3_id_1 {
 
 &tlmm {
 	gpio-reserved-ranges = <126 4>;
+	gpio-line-names = "NFC_ESE_SPI_MISO", /* GPIO_0 */
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_SCLK",
+			  "NFC_ESE_SPI_CS_N",
+			  "NC",
+			  "NC",
+			  "DISP_RESET_N",
+			  "DEBUG_GPIO0",
+			  "MDP_VSYNC_P",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL", /* GPIO_10 */
+			  "CAM_SOF",
+			  "CAM2_RST_N",
+			  "CAM_MCLK0",
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "CCI_I2C_SDA0",
+			  "CCI_I2C_SCL0",
+			  "CCI_I2C_SDA1",
+			  "CCI_I2C_SCL1", /* GPIO_20 */
+			  "NC",
+			  "MAIN_CAM_PWR_EN",
+			  "CAM3_RST_N",
+			  "NC",
+			  "CHAT_CAM_PWR_EN",
+			  "NC",
+			  "NC",
+			  "CAM0_RST_N",
+			  "RGBC_IR_PWR_EN",
+			  "CAM1_RST_N", /* GPIO_30 */
+			  "CCI_I2C_SDA2",
+			  "CCI_I2C_SCL2",
+			  "CCI_I2C_SDA3",
+			  "CCI_I2C_SCL3",
+			  "NC",
+			  "DEBUG_GPIO1",
+			  "RGBC_IR_INT",
+			  "USB_CC_DIR",
+			  "NC",
+			  "NC", /* GPIO_40 */
+			  "NFC_EN",
+			  "NFC_ESE_PWR_REQ",
+			  "BT_HCI_UART_CTS_N",
+			  "BT_HCI_UART_RFR_N",
+			  "BT_HCI_UART_TXD",
+			  "BT_HCI_UART_RXD",
+			  "NFC_IRQ",
+			  "NFC_DWL_REQ",
+			  "UIM2_DETECT_EN",
+			  "WLAN_SW_CTRL", /* GPIO_50 */
+			  "APPS_I2C_SDA",
+			  "APPS_I2C_SCL",
+			  "NC",
+			  "TS_RESET_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "HW_ID_0",
+			  "NC", /* GPIO_60 */
+			  "QLINK_REQUEST",
+			  "QLINK_ENABLE",
+			  "WMSS_RESET_N",
+			  "SDM_GRFC_8",
+			  "WDOG_DISABLE",
+			  "NC",
+			  "NC",
+			  "PA_INDICATOR_OR",
+			  "MSS_LTE_COXM_TXD",
+			  "MSS_LTE_COXM_RXD", /* GPIO_70 */
+			  "SDM_RFFE0_DATA",
+			  "SDM_RFFE0_CLK",
+			  "SDM_RFFE1_DATA",
+			  "SDM_RFFE1_CLK",
+			  "SDM_RFFE2_DATA",
+			  "SDM_RFFE2_CLK",
+			  "SDM_RFFE3_DATA",
+			  "SDM_RFFE3_CLK",
+			  "SUB_CAM_PWR_EN",
+			  "FP_RESET_N", /* GPIO_80 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "DVDT_WRT_DET_AND",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_90 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "UDON_SWITCH_SEL",
+			  "SD_CARD_DET_N",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "USB_AUDIO_EN1", /* GPIO_100 */
+			  "DISP_ERR_FG",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_DET",
+			  "UIM1_DATA",
+			  "UIM1_CLK", /* GPIO_110 */
+			  "UIM1_RESET",
+			  "UIM1_PRESENT",
+			  "NFC_CLK_REQ",
+			  "SW_SERVICE",
+			  "NC",
+			  "RF_ID_EXTENSION",
+			  "ALS_PROX_INT_N",
+			  "FP_INT",
+			  "DVDT_WRT_DET_OR",
+			  "BAROMETER_INT", /* GPIO_120 */
+			  "ACC_COVER_OPEN",
+			  "TS_INT_N",
+			  "CODEC_INT1_N",
+			  "CODEC_INT2_N",
+			  "TX_GTR_THRES_IN",
+			  "FP_SPI_MISO",
+			  "FP_SPI_MOSI",
+			  "FP_SPI_SCLK",
+			  "FP_SPI_CS_N",
+			  "NC", /* GPIO_130 */
+			  "DVDT_ENABLE",
+			  "ACCEL_INT",
+			  "NC",
+			  "MAG_INT_N",
+			  "NC",
+			  "FORCED_USB_BOOT",
+			  "NC",
+			  "NC",
+			  "HW_ID_1",
+			  "NC", /* GPIO_140 */
+			  "NC",
+			  "NC",
+			  "CODEC_RST_N",
+			  "CDC_SPI_MISO",
+			  "CDC_SPI_MOSI",
+			  "CDC_SPI_SCLK",
+			  "CDC_SPI_CS_N",
+			  "NC",
+			  "LPASS_SLIMBUS_CLK",
+			  "LPASS_SLIMBUS_DATA0", /* GPIO_150 */
+			  "LPASS_SLIMBUS_DATA1",
+			  "USB_AUDIO_EN2",
+			  "BT_FM_SLIMBUS_DATA",
+			  "BT_FM_SLIMBUS_CLK",
+			  "COMPASS_I2C_SDA",
+			  "COMPASS_I2C_SCL",
+			  "SSC_SPI_1_MISO",
+			  "SSC_SPI_1_MOSI",
+			  "SSC_SPI_1_CLK",
+			  "SSC_SPI_1_CS_N", /* GPIO_160 */
+			  "SSC_SENSOR_I2C_SDA",
+			  "SSC_SENSOR_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SSC_UART_1_TX",
+			  "SSC_UART_1_RX",
+			  "WL_CMD_CLK_CHAIN0",
+			  "WL_CMD_DATA_CHAIN0", /* GPIO_170 */
+			  "WL_CMD_CLK_CHAIN1",
+			  "WL_CMD_DATA_CHAIN1",
+			  "WL_BT_COEX_CLK",
+			  "WL_BT_COEX_DATA";
 };
 
 &uart2 {

-- 
2.40.0

