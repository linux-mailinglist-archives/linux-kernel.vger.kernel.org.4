Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69A826D27B9
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjCaSWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbjCaSW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:22:29 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229E023698;
        Fri, 31 Mar 2023 11:22:25 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id f14so3771079oiw.10;
        Fri, 31 Mar 2023 11:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680286944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f9UhKBRFdSgZY4m5Cd2DHq4T/UdvqVuy09n+C4WToZs=;
        b=ALIEDEb7F3zhoqVBkEAouZxdGOx4Sv06SoqhzXpKv3i6KMOnAyO4AS5DhkU664je9A
         BhbIQk8pAILsEzWXBDl/BtxqrFGry1ZtKqhRzAk8fY9CmC+HWnhSw4Gv4V2u0iPLSH1P
         u8wvNHPO39D7yTm5VKnoddVJKOy8iH4ktYy85nWw8JBZEK6KGSuZNfFfbidIP//mqigZ
         GiGk3u5XcKtzRZSKPXxoc91WnTYT/E6yMue5DxISx1AkKBSuKW68dZN3wJs+hbEnujG5
         oyvq/Hwdbq0MJiGDtkKi5isHiW320ZFuAdMiYpo+XsQzkZ7KODfWwuHZXzVF094Pm/Aq
         i8Fw==
X-Gm-Message-State: AO0yUKWd7pcP7z+LnysHF0XWezdOTM72aWHW+8DGX/DZ7oe4hr8hd4hh
        ziPLvJ5sJGLXU26dDYTQUA==
X-Google-Smtp-Source: AK7set/MjJxdPOwhbnT0as9wkVA7qitTRNGhdShXi4Ohvymt2oXKN1QtMgqIHyEoftvZkk8LVBvXkQ==
X-Received: by 2002:a05:6808:ab8:b0:387:cfb5:98f1 with SMTP id r24-20020a0568080ab800b00387cfb598f1mr11176985oij.27.1680286944194;
        Fri, 31 Mar 2023 11:22:24 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id q189-20020acad9c6000000b0038756901d1esm1243952oig.35.2023.03.31.11.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:22:23 -0700 (PDT)
Received: (nullmailer pid 1901110 invoked by uid 1000);
        Fri, 31 Mar 2023 18:22:23 -0000
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH] dt-bindings: arm: nvidia: Drop unneeded quotes
Date:   Fri, 31 Mar 2023 13:21:59 -0500
Message-Id: <20230331182159.1900674-1-robh@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup bindings dropping unneeded quotes. Once all these are fixed,
checking for this can be enabled in yamllint.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml   | 6 +++---
 .../bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml   | 6 +++---
 .../bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml       | 4 ++--
 .../bindings/arm/tegra/nvidia,tegra194-cbb.yaml           | 8 ++++----
 .../bindings/arm/tegra/nvidia,tegra234-cbb.yaml           | 4 ++--
 .../bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml        | 4 ++--
 .../bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml        | 4 ++--
 .../bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml        | 4 ++--
 .../bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml        | 4 ++--
 9 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
index b6f57d79a753..84dc6b7512af 100644
--- a/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
+++ b/Documentation/devicetree/bindings/arm/nvidia,tegra194-ccplex.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/nvidia,tegra194-ccplex.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/nvidia,tegra194-ccplex.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra194 CPU Complex
 
@@ -25,7 +25,7 @@ properties:
       - nvidia,tegra194-ccplex
 
   nvidia,bpmp:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Specifies the bpmp node that needs to be queried to get
       operating point data for all CPUs.
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
index 6089a96eae4f..36dbd0838f2d 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra-ccplex-cluster.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/tegra/nvidia,tegra-ccplex-cluster.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra CPU COMPLEX CLUSTER area
 
@@ -29,7 +29,7 @@ properties:
     maxItems: 1
 
   nvidia,bpmp:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Specifies the BPMP node that needs to be queried to get
       operating point data for all CPUs.
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
index 788a13f8aa93..5e0f1dc542b0 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-axi2apb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-axi2apb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra194 AXI2APB bridge
 
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
index dd3a4770c6a1..d9c54c32c6b9 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra194-cbb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/tegra/nvidia,tegra194-cbb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra194 CBB 1.0
 
@@ -64,13 +64,13 @@ properties:
       - description: secure interrupt
 
   nvidia,axi2apb:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Specifies the node having all axi2apb bridges which need to be checked
       for any error logged in their status register.
 
   nvidia,apbmisc:
-    $ref: '/schemas/types.yaml#/definitions/phandle'
+    $ref: /schemas/types.yaml#/definitions/phandle
     description:
       Specifies the apbmisc node which need to be used for reading the ERD
       register.
diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
index 44184ee01449..fcdf03131323 100644
--- a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
+++ b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra234-cbb.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/arm/tegra/nvidia,tegra234-cbb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra CBB 2.0
 
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
index ed9554c837ef..ba4c6473ff92 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvdec.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvdec.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvdec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra NVDEC
 
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
index 8199e5fa8211..c23dae713eb8 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvenc.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvenc.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvenc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra NVENC
 
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
index 895fb346ac72..99a33a5eac3f 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra210-nvjpg.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvjpg.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/gpu/host1x/nvidia,tegra210-nvjpg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra NVJPG
 
diff --git a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
index 4bdc19a2bccf..0b7561c8b9bb 100644
--- a/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
+++ b/Documentation/devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/gpu/host1x/nvidia,tegra234-nvdec.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: NVIDIA Tegra234 NVDEC
 
-- 
2.39.2

