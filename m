Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E11070C468
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbjEVRen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:34:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbjEVRee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:34:34 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5414F102;
        Mon, 22 May 2023 10:34:33 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2744C6606E66;
        Mon, 22 May 2023 18:34:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684776871;
        bh=OjRo5bVWm0/EWH6VSr3hLdB1q2WNjk+Aw68TSPXpDNA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gmwjDVefrNXll8xF8QMraIRLTng+FkSF3BsD5OE9+cQa8L5mk39EvPAuaK8o8nBbU
         x2CazKzY7H8Yebp3Uj4rzo4VEGyqqDJIbb94S+ZBRilzyNMvSpefjBh+KrFyokQxIO
         MqdXZUHBcUZBMSODCmnXGiESpKdwOeyVHjj2qX3DfspNEOLrF4dmg3ooVAa75viJkt
         UQkszGWFkSxcsaDjbxYO6J3HqCoJtVtROJwM/pOE7UkY4FGfVCbqjiaNGdLdBX83j3
         HjdcRV+SynVUOu2VtyxeDCTMhT34uQo7pul5phWiZ6pFfopq5rRB07tPOp6Hd5+gvV
         lXTI1WLeARTyA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 8CA1D4807E1; Mon, 22 May 2023 19:34:29 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-ide@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 2/6] dt-bindings: ata: ahci: add RK3588 AHCI controller
Date:   Mon, 22 May 2023 19:34:19 +0200
Message-Id: <20230522173423.64691-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522173423.64691-1-sebastian.reichel@collabora.com>
References: <20230522173423.64691-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like RK3568, the RK3588 has a DWC based AHCI controller.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 .../devicetree/bindings/ata/snps,dwc-ahci-common.yaml     | 8 ++++++--
 Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml  | 6 ++++--
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
index c1457910520b..34c5bf65b02d 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci-common.yaml
@@ -31,11 +31,11 @@ properties:
       PM-alive clock, RxOOB detection clock, embedded PHYs reference (Rx/Tx)
       clock, etc.
     minItems: 1
-    maxItems: 4
+    maxItems: 6
 
   clock-names:
     minItems: 1
-    maxItems: 4
+    maxItems: 6
     items:
       oneOf:
         - description: Application APB/AHB/AXI BIU clock
@@ -48,6 +48,10 @@ properties:
           const: pmalive
         - description: RxOOB detection clock
           const: rxoob
+        - description: PHY Transmit Clock
+          const: asic
+        - description: PHY Receive Clock
+          const: rbc
         - description: SATA Ports reference clock
           const: ref
 
diff --git a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
index 5afa4b57ce20..c6a0d6c8b62c 100644
--- a/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
+++ b/Documentation/devicetree/bindings/ata/snps,dwc-ahci.yaml
@@ -23,9 +23,11 @@ properties:
         const: snps,dwc-ahci
       - description: SPEAr1340 AHCI SATA device
         const: snps,spear-ahci
-      - description: Rockhip RK3568 AHCI controller
+      - description: Rockhip AHCI controller
         items:
-          - const: rockchip,rk3568-dwc-ahci
+          - enum:
+              - rockchip,rk3568-dwc-ahci
+              - rockchip,rk3588-dwc-ahci
           - const: snps,dwc-ahci
 
 patternProperties:
-- 
2.39.2

