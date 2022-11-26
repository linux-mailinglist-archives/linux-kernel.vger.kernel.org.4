Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C83846395D3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbiKZLr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:47:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiKZLqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:46:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8720F45
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h11so2857469wrw.13
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=z7plBhIpzF3FYZVyPnzK2MWsBYA6MNomj+Ef2VNZrQ1jIycNj2h6IFd1V5fmEHTbpe
         MaeBbJSN3MDPyJKBTqkRoDtoSgw3cSenJkoDuYzMIccv9dAKRylXgK8rANaHgqlvcLer
         1D/EXzHhSabPIOzv88G8BOK0yFdPnnkUmIKYmYGU0kIpq747Q4Ds4URPNyYFlA3ysIEg
         Nob2EWwvsQ+CPKefvBJ+JYH9ifd0O7sF/nO9AGN2uH01k4aa68U81S1auf5lOCHfcVyG
         Lte384eAzi1cWeQ4ry+8RP9KLO7QFkCDu+nl2Ak/kc+z8za4yMj6jude+N8rpstKpYna
         y48A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YFy4mpBpGJLVajWjtu3C2lS5gW1c9EpDqZmyzJeWXJI=;
        b=heVcuBgL6jUqiQUSlqLelcKKC/x8DhUljb3KUM3A5+zcnrka15STymWz4cezhOAkco
         /XRv58Q/Tv9CoZ/myFOUm9sJbaizMbg05rlOuOtjNGwYyrqkPOyPCw1CTOPgUPeRl59g
         Qpb8KvSCtuhUYCCd6wxq1jKMkPhC7qmWtHxIcy0vfK+UYWmeG46IFHfdluZhvVNKVMUO
         9CTnCg6Yw9RCg3xVwHlfyjkYQ48CAiS4lbuEX0jxknjow22ZSPstBvsVeRl3eErJQ54B
         Afcy7etRe/NnW2sD35Q35Nw4/RluVDeBuaa8AyJKy/JP/j4c77L0bfxS6wkj9NPVonZO
         Q9sA==
X-Gm-Message-State: ANoB5pkE27YOVttFjGvdIIWo0kXhZ5Ki7GF39FpnHC2riXZeLnS3c69y
        DRPUDSG+lplwwqsgZz9hK2qcMA==
X-Google-Smtp-Source: AA0mqf43DOzPcpsB0GvXOnwLMx8wh/y2XtKa71SIQtVWiAItFjVdLCAK5BnMPGN8nkYm3H0p8jZbig==
X-Received: by 2002:adf:fd05:0:b0:241:f0e0:cc24 with SMTP id e5-20020adffd05000000b00241f0e0cc24mr10613356wrr.198.1669463206681;
        Sat, 26 Nov 2022 03:46:46 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h5-20020adfa4c5000000b0023659925b2asm5942621wrb.51.2022.11.26.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:46:44 -0800 (PST)
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 05/10] arm64: dts: qcom: Add PM8550b pmic dtsi
Date:   Sat, 26 Nov 2022 13:46:12 +0200
Message-Id: <20221126114617.497677-6-abel.vesa@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221126114617.497677-1-abel.vesa@linaro.org>
References: <20221126114617.497677-1-abel.vesa@linaro.org>
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

