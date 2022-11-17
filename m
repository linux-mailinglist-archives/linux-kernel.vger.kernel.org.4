Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1D3862DDBD
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 15:16:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240332AbiKQOQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 09:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240314AbiKQOQV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 09:16:21 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F9C6DF01
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:16:20 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id kt23so5348575ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 06:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U5cS9nqr5rAd4hwsFX5SVt8LkKZ5u86E9Sxsnqkok3E=;
        b=odAFJJQuOJDT6LIyvCQ81jC7THS9snaqZj0vPNHHO4U0SzQf5SBJoAaC9GzlIX1RUM
         UgEfjnsWtyY80qabTaqQFZ6jymafAdop/MF5KpBrpjk8FLVhkdycu1qJ2802w8p2YrA6
         EuS/3Uu/ebdQRhynosF3sij1g+c5QhFn0kol8ae8lpocb6QDE+Yeewmlk4nx1H8jhBLM
         /eNqjK4J48qRGsXV19BMH6EOPnhcjlkFagqpsdPMtRtJjU8TCuJ9U82csskAjpcPlyDu
         7nsl4oC0/dbHd1KGpRWHOoDZNDUL5vfkkXz66zNQwi3oTn5hQnXN1j4650rzn+mayhTg
         7rMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U5cS9nqr5rAd4hwsFX5SVt8LkKZ5u86E9Sxsnqkok3E=;
        b=luvLpSvTbFNJKiDA6FRuXiCirSt1fUARvU6TIh4e82FUw4QXGsCDTMye8sRjWQNegy
         ZirkFg2C/nhrhyVlcfTqqDUTn6yuThKXSC31hZfRskKwZ0dRFlLdVK9NuownMjCn6aLb
         ZZ40ub/uLTfyewxIzN4Qs0cDIq3JRRL9ymjdqDpPt5a5aQAzVDR4+rg30HniX+LDdRcn
         brmP+lUj9anAxhzL158mo5wyCWD9HtfEmYyAblSDyEti7u02TNWLneyv6VVLy8z0wbhk
         /WKpL3x8Fl6hs4TSaP+VobLZ2ox4HZ7bpi23sts+KUkHpbDJUEkw+fD33ObjayxD/sRy
         PzmQ==
X-Gm-Message-State: ANoB5pm0MKV9stIb6x2f32ps2dXO7iR1sYhq+fn45r+GxhHICKvSeRGm
        jQnu8CzsnUw67P0WfTPVLo+6yA==
X-Google-Smtp-Source: AA0mqf7j5IOnbTiFENJOyEPXBicv3MOIZR2rnX8YCISCZ9OTd0wRnF/F/zZ7tnGLqNgWCcennRMywQ==
X-Received: by 2002:a17:906:4804:b0:7a8:3ecb:bd62 with SMTP id w4-20020a170906480400b007a83ecbbd62mr2307514ejq.721.1668694579013;
        Thu, 17 Nov 2022 06:16:19 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id e24-20020a170906315800b0078d793e7927sm432543eje.4.2022.11.17.06.16.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 17 Nov 2022 06:16:18 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: qcom: sm8450-nagara: Add gpio line names for TLMM
Date:   Thu, 17 Nov 2022 15:16:13 +0100
Message-Id: <20221117141613.19942-1-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sony ever so graciously provides GPIO line names in their downstream
kernel (though sometimes they are not 100% accurate and you can judge
that by simply looking at them and with what drivers they are used).

Add these to the PDX223&224 DTSIs to better document the hardware.

Diff between 223 and 224:
< 	gpio-line-names = "NC", /* GPIO_0 */
< 			  "NC",
< 			  "NC",
< 			  "NC",
> 	gpio-line-names = "TELE_SPI_MISO", /* GPIO_0 */
> 			  "TELE_SPI_MOSI",
> 			  "TELE_SPI_CLK",
> 			  "TELE_SPI_CS_N",
< 			  "PM8010_2_RESET_N",
> 			  "NC",
< 			  "NC",
> 			  "UWIDEC_PWR_EN",
< 			  "TOF_RST_N",
> 			  "NC"
< 			  "QLINK1_REQ",
< 			  "QLINK1_EN", /* GPIO_160 */
< 			  "QLINK1_WMSS_RESET_N",
> 			  "NC",
> 			  "NC", /* GPIO_160 */
> 			  "NC",
The tele lens setup is different on 1 IV and 5 IV and power wiring
is different for some lenses, so it makes sense. As for QLINK, no
idea.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 213 ++++++++++++++++++
 .../qcom/sm8450-sony-xperia-nagara-pdx224.dts | 213 ++++++++++++++++++
 2 files changed, 426 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index 3ab145877094..b83500316a81 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -12,3 +12,216 @@ / {
 	model = "Sony Xperia 1 IV";
 	compatible = "sony,pdx223", "qcom,sm8450";
 };
