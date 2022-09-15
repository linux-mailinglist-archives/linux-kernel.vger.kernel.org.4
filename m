Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6165B972E
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbiIOJNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiIOJM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:12:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EE98A64;
        Thu, 15 Sep 2022 02:12:26 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id F2B656601FF1;
        Thu, 15 Sep 2022 10:12:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663233145;
        bh=6jfqnEPzdQK2D+P1O+BfVEHosUL5CKX6vJs+oxLvAN0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvXgwQLs7+WFiAzDX95/l5PyPWVW9J1v9nvmZId0/+ryl+WEeZHyqYR8Jlem7nh36
         GjJeNXrqEsCiDKW8Q53RNhykS0yrcLqOTyFlpFmgqfrwmg0qPeVUNgo4zXxToIXnGt
         aow3xlT+9URCTAn9O5PmSUkjSj94cJZlq5oBViefIFAYE+HtBTDw2/juUTOZTtpgO8
         oUL0lAYe5yLbP9ZhjbrvE/Lc/v1ffgYTSsW4sanVLdhULHmP/jJ6wD8nrPcWt4stIz
         VGNsCvFTGd1sqdEfuhyFB5tN+PswXhXKNs4pNTzWa7M48WgrvFXCqGRomLqieYu2dj
         TzN/juGL7ivQw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sean.wang@mediatek.com
Cc:     pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/7] dt-bindings: leds: leds-mt6323: Document mt6331 compatible
Date:   Thu, 15 Sep 2022 11:12:11 +0200
Message-Id: <20220915091214.59673-5-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
References: <20220915091214.59673-1-angelogioacchino.delregno@collabora.com>
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

Add mediatek,mt6331-led compatible for the LED controller found
in the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/leds/leds-mt6323.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 45bf9f7d85f3..08dcb237a8c2 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -12,7 +12,9 @@ For MediaTek PMIC wrapper bindings see:
 Documentation/devicetree/bindings/soc/mediatek/pwrap.txt
 
 Required properties:
-- compatible : Must be "mediatek,mt6323-led"
+- compatible : Must be one of
+  - "mediatek,mt6323-led"
+  - "mediatek,mt6331-led"
 - address-cells : Must be 1
 - size-cells : Must be 0
 
-- 
2.37.2

