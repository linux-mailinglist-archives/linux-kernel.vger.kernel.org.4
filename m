Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56953604C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231597AbiJSPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbiJSPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:53:57 -0400
X-Greylist: delayed 733 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 19 Oct 2022 08:51:30 PDT
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3987B196089;
        Wed, 19 Oct 2022 08:51:30 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.94.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1olB9A-000167-Pv; Wed, 19 Oct 2022 17:38:20 +0200
Date:   Wed, 19 Oct 2022 16:38:14 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: phy: mediatek: tphy: add compatible for
 tphy-v4
Message-ID: <07c5d962515c4f675f076bb91d69eaf651b187c6.1666193782.git.daniel@makrotopia.org>
References: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df51b63add2830d91b527db64fba6ffdb7765f5d.1666193782.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V4 can be found in MT7986 and MT7981 SoCs, it supports PCIe with two
lanes.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
index 5613cc5106e32f..851e3dda7b638b 100644
--- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
+++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
@@ -89,6 +89,11 @@ properties:
               - mediatek,mt8188-tphy
               - mediatek,mt8195-tphy
           - const: mediatek,generic-tphy-v3
+      - items:
+          - enum:
+              - mediatek,mt7981-tphy
+              - mediatek,mt7986-tphy
+          - const: mediatek,generic-tphy-v4
       - const: mediatek,mt2701-u3phy
         deprecated: true
       - const: mediatek,mt2712-u3phy
@@ -99,7 +104,7 @@ properties:
     description:
       Register shared by multiple ports, exclude port's private register.
       It is needed for T-PHY V1, such as mt2701 and mt8173, but not for
-      T-PHY V2/V3, such as mt2712.
+      T-PHY V2/V3/V4, such as mt2712.
     maxItems: 1
 
   "#address-cells":
-- 
2.37.3

