Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24E069487B
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:46:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjBMOqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjBMOqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:46:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82BA91C303
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:46:33 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id sa10so32398605ejc.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 06:46:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WFfrceIf1t2XWsQlP6g7QsNsQTEjGCVtN3IyH9ltulo=;
        b=woKvrX1sGqxQx6Cbklg8tApJqk933IYZTDpF1a6UC5EWAzMm33IOcIqUXHCjtxA09y
         sAwKfHIGkVlmNlttz9k1nbmtt2eRA6A+5e5xi9ZlgxL/NX3Z80r4NK8IqUh7yjVd4Od2
         HBTPk37AvoGJtTCHk8a3/HgmpYCmREDEFYBXfcl77HDLJZUu0Q3Y52c6COplPayq8V7B
         oT4EqOGTL1J03rSJv1K8uCbQj6mjwFnUdDK930tzEN6uNorHVb9/gRci6G9Hmhbpq9PP
         vuUXRjhqURT3q4pGZyEv5HXpyPDSCJTLFypDegB/mm3a1D+HcB+enHJQMTaLQaEbvHP/
         FBxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WFfrceIf1t2XWsQlP6g7QsNsQTEjGCVtN3IyH9ltulo=;
        b=eYxfzTpUJVq7pMFCd2DAACFdE8lX9s9aLoo4hLBYZNvK2Fc8YhSgvEhzk6wNMh9GgY
         N43g6q2JYkhSgVG1TPde2om3Zgprr0hxxFxto8sg9dM8uZXtRJOg7ZIJ7GIcRv6cG/eZ
         pb5J3xLxCf+M5xwPHBgpGaIYyB3GVzfGh+en0zEG2tiDN1gGTTInb4cbUi+R8dPuLO1F
         ggkPqKX9BjBa40I/nhwQyusoc4CFZhNurVQWg4E6zEeOSSQ9KYTThg2Hm0hkNF5vIGM3
         wJdXX4sarYdjI3WwSy6xClsj3nE0RNq0+dcTum+81dZx7KT7yMt3HFAin+eK2LLaKG7w
         Tf1w==
X-Gm-Message-State: AO0yUKXP69IcIS78xxxpM1Web42SRFM9e/URasUhj1/KsgQbTm6Ubuf0
        tHnu0oDCLBWXy/KxPDN3ilcPrQ==
X-Google-Smtp-Source: AK7set8ADgoliwZ106ReYmNDSte1uMhXzntdImCMTGghdwpfO0opNzV0UP5PadwaDdDylPnWrBx2SQ==
X-Received: by 2002:a17:906:1d14:b0:88c:a43d:81bc with SMTP id n20-20020a1709061d1400b0088ca43d81bcmr22765588ejh.58.1676299592151;
        Mon, 13 Feb 2023 06:46:32 -0800 (PST)
Received: from [172.16.220.87] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id b19-20020a17090636d300b0085d6bfc6201sm6884208ejc.86.2023.02.13.06.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 06:46:31 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 13 Feb 2023 15:46:30 +0100
Subject: [PATCH v2 1/2] arm64: dts: qcom: sm7225-fairphone-fp4: move status
 property down
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230213-fp4-more-i2c-v2-1-1c459c572f80@fairphone.com>
References: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
In-Reply-To: <20230213-fp4-more-i2c-v2-0-1c459c572f80@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dts contains a mix of status-as-first-property (old qcom
style) and status-as-last-property (new style).

Move all status properties down to the bottom once and for all so that
the style is consistent between different nodes.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts | 34 +++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
index f7602e93121a..86114dd2c0c4 100644
--- a/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
+++ b/arch/arm64/boot/dts/qcom/sm7225-fairphone-fp4.dts
@@ -110,8 +110,8 @@ active-config0 {
 };
 
 &adsp {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/adsp.mdt";
+	status = "okay";
 };
 
 &apps_rsc {
@@ -355,13 +355,13 @@ &cci1_i2c0 {
 };
 
 &cdsp {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/cdsp.mdt";
+	status = "okay";
 };
 
 &i2c10 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
 
 	haptics@5a {
 		compatible = "awinic,aw8695";
@@ -396,8 +396,8 @@ &ipa {
 };
 
 &mpss {
-	status = "okay";
 	firmware-name = "qcom/sm7225/fairphone4/modem.mdt";
+	status = "okay";
 };
 
 &pm6150l_flash {
@@ -423,11 +423,11 @@ led-1 {
 };
 
 &pm6150l_wled {
-	status = "okay";
-
 	qcom,switching-freq = <800>;
 	qcom,current-limit-microamp = <20000>;
 	qcom,num-strings = <2>;
+
+	status = "okay";
 };
 
 &pm6350_gpios {
@@ -441,8 +441,8 @@ gpio_keys_pin: gpio-keys-state {
 };
 
 &pm6350_resin {
-	status = "okay";
 	linux,code = <KEY_VOLUMEDOWN>;
+	status = "okay";
 };
 
 &pm7250b_adc {
@@ -535,21 +535,21 @@ &uart9 {
 };
 
 &ufs_mem_hc {
-	status = "okay";
-
 	reset-gpios = <&tlmm 156 GPIO_ACTIVE_LOW>;
 
 	vcc-supply = <&vreg_l7e>;
 	vcc-max-microamp = <800000>;
 	vccq2-supply = <&vreg_l12a>;
 	vccq2-max-microamp = <800000>;
+
+	status = "okay";
 };
 
 &ufs_mem_phy {
-	status = "okay";
-
 	vdda-phy-supply = <&vreg_l18a>;
 	vdda-pll-supply = <&vreg_l22a>;
+
+	status = "okay";
 };
 
 &usb_1 {
@@ -562,26 +562,26 @@ &usb_1_dwc3 {
 };
 
 &usb_1_hsphy {
-	status = "okay";
-
 	vdd-supply = <&vreg_l18a>;
 	vdda-pll-supply = <&vreg_l2a>;
 	vdda-phy-dpdm-supply = <&vreg_l3a>;
+
+	status = "okay";
 };
 
 &usb_1_qmpphy {
-	status = "okay";
-
 	vdda-phy-supply = <&vreg_l22a>;
 	vdda-pll-supply = <&vreg_l16a>;
+
+	status = "okay";
 };
 
 &wifi {
-	status = "okay";
-
 	vdd-0.8-cx-mx-supply = <&vreg_l4a>;
 	vdd-1.8-xo-supply = <&vreg_l7a>;
 	vdd-1.3-rfa-supply = <&vreg_l2e>;
 	vdd-3.3-ch0-supply = <&vreg_l10e>;
 	vdd-3.3-ch1-supply = <&vreg_l11e>;
+
+	status = "okay";
 };

-- 
2.39.1

