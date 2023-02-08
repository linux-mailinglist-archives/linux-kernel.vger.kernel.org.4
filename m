Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E299368ED15
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231587AbjBHKhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:37:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbjBHKhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:32 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6358146179;
        Wed,  8 Feb 2023 02:37:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2EE74660209A;
        Wed,  8 Feb 2023 10:37:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675852648;
        bh=d0G1BjjpzFctDZyjviGuYyWcI6wqWF1+NmTwUM5ryBs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMnBmVeQqM3mZa3JMdwTPCM9maPHuXoBCaIDUWShbjzXpN0eA48WHjqmpYxa7aaMe
         D0wGrLRwK3QCtWax+iZlRy5r99p3fpTLjRr3x0QGimaQwOmaN0n87rmvJNdf9ZRfSo
         0yV8I1/f8M2Pos7NY56XFij//aZNqD+xCBOoaWlGHaljDKiE+hDXYxaf07DStwoqlR
         6NNJqxJDMFgUWthCvBVtpLceUN9UePv0G1qWBFtutMLDqFaQq/LMMofUnW84uvNdGP
         DKMk4mjsdru1dalbYNUnauvsRFyAXt7rvkhCqzQWwBjV38NUkvplKzpt7ras7QWZ9D
         8qhv9z8+fKybQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     airlied@gmail.com
Cc:     daniel@ffwll.ch, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tomeu.vizoso@collabora.com,
        steven.price@arm.com, alyssa.rosenzweig@collabora.com,
        matthias.bgg@gmail.com, robh@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/9] dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
Date:   Wed,  8 Feb 2023 11:37:04 +0100
Message-Id: <20230208103709.116896-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
References: <20230208103709.116896-1-angelogioacchino.delregno@collabora.com>
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

Since new platform data was required in Panfrost for getting GPU DVFS
finally working on MediaTek SoCs, add a new "mediatek,mt8183b-mali"
compatible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/gpu/arm,mali-bifrost.yaml        | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 6bd0a5b3c5b7..8c57b89ee866 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -19,6 +19,7 @@ properties:
           - enum:
               - amlogic,meson-g12a-mali
               - mediatek,mt8183-mali
+              - mediatek,mt8183b-mali
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
@@ -153,6 +154,7 @@ allOf:
             contains:
               enum:
                 - mediatek,mt8183-mali
+                - mediatek,mt8183b-mali
                 - mediatek,mt8192-mali
     then:
       properties:
@@ -178,6 +180,24 @@ allOf:
         - sram-supply
         - power-domains
         - power-domain-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183b-mali
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+
+      required:
+        - power-domains
+        - power-domain-names
   - if:
       properties:
         compatible:
-- 
2.39.1

