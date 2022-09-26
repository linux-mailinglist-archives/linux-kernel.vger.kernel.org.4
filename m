Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57C5F5EA876
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 16:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234760AbiIZOdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 10:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbiIZOct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 10:32:49 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C562455AA
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:48:09 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a2so10657790lfb.6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 05:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date;
        bh=TaqQlRA9wMfkARh78jCqln27UUwKbuylUFjHkD67rpg=;
        b=Yk0Iq9iDQsVLdnYNYspsrcCL0hhDqAFV0SatmPDdDKQJS3hw9qyUVO+CdKiMiVPtca
         lAtGsNeo8Rt932S6YTaMzUPdvTj+d8mPt6t3Wg/pS3rBCaeSj36im/JkCzfql8JH8Pw0
         XcDxh90O0TeATsXti4FyniKh9leXabX0jD5GdJUjKcP1BgGjUQCDpr4cnj6/mwqajI3v
         8btWRDCCttGHE8TIsvdEZ5Qez74AMZptqdBBZ15X/5o8hC5IpSRTY28+4BvuvbGDtT/Q
         qkgOxmK+aeoZTxLTjOIRSYjJhJL+Tak7B5VCnz3Y4R4wB1iD/+VZ3znY/pHKVo/qYxdc
         GFRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date;
        bh=TaqQlRA9wMfkARh78jCqln27UUwKbuylUFjHkD67rpg=;
        b=ihsMLlehy0vMWif0qJA9SSKwnbYqzQfbZehKmRHHankSGQPv7Rs7B2tIOinqmxfIWb
         Vkl3HvdVf/Ajbt1U7TayMklLyUEMVToPEKCGtGFB7cq72eLFHlMIkWXw6mvb73EMFUsY
         0YqijLpeo/F7hA+/nve35fz1XS8U8V16STpNkQD62B0XD6EfjfMXCQCjoC+TI0yeLTSN
         /agtwHj7bQk8zj77gdIOcccs4UQFI9qgZ1ycCbx6bJcFygedvHULgVe9kfA68gMi6EpE
         t0G5lHCVb5pB9Vle+fhgJeE3nYsbwYO+vuk9bSchZOnwkm7r64wSg/VAni/9yunpCt8s
         c/KA==
X-Gm-Message-State: ACrzQf3og2C64+G5NkB9+Sayq8Rpfd+Fg7om7Inj8xp9pihINp0QeUzD
        HPJ3mVX+RzkSMsp4TlPrSQIGRKaPyt6auw==
X-Google-Smtp-Source: AMsMyM7X2TuiHZ6rTF+imwhIm5sZ7t0irrXCWlBYENBZ1CAfDlt6e9yjEcF6RXeHBf2x71MSDaOsSQ==
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id g9-20020a05651222c900b00499cb5dc138mr8654673lfu.490.1664196487970;
        Mon, 26 Sep 2022 05:48:07 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 17-20020ac24851000000b0049496855494sm2532457lfy.104.2022.09.26.05.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 05:48:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: samsung: soc: match preferred naming in entire compatible
Date:   Mon, 26 Sep 2022 14:47:57 +0200
Message-Id: <20220926124757.475471-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Compatible is a string-array, therefore the "select" should look for
anything containing Samsung SoC part.  This allows to validate cases
like:
 - "samsung,exynos5250-gsc", "samsung,exynos5-gsc"
 - "samsung,exynos5250-pmu", "syscon"
 - "tesla,fsd-mct", "samsung,exynos4210-mct"

Since Tesla FSD builts on top of Exynos blocks, add an adidtional
pattern for it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/arm/samsung/samsung-soc.yaml     | 26 +++++++++++++++----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
index 653f85997643..bb1fdc205b44 100644
--- a/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
+++ b/Documentation/devicetree/bindings/arm/samsung/samsung-soc.yaml
@@ -18,17 +18,33 @@ description: |
     samsung,exynos5433-cmu-isp
 
 select:
-  properties:
-    compatible:
-      pattern: "^samsung,.*(s3c|s5pv|exynos)[0-9a-z]+.*$"
+  allOf:
+    - properties:
+        $nodename:
+          pattern: '^[a-z]'
+    - properties:
+        compatible:
+          contains:
+            pattern: "^samsung,.*(s3c|s5pv|exynos)[0-9a-z]+.*$"
   required:
     - compatible
 
 properties:
   compatible:
     oneOf:
-      - description: Preferred naming style for compatibles of SoC components
-        pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"
+      - description: Preferred naming style for compatibles of S3C/S5P/Exynos SoC components
+        minItems: 1
+        items:
+          - pattern: "^samsung,(s3c|s5pv|exynos|exynosautov)[0-9]+-.*$"
+          - {}
+          - {}
+
+      - description: Preferred naming style for compatibles of Tesla FSD SoC components
+        minItems: 1
+        items:
+          - pattern: "^tesla,fsd-.*$"
+          - {}
+          - {}
 
       # Legacy compatibles with wild-cards - list cannot grow with new bindings:
       - enum:
-- 
2.34.1

