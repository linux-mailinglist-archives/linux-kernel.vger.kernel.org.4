Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C756BCDDB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 12:17:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCPLRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 07:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCPLRT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 07:17:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52216C48B0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:11 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j11so1815820lfg.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678965429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Dqo3vqQkgXO2XmX0zU0XEpyQvAGwKwkDhhmGh4mUlEA=;
        b=geHOA6N69cOMKOp54uqlnmS/qoOCmqDT2CG0MwTgEj1bifzrn5sdU57I9jydF2ESN/
         JatgKPbVtpux/pUFTodcSJLAS8d+rVOkb7mMAoF8qr+rKArpe6RQYzcN1k8sl5gokWrp
         bTYxhZzule19Mm4I2IGjeWYg9X9zUZCjNyPl1bPaohzTH5IEESaXNTo15Si8FG+/uc55
         tg8RtNe5rDC+iuXBmE8O1ZklDAL1OZI35vTQFPME0sa7H+6sGZq4p7rR9dm3neCqPc/2
         3Uip2TW8T08TVMHRPe77WIcHIT/OINZwZZu2HZDRVrWN/mliqgdsSIqg6uwIcCHB1pd4
         0PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678965429;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dqo3vqQkgXO2XmX0zU0XEpyQvAGwKwkDhhmGh4mUlEA=;
        b=ifj58avTL5cgnpJ1kL6PoFwZgt5nlRP8XXN8zTFTR2mBRApg1ZEILEStC7BbLNfoLD
         EmqrMrK1M3R+1DK9Hib3v6DUCEGgTs5fDN/RS8yb2RN5MBOQS9YaSqAuC+l5LLnknu+M
         2oPZinRkz01T3QMp0yzmuzf/c2CaHSrsHZQcIzSoGC8B6nxEbAzORrOtFar4L/yYYsLo
         AJ/88ipDfxQSw9td54rRj9WaMj2CeEDkPl/MD3LSiW88Sj9awMzMm8zjnj88ueMbIYWD
         U2d/mAxT2BBjaoq6nL/IKhvZz7G4M1hvu3MWcdbM2Ab990q8IugMorp6Y6H57PTz7rD7
         fwDQ==
X-Gm-Message-State: AO0yUKV40SrduaeUgk8xkEBXNssH4DTfNHh/RBMDhXLYMIIrwsHOhoO/
        Ccx+T/Mav6WODcHsBNkqnUIbzA==
X-Google-Smtp-Source: AK7set/8lm2cHhRlkaWuX3/gs/iPyWEbk9FeCRtK0a2hTe/JDY2Hr82jWOtb2mYIX6N3SHRf7uoF2A==
X-Received: by 2002:a05:6512:39c4:b0:4dd:9eb6:5b4c with SMTP id k4-20020a05651239c400b004dd9eb65b4cmr2390052lfu.0.1678965429243;
        Thu, 16 Mar 2023 04:17:09 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id u28-20020ac243dc000000b004db2978e330sm1194222lfl.258.2023.03.16.04.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 04:17:08 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 16 Mar 2023 12:16:56 +0100
Subject: [PATCH 1/5] dt-bindings: clock: qcom,gpucc: Fix SM6350 clock names
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230315-topic-lagoon_gpu-v1-1-a74cbec4ecfc@linaro.org>
References: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
In-Reply-To: <20230315-topic-lagoon_gpu-v1-0-a74cbec4ecfc@linaro.org>
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1678965426; l=1659;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=bpaAXA5y4g96VwCAJK9chz5FYE16LKwf+GCJo/Dh+04=;
 b=Jild5AY0GLW3IlK/0sO5nZu7MvhQrlDmN5ABPy6VIRbq5sH0zdDzJyWVgYFZkV1dqSaHbcjDa8ah
 60eKja2ND5+/d/+W42zSyRGM0uDlHxgiIq4CiB4Jr8+5kd3WG32y
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SM6350 GPUCC uses the same clock names as the rest of the gang, except
without a _src suffix. Account for that.

Fixes: 7b91b9d8cc6c ("dt-bindings: clock: add SM6350 QCOM Graphics clock bindings")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/clock/qcom,gpucc.yaml      | 29 +++++++++++++++++++---
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
index db53eb288995..d209060a619d 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gpucc.yaml
@@ -43,10 +43,8 @@ properties:
       - description: GPLL0 div branch source
 
   clock-names:
-    items:
-      - const: bi_tcxo
-      - const: gcc_gpu_gpll0_clk_src
-      - const: gcc_gpu_gpll0_div_clk_src
+    minItems: 3
+    maxItems: 3
 
   '#clock-cells':
     const: 1
@@ -71,6 +69,29 @@ required:
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          items:
+            - const: qcom,sm6350-gpucc
+
+    then:
+      properties:
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: gcc_gpu_gpll0_clk
+            - const: gcc_gpu_gpll0_div_clk
+
+    else:
+      properties:
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: gcc_gpu_gpll0_clk_src
+            - const: gcc_gpu_gpll0_div_clk_src
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,gcc-sdm845.h>

-- 
2.39.2

