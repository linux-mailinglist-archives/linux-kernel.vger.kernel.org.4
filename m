Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545BC706E63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 18:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjEQQky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 12:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjEQQkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 12:40:51 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A7F40D4
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:49 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac836f4447so9883301fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 09:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684341648; x=1686933648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bexwWSWOvZ7VP6Uw/nDlY/FEdNklQkm5LIiy0WCk85I=;
        b=egZKNVell/R4u/lWxvCYH3suEZZZOj9L8NqpFezuxBiYn+FCNUeS2AJAkfYyvjimhp
         sBnx14VLfzWAr1dsfsCh/D61Xqp/PbaF7akFLvK+mjHhRXnZEEuaFEeKN8qfb7+YvzKY
         tQyRxG3khsxn6Ky8+VjN8WTBQgjfcqurod2k/iFkkp5FNNg2Bnrk9h4lkLyGJd4dMqYj
         kV20U2pnUJRk+WjJaiQGOctizyyZCzjnatTG4IeSYnM0BVUl5dfVYcFu6sfkejhRKyuM
         RDdoU7Z7OoXdFhOT4Mj17pLhKnnuEAAA7mgeNdKO0FCGX62pmtchYzsgp9b0+vbFKlsi
         Smag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684341648; x=1686933648;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bexwWSWOvZ7VP6Uw/nDlY/FEdNklQkm5LIiy0WCk85I=;
        b=R28m+EnDjS/oAdc2mhQ7CTNjXHzt+yXHW9P+SfTYfrWGrdkheM2hIJOPlh4y2g5rlh
         bfVcZaHOqbD3XyFyfAz0PjBujZpQd+X6GRrYjpi3IabEbq1P9clF/1aqsItf0RG4hUIN
         Vp4/8oRTQJrmphrbRqlMJ4/pIzlhYgHDS9fbCRaBAn7eGCwCITuJNF3/SauHF9OHisSZ
         ArhToHqx6VHMBDqjWdEhPZ0fio5+Mo0f0cFj8CucOHNtF6HjsepsBEWbn8YlwUwWlTp+
         zKik0zcb6OscXiIXvakxKAskSWJAWVCmPjP9LiKFLclBhIHxXS5XwRVyfR9MfzvsHs8Q
         FHOQ==
X-Gm-Message-State: AC+VfDwjGynn7C9TwE8GXhC27Uy40VrpOY5wTXn1nLwheHrESdy6331G
        LC3Ic4S+U0lLmyywHDPU3sGLsw==
X-Google-Smtp-Source: ACHHUZ4yuCnnaiaosNP5fJeMm/8cG+JdvWSuaWmEE6VEymYqn2UQERxm3Au6ynavmuAu0ETX+1yvtA==
X-Received: by 2002:a2e:8742:0:b0:2a8:ea26:607f with SMTP id q2-20020a2e8742000000b002a8ea26607fmr9226799ljj.31.1684341648084;
        Wed, 17 May 2023 09:40:48 -0700 (PDT)
Received: from [192.168.1.101] (abxi58.neoplus.adsl.tpnet.pl. [83.9.2.58])
        by smtp.gmail.com with ESMTPSA id 9-20020a05651c040900b002a8c271de33sm1919259lja.67.2023.05.17.09.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 09:40:47 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 17 May 2023 18:40:38 +0200
Subject: [PATCH 1/4] dt-bindings: clock: Add Qcom SM8450 GPUCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230517-topic-waipio-gpucc-v1-1-4f40e282af1d@linaro.org>
References: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
In-Reply-To: <20230517-topic-waipio-gpucc-v1-0-4f40e282af1d@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1684341644; l=5124;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=MhBViTEKlDT91YnvxN4Wt5A2PavC/GTeMqcTgs3LVTE=;
 b=UeflCyUL2/xQ4ejsfe5Zy8qh+Uui8nry8sJqhxTg2h8RRI8YifkSOJA1px/ElEmboQRof1PwK
 A/0t4Ou5w1PC7Dj3luclOUjMehVv+ifbmToYzKX1CXQyHI4RMRzw8oz
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

Add device tree bindings for the graphics clock controller on Qualcomm
Technology Inc's SM8450 SoCs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,sm8450-gpucc.yaml          | 73 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8450-gpucc.h      | 48 ++++++++++++++
 include/dt-bindings/reset/qcom,sm8450-gpucc.h      | 20 ++++++
 3 files changed, 141 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
