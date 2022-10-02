Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65965F232A
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbiJBMaI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 08:30:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiJBM3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 08:29:53 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB313EA0;
        Sun,  2 Oct 2022 05:29:43 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id g1so13088681lfu.12;
        Sun, 02 Oct 2022 05:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tSDcJlqQNFjQidf92tfYh99jD2wD2Br/7/lRU6P6wMg=;
        b=Dimv7vxPQZpWrJp/PddtVyf0puzE34C3348XRZbpYqHJIszjrYgI2cmTn+Qzlg63OI
         BMcZbLSzXQp+eZTY5LpBAfrv0dlDkifZetoRyZ6vJubGY+obEj5eb0qjWLm5dCmgzW9n
         w7RQTzvEuQFC/GiyfYGCGeRhDJi/UchnaHC5lLehBo45an2rkgnFKs3s5nr5++b0oVnl
         tZtrvZDYdA6jUbiv6AUvpLtgspsp+w0wsblVSQ8Qe9CZ3a0Oj2Zc1qWACx0i0qWmG4u+
         mEIG60P0fA5aNdYriOY0lJYJ5ERxCxKjfBvvQZBT75vG0CmfZh17KdqGih8Q+PKnkHHv
         EKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tSDcJlqQNFjQidf92tfYh99jD2wD2Br/7/lRU6P6wMg=;
        b=LLJ4+xY4Fa29i/qoh4GSMilAj6qQDGSFMF5hVW4LUqSJWBjqI32LUFA6gcK3lmwhRA
         p1tGLP2wJsP4fZQtFSKddMPJGFE+8/mL42y6FSfLceUYfXfNcblubxYT5rnFXj9sSqSQ
         V6vgI9jZAcNJVfSAbYMz9qpSx/ErejOMEE9kr2sDHjUFAoPy0OO7DDyEe2YagYu/0fxQ
         LbBUTod1Y3VdN0Fx6lnnY9kXTxoArPf+yVupQOGkicLLKMZnlDRCNRP+NVYr0aSQnpx8
         aOKaO8MA977A1GQB6BLO0ER3xjjDb6rdnJzZnQ3uZgpZpnHf/iUdt9A09X94Ik2FTGBU
         1MKg==
X-Gm-Message-State: ACrzQf1MgEi8REATJNRZjn+mFy0x98CX5Q8ukoQExk3jmUdsRAcw5AIV
        ki5sSOB7kD3IJcPy0FkTw9VtYmfCkn0dcw==
X-Google-Smtp-Source: AMsMyM4KWd3a64QztwV2L6NJ6Y/3q1iKGAJcM23lokj28JK5mZFg1ngDpgpFZ6yMmWoS7hOxyDYWZQ==
X-Received: by 2002:a05:6512:b8e:b0:497:fef2:80e2 with SMTP id b14-20020a0565120b8e00b00497fef280e2mr5462075lfv.257.1664713781677;
        Sun, 02 Oct 2022 05:29:41 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id v18-20020a197412000000b0049493c14b17sm1064948lfe.181.2022.10.02.05.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Oct 2022 05:29:41 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Rayyan Ansari <rayyan@ansari.sh>,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 5/6] ARM: dts: qcom: msm8226: Add CCI bus
Date:   Sun,  2 Oct 2022 15:28:57 +0300
Message-Id: <20221002122859.75525-6-matti.lehtimaki@gmail.com>
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

From: Rayyan Ansari <rayyan@ansari.sh>

Add a node for the Camera Control Interface I2C bus found on MSM8226.

Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
Signed-off-by: Matti Lehtimäki <matti.lehtimaki@gmail.com>
---
 arch/arm/boot/dts/qcom-msm8226.dtsi | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-msm8226.dtsi b/arch/arm/boot/dts/qcom-msm8226.dtsi
index e039128028bc..f5411e209d7b 100644
--- a/arch/arm/boot/dts/qcom-msm8226.dtsi
+++ b/arch/arm/boot/dts/qcom-msm8226.dtsi
@@ -7,6 +7,7 @@
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 #include <dt-bindings/clock/qcom,gcc-msm8974.h>
+#include <dt-bindings/clock/qcom,mmcc-msm8974.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/reset/qcom,gcc-msm8974.h>
@@ -298,6 +299,33 @@ blsp1_i2c5: i2c@f9927000 {
 			#size-cells = <0>;
 		};
 
+		cci: cci@fda0c000 {
+			compatible = "qcom,msm8226-cci";
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
+				clock-frequency = <400000>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		usb: usb@f9a55000 {
 			compatible = "qcom,ci-hdrc";
 			reg = <0xf9a55000 0x200>,
@@ -397,6 +425,22 @@ blsp1_i2c5_pins: blsp1-i2c5 {
 				bias-disable;
 			};
 
+			cci_default: cci-default-state {
+				pins = "gpio29", "gpio30";
+				function = "cci_i2c0";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+
+			cci_sleep: cci-sleep-state {
+				pins = "gpio29", "gpio30";
+				function = "gpio";
+
+				drive-strength = <2>;
+				bias-disable;
+			};
+
 			sdhc1_default_state: sdhc1-default-state {
 				clk {
 					pins = "sdc1_clk";
-- 
2.34.1

