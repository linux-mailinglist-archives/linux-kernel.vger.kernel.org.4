Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E968367C38D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 04:34:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbjAZDeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 22:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236127AbjAZDeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 22:34:08 -0500
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4452465EF0;
        Wed, 25 Jan 2023 19:33:54 -0800 (PST)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pKt1M-0004EY-1k;
        Thu, 26 Jan 2023 04:33:52 +0100
Date:   Thu, 26 Jan 2023 03:33:46 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Jianhui Zhao <zhaojh329@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH v5 1/3] dt-bindings: clock: Add compatibles for MT7981
Message-ID: <cc85ee470c781ff4013f6c21c92c0a21574b12b2.1674703830.git.daniel@makrotopia.org>
References: <cover.1674703830.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1674703830.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for MT7981 to existing bindings at
 - mediatek,apmixedsys.yaml
 - mediatek,topckgen.yaml
 - mediatek,ethsys.txt
 - mediatek,infracfg.yaml
 - mediatek,sgmiisys.txt

Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 .../devicetree/bindings/arm/mediatek/mediatek,ethsys.txt        | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml     | 1 +
 .../devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt      | 2 ++
 .../devicetree/bindings/clock/mediatek,apmixedsys.yaml          | 1 +
 Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml  | 1 +
 5 files changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
index 0502db73686bf..eccd4b706a78d 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,ethsys.txt
@@ -10,6 +10,7 @@ Required Properties:
 	- "mediatek,mt7622-ethsys", "syscon"
 	- "mediatek,mt7623-ethsys", "mediatek,mt2701-ethsys", "syscon"
 	- "mediatek,mt7629-ethsys", "syscon"
+	- "mediatek,mt7981-ethsys", "syscon"
 	- "mediatek,mt7986-ethsys", "syscon"
 - #clock-cells: Must be 1
 - #reset-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
index 1d7c837d93788..e997635e4fe4e 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.yaml
@@ -28,6 +28,7 @@ properties:
               - mediatek,mt6797-infracfg
               - mediatek,mt7622-infracfg
               - mediatek,mt7629-infracfg
+              - mediatek,mt7981-infracfg
               - mediatek,mt7986-infracfg
               - mediatek,mt8135-infracfg
               - mediatek,mt8167-infracfg
diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
index 29ca7a10b3156..d2c24c2775141 100644
--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sgmiisys.txt
@@ -8,6 +8,8 @@ Required Properties:
 - compatible: Should be:
 	- "mediatek,mt7622-sgmiisys", "syscon"
 	- "mediatek,mt7629-sgmiisys", "syscon"
+	- "mediatek,mt7981-sgmiisys_0", "syscon"
+	- "mediatek,mt7981-sgmiisys_1", "syscon"
 	- "mediatek,mt7986-sgmiisys_0", "syscon"
 	- "mediatek,mt7986-sgmiisys_1", "syscon"
 - #clock-cells: Must be 1
diff --git a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
index 731bfe0408c20..dae25dba4ba69 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,apmixedsys.yaml
@@ -20,6 +20,7 @@ properties:
       - enum:
           - mediatek,mt6797-apmixedsys
           - mediatek,mt7622-apmixedsys
+          - mediatek,mt7981-apmixedsys
           - mediatek,mt7986-apmixedsys
           - mediatek,mt8135-apmixedsys
           - mediatek,mt8173-apmixedsys
diff --git a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
index 81531b5b0db79..0fdf564148334 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,topckgen.yaml
@@ -35,6 +35,7 @@ properties:
               - mediatek,mt6779-topckgen
               - mediatek,mt6795-topckgen
               - mediatek,mt7629-topckgen
+              - mediatek,mt7981-topckgen
               - mediatek,mt7986-topckgen
               - mediatek,mt8167-topckgen
               - mediatek,mt8183-topckgen
-- 
2.39.1

