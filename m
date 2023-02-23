Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F19BA6A0AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:35:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjBWNfU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:35:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbjBWNfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:35:00 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C0731E37;
        Thu, 23 Feb 2023 05:35:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 242906602206;
        Thu, 23 Feb 2023 13:34:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677159298;
        bh=8laopmxtR2OlouaKlRNp419Yf1O5zDNFgjtz+3x6w6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELHcbqVZlsGf9F5eWvkeUdUS6r54S6c20urNg8COWvLiOWeQLN+XvJdtF111drNqG
         j88UAdHB5EORMwWIwMyIohA02twGQKeDj7ZETlgdk8i+7kUKvsgdAqKBilxs2I3+fT
         xpq8W+03OxqlTT9zaJHwvHYhm/olqxKQWy2zyaXgvYVVyLtjeYrLxYFiD/0CtTh0Vh
         GokQAcANcL3X+dGcE05wB/n2KO8NzQc9cJgF//kOPUj8iUDBRVLq+rqephLG5oUx20
         r+31XHYb3qsKZU+qoykzHtdlotX6tbGfzwcUtfEqoQWDMRM9JllelqjpF414w2xzzy
         Oih3Cp9+LICgQ==
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
Subject: [PATCH v3 06/11] dt-bindings: gpu: mali-bifrost: Add support for MediaTek MT8186
Date:   Thu, 23 Feb 2023 14:34:35 +0100
Message-Id: <20230223133440.80941-7-angelogioacchino.delregno@collabora.com>
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

MT8186 has a Mali-G52 MC2 2EE GPU (two cores): add a binding with
two power domains (one per core) for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../bindings/gpu/arm,mali-bifrost.yaml         | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index be18b161959b..b9424f3ebd5f 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -20,6 +20,7 @@ properties:
               - amlogic,meson-g12a-mali
               - mediatek,mt8183-mali
               - mediatek,mt8183b-mali
+              - mediatek,mt8186-mali
               - realtek,rtd1619-mali
               - renesas,r9a07g044-mali
               - renesas,r9a07g054-mali
@@ -159,6 +160,7 @@ allOf:
               enum:
                 - mediatek,mt8183-mali
                 - mediatek,mt8183b-mali
+                - mediatek,mt8186-mali
                 - mediatek,mt8192-mali
     then:
       properties:
@@ -204,6 +206,22 @@ allOf:
       required:
         - power-domains
         - power-domain-names
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: mediatek,mt8186-mali
+    then:
+      properties:
+        power-domains:
+          minItems: 2
+        power-domain-names:
+          items:
+            - const: core0
+            - const: core1
+      required:
+        - power-domains
+        - power-domain-names
   - if:
       properties:
         compatible:
-- 
2.39.2

