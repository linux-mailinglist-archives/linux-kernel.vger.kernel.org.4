Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C426C3D88
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 23:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjCUWNF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 18:13:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbjCUWMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 18:12:55 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328F3570B8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:12:52 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id q16so10147232lfe.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 15:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679436770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=13Zv1FUEwXx4yLngj7RFNjjKZHhiuq0qCRERwhQpaHM=;
        b=TVuYpJX2h2hgxrXCaQvHejEwvzDdasb9KPUcqB5a+pdXGkqtqaByqa3QRdPSRyYrC1
         yvH/dpUOZk3mt0XFCIEicnwR9snV7o3ElME2ErKL93QqZmBywIfyZxeshol3k3RBVKBa
         ZWGXn3pmJm+5XGoKFvH/JnrHBIHKQoN4vaYYKGniIDJxq2okgkoxLH4uYicHOgx331mV
         SOmApg7Vymy+iR8Q4EKrvV0+FcCwzFTUEUPPVwWr5ioCNbZubO3ffdDqXpV2UkHKpOGR
         kiB+Nh8qD7r0NXNGoW5cxb2mvihMkXHDMMsUu7F9br4Tj6TjfwZ/ycBXuJ3SSfJeGqA4
         qIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679436770;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=13Zv1FUEwXx4yLngj7RFNjjKZHhiuq0qCRERwhQpaHM=;
        b=3hz6CkrVsaAaYQTo2CQCO46qbHw31I3nDrTQ+l5Ee7+h/Bay1lqgZLTiHSwD17jR9g
         J7aS0KbyU+VHMj1FtRLCqaH/J3UzJsUvfBcbWuKGlHBpR6u3GflSvOn63CFLSiJhmPZA
         Jd4XJlBNQqkPHCLYKXN2U8XpwBsU7SLLVjsCXJPKz2ZyKuuS95fxTukCUbQYPVbf0gHo
         a+b33AtB2KeNJubyiqzVo8fz3SNhZuVNO8Ck+j1gOGYnNseCUczPiJxbuweSgZYZUo62
         oZEq2cAUXLQwDCsqj+9x4J0IFnyZsz9xl6fGCp+Mhu5LUODX0lgp34gqSv6d4rlUkEy2
         BQjA==
X-Gm-Message-State: AO0yUKVHIeTfOZT9mtlHbqsW7c50QR+p+aCbuCHPU/I+4lAyvL94+cTf
        c9bd2dDtwtxyl9qRWL+riZF4ew==
X-Google-Smtp-Source: AK7set/HbvRs2o8GvFlrB1PxbxWzkQeDfHexsDnns6zywGT0jmSu8t9oRMx+73W4owCg686i1/pKJg==
X-Received: by 2002:a05:6512:11e1:b0:4e9:6033:20d3 with SMTP id p1-20020a05651211e100b004e9603320d3mr1313142lfs.24.1679436770366;
        Tue, 21 Mar 2023 15:12:50 -0700 (PDT)
Received: from [192.168.1.101] (abym238.neoplus.adsl.tpnet.pl. [83.9.32.238])
        by smtp.gmail.com with ESMTPSA id o15-20020a056512050f00b004e9c983a007sm1220344lfb.289.2023.03.21.15.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 15:12:50 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 21 Mar 2023 23:12:31 +0100
Subject: [PATCH 4/4] arm64: dts: qcom: sm8350-nagara: Unify status property
 placement
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230321-topic-sagami_dp-v1-4-340c8bce4276@linaro.org>
References: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
In-Reply-To: <20230321-topic-sagami_dp-v1-0-340c8bce4276@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1679436764; l=3059;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=PVuMTdifNqJ5Z9yoopYhHdxk90HwveOlTjYOQjYaiCQ=;
 b=a/DZcv2drxELLeAnMNRTKju2/lidHG2b/fLv1uCpGms/QwtibA0s5OuDX897ZdRKlqSiUSqgwWF3
 etA5Tt2uDugI33oTmOXhkdCWx2vAtUeB8BBlDdvG6ULSUfDSBXxH
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we're heading towards getting the status property last everywhere,
take care of it for SM8350 SONY Sagami.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi   | 30 ++++++++++------------
 1 file changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
index b2baa81baf5e..95b1ba4ce470 100644
--- a/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8350-sony-xperia-sagami.dtsi
@@ -189,8 +189,8 @@ vph_pwr: vph-pwr-regulator {
 };
 
 &adsp {
-	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/adsp.mbn";
+	status = "okay";
 };
 
 &apps_rsc {
@@ -542,27 +542,27 @@ pmr735a_l7: ldo7 {
 };
 
 &cdsp {
-	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/cdsp.mbn";
+	status = "okay";
 };
 
 &i2c1 {
-	status = "okay";
 	clock-frequency = <1000000>;
+	status = "okay";
 
 	/* Some subset of SONY IMX663 camera sensor @ 38 */
 };
 
 &i2c4 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
 
 	/* Samsung Touchscreen (needs I2C GPI DMA) @ 48 */
 };
 
 &i2c11 {
-	status = "okay";
 	clock-frequency = <1000000>;
+	status = "okay";
 
 	cs35l41_l: speaker-amp@40 {
 		compatible = "cirrus,cs35l41";
@@ -596,31 +596,31 @@ cs35l41_r: speaker-amp@41 {
 };
 
 &i2c12 {
-	status = "okay";
 	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
 	clock-frequency = <100000>;
+	status = "okay";
 
 	/* AMS TCS3490 RGB+IR color sensor @ 72 */
 };
 
 &i2c13 {
-	status = "okay";
 	/* Clock frequency was not specified downstream, let's park it to 100 KHz */
 	clock-frequency = <100000>;
+	status = "okay";
 
 	/* Qualcomm PM8008i/PM8008j (?) @ 8, 9, c, d */
 };
 
 &i2c15 {
-	status = "okay";
 	clock-frequency = <400000>;
+	status = "okay";
 
 	/* NXP SN1X0 NFC @ 28 */
 };
 
 &i2c17 {
-	status = "okay";
 	clock-frequency = <1000000>;
+	status = "okay";
 
 	/* Cirrus Logic CS40L25A boosted haptics driver @ 40 */
 };
@@ -652,8 +652,8 @@ mdss_dp_altmode: endpoint {
 };
 
 &mpss {
-	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/modem.mbn";
+	status = "okay";
 };
 
 &pm8350_gpios {
@@ -719,8 +719,8 @@ &pon_pwrkey {
 };
 
 &pon_resin {
-	status = "okay";
 	linux,code = <KEY_VOLUMEUP>;
+	status = "okay";
 };
 
 &qupv3_id_0 {
@@ -748,8 +748,8 @@ &sdhc_2 {
 };
 
 &slpi {
-	status = "okay";
 	firmware-name = "qcom/sm8350/Sony/sagami/slpi.mbn";
+	status = "okay";
 };
 
 &spi14 {
@@ -1038,16 +1038,14 @@ usb_1_dwc3_ss: endpoint {
 };
 
 &usb_1_hsphy {
-	status = "okay";
-
 	vdda-pll-supply = <&pm8350_l5>;
 	vdda18-supply = <&pm8350c_l1>;
 	vdda33-supply = <&pm8350_l2>;
+	status = "okay";
 };
 
 &usb_1_qmpphy {
-	status = "okay";
-
 	vdda-phy-supply = <&pm8350_l6>;
 	vdda-pll-supply = <&pm8350_l1>;
+	status = "okay";
 };

-- 
2.40.0

