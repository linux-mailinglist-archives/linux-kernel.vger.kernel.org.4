Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B84F629D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 16:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiKOP1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 10:27:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237742AbiKOP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 10:27:43 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 243E42C109
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:40 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ud5so36948287ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 07:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/OnIF5KJq38ydF7gLxLfsf0iN2iW7kEJTrwDz5/qCW8=;
        b=XeD7h1D85c6PELOSUkCRH42zXo6QrloEq7je/ihrbaWxuZGUSugvC6ZYCtZPrpYQ4C
         m0/ZoyjftHwJDvZSWFeHc7V1cB19WR8ouls1xE8wSHQj9ZSBG/zZdQbUr//U4Hz78NOh
         70ld40peqz55/qWelsXnefWszp8OMz/rpqmTbA6IjQrxu45BbDpIS0QzOQ2DFbGI6PtQ
         RNqBkZX2Prkbb3LIHpdKtx0PT/Q6nocYrCQXe9fVAYLrKU6ViBsbbJUZSQKlvvaQsi7f
         49WgjnxLy320wM2CPMu7og+jlX6VaL9gxSlfXHPthueLNUy/SEDBgRDH8QLQkHu54Wqp
         dG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/OnIF5KJq38ydF7gLxLfsf0iN2iW7kEJTrwDz5/qCW8=;
        b=GGhKMG5ks/hGAAV/AyDQb0Wm4QUaPyVK8jbwFoPI6UfdTXABV+bqB12mWPZhpZ8bCo
         SyjubCqDWGaXpC+SdMP3LGpAkgdQzUHI0tgXqf7LGar1LTiBehapJmRa3Ufe++J6u87A
         GmeS7XD58PFXD0w2D+tG5sV0nf9WQ+OlY1pkGjRnwKk+ToDr5ZpXaDnTovAX63iGDj64
         A4NYmD8OzBT2n6KUZecb4G/IElRjx9O8b/TSfwmBvgAfmcf4xQo0DJBVgCWnUAI0cJwf
         xXw/0P2dm75xKRihb27iB+oC6xEG6az74vAsFkALCGAJBXz3abgxElfykQn6nrLQy5zX
         Sxqw==
X-Gm-Message-State: ANoB5pmY1pvZBhroxjsjcqKZ5z97Tuk3Kn2hhpAWvAquO9LKCk2UpCeh
        DnyM0kALfej33cNRuiKxgnZL2w==
X-Google-Smtp-Source: AA0mqf6t90H5G/NxFj6kZZ89Op+6k4zWLusxmbs0qlF4AQ2K0srx4P2Envtn5p5Sx3vJB9JOY4JsQw==
X-Received: by 2002:a17:906:d82:b0:7ad:8a7a:2343 with SMTP id m2-20020a1709060d8200b007ad8a7a2343mr13999054eji.225.1668526058653;
        Tue, 15 Nov 2022 07:27:38 -0800 (PST)
Received: from localhost.localdomain ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id ku21-20020a170907789500b007ae1ab8f887sm5750679ejc.14.2022.11.15.07.27.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Nov 2022 07:27:38 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     patches@linaro.org, Konrad Dybcio <konrad.dybcio@linaro.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/9] dt-bindings: arm-smmu: Allow 3 power domains on SM6375 MMU500
Date:   Tue, 15 Nov 2022 16:27:19 +0100
Message-Id: <20221115152727.9736-2-konrad.dybcio@linaro.org>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
In-Reply-To: <20221115152727.9736-1-konrad.dybcio@linaro.org>
References: <20221115152727.9736-1-konrad.dybcio@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SMMU on SM6375 requires 3 power domains to be active. Add an
appropriate description of that.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 .../devicetree/bindings/iommu/arm,smmu.yaml   | 23 ++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 28f5720824cd..348a73f3e5f0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -200,7 +200,8 @@ properties:
     maxItems: 7
 
   power-domains:
-    maxItems: 1
+    minItems: 1
+    maxItems: 3
 
   nvidia,memory-controller:
     description: |
@@ -364,6 +365,26 @@ allOf:
             - description: interface clock required to access smmu's registers
                 through the TCU's programming interface.
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm6375-smmu-500
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: SNoC MMU TBU RT GDSC
+            - description: SNoC MMU TBU NRT GDSC
+            - description: SNoC TURING MMU TBU0 GDSC
+
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
 examples:
   - |+
     /* SMMU with stream matching or stream indexing */
-- 
2.38.1

