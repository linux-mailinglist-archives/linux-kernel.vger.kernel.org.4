Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1A86BCC8C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbjCPKVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjCPKU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:20:57 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CA3BD4E0;
        Thu, 16 Mar 2023 03:20:49 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 110C8660309F;
        Thu, 16 Mar 2023 10:20:47 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678962047;
        bh=0AQ+gCHdVFTNhiJx165qPUL/6q3xPgjQ71jCDBHRJbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XZDAjq3y2FnChbx/QaN5W8qWibNZXqFSx+bE4yxNo3mFhqkC7puUiGzFrqJ5720we
         v276dVUUfq1cEPXmL24DQ4EhnCiJsU25pvEEIvRp3r/vhHJbgczulchcoecA+QwABQ
         B1HOy+tPc/AkhUEuqiFocFMS+vZeq5umSPFkuuheU3xiOtZYibBpfGg/ajB8vdAruC
         4R7RsK/EAaaGdSde/s04W54Jf6mYSi8f0QMZIPtMAI5KdYR2Pc6Yb27G3iEgE81+XC
         CySRPOBKTfHPlH+BVgy45OGeCYPm+Yxj95Ynox8lSxDadnVcD/twx2DodOuI9ckKhQ
         2H7AMk+HJ9iqg==
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
Subject: [PATCH v5 02/12] dt-bindings: gpu: mali-bifrost: Set power-domains maxItems to 5
Date:   Thu, 16 Mar 2023 11:20:31 +0100
Message-Id: <20230316102041.210269-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
References: <20230316102041.210269-1-angelogioacchino.delregno@collabora.com>
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
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
Reviewed-by: Rob Herring <robh@kernel.org>
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

