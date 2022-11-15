Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75262957E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 11:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238454AbiKOKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 05:13:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiKOKN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 05:13:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15032529B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:12:40 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id cl5so23377183wrb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 02:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S7fY4usYA2r8CtJ+7ODnRoPWudv42gnaXQJ+odzKSO4=;
        b=PPe1huoE8PUp++8XjASswj4jCJtBg6x2OyOFE7goL4OGQqeDQB55QghpqEZEnwLNsk
         QS1QpGaT3Y/36WrPAHeNzacsvr/pfz6X4VDiLXiPt52Qzc3dr5jv5W3NkoRcDAfyvlEt
         j3BrRG3ICBUH2F6qE/NpV1IeOoyOW0jGUos2H0sjN0YVZQEaQUYBHL2EMOIuRhJmgnV+
         TUy5lqki8+akDUysuH6NgDvwm13/wWNUp6t7mM/FbxNg6JXQxobQDx1AHjPHG7flXHOM
         eyMWK50+fuSLLsg1esl07a/YRKFXj1rOmHPHVPyb870DbL9IyKxfZc5KJdsKTgs2f+oa
         DDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7fY4usYA2r8CtJ+7ODnRoPWudv42gnaXQJ+odzKSO4=;
        b=7OfLCmauUGc7kW7hJr5Wkwuex0GO6gOA6iripv5ehdVGKgMPqwOIlio0mce+dMMuJV
         x1edm+SfKDK5jBr1DtuH9BnORKU7jUEQbshuhyta+WrtY8AUFg387uxD+5mbfPFNCdqo
         N2nNA1oWXbbrBU+0etUFuTNf9EmHLqTaIthRvdleVEo9baJMgjYXaGrP2SR7QJ8utCNz
         hDSx+gaCAp7baBY9BaIFoBaj60fsO/EhTB3ZmQfCIaegwPbqiEInuwPw0voG+x9bw+p3
         1FuNcNPrKS0nF/EzEWyH1DIgr8wtO/p13X3zYuZGpXP59m8+2Y5jH2wGZjGZiWaHllXi
         IzNg==
X-Gm-Message-State: ANoB5pnV9v7TSDGXnLW0sE0CDO6DzZqrG7ikg901gfmXWm3+t/tzf7aV
        yln9b+xTL9AhOCrKVxmlx57euA==
X-Google-Smtp-Source: AA0mqf7aOcAxtA3gWpMqYJHQreD3qVlQTroA5wZgb/8vVnh3POAQIGfWysVu5HKtm22QE8m+BgfKeg==
X-Received: by 2002:adf:f4c3:0:b0:22e:3498:9adb with SMTP id h3-20020adff4c3000000b0022e34989adbmr10651246wrp.335.1668507159044;
        Tue, 15 Nov 2022 02:12:39 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id az40-20020a05600c602800b003b492753826sm15165154wmb.43.2022.11.15.02.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 02:12:38 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Tue, 15 Nov 2022 11:12:36 +0100
Subject: [PATCH v4 2/2] dt-bindings: soc: qcom: convert non-smd RPM bindings to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221005-mdm9615-pinctrl-yaml-v4-2-463523919c19@linaro.org>
References: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
In-Reply-To: <20221005-mdm9615-pinctrl-yaml-v4-0-463523919c19@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>, Lee Jones <lee@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.10.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the non-SMD RPM node bindings to dt-schema, the old txt bindings
are now removed since all bindings were converted.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Lee Jones <lee@kernel.org>
---
 Documentation/devicetree/bindings/mfd/qcom-rpm.txt | 283 ---------------------
 .../devicetree/bindings/soc/qcom/qcom,rpm.yaml     | 101 ++++++++
 2 files changed, 101 insertions(+), 283 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt b/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
