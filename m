Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7261D6E9ACF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 19:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbjDTRdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 13:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbjDTRc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 13:32:59 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3948D49E6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:32:56 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y24so3667413ljm.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 10:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1682011974; x=1684603974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1QUEi4KCioig+7MEuspZ8Q1/71UjWTN1Jyb1cQYkHw=;
        b=O85RtNVrl9M4nCdFA4BXrn/HEFzclT+XKWDgbs4vtvP8aycnyWRl1hJ5gbDoJD7cyE
         f6EA2f5v6PQzF/Ql/WX5hHwxXzTxTEkDCIU/uQGm1/cxi38OWuavmNTB0aAI14+V3H4r
         Q1YT2+n4G+cFGo+JM49sE4c3oJC9ahqhw9BzxBfQVxzRxMPq7Y0PSIGGVCC4xxOJJl3E
         /p12xY8OcpHFzQTSppI94is8Mpgy3aSczya9cvqFSdwp+Ep0nHshU3UoCIRr/lsWTecL
         2mEBgev6Gl2J0u6AervWlVSB+ZiYFd5uyt9bhq2+mJMrFosUmsKJkbCfy3Seu+yrKGQS
         hpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682011974; x=1684603974;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1QUEi4KCioig+7MEuspZ8Q1/71UjWTN1Jyb1cQYkHw=;
        b=kQ7fDQlg8aP76S3UoALHP/LIRYIfXUSXB2cGlIg0VrRnWhw/qhY13r+LDJMDhLcE9B
         D4ALMPsJr27epwW6gFzK2JIPGiasxv97PZzUNv15IyqbGm4lcHIAAeuqXwYCUdbqabmI
         SNxBpryhpBOXbqZSBodRXPjQ/8ctj0RVgdJIwJ+nc4pIpvZzpHd/RO/UBE+IIU7cNruJ
         GCX4esxZo2qixOiISEs+R1FblKVWWWE/k3w+SikLdBlvQ4e0xQDiIP7EXgpa2tM+BKL0
         DJJR6nRsItmVC7nxUAFhi5jFVudIi2LNxlzIYPDWWtBRjpHdrBmCNzNHX1JPq3J6riwP
         4jTQ==
X-Gm-Message-State: AAQBX9fxlTof51pvUm9JyFizma6PfY732RBMBPHy7NfVr5gm/UbMIkGG
        ZJD7v550jzT/SeagJDWH38qDaQ==
X-Google-Smtp-Source: AKy350aJnCxM8HWEyF1YEXqdKt+VkAX0vQneduQniFOJMHsQfjTNv5V3v2u9E3gjgvgr90AJYJQo+Q==
X-Received: by 2002:a2e:8012:0:b0:2a8:dcb0:6c8e with SMTP id j18-20020a2e8012000000b002a8dcb06c8emr652376ljg.33.1682011974585;
        Thu, 20 Apr 2023 10:32:54 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id e22-20020a2e8ed6000000b002a8c1462ecbsm309597ljl.137.2023.04.20.10.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 10:32:54 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 20 Apr 2023 19:32:50 +0200
Subject: [PATCH v4 1/2] dt-bindings: clock: Add SM8350 VIDEOCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-topic-lahaina_vidcc-v4-1-86c714a66a81@linaro.org>
References: <20230413-topic-lahaina_vidcc-v4-0-86c714a66a81@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v4-0-86c714a66a81@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1682011971; l=4835;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=9Ky1ETSdCXuI6Z+f0jtlluA/Pju2puOcRtbU8+oK15g=;
 b=Xe/RzGuRAEWqTfw1c0NmBK1z59sxOZ+KoyGkQ3PKlk8dIlAoOkyiKLcuPHSGDWM50fPOD5yHKNuL
 ypHkG8j7DF3nJSgT2gOZowhUF4OcznDQ4moEC9lDc3x8FfKOC+Ia
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350, like most recent higher-end chips has a separate clock
controller block just for the Venus IP. Document it.

The binding was separated as the driver, unlike the earlier ones, doesn't
expect clock-names to keep it easier to maintain.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../bindings/clock/qcom,sm8350-videocc.yaml        | 68 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    | 35 +++++++++++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    | 18 ++++++
 3 files changed, 121 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
