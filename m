Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5125B9733
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 11:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiIOJNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 05:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiIOJNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:13:00 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415498C87;
        Thu, 15 Sep 2022 02:12:28 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7586B6602024;
        Thu, 15 Sep 2022 10:12:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663233147;
        bh=4/Xh1ohuebKIvwC0AY9uFYUnkjduE8QIlQvHvl8T/XU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JEVh4ujoePpJ2IoUdJlXxb+O+ySGtNP5u+CNq05Y9IHbyLTKXwflYEnzmuP4N6lfK
         Y8xs1XuQ5o/c6Yu7NHZjcyRMyKawU/OowkmJ4WdFnd9jeL5WF+FSJJYFAQX6+E17XO
         688eoFUNi7LzLfw2NSgXjkE9l6fO20a/Nq4N22ADlJCrEwcxwBIFax2R3edtEjFbB3
         CxcTIaV4zphisAzaT3HmJ1UjkFeWeMbzWqBAks76KpvalnulVAbKTuorq6eKkwn2tU
         N7JCsFnoPTro7ZvDSB7ze0HcE6uXPzeuW/JYiREXBKC2tdQV2LnWhyA+Ey567/oklG
         XA13kC4xeL8xg==
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
Subject: [PATCH 6/7] dt-bindings: leds: leds-mt6323: Document mt6332 compatible
Date:   Thu, 15 Sep 2022 11:12:13 +0200
Message-Id: <20220915091214.59673-7-angelogioacchino.delregno@collabora.com>
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

Add support for MT6332 LEDs/WLEDs with compatible "mediatek,mt6332-led".

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 08dcb237a8c2..f33c2f391ad1 100644
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
2.37.2

