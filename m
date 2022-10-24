Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3920460BEC9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbiJXXmK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:42:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiJXXlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:41:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9D5192DB0;
        Mon, 24 Oct 2022 15:00:27 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 049966602823;
        Mon, 24 Oct 2022 23:00:22 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666648824;
        bh=d75fJH0ARJtURmP3T8+VteKCb9z0HW7yZAWSp5EIerU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xpmnsd13nVFhEaTQPZgbYHf3o7odt8SGo6UH2G5nMif/BG2OP6Q1OwT/DwTGsOeqf
         ktD/4Ii4vd7yIqGQxhnGeWHjMNTDnNwoCQZGX4omRwq3yDjOVAJjqbOBF8UX42OglV
         UWuw43c/mVZ4NBEj9Zze6Of+cwucBjJRJjNFNBUR9FHifvMUAjkMWMEx7N0oTnYcvn
         OWkxToM4q9hyXtQxbIvNUr5zqpwWZH3RBwb14NoZSXtNnapaphsf9+FvHYqKu93+QU
         gehUqDGsjTwKNE9WmMGfSxpXVR6OSC8sF45tJ3URgg3iXwbluNkrJfUDD7bT1F/K3h
         05dI1WgFuONXA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
Date:   Mon, 24 Oct 2022 18:00:12 -0400
Message-Id: <20221024220015.1759428-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221024220015.1759428-1-nfraprado@collabora.com>
References: <20221024220015.1759428-1-nfraprado@collabora.com>
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

The rt5682s codec is a DAI provider with two interfaces - AIF1 and AIF2
- and therefore should have a #sound-dai-cells property that is equal to
1. Add it.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Changed commit message
- Changed value to 1

 Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index ca5b8987b749..1c0b06d82369 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -87,6 +87,9 @@ properties:
     maxItems: 2
     description: Name given for DAI word clock and bit clock outputs.
 
+  "#sound-dai-cells":
+    const: 1
+
 additionalProperties: false
 
 required:
-- 
2.38.1

