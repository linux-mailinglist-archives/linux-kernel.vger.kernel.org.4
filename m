Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046AC6229F4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:13:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiKILNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:13:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiKILNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:13:13 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1382A41A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:59 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id a67so26658398edf.12
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7ORdNvCZeW1eLAFgDoT00Z0MnsQHTXCI5a/39+Z9Rwg=;
        b=H+DqAPYQ+juP9L8EStGj6rtNPo+W1K7Y9V83bFMIe7nWZmoht8czm8SMlj9aisAmck
         C3uASnAdE3qgYNqg2/UWCBu4Yf3YSKrygbvAo9crUIxFD/xIf5aF7jl7guWQ7k1Y6fTq
         lP5vAyrR9rVC59uTchwPMy1lihErdHwMH1uZRLpNWDggMTLPfGce1KBVJowJl6PnmoOr
         RWYou4rosw1WZkGGnOMLo+TTOhNp+yuG2Ze53DgCLvadpKvKtkSqzl8dqeCtLkLA7ErJ
         SI3J35dq2UOEg71TFsPzwJ9iYy3+f/2mC7rquoe8boLZjAcZqpIFnsAi5DG4fox5TeVX
         6a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7ORdNvCZeW1eLAFgDoT00Z0MnsQHTXCI5a/39+Z9Rwg=;
        b=VG7wmWAtYu89/p/kUGR3qMgVBcXOgVlKjBq2t3hw2dGHrCLLUnGE9ZI/SMhDezmzED
         JG2VV34edzrqza0Nu0TOLDytjqnjidySaKupbOq/Hi4YBvO3ynqgS7WeAOONBSNB32We
         8zQ/UunyO4ztWWi7k1QDsiRFuIY29UK6vWeQuEieMFigmFioJczUca3TATCJ9j2uYFzS
         wtLCYOqqRrjig2JErHeNyNg16fXYQZuI4pgKxY2lhIKTraLjUv6m2AFN2jP1jGRXVOsY
         WBpk9wV9taptuwsgzR1Eq/9ic4uFP8TxTY33JYsKo1gYe3c7BCIsn/65MRXBdqk6xZpa
         CQpw==
X-Gm-Message-State: ACrzQf37GtHrSuWNpZqmKlz5nXNIZgkc5IfVj3W4IeaeucdSW6bC5CcI
        Ku1zRLu4Rlh0IXukhSuhZZ2cng==
X-Google-Smtp-Source: AMsMyM455QkPeaIE50OfnLrA6tvN0gkcUk54pjOM6YPFBWmAo9uMmusfVz+yHWHIVJAYWKBKtCyDDg==
X-Received: by 2002:a05:6402:1b01:b0:463:a54a:d551 with SMTP id by1-20020a0564021b0100b00463a54ad551mr44890196edb.428.1667992378115;
        Wed, 09 Nov 2022 03:12:58 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:57 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: dts: qcom: sm6375-pdx225: Configure Samsung touchscreen
Date:   Wed,  9 Nov 2022 12:12:35 +0100
Message-Id: <20221109111236.46003-11-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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
 .../qcom/sm6375-sony-xperia-murray-pdx225.dts | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
index 17094e588a3a..33083f18755b 100644
--- a/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
+++ b/arch/arm64/boot/dts/qcom/sm6375-sony-xperia-murray-pdx225.dts
@@ -78,6 +78,23 @@ &gpi_dma1 {
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
@@ -287,6 +304,20 @@ &qupv3_id_1 {
 
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

