Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADAD9643908
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 00:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbiLEXE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 18:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234090AbiLEXEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 18:04:11 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421A012AB5
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 15:04:10 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id gu23so2038463ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 15:04:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=dm6gAjyq+jWBbmyn8sCR1T8SM/dA2ONJ2C0Gu+DQxcXX5YiCcyDDRsKEFZOSSrV1fw
         PYDDYThxg64rpHj17CscKXJt/Veu/fnr1ejsMkTde+WjAJnsgTcsv4uQ3+KLWWVayduf
         DLANtD5BeygvR7AID2co2mX+KjIaGNDKNfZHdEwR3MbAv9eJ61QoeTbaGyMJxtZjZmNr
         1VvVjsVJQlhr6NQ0yG9m3IGcAmWcspQSqbG8j6gNZcCk4Nt1Q61S+J2Oc693NLr5daiq
         S2VJmf4V9d6MWJVL0Gn5/U5ChwhsTltPXkIyStxgR1drorOQwJxNEnDiu3wHkNt69DW+
         zhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=Q5eRg6rDRvqwaNJ7FTQu7rQY8JwhjCSkZofZSjGXLo/DMUak3TngM21RyJdnY00qQD
         +FwMXcpeTwHtJ+epOT9HoFzOewQ42TH4mKUfRP5qcxVDi+tzvEvJY782Lrw90JJ5SC/a
         TcPXwvRzSdoPmPG9ncVlW7ODpmwcYD17vMn5hntROCqJ/wkLB4TmMgNDsDf1gMvIl1OE
         P3s/YCPg8yu3sob17G1RT4P1GHsLXwp0nw9nEYTNj4nJs8VX6lyBBXAvEuVE2rcsQPZP
         YCRk5Pc2NZwHYW3JQhtAiiIexapBiYwc0VyIsPYiLbcc++VzCakwlp9IPkk2jd4FAOhy
         +hZw==
X-Gm-Message-State: ANoB5pn8A7nKrGpyHdfx1wHsRMe9z0OnmqVS+LFt0PIQ6FZU93xtizyh
        xzFW87wBvnHyCJAoTRiIoaKQYg==
X-Google-Smtp-Source: AA0mqf62uIHp9OaWCRL6vrWdeTCv6sEP5Wb0Uwvzn/Yk89viB3hWQAQOvPy6dyA02SerydSGWRGG2w==
X-Received: by 2002:a17:906:f896:b0:7bb:cdd8:94e7 with SMTP id lg22-20020a170906f89600b007bbcdd894e7mr43075353ejb.369.1670281448794;
        Mon, 05 Dec 2022 15:04:08 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id kw26-20020a170907771a00b00783f32d7eaesm6655642ejc.164.2022.12.05.15.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 15:04:08 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v5 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Tue,  6 Dec 2022 01:03:37 +0200
Message-Id: <20221205230342.494923-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221205230342.494923-1-abel.vesa@linaro.org>
References: <20221205230342.494923-1-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for PM8550b in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550b.dtsi | 59 +++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550b.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550b.dtsi b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
new file mode 100644
index 000000000000..16bcfb64d735
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550b.dtsi
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2022, Linaro Limited
+ */
+
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/spmi/spmi.h>
+
+/ {
+	thermal-zones {
+		pm8550b-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550b_temp_alarm>;
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
+					type = "hot";
+				};
+			};
+		};
+	};
+};
+
+
+&spmi_bus {
+	pm8550b: pmic@7 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x7 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550b_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x7 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550b_gpios: gpio@8800 {
+			compatible = "qcom,pm8550b-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550b_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

