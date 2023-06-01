Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE94719A9C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233010AbjFALIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbjFALIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F419129;
        Thu,  1 Jun 2023 04:08:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E8BBA6606EC6;
        Thu,  1 Jun 2023 12:08:19 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617700;
        bh=nQ0MVqFfgCHhWG42gWfQJ98uBqo9DXUvooDjVe+kw74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=es2RIr04MQGlehj8/qes9XlFsnSt1kn/mhZfx6W8aZjemF5KMuDoqVefpiEjSCx9J
         7DoUHG9rAApWC4fBzCEZnaOfbuSe9HBMZIn8zj4tnhcRy3E7HcZxDx740I5jdT0Vd7
         U6ikFPhHA0PrAzKoolJqYUtQJRhApi3sPOL5jwrArXzBfOqvKP7JYdmiejL/E5gtBe
         jzXSArXh3bL4s3/nwjvG1CBxrxPpPBzyAyn+kfGxL6k73MaippcFhawuO5msPLpOud
         s9ovp2opBLJoVbbDaciCggFZS/bsGhSffhq4r6nwtuZuNPZ/iuAowlwsZyQ3KqR5+p
         oP/NpuExVitNA==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 2/8] dt-bindings: leds: leds-mt6323: Document mt6332 compatible
Date:   Thu,  1 Jun 2023 13:08:07 +0200
Message-Id: <20230601110813.2373764-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for MT6332 LEDs/WLEDs with compatible "mediatek,mt6332-led".

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 7dc63af41562..052dccb8f2ce 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -15,6 +15,7 @@ Required properties:
 - compatible : Must be one of
   - "mediatek,mt6323-led"
   - "mediatek,mt6331-led"
+  - "mediatek,mt6332-led"
 - address-cells : Must be 1
 - size-cells : Must be 0
 
-- 
2.40.1