new file mode 100644
index 000000000000..ad913b2daf0c
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-gpucc.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8450-gpucc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Graphics Clock & Reset Controller on SM8450
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm graphics clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,sm8450-gpucc.h
+    include/dt-bindings/reset/qcom,sm8450-gpucc.h
+
+properties:
+  compatible:
+    enum:
+      - qcom,sm8450-gpucc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: GPLL0 main branch source
+      - description: GPLL0 div branch source
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
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        clock-controller@3d90000 {
+            compatible = "qcom,sm8450-gpucc";
+            reg = <0 0x03d90000 0 0xa000>;
+            clocks = <&rpmhcc RPMH_CXO_CLK>,
+                     <&gcc GCC_GPU_GPLL0_CLK_SRC>,
+                     <&gcc GCC_GPU_GPLL0_DIV_CLK_SRC>;
+            #clock-cells = <1>;
+            #reset-cells = <1>;
+            #power-domain-cells = <1>;
+        };
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8450-gpucc.h b/include/dt-bindings/clock/qcom,sm8450-gpucc.h
new file mode 100644
index 000000000000..712b171503d6
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8450-gpucc.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8450_H
+#define _DT_BINDINGS_CLK_QCOM_GPU_CC_SM8450_H
+
+/* Clocks */
+#define GPU_CC_AHB_CLK				0
+#define GPU_CC_CRC_AHB_CLK			1
+#define GPU_CC_CX_APB_CLK			2
+#define GPU_CC_CX_FF_CLK			3
+#define GPU_CC_CX_GMU_CLK			4
+#define GPU_CC_CX_SNOC_DVM_CLK			5
+#define GPU_CC_CXO_AON_CLK			6
+#define GPU_CC_CXO_CLK				7
+#define GPU_CC_DEMET_CLK			8
+#define GPU_CC_DEMET_DIV_CLK_SRC		9
+#define GPU_CC_FF_CLK_SRC			10
+#define GPU_CC_FREQ_MEASURE_CLK			11
+#define GPU_CC_GMU_CLK_SRC			12
+#define GPU_CC_GX_FF_CLK			13
+#define GPU_CC_GX_GFX3D_CLK			14
+#define GPU_CC_GX_GFX3D_RDVM_CLK		15
+#define GPU_CC_GX_GMU_CLK			16
+#define GPU_CC_GX_VSENSE_CLK			17
+#define GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK		18
+#define GPU_CC_HUB_AHB_DIV_CLK_SRC		19
+#define GPU_CC_HUB_AON_CLK			20
+#define GPU_CC_HUB_CLK_SRC			21
+#define GPU_CC_HUB_CX_INT_CLK			22
+#define GPU_CC_HUB_CX_INT_DIV_CLK_SRC		23
+#define GPU_CC_MEMNOC_GFX_CLK			24
+#define GPU_CC_MND1X_0_GFX3D_CLK		25
+#define GPU_CC_MND1X_1_GFX3D_CLK		26
+#define GPU_CC_PLL0				27
+#define GPU_CC_PLL1				28
+#define GPU_CC_SLEEP_CLK			29
+#define GPU_CC_XO_CLK_SRC			30
+#define GPU_CC_XO_DIV_CLK_SRC			31
+
+/* GDSCs */
+#define GPU_GX_GDSC				0
+#define GPU_CX_GDSC				1
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sm8450-gpucc.h b/include/dt-bindings/reset/qcom,sm8450-gpucc.h
new file mode 100644
index 000000000000..58ba8f987107
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sm8450-gpucc.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_GPU_CC_SM8450_H
+#define _DT_BINDINGS_RESET_QCOM_GPU_CC_SM8450_H
+
+#define GPUCC_GPU_CC_ACD_BCR			0
+#define GPUCC_GPU_CC_CX_BCR			1
+#define GPUCC_GPU_CC_FAST_HUB_BCR		2
+#define GPUCC_GPU_CC_FF_BCR			3
+#define GPUCC_GPU_CC_GFX3D_AON_BCR		4
+#define GPUCC_GPU_CC_GMU_BCR			5
+#define GPUCC_GPU_CC_GX_BCR			6
+#define GPUCC_GPU_CC_XO_BCR			7
+#define GPUCC_GPU_CC_GX_ACD_IROOT_BCR		8
+
+#endif

-- 
2.40.1

