Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AE4864BCD3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 20:11:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236759AbiLMTLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 14:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236698AbiLMTKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:10:46 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0470A25C68
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:43 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id y4so4348698ljc.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Dec 2022 11:10:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f9MORplhhfdi/jL2+RcflqsTy0dwAHC7rMffa/ngD80=;
        b=c46V/vZqZwivcFoi24votpdSH3QEBmnIV14/WlnWj1uZcMB4+FO2DyzoZZCW09mXH7
         rsisuLq0mcdPAcTZvPVRxATCiw7FtR2NVctUEWRMj6tePOXZizO8hbWtiaAYF4vzpERk
         mGN/OhpS9jFp78XT7hec5bJ1tslMhQR9xEwPRaeFboyvDeIPIhAFRwbCGBo1FYLJu9vB
         DpXJbeOJd5i23U7UJucXoYUDNso8w5qVqtdkh9dLX4CAVEi0yZx0eCzxWw6xQGpmWHwz
         /P/gzbaAqwEWTirj4Etm7METQDzstZsYVyRhDdiBKJKrZcJq6Y4v+szyLqFHT1JxSuGO
         H4LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f9MORplhhfdi/jL2+RcflqsTy0dwAHC7rMffa/ngD80=;
        b=wIOYq3EaezSuoK0ESqENU5cw/L0NkOyxcgzTSqDPKxC7xolYskSlMcvccBBSnuXztT
         QLsr97TVWcJ7biJWVKnqBSor4VytjC3Sxw6EtpCx/L5V1+kXKQy8C7aGC7bKqdc1z+ua
         vmtDqmInQsAfuTr8ZdI8LcaOYSUBa/7nFbZntr/eIfeIBC4I7EyV0S/JeRlyYUqhO2BS
         U1KVdUPDZNvnKRw2Su3JWMLoQnVPweYczkYDp2O2BQKWR45WK5MIqA5BShQDDBew7NIE
         BK7j3XcQ7LHSTA19B/it1ntTda11d4suDH6BI1lDW8fKokN6ZKxCDVsnJdKDDTDZuGUM
         pgJg==
X-Gm-Message-State: ANoB5pmveAVBxqeuRjD6JyVlGCtVl7SYMkTC+9jStsQSTBumDYxshnF0
        4hgH0uAkE8i4sKh/yaYZurXogA==
X-Google-Smtp-Source: AA0mqf4gtxPAKFzMevFm9WHRQUDf0dCnaJr9A4B0Q7nkeoS/deP5oT2isovmcALg1W687r53F8VwmQ==
X-Received: by 2002:a2e:b889:0:b0:278:fe64:12e8 with SMTP id r9-20020a2eb889000000b00278fe6412e8mr6805001ljp.38.1670958643565;
        Tue, 13 Dec 2022 11:10:43 -0800 (PST)
Received: from localhost.localdomain (abxh44.neoplus.adsl.tpnet.pl. [83.9.1.44])
        by smtp.gmail.com with ESMTPSA id w28-20020a05651c119c00b0026dfbdfc1ddsm372023ljo.11.2022.12.13.11.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 11:10:43 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Vinod Koul <vkoul@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] arm64: dts: qcom: sm8450-nagara: Add GPIO line names for PMIC GPIOs
Date:   Tue, 13 Dec 2022 20:10:32 +0100
Message-Id: <20221213191036.611241-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221213191036.611241-1-konrad.dybcio@linaro.org>
References: <20221213191036.611241-1-konrad.dybcio@linaro.org>
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

Add these to the PDX223&224 DTSIs to better document the hardware.

Diff between 223 and 224:
pm8350b
< 			  "CAM_PWR_LD_EN",
> 			  "NC",

pm8350c
<			  "RGBC_IR_PWR_EN",
> 			  "NC",

Which is due to different camera power wiring on 223 and lack of a
ToF sensor on 224.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../qcom/sm8450-sony-xperia-nagara-pdx223.dts | 23 ++++++++++++++++
 .../qcom/sm8450-sony-xperia-nagara-pdx224.dts | 23 ++++++++++++++++
 .../dts/qcom/sm8450-sony-xperia-nagara.dtsi   | 27 +++++++++++++++++++
 3 files changed, 73 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
index b83500316a81..561cd4f09ab7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx223.dts
@@ -13,6 +13,29 @@ / {
 	compatible = "sony,pdx223", "qcom,sm8450";
 };
 
+&pm8350b_gpios {
+	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SNAPSHOT_N",
+			  "CAM_PWR_LD_EN",
+			  "NC",
+			  "FOCUS_N";
+};
+
+&pm8350c_gpios {
+	gpio-line-names = "FL_STROBE_TRIG_WIDE", /* GPIO_1 */
+			  "FL_STROBE_TRIG_TELE",
+			  "WLC_ID",
+			  "WLC_TXPWR_EN",
+			  "NC",
+			  "RGBC_IR_PWR_EN",
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
+
 &tlmm {
 	gpio-line-names = "NC", /* GPIO_0 */
 			  "NC",
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
index 13c2fc4bccfc..fc9d74d0f227 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara-pdx224.dts
@@ -20,6 +20,29 @@ imx563_vdig_vreg: imx563-vdig-regulator {
 	};
 };
 
+&pm8350b_gpios {
+	gpio-line-names = "CAM_PWR_A_CS", /* GPIO_1 */
+			  "NC",
+			  "NC",
+			  "NC",
+			  "SNAPSHOT_N",
+			  "NC",
+			  "NC",
+			  "FOCUS_N";
+};
+
+&pm8350c_gpios {
+	gpio-line-names = "FL_STROBE_TRIG_WIDE", /* GPIO_1 */
+			  "FL_STROBE_TRIG_TELE",
+			  "WLC_ID",
+			  "WLC_TXPWR_EN",
+			  "NC",
+			  "NC", /* RGBCIR uses a PMIC vreg, so it's most likely NC. */
+			  "NC",
+			  "NC",
+			  "WIDEC_PWR_EN";
+};
+
 &tlmm {
 	gpio-line-names = "TELE_SPI_MISO", /* GPIO_0 */
 			  "TELE_SPI_MOSI", /* SONY says NC, but it only makes sense this way.. */
diff --git a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
index e29fb7adc780..8e128efcb128 100644
--- a/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450-sony-xperia-nagara.dtsi
@@ -551,6 +551,33 @@ &pcie0_phy {
 	status = "okay";
 };
 
+&pm8350_gpios {
+	gpio-line-names = "ASSIGN1_THERM", /* GPIO_1 */
+			  "LCD_ID",
+			  "SDR_MMW_THERM",
+			  "RF_ID",
+			  "NC",
+			  "VOL_DOWN_N",
+			  "NC",
+			  "NC",
+			  "NC",
+			  "PM8350_OPTION"; /* GPIO_10 */
+};
+
+&pm8450_gpios {
+	gpio-line-names = "FP_LDO_EN", /* GPIO_1 */
+			  "",
+			  "",
+			  "";
+};
+
+&pmk8350_gpios {
+	gpio-line-names = "NC", /* GPIO_1 */
+			  "NC",
+			  "DISP_THERM",
+			  "PMK8350_OPTION";
+};
+
 &remoteproc_adsp {
 	firmware-name = "qcom/sm8350/Sony/nagara/adsp.mbn";
 	status = "okay";
-- 
2.39.0