deleted file mode 100644
index b823b8625243..000000000000
--- a/Documentation/devicetree/bindings/mfd/qcom-rpm.txt
+++ /dev/null
@@ -1,283 +0,0 @@
-Qualcomm Resource Power Manager (RPM)
-
-This driver is used to interface with the Resource Power Manager (RPM) found in
-various Qualcomm platforms. The RPM allows each component in the system to vote
-for state of the system resources, such as clocks, regulators and bus
-frequencies.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-apq8064"
-		    "qcom,rpm-msm8660"
-		    "qcom,rpm-msm8960"
-		    "qcom,rpm-ipq8064"
-		    "qcom,rpm-mdm9615"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: base address and size of the RPM's message ram
-
-- interrupts:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: three entries specifying the RPM's:
-		    1. acknowledgement interrupt
-		    2. error interrupt
-		    3. wakeup interrupt
-
-- interrupt-names:
-	Usage: required
-	Value type: <string-array>
-	Definition: must be the three strings "ack", "err" and "wakeup", in order
-
-- qcom,ipc:
-	Usage: required
-	Value type: <prop-encoded-array>
-
-	Definition: three entries specifying the outgoing ipc bit used for
-		    signaling the RPM:
-		    - phandle to a syscon node representing the apcs registers
-		    - u32 representing offset to the register within the syscon
-		    - u32 representing the ipc bit within the register
-
-
-= SUBNODES
-
-The RPM exposes resources to its subnodes. The below bindings specify the set
-of valid subnodes that can operate on these resources.
-
-== Regulators
-
-Regulator nodes are identified by their compatible:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,rpm-pm8058-regulators"
-		    "qcom,rpm-pm8901-regulators"
-		    "qcom,rpm-pm8921-regulators"
-		    "qcom,rpm-pm8018-regulators"
-		    "qcom,rpm-smb208-regulators"
-
-- vdd_l0_l1_lvs-supply:
-- vdd_l2_l11_l12-supply:
-- vdd_l3_l4_l5-supply:
-- vdd_l6_l7-supply:
-- vdd_l8-supply:
-- vdd_l9-supply:
-- vdd_l10-supply:
-- vdd_l13_l16-supply:
-- vdd_l14_l15-supply:
-- vdd_l17_l18-supply:
-- vdd_l19_l20-supply:
-- vdd_l21-supply:
-- vdd_l22-supply:
-- vdd_l23_l24_l25-supply:
-- vdd_ncp-supply:
-- vdd_s0-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-	Usage: optional (pm8058 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- lvs0_in-supply:
-- lvs1_in-supply:
-- lvs2_in-supply:
-- lvs3_in-supply:
-- mvs_in-supply:
-- vdd_l0-supply:
-- vdd_l1-supply:
-- vdd_l2-supply:
-- vdd_l3-supply:
-- vdd_l4-supply:
-- vdd_l5-supply:
-- vdd_l6-supply:
-- vdd_s0-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s3-supply:
-- vdd_s4-supply:
-	Usage: optional (pm8901 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vdd_l1_l2_l12_l18-supply:
-- vdd_l3_l15_l17-supply:
-- vdd_l4_l14-supply:
-- vdd_l5_l8_l16-supply:
-- vdd_l6_l7-supply:
-- vdd_l9_l11-supply:
-- vdd_l10_l22-supply:
-- vdd_l21_l23_l29-supply:
-- vdd_l24-supply:
-- vdd_l25-supply:
-- vdd_l26-supply:
-- vdd_l27-supply:
-- vdd_l28-supply:
-- vdd_ncp-supply:
-- vdd_s1-supply:
-- vdd_s2-supply:
-- vdd_s4-supply:
-- vdd_s5-supply:
-- vdd_s6-supply:
-- vdd_s7-supply:
-- vdd_s8-supply:
-- vin_5vs-supply:
-- vin_lvs1_3_6-supply:
-- vin_lvs2-supply:
-- vin_lvs4_5_7-supply:
-	Usage: optional (pm8921 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-- vin_lvs1-supply:
-- vdd_l7-supply:
-- vdd_l8-supply:
-- vdd_l9_l10_l11_l12-supply:
-	Usage: optional (pm8018 only)
-	Value type: <phandle>
-	Definition: reference to regulator supplying the input pin, as
-		    described in the data sheet
-
-The regulator node houses sub-nodes for each regulator within the device. Each
-sub-node is identified using the node's name, with valid values listed for each
-of the pmics below.
-
-pm8058:
-	l0, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14, l15,
-	l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, s0, s1, s2, s3, s4,
-	lvs0, lvs1, ncp
-
-pm8901:
-	l0, l1, l2, l3, l4, l5, l6, s0, s1, s2, s3, s4, lvs0, lvs1, lvs2, lvs3,
-	mvs
-
-pm8921:
-	s1, s2, s3, s4, s7, s8, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-	l12, l14, l15, l16, l17, l18, l21, l22, l23, l24, l25, l26, l27, l28,
-	l29, lvs1, lvs2, lvs3, lvs4, lvs5, lvs6, lvs7, usb-switch, hdmi-switch,
-	ncp
-
-pm8018:
-	s1, s2, s3, s4, s5, , l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
-	l12, l14, lvs1
-
-smb208:
-	s1a, s1b, s2a, s2b
-
-The content of each sub-node is defined by the standard binding for regulators -
-see regulator.txt - with additional custom properties described below:
-
-=== Switch-mode Power Supply regulator custom properties
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <empty>
-	Definition: enable pull down of the regulator when inactive
-
-- qcom,switch-mode-frequency:
-	Usage: required
-	Value type: <u32>
-	Definition: Frequency (Hz) of the switch-mode power supply;
-		    must be one of:
-		    19200000, 9600000, 6400000, 4800000, 3840000, 3200000,
-		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
-		    1480000, 1370000, 1280000, 1200000
-
-- qcom,force-mode:
-	Usage: optional (default if no other qcom,force-mode is specified)
-	Value type: <u32>
-	Definition: indicates that the regulator should be forced to a
-		   particular mode, valid values are:
-		   QCOM_RPM_FORCE_MODE_NONE - do not force any mode
-		   QCOM_RPM_FORCE_MODE_LPM - force into low power mode
-		   QCOM_RPM_FORCE_MODE_HPM - force into high power mode
-		   QCOM_RPM_FORCE_MODE_AUTO - allow regulator to automatically
-					      select its own mode based on
-					      realtime current draw, only for:
-					      pm8921 smps and ftsmps
-
-- qcom,power-mode-hysteretic:
-	Usage: optional
-	Value type: <empty>
-	Definition: select that the power supply should operate in hysteretic
-		    mode, instead of the default pwm mode
-
-=== Low-dropout regulator custom properties
-
-- bias-pull-down:
-	Usage: optional
-	Value type: <empty>
-	Definition: enable pull down of the regulator when inactive
-
-- qcom,force-mode:
-	Usage: optional
-	Value type: <u32>
-	Definition: indicates that the regulator should not be forced to any
-		   particular mode, valid values are:
-		   QCOM_RPM_FORCE_MODE_NONE - do not force any mode
-		   QCOM_RPM_FORCE_MODE_LPM - force into low power mode
-		   QCOM_RPM_FORCE_MODE_HPM - force into high power mode
-		   QCOM_RPM_FORCE_MODE_BYPASS - set regulator to use bypass
-						mode, i.e.  to act as a switch
-						and not regulate, only for:
-						pm8921 pldo, nldo and nldo1200
-
-=== Negative Charge Pump custom properties
-
-- qcom,switch-mode-frequency:
-	Usage: required
-	Value type: <u32>
-	Definition: Frequency (Hz) of the switch mode power supply;
-		    must be one of:
-		    19200000, 9600000, 6400000, 4800000, 3840000, 3200000,
-		    2740000, 2400000, 2130000, 1920000, 1750000, 1600000,
-		    1480000, 1370000, 1280000, 1200000
-
-= EXAMPLE
-
-	#include <dt-bindings/mfd/qcom-rpm.h>
-
-	rpm@108000 {
-		compatible = "qcom,rpm-msm8960";
-		reg = <0x108000 0x1000>;
-		qcom,ipc = <&apcs 0x8 2>;
-
-		interrupts = <0 19 0>, <0 21 0>, <0 22 0>;
-		interrupt-names = "ack", "err", "wakeup";
-
-		regulators {
-			compatible = "qcom,rpm-pm8921-regulators";
-			vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
-
-			s1 {
-				regulator-min-microvolt = <1225000>;
-				regulator-max-microvolt = <1225000>;
-
-				bias-pull-down;
-
-				qcom,switch-mode-frequency = <3200000>;
-			};
-
-			pm8921_s4: s4 {
-				regulator-min-microvolt = <1800000>;
-				regulator-max-microvolt = <1800000>;
-
-				qcom,switch-mode-frequency = <1600000>;
-				bias-pull-down;
-
-				qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
-			};
-		};
-	};
-
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
new file mode 100644
index 000000000000..e27e895c1f3f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,rpm.yaml
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,ipc-rpm.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Resource Power Manager (RPM)
+
+description:
+  This driver is used to interface with the Resource Power Manager (RPM) found
+  in various Qualcomm platforms. The RPM allows each component in the system
+  to vote for state of the system resources, such as clocks, regulators and bus
+  frequencies.
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,rpm-apq8064
+      - qcom,rpm-msm8660
+      - qcom,rpm-msm8960
+      - qcom,rpm-ipq8064
+      - qcom,rpm-mdm9615
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 3
+
+  interrupt-names:
+    items:
+      - const: ack
+      - const: err
+      - const: wakeup
+
+  qcom,ipc:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - items:
+          - description: phandle to a syscon node representing the APCS registers
+          - description: u32 representing offset to the register within the syscon
+          - description: u32 representing the ipc bit within the register
+    description:
+      Three entries specifying the outgoing ipc bit used for signaling the RPM.
+
+patternProperties:
+  "^regulators(-[01])?$":
+    type: object
+    $ref: /schemas/regulator/qcom,ipc-rpm-regulator.yaml#
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - interrupt-names
+  - qcom,ipc
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mfd/qcom-rpm.h>
+
+    rpm@108000 {
+      compatible = "qcom,rpm-msm8960";
+      reg = <0x108000 0x1000>;
+      qcom,ipc = <&apcs 0x8 2>;
+
+      interrupts = <GIC_SPI 19 IRQ_TYPE_NONE>, <GIC_SPI 21 IRQ_TYPE_NONE>, <GIC_SPI 22 IRQ_TYPE_NONE>;
+      interrupt-names = "ack", "err", "wakeup";
+
+      regulators {
+        compatible = "qcom,rpm-pm8921-regulators";
+        vdd_l1_l2_l12_l18-supply = <&pm8921_s4>;
+
+        s1 {
+          regulator-min-microvolt = <1225000>;
+          regulator-max-microvolt = <1225000>;
+
+          bias-pull-down;
+
+          qcom,switch-mode-frequency = <3200000>;
+        };
+
+        pm8921_s4: s4 {
+          regulator-min-microvolt = <1800000>;
+          regulator-max-microvolt = <1800000>;
+
+          qcom,switch-mode-frequency = <1600000>;
+          bias-pull-down;
+
+          qcom,force-mode = <QCOM_RPM_FORCE_MODE_AUTO>;
+        };
+      };
+    };

-- 
b4 0.10.1
