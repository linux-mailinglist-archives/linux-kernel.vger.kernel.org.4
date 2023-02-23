Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0706A0A99
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:35:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233362AbjBWNfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjBWNe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:34:58 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5CF531E37;
        Thu, 23 Feb 2023 05:34:55 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 98B0E6602207;
        Thu, 23 Feb 2023 13:34:53 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159294;
        bh=DZyb8vw6qbtsYIBlP4pzm++AodTcvCv6AvAETopyIuw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NYu03vv1qJuOYlmylMrIAyYrmCCeql0wrQvbiOajOzEtWMk9fe2QClrSXl5UKBq7F
         gnBv7pcmHASD9KHn9aA8CYcQjSaz5T5fcM+kbDOExSgearlpCRBas/XTGpT5+o/vDI
         CvVsacZ/DGPBhH6QBAudtY1bmf5NjNlMbNCuF3n8etvKB2aBijiQSCOYMWIYYDpXcM
         YQbUXF9UpbvdB0vTfPN00MjxPShFufEUoPr9vo+FYil4d5wyB5m69+RwLNIFFLEevV
         g0Rh0xjEusaGljfQTj3+SHcAr3LYy+s+85UxTjYgeyaUjp2Il2Zg3U7SMHK3y2HlEQ
         rSJuihO2Whkwg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, steven.price@arm.com,
        alyssa.rosenzweig@collabora.com, matthias.bgg@gmail.com,
        robh@kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 01/11] dt-bindings: gpu: mali-bifrost: Add power-domain-names to base schema
Date:   Thu, 23 Feb 2023 14:34:30 +0100
Message-Id: <20230223133440.80941-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
References: <20230223133440.80941-1-angelogioacchino.delregno@collabora.com>
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

From: Chen-Yu Tsai <wenst@chromium.org>

In commit a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek
MT8183"), "power-domain-names" was added to the mt8183-mali sub-schema,
but was not added to the base mali-bifrost schema. Because validation
happens for the base schema and any sub-schemas separately, this causes
errors to be emitted when validating the MT8183 device trees.

Add power-domain-names to the base schema to silence the error.

Fixes: a7a596cd3115 ("dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183")
Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 78964c140b46..02699d389be1 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -65,6 +65,8 @@ properties:
     minItems: 1
     maxItems: 3
 
+  power-domain-names: true
+
   resets:
     minItems: 1
     maxItems: 3
@@ -166,6 +168,7 @@ allOf:
       properties:
         power-domains:
           maxItems: 1
+        power-domain-names: false
         sram-supply: false
   - if:
       properties:
-- 
2.39.2

