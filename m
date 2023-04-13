Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A826E147B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDMSpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjDMSph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:45:37 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648C683ED
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:45:10 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id u12so2695292lfu.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681411504; x=1684003504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hZACr2qT1r+Pq/JG1rFFm+OjlMblwToTQZN+UEc9YSE=;
        b=ipoZ09DD8FOfkQzZoNddbAAVIjuTGgv3X8jItYX/VKEDi4DKFx0hMeQw1RilOubilj
         uU0B5n6+CXaU1AtxicTzo8me/QtmJQ6sF0FxduKsAyflcBaOtzRvMFS7r7Yksq2zlMq6
         t4TldUJ9XhZiveAq+OpW6NoNJ3AwMfiLZjNBKcC83zGD4ltSCtvyuiolOSg8VPOamC+8
         /cZDBOPoLJog3Fuof+RaSkX1iWtDMF+rK4HGSwCEXevazjoLpXWlmAuaQxDDWWHP3n23
         LEgmt28rS+LsA0Jd2vePORdbaVvhv+mruCFrw2oaCtl16Uvfrw/Ck/5QRMPPWOLyCrvx
         vBiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681411504; x=1684003504;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZACr2qT1r+Pq/JG1rFFm+OjlMblwToTQZN+UEc9YSE=;
        b=jECEtE97WflSIk0Yo23VOayBdKxyVKBkgd5CTKlM3xRtJ7way5FTspgwA6+VojhMzp
         puHLNDbzGW3Z0K6lLUso460R4d5YoaD+KO4k+kgn4jUOXMGaTCvzKk0z67Mnrwk2iBDp
         ftZxzfNdoRLf/0N3eXSbz4zW5IAoWQZ7xCxflT0JDjNE5m18Oi3WxeDgayofrHlv6e9r
         oAXeB3M7Df5f+DbLeI0zAZ/Yry2src0IEtdym0kPoIXy/Han40mfgVPCHQvrXApweG2V
         SP7p4E5un1lvOk14RG1IwMXPv+j7igxJmgUgtD0vJap1jjME//t91mKpHvx0NaStCu14
         0zhQ==
X-Gm-Message-State: AAQBX9evBtzP8McXpHPFzflxlXJijtDqd+v8NJXeZ/sPmouIXP7bI81G
        z2zIunYHkND+NAKys4PcKa+fvQ==
X-Google-Smtp-Source: AKy350a/4OMy48fn79E4+jYeY45rNsKnNmTWLoYvl4/gP65R2uYAcZ7FhKBxQs5Wbr9xlEo8cpnJbw==
X-Received: by 2002:ac2:4895:0:b0:4d5:a689:7580 with SMTP id x21-20020ac24895000000b004d5a6897580mr1315941lfc.47.1681411503841;
        Thu, 13 Apr 2023 11:45:03 -0700 (PDT)
Received: from [192.168.1.101] (abyl123.neoplus.adsl.tpnet.pl. [83.9.31.123])
        by smtp.gmail.com with ESMTPSA id r12-20020ac24d0c000000b004e95f53adc7sm419621lfi.27.2023.04.13.11.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Apr 2023 11:45:03 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 13 Apr 2023 20:44:58 +0200
Subject: [PATCH 1/2] dt-bindings: clock: qcom,videocc: Add SM8350
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-topic-lahaina_vidcc-v1-1-134f9b22a5b3@linaro.org>
References: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org>
In-Reply-To: <20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681411500; l=4559;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=yDNgI5vaFDUinUfBBr+IuGY3i/nybTj/plx2VvRXMcU=;
 b=kCI9+Y3Yau+8W4V5pT49oVmrNAQ+AMsy1qHMQJv0ZoeP7gblBQqWZjfEc7J9boIRTdoKnPYxre40
 2HjDfGoiAa1QF3RcaEv7cyXAgZSkuUfMbWN74nOdyzhuMLI+bQl0
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM8350, like most recent higher-end chips has a separate clock
controller block just for the Venus IP. Document it.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/clock/qcom,videocc.yaml    | 29 +++++++++++++++++-
 include/dt-bindings/clock/qcom,sm8350-videocc.h    | 35 ++++++++++++++++++++++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    | 18 +++++++++++
 3 files changed, 81 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
index 2b07146161b4..6d892b0f2306 100644
--- a/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,videocc.yaml
@@ -19,6 +19,8 @@ description: |
     include/dt-bindings/clock/qcom,videocc-sdm845.h
     include/dt-bindings/clock/qcom,videocc-sm8150.h
     include/dt-bindings/clock/qcom,videocc-sm8250.h
+    include/dt-bindings/clock/qcom,videocc-sm8350.h
+    include/dt-bindings/reset/qcom,videocc-sm8350.h
 
 properties:
   compatible:
@@ -28,6 +30,7 @@ properties:
       - qcom,sdm845-videocc
       - qcom,sm8150-videocc
       - qcom,sm8250-videocc
+      - qcom,sm8350-videocc
 
   clocks:
     minItems: 1
@@ -63,7 +66,6 @@ required:
   - compatible
   - reg
   - clocks
-  - clock-names
   - '#clock-cells'
   - '#reset-cells'
   - '#power-domain-cells'
@@ -85,6 +87,9 @@ allOf:
           items:
             - const: bi_tcxo
 
+      required:
+        - clock-names
+
   - if:
       properties:
         compatible:
@@ -101,6 +106,9 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+      required:
+        - clock-names
+
   - if:
       properties:
         compatible:
@@ -119,6 +127,25 @@ allOf:
             - const: bi_tcxo
             - const: bi_tcxo_ao
 
+      required:
+        - clock-names
+
+  - if:
+      properties:
+        compatible:
+          enum:
+            - qcom,sm8350-videocc
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Board sleep clock
+
+      required:
+        - power-domains
+
 additionalProperties: false
 
 examples:
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
index 000000000000..df7a808720ee
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
+#define CVP_VIDEO_CC_INTERFACE_BCR				0
+#define CVP_VIDEO_CC_MVS0_BCR					1
+#define VIDEO_CC_MVS0C_CLK_ARES					2
+#define CVP_VIDEO_CC_MVS0C_BCR					3
+#define CVP_VIDEO_CC_MVS1_BCR					4
+#define VIDEO_CC_MVS1C_CLK_ARES					5
+#define CVP_VIDEO_CC_MVS1C_BCR					6
+
+#endif

-- 
2.40.0