+
+&tlmm {
+	gpio-line-names = "NC", /* GPIO_0 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL",
+			  "NC",
+			  "PM8010_1_RESET_N",
+			  "WLC_INT_N",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "PM8010_2_RESET_N",
+			  "DISP_ERR_FG",
+			  "HALL_INT_N",
+			  "ALS_PROX_INT_N",
+			  "IMU1_INT",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "DISP_RESET_N",
+			  "DISP_VDDR_EN",
+			  "TS_RESET_N", /* GPIO_20 */
+			  "TS_INT_N",
+			  "NC",
+			  "TELEC_PWR_EN",
+			  "CAM1_RESET_N",
+			  "LEO_CAM0_RESET_N",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "FP_SPI_MISO",
+			  "FP_SPI_MOSI",
+			  "FP_SPI_CLK", /* GPIO_30 */
+			  "FP_SPI_CS_N",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_CLK",
+			  "NFC_ESE_SPI_CS",
+			  "FP_INT_N", /* GPIO_40 */
+			  "NC",
+			  "FP_RESET_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "NFC_DWL_REQ",
+			  "NFC_IRQ",
+			  "FORCE_USB_BOOT",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "SBU_SW_OE", /* GPIO_50 */
+			  "SBU_SW_SEL",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "GNSS_ELNA_EN0",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_70 */
+			  "NC",
+			  "HAP_I2C_SDA",
+			  "HAP_I2C_SCL",
+			  "HAP_RST_N",
+			  "HAP_INT_N",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_80 */
+			  "HST_BT_EN",
+			  "HST_SW_CTRL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "HW_ID_0",
+			  "HW_ID_1", /* GPIO_90 */
+			  "USB_CC_DIR",
+			  "TRAY_DET",
+			  "SW_SERVICE",
+			  "PCIE0_RESET_N",
+			  "PCIE0_CLK_REQ_N",
+			  "PCIE0_WAKE_N",
+			  "OIS_ENABLE_WIDE",
+			  "DEBUG_GPIO0",
+			  "NC",
+			  "CAM_MCLK0", /* GPIO_100 */
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "NC",
+			  "NC",
+			  "TOF_RST_N",
+			  "CAM_SOF",
+			  "NC",
+			  "AFEXPTMG_TELE",
+			  "CCI_I2C0_SDA", /* GPIO_110 */
+			  "CCI_I2C0_SCL",
+			  "CCI_I2C1_SDA",
+			  "CCI_I2C1_SCL",
+			  "CCI_I2C2_SDA",
+			  "CCI_I2C2_SCL",
+			  "NC",
+			  "CAM2_RESET_N",
+			  "NC",
+			  "EXT_VD0_XVS",
+			  "CAM3_RESET_N", /* GPIO_120 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RF_ID_EXTENSION_2",
+			  "HAP_I2S_CLK",
+			  "HAP_I2S_DOUT",
+			  "HAP_TRG1",
+			  "HAP_I2S_SYNC",
+			  "UIM1_DATA", /* GPIO_130 */
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "TRAY_DET",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "SM_RFFE0_CLK",
+			  "SM_RFFE0_DATA",
+			  "SM_RFFE1_CLK", /* GPIO_140 */
+			  "SM_RFFE1_DATA",
+			  "SM_MSS_GRFC4",
+			  "HST_AS_EN",
+			  "LAA_RX_EN",
+			  "NC",
+			  "SM_RFFE4_CLK",
+			  "SM_RFFE4_DATA",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "RF_LCD_ID_EN", /* GPIO_150 */
+			  "RF_ID_EXTENSION",
+			  "SM_MSS_GRFC12",
+			  "NFC_COLD_RST",
+			  "NC",
+			  "NC",
+			  "SDR1_QLINK0_REQ",
+			  "SDR1_QLINK0_EN",
+			  "SDR1_QLINK0_WMSS_RESET_N",
+			  "QLINK1_REQ",
+			  "QLINK1_EN", /* GPIO_160 */
+			  "QLINK1_WMSS_RESET_N",
+			  "SDR2_QLINK2_REQ",
+			  "SDR2_QLINK2_EN",
+			  "SDR2_QLINK2_WMSS_RESET_N",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1", /* GPIO_170 */
+			  "SM_DMIC1_CLK",
+			  "SM_DMIC1_DATA",
+			  "SM_DMIC2_CLK",
+			  "SM_DMIC2_DATA",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "NC",
+			  "NC",
+			  "WCD_SWR_TX_DATA2",
+			  "SPK_AMP_I2S_ASP_DIN", /* GPIO_180 */
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "SPK_AMP_INT_N",
+			  "SPK_AMP_RESET_N",
+			  "HST_BT_WLAN_SLIMBUS_CLK",
+			  "HST_BT_WLAN_SLIMBUS_DAT0",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MAG_I2C_SDA", /* GPIO_190 */
+			  "MAG_I2C_SCL",
+			  "IMU_SPI_MISO",
+			  "IMU_SPI_MOSI",
+			  "IMU_SPI_CLK",
+			  "IMU_SPI_CS_N",
+			  "SENSOR_I2C_SDA",
+			  "SENSOR_I2C_SCL",
+			  "OIS_TELE_I2C_SDA",
+			  "OIS_TELE_I2C_SCL",
+			  "NC", /* GPIO_200 */
+			  "OIS_ENABLE_TELE",
+			  "HST_BLE_UART_TX",
+			  "HST_BLE_UART_RX",
+			  "HSTP_CLK_CFG_SEL",
+			  "NC",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "CCI_I2C3_SDA",
+			  "CCI_I2C3_SCL";
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
index 0d64d3c0afed..13c2fc4bccfc 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
@@ -19,3 +19,216 @@ imx563_vdig_vreg: imx563-vdig-regulator {
 		enable-active-high;
 	};
 };
