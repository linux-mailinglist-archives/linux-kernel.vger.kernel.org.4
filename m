Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6708B611BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 22:56:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiJ1U4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 16:56:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiJ1Uzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 16:55:53 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C20A1D1009;
        Fri, 28 Oct 2022 13:55:50 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 18D78660293A;
        Fri, 28 Oct 2022 21:55:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666990548;
        bh=/xWER+x0oIFofm2IpHy5fUUgY7g0hKyTCznvNF7+CqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TnrQ1htkoHEWLyVfQvnS1zDqwnVJLfaspdiMRoVtYHz6yeWXdJimx7MDgfuvbG2x9
         On+v13qBR8Bbq7mbl6dYsbLnoCQdhFdD7vmVXGdVfOOnvNdCTpzrIR9an02sCDaOyR
         zrOexNFlp61rZ/ekhsw1QswkvJZvROGorR+j6DHE997IjpOBpsPM+KrCs6KI0h8PT4
         IQBzoVzkTtndgGiY2HE3lzEWtiuAXrR3/27AH1DPOMQ1J8oqFyLSnlGLadRvfVEcMe
         F3VA/UrlLhlXi+lRx1PH35hgPxG69uddO1xdYrLXl3HX7vcaQxLz7HO1WsRGdq16+N
         I2DFlrcDgoziA==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Mark Brown <broonie@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] ASoC: dt-bindings: realtek,rt5682s: Add AVDD and MICVDD supplies
Date:   Fri, 28 Oct 2022 16:55:33 -0400
Message-Id: <20221028205540.3197304-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221028205540.3197304-1-nfraprado@collabora.com>
References: <20221028205540.3197304-1-nfraprado@collabora.com>
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

The rt5682s codec has two supplies - AVDD and MICVDD - which are already
used by sc7180-trogdor-kingoftown.dtsi. Document them in the binding.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---
Commit adapted from [1], changes:
- Made supplies required
- Added description for supplies

[1] https://lore.kernel.org/all/20221024220015.1759428-3-nfraprado@collabora.com

 .../devicetree/bindings/sound/realtek,rt5682s.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index 1c0b06d82369..b7338bfc0f5a 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -90,11 +90,20 @@ properties:
   "#sound-dai-cells":
     const: 1
 
+  AVDD-supply:
+    description: Regulator supplying analog power through the AVDD pin.
+
+  MICVDD-supply:
+    description: Regulator supplying power for the microphone bias through the
+      MICVDD pin.
+
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - AVDD-supply
+  - MICVDD-supply
 
 examples:
   - |
@@ -120,5 +129,8 @@ examples:
 
             clocks = <&osc>;
             clock-names = "mclk";
+
+            AVDD-supply = <&avdd_reg>;
+            MICVDD-supply = <&micvdd_reg>;
         };
     };
-- 
2.38.1

