Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E7A627AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 11:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236241AbiKNKmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 05:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236111AbiKNKmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 05:42:38 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682D81EADB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:37 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id l8so12559900ljh.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 02:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pefehE5o4ZbEpfgRDd+vWut5SWgW8/RYnVz1s2zWHXE=;
        b=uZuLqwtgmf+J1MWVvHIF9VmWJb6tLA0c/U0YPCM+7e/Uzfzb5lPasX+IC3yfp2iNKh
         uVtkvGdNj2j7jTGo+dI+dxfd8wpCOJXuSxYnZ8TGMs/oObT6unEB2szR5Zt9iuaXvcKO
         Y0y6cWkeUbTl/hSMoDgVU+QC+0OLIDR5o0J4I7jHRNgYSDo31yYydomF4DjwHxLmMw7G
         5aF0w6g8YhcbliXFeZ/CVEBdt57OAkXRW1tFbBjptCwMr5BQVzKuRjjazaZDFx5zvP/4
         74rLHZc6hiVV32ghjXANyOpaqURNX5Mba7WlDr+Zj+ArfBcX5phE+xtssV35aT/JTtnn
         UUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pefehE5o4ZbEpfgRDd+vWut5SWgW8/RYnVz1s2zWHXE=;
        b=NntiYb7qkZLDX/PhTxBqHPnR6qIwvX33Q8BbrBUKyCG3S3DG/aeUE1TGwdmX7lrE5P
         dGeO8xqMXnD66hIPbnE/GgVd2jzhdP7ZmVJLXFaXMCegATUgblaOabE5nxVJhMh+bFKh
         koku2v/PsucobTOWHn4mhTbelsraFKNb4DJf0oUWMvWpOZL09rcrt1alQlkVOj4ENL1v
         YNrcOXlJDM0dPrN7Ucd6IdKhuv3ZvqjftVh4CifhFS+kPRQEJkLrgNawlLGIf/rZYQRP
         noMs0TiQpwRORsIHLURHRz8CelX4HYhT8MDYmjzNmVsihoxW+70pFkZLPoQlvhzf3SfT
         ufUQ==
X-Gm-Message-State: ANoB5pncUlgq+Njh1B4M+DTV3Ziw2TZN1wiUAyqKXI/dzgZoNpNmeBo8
        Io0+X1YD3SAbZNDhsPw1qakFmA==
X-Google-Smtp-Source: AA0mqf7/mUQ/mfjgdPLxhttxA/2in9O16AdY2CR6UlT6O2LaPLs3Ls2ZD6tUWXwDycZWnL+CFHmV2A==
X-Received: by 2002:a05:651c:104e:b0:26f:bf09:2f57 with SMTP id x14-20020a05651c104e00b0026fbf092f57mr3642094ljm.180.1668422555818;
        Mon, 14 Nov 2022 02:42:35 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id bs21-20020a05651c195500b0026c4e922fb2sm1946486ljb.48.2022.11.14.02.42.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 14 Nov 2022 02:42:35 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/9] arm64: dts: qcom: pmk8350: Allow specifying arbitrary SID
Date:   Mon, 14 Nov 2022 11:42:15 +0100
Message-Id: <20221114104222.36329-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221114104222.36329-1-konrad.dybcio@linaro.org>
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
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

PMK8350 is shipped on SID6 with some SoCs, for example with SM6375.
Add some preprocessor logic to allow changing the SID in cases like
this.

While I am not in favour of adding #if's into the device tree, this
is the least messy way to handle this. If one isn't specified, it
will default to 0 (as it has been previously).

Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Changes since v1:
- take a different approach; patch substituted

 arch/arm64/boot/dts/qcom/pmk8350.dtsi | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pmk8350.dtsi b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
index a7ec9d11946d..2730d97ab213 100644
--- a/arch/arm64/boot/dts/qcom/pmk8350.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmk8350.dtsi
@@ -8,10 +8,15 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/* (Sadly) this PMIC can be configured to be at different SIDs */
+#ifndef PMK8350_SID
+	#define PMK8350_SID 0
+#endif
+
 &spmi_bus {
-	pmk8350: pmic@0 {
+	pmk8350: pmic@PMK8350_SID {
 		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
-		reg = <0x0 SPMI_USID>;
+		reg = <PMK8350_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
@@ -21,14 +26,14 @@ pmk8350_pon: pon@1300 {
 
 			pon_pwrkey: pwrkey {
 				compatible = "qcom,pmk8350-pwrkey";
-				interrupts = <0x0 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMK8350_SID 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
 				linux,code = <KEY_POWER>;
 				status = "disabled";
 			};
 
 			pon_resin: resin {
 				compatible = "qcom,pmk8350-resin";
-				interrupts = <0x0 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				interrupts = <PMK8350_SID 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
 				status = "disabled";
 			};
 		};
@@ -38,14 +43,14 @@ pmk8350_vadc: adc@3100 {
 			reg = <0x3100>;
 			#address-cells = <1>;
 			#size-cells = <0>;
-			interrupts = <0x0 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMK8350_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 			#io-channel-cells = <1>;
 		};
 
 		pmk8350_adc_tm: adc-tm@3400 {
 			compatible = "qcom,adc-tm7";
 			reg = <0x3400>;
-			interrupts = <0x0 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMK8350_SID 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#thermal-sensor-cells = <1>;
@@ -56,7 +61,7 @@ pmk8350_rtc: rtc@6100 {
 			compatible = "qcom,pmk8350-rtc";
 			reg = <0x6100>, <0x6200>;
 			reg-names = "rtc", "alarm";
-			interrupts = <0x0 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PMK8350_SID 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
 			status = "disabled";
 		};
 
-- 
2.38.1

