Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9B160BFBE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 02:40:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiJYAkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 20:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbiJYAjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 20:39:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7190B1FCC9;
        Mon, 24 Oct 2022 16:07:06 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7D27D6602319;
        Tue, 25 Oct 2022 00:07:02 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666652824;
        bh=syu6x+tQMYyXRnROEzYyOqlWI3pV6D/rMZw1lLuGM5g=;
        h=From:To:Cc:Subject:Date:From;
        b=bMUwQ7iyuh1NncKE+xbrlV4imgXvN327I0B1FFYOlO9RvlB4/vL5xDB5HkHfSrltg
         jqoPN/y0eDEWf0R0TqfMACGkLH/iC88vUEJEyjIy2hzRo2TL51zDjk84uo8rEZ2O2u
         fJ3Q9lCEFsbQAMMS+eT8uN+bdrbkWyQXLKaw+AN7nnZBTdJ1GopP7mGKT72fbCCtJA
         QkLmUSxiIDx2kftHEj3WQeYtpXNQpLRoBXZK4KrZRyce8QGIaCa5Kw/+2RRTT/6RPo
         wSsVI2XKgM9bJnwXyzcxPRU/XPrCf+rLUiVsmj0VlLDEDvu5t7q4vIC9N4KP15I8HQ
         S+iDU7uVQPNDA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shane Chien <shane.chien@mediatek.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] ASoC: dt-bindings: mt8192-mt6359: Set maxItems, not type, for sound-dai
Date:   Mon, 24 Oct 2022 19:06:57 -0400
Message-Id: <20221024230658.1772907-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sound-dai is a standard property whose type is already set to
phandle-array by sound-dai.yaml, so there's no need to set it (and
wrongly so for headset-codec) in this binding. What should be set
however is the maximum number of items, which for headset-codec should
be 1.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
index 478be7e3fa29..c6e614c1c30b 100644
--- a/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
+++ b/Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml
@@ -34,7 +34,7 @@ properties:
 
     properties:
       sound-dai:
-        $ref: /schemas/types.yaml#/definitions/phandle
+        maxItems: 1
     required:
       - sound-dai
 
@@ -48,7 +48,6 @@ properties:
         maxItems: 2
         items:
           maxItems: 1
-        $ref: /schemas/types.yaml#/definitions/phandle-array
     required:
       - sound-dai
 
-- 
2.38.1

