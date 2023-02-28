Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237BF6A56A7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:27:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231171AbjB1K13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbjB1K1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:27:15 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC872CFD8;
        Tue, 28 Feb 2023 02:27:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C18B06602FDB;
        Tue, 28 Feb 2023 10:27:12 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677580033;
        bh=DycugKaR5mUM4/B5jFI1O5Chf+Iz4ZY0tMtXPBou2pk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TciQedvWltIU9GlfNDq1yjwAWt4XET1fgMhl0b6ZCnY+lY0vdzRTnVQPCOaA5LNBA
         tG33T24975UVz71zgw8/NZVKYtYc3CGnkr095mNYN67WrLecErMKuGYEmjI6rXHu2i
         Z+Qqc+KjsW9mHmrJj65YRImlICLoEANfaAXB37L0ubbEbB9swHQ1IpndwbmF4RurdK
         kGoXOFGBQMg9FRRmhhAxJ3BpQVIjbBKoP3ujR+RsO6Ws4O7H0VgNYq7HK4aYp3Pt1M
         eUWnuoCv7eGQsEnLZnkQsXkEqP9OCrfKNobQSrVg8QLYSY7nNSlsnh1pmMnOg01cwi
         FsELsq2vFknFw==
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
Subject: [PATCH v4 05/12] dt-bindings: gpu: mali-bifrost: Add new MT8183 compatible
Date:   Tue, 28 Feb 2023 11:26:57 +0100
Message-Id: <20230228102704.708150-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
References: <20230228102704.708150-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---

Since the changes are small, I kept the Reviewed-by tags that were
released on the previous version of this patch.
If that was wrong, please advertise so.

 .../bindings/gpu/arm,mali-bifrost.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index c5bef872114d..cf24aaba70f2 100644
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
@@ -177,6 +178,24 @@ allOf:
     else:
       properties:
         sram-supply: false
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8183b-mali
+    then:
+      properties:
+        power-domains:
+          minItems: 3
+          maxItems: 3
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+            - const: core2
+      required:
+        - power-domains
+        - power-domain-names
   - if:
       properties:
         compatible:
-- 
2.39.2

