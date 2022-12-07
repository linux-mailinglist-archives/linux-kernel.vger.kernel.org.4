Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C97C6461A7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 20:23:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiLGTXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 14:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiLGTXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 14:23:37 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC3E663F0
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 11:23:34 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id h11so29455578wrw.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 11:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IKTKywHyIPCXBSUcfJeW1/Q8bxFrGPEAhsZglTH+lJs=;
        b=VhLcSFA69TfU3tTYA+KzSGAqs4oCfIasSQUJtqfnLkN4gidG2uNmUyFHUtyWx4ay3D
         jwBIfv/CSvkPZHF9dGZ3ISZpKtzbpSC30XzcGCxyDYsUezcyoeKhnnD4TPfVDyV77b7K
         wqM4mazTIvYP5WGQHISThrK0SSCTEUW1Ap3wvktC9o/nKK+aD6y0rFqecEVU/sXXCrGl
         3fEjksXD2bAmWXTCXjPP7nqa5hfF0cH53QNBhwfCAD+xQ3qS0Wl3kbNpxWDPR/3jUW7a
         V7FzY7IoZcBP4vAN0cCs6ytpq4/+FeHGH8WH3VuIoYrt6f+/i+PM12hIgLkFsHnKn0bJ
         PLSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IKTKywHyIPCXBSUcfJeW1/Q8bxFrGPEAhsZglTH+lJs=;
        b=cFWj+OeXyMY/rvd+NdJQeUcfgfzFadwVzj4/xGRZVt3x8W5G5+A1R6POpBkHGogmb1
         EgHR0zcvqTVvxNd+z5P6tHOYkuXz2an7+pLlZ2yCrRhX4bCMb/PGGkPLad5Q8ZfQPP00
         eEz2+J+QCzA3W4aNtkuObAaRT2T3NIB/eUjl8Ht9Y2x5vLvQGBu2Zq5tdlZpvlg1wZrr
         2DlanyZ5pWLTp70t3ffKbnZu4hk1UApOHBkZU937SdUYRgKAipL/JlLodl5NsyMWlZTC
         nOjKgSrE0f7ylIYaJVtocgSwKRlGANonz8V6/LcOx3vUrApll8RjyZfl1HXjM10rkVqW
         bRgw==
X-Gm-Message-State: ANoB5pmwCBxM0tBcDaXpKx8cf0xRVmTCY8L4cf/j2xPzcDLOVzfdimMd
        LbVI4w1ZV1et4Qk6hbGiAuCa2Q==
X-Google-Smtp-Source: AA0mqf61O+6qmFAt/ReXwL6EYsS8v7RI0vpNMnZgQa158zyNM8AudnisBmfCAS/cr+4SfAq9+JJw7A==
X-Received: by 2002:adf:eb02:0:b0:236:5e6a:7ee with SMTP id s2-20020adfeb02000000b002365e6a07eemr57392748wrn.618.1670441013364;
        Wed, 07 Dec 2022 11:23:33 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id w1-20020a5d5441000000b002422b462975sm19400355wrv.34.2022.12.07.11.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Dec 2022 11:23:33 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Wed, 07 Dec 2022 20:23:24 +0100
Subject: [PATCH v3 2/5] dt-bindings: remoteproc: qcom: adsp: document sm8550 adsp,
 cdsp & mpss compatible
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-2-62162a1df718@linaro.org>
References: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
In-Reply-To: <20221114-narmstrong-sm8550-upstream-remoteproc-v3-0-62162a1df718@linaro.org>
To:     Amol Maheshwari <amahesh@qti.qualcomm.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-remoteproc@vger.kernel.org, Abel Vesa <abel.vesa@linaro.org>,
        linux-kernel@vger.kernel.org
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

This documents the compatible for the component used to boot the
aDSP, cDSP and MPSS on the SM8550 SoC.

The SM8550 boot process on SM8550 now requires a secondary "Devicetree"
firmware to be passed along the main Firmware, and the cDSP a new power
domain named "NSP".

A third memory domain for the DSM memory zone is also needed for the MPSS
PAS bindings.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 178 +++++++++++++++++++++
 1 file changed, 178 insertions(+)

diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
new file mode 100644
index 000000000000..ae612809e260
--- /dev/null
+++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/remoteproc/qcom,sm8550-pas.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8550 Peripheral Authentication Service
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8550 SoC Peripheral Authentication Service loads and boots firmware
+  on the Qualcomm DSP Hexagon cores.
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8550-adsp-pas
+      - qcom,sm8550-cdsp-pas
+      - qcom,sm8550-mpss-pas
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock
+
+  clock-names:
+    items:
+      - const: xo
+
+  qcom,qmp:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: Reference to the AOSS side-channel message RAM.
+
+  smd-edge: false
+
+  firmware-name:
+    $ref: /schemas/types.yaml#/definitions/string-array
+    items:
+      - description: Firmware name of the Hexagon core
+      - description: Firmware name of the Hexagon Devicetree
+
+  memory-region:
+    minItems: 2
+    items:
+      - description: Memory region for main Firmware authentication
+      - description: Memory region for Devicetree Firmware authentication
+      - description: DSM Memory region
+
+required:
+  - compatible
+  - reg
+
+allOf:
+  - $ref: /schemas/remoteproc/qcom,pas-common.yaml#
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-adsp-pas
+            - qcom,sm8550-cdsp-pas
+    then:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+        memory-region:
+          maxItems: 2
+    else:
+      properties:
+        interrupts:
+          minItems: 6
+        interrupt-names:
+          minItems: 6
+        memory-region:
+          minItems: 3
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-adsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: LCX power domain
+            - description: LMX power domain
+        power-domain-names:
+          items:
+            - const: lcx
+            - const: lmx
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-cdsp-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MXC power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mxc
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8550-mpss-pas
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: CX power domain
+            - description: MXC power domain
+            - description: NSP power domain
+        power-domain-names:
+          items:
+            - const: cx
+            - const: mxc
+            - const: nsp
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/mailbox/qcom-ipcc.h>
+
+    remoteproc@30000000 {
+        compatible = "qcom,sm8550-adsp-pas";
+        reg = <0x030000000 0x100>;
+
+        clocks = <&rpmhcc RPMH_CXO_CLK>;
+        clock-names = "xo";
+
+        interrupts-extended = <&pdc 6 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+                              <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "wdog", "fatal", "ready",
+                          "handover", "stop-ack";
+
+        memory-region = <&adsp_mem>, <&dtb_adsp_mem>;
+
+        firmware-name = "qcom/sm8550/adsp.mbn",
+                        "qcom/sm8550/adsp_dtb.mbn";
+
+        power-domains = <&rpmhpd_sm8550_lcx>,
+                        <&rpmhpd_sm8550_lmx>;
+        power-domain-names = "lcx", "lmx";
+
+        qcom,qmp = <&aoss_qmp>;
+        qcom,smem-states = <&smp2p_adsp_out 0>;
+        qcom,smem-state-names = "stop";
+
+        glink-edge {
+            interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+                                         IPCC_MPROC_SIGNAL_GLINK_QMP
+                                         IRQ_TYPE_EDGE_RISING>;
+            mboxes = <&ipcc IPCC_CLIENT_LPASS IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+            label = "lpass";
+            qcom,remote-pid = <2>;
+
+            /* ... */
+        };
+    };

-- 
b4 0.10.1
