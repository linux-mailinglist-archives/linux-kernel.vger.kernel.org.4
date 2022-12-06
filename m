Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE4364444E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234448AbiLFNNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:13:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234409AbiLFNNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:13:31 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0E01A3B2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 05:13:25 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id ud5so6091799ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 05:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=YrpaHjwuDo4r0DOFwuwsECyHvnN/pZErxOwfbUQI5I8Ib1zoahU8Qno13NBen+P/KB
         k5JQRoUIOIjIG1UEDdRAXtJ3o2nl1SoNcUyGef6iZ6wWkvHG05cvaYRV357/hZic1Diu
         LsHvyZBG92aBGts2jXv+R2dDiuVJ1lrZ3sz6U2bo8sp+VH50HScTDvpDGYHJWwRO6EHv
         sCgcKy6NyMUfH0Fn4d62A1429mOvO4uxc357arTegrVfOa+Zn8mBLyoK+DfWwY0DeGut
         Jam5tQJZJ0iQqQmaZcvGCcxFg2fqBJq0vypfnyEeeIFrddP036Eop/xhVoJd7TUBmUkH
         FAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=GcvrXD8YM0FUv6FgfT/OgAIQm+divbuHDU03CAG/VR2u0SQE1zSxDu5F5kRwJ5Px86
         J4px1pcrwE/9NOpYdqzRagsYqpAWszsEZVWI/YnsvSElrTzq4r4BoD5YBkOL+Jru7NHR
         XPSYDOwJGvuirS2tsV1SmX1tfdAqCMK0itpyFBYq3txs2RSKOxgf5oLYsOZ43PMKuIW3
         AJmFiGD5kDzZFuApyOQ2LXubV8bkSHuJMKy5OnetsGjMNl/F4vHUkOZPKIsFMtkHpjNd
         JKw0WJ0ceu5iM0d8eVDvyIN05i/JB+wyYjJpk235YJwoeuKcCEkl8vhfwamHEBMjUjIH
         IxVw==
X-Gm-Message-State: ANoB5pl80BTbp8FZc0nFtgP7OPhsOdFd3VO7JoUPpjrlmx9B9BLI8hi+
        oQeGuNh14ZoJbuR59eQvJ27RvQ==
X-Google-Smtp-Source: AA0mqf63iltqML0x2pVQsXrHAR7YEA//oz9/L2AYQKAoQz2WbNhrERaoUHPl7YF228btXldruturDQ==
X-Received: by 2002:a17:907:76f2:b0:7c0:eb3c:1037 with SMTP id kg18-20020a17090776f200b007c0eb3c1037mr8561661ejc.663.1670332404074;
        Tue, 06 Dec 2022 05:13:24 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id u2-20020a1709061da200b007b8a8fc6674sm7345775ejh.12.2022.12.06.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 05:13:23 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v6 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Tue,  6 Dec 2022 15:12:48 +0200
Message-Id: <20221206131252.977369-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206131252.977369-1-abel.vesa@linaro.org>
References: <20221206131252.977369-1-abel.vesa@linaro.org>
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

From: Neil Armstrong <neil.armstrong@linaro.org>

Add nodes for PM8550ve in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550ve.dtsi | 59 ++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550ve.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550ve.dtsi b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
new file mode 100644
index 000000000000..c47646a467be
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550ve.dtsi
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
+		pm8550ve-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550ve_temp_alarm>;
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
+	pm8550ve: pmic@5 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x5 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550ve_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x5 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550ve_gpios: gpio@8800 {
+			compatible = "qcom,pm8550ve-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550ve_gpios 0 0 8>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

