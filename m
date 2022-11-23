Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D3C635B89
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 12:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236169AbiKWLXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 06:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236782AbiKWLXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 06:23:02 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1FB72128;
        Wed, 23 Nov 2022 03:23:00 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C0EA86602AA1;
        Wed, 23 Nov 2022 11:22:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669202579;
        bh=NwKmpaNcpbD7LP5LEcTP4r+ZafVpwkZH2doF2FPT2FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IEO4VhcCJqOVvSnNfKrgM/79lZKPBHuXXAjSFloFJTCeQRCN7qhCP7cMj//jK8Cxl
         E+CSWnWfFosMFC0zYkWwidESQ51LlagQYHo2jKcCbjEYwuQgLM5X69YdxwofqIOX/x
         VSJ6qrW5/0h1HEdYixVM5EpdjcqE5xCJElopRDNaR6cCHZXyjO24ikD5Jqpdyj96Xa
         GjAjz/1kw8YduVJ3gNhelUhd+a6eVnel8nLOBbbwjPcX15fCVhdLPCAT5F6fHrsuqJ
         YrIfxQWj8zr7H/vSmqy6m9NM56xaRKt5GrzwYd3Ouu7mGH1kXU4wbLBeAZbdwN8NM0
         n9D1ohwg4uf5A==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 2/4] dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
Date:   Wed, 23 Nov 2022 12:22:47 +0100
Message-Id: <20221123112249.98281-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
References: <20221123112249.98281-1-angelogioacchino.delregno@collabora.com>
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

Add compatible to support the SYS_CIRQ controller found on MT8192.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/interrupt-controller/mediatek,mtk-cirq.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
index 4f1132c077ff..fdcb4d8db818 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
@@ -26,6 +26,7 @@ properties:
           - mediatek,mt2701-cirq
           - mediatek,mt8135-cirq
           - mediatek,mt8173-cirq
+          - mediatek,mt8192-cirq
       - const: mediatek,mtk-cirq
 
   reg:
-- 
2.38.1

