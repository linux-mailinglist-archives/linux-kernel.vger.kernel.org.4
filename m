Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADE36A56A0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231264AbjB1K1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:27:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbjB1K1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:27:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469B1233EB;
        Tue, 28 Feb 2023 02:27:12 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 19EDA6602FD8;
        Tue, 28 Feb 2023 10:27:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1677580030;
        bh=07ttYEO0iBLHOrhXOFTPyKzhESTahMlFIiXlO4bGx5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HwanA9e8mQdP3F3nehvW+iHlvEKe5WR1w7Ik64jb67REBrVYaOGHmeCnb/cBWmP+3
         O0eqLn0o54Vtl2zQIJvaoTCJkmxc1IJTDGM44j2cpFV0SQ80Hb7sqzgFXHNuDSvCUF
         6A8nwA2xhX+22Q2aFA2Ckbg3gdo8bsL/CuDxdXJLaB2H0nFXGDQQ5phS42jz2Le6cq
         UAniRBIPAO0lVda2L67lVGR2ut/B/j/oi7s1bhuBLvCOdJSpEPdmlRYXgYTTHSDlET
         kU9+dLtg0YnJiLIKrnvEmr2nlQ9+enUFdK7QH50b1vHb5+hTU5C3fCAmOmPlczawXt
         yS9fsVl5VaL9Q==
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
Subject: [PATCH v4 02/12] dt-bindings: gpu: mali-bifrost: Set power-domains maxItems to 5
Date:   Tue, 28 Feb 2023 11:26:54 +0100
Message-Id: <20230228102704.708150-2-angelogioacchino.delregno@collabora.com>
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

In preparation for adding (and fixing) power-domain-names and MediaTek
MT8192 bindings, allow up to five items for power-domains.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 7e110751353e..5b7f1c9d2b30 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -63,7 +63,7 @@ properties:
 
   power-domains:
     minItems: 1
-    maxItems: 3
+    maxItems: 5
 
   resets:
     minItems: 1
@@ -157,6 +157,7 @@ allOf:
       properties:
         power-domains:
           minItems: 3
+          maxItems: 3
         power-domain-names:
           items:
             - const: core0
-- 
2.39.2

