Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BB9F6229DD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 12:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKILMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 06:12:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiKILMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 06:12:48 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9901327CEB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 03:12:47 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 21so26727503edv.3
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 03:12:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dw8yiTzUnE0/1jed/kvyGb1dCoZQTp6ZbqhV1sxsfZ0=;
        b=LgW7dKax1lUQHPezWxwMRSeDeHZcYqMQBQqKjPC55A582VnN+e75uJI772OUM4vS6A
         zf9WuuxvZUZ9YCXKczzJ4tNiiiZXrkaAjARV7vJfp80FasOdqBIqIRaCLavH07eQGFj9
         iIlBLdHzhkbGnrHkDVR+fE7/l3m4V+YSkRJdc2QOCip4Wjhf+LlfWEMhCaYqP9tjGL1i
         Uc57G1u09ZU+8s0WakgNHJ+I9azokFhmdQjx9yqO3yDpiOqT4BbfUp7FzWUvjlRVnjUl
         uxH55k5Cf7gpVa0/FLQsgx6mFFvxA+gUYTJIvvobMeJEK+H7sXBSWxfkM5IW1WuNzq6p
         Wncw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dw8yiTzUnE0/1jed/kvyGb1dCoZQTp6ZbqhV1sxsfZ0=;
        b=Ek4zG7dJKacgBz6Lx3ZeLG+8IQbZFp+a8sMeWFb25d05c1hJIsh72sSuaB8ou+4sqH
         41XU4+3Xb3uiZf59xlmZUQZmjwhnGYFkJICSHFQ6HJg3N+/2aZYJ6jax/epzYyVBQ/ig
         X/IHwm9jZeBiWBWKrK9vnvu1Ha/5Ewviq482etwgPnNMTfle1T9y3ESp5I90hoIMdw1D
         puVYoC1Z6Qg0G+CBzciw1fLc+rz1GPruIiNyu0EqBEfsHHD9r14hfJDwsWw14d+Nfvcs
         aSpxDetvj4k4jaS89JgtLGSweB8uf7RFBRNDIwnfYPScHCdV7TMojqpWpdpuHCtrXiqb
         8zww==
X-Gm-Message-State: ACrzQf1vf2Ddo5B9+Ne1+0Qk0NtAAd343pFFpMVevdCQ/HOU3q4IQ6WU
        i8q0hwKxrPEPQvwHZjIvRp4mSw==
X-Google-Smtp-Source: AMsMyM4AkeeOBGLFE9c17vhZZpE95yA+NmUlhsM0m0/uy0qQjk/oLXIWqskqcLe4+RlXjAkxr4ZVnA==
X-Received: by 2002:a50:c302:0:b0:463:26d6:25fb with SMTP id a2-20020a50c302000000b0046326d625fbmr55347903edb.204.1667992367157;
        Wed, 09 Nov 2022 03:12:47 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id k8-20020a1709062a4800b007ad9c826d75sm5825899eje.61.2022.11.09.03.12.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 09 Nov 2022 03:12:46 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/10] arm64: dts: qcom: Add a device tree for PMK8350 on SID6
Date:   Wed,  9 Nov 2022 12:12:28 +0100
Message-Id: <20221109111236.46003-4-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221109111236.46003-1-konrad.dybcio@linaro.org>
References: <20221109111236.46003-1-konrad.dybcio@linaro.org>
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
Add a DT with the SID changed to allow it to work.

Unfortunately, the entire DT needs to be copied even if the diff is
very little, as the node names are not unique. Including pm6125 and
pmk8350 together for example, would make pmk8350 overwrite the pm6125
node, as both are defined as 'pmic@0'.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi | 73 ++++++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi b/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
new file mode 100644
index 000000000000..00390f8b9c97
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pmk8350_sid6.dtsi
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/input/input.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmk8350: pmic@6 {
+		compatible = "qcom,pmk8350", "qcom,spmi-pmic";
+		reg = <0x6 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pmk8350_pon: pon@1300 {
+			compatible = "qcom,pm8998-pon";
+			reg = <0x1300>;
+
+			pon_pwrkey: pwrkey {
+				compatible = "qcom,pmk8350-pwrkey";
+				interrupts = <0x6 0x13 0x7 IRQ_TYPE_EDGE_BOTH>;
+				linux,code = <KEY_POWER>;
+				status = "disabled";
+			};
+
+			pon_resin: resin {
+				compatible = "qcom,pmk8350-resin";
+				interrupts = <0x6 0x13 0x6 IRQ_TYPE_EDGE_BOTH>;
+				status = "disabled";
+			};
+		};
+
+		pmk8350_vadc: adc@3100 {
+			compatible = "qcom,spmi-adc7";
+			reg = <0x3100>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			interrupts = <0x6 0x31 0x0 IRQ_TYPE_EDGE_RISING>;
+			#io-channel-cells = <1>;
+		};
+
+		pmk8350_adc_tm: adc-tm@3400 {
+			compatible = "qcom,adc-tm7";
+			reg = <0x3400>;
+			interrupts = <0x6 0x34 0x0 IRQ_TYPE_EDGE_RISING>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#thermal-sensor-cells = <1>;
+			status = "disabled";
+		};
+
+		pmk8350_rtc: rtc@6100 {
+			compatible = "qcom,pmk8350-rtc";
+			reg = <0x6100>, <0x6200>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x6 0x62 0x1 IRQ_TYPE_EDGE_RISING>;
+			status = "disabled";
+		};
+
+		pmk8350_gpios: gpio@b000 {
+			compatible = "qcom,pmk8350-gpio", "qcom,spmi-gpio";
+			reg = <0xb000>;
+			gpio-controller;
+			gpio-ranges = <&pmk8350_gpios 0 0 4>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.38.1

