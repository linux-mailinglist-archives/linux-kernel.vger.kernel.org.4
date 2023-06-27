Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B12A740344
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 20:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjF0SbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 14:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjF0Sa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 14:30:57 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB775198C
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:53 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fa48b5dc2eso5055851e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 11:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687890652; x=1690482652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/mDU0vzze/ov8lSvaXaSMAceWfhtBvQ2qAMt330k4/s=;
        b=hPWB0x8eIfOr5T9M6wTeoBjfDEgt4CAfyRPXRCbA1scR7I8PGdGVJxdyZNID6J8ojw
         lNwtP/UZuI4f1nACmWa8uAlKo82MY3vS/VUZqioUghk8T/KaGbFWgc602CTSWbQ/oCRP
         kfBgPuY2D2lYS081h01rlNCUR2KGltH+UaeALhzApdKFtPpQP2urmlSv0yLrGOZ7BFuA
         O1ChTcgTFUvyRHzAwtU5M1eoG3V1tCJeAPAMVxv79Vbr3Xq2co+tIpzUatPGqSUn62lR
         KiifHM+6ynq4bxyJ+UVxdA6c0agvrhFCVt+tHbb8+MlNh5Mlh+8XtQzIAlTFhjWzJIcb
         otWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687890652; x=1690482652;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mDU0vzze/ov8lSvaXaSMAceWfhtBvQ2qAMt330k4/s=;
        b=SjJA58Wn5zft4cqejjB9e8fqi3cR982W4V/jGdQ8UNdyqExhYhcLQ1g7jQjKGBH48q
         mBMDFma2wYRsWejGSeY7pWVWIJDdRoB3mvv+L5D9/vJgwJJZkLDxvrUr4a1e1u8q8dUq
         qJCRg9ZpAHrPKMSowRmEBwz/JTfmg5UPP8d2oYO6IjFxdPp+TEbyhKpxxnS6/La/JyMK
         KtR/QrBTjJafqiNsSwDm9FW4dLPDON49wAAF34wWh6ElSH2bUie1vgCv7TRABoxemcWv
         uB8Okrrtvd16Bdn2/aDCGLVbwfUIseI51WqYUazFq026YqbaDZ5VQuAWkVMSk7M3RfOH
         wnqg==
X-Gm-Message-State: AC+VfDwqL9RbO9aBOLHH2e4GUqyVsuv47Y7daVouR7c6cmCIs3fAhCg6
        Yg1j6/ltfg5icm58YApTLxTZcA==
X-Google-Smtp-Source: ACHHUZ6YiI5NAZaKA6lqnRCBNA00i1T5NLQICfkw4pgHVUSTv5fIGjiXHXSzUqME9SSktIUGry49XQ==
X-Received: by 2002:ac2:4f12:0:b0:4ed:cc6d:61fe with SMTP id k18-20020ac24f12000000b004edcc6d61femr5638591lfr.24.1687890652053;
        Tue, 27 Jun 2023 11:30:52 -0700 (PDT)
Received: from [192.168.1.101] (abxj103.neoplus.adsl.tpnet.pl. [83.9.3.103])
        by smtp.gmail.com with ESMTPSA id q16-20020ac25290000000b004f640b0fb04sm1605205lfm.212.2023.06.27.11.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 11:30:51 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Tue, 27 Jun 2023 20:30:39 +0200
Subject: [PATCH v11 3/9] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v11-3-ba22b4daa5d6@linaro.org>
References: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v11-0-ba22b4daa5d6@linaro.org>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Niklas Cassel <nks@flawful.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1687890646; l=10291;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=XsgCikCmVAkzuppoOZcUQl3FsJV4tSEV5u46Y3qt2EA=;
 b=d0EOcuxI6wpX0vXWGn3hm2KKdb23tzJwu2rQ2Za6mq0kGDUsSVJ6sTLWAZPltQCAmctoe/Xrv
 QKjKBwJYMTlDqXxd2O2KOYGiwNTD5wEnxWFt/5vE5sqp14nwORdstxm
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

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>

