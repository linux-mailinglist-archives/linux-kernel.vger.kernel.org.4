Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0471B5B7E76
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiINBjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiINBjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:39:52 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7799F1B7B4;
        Tue, 13 Sep 2022 18:39:51 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id k2so7215022ilu.9;
        Tue, 13 Sep 2022 18:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=UtNtS187yKOacODImDG2YRF08CtQU5quoA//8P2rLq4=;
        b=f15IB55PPOI7CKHV95pbVe2veg0Sqa9da04wovkAt2D4vMK+Ns4mt132R/Hz6oIk5L
         c1EBfpMGa7AoztG3s5TX96XejJdKITjJs/H73Sq/e1LMODPBaezmjKwEjLgZ8jwgE5+9
         TY1chee/PNGdbXddFooBLmycsUg67YNllNIvir1aA7Y5e8IiVegpoYGUlYO0sCeKEgwj
         Oc2jfRKMSAOv0LoXaYvcct3DCpXkKT+vBIbDzKOgc02wdX7JP64mSHRweEVBKv+QjS16
         hi/6iPjgKiRU68mxEdBtOLc6zrzuuxc4YXdEgG5z9Q5AS33rH5p+XP2UeigyBoEmZuyU
         jP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=UtNtS187yKOacODImDG2YRF08CtQU5quoA//8P2rLq4=;
        b=BjQkE6uK66PZCi3j6r0cZKZdgnt/ZJM4Sboq9OwlWo5FBp64qva0a7tgyVI8+frIXn
         fQOfxJUoshS45vlGeoMFyGu7hOLlHbIg3lK0IM4D/HsrdxNe9CcFl7eZV17ehrtuKhKC
         xNhGmrbyr9mgW2KQrVNx80AsNaXxzz7rwCAH4NkPK0VwVhfOPt7MTizPugyhFWEZqNZp
         62RpzDh4/SQVRD+PtanawO/D2+vEw4nB840uZqM1YTvhyqqZjOOto4WA8xS5RFtRWd0p
         c30uCDKdO+HlFmLsS/NKsYGYFGV8ggP2cQG74B03EsuFKSH057uF1d4WiGdg63Nqve/u
         lggg==
X-Gm-Message-State: ACgBeo1DNv/axgQ5YnLe3IkpvSWv7nReqGjOm2qwPi9AHsOqDZ38NNNp
        RJ/fVwkoTyXqCnQpJ6bmBHzfhLPg+Vs=
X-Google-Smtp-Source: AA6agR63DB76gI5T5G2yRsOHsv6zngT7GcqHXS5GrY20N8sKBBAnGCqB7bSQT6n5x2Fq7siQEYXRqA==
X-Received: by 2002:a05:6e02:1563:b0:2f3:88a:82ba with SMTP id k3-20020a056e02156300b002f3088a82bamr13062185ilu.93.1663119590677;
        Tue, 13 Sep 2022 18:39:50 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id g44-20020a02852f000000b0035847c18844sm6218544jai.7.2022.09.13.18.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 18:39:50 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>
Subject: [PATCH v4 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global clocks
Date:   Tue, 13 Sep 2022 21:39:20 -0400
Message-Id: <20220914013922.198778-2-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914013922.198778-1-mailingradian@gmail.com>
References: <20220914013922.198778-1-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Snapdragon 670 clocks will be added into the sdm845 gcc driver. Most
of the new clocks, GDSCs, and resets already have reserved IDs but there
are some resources that don't. Add the new clock from Snapdragon 670 and
document the differences between the SoC parent clocks.

Signed-off-by: Richard Acayan <mailingradian@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/clock/qcom,gcc-sdm845.yaml       | 59 +++++++++++++++----
 include/dt-bindings/clock/qcom,gcc-sdm845.h   |  1 +
 2 files changed, 47 insertions(+), 13 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
index 610332a6af14..e169d46c78f8 100644
--- a/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
+++ b/Documentation/devicetree/bindings/clock/qcom,gcc-sdm845.yaml
@@ -19,23 +19,17 @@ description: |
 
 properties:
   compatible:
-    const: qcom,gcc-sdm845
+    enum:
+      - qcom,gcc-sdm670
+      - qcom,gcc-sdm845
 
   clocks:
-    items:
-      - description: Board XO source
-      - description: Board active XO source
-      - description: Sleep clock source
-      - description: PCIE 0 Pipe clock source
-      - description: PCIE 1 Pipe clock source
+    minItems: 3
+    maxItems: 5
 
   clock-names:
-    items:
-      - const: bi_tcxo
-      - const: bi_tcxo_ao
-      - const: sleep_clk
-      - const: pcie_0_pipe_clk
-      - const: pcie_1_pipe_clk
+    minItems: 3
+    maxItems: 5
 
   power-domains:
     maxItems: 1
@@ -45,6 +39,45 @@ required:
 
 allOf:
   - $ref: qcom,gcc.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,gcc-sdm670
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Sleep clock source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,gcc-sdm845
+    then:
+      properties:
+        clocks:
+          items:
+            - description: Board XO source
+            - description: Board active XO source
+            - description: Sleep clock source
+            - description: PCIE 0 Pipe clock source
+            - description: PCIE 1 Pipe clock source
+        clock-names:
+          items:
+            - const: bi_tcxo
+            - const: bi_tcxo_ao
+            - const: sleep_clk
+            - const: pcie_0_pipe_clk
+            - const: pcie_1_pipe_clk
 
 unevaluatedProperties: false
 
diff --git a/include/dt-bindings/clock/qcom,gcc-sdm845.h b/include/dt-bindings/clock/qcom,gcc-sdm845.h
index 968fa65b9c42..d78b899263a2 100644
--- a/include/dt-bindings/clock/qcom,gcc-sdm845.h
+++ b/include/dt-bindings/clock/qcom,gcc-sdm845.h
@@ -199,6 +199,7 @@
 #define GCC_QSPI_CNOC_PERIPH_AHB_CLK				189
 #define GCC_LPASS_Q6_AXI_CLK					190
 #define GCC_LPASS_SWAY_CLK					191
+#define GPLL6							192
 
 /* GCC Resets */
 #define GCC_MMSS_BCR						0
-- 
2.37.3

