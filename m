Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFF76E9EF5
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbjDTWbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjDTWbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:31:38 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCA761BD
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:31 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4edcdfa8638so955130e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029890; x=1684621890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/ClOH4eySn6pgIjpy+oC1BfRBQnYTvzfBmb6SYfUGI=;
        b=xU9orBvXPHxzW2vhRvYLN2Yh3+4dnkFsRxJkrKPCxZ6OIIbO3CcTE9cHLoqnt2uOxV
         cM0SZm7l1er1VvM0uE0LrjEdbc66eVK4SNUx22aJ3vEamJsMK+przGALxbC92kfzI1Xg
         11GUg49b/oMSlmgFqPCC37kA0xOfVk1ChudfcwdS/RLwfqOdQ7+Kr/kWIIIO8KVcGsA9
         CppqmX/SKadd2u67TFdqom83ZvUApsnNjPcfAnvRMeeQlgFAGbuo/FHLMjJ+jBob4k/X
         V5ZLKkkKC9vBp4noRwAki/pnS+KygXW1LzgKKVdxWulPBIBPUEZKWNdMol86qgTJbcP5
         wUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029890; x=1684621890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H/ClOH4eySn6pgIjpy+oC1BfRBQnYTvzfBmb6SYfUGI=;
        b=PFEWWYKyF10Nt8ry05EcEmKVCbZk2BOqENFMEJjg4rSISWCmCI/rFLiqye8tIzsy+B
         2hYqGynpN7z3h1Ny49gvwLBteQQxPFSk2w/jMx3KPnvJrIFWfLlVKZbyfAeqF0bqVnzc
         MdM6atTt1jOZd68lEypheE/M4n0D55bg1MYUw6Hba/2liH0CUp+RieQTci4LRURdIbXz
         jFxfNXMm8eBWww8zsGoeqYLEUuRTw3u7vF9er+xNy/bqQ1oTgTAEMpMa1vbe7fhV5SAk
         SVIBu4TCLzNiwq8P8/Fi9Dqn1vam0XodAPHBXEx4G+s1W9Kue1N/kGe7BW+K3f7Jjr9P
         qBIw==
X-Gm-Message-State: AAQBX9cBNEWefJC07n9AdiIpxxcnuaQrbM4j/bIdIY1h5mmlsD7C/FG9
        qBTjsgJyS5MuCliXU7QqdzGoaA==
X-Google-Smtp-Source: AKy350YasXikHQw7hRtwQ9T3OjMiyqTGMx/+6rQOFaYlOHkdtIoTQa4HUY8K62IoCGIeWrZYZoDcRw==
X-Received: by 2002:ac2:5198:0:b0:4eb:1048:1285 with SMTP id u24-20020ac25198000000b004eb10481285mr717653lfi.47.1682029889847;
        Thu, 20 Apr 2023 15:31:29 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:29 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Apr 2023 00:31:14 +0200
Subject: [PATCH v2 05/13] dt-bindings: display/msm: Add SM6375 DPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-5-5def73f50980@linaro.org>
References: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
In-Reply-To: <20230411-topic-straitlagoon_mdss-v2-0-5def73f50980@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux.dev, Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=3492;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=vZzhA97oxdwZ/IPQF/OKwzeLk8iG5rTuB8ZFpx6DRZ0=;
 b=LHP9urgYRNjLl/5VSCLQUISqeihQSxNIUZy+XvNKkOEL9JqpSWQ2vdVfistdyy8B/5eY1mn0oqT/
 KKMShazuBkrzUMnshYU5IHSJ7DAkhujaMV7IaAqS4nX6dB6v7NvC
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document SM6375 DPU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/msm/qcom,sm6375-dpu.yaml      | 106 +++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-dpu.yaml
new file mode 100644
index 000000000000..76dc5a7efebf
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-dpu.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display DPU dt properties for SM6375 target
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+$ref: /schemas/display/msm/dpu-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,sm6375-dpu
+
+  reg:
+    items:
+      - description: Address offset and size for mdp register set
+      - description: Address offset and size for vbif register set
+
+  reg-names:
+    items:
+      - const: mdp
+      - const: vbif
+
+  clocks:
+    items:
+      - description: Display iface clock
+      - description: Display bus clock
+      - description: Display core clock
+      - description: Display lut clock
+      - description: Display rot clock
+      - description: Display vsync clock
+      - description: Display throttle clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: bus
+      - const: core
+      - const: lut
+      - const: rot
+      - const: vsync
+      - const: throttle
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-controller@ae01000 {
+        compatible = "qcom,sm6375-dpu";
+        reg = <0x05e01000 0x8e030>,
+              <0x05eb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&gcc GCC_DISP_HF_AXI_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                 <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                 <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+                 <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
+        clock-names = "iface",
+                      "bus",
+                      "core",
+                      "lut",
+                      "rot",
+                      "vsync",
+                      "throttle";
+
+        assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        assigned-clock-rates = <19200000>;
+
+        operating-points-v2 = <&mdp_opp_table>;
+        power-domains = <&rpmpd SM6375_VDDCX>;
+
+        interrupt-parent = <&mdss>;
+        interrupts = <0>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                endpoint {
+                    remote-endpoint = <&dsi0_in>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                endpoint {
+                    remote-endpoint = <&dsi1_in>;
+                };
+            };
+        };
+    };
+...

-- 
2.40.0

