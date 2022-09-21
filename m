Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23335BF56D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 06:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiIUEiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 00:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiIUEiM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 00:38:12 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019EE7CB65;
        Tue, 20 Sep 2022 21:38:07 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id b75so4737056pfb.7;
        Tue, 20 Sep 2022 21:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=tI0KkUSNvhGhZYrmwE2JK7mdGhHWeK/tgIx66TUM+Xc=;
        b=YcGzBfBJLMay6gG0FphGd7sNw4Y32VoDggjauHTNUTkgiOXvR/KWGqpxhWAw0lF6Cf
         kJTINpUOya3zc61HEQH4ezeeQLeWrBv5laZzb5puMiczInOGgkkj5kOSPHFjcrJ36Mw4
         FHowKZ0i3ljFUC31pBUe0PMN+whvtB2T9MdvwkfRMkOCxo12squqzvnLnorhpez8CfrM
         33Cy5bsrCE0DtiAwo9DFlxFYbI6aq4CQIs2qpfX0WYbwgUpsxVy5+xxsY6CDb+r4tQTS
         qFZ6LSeo0N7qbuT0AtH98YERr9SV3439CpYs54zGQb8PH+jb7Lm+wtEAKI0Npt0g8n/4
         u+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=tI0KkUSNvhGhZYrmwE2JK7mdGhHWeK/tgIx66TUM+Xc=;
        b=C6IfAOtWN8EoPeiOIYOew97Mj3yQhHbjrDznZZ8kdE8l5KkZ/pIu6zCvDh5P6PC9CG
         p/06Nh90+IXVBPjCD4H0+7N+iRoLgW04TjCsy2XP9F5tJnkbm2ETViNidEVT7LLN6/f3
         AfY0UBZ1EsgorA0ufz++F4N6NqhnTn20r6jWqjcm6RrHVOUtllLVo8zPnelFtWisItLw
         j5K6pJpF16Z/2jg2AA0xQo/aL1bBb4HVL140zqAvwsD8BaV5anSb7Lg2lX+1m6MRjzb5
         1+8xSJQFDEARonwE/Ap42l2tngrd827EEDNvViPTE92rVCu88dR2WGnuHgyuB4TA75yy
         oo3A==
X-Gm-Message-State: ACrzQf0ylDRizXlr8/UG8I2SD4TUDpnq84OoXP/A+y93MGe/REhirPxN
        6ysAE6LUNL/djsHRB70K+Nm1sflLcMnA3w==
X-Google-Smtp-Source: AMsMyM5egigiCc1c0Z5xm4WpnKBpQwwbkYUV3gUFlB1/bBxiO+8WtuQY85RJmxuriU4o5oqLEzbPIA==
X-Received: by 2002:a05:6a00:14d5:b0:542:9c32:ab27 with SMTP id w21-20020a056a0014d500b005429c32ab27mr26686304pfu.64.1663735085908;
        Tue, 20 Sep 2022 21:38:05 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t185-20020a6378c2000000b0042c0ffa0e62sm821182pgc.47.2022.09.20.21.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 21:38:05 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, linux-kernel@vger.kernel.org
Cc:     andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 2/4] dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
Date:   Wed, 21 Sep 2022 10:06:46 +0530
Message-Id: <20220921043648.2152725-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
References: <20220921043648.2152725-1-sireeshkodali1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a direct conversion of the existing txt documentation to YAML.
It is in preparation for the addition of pronto-v3 to the docs. This
patch doesn't document any of the existing subnodes/properties that are
not documented in the existing txt file. That is done in a separate
patch.

Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
---
 .../bindings/remoteproc/qcom,wcnss-pil.txt    | 177 ------------
 .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 267 ++++++++++++++++++
 2 files changed, 267 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
