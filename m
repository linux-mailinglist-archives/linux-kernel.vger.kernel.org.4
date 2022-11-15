Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0A629D5B
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbiKOP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237725AbiKOP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:27:43 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA612D76A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:40 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id y14so36912692ejd.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IypuJ/Pof2USoK7b4/Atk2DRjHrF23U2plR6w47C7ao=;
        b=ito5/jloRWFJ99jHqzlUSB4dBZpMQRiX+Vmb2DRhO1mWYaBAQEtz+7NntJX+Jan9PH
         Atnwdz311XrxObo9JVDE+jxVAMcBgJcl1wmVk2ob3hGKKWOIEU17e4FaVriDc3CLmREn
         ta/KKE/wRx5PuWIqFfrU1IFuFxHwcnBj5QOmRZXuqmNb9ag6pu23wkvs3zGqVf2/8I2d
         SEyqFklKn0qZDPmmVta7XKisPbu4bcOJK7VKRDBZTxso1Krtk//SocgRlFAjH+ISWxKM
         t9XH5TB0bvWdQqzSXMBBql44J1oUnVZjuVilEsk2ce0GmK7wYFQtYT/ire9Oq97kOk2m
         +rcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IypuJ/Pof2USoK7b4/Atk2DRjHrF23U2plR6w47C7ao=;
        b=wQIF/gH1sPPbqV1tOE/eT1FfvxNX8A+Wpy1Ag7mE2GV1aqnFLBTcgJ3e1L45JRcT+u
         rjG6wa5Fpq2brjS/z/y24vPn+XvGZLEuuXKHNwhyofzhPTDyRGRocFlsV4MXvMlFOsq2
         6dgUIJDE+SeHG/+wekl6qK1ZU0EW/lxq/agcqW4iNMkMxb0fb7u426pVCLkyJm6LVOa4
         zS1bTKEPyw/KDgldUjqaeyavyjo5qWf1DuHOaMPdED045RclucvW4J8LqL/QRyFB996Y
         iY3t0TgLY5BvKXXCq6w8+jF9AV4auR5yYiBrRz8OwFFJaNDdT6iJa9Lv7bWfgNOb5gqC
         7bBA==
X-Gm-Message-State: ANoB5plcrnX3lKDdCO7rSJoJnXuRcZdxJkoiwXVhYjxsgYyn/HIi837k
        pO/kE9OddVwMwMM3xrlpvkFHng==
X-Google-Smtp-Source: AA0mqf50V2PfNgzViLP2mKi1jL47BCBMB63T0Ng5UlgIw+DgCsgLNzx1P9I0TusUJoS3nHavcUpnFg==
X-Received: by 2002:a17:906:1441:b0:7ad:b97e:283a with SMTP id q1-20020a170906144100b007adb97e283amr13913029ejc.567.1668526060270;
        Tue, 15 Nov 2022 07:27:40 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:39 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/9] arm64: dts: qcom: pmk8350: Allow specifying arbitrary SID
Date:   Tue, 15 Nov 2022 16:27:20 +0100
Message-Id: <20221115152727.9736-3-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115152727.9736-1-konrad.dybcio@linaro.org>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
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

