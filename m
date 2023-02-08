Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7568ED1C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbjBHKht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:37:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjBHKhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F328B4741A;
        Wed,  8 Feb 2023 02:37:30 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 16FD3660209C;
        Wed,  8 Feb 2023 10:37:29 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675852649;
        bh=NHwI9wz8c2rm9f8C+YQk4IHldiJVGMy9bByas6AgTLs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NPOzPn5DJLfXV7xK7LvRnHr+UPZ1vZHuttiqK7hW4ilQgrER8UKEPM5tuE+ceqxH8
         lWuTDfdPzaALUnr0PwA6ikpN9mIAkoCYBMqkR8TxtG686lsu6sjBG1OB8jcxJJ01rx
         IjpU1IhF/rx1pnvcb1J+kJ8pqzmyRwP17EPybH1CN3nct2hRsPE/25driR3IXo0PNN
         NIVL7vMOnfrafgfguiH1mVeFNRFVjm6JHsmflVuC5Lj8BkfuFz8ph/TWmgAAy8i+X1
         t7ppyaLizEvTOeVubFipnVGZZ6GlrhI9QUp/l+fBfxfU0okzwtAN+Idc3Go1WXDle9
         6dZIfQktps8Ow==
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
Subject: [PATCH 5/9] dt-bindings: gpu: mali-bifrost: Add a compatible for MediaTek MT8186
Date:   Wed,  8 Feb 2023 11:37:05 +0100
Message-Id: <20230208103709.116896-6-angelogioacchino.delregno@collabora.com>
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

Get GPU support on MT8186 by adding its compatible.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index 8c57b89ee866..85111559dfe0 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -15,6 +15,11 @@ properties:
 
   compatible:
     oneOf:
+      - items:
+          - enum:
+              - mediatek,mt8186-mali
+          - const: mediatek,mt8183b-mali
+          - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
       - items:
           - enum:
               - amlogic,meson-g12a-mali
-- 
2.39.1

