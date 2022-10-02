Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF015F2329
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:30:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiJBMaE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:30:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJBM3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:29:51 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F5F26CA;
        Sun,  2 Oct 2022 05:29:45 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id d26so961431ljl.2;
        Sun, 02 Oct 2022 05:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=8eWUoCOV9OFPiTKwbMDBPdwIKQbitR/fBcjjdJ8WY6g=;
        b=FsYjqVnM1UcTFpv2E65WGF6reuMPfMzjJq20ABuEfNbRsEWvBDp871VCWUxZSfQO6G
         oQW4RLXw/x6Sf3s+t8GcLZfRQ0JLvgz/+Kf+AYB0cDgOvAoRxHbWFicYYVhIF6acvr2R
         DYWlAVOZV7wV2Kuhtd4rsI6TJshga2eTXoBXE/J3eDGKgFcTbCqN803gBqKWtsY8+DSH
         jxvbPVbzBvNAQ+SRKIZf7gDDG9RCWD/RCZMSVtqsqNRkRb8+kTfjdhwcatb9Aw8IUlml
         Vj7caAXx0/V4rEVyzhKjOFNc3dEZmdkeYajzUiASzhYSqJ5+4EjnyviFTqe1nqjQ8wsh
         r4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=8eWUoCOV9OFPiTKwbMDBPdwIKQbitR/fBcjjdJ8WY6g=;
        b=U9wIgXCTtL1dLPELJKA7Fu9RrzqG5KayW/R8Bw4GCH4b9umhSHUzfEgRdFJPgnMvrd
         bDSC+F5YaRjOh6gV1/e/r3rvfeoLKbY7IxoMGbBFdlUeGS2jsURetma8dExpxQTKJozr
         JQcH/dWGzTTbwdnfPFO6Yzy3icWIrMyMp+JXaDj7U+cHXqHwsFfaBvLsEtHOHR2RebHi
         DJWHufEcATa2n6hT2DAN7kmfNxjwd40QzPp1vQBAALNyHgZdVZx23sxToO2XUkwrtC0X
         Q8mufdfIrCH57QPTZQ3Mi3P3SyF0RQ/d/dyOi7JUwQUCcLOD3SpWeG6TssSyeaoIDpaV
         pv4A==
X-Gm-Message-State: ACrzQf3tgwV7ypgL7X+Hj1fDs78Pb9MJxzOI8wEwWMmB070MK0ByUjCM
        tN5g0tGWhxvJvaYvk81ILitKxUr1dUcacA==
X-Google-Smtp-Source: AMsMyM4UOsu0kDdMfepsatzyooypgRX3+Q6sT84h7MhzRVAMmjZsmVen7VJpatJ2S/fVHlF2RXhCHA==
X-Received: by 2002:a2e:90d5:0:b0:26d:d03a:c5c4 with SMTP id o21-20020a2e90d5000000b0026dd03ac5c4mr1093551ljg.133.1664713784036;
        Sun, 02 Oct 2022 05:29:44 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id v18-20020a197412000000b0049493c14b17sm1064948lfe.181.2022.10.02.05.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 05:29:43 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Luca Weiss <luca@z3ntu.xyz>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 6/6] ARM: dts: qcom: msm8974: Add CCI bus
Date:   Sun,  2 Oct 2022 15:28:58 +0300
Message-Id: <20221002122859.75525-7-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
References: <20221002122859.75525-1-matti.lehtimaki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luca Weiss <luca@z3ntu.xyz>

Add a node for the Camera Control Interface I2C bus found on MSM8974.

Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8974.dtsi | 66 +++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8974.dtsi b/arch/arm/boot/dts/qcom-msm8974.dtsi
index 7a9be0acf3f5..b89d56590448 100644
--- a/arch/arm/boot/dts/qcom-msm8974.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8974.dtsi
@@ -1463,6 +1463,38 @@ blsp2_i2c6_sleep: blsp2-i2c6-sleep {
 				bias-pull-up;
 			};
 
+			cci_default: cci-default-state {
+				cci_i2c0_default: cci-i2c0-default-pins {
+					pins = "gpio19", "gpio20";
+					function = "cci_i2c0";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cci_i2c1_default: cci-i2c1-default-pins {
+					pins = "gpio21", "gpio22";
+					function = "cci_i2c1";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
+			cci_sleep: cci-sleep-state {
+				cci_i2c0_sleep: cci-i2c0-sleep-pins {
+					pins = "gpio19", "gpio20";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+
+				cci_i2c1_sleep: cci-i2c1-sleep-pins {
+					pins = "gpio21", "gpio22";
+					function = "gpio";
+					drive-strength = <2>;
+					bias-disable;
+				};
+			};
+
 			spi8_default: spi8_default {
 				mosi {
 					pins = "gpio45";
@@ -1616,6 +1648,40 @@ dsi0_phy: dsi-phy@fd922a00 {
 			};
 		};
 
+		cci: cci@fda0c000 {
+			compatible = "qcom,msm8974-cci";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xfda0c000 0x1000>;
+			interrupts = <GIC_SPI 50 IRQ_TYPE_EDGE_RISING>;
+			clocks = <&mmcc CAMSS_TOP_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CCI_AHB_CLK>,
+				 <&mmcc CAMSS_CCI_CCI_CLK>;
+			clock-names = "camss_top_ahb",
+				      "cci_ahb",
+				      "cci";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&cci_default>;
+			pinctrl-1 = <&cci_sleep>;
+
+			status = "disabled";
+
+			cci_i2c0: i2c-bus@0 {
+				reg = <0>;
+				clock-frequency = <100000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+
+			cci_i2c1: i2c-bus@1 {
+				reg = <1>;
+				clock-frequency = <100000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gpu: adreno@fdb00000 {
 			compatible = "qcom,adreno-330.1", "qcom,adreno";
 			reg = <0xfdb00000 0x10000>;
-- 
2.34.1

