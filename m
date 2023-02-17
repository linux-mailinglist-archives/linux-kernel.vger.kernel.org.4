Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6452969A9D6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 12:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjBQLJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 06:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQLJB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 06:09:01 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B516667B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:31 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o3so1207754lfo.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 03:08:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Um2Kl/FNAGgcNUPQ8sTcLRIWwPFplh3sZJwbntzDfbQ=;
        b=sUTZenwlhTixWXiRsFhf9UUdbO0XqOxWBVfTqt3u4geQTR0rDgp9Ghg23N/FLnWmRP
         SkBy4BKMABC4KZoTP4aeNMJ6q5S9YDKAVZycM9Mi9wMhJo3mvt4v52AyyVx3IbRRSoUs
         by7k95Fj34j2ihApmZ1NmnKC2ZfkPEQc/dBBQTRR1yIMC9VfgVlZbm3f4ACFIMSXB5E9
         jvqeUHzw2YsRA0UwjbqIzd/nMCEoIHVymgmX5GjryxVux78EXDOtIuMibEw7Z98puh3r
         Ly6wvM4beG+m0LtukYeYguhfUXQ3ZGriIID725wCVG+4+Pxwu5qvmwXoR9OxVuzNT3P5
         /g4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Um2Kl/FNAGgcNUPQ8sTcLRIWwPFplh3sZJwbntzDfbQ=;
        b=SZXeC58AQz2I3E34lwPiibc57N2CebFcj5JQ3yi3v5GjMkr0gYGtO2+nFIm3EATXV7
         39OkU2oeH00NlZh7nvdAcOtg/QN2t1fpO2VE12GbuC4+STJo2bbJEBnzzpL0E78iaIlu
         vdP0HFBVGEJj8dQGf8z8fHgG4chZFCjDNutomg8owOaMkDEd6uNh0tLYRNoliaeuMNFM
         Cv6WVahlSzlnFy9NGAVGwTydOPryVaYCYuiQiwaMKU1i0OT4hqN54JYsPUzF7t34ZjJy
         Kmhbm2E5dt6kP3Wi5ZXJ9ea4oF1f5Qo28mv9pms8FIKuNd1m0m71OmDXDR2D+nU8JkaL
         +u2w==
X-Gm-Message-State: AO0yUKVjuOAuBfTEf9ZKdyjiXgYEpa+OVLN2/TxwMn0gyEcaqiZFX4ad
        NW6Y5VFCQ0eQxQApruw2IUxMOQ==
X-Google-Smtp-Source: AK7set/+vMiAiiGiFVK0T2VcAbAWxtvrZ7/MkLOQpAXK50WH+LxV1q7AwdFDIEfOwXC0ZHEMrMpBRQ==
X-Received: by 2002:ac2:4c36:0:b0:4b5:936e:69df with SMTP id u22-20020ac24c36000000b004b5936e69dfmr2822368lfq.53.1676632110257;
        Fri, 17 Feb 2023 03:08:30 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512020c00b004b57162edfasm640162lfo.117.2023.02.17.03.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 03:08:29 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 17 Feb 2023 12:08:26 +0100
Subject: [PATCH v10 3/6] dt-bindings: soc: qcom: cpr3: Add bindings for
 CPR3 driver
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230217-topic-cpr3h-v10-3-67aed8fdfa61@linaro.org>
References: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
In-Reply-To: <20230217-topic-cpr3h-v10-0-67aed8fdfa61@linaro.org>
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
        Mark Brown <broonie@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1676632104; l=10567;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9ZySoMaLf8PyKdMzn1jPJg5xQ5me/gf5Q6oUNDsVvvI=;
 b=BHSsg3P5yPHulV9t5GnVmJlPJBvKfF8FQOlgS3cQrw7nf3J0y2qdtjx7gMT5uzthOqKBaK+yj4mq
 0Z5HgECuCcuYb/+uSHbwPaEHdpr+yDe4RZizJqtQbuWiSLydb6Mc
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/soc/qcom/qcom,cpr3.yaml    | 299 +++++++++++++++++++++
 1 file changed, 299 insertions(+)

diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
new file mode 100644
index 000000000000..18366c1e58b9
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
@@ -0,0 +1,299 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/soc/qcom/qcom,cpr3.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Qualcomm Core Power Reduction v3/v4/Hardened (CPR3, CPR4, CPRh)
+
+description: |
+  CPR (Core Power Reduction) is a technology to reduce core power on a CPU
+  or other device. Each OPP of a device corresponds to a "corner" that has
+  a range of valid voltages for a particular frequency. While the device is
+  running at a particular frequency, CPR monitors dynamic factors such as
+  temperature, etc. and suggests or, in the CPR-Hardened case performs,
+  adjustments to the voltage to save power and meet silicon characteristic
+  requirements.
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
+    minItems: 1
+    maxItems: 2
+
+  interrupts:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: "ref"
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
+  acc-syscon:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: phandle to syscon for writing ACC settings
+
+  nvmem-cells:
+    description: Cells containing the fuse corners and revision data
+    minItems: 10
+    maxItems: 32
+
+  nvmem-cell-names:
+    minItems: 10
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
+  - clock-names
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
+            - const: "cpr_speed_bin"
+            - const: "cpr_fuse_revision"
+            - const: "cpr0_quotient1"
+            - const: "cpr0_quotient2"
+            - const: "cpr0_quotient3"
+            - const: "cpr0_quotient4"
+            - const: "cpr0_quotient_offset2"
+            - const: "cpr0_quotient_offset3"
+            - const: "cpr0_quotient_offset4"
+            - const: "cpr0_init_voltage1"
+            - const: "cpr0_init_voltage2"
+            - const: "cpr0_init_voltage3"
+            - const: "cpr0_init_voltage4"
+            - const: "cpr0_ring_osc1"
+            - const: "cpr0_ring_osc2"
+            - const: "cpr0_ring_osc3"
+            - const: "cpr0_ring_osc4"
+            - const: "cpr1_quotient1"
+            - const: "cpr1_quotient2"
+            - const: "cpr1_quotient3"
+            - const: "cpr1_quotient4"
+            - const: "cpr1_quotient_offset2"
+            - const: "cpr1_quotient_offset3"
+            - const: "cpr1_quotient_offset4"
+            - const: "cpr1_init_voltage1"
+            - const: "cpr1_init_voltage2"
+            - const: "cpr1_init_voltage3"
+            - const: "cpr1_init_voltage4"
+            - const: "cpr1_ring_osc1"
+            - const: "cpr1_ring_osc2"
+            - const: "cpr1_ring_osc3"
+            - const: "cpr1_ring_osc4"
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
+            operating-points-v2 = <&cpu_gold_opp_table>;
+            power-domains = <&apc_cprh 0>;
+            power-domain-names = "cprh";
+        };
+
+        cpu@100 {
+            compatible = "qcom,kryo280";
+            device_type = "cpu";
+            reg = <0x0 0x100>;
+            operating-points-v2 = <&cpu_silver_opp_table>;
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
+        clock-names = "ref";
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
2.39.1

