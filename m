Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9D96DF34D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbjDLL2P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjDLL2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:28:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ABF22D55;
        Wed, 12 Apr 2023 04:27:52 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A92A8660321B;
        Wed, 12 Apr 2023 12:27:49 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681298871;
        bh=ldbfDeNpQ5/zM9eHSB8JeIaBEL0OQKQfjXn1SCCi2DU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mxXjiJZ7p1YY1OBLjncsrhMXEP05TZ0vQDDw0eNavUZTqfIUSBJNLAPI/rIf/1mBq
         fW8TNlmIwFwmGQfnFIQf05/YA2CPZVCyesNm6ws6hfc0FknxVQR6pzmR9dot980XC4
         pWZ6jir2AzEAzQ9AHpJLlrT0sXC/TCV9e9WLeWaKkQhhWaCvE7xD6KueZe4vjo25HE
         /01O4v6h5nBb8/KUU8c/v8uqAY3B1YccUB4i8RTLhfvuE87uV6ei8Q1lZL4t2vYIYx
         yB/4gBkWRSWVVX1eelHbULStSTgwINvWXqhXuWzIK3HPlsjrHXwvNzvRz0la2VFOc9
         bLAKwfRYagZeA==
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
Subject: [PATCH 04/27] dt-bindings: display: mediatek: aal: Add compatible for MediaTek MT6795
Date:   Wed, 12 Apr 2023 13:27:16 +0200
Message-Id: <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
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

Add a compatible string for MediaTek Helio X10 MT6795: similarly to
MT8173, this SoC has the gamma LUT registers in DISP_AAL.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/display/mediatek/mediatek,aal.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
index 92741486c24d..7fd42c8fdc32 100644
--- a/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
+++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,aal.yaml
@@ -27,6 +27,7 @@ properties:
       - items:
           - enum:
               - mediatek,mt2712-disp-aal
+              - mediatek,mt6795-disp-aal
           - const: mediatek,mt8173-disp-aal
       - items:
           - enum:
-- 
2.40.0