Add the bindings for the CPR3 driver to the documentation.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
[Konrad: Make binding check pass; update AGdR's email]
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 289 +++++++++++++++++++++
 1 file changed, 289 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
new file mode 100644
index 000000000000..46b94dffaf85
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -0,0 +1,289 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
+
+description:
+  CPR (Core Power Reduction) is a technology to reduce core power of a CPU
+  (or another device). Each OPP of a device corresponds to a "corner" that
+  has a range of valid voltages for a particular frequency.
+  The CPR monitors dynamic factors such as temperature, etc. and suggests
+  or (in the CPR-hardened case) applies voltage adjustments to save power
+  and meet silicon characteristic requirements for a given chip unit.
+
+maintainers:
+  - AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+
+properties:
+  compatible:
+    oneOf:
+      - description: CPRv3 controller
+        items:
+          - const: qcom,cpr3
+      - description: CPRv4 controller
+        items:
+          - const: qcom,cpr4
+      - description: CPRv4-Hardened controller
+        items:
+          - enum:
+              - qcom,msm8998-cprh
+              - qcom,sdm630-cprh
+          - const: qcom,cprh
+
+  reg:
+    description: Base address and size of the CPR controller(s)
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: CPR reference clock
+
+  vdd-supply:
+    description: Autonomous Phase Control (APC) or other power supply
+
+  '#power-domain-cells':
+    const: 1
+
+  qcom,acc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to syscon for writing ACC settings
+
+  nvmem-cells:
+    description: Cells containing the fuse corners and revision data
+    maxItems: 32
+
+  nvmem-cell-names:
+    maxItems: 32
+
+  operating-points-v2: true
+
+  power-domains: true
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - operating-points-v2
+  - "#power-domain-cells"
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,msm8998-cprh
+    then:
+      properties:
+        nvmem-cell-names:
+          items:
+            - const: cpr_speed_bin
+            - const: cpr_fuse_revision
+            - const: cpr0_quotient1
+            - const: cpr0_quotient2
+            - const: cpr0_quotient3
+            - const: cpr0_quotient4
+            - const: cpr0_quotient_offset2
+            - const: cpr0_quotient_offset3
+            - const: cpr0_quotient_offset4
+            - const: cpr0_init_voltage1
+            - const: cpr0_init_voltage2
+            - const: cpr0_init_voltage3
+            - const: cpr0_init_voltage4
+            - const: cpr0_ring_osc1
+            - const: cpr0_ring_osc2
+            - const: cpr0_ring_osc3
+            - const: cpr0_ring_osc4
+            - const: cpr1_quotient1
+            - const: cpr1_quotient2
+            - const: cpr1_quotient3
+            - const: cpr1_quotient4
+            - const: cpr1_quotient_offset2
+            - const: cpr1_quotient_offset3
+            - const: cpr1_quotient_offset4
+            - const: cpr1_init_voltage1
+            - const: cpr1_init_voltage2
+            - const: cpr1_init_voltage3
+            - const: cpr1_init_voltage4
+            - const: cpr1_ring_osc1
+            - const: cpr1_ring_osc2
+            - const: cpr1_ring_osc3
+            - const: cpr1_ring_osc4
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8998.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    cpus {
+        #address-cells = <2>;
+        #size-cells = <0>;
+
+        cpu@0 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x0>;
+            operating-points-v2 = <&cpu0_opp_table>;
+            power-domains = <&apc_cprh 0>;
+            power-domain-names = "cprh";
+        };
+
+        cpu@100 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x100>;
+            operating-points-v2 = <&cpu4_opp_table>;
+            power-domains = <&apc_cprh 1>;
+            power-domain-names = "cprh";
+        };
+    };
+
+    cpu0_opp_table: opp-table-cpu0 {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-1843200000 {
+            opp-hz = /bits/ 64 <1843200000>;
+            required-opps = <&cprh_opp3>;
+        };
+
+        opp-1094400000 {
+            opp-hz = /bits/ 64 <1094400000>;
+            required-opps = <&cprh_opp2>;
+        };
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cpu4_opp_table: opp-table-cpu4 {
+        compatible = "operating-points-v2";
+        opp-shared;
+
+        opp-2208000000 {
+            opp-hz = /bits/ 64 <2208000000>;
+            required-opps = <&cprh_opp3>;
+        };
+
+        opp-1113600000 {
+            opp-hz = /bits/ 64 <1113600000>;
+            required-opps = <&cprh_opp2>;
+        };
+
+        opp-300000000 {
+            opp-hz = /bits/ 64 <300000000>;
+            required-opps = <&cprh_opp1>;
+        };
+    };
+
+    cprh_opp_table: opp-table-cprh {
+        compatible = "operating-points-v2-qcom-level";
+
+        cprh_opp1: opp-1 {
+            opp-level = <1>;
+            qcom,opp-fuse-level = <1>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+
+        cprh_opp2: opp-2 {
+            opp-level = <2>;
+            qcom,opp-fuse-level = <2>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+
+        cprh_opp3: opp-3 {
+            opp-level = <3>;
+            qcom,opp-fuse-level = <2 3>;
+            qcom,opp-cloop-vadj = <0>;
+            qcom,opp-oloop-vadj = <0>;
+        };
+    };
+
+    apc_cprh: power-controller@179c8000 {
+        compatible = "qcom,msm8998-cprh", "qcom,cprh";
+        reg = <0x0179c8000 0x4000>, <0x0179c4000 0x4000>;
+        clocks = <&gcc GCC_HMSS_RBCPR_CLK>;
+
+        operating-points-v2 = <&cprh_opp_table>;
+        #power-domain-cells = <1>;
+
+        nvmem-cells = <&cpr_efuse_speedbin>,
+                      <&cpr_fuse_revision>,
+                      <&cpr_quot0_pwrcl>,
+                      <&cpr_quot1_pwrcl>,
+                      <&cpr_quot2_pwrcl>,
+                      <&cpr_quot3_pwrcl>,
+                      <&cpr_quot_offset1_pwrcl>,
+                      <&cpr_quot_offset2_pwrcl>,
+                      <&cpr_quot_offset3_pwrcl>,
+                      <&cpr_init_voltage0_pwrcl>,
+                      <&cpr_init_voltage1_pwrcl>,
+                      <&cpr_init_voltage2_pwrcl>,
+                      <&cpr_init_voltage3_pwrcl>,
+                      <&cpr_ro_sel0_pwrcl>,
+                      <&cpr_ro_sel1_pwrcl>,
+                      <&cpr_ro_sel2_pwrcl>,
+                      <&cpr_ro_sel3_pwrcl>,
+                      <&cpr_quot0_perfcl>,
+                      <&cpr_quot1_perfcl>,
+                      <&cpr_quot2_perfcl>,
+                      <&cpr_quot3_perfcl>,
+                      <&cpr_quot_offset1_perfcl>,
+                      <&cpr_quot_offset2_perfcl>,
+                      <&cpr_quot_offset3_perfcl>,
+                      <&cpr_init_voltage0_perfcl>,
+                      <&cpr_init_voltage1_perfcl>,
+                      <&cpr_init_voltage2_perfcl>,
+                      <&cpr_init_voltage3_perfcl>,
+                      <&cpr_ro_sel0_perfcl>,
+                      <&cpr_ro_sel1_perfcl>,
+                      <&cpr_ro_sel2_perfcl>,
+                      <&cpr_ro_sel3_perfcl>;
+        nvmem-cell-names = "cpr_speed_bin",
+                           "cpr_fuse_revision",
+                           "cpr0_quotient1",
+                           "cpr0_quotient2",
+                           "cpr0_quotient3",
+                           "cpr0_quotient4",
+                           "cpr0_quotient_offset2",
+                           "cpr0_quotient_offset3",
+                           "cpr0_quotient_offset4",
+                           "cpr0_init_voltage1",
+                           "cpr0_init_voltage2",
+                           "cpr0_init_voltage3",
+                           "cpr0_init_voltage4",
+                           "cpr0_ring_osc1",
+                           "cpr0_ring_osc2",
+                           "cpr0_ring_osc3",
+                           "cpr0_ring_osc4",
+                           "cpr1_quotient1",
+                           "cpr1_quotient2",
+                           "cpr1_quotient3",
+                           "cpr1_quotient4",
+                           "cpr1_quotient_offset2",
+                           "cpr1_quotient_offset3",
+                           "cpr1_quotient_offset4",
+                           "cpr1_init_voltage1",
+                           "cpr1_init_voltage2",
+                           "cpr1_init_voltage3",
+                           "cpr1_init_voltage4",
+                           "cpr1_ring_osc1",
+                           "cpr1_ring_osc2",
+                           "cpr1_ring_osc3",
+                           "cpr1_ring_osc4";
+    };
+...

-- 
2.41.0

