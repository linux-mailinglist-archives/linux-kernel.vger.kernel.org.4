Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8581A5F53D2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbiJELkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiJELkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:40:04 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BD04DF77;
        Wed,  5 Oct 2022 04:37:18 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73F2A66022F9;
        Wed,  5 Oct 2022 12:35:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664969739;
        bh=/7BGNVmlvPkqeDYBGkWztyuuvDVeU67h+vPFB54rXc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ct9+K1N+ae63ngLJ6uGP20dsPPJ0BTs6+78OZ+A9nGM6zkENoRXts2wBvrNwmnGUV
         MoWW2tswP4zV77YyjzaapzVEp7VydKdQl0WgOshQuZM5tI/dCKXMNdl075b37xWa0j
         HDH7VHU1bln2BUyi3BF9ai5iMLw9LqNwdiwM4+IihhxZppjBx1xsNBntcBTMJCINxo
         sVO7+MQiACkHY1xF2QRga2m3AcgBrtwSz/X04uYWO6Bg6qFvFFhxTlsNw0ts7zhrla
         dFIxgF0AuDt78oVdJxHH2BcKJY9f51i0XoNvQ6fqhWHB+LCaRuC3XjbuLyye9MLv4h
         hm3OGiBTMpajQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     wim@linux-watchdog.org
Cc:     linux@roeck-us.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        allen-kh.cheng@mediatek.com, seiya.wang@mediatek.com,
        angelogioacchino.delregno@collabora.com, tinghan.shen@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] dt-bindings: watchdog: mediatek,mtk-wdt: Add compatible for MT6795
Date:   Wed,  5 Oct 2022 13:35:16 +0200
Message-Id: <20221005113517.70628-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the mediatek,mt6795-wdt compatible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
index f43b5af92d40..54dfe7941d53 100644
--- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
+++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
@@ -23,6 +23,7 @@ properties:
           - enum:
               - mediatek,mt2712-wdt
               - mediatek,mt6589-wdt
+              - mediatek,mt6795-wdt
               - mediatek,mt7986-wdt
               - mediatek,mt8183-wdt
               - mediatek,mt8186-wdt
-- 
2.37.2

