Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F15A06DA981
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 09:46:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237539AbjDGHqX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 03:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbjDGHqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 03:46:17 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A956EAD08
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 00:46:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id g18so6713305ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 00:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1680853573; x=1683445573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZU4QEaEraDl+k3WFZpoXH7Xf2Al7n2chAXs2OYDEB0A=;
        b=ft2ENGrY7IVU28h6GHwi9x6b6eum3G3wxe0Oo+4GY9MhdcnmQbqEl2ZGIW8Pmo8x8k
         BmwwbhFkH3StlX8MACPiWB1XZROZYCCUpknXyVZN0dE2YQcNPYE5w9H6wGIjYOvxD4Gj
         WAqptG84nsR+yy75WZmX7UftkYVhnQHBs4DHRK0YIIevO03ifG39ss11tf/g+rWKTNJu
         //gps2LFQKrf64hehcaydwnPThDoGSlJhs34GrdJ+yfqbeD10Qo/ArULBIyvU+8wvQ8e
         S2pF7khjDHT9hCT9kWPnTss/RyAjA5O0eS9hb7T6TuDc7gCm44DodLmZYSkEzE4sjkg7
         lyRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680853573; x=1683445573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZU4QEaEraDl+k3WFZpoXH7Xf2Al7n2chAXs2OYDEB0A=;
        b=3sGxE/EvLu51FH3oSYjC1SA+Fj9+t1FP+XuroqhqGKvlQrel7PO6wD1aLFCFlPGHjM
         sC+KOH/tDbTRUVfZQsdEcXrpk85jHofrRfPmtCwPur6KdrD+rr+Hc3HEU4z4+B/CEbQS
         XlgRAALyaBGULY5x8KbJie4wZbIzAokeyqh6y7eFxu3qE+J3aHPFrzlG8pXLw5i6NID6
         Wrk5W9avdXSju1Hr1BrnP9SiopK3mH5z+PNkAsDiTiIHeWcANkZ3nevbUOHMQcJBJJ1r
         2Jc7wfAwRePpev+b25SOQ2p9zlPlnlJ1Y0mKBqVQu2Njnwklxeq84NWtQo0ysCLYRwi4
         RaVQ==
X-Gm-Message-State: AAQBX9eZ1wv0v5er5AZ+sv4adYfKvTAwt+LtFaHBjGFIiblQzSVpGw9r
        eKX8fIA210MrMCWw0ZONqOyI3g==
X-Google-Smtp-Source: AKy350ZYfQHwG3ayXnnoaraMlwZm4Ddqc0MxjgbAQxHwZ8cjpPXh21em52DJJjc+SRfdjp4O3YIw1Q==
X-Received: by 2002:a17:907:a413:b0:91d:9745:407a with SMTP id sg19-20020a170907a41300b0091d9745407amr9851386ejc.14.1680853573270;
        Fri, 07 Apr 2023 00:46:13 -0700 (PDT)
Received: from [172.16.220.24] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id sa28-20020a1709076d1c00b00949c04d1c64sm1762378ejc.41.2023.04.07.00.46.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Apr 2023 00:46:12 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 07 Apr 2023 09:45:45 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: pm7250b: make SID configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230407-pm7250b-sid-v1-2-fc648478cc25@fairphone.com>
References: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
In-Reply-To: <20230407-pm7250b-sid-v1-0-fc648478cc25@fairphone.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like other Qualcomm PMICs the PM7250B can be used on different addresses
on the SPMI bus. Use similar defines like the PMK8350 to make this
possible.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/pm7250b.dtsi | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/pm7250b.dtsi b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
index daa6f1d30efa..eeb476edc79a 100644
--- a/arch/arm64/boot/dts/qcom/pm7250b.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm7250b.dtsi
@@ -7,6 +7,15 @@
 #include <dt-bindings/interrupt-controller/irq.h>
 #include <dt-bindings/spmi/spmi.h>
 
+/* This PMIC can be configured to be at different SIDs */
+#ifndef PM7250B_SID
+	#define PM7250B_SID 2
+#endif
+
+#ifndef PM7250B_SID1
+	#define PM7250B_SID1 3
+#endif
+
 / {
 	thermal-zones {
 		pm7250b-thermal {
@@ -39,16 +48,16 @@ trip2 {
 };
 
 &spmi_bus {
-	pmic@2 {
+	pmic@PM7250B_SID {
 		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
-		reg = <0x2 SPMI_USID>;
+		reg = <PM7250B_SID SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 
 		pm7250b_temp: temp-alarm@2400 {
 			compatible = "qcom,spmi-temp-alarm";
 			reg = <0x2400>;
-			interrupts = <0x2 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
+			interrupts = <PM7250B_SID 0x24 0x0 IRQ_TYPE_EDGE_BOTH>;
 			io-channels = <&pm7250b_adc ADC5_DIE_TEMP>;
 			io-channel-names = "thermal";
 			#thermal-sensor-cells = <0>;
@@ -60,7 +69,7 @@ pm7250b_adc: adc@3100 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			#io-channel-cells = <1>;
-			interrupts = <0x2 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PM7250B_SID 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
 
 			adc-chan@0 {
 				reg = <ADC5_REF_GND>;
@@ -141,7 +150,7 @@ adc-chan@99 {
 		pm7250b_adc_tm: adc-tm@3500 {
 			compatible = "qcom,spmi-adc-tm5";
 			reg = <0x3500>;
-			interrupts = <0x2 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
+			interrupts = <PM7250B_SID 0x35 0x0 IRQ_TYPE_EDGE_RISING>;
 			#thermal-sensor-cells = <1>;
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -149,9 +158,9 @@ pm7250b_adc_tm: adc-tm@3500 {
 		};
 	};
 
-	pmic@3 {
+	pmic@PM7250B_SID1 {
 		compatible = "qcom,pm7250b", "qcom,spmi-pmic";
-		reg = <0x3 SPMI_USID>;
+		reg = <PM7250B_SID1 SPMI_USID>;
 		#address-cells = <1>;
 		#size-cells = <0>;
 	};

-- 
2.40.0

