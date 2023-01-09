Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 999826621E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 10:44:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbjAIJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 04:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjAIJoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 04:44:16 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DB2657F
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 01:44:14 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id m7so7521350wrn.10
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 01:44:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78I4BfLAwXemQHRA2Z9SJEKYwTSclGWOUVaDz+fwvT4=;
        b=tQD9ux1zq53CEEQVcXi9/efEqeMgFjG7aaioh94Dj9PVtTPk1pWOhlxOtLoz5VBSQP
         XWAd/8c2yLRxPdsc2NjETd1lMNtjjCzg5/gwblydbhNBEWTDILweygPdH479JBYGtri7
         CjXetsqtyvoSgeXqxJ+bfmbfWi4qaIxhk0j5o47e0IgH0see/xWPp3iTGPf7skr/3P93
         IBClGA7Jg2I+DtgmvCtM6k2EIbYq8bFO0jo6Q5SftgJmC4+Tsu8gmufIQ8eJx3jUcKkz
         u+KIZscbi1N+tvw44UzPtRfugVm/8+eR+jtCyyMA+cO/l4OVC5pkzw6acExu9iT3re7a
         Gj0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=78I4BfLAwXemQHRA2Z9SJEKYwTSclGWOUVaDz+fwvT4=;
        b=WWNxtu4oORE3t5T/gKE6aP4HHHVCthKWivzmQi/9+peh2BNdVdt96CpbFdTzCn5ga+
         gDrVcWOT2I2Ri25BP3gUWLQ3qwT3j9ycaJC9JPzpXY9GbL0s4l3VtTAcTBVTuclZfHmY
         DhBO2hHLe8Ocs7H9rQT47Skt6JnsNJ2zoNxpTaJcs8sJNiwSrsyzV086Udo+pceefJkv
         JHdzmox6rk6N8P+lhdMH3fVFdXeaBAbGJ/8SK3OalLVIcAmFUCINbiED2eTe6ENBdkLL
         +30vGrIFt5NXLSVeJTGfvY9I5yHYJPlrnWVhJB1yAsn0IoGNZ49hnkuhAry6+BmGHjjO
         BjWw==
X-Gm-Message-State: AFqh2krH8GIqiqRlvgrAshbaY7L1S1LJuHkxFjoVTvqrIOqy3miucoav
        6V85UjuGXAMhoSRJ/Kxzay0dLw==
X-Google-Smtp-Source: AMrXdXu6IBjgTL6q/mWRVS9EGIEadX+X4rO4sGABAiYG2ZCUkwnMYZXHDE3MrrPalY2TArxWP44VVw==
X-Received: by 2002:a5d:404c:0:b0:2bb:ea1d:e36e with SMTP id w12-20020a5d404c000000b002bbea1de36emr2874247wrp.15.1673257453045;
        Mon, 09 Jan 2023 01:44:13 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id f7-20020a5d6647000000b002bbeb700c38sm2965185wrw.91.2023.01.09.01.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 01:44:12 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 09 Jan 2023 10:43:28 +0100
Subject: [PATCH v2 1/3] dt-bindings: clock: document SM8550 DISPCC clock controller
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230103-topic-sm8550-upstream-dispcc-v2-1-786ddd8785a2@linaro.org>
References: <20230103-topic-sm8550-upstream-dispcc-v2-0-786ddd8785a2@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v2-0-786ddd8785a2@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.11.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document device tree bindings for display clock controller for
Qualcomm SM8550 SoC.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/clock/qcom,sm8550-dispcc.yaml         | 105 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8550-dispcc.h     | 101 ++++++++++++++++++++
 2 files changed, 206 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
