Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FA1B6CAB33
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 19:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjC0RBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjC0RBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 13:01:14 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96E3F30D0;
        Mon, 27 Mar 2023 10:01:13 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-17997ccf711so9991991fac.0;
        Mon, 27 Mar 2023 10:01:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679936473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PzJOwXJGnpewWNNi+yNJmLTRAbz5urBiQadDRHFSL6c=;
        b=G94gmNO61AGdTV3QALGNnxWhgpLZIjGJIkyKj78EtNajbQND+pqgcdoeUsa2vZJTnK
         9peEtkP/JaByylj6EHPrIa41ePmJlinqFOVcl4iWA1VdHoXjNjSyFdrScwaNfuh0tX2T
         oCevyR3OxAtairA//o1URnmChIsnd2tzK8CiKotKtDxrJJFEv3I5NDnBOHRoKWvc2yTK
         HbMIoU3vSBSxpHaeCCJme8KqpXdtuXiXwheQtnr8abjoSIOnXakHHmkla69SzJsctID/
         as9x5Zg/eRTt5yw1k/MiUJ0tETtFLbQka1kvcOVJobDJ2wZ4JqhsTozspJSV4XLNgsO4
         gYow==
X-Gm-Message-State: AO0yUKXJnVQ2W+01mAIEIUcgNyLA7bl6YsOHqD2Nn5jDzWEBSTSZFYAJ
        8XVKXlHnzPJjThWVNJ0AeA==
X-Google-Smtp-Source: AKy350Z+Kjw1i/JksSjolvq7a2t5f+4ZePOoRduRRvCMM6+RJnEwzPjGBbNXpHwywbmrYn/4T9J30A==
X-Received: by 2002:a05:6870:a454:b0:176:26b7:44b3 with SMTP id n20-20020a056870a45400b0017626b744b3mr8893265oal.36.1679936472726;
        Mon, 27 Mar 2023 10:01:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u6-20020a056870b0c600b00172289de1besm9527286oag.18.2023.03.27.10.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 10:01:11 -0700 (PDT)
Received: (nullmailer pid 4102273 invoked by uid 1000);
        Mon, 27 Mar 2023 17:01:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Cc:     linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH] dt-bindings: ata: Drop unneeded quotes
Date:   Mon, 27 Mar 2023 12:00:53 -0500
Message-Id: <20230327170053.4100949-1-robh@kernel.org>
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
 Documentation/devicetree/bindings/ata/ahci-common.yaml      | 6 +++---
 Documentation/devicetree/bindings/ata/ahci-platform.yaml    | 2 +-
 .../devicetree/bindings/ata/renesas,rcar-sata.yaml          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/ahci-common.yaml b/Documentation/devicetree/bindings/ata/ahci-common.yaml
index 94d72aeaad0f..7fdf40954a4c 100644
--- a/Documentation/devicetree/bindings/ata/ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-common.yaml
@@ -59,7 +59,7 @@ properties:
     const: sata-phy
 
   hba-cap:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Bitfield of the HBA generic platform capabilities like Staggered
       Spin-up or Mechanical Presence Switch support. It can be used to
@@ -67,7 +67,7 @@ properties:
       in case if the system firmware hasn't done it.
 
   ports-implemented:
-    $ref: '/schemas/types.yaml#/definitions/uint32'
+    $ref: /schemas/types.yaml#/definitions/uint32
     description:
       Mask that indicates which ports the HBA supports. Useful if PI is not
       programmed by the BIOS, which is true for some embedded SoC's.
@@ -110,7 +110,7 @@ $defs:
         description: Power regulator for SATA port target device
 
       hba-port-cap:
-        $ref: '/schemas/types.yaml#/definitions/uint32'
+        $ref: /schemas/types.yaml#/definitions/uint32
         description:
           Bitfield of the HBA port-specific platform capabilities like Hot
           plugging, eSATA, FIS-based Switching, etc (see AHCI specification
diff --git a/Documentation/devicetree/bindings/ata/ahci-platform.yaml b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
index 7dc2a2e8f598..6d9e33276ba7 100644
--- a/Documentation/devicetree/bindings/ata/ahci-platform.yaml
+++ b/Documentation/devicetree/bindings/ata/ahci-platform.yaml
@@ -34,7 +34,7 @@ select:
     - compatible
 
 allOf:
-  - $ref: "ahci-common.yaml#"
+  - $ref: ahci-common.yaml#
 
 properties:
   compatible:
diff --git a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
index c4e4a9eab658..fe0909554790 100644
--- a/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
+++ b/Documentation/devicetree/bindings/ata/renesas,rcar-sata.yaml
@@ -1,8 +1,8 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: "http://devicetree.org/schemas/ata/renesas,rcar-sata.yaml#"
-$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+$id: http://devicetree.org/schemas/ata/renesas,rcar-sata.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Renesas R-Car Serial-ATA Interface
 
-- 
2.39.2

