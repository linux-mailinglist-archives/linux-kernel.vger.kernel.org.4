Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8141B644F36
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiLFXBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiLFXBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:15 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE304A58D
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:12 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id bj12so9893696ejb.13
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=h9vj09fflZ4nmC1CFfoFNSlxFAqHvl5GNF1UKQ/yE4OJ3QrK6otEKkyVIm2IInInkp
         HB1TJnetE9jEswXwnjvPnlFNYWuKRNlJ4mLDyg4NyrNJ6lxuO8Xlb3fIQqbWaNyDTt85
         ybp8qcnDPNF+WxsKgU7yiTCcSdha0UHQQ0wm2h28JramW9ZNwo7KK82rkDoF7PB97C8E
         wWbLs3MZiiak0buc6Aw6i4pQ8c4RO+qAL+VhVuwLscOoZp0hhh1iCFEAwVtWUJszYuxP
         YcBpr7jDUV8Ic5DpHnChrFs1wQwDLfRN/PqceDSH2oXYgIGBqFmjmr78RRGdVGhU48Ir
         +WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=5EYYplmPHdyPt0lole5azJhtBYFVY11aQpztTSUxgaCNQVxF+k0BYHM5EOI2TtQ0Sy
         9QCnkDUmAy+x+KynG1Mb4VLQAVVxUG33g/DddAbTVUm1NnqZG4CBH25iTZpSfgsMWGbx
         yjkcUMxg+VZgNbcPyw5UHecMYQekdJ+Y7xcj665b3C4LP9nrcqQ0ZdM4FYMD/Yndz+YF
         RcGiQT7opQxJxdpDtPmxberDAr6+rKakVMe308fVY9RBCsVcsy6XvjQN1NPQRosOO7P4
         uZMl8HRWQaErvZXkUdnNo2YrZAnjxR4DaKH8HDM32lsDOZ5vcUFNNs5oT+Ek+tYJInaZ
         qRuA==
X-Gm-Message-State: ANoB5pkNGGUKxsvEWpTtPYzNI5OKJsNfutZszDHQq349Q2W9v0tGmxbo
        jpCZ8aQI8vSCnM1oE6m9zoRKWQ==
X-Google-Smtp-Source: AA0mqf7oLLI6nrpRw2MZ5OEAvOEUWaYcyBQezRf7WNbKLZAnVfT0LUyFC8dOqhS50xLJ/31BDVbtew==
X-Received: by 2002:a17:906:a084:b0:7bd:f57f:76a4 with SMTP id q4-20020a170906a08400b007bdf57f76a4mr38909541ejy.413.1670367671568;
        Tue, 06 Dec 2022 15:01:11 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:11 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Wed,  7 Dec 2022 01:00:57 +0200
Message-Id: <20221206230102.1521053-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206230102.1521053-1-abel.vesa@linaro.org>
References: <20221206230102.1521053-1-abel.vesa@linaro.org>
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

