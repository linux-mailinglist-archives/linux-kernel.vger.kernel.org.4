Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6725B866B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 12:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiINKau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 06:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiINKak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 06:30:40 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE7AD7C31E;
        Wed, 14 Sep 2022 03:30:37 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C48F2660201C;
        Wed, 14 Sep 2022 11:30:35 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663151436;
        bh=eNWg78i6IYPaEzcnokszyEzeRsi6y2fLOfB+IH74hdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et5hkc4hpifH1Xcx0RfbmnH5fLsfSQ3jNiwdNjijH+OX3uYQpKl0MN50RpTehBatH
         TemrjY/qNZSMl5tR4Wy7hI1CHJGXG141Ijpwk/eSlwWLdWX7nv91/HNI7ZzJ2i8i2U
         zSOpcVuWIAcuKmA4cTcOi8CqLzoURRSBxnqU1nDVFNvQ4QWfi2bXkFr+FY2X1HELF+
         cbYU1qk0GEbfX7I/lyNyfdH7RdecuRr87ItxfLGqrWx9EwOMriraJ9/HtGHHkVQas8
         4VhJUb9O5vY3IwGA8m5LJ3ZY42n4Sfn1Pd7iFXA9mr8Bkja/Sq4FAxbpwothXGV22y
         TZySjhfZkTJZg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.torokhov@gmail.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, chen.zhong@mediatek.com,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v2 2/2] dt-bindings: input: mediatek,pmic-keys: Add compatible for MT6331 keys
Date:   Wed, 14 Sep 2022 12:30:21 +0200
Message-Id: <20220914103021.43593-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
References: <20220914103021.43593-1-angelogioacchino.delregno@collabora.com>
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

Add a compatible for the keys found on MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
index 9d8a0c3aebca..2f72ec418415 100644
--- a/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
+++ b/Documentation/devicetree/bindings/input/mediatek,pmic-keys.yaml
@@ -25,6 +25,7 @@ properties:
   compatible:
     enum:
       - mediatek,mt6323-keys
+      - mediatek,mt6331-keys
       - mediatek,mt6358-keys
       - mediatek,mt6397-keys
 
-- 
2.37.2

