Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0403C6E7A19
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233281AbjDSMxb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233252AbjDSMx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:53:27 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7F2AD0A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:53:22 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id x34so20629185ljq.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681908800; x=1684500800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8xYYOHLNVDMTohffgWud8xqJBCND68iSOSGFM0h5z3I=;
        b=o2cRMBjSmSVnsrxuNgEWzy6nqKv8XByLVU6Y2wq/ThVMB483B592UaP3iVkc5CueUb
         A3eXTXRBwmAD+Q9NHTVx8u8ZN/i7k1JdgUCZx9q3H6/K700MDxKz3MYMflIon8nBpEYB
         hIjInyLCjPLTscyJHJT2EfLFLBZUahXobXQY7g1HipzV2YQ0nLtGGapAX+Xas66aEO1P
         CdSmf+s5GhrQWDfr201v4y0YhIuzImwvyyOEVEEmfGUlWarTOkqB1CU2wn9caS/Po1I1
         fVm6EYQl51EfUaO9OJZ9dDOG+y774tvLset/xIrnuWpuKb79rZigMapsq0cIP8gTLf6Z
         PiFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908800; x=1684500800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8xYYOHLNVDMTohffgWud8xqJBCND68iSOSGFM0h5z3I=;
        b=VocNVkFMM+Zbz/EazzRRP9a5WU2gQmjuYP7hSsfu5G8djND8dYCmDasWjBCqs2nwKC
         bhjZxkYwOVxE+pia5hzCAvRZllU/t5DQloaYTy/SbtmIP2B+K0OObdFlmSNd3R/spKce
         p5u4ncmkwErr5XpjbWdI926p8jS39kxdGYhUClfMeLsmeJJ4zmxPE+NWfabk0oJB5Ohk
         yXFTQrwMSayzvr7rHPJ1a3prWh5Fh8YiM8UXvTjsxMZZRZo6g3INZepWOWBFSHVdeTMj
         bo5Q/KV+RHQ6w+8uA4L1Ga9bZ8MZO7NN8xtU2iKww4HWwmAwH7IuJB72n+CMRHvUzPYp
         qIzQ==
X-Gm-Message-State: AAQBX9dCgtsI8RCDt0Cbngh+QK1UU6gX0jobRYQ2AQQ0tUc/TrQJ9y3T
        bFTjEy5qN/C3/uVZngsboEknsw==
X-Google-Smtp-Source: AKy350ZOTAs4jPtjma0d8d9PEFwQvxC8g0FcWJeV3yJ/K70xoDFmzjK097qzPccjGBiLfSbZDDDrNw==
X-Received: by 2002:a2e:82d0:0:b0:2a7:b0c8:2880 with SMTP id n16-20020a2e82d0000000b002a7b0c82880mr2060609ljh.13.1681908800415;
        Wed, 19 Apr 2023 05:53:20 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e98d6000000b002a76c16ad65sm2926079ljj.87.2023.04.19.05.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:53:20 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Wed, 19 Apr 2023 14:53:16 +0200
Subject: [PATCH v3 1/2] dt-bindings: clock: Add SM8350 VIDEOCC
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-topic-lahaina_vidcc-v3-1-0e404765f945@linaro.org>
References: <20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681908797; l=5024;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=7QNb+xqbjJjxz1P8jpiD8h6kz1h8Zayy+ZLb0w8ouQo=;
 b=RfYpukZwRFkGbra6dPpG++WemAPuFa2+x7/bUYdsWcbbreMdrxM8W+fh+JI0IkHPQoRKGpfeLRvP
 upLr/QbDBbShK2WozGVmGLw4/6Pj2ZnsyM3WFVVGW+O7aG/iqf0+
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 .../bindings/clock/qcom,sm8350-videocc.yaml        | 81 ++++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    | 35 ++++++++++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    | 18 +++++
 3 files changed, 134 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
new file mode 100644
index 000000000000..28a1002b1563
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,sm8350-videocc.yaml
@@ -0,0 +1,81 @@
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
+  reg:
+    maxItems: 1
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
+  '#clock-cells':
+    const: 1
+
+  '#reset-cells':
+    const: 1
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - power-domains
+  - required-opps
+  - '#clock-cells'
+  - '#reset-cells'
+  - '#power-domain-cells'
+
+additionalProperties: false
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