new file mode 100644
index 000000000000..ab25f7cbaa2e
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
@@ -0,0 +1,105 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8550-dispcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Display Clock & Reset Controller for SM8550
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  Qualcomm display clock control module provides the clocks, resets and power
+  domains on SM8550.
+
+  See also:: include/dt-bindings/clock/qcom,sm8550-dispcc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8550-dispcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board Always On XO source
+      - description: Display's AHB clock
+      - description: sleep clock
+      - description: Byte clock from DSI PHY0
+      - description: Pixel clock from DSI PHY0
+      - description: Byte clock from DSI PHY1
+      - description: Pixel clock from DSI PHY1
+      - description: Link clock from DP PHY0
+      - description: VCO DIV clock from DP PHY0
+      - description: Link clock from DP PHY1
+      - description: VCO DIV clock from DP PHY1
+      - description: Link clock from DP PHY2
+      - description: VCO DIV clock from DP PHY2
+      - description: Link clock from DP PHY3
+      - description: VCO DIV clock from DP PHY3
+
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  reg:
+    maxItems: 1
+
+  power-domains:
+    description:
+      A phandle and PM domain specifier for the MMCX power domain.
+    maxItems: 1
+
+  required-opps:
+    description:
+      A phandle to an OPP node describing required MMCX performance point.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    clock-controller@af00000 {
+      compatible = "qcom,sm8550-dispcc";
+      reg = <0x0af00000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&gcc GCC_DISP_AHB_CLK>,
+               <&sleep_clk>,
+               <&dsi0_phy 0>,
+               <&dsi0_phy 1>,
+               <&dsi1_phy 0>,
+               <&dsi1_phy 1>,
+               <&dp0_phy 0>,
+               <&dp0_phy 1>,
+               <&dp1_phy 0>,
+               <&dp1_phy 1>,
+               <&dp2_phy 0>,
+               <&dp2_phy 1>,
+               <&dp3_phy 0>,
+               <&dp3_phy 1>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+      power-domains = <&rpmhpd SM8550_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8550-dispcc.h b/include/dt-bindings/clock/qcom,sm8550-dispcc.h
new file mode 100644
index 000000000000..ed3094c694e0
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8550-dispcc.h
@@ -0,0 +1,101 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_SM8550_DISP_CC_H
+#define _DT_BINDINGS_CLK_QCOM_SM8550_DISP_CC_H
+
+/* DISP_CC clocks */
+#define DISP_CC_MDSS_ACCU_CLK					0
+#define DISP_CC_MDSS_AHB1_CLK					1
+#define DISP_CC_MDSS_AHB_CLK					2
+#define DISP_CC_MDSS_AHB_CLK_SRC				3
+#define DISP_CC_MDSS_BYTE0_CLK					4
+#define DISP_CC_MDSS_BYTE0_CLK_SRC				5
+#define DISP_CC_MDSS_BYTE0_DIV_CLK_SRC				6
+#define DISP_CC_MDSS_BYTE0_INTF_CLK				7
+#define DISP_CC_MDSS_BYTE1_CLK					8
+#define DISP_CC_MDSS_BYTE1_CLK_SRC				9
+#define DISP_CC_MDSS_BYTE1_DIV_CLK_SRC				10
+#define DISP_CC_MDSS_BYTE1_INTF_CLK				11
+#define DISP_CC_MDSS_DPTX0_AUX_CLK				12
+#define DISP_CC_MDSS_DPTX0_AUX_CLK_SRC				13
+#define DISP_CC_MDSS_DPTX0_CRYPTO_CLK				14
+#define DISP_CC_MDSS_DPTX0_LINK_CLK				15
+#define DISP_CC_MDSS_DPTX0_LINK_CLK_SRC				16
+#define DISP_CC_MDSS_DPTX0_LINK_DIV_CLK_SRC			17
+#define DISP_CC_MDSS_DPTX0_LINK_INTF_CLK			18
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK				19
+#define DISP_CC_MDSS_DPTX0_PIXEL0_CLK_SRC			20
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK				21
+#define DISP_CC_MDSS_DPTX0_PIXEL1_CLK_SRC			22
+#define DISP_CC_MDSS_DPTX0_USB_ROUTER_LINK_INTF_CLK		23
+#define DISP_CC_MDSS_DPTX1_AUX_CLK				24
+#define DISP_CC_MDSS_DPTX1_AUX_CLK_SRC				25
+#define DISP_CC_MDSS_DPTX1_CRYPTO_CLK				26
+#define DISP_CC_MDSS_DPTX1_LINK_CLK				27
+#define DISP_CC_MDSS_DPTX1_LINK_CLK_SRC				28
+#define DISP_CC_MDSS_DPTX1_LINK_DIV_CLK_SRC			29
+#define DISP_CC_MDSS_DPTX1_LINK_INTF_CLK			30
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK				31
+#define DISP_CC_MDSS_DPTX1_PIXEL0_CLK_SRC			32
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK				33
+#define DISP_CC_MDSS_DPTX1_PIXEL1_CLK_SRC			34
+#define DISP_CC_MDSS_DPTX1_USB_ROUTER_LINK_INTF_CLK		35
+#define DISP_CC_MDSS_DPTX2_AUX_CLK				36
+#define DISP_CC_MDSS_DPTX2_AUX_CLK_SRC				37
+#define DISP_CC_MDSS_DPTX2_CRYPTO_CLK				38
+#define DISP_CC_MDSS_DPTX2_LINK_CLK				39
+#define DISP_CC_MDSS_DPTX2_LINK_CLK_SRC				40
+#define DISP_CC_MDSS_DPTX2_LINK_DIV_CLK_SRC			41
+#define DISP_CC_MDSS_DPTX2_LINK_INTF_CLK			42
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK				43
+#define DISP_CC_MDSS_DPTX2_PIXEL0_CLK_SRC			44
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK				45
+#define DISP_CC_MDSS_DPTX2_PIXEL1_CLK_SRC			46
+#define DISP_CC_MDSS_DPTX3_AUX_CLK				47
+#define DISP_CC_MDSS_DPTX3_AUX_CLK_SRC				48
+#define DISP_CC_MDSS_DPTX3_CRYPTO_CLK				49
+#define DISP_CC_MDSS_DPTX3_LINK_CLK				50
+#define DISP_CC_MDSS_DPTX3_LINK_CLK_SRC				51
+#define DISP_CC_MDSS_DPTX3_LINK_DIV_CLK_SRC			52
+#define DISP_CC_MDSS_DPTX3_LINK_INTF_CLK			53
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK				54
+#define DISP_CC_MDSS_DPTX3_PIXEL0_CLK_SRC			55
+#define DISP_CC_MDSS_ESC0_CLK					56
+#define DISP_CC_MDSS_ESC0_CLK_SRC				57
+#define DISP_CC_MDSS_ESC1_CLK					58
+#define DISP_CC_MDSS_ESC1_CLK_SRC				59
+#define DISP_CC_MDSS_MDP1_CLK					60
+#define DISP_CC_MDSS_MDP_CLK					61
+#define DISP_CC_MDSS_MDP_CLK_SRC				62
+#define DISP_CC_MDSS_MDP_LUT1_CLK				63
+#define DISP_CC_MDSS_MDP_LUT_CLK				64
+#define DISP_CC_MDSS_NON_GDSC_AHB_CLK				65
+#define DISP_CC_MDSS_PCLK0_CLK					66
+#define DISP_CC_MDSS_PCLK0_CLK_SRC				67
+#define DISP_CC_MDSS_PCLK1_CLK					68
+#define DISP_CC_MDSS_PCLK1_CLK_SRC				69
+#define DISP_CC_MDSS_RSCC_AHB_CLK				70
+#define DISP_CC_MDSS_RSCC_VSYNC_CLK				71
+#define DISP_CC_MDSS_VSYNC1_CLK					72
+#define DISP_CC_MDSS_VSYNC_CLK					73
+#define DISP_CC_MDSS_VSYNC_CLK_SRC				74
+#define DISP_CC_PLL0						75
+#define DISP_CC_PLL1						76
+#define DISP_CC_SLEEP_CLK					77
+#define DISP_CC_SLEEP_CLK_SRC					78
+#define DISP_CC_XO_CLK						79
+#define DISP_CC_XO_CLK_SRC					80
+
+/* DISP_CC resets */
+#define DISP_CC_MDSS_CORE_BCR					0
+#define DISP_CC_MDSS_CORE_INT2_BCR				1
+#define DISP_CC_MDSS_RSCC_BCR					2
+
+/* DISP_CC GDSCR */
+#define MDSS_GDSC						0
+#define MDSS_INT2_GDSC						1
+
+#endif

-- 
2.34.1
