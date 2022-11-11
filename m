Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A15626399
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 22:29:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbiKKV3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 16:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233998AbiKKV30 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 16:29:26 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 699EBE02A;
        Fri, 11 Nov 2022 13:29:24 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id e11-20020a4ab14b000000b0049be568062bso822607ooo.4;
        Fri, 11 Nov 2022 13:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hIp7jd8BG+VyztOlnNrMSKLknJT+C5EdBhL10GKzhBU=;
        b=OGn0nAFk9QVy7Bqwo+jZCLnHxVJo3P3+OH6zWQQqSYui3acUbN75alomjiQGmQjcYJ
         gwuT4CqK/ggb+iB5EHfzwOMNa2yPtdN+RqV07XU5dR1vWTGe5pIuShMs/d0XpjqmfcH/
         f8pUeBpjqmjYwgnfpJHRFdeBwykMJiGfq3dqBx2reCnFAFjKpPT69+hANHoynq/F0y1R
         7qkkGfbtpd/1/Fk1jJm5pSvIngVcxo1czhSqW7Zlq7/4mkAQjpLxQysNWBYy0RTyfoGW
         Klx1n4GTMLNONlUWVKqlygDruwHSNv0Edapr7628rQFgZbFlvmKmGRExNp+BYJKwaNOY
         H1xQ==
X-Gm-Message-State: ANoB5pnF86ZLm/2oTmoUq5PCnGbwv779Ec6ZXF/qJCzt2vTjd/3gJMIH
        Vcs6nvvOid/ZmPZ/qEHxpg==
X-Google-Smtp-Source: AA0mqf4qpdSnYe3yq24GgO3dKhAyK4uUgFYDUEN8XGhdue/Iag212Co/ECLO5w9c0X6gMaWFOQI4fg==
X-Received: by 2002:a4a:5884:0:b0:498:9589:b7ac with SMTP id f126-20020a4a5884000000b004989589b7acmr1706732oob.56.1668202163616;
        Fri, 11 Nov 2022 13:29:23 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id t9-20020a056870638900b0013c955f64dbsm1802406oap.41.2022.11.11.13.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 13:29:23 -0800 (PST)
Received: (nullmailer pid 4104940 invoked by uid 1000);
        Fri, 11 Nov 2022 21:29:24 -0000
From:   Rob Herring <robh@kernel.org>
To:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Thara Gopinath <thara.gopinath@linaro.org>
Cc:     asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH] dt-bindings: Drop type from 'cpus' property
Date:   Fri, 11 Nov 2022 15:28:56 -0600
Message-Id: <20221111212857.4104308-1-robh@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'cpus' is a common property, and it is now defined in dtschema schemas,
so drop the type references in the tree.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/interrupt-controller/apple,aic.yaml | 1 -
 Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml     | 3 ---
 Documentation/devicetree/bindings/power/renesas,apmu.yaml   | 6 ++----
 Documentation/devicetree/bindings/thermal/qcom-lmh.yaml     | 2 +-
 4 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
index e18107eafe7c..698588e9aa86 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/apple,aic.yaml
@@ -90,7 +90,6 @@ properties:
             maximum: 5
 
           cpus:
-            $ref: /schemas/types.yaml#/definitions/phandle-array
             description:
               Should be a list of phandles to CPU nodes (as described in
               Documentation/devicetree/bindings/arm/cpus.yaml).
diff --git a/Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml b/Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml
index c87821be158b..a740378ed592 100644
--- a/Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml
+++ b/Documentation/devicetree/bindings/perf/arm,dsu-pmu.yaml
@@ -32,11 +32,8 @@ properties:
       - description: nCLUSTERPMUIRQ interrupt
 
   cpus:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
     maxItems: 12
-    items:
-      maxItems: 1
     description: List of phandles for the CPUs connected to this DSU instance.
 
 required:
diff --git a/Documentation/devicetree/bindings/power/renesas,apmu.yaml b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
index f2cc89e7f4e4..2b4d802ef4b2 100644
--- a/Documentation/devicetree/bindings/power/renesas,apmu.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,apmu.yaml
@@ -34,10 +34,8 @@ properties:
     maxItems: 1
 
   cpus:
-    $ref: /schemas/types.yaml#/definitions/phandle-array
-    items:
-      minItems: 1
-      maxItems: 4
+    minItems: 1
+    maxItems: 4
     description: |
       Array of phandles pointing to CPU cores, which should match the order of
       CPU cores used by the WUPCR and PSTR registers in the Advanced Power
diff --git a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
index e1587ddf7de3..92762efc2120 100644
--- a/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
+++ b/Documentation/devicetree/bindings/thermal/qcom-lmh.yaml
@@ -37,7 +37,7 @@ properties:
   cpus:
     description:
       phandle of the first cpu in the LMh cluster
-    $ref: /schemas/types.yaml#/definitions/phandle
+    maxItems: 1
 
   qcom,lmh-temp-arm-millicelsius:
     description:
-- 
2.35.1