deleted file mode 100644
index ac423f4c3f1b..000000000000
--- a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.txt
+++ /dev/null
@@ -1,177 +0,0 @@
-Qualcomm WCNSS Peripheral Image Loader
-
-This document defines the binding for a component that loads and boots firmware
-on the Qualcomm WCNSS core.
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,riva-pil",
-		    "qcom,pronto-v1-pil",
-		    "qcom,pronto-v2-pil"
-
-- reg:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must specify the base address and size of the CCU, DXE and
-		    PMU register blocks
-
-- reg-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be "ccu", "dxe", "pmu"
-
-- interrupts-extended:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: must list the watchdog and fatal IRQs and may specify the
-		    ready, handover and stop-ack IRQs
-
-- interrupt-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: should be "wdog", "fatal", optionally followed by "ready",
-		    "handover", "stop-ack"
-
-- firmware-name:
-	Usage: optional
-	Value type: <string>
-	Definition: must list the relative firmware image path for the
-		    WCNSS core. Defaults to "wcnss.mdt".
-
-- vddmx-supply: (deprecated for qcom,pronto-v1/2-pil)
-- vddcx-supply: (deprecated for qcom,pronto-v1/2-pil)
-- vddpx-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the WCNSS core
-
-- power-domains:
-	Usage: required (for qcom,pronto-v1/2-pil)
-	Value type: <phandle>
-	Definition: reference to the power domains to be held on behalf of the
-		    booting of the WCNSS core
-
-- power-domain-names:
-	Usage: required (for qcom,pronto-v1/2-pil)
-	Value type: <stringlist>
-	Definition: must be "cx", "mx"
-
-- qcom,smem-states:
-	Usage: optional
-	Value type: <prop-encoded-array>
-	Definition: reference to the SMEM state used to indicate to WCNSS that
-		    it should shut down
-
-- qcom,smem-state-names:
-	Usage: optional
-	Value type: <stringlist>
-	Definition: should be "stop"
-
-- memory-region:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: reference to reserved-memory node for the remote processor
-		    see ../reserved-memory/reserved-memory.txt
-
-= SUBNODES
-A required subnode of the WCNSS PIL is used to describe the attached rf module
-and its resource dependencies. It is described by the following properties:
-
-- compatible:
-	Usage: required
-	Value type: <string>
-	Definition: must be one of:
-		    "qcom,wcn3620",
-		    "qcom,wcn3660",
-		    "qcom,wcn3660b",
-		    "qcom,wcn3680"
-
-- clocks:
-	Usage: required
-	Value type: <prop-encoded-array>
-	Definition: should specify the xo clock and optionally the rf clock
-
-- clock-names:
-	Usage: required
-	Value type: <stringlist>
-	Definition: should be "xo", optionally followed by "rf"
-
-- vddxo-supply:
-- vddrfa-supply:
-- vddpa-supply:
-- vdddig-supply:
-	Usage: required
-	Value type: <phandle>
-	Definition: reference to the regulators to be held on behalf of the
-		    booting of the WCNSS core
-
-
-The wcnss node can also have an subnode named "smd-edge" that describes the SMD
-edge, channels and devices related to the WCNSS.
-See ../soc/qcom/qcom,smd.yaml for details on how to describe the SMD edge.
-
-= EXAMPLE
-The following example describes the resources needed to boot control the WCNSS,
-with attached WCN3680, as it is commonly found on MSM8974 boards.
-
-pronto@fb204000 {
-	compatible = "qcom,pronto-v2-pil";
-	reg = <0xfb204000 0x2000>, <0xfb202000 0x1000>, <0xfb21b000 0x3000>;
-	reg-names = "ccu", "dxe", "pmu";
-
-	interrupts-extended = <&intc 0 149 1>,
-			      <&wcnss_smp2p_slave 0 0>,
-			      <&wcnss_smp2p_slave 1 0>,
-			      <&wcnss_smp2p_slave 2 0>,
-			      <&wcnss_smp2p_slave 3 0>;
-	interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
-
-	power-domains = <&rpmpd MSM8974_VDDCX>, <&rpmpd MSM8974_VDDMX>;
-	power-domain-names = "cx", "mx";
-
-	vddpx-supply = <&pm8941_s3>;
-
-	qcom,smem-states = <&wcnss_smp2p_out 0>;
-	qcom,smem-state-names = "stop";
-
-	memory-region = <&wcnss_region>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&wcnss_pin_a>;
-
-	iris {
-		compatible = "qcom,wcn3680";
-
-		clocks = <&rpmcc RPM_CXO_CLK_SRC>, <&rpmcc RPM_CXO_A2>;
-		clock-names = "xo", "rf";
-
-		vddxo-supply = <&pm8941_l6>;
-		vddrfa-supply = <&pm8941_l11>;
-		vddpa-supply = <&pm8941_l19>;
-		vdddig-supply = <&pm8941_s3>;
-	};
-
-	smd-edge {
-		interrupts = <0 142 1>;
-
-		qcom,ipc = <&apcs 8 17>;
-		qcom,smd-edge = <6>;
-		qcom,remote-pid = <4>;
-
-		label = "pronto";
-
-		wcnss {
-			compatible = "qcom,wcnss";
-			qcom,smd-channels = "WCNSS_CTRL";
-
-			qcom,mmio = <&pronto>;
-
-			bt {
-				compatible = "qcom,wcnss-bt";
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
new file mode 100644
index 000000000000..a99a1e5242f8
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,wcnss-pil.yaml
@@ -0,0 +1,267 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,wcnss-pil.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm WCNSS Peripheral Image Loader
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+
+description:
+  This document defines the binding for a component that loads and boots
+  firmware on the Qualcomm WCNSS core.
+
+properties:
+  compatible:
+    enum:
+      - qcom,riva-pil
+      - qcom,pronto-v1-pil
+      - qcom,pronto-v2-pil
+
+  reg:
+    maxItems: 3
+    description:
+      The base address and size of the CCU, DXE and PMU register blocks
+
+  reg-names:
+    items:
+      - const: ccu
+      - const: dxe
+      - const: pmu
+
+  interrupts:
+    minItems: 2
+    maxItems: 5
+
+  interrupt-names:
+    minItems: 2
+    items:
+      - const: wdog
+      - const: fatal
+      - const: ready
+      - const: handover
+      - const: stop-ack
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Relative firmware image path for the WCNSS core. Defaults to
+      "wcnss.mdt".
+
+  vddpx-supply:
+    description:
+      PX regulator to be held on behalf of the booting of the WCNSS core
+
+  vddmx-supply:
+    description:
+      MX regulator to be held on behalf of the booting of the WCNSS core.
+
+  vddcx-supply:
+    description:
+      CX regulator to be held on behalf of the booting of the WCNSS core.
+
+  power-domains:
+    maxItems: 2
+
+  power-domain-names:
+    items:
+      - const: cx
+      - const: mx
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      States used by the AP to signal the WCNSS core that it should shutdown
+    items:
+      - description: Stop the modem
+
+  qcom,smem-state-names:
+    description: The names of the state bits used for SMP2P output
+    items:
+      - const: stop
+
+  memory-region:
+    maxItems: 1
+    description: reserved-memory for the WCNSS core
+
+  smd-edge:
+    $ref: /schemas/remoteproc/qcom,smd-edge.yaml#
+    description:
+      Qualcomm Shared Memory subnode which represents communication edge,
+      channels and devices related to the ADSP.
+
+  iris:
+    type: object
+    description:
+      The iris subnode of the WCNSS PIL is used to describe the attached RF module
+      and its resource dependencies.
+
+    properties:
+      compatible:
+        enum:
+          - qcom,wcn3620
+          - qcom,wcn3660
+          - qcom,wcn3660b
+          - qcom,wcn3680
+
+      clocks:
+        minItems: 1
+        items:
+          - description: XO clock
+          - description: RF clock
+
+      clock-names:
+        minItems: 1
+        items:
+          - const: xo
+          - const: rf
+
+      vddxo-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vddrfa-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vddpa-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+      vdddig-supply:
+        description:
+          Reference to the regulator to be held on behalf of the booting WCNSS
+          core
+
+    required:
+      - compatible
+      - clocks
+      - clock-names
+      - vddxo-supply
+      - vddrfa-supply
+      - vddpa-supply
+      - vdddig-supply
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts-extended
+  - interrupt-names
+  - iris
+  - vddpx-supply
+  - memory-region
+  - smd-edge
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,riva-pil
+    then:
+      required:
+        - vddcx-supply
+        - vddmx-supply
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pronto-v1-pil
+              - qcom,pronto-v2-pil
+    then:
+      properties:
+        vddmx-supply:
+          deprecated: true
+          description: Deprecated for qcom,pronto-v1/2-pil
+
+        vddcx-supply:
+          deprecated: true
+          description: Deprecated for qcom,pronto-v1/2-pil
+
+      required:
+        - power-domains
+        - power-domain-names
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    pronto@a21b000 {
+        compatible = "qcom,pronto-v2-pil";
+        reg = <0x0a204000 0x2000>, <0x0a202000 0x1000>, <0x0a21b000 0x3000>;
+        reg-names = "ccu", "dxe", "pmu";
+
+        interrupts-extended = <&intc GIC_SPI 149 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&wcnss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready", "handover", "stop-ack";
+
+        power-domains = <&rpmpd MSM8916_VDDCX>, <&rpmpd MSM8916_VDDMX>;
+        power-domain-names = "cx", "mx";
+
+        vddpx-supply = <&pm8916_l7>;
+
+        qcom,smem-states = <&wcnss_smp2p_out 0>;
+        qcom,smem-state-names = "stop";
+
+        memory-region = <&wcnss_region>;
+
+        pinctrl-names = "default";
+        pinctrl-0 = <&wcnss_pin_a>;
+
+        iris {
+            compatible = "qcom,wcn3620";
+            vddxo-supply = <&pm8916_l7>;
+            vddrfa-supply = <&pm8916_s3>;
+            vddpa-supply = <&pm8916_l9>;
+            vdddig-supply = <&pm8916_l5>;
+
+            clocks = <&rpmcc RPM_SMD_RF_CLK2>;
+            clock-names = "xo";
+        };
+
+        smd-edge {
+            interrupts = <GIC_SPI 142 IRQ_TYPE_EDGE_RISING>;
+
+            qcom,ipc = <&apcs 8 17>;
+            qcom,smd-edge = <6>;
+            qcom,remote-pid = <4>;
+
+            label = "pronto";
+
+            wcnss_ctrl: wcnss {
+                compatible = "qcom,wcnss";
+                qcom,smd-channels = "WCNSS_CTRL";
+
+                qcom,mmio = <&pronto>;
+
+                bluetooth {
+                    compatible = "qcom,wcnss-bt";
+                };
+
+                wifi {
+                    compatible = "qcom,wcnss-wlan";
+
+                    interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                                 <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>;
+                    interrupt-names = "tx", "rx";
+
+                    qcom,smem-states = <&apps_smsm 10>, <&apps_smsm 9>;
+                    qcom,smem-state-names = "tx-enable", "tx-rings-empty";
+                };
+            };
+        };
+    };
-- 
2.37.3

