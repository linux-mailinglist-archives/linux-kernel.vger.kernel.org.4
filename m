Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CF96395D1
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 12:47:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiKZLrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 06:47:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiKZLqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 06:46:48 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE9218BF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:44 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d1so10132334wrs.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 03:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YiSyzj5bxhBZ228Fs3MQ7cHv3+MhOBcyO/fL/boI7rc=;
        b=kvlN0yepnQQsvdxvQmkOac81dsjqwzbMcLS3fhTN8quXa5l/+RNB3X2E4sCI6BDRCg
         ok4O0V6yItPetHKmclQombSh7mfghu5Bke3Wvw0YaL1/1ocnOT+TudvB7UC+MEEcKBf/
         3qaUm+xqUQZypNkG2R7mvkMzQLxBaRbnwWMurl9Exu/od+pJVcnoNLjcxjbavrr9/NHb
         cyY3wEss9ntQF4XB57szwDTnNEwOr3x8K0MjIU6ZZH28AhxL3LTZdGMDysxMIB9QIdt2
         bZGjyFD83sk7zsWTxzOPrZM/DndER0ysKc4a7VqJcNY4vRDas45qQ546+t04QhERrxlx
         7Vkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YiSyzj5bxhBZ228Fs3MQ7cHv3+MhOBcyO/fL/boI7rc=;
        b=fK5Tn03pXjA/SRoNfOfR5mRat1trBPyfzT2XdW76/KLi0sgmvmnPqfETfbLU7qHMwI
         pp7J+fCXvwlOo1ZWFXDI8/B3eWTePd9uV+VGEvYI27yfv2NlSUTmgx0Ss5TDhET63up8
         aZqiSHAZ81xiz2jVA7cIHg/a3s79pzLqyxf7f+1y/CGk6PnZSTviQjA/aZuVmHva+/yT
         0Z8S/PgvRTJ36DV5EIRCmmynh441MPw9bnNPA2nO6+uyaHdSFsW2JZjT1d1gaiRzvIpZ
         kHKBtC8KPUQ9au3WSN9zOP1nW5OGmZag4qovD4SMq+069iEqTp3bhxVxsvdMtZzylk/3
         4kjw==
X-Gm-Message-State: ANoB5pmQNy8EcxJuixiDq2hE19+1NwjL9oht/+k0lkLQ+y/v2MPuPOLe
        S8wHQ3gU9A8snJCJvThKy++kzw==
X-Google-Smtp-Source: AA0mqf4Hk+w6WC2o6zY2XM78jGRkDG+5bhDrVYInii70somijzaFb/MRTClEdJP4wyMScKekHlUjbg==
X-Received: by 2002:adf:d847:0:b0:242:e13:44c2 with SMTP id k7-20020adfd847000000b002420e1344c2mr978541wrl.529.1669463203901;
        Sat, 26 Nov 2022 03:46:43 -0800 (PST)
Received: from hackbox.lan ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h5-20020adfa4c5000000b0023659925b2asm5942621wrb.51.2022.11.26.03.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Nov 2022 03:46:42 -0800 (PST)
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
Subject: [PATCH v3 04/10] arm64: dts: qcom: Add PM8550 pmic dtsi
Date:   Sat, 26 Nov 2022 13:46:11 +0200
Message-Id: <20221126114617.497677-5-abel.vesa@linaro.org>
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

Add nodes for PM8550 in separate dtsi file.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/pm8550.dtsi | 59 ++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8550.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8550.dtsi b/arch/arm64/boot/dts/qcom/pm8550.dtsi
new file mode 100644
index 000000000000..46396ec1a330
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8550.dtsi
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
+		pm8550-thermal {
+			polling-delay-passive = <100>;
+			polling-delay = <0>;
+
+			thermal-sensors = <&pm8550_temp_alarm>;
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
+	pm8550: pmic@1 {
+		compatible = "qcom,pm8550", "qcom,spmi-pmic";
+		reg = <0x1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		pm8550_temp_alarm: temp-alarm@a00 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0xa00>;
+			interrupts = <0x1 0xa 0x0 IRQ_TYPE_EDGE_BOTH>;
+			#thermal-sensor-cells = <0>;
+		};
+
+		pm8550_gpios: gpio@8800 {
+			compatible = "qcom,pm8550-gpio", "qcom,spmi-gpio";
+			reg = <0x8800>;
+			gpio-controller;
+			gpio-ranges = <&pm8550_gpios 0 0 12>;
+			#gpio-cells = <2>;
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+};
-- 
2.34.1

