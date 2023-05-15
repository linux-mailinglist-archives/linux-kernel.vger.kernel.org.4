Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723AE702D66
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:04:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242123AbjEONEh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242093AbjEONEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:04:31 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E91B419BA
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:28 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-4f24ddf514eso10890282e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684155867; x=1686747867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=froMVBkhiao5KfF7Z0DAyeGNQcRj1djapSOzel/BeiI=;
        b=UTgfb+pN1vt2XTPKYjGSrjBbDflYC9SLePW4nNvYfLJCzF6uZ8flJ2KKHpWKdnHi3J
         yN3xR5/r5I6DYLkJynIa0zTX10FTivNY0BkqtacNzD7/tZkZo5q13+kU+NHIQf6GxXNO
         r2nkdy7957B4LlEpd9J+vC/o2oZU0NH/5AS/jHvJl5nmJ3YcNfbp35VJNdXf4PMcPbt/
         5nsGYfnioYKEq246b8oCIKEoYV6HACcXbNkmsQYFY8T57mYYnqWuXLMv43LBdPBiGmDO
         eJ88ElaRiRtMb6wtIxngm+wpZNzh9thia3TI59MUhB2dmclof/I28vDHpHYoJXG4CXSL
         0uqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684155867; x=1686747867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=froMVBkhiao5KfF7Z0DAyeGNQcRj1djapSOzel/BeiI=;
        b=gXG5gyGTw6TjzYv1bBgpi8ddK/lU7033SMKRubOs0v/2QcDyavEAlG6VuMEK9eX08X
         bW70Cvs9Ak7puEwE2TD4pAA6IVHLVkIpiG8t0TqNknqWsumHr0x8c6wZHTS/G0gtX15Q
         tZhjhwrEu9DLuLKfHeYBFAe0Ui7mwjni0JMigewFUPN59GDs1ArZ7dIJcKu1qSNOyKmD
         ikkNCgqs0afYBSjj8+T++ga94iwnwckvW7H4KQ8g5i5NYrlchGJlSF3OyyBsVdK57ow3
         L2e7eWYGrCTNknlZH9d+L4xl3QsOgcwpopdvE+2y+fi9Ne/Bevih7tcAKpNHJPWTT9Gm
         6Bsg==
X-Gm-Message-State: AC+VfDygn/Mceskac676hKamyGLBFhBT3vdBhNFZ4C3dKwZcMYTxW8WH
        ZbZsUtk9wL217E0GKB5vqc51Gw==
X-Google-Smtp-Source: ACHHUZ5wGmFoVZqgFVjB9Wm7ewnQw7HjXRa9sG96Tj33yUU+bQ7tscGFpGKlrOe5/NMzIrgh2NaqjQ==
X-Received: by 2002:a05:6512:2181:b0:4e8:4a21:9c92 with SMTP id b1-20020a056512218100b004e84a219c92mr6447193lft.4.1684155867126;
        Mon, 15 May 2023 06:04:27 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id x27-20020ac25ddb000000b004f37a64c90asm785823lfq.303.2023.05.15.06.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 06:04:26 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 15 May 2023 15:04:12 +0200
Subject: [PATCH 1/5] arm64: dts: qcom: qrb4210-rb2: Describe fixed
 regulators
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230515-topic-rb2-bits-v1-1-a52d154a639d@linaro.org>
References: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
In-Reply-To: <20230515-topic-rb2-bits-v1-0-a52d154a639d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684155864; l=3058;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=GScLO8rtCKVnaqomkuQBjV5ndf+TerTFxlAHtwKZGT8=;
 b=m+UhjhC7gCcc0/ESEOtUDg6b5jWWuamr9Tb+sNQJh99qnPLNYchXIFGZPeIXYRBYja0LEUJho
 1dcF7U1ce5nDtpp8ka/lfEj+ibRfbf019F/5wF5fXaK4gq3AcYoHQeT
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board hosts a whole lot of fixed regulators. Describe them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 77 +++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
index 7843495b0076..80c6b59c8ff6 100644
--- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
+++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
@@ -19,11 +19,86 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
-	vph_pwr: vph-pwr-regulator {
+	vreg_hdmi_out_1p2: regulator-hdmi-out-1p2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VREG_HDMI_OUT_1P2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vdc_1v2>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	lt9611_3v3: regulator-lt9611-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "LT9611_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vdc_3v3>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* Main barrel jack input */
+	vdc_12v: regulator-vdc-12v {
+		compatible = "regulator-fixed";
+		regulator-name = "DC_12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 1.2V supply stepped down from the barrel jack input */
+	vdc_1v2: regulator-vdc-1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_1V2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		vin-supply = <&vdc_12v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 3.3V supply stepped down from the barrel jack input */
+	vdc_3v3: regulator-vdc-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_3V3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		vin-supply = <&vdc_12v>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* 5V supply stepped down from the barrel jack input */
+	vdc_5v: regulator-vdc-5v {
+		compatible = "regulator-fixed";
+		regulator-name = "VDC_5V";
+
+		regulator-min-microvolt = <5000000>;
+		regulator-max-microvolt = <5000000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* "Battery" voltage for the SoM, stepped down from the barrel jack input */
+	vdc_vbat_som: regulator-vdc-vbat {
+		compatible = "regulator-fixed";
+		regulator-name = "VBAT_SOM";
+		regulator-min-microvolt = <4200000>;
+		regulator-max-microvolt = <4200000>;
+		regulator-always-on;
+		regulator-boot-on;
+	};
+
+	/* PMI632 charger out, supplied by VBAT */
+	vph_pwr: regulator-vph-pwr {
 		compatible = "regulator-fixed";
 		regulator-name = "vph_pwr";
 		regulator-min-microvolt = <3700000>;
 		regulator-max-microvolt = <3700000>;
+		vin-supply = <&vdc_vbat_som>;
 
 		regulator-always-on;
 		regulator-boot-on;

-- 
2.40.1

