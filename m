Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B17C6D27B1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbjCaSVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjCaSVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:21:39 -0400
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B4B1C1E7;
        Fri, 31 Mar 2023 11:21:38 -0700 (PDT)
Received: by mail-ot1-f48.google.com with SMTP id r40-20020a05683044a800b006a14270bc7eso8962282otv.6;
        Fri, 31 Mar 2023 11:21:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286898;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3t5CKl6Ye7wvWfdL46PtBvqDLWnMxYGWKH3UaAAkiUk=;
        b=fPh/iFOrWzvUgMPurkxKXHYyp2NqdvI172JHtMUVWwBp7xqc0Jh7yB1wDHXDMQsddS
         FPjMz5mc9MYunc7EZ71/u61OcmC3qOmrzg8XZES54tRtp2u1XurmfS4Y7edi/YDs1R79
         /5Lp/ujZL1JkO4MUhW7C5jrv+qHx/MqouKJElZBrNlZ89aC1FTF2NCuTKgfd0/T1ICH2
         KZKc1biKB+hy0Udp+M/47wY3rXEuG4sdgHhiRMO7gvwB0a+zS3tZHzuEUxHTE9RdAx9E
         vhRmcdZiLOE4I/g+dazVm8fSOtEgPbRK9EpBRgVfTe2Ki90TVFfwusRZiwB8WAPhGar7
         DV3Q==
X-Gm-Message-State: AAQBX9f/cSbW/R5ZoTDbchkOjnyOANXvu4cYap+Qh0UjZfbB52BW90Ww
        jmyHecBhkv6cMzHuNDy7Ng==
X-Google-Smtp-Source: AKy350am+Rs5fsysUO/Ou+XiPYyX5AqcPtC+SBfe66RPqx+fy71Nv5pVkD5gs3QV9tnB8HWcypjqAw==
X-Received: by 2002:a9d:7ac9:0:b0:693:d9a5:c5d with SMTP id m9-20020a9d7ac9000000b00693d9a50c5dmr13024037otn.3.1680286897866;
        Fri, 31 Mar 2023 11:21:37 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b22-20020a9d7556000000b006a305c68617sm56551otl.53.2023.03.31.11.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:21:37 -0700 (PDT)
Received: (nullmailer pid 1900261 invoked by uid 1000);
        Fri, 31 Mar 2023 18:21:36 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] dt-bindings: memory-controller: Drop unneeded quotes
Date:   Fri, 31 Mar 2023 13:21:18 -0500
Message-Id: <20230331182119.1899919-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/memory-controllers/renesas,dbsc.yaml           | 4 ++--
 .../bindings/memory-controllers/renesas,rpc-if.yaml         | 2 +-
 .../bindings/memory-controllers/samsung,exynos5422-dmc.yaml | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
index 7056ccb7eb30..8e3822314b25 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,dbsc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/memory-controllers/renesas,dbsc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/memory-controllers/renesas,dbsc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas DDR Bus Controllers
 
diff --git a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
index 30a403b1b79a..56e62cd0b36a 100644
--- a/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/renesas,rpc-if.yaml
@@ -20,7 +20,7 @@ description: |
   - if it contains "cfi-flash", then HyperFlash is used.
 
 allOf:
-  - $ref: "/schemas/spi/spi-controller.yaml#"
+  - $ref: /schemas/spi/spi-controller.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml b/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
index 098348b2b815..783ac984d898 100644
--- a/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
+++ b/Documentation/devicetree/bindings/memory-controllers/samsung,exynos5422-dmc.yaml
@@ -42,7 +42,7 @@ properties:
     maxItems: 8
 
   devfreq-events:
-    $ref: '/schemas/types.yaml#/definitions/phandle-array'
+    $ref: /schemas/types.yaml#/definitions/phandle-array
     minItems: 1
     maxItems: 16
     items:
@@ -50,7 +50,7 @@ properties:
     description: phandles of the PPMU events used by the controller.
 
   device-handle:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       phandle of the connected DRAM memory device. For more information please
       refer to jedec,lpddr3.yaml.
@@ -73,7 +73,7 @@ properties:
       - description: registers of DREX1
 
   samsung,syscon-clk:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Phandle of the clock register set used by the controller, these registers
       are used for enabling a 'pause' feature and are not exposed by clock
-- 
2.39.2

