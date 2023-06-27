Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0974011A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbjF0Q1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjF0QYx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:24:53 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E16873584
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:51 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb7769f15aso3374322e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687883090; x=1690475090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ctd6NThpx69jPylUbb4gptRsxME69SX4+Gzv2K70VRo=;
        b=BOVVvXqNrZIAQGOBdv707QC8EQ5sHi6gmFvrnAlotB+9fchHS1X9Ykle6oSU66Ffij
         DSlIk7VYigcKJbM6QpT5dUXTNWkCHdu2cVB4qYJqj415lMisiZAGIH107dOnSAxbkgV2
         zhXOYVsgGQbU8adZTfxsZNOBEoHoYdeEjPB2uVNsWD5VVxDJMlpS31WXF66y2sYK5MYl
         +HTIC46yh7dfpvVJblamv2+Pa8MoExmgFz4wXCsdLttegxqnWR+CKQVmFYqz/RgAaGtR
         2E48YTCLonYoBdTMPq0+/K9pOKHuqf8wtsEHJNOjDmQX54Z5nbZ1xy/c4XItBeBLXWSP
         Hseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687883090; x=1690475090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ctd6NThpx69jPylUbb4gptRsxME69SX4+Gzv2K70VRo=;
        b=cdZ3FJD81Y+/pdA0WumCerY1/PKUmxNk0bfbs/LGdI0RTXD9i1vxjG4sGceFOrmZm3
         1LhG5hkTYLyccntjd07QPGahENHj2dOxLPKFICXsoO67GciHG8hOxSXQjav5zeQpl+ql
         G0HoFqqYKy2mgijJwgX+tX1keDzB+NW9ndoNB/ONxt+s5S8QlmV8Lm7s4ESQvZbTGSHe
         /4mUcAqQfQSfpIB/ILJKf7hjHNcwL7KxcVJVIQPeu92kLAnnHvu/nmb50oWsooZm7w6Z
         2OiY+3Jz7p6baDNyz2Xd8h66hE7MVNh7UqmXvbWKUGTqTC5idqUdHDJ/FGmr4L4NxI8r
         IhnQ==
X-Gm-Message-State: AC+VfDyQKgz1ZUWP1odGMOqgWHZtlS7Uk7n8L1t2hHxwnl3fRrhwhbV8
        fl6EGzuKYbB9ifejn/1rxSx8qg==
X-Google-Smtp-Source: ACHHUZ7/IsrAYYJ83qNIX85WmUB8XQr3Dyw8YmG60/Pgj6ZfFtoyl/nbnCy5K9y/GyUuCqUq4R2nlg==
X-Received: by 2002:a05:6512:1584:b0:4f8:710c:e2c7 with SMTP id bp4-20020a056512158400b004f8710ce2c7mr13974676lfb.33.1687883090060;
        Tue, 27 Jun 2023 09:24:50 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id g7-20020a19ac07000000b004fb259a5589sm1190508lfc.104.2023.06.27.09.24.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 09:24:49 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 18:24:21 +0200
Subject: [PATCH 05/11] dt-bindings: sound: Convert pm8916-wcd-analog-codec
 to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230627-topic-more_bindings-v1-5-6b4b6cd081e5@linaro.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
In-Reply-To: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
To:     cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Benjamin Li <benl@squareup.com>,
        James Willcox <jwillcox@squareup.com>,
        Joseph Gates <jgates@squareup.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Zac Crosby <zac@squareup.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Lee Jones <lee@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Xu Yang <xu.yang_2@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Jun Nie <jun.nie@linaro.org>, Max Chen <mchen@squareup.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        alsa-devel@alsa-project.org, iommu@lists.linux.dev,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Rob Herring <robh@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687883074; l=9977;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=uE+UU1PMQNBYsYkBYV409QKnIYIcTBQRlTvAYK5pYKY=;
 b=ylbQz6shMjx5lnxaRBjhrP3JWvzCQM5oZnlXR3bVaBTrtloCKKp5Ahu9D93lKetS3VtOSvBGd
 bnHc4HJs/T0C/ycfLYk2PP7QKWRsGStWE6uvvRwzgbDcFZbYWNRUi8Q
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the PM8916 analog WCD codec bindings to YAML.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/sound/qcom,msm8916-wcd-analog.txt     | 101 -------------
 .../sound/qcom,pm8916-wcd-analog-codec.yaml        | 160 +++++++++++++++++++++
 2 files changed, 160 insertions(+), 101 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt b/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
