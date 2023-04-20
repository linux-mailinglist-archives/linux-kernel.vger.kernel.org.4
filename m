Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F0AA6E9492
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 14:36:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjDTMgN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 08:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231715AbjDTMgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 08:36:03 -0400
Received: from fudo.makrotopia.org (fudo.makrotopia.org [IPv6:2a07:2ec0:3002::71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71B356EB9;
        Thu, 20 Apr 2023 05:35:58 -0700 (PDT)
Received: from local
        by fudo.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1ppTW0-0005Vz-2e;
        Thu, 20 Apr 2023 14:35:56 +0200
Date:   Thu, 20 Apr 2023 13:35:51 +0100
From:   Daniel Golle <daniel@makrotopia.org>
To:     devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        John Crispin <john@phrozen.org>
Subject: [PATCH v2 1/2] dt-bindings: pwm: mediatek: Add mediatek,mt7981
 compatible
Message-ID: <2662c29ec80458852bb8c9041656bca46e2662dd.1681992038.git.daniel@makrotopia.org>
References: <cover.1681992038.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1681992038.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add compatible string for the PWM unit found of the MediaTek MT7981 SoC.
This is in preparation to adding support in the pwm-mediatek.c driver.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
No changes since v1.

 Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
index 8e176ba7a525f..0fbe8a6469eb2 100644
--- a/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
+++ b/Documentation/devicetree/bindings/pwm/mediatek,mt2712-pwm.yaml
@@ -22,6 +22,7 @@ properties:
           - mediatek,mt7623-pwm
           - mediatek,mt7628-pwm
           - mediatek,mt7629-pwm
+          - mediatek,mt7981-pwm
           - mediatek,mt7986-pwm
           - mediatek,mt8183-pwm
           - mediatek,mt8365-pwm
-- 
2.40.0

