Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA709627ADB
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236345AbiKNKnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:43:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236333AbiKNKms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:42:48 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A81C1FCE0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:47 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id a29so18542023lfj.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nItdB8eAMelscjG++jq869kf8s0YiV/Dw6cuOez7lOk=;
        b=IvHcqfKhnZveNhejhcrkOLY3/IUVU7YVS62Qdr/0gXXMsHFRh2HS4OXPAPMdFgkN5I
         xWLMbFhtu8TP41RJuC0l6XNU5IYwOvHJYh7wVobbIKMsG1iWSAxZwlfJaKsIi0khZn7a
         r0ONVmBBKioW76jtjHKd6xO9WahfgR24xt2cSW/X7rwtDqh7icn5m6JFBQidcg0vWOP/
         QQDL2QtZxRSPCyKlUZeV64k4ryln+zX7el4tAqlpz06pd3eoFIfMzMBhIHoK4EqVkoRo
         5NhC328LQ74jUiaetfElmViTtZfHaLXLO/8LNoRt98qMzFSVZmL5oWipb75aOFtP4zey
         TvNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nItdB8eAMelscjG++jq869kf8s0YiV/Dw6cuOez7lOk=;
        b=oUgT7S56PhChMZmikOFkVHWw/vslmMD29UN22RWivvJnFLyZU/xCWmQ2In5or13CRC
         LtMIMfh+uF+1EdT7vVH3xvOzKZUCdw0bAacNB5JWxgrJFDRqLD/yHw+pTnhoDeeH1iJN
         oXT7SKkNm9mwjpvs5ApXknnAr0cPnsXx7Y0qmdFrIIXFftoaq1C4mtOJz2e0oEhFyi/i
         FCDBtmL8DX1K2QmAJM8qj7FmdOdQfV099+Wmlq5jlc2iSoXWxdw0LIKmEdeLkzYK62kw
         JGQQAe2D6c2F5rqZbCA8WN0TVPlCWi+BRKh/MpPqCCmthywNpSwsosB7Fm/lSp5HvVS7
         AonA==
X-Gm-Message-State: ANoB5plBVD+V+hSSlz6EvPhwv6KgHCuF667UBLx//EbK4Zvwqv02R7H4
        oDEKdQMZX1BbjAEIs1/l0PQnBQ==
X-Google-Smtp-Source: AA0mqf5iNmdaQzZztLQqFNo881nTgTNZbZNI9+KtHf1xoaF8oAlIWFaai+bWbqmsv7PwkjLyanux0A==
X-Received: by 2002:a05:6512:224d:b0:4a2:be5c:688f with SMTP id i13-20020a056512224d00b004a2be5c688fmr3605583lfu.121.1668422565886;
        Mon, 14 Nov 2022 02:42:45 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c4e922fb2sm1946486ljb.48.2022.11.14.02.42.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:42:45 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 9/9] arm64: dts: qcom: sm6375-pdx225: Configure Samsung touchscreen
Date:   Mon, 14 Nov 2022 11:42:22 +0100
Message-Id: <20221114104222.36329-10-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114104222.36329-1-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a pretty bog-standard-for-Xperias-for-the-past-3-years
touchscreen setup.

The OEM that built the Xperia 10 IV for SONY decided to use some
kind of a GPIO regulator that needs to be enabled at all times
for both the touch panel and the display panel to function.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
No changes since v1.

 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 0f1ddfa28c89..d18167bcb41f 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -81,6 +81,23 @@ &gpi_dma1 {
 	status = "okay";
 };
 
+&i2c8 {
+	clock-frequency = <400000>;
+	status = "okay";
+
+	touchscreen@48 {
+		compatible = "samsung,s6sy761";
+		reg = <0x48>;
+		interrupt-parent = <&tlmm>;
+		interrupts = <22 0x2008>;
+
+		vdd-supply = <&pm6125_l13>;
+
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_default &ts_avdd_default>;
+	};
+};
+
 &pmk8350_adc_tm {
 	status = "okay";
 };
@@ -290,6 +307,20 @@ pmr735a_l7: l7 {
 
 &tlmm {
 	gpio-reserved-ranges = <13 4>;
+
+	ts_int_default: ts-int-default-state {
+		pins = "gpio22";
+		function = "gpio";
+		drive-strength = <8>;
+		bias-pull-up;
+	};
+
+	ts_avdd_default: ts-avdd-default-state {
+		pins = "gpio59";
+		function = "gpio";
+		drive-strength = <8>;
+		output-high;
+	};
 };
 
 &usb_1 {
-- 
2.38.1

