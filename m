Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07D66DF37E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjDLL2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDLL2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F0B2D40;
        Wed, 12 Apr 2023 04:28:04 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BD5396603222;
        Wed, 12 Apr 2023 12:27:56 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298878;
        bh=xWx6EegFN/Cbl8Z4PW24l4hQjXItZf81rLKoJwUO+Qo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=en1fQNlpo7h26/3IGRfMpiL0JCdY+sdr34CvR3a22Mg5ATikZObWikLJOC5tP/Zq8
         yeNSzjV2lluyQoldlcc351dLO/sfJIWdfEtvAmFU/daLTEr18dweZIbLx0uyyEBD0d
         VI9oB28mqgxMHs6Erw1BBiXpgRJjHV7j0WrfaGcaGhalGxcCqtEseHI4F/XQpcq9Oc
         zyAh6aIfUVyaaTH2A8HCzS8Kyt9Kx3Yxx0LMqZ2Hb1X+lD1tOJRnF79Z4zdEOGxV3r
         4BP5lZkpcjNQcHoSt2Cj0D5weFNsgCx7Q8y4+lRBRubKn3Y2Q21jHLcQVWe/sCt7nZ
         b2pQWmeXfT2AA==
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
Subject: [PATCH 09/27] dt-bindings: display: mediatek: color: Add compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 13:27:21 +0200
Message-Id: <20230412112739.160376-10-angelogioacchino.delregno@collabora.com>
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

Add a compatible string for MediaTek Helio X10 MT6795's COLOR block: this
is the same as MT8173.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,color.yaml     | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
index 62306c88f485..449b37c7560f 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,color.yaml
@@ -35,6 +35,7 @@ properties:
           - const: mediatek,mt2701-disp-color
       - items:
           - enum:
+              - mediatek,mt6795-disp-color
               - mediatek,mt8183-disp-color
               - mediatek,mt8186-disp-color
               - mediatek,mt8188-disp-color
-- 
2.40.0

