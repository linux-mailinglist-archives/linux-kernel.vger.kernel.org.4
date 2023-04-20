Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5727A6E9EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 00:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjDTWb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 18:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjDTWbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 18:31:42 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E574218
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4eca0563b31so937603e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682029891; x=1684621891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Lz/IEiPwvezP8Nrs8AL5uLLHF3AYMp3TDwKvNeVq6Ew=;
        b=XMLGmHejxhkNdnfcV6PP/eljXK7hGAcTCNMev7ZSpDEkboQiPM6NBXWZ13CjqhS/rQ
         pltSi17mXepFj0WyafmObSdImSo3hz7944kUXG6DBDMuUkcbSe7d9lWv19orvGgI1C5J
         9qlzD3m9GHoq7jL4R/IReUSfwHCFLFRYs8qhqj2JuR7Rz7j79RBnsIiJdOGrmpV8bvbw
         EC9FZuaiIJPCrFESb+UQSBI/lEgwB/Hy9cidojDm0v50CUSZGWrChKgaRPqFhxR8P5xH
         Ey9OF+z0CR3PpkSLhuE077o6iMBDjZwB824/3H5NNknv85GgNYxuZ/B0dl/Nx5tYtEs+
         J8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682029891; x=1684621891;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lz/IEiPwvezP8Nrs8AL5uLLHF3AYMp3TDwKvNeVq6Ew=;
        b=CNCQqqZIa/AmpLYoFiTCEMQ700+9GUk3BLZuNE3ynsSJxc8pYeM8BElfWnbhkkaswt
         cVi15fkj9ov/J5HmVD654gkh2xWO1bk5RoO/Gvmd5E5xtT4UzPVla8jUynfiEPTr5WXA
         qPgN2UxXZv+4qhyZP9Jua1L0yhrctdeSV7zthIXpXzZ438/EztFlrh3UlItoeQfU/PpT
         VNQg4nAgx+4pndgE13DM2xz32vRVPErAZiI/eVRqsR/rn7GNlfQtU3b/iuM4Ytl/GZjY
         fLSnHdiWmE3eMSXlrHOvmpM8q6endCbjtVSpAW9+P61ES6pmtWuXuGGudYHC0er+w880
         FgjQ==
X-Gm-Message-State: AAQBX9eH2/xyXgA68HJ5sb2QkEPEwAIWaE1AtnmX0qvNGwC4DIeWjkSv
        NmJ0VuEStsuPteqYpT+RNnPgyw==
X-Google-Smtp-Source: AKy350b/LoxX5cmbV2XERX6B3Daighg9BEb1v7QkIWYy4k8CsCfLnP3/T5ZmODaRMiIKXbEUASpmCQ==
X-Received: by 2002:a05:6512:208:b0:4a4:68b9:19e7 with SMTP id a8-20020a056512020800b004a468b919e7mr897920lfo.15.1682029891580;
        Thu, 20 Apr 2023 15:31:31 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id w8-20020ac25d48000000b004eedb66983csm324256lfd.273.2023.04.20.15.31.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 15:31:31 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Fri, 21 Apr 2023 00:31:15 +0200
Subject: [PATCH v2 06/13] dt-bindings: display/msm: Add SM6375 MDSS
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230411-topic-straitlagoon_mdss-v2-6-5def73f50980@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682029879; l=7042;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=NAfwHg47hKCKFK0+NQIcVu2PABcoM/KsJDZyi6LXodQ=;
 b=ztmVWXu2NN/CiemOQIkHaxNFh4zd6/8/49TptQ4i4ZtEPsJ7YjcNh0g9ioQdx2RS03p11T4AwfZ0
 S+oJv0FYB3KDMPVBSGj3lIZAEyQQYIuUtB2x/cFJdK6ZMqJMJJMP
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

Document the SM6375 MDSS.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/display/msm/qcom,sm6375-mdss.yaml     | 216 +++++++++++++++++++++
 1 file changed, 216 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
