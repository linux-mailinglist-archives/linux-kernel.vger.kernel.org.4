Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC4C16D8CBF
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 03:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234347AbjDFBbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 21:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbjDFBbS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:31:18 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A986EB9
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 18:31:14 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id y7so6774040ljp.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 18:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680744673;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CSrRjCQsmbqj/wv/a1/yZMyMyqp5mxIsDwyF+FffW3g=;
        b=kFm9KveG/fJDA4W4W2wdeLQxpwWCg/5RNbNE6GIrRqW/iGGSKKCEL1st+FEvAjGk7R
         8SpWI8n5JIjguFZ2uhq3nvguMe6CzuAKbz9bG+M8HDZ7uguB0PvpDqo26tf8gqD10vr+
         hI0nYbKjixH+fjudoaME+uytxkHVpAt0LLvO8OigXP3ZgTO3Ij4O9vpHopG5/MNWFFnp
         aUOG84r+7S6HXKXTMLxg7w7HmTywc+TFLGzon9ZUjI0Feo54b9NHwvM0gif49YTixG9T
         6W+THaVUF28UUkUYl2jKD4iy6I7NnMfzrnvbLwKuDGZMwjZYurYiI1VYNjAlQlYFVSf7
         MJDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680744673;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CSrRjCQsmbqj/wv/a1/yZMyMyqp5mxIsDwyF+FffW3g=;
        b=7vTDwCwjvxjteIxeTuREMPL+mW127BlfBKO+Y3mZrNJlVEUQDBmPIjwj54XcycLBZO
         DMD40g0hhmcnDmlA4wFv2mTf0BlhYZr+CkNJ9l7ndDoJhHExT44NsQQIIqO0DAhwKa/8
         /EPRenpyfuiEfllyryeyRFiKnNa7PrvG2ZkEe0KT0mOrclN/O5YmgwJCe+0YY0dJllGO
         82l1qIUKrPdRnTPMO7PkiJhqxekzOhM+mibmcz3ECFkvsQeE0g6eVIkSvZ8WgXkkp4FO
         YE32DE/EBcE5/ivtEvj5zxZQGeN+twurlMrc2bWIgRXjuwyVkl/gQx6ABIU5rfD0raOw
         /4OA==
X-Gm-Message-State: AAQBX9d25PN94P1AS3dzJktGyCptYge/wr5tJ5ddnKMQwVM0TqqRdexl
        lNZJ9PA4lNMypETjttlSx9ElAw==
X-Google-Smtp-Source: AKy350Y4TY0FmFDViv5jfvptjRz6lI7gqXueo0pWn90UcUx3RJ3mD/1bBurBI/Agh0gjoD7sv8BZZw==
X-Received: by 2002:a2e:8507:0:b0:29f:390:6641 with SMTP id j7-20020a2e8507000000b0029f03906641mr2578983lji.11.1680744672711;
        Wed, 05 Apr 2023 18:31:12 -0700 (PDT)
Received: from [192.168.1.101] (abxh37.neoplus.adsl.tpnet.pl. [83.9.1.37])
        by smtp.gmail.com with ESMTPSA id z4-20020a2e8404000000b002a483f01d9csm14222ljg.85.2023.04.05.18.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Apr 2023 18:31:12 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 06 Apr 2023 03:31:08 +0200
Subject: [PATCH] dt-bindings: iommu: Convert QCOM IOMMU to YAML
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230406-topic-qciommu-v1-1-03f17717a447@linaro.org>
X-B4-Tracking: v=1; b=H4sIANsgLmQC/x2NywqDMBAAf0X23IX4QFt/pXiI60YXNNFERRD/v
 UuPMzDMDYmjcII2uyHyKUmCV8hfGdBk/cgogzIUpihNZWrcwyqEG0lYlgMbavJy4LdzHwZteps
 Y+2g9TVr5Y55VrpGdXP/Jt3ueH6F0Bs50AAAA
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1680744671; l=7256;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=z8HCrPvi1fKv6OJnTFPhKhw+sxnsX3KR5dCrGbmbmoY=;
 b=fr4XqlN1G29CA4GNNexEwZpf4A4qxp8Elf3nNHjh5xumdpyKPN+bT11jryh6bKZ32gjWcNuSRCc0
 VtidLQ7UCvidzyC9YveUTjlezUUtFdicPTIt7OfJkuxV3DfUP6kg
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Qualcomm IOMMU bindings to YAML.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
foobar b4 requires I put some text here
---
 .../devicetree/bindings/iommu/qcom,iommu.txt       | 122 ---------------------
 .../devicetree/bindings/iommu/qcom,iommu.yaml      | 110 +++++++++++++++++++
 2 files changed, 110 insertions(+), 122 deletions(-)

diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt b/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
deleted file mode 100644
index e6cecfd360eb..000000000000
--- a/Documentation/devicetree/bindings/iommu/qcom,iommu.txt
+++ /dev/null
@@ -1,122 +0,0 @@
-* QCOM IOMMU v1 Implementation
-
-Qualcomm "B" family devices which are not compatible with arm-smmu have
-a similar looking IOMMU but without access to the global register space,
-and optionally requiring additional configuration to route context irqs
-to non-secure vs secure interrupt line.
-
-** Required properties:
-
-- compatible       : Should be one of:
-
-                        "qcom,msm8916-iommu"
-                        "qcom,msm8953-iommu"
-
-                     Followed by "qcom,msm-iommu-v1".
-
-- clock-names      : Should be a pair of "iface" (required for IOMMUs
-                     register group access) and "bus" (required for
-                     the IOMMUs underlying bus access).
-
-- clocks           : Phandles for respective clocks described by
-                     clock-names.
-
-- #address-cells   : must be 1.
-
-- #size-cells      : must be 1.
-
-- #iommu-cells     : Must be 1.  Index identifies the context-bank #.
-
-- ranges           : Base address and size of the iommu context banks.
-
-- qcom,iommu-secure-id  : secure-id.
-
-- List of sub-nodes, one per translation context bank.  Each sub-node
-  has the following required properties:
-
-  - compatible     : Should be one of:
-        - "qcom,msm-iommu-v1-ns"  : non-secure context bank
-        - "qcom,msm-iommu-v1-sec" : secure context bank
-  - reg            : Base address and size of context bank within the iommu
-  - interrupts     : The context fault irq.
-
-** Optional properties:
-
-- reg              : Base address and size of the SMMU local base, should
-                     be only specified if the iommu requires configuration
-                     for routing of context bank irq's to secure vs non-
-                     secure lines.  (Ie. if the iommu contains secure
-                     context banks)
-
-
-** Examples:
-
-	apps_iommu: iommu@1e20000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#iommu-cells = <1>;
-		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-		ranges = <0 0x1e20000 0x40000>;
-		reg = <0x1ef0000 0x3000>;
-		clocks = <&gcc GCC_SMMU_CFG_CLK>,
-			 <&gcc GCC_APSS_TCU_CLK>;
-		clock-names = "iface", "bus";
-		qcom,iommu-secure-id = <17>;
-
-		// mdp_0:
-		iommu-ctx@4000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x4000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		// venus_ns:
-		iommu-ctx@5000 {
-			compatible = "qcom,msm-iommu-v1-sec";
-			reg = <0x5000 0x1000>;
-			interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	gpu_iommu: iommu@1f08000 {
-		#address-cells = <1>;
-		#size-cells = <1>;
-		#iommu-cells = <1>;
-		compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
-		ranges = <0 0x1f08000 0x10000>;
-		clocks = <&gcc GCC_SMMU_CFG_CLK>,
-			 <&gcc GCC_GFX_TCU_CLK>;
-		clock-names = "iface", "bus";
-		qcom,iommu-secure-id = <18>;
-
-		// gfx3d_user:
-		iommu-ctx@1000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x1000 0x1000>;
-			interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
-		// gfx3d_priv:
-		iommu-ctx@2000 {
-			compatible = "qcom,msm-iommu-v1-ns";
-			reg = <0x2000 0x1000>;
-			interrupts = <GIC_SPI 242 IRQ_TYPE_LEVEL_HIGH>;
-		};
-	};
-
-	...
-
-	venus: video-codec@1d00000 {
-		...
-		iommus = <&apps_iommu 5>;
-	};
-
-	mdp: mdp@1a01000 {
-		...
-		iommus = <&apps_iommu 4>;
-	};
-
-	gpu@1c00000 {
-		...
-		iommus = <&gpu_iommu 1>, <&gpu_iommu 2>;
-	};
diff --git a/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
new file mode 100644
index 000000000000..b33236c0f9ef
--- /dev/null
+++ b/Documentation/devicetree/bindings/iommu/qcom,iommu.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iommu/qcom,iommu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies legacy IOMMU implementations
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm "B" family devices which are not compatible with arm-smmu have
+  a similar looking IOMMU, but without access to the global register space
+  and optionally requiring additional configuration to route context IRQs
+  to non-secure vs secure interrupt line.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - qcom,msm8916-iommu
+          - qcom,msm8953-iommu
+      - const: qcom,msm-iommu-v1
+
+  clocks:
+    items:
+      - description: Clock required for IOMMU register group access
+      - description: Clock required for underlying bus access
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+
+  power-domains:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  ranges: true
+
+  qcom,iommu-secure-id:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      The SCM secure ID of the IOMMU instance.
+
+  '#address-cells':
+    const: 1
+
+  '#size-cells':
+    const: 1
+
+  '#iommu-cells':
+    const: 1
+
+patternProperties:
+  "^iommu-ctx@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        enum:
+          - qcom,msm-iommu-v1-ns
+          - qcom,msm-iommu-v1-sec
+
+      interrupts:
+        maxItems: 1
+
+      reg:
+        maxItems: 1
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+  - '#iommu-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    apps_iommu: iommu@1e20000 {
+      compatible = "qcom,msm8916-iommu", "qcom,msm-iommu-v1";
+      reg = <0x1ef0000 0x3000>;
+      clocks = <&gcc GCC_SMMU_CFG_CLK>,
+               <&gcc GCC_APSS_TCU_CLK>;
+      clock-names = "iface", "bus";
+      qcom,iommu-secure-id = <17>;
+      #address-cells = <1>;
+      #size-cells = <1>;
+      #iommu-cells = <1>;
+      ranges = <0 0x1e20000 0x40000>;
+
+      /* mdp_0: */
+      iommu-ctx@4000 {
+        compatible = "qcom,msm-iommu-v1-ns";
+        reg = <0x4000 0x1000>;
+        interrupts = <GIC_SPI 70 IRQ_TYPE_LEVEL_HIGH>;
+      };
+    };
+
+    mdp: mdp@1a01000 {
+      iommus = <&apps_iommu 4>;
+    };

---
base-commit: 8417c8f5007bf4567ccffda850a3157c7d905f67
change-id: 20230406-topic-qciommu-7c713de8ff9e

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

