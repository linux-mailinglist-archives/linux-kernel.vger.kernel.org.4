Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C42D654497
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 16:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231187AbiLVPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 10:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiLVPvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 10:51:55 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C99165AA;
        Thu, 22 Dec 2022 07:51:54 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 857476602CD9;
        Thu, 22 Dec 2022 15:51:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671724313;
        bh=3eFP3ouO4RR+WchS8C8yL39f+/y+XVsgL/MqIts3FDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Jmn7DTnB6taOrn7Lgc1s7bisSM8rGmZg+9wCyG6xOnmnAfnAfUufSjnmFmA/pO2ZV
         zghc1NF0SRNEWdHLrxle/LWYjoOZJhELJpRrMu2Pzq8BuLUCq0aa55PKg+z6NrVtPl
         wUuQiZAf0A32WnoygbMmq9YmWwuy+ntyZkJMQeJcm+nqAtktYOIc2NXmB5vSA6BIqS
         VrXUGOidpRoTPs0Ve0OVCkE19B4xQJg1LN0TkxL70a44F45IGxwke1IcMIJwXm+Cth
         LXqzMTm+RgsTQ+XSlxa6E/UbL9yo1D8EsLcgxv3iqB2DBZaMJh2lcqlcPYKJqtgWC4
         xv4QW+8NF8k/A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 2/6] dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795, MT8173/92/95
Date:   Thu, 22 Dec 2022 16:51:43 +0100
Message-Id: <20221222155147.158837-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
References: <20221222155147.158837-1-angelogioacchino.delregno@collabora.com>
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

MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
compatibles for them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
index cfd042ac1e14..d00327d12e1e 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
@@ -16,7 +16,12 @@ description: |
 
 properties:
   compatible:
-    const: mediatek,mt8186-fhctl
+    enum:
+      - mediatek,mt6795-fhctl
+      - mediatek,mt8173-fhctl
+      - mediatek,mt8186-fhctl
+      - mediatek,mt8192-fhctl
+      - mediatek,mt8195-fhctl
 
   reg:
     maxItems: 1
-- 
2.39.0