+
+&tlmm {
+	gpio-line-names = "TELE_SPI_MISO", /* GPIO_0 */
+			  "TELE_SPI_MOSI", /* SONY says NC, but it only makes sense this way.. */
+			  "TELE_SPI_CLK",
+			  "TELE_SPI_CS_N",
+			  "WLC_I2C_SDA",
+			  "WLC_I2C_SCL",
+			  "NC",
+			  "PM8010_1_RESET_N",
+			  "WLC_INT_N",
+			  "NC",
+			  "NC", /* GPIO_10 */
+			  "NC",
+			  "DISP_ERR_FG",
+			  "HALL_INT_N",
+			  "ALS_PROX_INT_N",
+			  "IMU1_INT",
+			  "TS_I2C_SDA",
+			  "TS_I2C_SCL",
+			  "DISP_RESET_N",
+			  "DISP_VDDR_EN",
+			  "TS_RESET_N", /* GPIO_20 */
+			  "TS_INT_N",
+			  "UWIDEC_PWR_EN",
+			  "TELEC_PWR_EN",
+			  "CAM1_RESET_N",
+			  "LEO_CAM0_RESET_N",
+			  "DEBUG_UART_TX",
+			  "DEBUG_UART_RX",
+			  "FP_SPI_MISO",
+			  "FP_SPI_MOSI",
+			  "FP_SPI_CLK", /* GPIO_30 */
+			  "FP_SPI_CS_N",
+			  "NFC_I2C_SDA",
+			  "NFC_I2C_SCL",
+			  "NFC_EN",
+			  "NFC_CLK_REQ",
+			  "NFC_ESE_SPI_MISO",
+			  "NFC_ESE_SPI_MOSI",
+			  "NFC_ESE_SPI_CLK",
+			  "NFC_ESE_SPI_CS",
+			  "FP_INT_N", /* GPIO_40 */
+			  "NC",
+			  "FP_RESET_N",
+			  "WCD_RST_N",
+			  "NC",
+			  "NFC_DWL_REQ",
+			  "NFC_IRQ",
+			  "FORCE_USB_BOOT",
+			  "APPS_I2C_1_SDA",
+			  "APPS_I2C_1_SCL",
+			  "SBU_SW_OE", /* GPIO_50 */
+			  "SBU_SW_SEL",
+			  "SPK_AMP_I2C_SDA",
+			  "SPK_AMP_I2C_SCL",
+			  "NC",
+			  "NC",
+			  "CAMSENSOR_I2C_SDA",
+			  "CAMSENSOR_I2C_SCL",
+			  "GNSS_ELNA_EN0",
+			  "NC",
+			  "NC", /* GPIO_60 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RGBC_IR_INT",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC", /* GPIO_70 */
+			  "NC",
+			  "HAP_I2C_SDA",
+			  "HAP_I2C_SCL",
+			  "HAP_RST_N",
+			  "HAP_INT_N",
+			  "HST_BT_UART_CTS",
+			  "HST_BT_UART_RFR",
+			  "HST_BT_UART_TX",
+			  "HST_BT_UART_RX",
+			  "HST_WLAN_EN", /* GPIO_80 */
+			  "HST_BT_EN",
+			  "HST_SW_CTRL",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "DISP_VSYNC",
+			  "NC",
+			  "NC",
+			  "HW_ID_0",
+			  "HW_ID_1", /* GPIO_90 */
+			  "USB_CC_DIR",
+			  "TRAY_DET",
+			  "SW_SERVICE",
+			  "PCIE0_RESET_N",
+			  "PCIE0_CLK_REQ_N",
+			  "PCIE0_WAKE_N",
+			  "OIS_ENABLE_WIDE",
+			  "DEBUG_GPIO0",
+			  "NC",
+			  "CAM_MCLK0", /* GPIO_100 */
+			  "CAM_MCLK1",
+			  "CAM_MCLK2",
+			  "CAM_MCLK3",
+			  "NC",
+			  "NC",
+			  "NC", /* SONY didn't rename this, but there's no ToF so it's likely NC */
+			  "CAM_SOF",
+			  "NC",
+			  "AFEXPTMG_TELE",
+			  "CCI_I2C0_SDA", /* GPIO_110 */
+			  "CCI_I2C0_SCL",
+			  "CCI_I2C1_SDA",
+			  "CCI_I2C1_SCL",
+			  "CCI_I2C2_SDA",
+			  "CCI_I2C2_SCL",
+			  "NC",
+			  "CAM2_RESET_N",
+			  "NC",
+			  "EXT_VD0_XVS",
+			  "CAM3_RESET_N", /* GPIO_120 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "RF_ID_EXTENSION_2",
+			  "HAP_I2S_CLK",
+			  "HAP_I2S_DOUT",
+			  "HAP_TRG1",
+			  "HAP_I2S_SYNC",
+			  "UIM1_DATA", /* GPIO_130 */
+			  "UIM1_CLK",
+			  "UIM1_RESET",
+			  "TRAY_DET",
+			  "UIM2_DATA",
+			  "UIM2_CLK",
+			  "UIM2_RESET",
+			  "UIM2_PRESENT",
+			  "SM_RFFE0_CLK",
+			  "SM_RFFE0_DATA",
+			  "SM_RFFE1_CLK", /* GPIO_140 */
+			  "SM_RFFE1_DATA",
+			  "SM_MSS_GRFC4",
+			  "HST_AS_EN",
+			  "LAA_RX_EN",
+			  "NC",
+			  "SM_RFFE4_CLK",
+			  "SM_RFFE4_DATA",
+			  "WLAN_COEX_UART1_RX",
+			  "WLAN_COEX_UART1_TX",
+			  "RF_LCD_ID_EN", /* GPIO_150 */
+			  "RF_ID_EXTENSION",
+			  "SM_MSS_GRFC12",
+			  "NFC_COLD_RST",
+			  "NC",
+			  "NC",
+			  "SDR1_QLINK0_REQ",
+			  "SDR1_QLINK0_EN",
+			  "SDR1_QLINK0_WMSS_RESET_N",
+			  "NC",
+			  "NC", /* GPIO_160 */
+			  "NC",
+			  "SDR2_QLINK2_REQ",
+			  "SDR2_QLINK2_EN",
+			  "SDR2_QLINK2_WMSS_RESET_N",
+			  "WCD_SWR_TX_CLK",
+			  "WCD_SWR_TX_DATA0",
+			  "WCD_SWR_TX_DATA1",
+			  "WCD_SWR_RX_CLK",
+			  "WCD_SWR_RX_DATA0",
+			  "WCD_SWR_RX_DATA1", /* GPIO_170 */
+			  "SM_DMIC1_CLK",
+			  "SM_DMIC1_DATA",
+			  "SM_DMIC2_CLK",
+			  "SM_DMIC2_DATA",
+			  "SPK_AMP_I2S_CLK",
+			  "SPK_AMP_I2S_WS",
+			  "NC",
+			  "NC",
+			  "WCD_SWR_TX_DATA2",
+			  "SPK_AMP_I2S_ASP_DIN", /* GPIO_180 */
+			  "SPK_AMP_I2S_ASP_DOUT",
+			  "SPK_AMP_INT_N",
+			  "SPK_AMP_RESET_N",
+			  "HST_BT_WLAN_SLIMBUS_CLK",
+			  "HST_BT_WLAN_SLIMBUS_DAT0",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "MAG_I2C_SDA", /* GPIO_190 */
+			  "MAG_I2C_SCL",
+			  "IMU_SPI_MISO",
+			  "IMU_SPI_MOSI",
+			  "IMU_SPI_CLK",
+			  "IMU_SPI_CS_N",
+			  "SENSOR_I2C_SDA",
+			  "SENSOR_I2C_SCL",
+			  "OIS_TELE_I2C_SDA",
+			  "OIS_TELE_I2C_SCL",
+			  "NC", /* GPIO_200 */
+			  "OIS_ENABLE_TELE",
+			  "HST_BLE_UART_TX",
+			  "HST_BLE_UART_RX",
+			  "HSTP_CLK_CFG_SEL",
+			  "NC",
+			  "APPS_I2C_0_SDA",
+			  "APPS_I2C_0_SCL",
+			  "CCI_I2C3_SDA",
+			  "CCI_I2C3_SCL";
+};
-- 
2.38.1

