Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD3A60BEC3
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 01:41:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiJXXlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 19:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiJXXl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 19:41:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A3D29F13D;
        Mon, 24 Oct 2022 15:00:29 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.51])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6002A66026E6;
        Mon, 24 Oct 2022 23:00:25 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666648827;
        bh=zH2yLaAyOCI8HWlnuIsMKt/wbk7W63NEAC2PrYHIQu4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hN3evVtjPXxYFgB91bDh1SQXIwQjNmNjTD5fUwYDtrR4pu3rNv3JwNveKdsTVHyp3
         OCy+7bWb3wX07X4CFPH7gGcCL4rrSECV8UlZ4ko3si3GUMdPmuj6L084wCC5AlpP96
         GHvxYvjMDleeoMN2Ay37cIOH14ngJukjKFHjqS96Ftm70UOjxG3y0aCmfMc0wugHFh
         6GB0dI+/qqekdcQqGfiESiworEzu7X36uWPsLRr1YbS5KihfwA/rWpJt53ZASINSrl
         arQMfpSXATYqIhh/ncTeVb3bPythieLhBbc+tUEE5BzKLOtXgnLcGqoarhPdgiN++S
         LpES3IS0bGotg==
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
Subject: [PATCH v2 2/4] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
Date:   Mon, 24 Oct 2022 18:00:13 -0400
Message-Id: <20221024220015.1759428-3-nfraprado@collabora.com>
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

The rt5682s codec can have two supplies: AVDD and MICVDD. They are
already used by sc7180-trogdor-kingoftown.dtsi, so document them in the
binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

Changes in v2:
- Added mention that property is already used in a DT to the commit
  message

 Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 1c0b06d82369..ac1dea5b4450 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -90,6 +90,10 @@ properties:
   "#sound-dai-cells":
     const: 1
 
+  AVDD-supply: true
+
+  MICVDD-supply: true
+
 additionalProperties: false
 
 required:
-- 
2.38.1