new file mode 100644
index 000000000000..23505c8c3dbd
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,sm8350-videocc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 Video Clock & Reset Controller
+
+maintainers:
+  - Konrad Dybcio <konrad.dybcio@linaro.org>
+
+description: |
+  Qualcomm video clock control module provides the clocks, resets and power
+  domains on Qualcomm SoCs.
+
+  See also::
+    include/dt-bindings/clock/qcom,videocc-sm8350.h
+    include/dt-bindings/reset/qcom,videocc-sm8350.h
+
+properties:
+  compatible:
+    const: qcom,sm8350-videocc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Board active XO source
+      - description: Board sleep clock
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
+  - clocks
+  - power-domains
+  - required-opps
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+
+    clock-controller@abf0000 {
+      compatible = "qcom,sm8350-videocc";
+      reg = <0x0abf0000 0x10000>;
+      clocks = <&rpmhcc RPMH_CXO_CLK>,
+               <&rpmhcc RPMH_CXO_CLK_A>,
+               <&sleep_clk>;
+      power-domains = <&rpmhpd SM8350_MMCX>;
+      required-opps = <&rpmhpd_opp_low_svs>;
+      #clock-cells = <1>;
+      #reset-cells = <1>;
+      #power-domain-cells = <1>;
+    };
+...
diff --git a/include/dt-bindings/clock/qcom,sm8350-videocc.h b/include/dt-bindings/clock/qcom,sm8350-videocc.h
new file mode 100644
index 000000000000..b6945a448676
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,sm8350-videocc.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8350_H
+#define _DT_BINDINGS_CLK_QCOM_VIDEO_CC_SM8350_H
+
+/* Clocks */
+#define VIDEO_CC_AHB_CLK_SRC					0
+#define VIDEO_CC_MVS0_CLK					1
+#define VIDEO_CC_MVS0_CLK_SRC					2
+#define VIDEO_CC_MVS0_DIV_CLK_SRC				3
+#define VIDEO_CC_MVS0C_CLK					4
+#define VIDEO_CC_MVS0C_DIV2_DIV_CLK_SRC				5
+#define VIDEO_CC_MVS1_CLK					6
+#define VIDEO_CC_MVS1_CLK_SRC					7
+#define VIDEO_CC_MVS1_DIV2_CLK					8
+#define VIDEO_CC_MVS1_DIV_CLK_SRC				9
+#define VIDEO_CC_MVS1C_CLK					10
+#define VIDEO_CC_MVS1C_DIV2_DIV_CLK_SRC				11
+#define VIDEO_CC_SLEEP_CLK					12
+#define VIDEO_CC_SLEEP_CLK_SRC					13
+#define VIDEO_CC_XO_CLK_SRC					14
+#define VIDEO_PLL0						15
+#define VIDEO_PLL1						16
+
+/* GDSCs */
+#define MVS0C_GDSC						0
+#define MVS1C_GDSC						1
+#define MVS0_GDSC						2
+#define MVS1_GDSC						3
+
+#endif
diff --git a/include/dt-bindings/reset/qcom,sm8350-videocc.h b/include/dt-bindings/reset/qcom,sm8350-videocc.h
new file mode 100644
index 000000000000..cd356b207a4a
--- /dev/null
+++ b/include/dt-bindings/reset/qcom,sm8350-videocc.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2023, Linaro Limited
+ */
+
+#ifndef _DT_BINDINGS_RESET_QCOM_VIDEO_CC_SM8350_H
+#define _DT_BINDINGS_RESET_QCOM_VIDEO_CC_SM8350_H
+
+#define VIDEO_CC_CVP_INTERFACE_BCR				0
+#define VIDEO_CC_CVP_MVS0_BCR					1
+#define VIDEO_CC_MVS0C_CLK_ARES					2
+#define VIDEO_CC_CVP_MVS0C_BCR					3
+#define VIDEO_CC_CVP_MVS1_BCR					4
+#define VIDEO_CC_MVS1C_CLK_ARES					5
+#define VIDEO_CC_CVP_MVS1C_BCR					6
+
+#endif

-- 
2.40.0

