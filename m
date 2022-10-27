Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8214C60F037
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 08:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbiJ0Ga6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 02:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234309AbiJ0Gan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 02:30:43 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D8A15F935
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:31 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id u6so430154plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 23:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ewp7WVPU21yPtwhSSVCjsPaCneME+6WwPEVVpVqunaw=;
        b=QKwnaVlmWSdqZH1nyo9MS5awPPgttmfmIPNBpqPSogH21caXuTdoLYqMgIr0qbylgD
         yyfWrIoi+X010DsOxnLxFllBfn9t+6Fq5bzAHh6xLmEfalaa8x/NHFNnpBT954WXMBgi
         l0tiSMAmgVAPhkPB4Y3wJKCcHM1rlnnjLnQT5KdCnWc58d6LJlCtz4fOEF/H2nZD141p
         EfZe/Aj4/aJR7sU2+aLQbYJVDopZVt7+hhcXtxdOT9ubOwAzPhS3/SKaT8M4HmjG4mrl
         cjgsFLVPzXu83DCO0+B8oitBWBLQ5psRtWpfyac3vOY4Gx6mPwdrDYKnRu63kDgV2XuQ
         3uqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ewp7WVPU21yPtwhSSVCjsPaCneME+6WwPEVVpVqunaw=;
        b=lIjCN85G3KlExL7prov+W+hk0DqVUK6kFgPzAzIMxkdxdDAkl0CUS2zdV95KAj53Bo
         9S1gqD3XaUmsR1KjCl3AjKO3hpeihDEW8g1a0JuD/s/vjAgdSm+Gq1gLz7hP3WRsicC/
         NBIiK+8Z1kV1ycAky//Xcuw2fAhU/e+Pw9/BFK5yoIfzkHbhfECqu7FrSSXufu98iFJ6
         o/T8wXSxhPE75VZOCwG/bA7+fCzNuNH7L8ley328OnF4A08VGcAQXrim9Ndl3KgJesf/
         sYvwjFMTk+0PES+XGHAfsbkCimqRx6TGUgOWIJBTp+UNJ+cCRCur28pvHwedvOeFp/o+
         Ql/Q==
X-Gm-Message-State: ACrzQf0FH8ZvnzJHCt5SNU/AKKQ0FDq1ptaJ7KYpH1icq1VsVVmFSj2A
        8ThHoCj8MWy4pH7ZjWukAdch
X-Google-Smtp-Source: AMsMyM6CftFsfShRPrtMvRCSSZ8ID1q8F3mI75KdHUpS59KEJ5+xKiWYrVHsyE+7Ikkuk8LEQPzsrg==
X-Received: by 2002:a17:90b:314b:b0:20d:a462:b996 with SMTP id ip11-20020a17090b314b00b0020da462b996mr8321768pjb.39.1666852231025;
        Wed, 26 Oct 2022 23:30:31 -0700 (PDT)
Received: from localhost.localdomain ([117.193.208.123])
        by smtp.gmail.com with ESMTPSA id i126-20020a626d84000000b00561d79f1064sm446041pfc.57.2022.10.26.23.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 23:30:30 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, johan+linaro@kernel.org,
        quic_jprakash@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 03/11] arm64: dts: qcom: sc8280xp-pmics: Add thermal zones for PM8280_{1/2} PMICs
Date:   Thu, 27 Oct 2022 11:59:58 +0530
Message-Id: <20221027063006.9056-4-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
References: <20221027063006.9056-1-manivannan.sadhasivam@linaro.org>
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

Add thermal zones for the PM8280_{1/2} PMICs by using the temperature
alarm blocks as the thermal sensors. Temperature trip points are
inheried from PM8350 PMIC.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 44 ++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
index 5de47b1434a4..397ff4995003 100644
--- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
@@ -7,6 +7,50 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/ {
+	thermal-zones {
+		pm8280_1_thermal: pm8280-1-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8280_1_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+
+		pm8280_2_thermal: pm8280-2-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+			thermal-sensors = <&pm8280_2_temp_alarm>;
+
+			trips {
+				trip0 {
+					temperature = <95000>;
+					hysteresis = <0>;
+					type = "passive";
+				};
+
+				trip1 {
+					temperature = <115000>;
+					hysteresis = <0>;
+					type = "critical";
+				};
+			};
+		};
+	};
+};
+
 &spmi_bus {
 	pmk8280: pmic@0 {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-- 
2.25.1

