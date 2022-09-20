Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52CB85BDA9E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 05:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiITDEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 23:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiITDDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 23:03:51 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3373158527;
        Mon, 19 Sep 2022 20:03:49 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id t70so1206694pgc.5;
        Mon, 19 Sep 2022 20:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=xiJ4eakZRhBliS0FKYx5g+Igo+LUyI4eBKYE7J68wu0=;
        b=gEpk7h2DrBcKM5H5XHlb6W79aPPgBdeBlCtDAabfdnZwqYYkihsivjJye0KGRQLTSd
         MFpuXtclcroPPaTHk/uFK3dGlL+pNOI1x+7DehpW+l5ud7pS6Rx+t6T0aQiy5SsyRZ+3
         qgcZYi/ngphtTrAQgEu9Jeo/qfAZcQ6qLO6oUvljgMXszALfFDV8zNrX3oHfstcdujGi
         Ny858kESfgQyQr9mBBp/kmUZGGZTU1bAwRocLfKKbv4rBTN2isBK9RumWb6/9YjX98Lt
         cq83dxSfwOcqW7pcmhyoJBo2gRzKGymQNm45e7F4l6n2N0XAwdacilIrtYElQPj6+8Ln
         EgVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=xiJ4eakZRhBliS0FKYx5g+Igo+LUyI4eBKYE7J68wu0=;
        b=JPi2m+KEUHF4gnPEynlfiYSpCzOr/FJYxYxfGZh46MDH50putYOP+xKgqaU/DXS24E
         dVqrhoQhbkoNWy1W0kIaJ8KvaZ+bG4vzE5jNIrD9wCNlFN8UhqALWH5d4ljCylrOj9i+
         POwaoBcbMbfaseWDAhykPg8WOygE7UR6OskBT/XbXBnzejDKgHCjownTYXi9mFWGMr8F
         jDGY9tavuwIpHE6oYxzEU/Y/mprV1FOOD/5YKqxBL39t8EuYAVRCGpwdTOBEEX9niUBT
         9XW/LwmI5l3V4cRjuxiVuZ0RAb1/226PwGCkeCVGIvTovN9uDJXUgv+o03e8FugwGHk/
         HDRw==
X-Gm-Message-State: ACrzQf1WJDscSZrKrt3S5e5gLw2f2TW5uNl1N43vNEeXG1/7HWZRmlYG
        wKc81kTw7gGjucIjULQRCe170g+kXta1wA==
X-Google-Smtp-Source: AMsMyM4COtz2slNzGDFh3gL/o22M3q9tImTXWOTeDkLfYBBOje9Z/JI4xrCDWUGe1QL36b6J7FSKtQ==
X-Received: by 2002:a63:81c2:0:b0:439:fbd1:7bab with SMTP id t185-20020a6381c2000000b00439fbd17babmr9605844pgd.33.1663643028140;
        Mon, 19 Sep 2022 20:03:48 -0700 (PDT)
Received: from skynet-linux.local ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.googlemail.com with ESMTPSA id t193-20020a635fca000000b0043a18cef977sm171083pgb.13.2022.09.19.20.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 20:03:47 -0700 (PDT)
From:   Sireesh Kodali <sireeshkodali1@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     andersson@kernel.org, Sireesh Kodali <sireeshkodali1@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 2/4] dt-bindings: remoteproc: qcom: Convert wcnss documentation to YAML
Date:   Tue, 20 Sep 2022 08:33:14 +0530
Message-Id: <20220920030316.1619781-3-sireeshkodali1@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
References: <20220920030316.1619781-1-sireeshkodali1@gmail.com>
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
index 000000000000..bb499ae9a4f0
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
+        compatible = "qcom,pronto-v2-pil", "qcom,pronto";
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

