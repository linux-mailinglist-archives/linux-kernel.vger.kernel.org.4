Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682756DF360
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjDLL2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjDLL2J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FE449C7;
        Wed, 12 Apr 2023 04:28:03 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 231636603213;
        Wed, 12 Apr 2023 12:27:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298872;
        bh=lu2YqjszT6GAQfheSYtmuPDjTI03Qls3ZRurM5/bzdk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UOZnOw2J87HqYSwK3AmmugMo0zxjvfBq7HlkaMBwgOEibqfmGDylJYzvoabSKOCFm
         Gpoq95VCcoNzMiyLhc7EfhZG3PMNDwkHi/tcs3brHC6NcLq51IzjMrFIEH32AQERie
         aAbFzQA2Gbw6p1jjT5A8naU3ZQT5iGBGvMXf4kSSMwFrp5KWaLzDTPMtcnEoFj2jJ4
         gX2agOSfKZpLT5d7dueZvC46+auOanKQOKTidisZWyYDhZvdaD+jVTKlYLJsAzIf9O
         3J2Fy7OkjNMDm3rNwSbwUDncpPbyhmbdg67VZglnh/xgdtnIn5QfrMFV3n+IPvWmeo
         yIpS2GztN7+0g==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        angelogioacchino.delregno@collabora.com, ck.hu@mediatek.com,
        jitao.shi@mediatek.com, xinlei.lee@mediatek.com,
        houlong.wei@mediatek.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Subject: [PATCH 05/27] dt-bindings: display: mediatek: dsi: Add compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 13:27:17 +0200
Message-Id: <20230412112739.160376-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a compatible string for MediaTek Helio X10 MT6795, using the same
DSI block as MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../display/mediatek/mediatek,dsi.yaml        | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
index 4707b60238b0..12441b937684 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,dsi.yaml
@@ -22,13 +22,18 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - mediatek,mt2701-dsi
-      - mediatek,mt7623-dsi
-      - mediatek,mt8167-dsi
-      - mediatek,mt8173-dsi
-      - mediatek,mt8183-dsi
-      - mediatek,mt8186-dsi
+    oneOf:
+      - enum:
+          - mediatek,mt2701-dsi
+          - mediatek,mt7623-dsi
+          - mediatek,mt8167-dsi
+          - mediatek,mt8173-dsi
+          - mediatek,mt8183-dsi
+          - mediatek,mt8186-dsi
+      - items:
+          - enum:
+              - mediatek,mt6795-dsi
+          - const: mediatek,mt8173-dsi
 
   reg:
     maxItems: 1
-- 
2.40.0

