Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0D26CAB4E
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232324AbjC0RCp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232307AbjC0RC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:02:28 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81975BA8;
        Mon, 27 Mar 2023 10:02:03 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-17ec8963db8so9948693fac.8;
        Mon, 27 Mar 2023 10:02:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936523;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g36LB56fmScqFYQLMR1QrBmpqkKWb5a6f9AKykOj3Bw=;
        b=Qmu+VySu7TL05kGXlSHzDXFO0MWG8ytlr/Zu4j/Ey6WvUhWMP7UMh0zR+RDFuLyyfw
         2QUIiYsULZkBIiU+Q1EFNRshIlFJrRReh/f15+vQqlErxQYcRDogRyvtkM2P/LIhXnfP
         vofS/ajM6RKli6/gzuCP/UfxvevPbcGlseglMG4pcHJY++q2xQYafnRFIXo/V0pDo3Ga
         tU9I/R72ZUGcpcyS8ePXMxgrwUcjCZ51lEG279efsQVl71a+nto+/q2b8H0omS+dxJcn
         jonR56UvR9/ZbByx/JskpWogoeWY3r8bOwYebzMXL707k9jraSxRAjgaxR6wYqQGrSsS
         G7GQ==
X-Gm-Message-State: AAQBX9cO32HZvM/nE8z9DWEYDX8PF7V5piYKxbH+XgrPeF7pLj9CQ14o
        +zGBKrZZecOeNHQVFV10+g==
X-Google-Smtp-Source: AKy350YnHstOEw1avVxSXYtmJmZlzDSW/DDiq3a65+LUgrmEvX2Gwz7648gA6HnLvYFD+vanJTRbEQ==
X-Received: by 2002:a05:6870:e255:b0:17a:a7af:6ce7 with SMTP id d21-20020a056870e25500b0017aa7af6ce7mr8867996oac.39.1679936522863;
        Mon, 27 Mar 2023 10:02:02 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bf9-20020a0568700a0900b0017264f96879sm640694oac.17.2023.03.27.10.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:02:02 -0700 (PDT)
Received: (nullmailer pid 4106102 invoked by uid 1000);
        Mon, 27 Mar 2023 17:02:01 -0000
From:   Rob Herring <robh@kernel.org>
To:     Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: rng: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:01:53 -0500
Message-Id: <20230327170153.4105594-1-robh@kernel.org>
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
 Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml | 4 ++--
 Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml | 4 ++--
 Documentation/devicetree/bindings/rng/mtk-rng.yaml           | 4 ++--
 Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml   | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
index 09c6c906b1f9..457a6e43d810 100644
--- a/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/amlogic,meson-rng.yaml
@@ -2,8 +2,8 @@
 # Copyright 2019 BayLibre, SAS
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/rng/amlogic,meson-rng.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/rng/amlogic,meson-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Amlogic Meson Random number generator
 
diff --git a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
index a00e9bc8b609..827983008ecf 100644
--- a/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
+++ b/Documentation/devicetree/bindings/rng/brcm,iproc-rng200.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/rng/brcm,iproc-rng200.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/rng/brcm,iproc-rng200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: HWRNG support for the iproc-rng200 driver
 
diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.yaml b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
index bb32491ee8ae..7e8dc62e5d3a 100644
--- a/Documentation/devicetree/bindings/rng/mtk-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/mtk-rng.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/rng/mtk-rng.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/rng/mtk-rng.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: MediaTek Random number generator
 
diff --git a/Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml b/Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml
index e749818fc193..06a6791b3356 100644
--- a/Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml
+++ b/Documentation/devicetree/bindings/rng/ti,keystone-rng.yaml
@@ -25,7 +25,7 @@ properties:
     maxItems: 1
 
   ti,syscon-sa-cfg:
-    $ref: "/schemas/types.yaml#/definitions/phandle"
+    $ref: /schemas/types.yaml#/definitions/phandle
     description: |
       Phandle to syscon node of the SA configuration registers.  These
       registers are shared between HWRNG and crypto drivers.
-- 
2.39.2

