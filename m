Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7160F41F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 11:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235287AbiJ0Jzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 05:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbiJ0JzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 05:55:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C8B52FD6;
        Thu, 27 Oct 2022 02:55:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5CBD766028D2;
        Thu, 27 Oct 2022 10:55:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666864518;
        bh=W8SEx0xapJJdUfHfS4BFtY3HtU4jbX1ZpxNLzv2olK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SbL5im1DrRuFVThK8Et1NFIXOa0kw9VUBh3iZ6XNTqtB6k7yRU0CGbhg1p81W9vet
         URFH82qFjD1EpvYPczHsA+I7xoviwfe30+z9hnqGWZtGA4biNsdwpcf0RfhCWHAWex
         1nkr7qGnByNOL5d/0//IOs7NqPLPiXRQO8meoOrE4kAtU2olEOBpbtT49qHQvzDjDv
         qohCakq6tZE3Fk9ki9m7lcOgIb1nc3Ul++IqZYO1G8OgCIarMdLiG3MCWP1vRdOoqU
         +Y/176vWxVIqcsw+JrGCprCTvASnpvv8sgn+XiMBSon/bfV4xRgo2gBbNIjpnNTULx
         RN/9oVZZhSpHw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     matthias.bgg@gmail.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, hsinyi@chromium.org,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sam.shih@mediatek.com, andrew@lunn.ch, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 5/6] dt-bindings: arm: mediatek: Add compatible for MT6795 Sony Xperia M5
Date:   Thu, 27 Oct 2022 11:55:03 +0200
Message-Id: <20221027095504.37432-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
References: <20221027095504.37432-1-angelogioacchino.delregno@collabora.com>
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

Add a compatible for the Sony Xperia M5 smartphone.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/arm/mediatek.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index d76ce4c3819d..49153d66796a 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -58,6 +58,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt6795-evb
+              - sony,xperia-m5
           - const: mediatek,mt6795
       - items:
           - enum:
-- 
2.37.2

