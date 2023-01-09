Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CC3166217C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:27:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236481AbjAIJ0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:26:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233254AbjAIJ0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:26:45 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AD89B
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:26:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id g10so5788414wmo.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E+gc0w5hWfVZt2wiZtuzeDBan9gl3xA+7WK6wQRAV74=;
        b=vKR0QOYI/rOQ+WlWBIrflT2ln+b39zy8uB716rTZAbLdI9vQG8ISOyBwI3KahNcoBa
         AX+wlowVJ/Ruw/tZMKaG8CejZQCkg+5v6vG0+mTuGS/VXS3dvmF0I/hrufdlHW7dDSvo
         OYl+9UN/tHO+tsaZJIzeLLnpH0Ak1haslInzwXEZgZNp1jYiXB7V955R2zuCAodHBKcX
         YhDNfTjocbNglLQFeTPqTHosBBtJqEl/XpR3td4ezNBY2TWa/KfYEXVb8SzyCLU5x3BB
         DQ+AltUqx9uXGM8CweD32P8kv1KaSpszHowRRbFr9JsobpZx1i96gb/YeHAWOM8kBoAG
         zOuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E+gc0w5hWfVZt2wiZtuzeDBan9gl3xA+7WK6wQRAV74=;
        b=pvGPT4Has36fe2owMRdLo8GyG8dpeyq39jy6/uGTvVcj3nW26JXAiB+/DIrXDeovJP
         NkDDE+MZNCVaBMdqg9pwGihm7uF3fEwFF1Mxb8uUhjZi6tTikqSwwGZ16P9gJIKrDwva
         TL/7dUN+ylX0NRHjmtQXB1qUKychpa6LT+dosmvhV3kxflMEWRCZt65ve+QYcoAsh2d4
         ngC+iwxjr9fgbiUguxzKM2FZB5O2ufQwx5jipCHX3Z++C/ieW2nC/19fVdtbfquqWT95
         mc9s8WiSc4mvLK8UxvqBFFHLljslr0PScXqjCwM5roQNe/vmGQmJ9Gh2MMtSbqTLqmmu
         x9BQ==
X-Gm-Message-State: AFqh2kp798A2Y28f8VRv132wltl8xk6R68QJOlq/DmmQH1kyL9IBuBk6
        1V95F4f8KmhHGkpUdXEtiYJPIA==
X-Google-Smtp-Source: AMrXdXuAO8AszQ04C4sIU8mdVvqVfTBv/kxLC3UPIki9fIDrZJL5BKOVJdSE4Kk3MNwKx2CiRByeiA==
X-Received: by 2002:a05:600c:1e09:b0:3cf:b73f:bf8f with SMTP id ay9-20020a05600c1e0900b003cfb73fbf8fmr45111226wmb.7.1673256402579;
        Mon, 09 Jan 2023 01:26:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id s23-20020a1cf217000000b003d1e3b1624dsm15195758wmc.2.2023.01.09.01.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:26:42 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 10:26:34 +0100
Subject: [PATCH v2 2/7] dt-bindings: display/msm: document DPU on SM8550
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-mdss-dsi-v2-2-87f1c16d7635@linaro.org>
References: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-mdss-dsi-v2-0-87f1c16d7635@linaro.org>
To:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the DPU hardware found on the Qualcomm SM8550 platform.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/display/msm/qcom,sm8550-dpu.yaml      | 134 +++++++++++++++++++++
 1 file changed, 134 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
new file mode 100644
index 000000000000..c3d5a98fe3c0
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/msm/qcom,sm8550-dpu.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: GPL-2.0-only or BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/msm/qcom,sm8550-dpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8550 Display DPU
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+$ref: /schemas/display/msm/dpu-common.yaml#
+
+properties:
+  compatible:
+    const: qcom,sm8550-dpu
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
+      - description: Display AHB
+      - description: Display hf axi
+      - description: Display MDSS ahb
+      - description: Display lut
+      - description: Display core
+      - description: Display vsync
+
+  clock-names:
+    items:
+      - const: bus
+      - const: nrt_bus
+      - const: iface
+      - const: lut
+      - const: core
+      - const: vsync
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8550-dispcc.h>
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interconnect/qcom,sm8550.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    display-controller@ae01000 {
+        compatible = "qcom,sm8550-dpu";
+        reg = <0x0ae01000 0x8f000>,
+              <0x0aeb0000 0x2008>;
+        reg-names = "mdp", "vbif";
+
+        clocks = <&gcc GCC_DISP_AHB_CLK>,
+                <&gcc GCC_DISP_HF_AXI_CLK>,
+                <&dispcc DISP_CC_MDSS_AHB_CLK>,
+                <&dispcc DISP_CC_MDSS_MDP_LUT_CLK>,
+                <&dispcc DISP_CC_MDSS_MDP_CLK>,
+                <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        clock-names = "bus",
+                      "nrt_bus",
+                      "iface",
+                      "lut",
+                      "core",
+                      "vsync";
+
+        assigned-clocks = <&dispcc DISP_CC_MDSS_VSYNC_CLK>;
+        assigned-clock-rates = <19200000>;
+
+        operating-points-v2 = <&mdp_opp_table>;
+        power-domains = <&rpmhpd SM8550_MMCX>;
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
+                dpu_intf1_out: endpoint {
+                    remote-endpoint = <&dsi0_in>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                dpu_intf2_out: endpoint {
+                    remote-endpoint = <&dsi1_in>;
+                };
+            };
+        };
+
+        mdp_opp_table: opp-table {
+            compatible = "operating-points-v2";
+
+            opp-200000000 {
+                opp-hz = /bits/ 64 <200000000>;
+                required-opps = <&rpmhpd_opp_low_svs>;
+            };
+
+            opp-325000000 {
+                opp-hz = /bits/ 64 <325000000>;
+                required-opps = <&rpmhpd_opp_svs>;
+            };
+
+            opp-375000000 {
+                opp-hz = /bits/ 64 <375000000>;
+                required-opps = <&rpmhpd_opp_svs_l1>;
+            };
+
+            opp-514000000 {
+                opp-hz = /bits/ 64 <514000000>;
+                required-opps = <&rpmhpd_opp_nom>;
+            };
+        };
+    };
+...

-- 
2.34.1
