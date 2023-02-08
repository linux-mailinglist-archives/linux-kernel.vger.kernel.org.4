Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC40B68ED12
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 11:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBHKhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 05:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjBHKhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 05:37:31 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1D3470B6;
        Wed,  8 Feb 2023 02:37:29 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 47D4F6602099;
        Wed,  8 Feb 2023 10:37:27 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675852648;
        bh=gm5F2sSwiOtYTPOlUBqXjRr6lOwCrY+tYUuQg0DBVn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PcA1w0qQ58/z+R8lt9CK1ZTIss+J8CHl2DVcujZANu6edJog53Dc4+v3S9f9ktT0H
         JBCRojfUPmvBkufTRYWbS8IwDw4hDvL/ppm58837d1XzQ+Vn7wBoa6hDT6hzACim0x
         eRgWZ4K9OAPUxs/y1mZu1JQ8cZYg9SSYMmV9s+NgDo0YPheAr6hWgF1ncO4xjjIqNn
         WajBk1GnhU4MiSil1bv+ddv6uttyV3E2ifS+PwMyZQoPaeYiPNZCRIsoZ2gHXxyrbq
         12Wz0CroCjIoXgdyz1Hv+EA3/CmFls5ZAItilsNG5KXokAGZ1mh62uV133Kjx2TVSl
         f3zSnQvFQLgxQ==
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
Subject: [PATCH 3/9] dt-bindings: gpu: mali-bifrost: Add compatible for MT8195 SoC
Date:   Wed,  8 Feb 2023 11:37:03 +0100
Message-Id: <20230208103709.116896-4-angelogioacchino.delregno@collabora.com>
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

The MediaTek MT8195 SoC has a Mali G57 MC5 (Valhall-JM) and has the
same number of power domains and requirements as MT8192 in terms of
bindings.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
index e7aba66ddb8f..6bd0a5b3c5b7 100644
--- a/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
+++ b/Documentation/devicetree/bindings/gpu/arm,mali-bifrost.yaml
@@ -25,6 +25,11 @@ properties:
               - rockchip,px30-mali
               - rockchip,rk3568-mali
           - const: arm,mali-bifrost # Mali Bifrost GPU model/revision is fully discoverable
+      - items:
+          - enum:
+              - mediatek,mt8195-mali
+          - const: mediatek,mt8192-mali
+          - const: arm,mali-valhall-jm # Mali Valhall GPU model/revision is fully discoverable
       - items:
           - enum:
               - mediatek,mt8192-mali
-- 
2.39.1