new file mode 100644
index 000000000000..fb56971ea2a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm6375-mdss.yaml
@@ -0,0 +1,216 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm6375-mdss.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM6375 Display MDSS
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description:
+  SM6375 MSM Mobile Display Subsystem (MDSS), which encapsulates sub-blocks
+  like DPU display controller, DSI and DP interfaces etc.
+
+$ref: /schemas/display/msm/mdss-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: qcom,sm6375-mdss
+
+  clocks:
+    items:
+      - description: Display AHB clock from gcc
+      - description: Display AHB clock
+      - description: Display core clock
+
+  clock-names:
+    items:
+      - const: iface
+      - const: ahb
+      - const: core
+
+  iommus:
+    maxItems: 1
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    maxItems: 2
+
+patternProperties:
+  "^display-controller@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm6375-dpu
+
+  "^dsi@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        items:
+          - const: qcom,sm6375-dsi-ctrl
+          - const: qcom,mdss-dsi-ctrl
+
+  "^phy@[0-9a-f]+$":
+    type: object
+    properties:
+      compatible:
+        const: qcom,sm6375-dsi-phy-7nm
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/clock/qcom,sm6375-gcc.h>
+    #include <dt-bindings/clock/qcom,sm6375-dispcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-subsystem@5e00000 {
+        compatible = "qcom,sm6375-mdss";
+        reg = <0x05e00000 0x1000>;
+        reg-names = "mdss";
+
+        power-domains = <&dispcc MDSS_GDSC>;
+
+        clocks = <&gcc GCC_DISP_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                 <&dispcc DISP_CC_MDSS_MDP_CLK>;
+        clock-names = "iface", "ahb", "core";
+
+        interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-controller;
+        #interrupt-cells = <1>;
+
+        iommus = <&apps_smmu 0x820 0x2>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+        ranges;
+
+        display-controller@5e01000 {
+            compatible = "qcom,sm6375-dpu";
+            reg = <0x05e01000 0x8e030>,
+                  <0x05eb0000 0x2008>;
+            reg-names = "mdp", "vbif";
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&gcc GCC_DISP_HF_AXI_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                     <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                     <&dispcc DISP_CC_MDSS_ROT_CLK>,
+                     <&dispcc DISP_CC_MDSS_VSYNC_CLK>,
+                     <&gcc GCC_DISP_THROTTLE_CORE_CLK>;
+            clock-names = "iface",
+                          "bus",
+                          "core",
+                          "lut",
+                          "rot",
+                          "vsync",
+                          "throttle";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            operating-points-v2 = <&mdp_opp_table>;
+            power-domains = <&rpmpd SM6375_VDDCX>;
+
+            interrupt-parent = <&mdss>;
+            interrupts = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dpu_intf1_out: endpoint {
+                        remote-endpoint = <&dsi0_in>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dpu_intf2_out: endpoint {
+                        remote-endpoint = <&dsi1_in>;
+                    };
+                };
+            };
+        };
+
+        dsi@5e94000 {
+            compatible = "qcom,sm6375-dsi-ctrl", "qcom,mdss-dsi-ctrl";
+            reg = <0x05e94000 0x400>;
+            reg-names = "dsi_ctrl";
+
+            interrupt-parent = <&mdss>;
+            interrupts = <4>;
+
+            clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK>,
+                     <&dispcc DISP_CC_MDSS_BYTE0_INTF_CLK>,
+                     <&dispcc DISP_CC_MDSS_PCLK0_CLK>,
+                     <&dispcc DISP_CC_MDSS_ESC0_CLK>,
+                     <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&gcc GCC_DISP_HF_AXI_CLK>;
+            clock-names = "byte",
+                          "byte_intf",
+                          "pixel",
+                          "core",
+                          "iface",
+                          "bus";
+
+            assigned-clocks = <&dispcc DISP_CC_MDSS_BYTE0_CLK_SRC>,
+                              <&dispcc DISP_CC_MDSS_PCLK0_CLK_SRC>;
+            assigned-clock-parents = <&mdss_dsi0_phy 0>, <&mdss_dsi0_phy 1>;
+
+            operating-points-v2 = <&dsi_opp_table>;
+            power-domains = <&rpmpd SM6375_VDDMX>;
+
+            phys = <&mdss_dsi0_phy>;
+            phy-names = "dsi";
+
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    dsi0_in: endpoint {
+                        remote-endpoint = <&dpu_intf1_out>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    dsi0_out: endpoint {
+                    };
+                };
+            };
+        };
+
+        mdss_dsi0_phy: phy@5e94400 {
+            compatible = "qcom,sm6375-dsi-phy-7nm";
+            reg = <0x05e94400 0x200>,
+                  <0x05e94600 0x280>,
+                  <0x05e94900 0x264>;
+            reg-names = "dsi_phy",
+                        "dsi_phy_lane",
+                        "dsi_pll";
+
+            #clock-cells = <1>;
+            #phy-cells = <0>;
+
+            clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                     <&rpmcc RPM_SMD_XO_CLK_SRC>;
+            clock-names = "iface", "ref";
+        };
+    };
+...

-- 
2.40.0

