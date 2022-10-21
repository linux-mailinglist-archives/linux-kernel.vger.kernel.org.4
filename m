Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DD2607EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 21:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbiJUTJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 15:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbiJUTJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 15:09:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71D82958FD;
        Fri, 21 Oct 2022 12:09:16 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BEE05660253A;
        Fri, 21 Oct 2022 20:09:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666379355;
        bh=ywauAsdLjkUJQdp0DsPF37EGmMMhN0y3N+sXyQYS3Qg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iu0jAwwGrKbqJzEzPiKUlOya7r6lOCskEMWFOVGoIzf/0Y7zjRuxwWsHvs8VPDIAR
         1aPXxUaTwKc3rthrwR/k6jEs1J74w5Uet7EHlnItZNBs4SKUgNerZSxQuWDWcRaVyb
         djtz+Toe9r/ZwCyOJsztGqOreeuC+qrb95HBpPLxqmDArPj39ryaBRzB+Jwxht9P1F
         Jjwx1J9n8oCVFShIQRxzCh+j/n825V6z1jryXCbI/aA/eM01c1GRVIxFWSncFpqzFg
         HbLoX3UYi4M8enWCq4jEAlnsx0pixO2hI3eEJp71gftL6KjfB6zprKWRTy2XZAUMrf
         Y3T34Z9UTdS8A==
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
Subject: [PATCH 1/3] ASoC: dt-bindings: realtek,rt5682s: Add #sound-dai-cells
Date:   Fri, 21 Oct 2022 15:09:06 -0400
Message-Id: <20221021190908.1502026-2-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221021190908.1502026-1-nfraprado@collabora.com>
References: <20221021190908.1502026-1-nfraprado@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt5682s codec can be pointed to through a sound-dai property to be
used as part of a machine sound driver. dtc expects #sound-dai-cells to
be defined in the codec's node in those cases, so add it in the
dt-binding and set it to 0.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
index ca5b8987b749..ea53a55015c4 100644
--- a/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
+++ b/Documentation/devicetree/bindings/sound/realtek,rt5682s.yaml
@@ -87,6 +87,9 @@ properties:
     maxItems: 2
     description: Name given for DAI word clock and bit clock outputs.
 
+  "#sound-dai-cells":
+    const: 0
+
 additionalProperties: false
 
 required:
-- 
2.38.1

