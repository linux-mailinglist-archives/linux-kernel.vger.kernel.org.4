Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA62D644F39
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 00:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbiLFXBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 18:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiLFXBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 18:01:24 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768154A5A5
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 15:01:14 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id gh17so9949894ejb.6
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 15:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=IzXgGyW6CjFpY0TCNOOu4R4uma4O6afb5qYm0dt8JJrZN1lGfpOkB0mrehfSvFbBr1
         Cer7UsRQbWTwBhIlZ2gLbzLOTdvxewupLPtPJ3M5xDc2Nsp3A663fvLOSJqXEOgIte9g
         0lKRco7eEbtELrdgdMpm0tnnKPF3ty3NnFiLk1ApfPrfxng/4mAwJU93TGEsDy2dF2To
         duunu3RLhRh/ofCy7F/pP7f0lgWnbFmHF9fBcAAGRA8J5MAKY2nXhf3sQyJgRxpkUmnJ
         cgPkVLmMNMHcR71Qg/xFJjJZCuAtUVVD9ezBe0RaXA3qu9AbgM/7XmzHdSxBwjx/+BDA
         iIWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2GBkrjGOYCG/vFk7NUYRuiiITSa0YV9dEfizXvTyQ5c=;
        b=B+bkHPiIMp4RLCBGsV5LKJG+Mo7xxz26i5g9H6oV0daU7jxAhv8SyHb0vtV8C6FdNT
         VztjlTm+qrxIssjAlkLIacpZp55ivLe2umIqec0u1QtSYPJdUtoThtCHsqKT9cm8znPq
         6e9UAZ2UKBQ8C/p1vcNOGCERTAFnbegNFsbeIuWetVm2ADTB5OpmCsBhIjr93o6qVh2y
         zxLg80KR4JLSRXd72NHWSncUvo73xfrB2OjCb4PyRMEGPmXj5BB0kL73pL3G2Tl4PA/I
         S9RL762ktUEa7+l3BNl6dHpGejT2ahbGJcZEjXar6jDYnWcSdU7zHdxaadwPYQuIG5oj
         PwYg==
X-Gm-Message-State: ANoB5plyElMF4tzyz8yKonv1WZVNpW93DxzZWGZKjHAP9tgX9vI2S6ky
        y5KJ0et0foBb5kRq9wS+TtvSew==
X-Google-Smtp-Source: AA0mqf6B6V0oKPMpHtAPl8wI4TSEAAKdJgwT/mGPkXii3o0jNfaRiUSyhH9xfoyrmE7n+k5sb3XOrQ==
X-Received: by 2002:a17:906:3604:b0:78d:99a0:7cf6 with SMTP id q4-20020a170906360400b0078d99a07cf6mr73616066ejb.56.1670367672700;
        Tue, 06 Dec 2022 15:01:12 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906838a00b007c0dacbe00bsm4239320ejx.115.2022.12.06.15.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Dec 2022 15:01:12 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v7 06/10] arm64: dts: qcom: Add PM8550ve pmic dtsi
Date:   Wed,  7 Dec 2022 01:00:58 +0200
Message-Id: <20221206230102.1521053-7-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221206230102.1521053-1-abel.vesa@linaro.org>
References: <20221206230102.1521053-1-abel.vesa@linaro.org>
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