deleted file mode 100644
index e7d17dda55db..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,msm8916-wcd-analog.txt
+++ /dev/null
@@ -1,101 +0,0 @@
-msm8916 analog audio CODEC
-
-Bindings for codec Analog IP which is integrated in pmic pm8916,
-
-## Bindings for codec core on pmic:
-
-Required properties
- - compatible = "qcom,pm8916-wcd-analog-codec";
- - reg: represents the slave base address provided to the peripheral.
- - interrupts: List of interrupts in given SPMI peripheral.
- - interrupt-names: Names specified to above list of interrupts in same
-		    order. List of supported interrupt names are:
-  "cdc_spk_cnp_int" - Speaker click and pop interrupt.
-  "cdc_spk_clip_int" - Speaker clip interrupt.
-  "cdc_spk_ocp_int" - Speaker over current protect interrupt.
-  "mbhc_ins_rem_det1" - jack insert removal detect interrupt 1.
-  "mbhc_but_rel_det" - button release interrupt.
-  "mbhc_but_press_det" - button press event
-  "mbhc_ins_rem_det" - jack insert removal detect interrupt.
-  "mbhc_switch_int"	- multi button headset interrupt.
-  "cdc_ear_ocp_int" - Earphone over current protect interrupt.
-  "cdc_hphr_ocp_int" - Headphone R over current protect interrupt.
-  "cdc_hphl_ocp_det" - Headphone L over current protect interrupt.
-  "cdc_ear_cnp_int" - earphone cnp interrupt.
-  "cdc_hphr_cnp_int" - hphr click and pop interrupt.
-  "cdc_hphl_cnp_int" - hphl click and pop interrupt.
-
- - clocks: Handle to mclk.
- - clock-names: should be "mclk"
- - vdd-cdc-io-supply: phandle to VDD_CDC_IO regulator DT node.
- - vdd-cdc-tx-rx-cx-supply: phandle to VDD_CDC_TX/RX/CX regulator DT node.
- - vdd-micbias-supply: phandle of VDD_MICBIAS supply's regulator DT node.
-
-Optional Properties:
- - qcom,mbhc-vthreshold-low: Array of 5 threshold voltages in mV for 5 buttons
-			     detection on headset when the mbhc is powered up
-			     by internal current source, this is a low power.
- - qcom,mbhc-vthreshold-high: Array of 5 thresold voltages in mV for 5 buttons
-			      detection on headset when mbhc is powered up
-			       from micbias.
-- qcom,micbias-lvl:  Voltage (mV) for Mic Bias
-- qcom,hphl-jack-type-normally-open: boolean, present if hphl pin on jack is a
-				     NO (Normally Open). If not specified, then
-				     its assumed that hphl pin on jack is NC
-				     (Normally Closed).
-- qcom,gnd-jack-type-normally-open: boolean, present if gnd pin on jack is
-				    NO (Normally Open). If not specified, then
-				    its assumed that gnd pin on jack is NC
-				    (Normally Closed).
-- qcom,micbias1-ext-cap: boolean, present if micbias1 has external capacitor
-			 connected.
-- qcom,micbias2-ext-cap: boolean, present if micbias2 has external capacitor
-			 connected.
-
-Example:
-
-spmi_bus {
-	...
-	audio-codec@f000{
-		compatible = "qcom,pm8916-wcd-analog-codec";
-		reg = <0xf000 0x200>;
-		reg-names = "pmic-codec-core";
-		clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
-		clock-names = "mclk";
-		qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
-		qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
-		interrupt-parent = <&spmi_bus>;
-		interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
-			     <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
-			     <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
-		interrupt-names = "cdc_spk_cnp_int",
-				  "cdc_spk_clip_int",
-				  "cdc_spk_ocp_int",
-				  "mbhc_ins_rem_det1",
-				  "mbhc_but_rel_det",
-				  "mbhc_but_press_det",
-				  "mbhc_ins_rem_det",
-				  "mbhc_switch_int",
-				  "cdc_ear_ocp_int",
-				  "cdc_hphr_ocp_int",
-				  "cdc_hphl_ocp_det",
-				  "cdc_ear_cnp_int",
-				  "cdc_hphr_cnp_int",
-				  "cdc_hphl_cnp_int";
-	               vdd-cdc-io-supply = <&pm8916_l5>;
-	               vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
-	               vdd-micbias-supply = <&pm8916_l13>;
-	               #sound-dai-cells = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
new file mode 100644
index 000000000000..c385028c4296
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,pm8916-wcd-analog-codec.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,pm8916-wcd-analog-codec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PM8916 WCD Analog Audio Codec
+
+maintainers:
+  - Konrad Dybcio <konradybcio@kernel.org>
+
+description:
+  The analog WCD audio codec found on Qualcomm PM8916 PMIC.
+
+properties:
+  compatible:
+    const: qcom,pm8916-wcd-analog-codec
+
+  reg:
+    maxItems: 1
+
+  reg-names:
+    items:
+      - const: pmic-codec-core
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: mclk
+
+  interrupts:
+    maxItems: 14
+
+  interrupt-names:
+    items:
+      - const: cdc_spk_cnp_int
+      - const: cdc_spk_clip_int
+      - const: cdc_spk_ocp_int
+      - const: mbhc_ins_rem_det1
+      - const: mbhc_but_rel_det
+      - const: mbhc_but_press_det
+      - const: mbhc_ins_rem_det
+      - const: mbhc_switch_int
+      - const: cdc_ear_ocp_int
+      - const: cdc_hphr_ocp_int
+      - const: cdc_hphl_ocp_det
+      - const: cdc_ear_cnp_int
+      - const: cdc_hphr_cnp_int
+      - const: cdc_hphl_cnp_int
+
+  vdd-cdc-io-supply:
+    description: 1.8V buck supply
+
+  vdd-cdc-tx-rx-cx-supply:
+    description: 1.8V SIDO buck supply
+
+  vdd-micbias-supply:
+    description: micbias supply
+
+  qcom,mbhc-vthreshold-low:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of 5 threshold voltages in mV for 5-button detection on
+      headset when MBHC is powered by an internal current source.
+    minItems: 5
+    maxItems: 5
+
+  qcom,mbhc-vthreshold-high:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Array of 5 threshold voltages in mV for 5-button detection on
+      headset when MBHC is powered from micbias.
+    minItems: 5
+    maxItems: 5
+
+  qcom,micbias-lvl:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Voltage (mV) for Mic Bias
+
+  qcom,hphl-jack-type-normally-open:
+    type: boolean
+    description:
+      True if the HPHL pin on the jack is NO (Normally Open), false if it's
+      NC (Normally Closed).
+
+  qcom,gnd-jack-type-normally-open:
+    type: boolean
+    description:
+      True if the GND pin on the jack is NO (Normally Open), false if it's
+      NC (Normally Closed).
+
+  qcom,micbias1-ext-cap:
+    type: boolean
+    description:
+      True if micbias1 has an external capacitor.
+
+  qcom,micbias2-ext-cap:
+    type: boolean
+    description:
+      True if micbias2 has an external capacitor.
+
+  "#sound-dai-cells":
+    const: 1
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8916.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    audio-codec@f000{
+      compatible = "qcom,pm8916-wcd-analog-codec";
+      reg = <0xf000 0x200>;
+      reg-names = "pmic-codec-core";
+      clocks = <&gcc GCC_CODEC_DIGCODEC_CLK>;
+      clock-names = "mclk";
+      qcom,mbhc-vthreshold-low = <75 150 237 450 500>;
+      qcom,mbhc-vthreshold-high = <75 150 237 450 500>;
+      interrupt-parent = <&spmi_bus>;
+      interrupts = <0x1 0xf0 0x0 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x1 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x2 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x3 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x4 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x5 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x6 IRQ_TYPE_NONE>,
+            <0x1 0xf0 0x7 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x0 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x1 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x2 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x3 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x4 IRQ_TYPE_NONE>,
+            <0x1 0xf1 0x5 IRQ_TYPE_NONE>;
+      interrupt-names = "cdc_spk_cnp_int",
+                        "cdc_spk_clip_int",
+                        "cdc_spk_ocp_int",
+                        "mbhc_ins_rem_det1",
+                        "mbhc_but_rel_det",
+                        "mbhc_but_press_det",
+                        "mbhc_ins_rem_det",
+                        "mbhc_switch_int",
+                        "cdc_ear_ocp_int",
+                        "cdc_hphr_ocp_int",
+                        "cdc_hphl_ocp_det",
+                        "cdc_ear_cnp_int",
+                        "cdc_hphr_cnp_int",
+                        "cdc_hphl_cnp_int";
+      vdd-cdc-io-supply = <&pm8916_l5>;
+      vdd-cdc-tx-rx-cx-supply = <&pm8916_l5>;
+      vdd-micbias-supply = <&pm8916_l13>;
+      #sound-dai-cells = <1>;
+    };

-- 
2.41.0

