Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C80662F221
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 11:07:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241835AbiKRKHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 05:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240950AbiKRKGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 05:06:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 214DBCE2D;
        Fri, 18 Nov 2022 02:06:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4D8C66602AA7;
        Fri, 18 Nov 2022 10:06:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1668766009;
        bh=HIRKl9LLbNCciqN5hCbiOvtTOlM19cvE0E9kI4/8XXQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CCLOXKSmWgktENVJ9T9gHm9n//U1kSSjxnX81IK0Sx/sinEjJVZK0HHHD/PLpeBSY
         w/2pwcvjtcuIhzm+IhjJEXjYj5mBNN3cOaSHUirxj4nuINv6JT6FgA55nNrekIVUg7
         3JnGNMBAOsGs/8gkz/TjWGwC9/AMQV9hOomsWpDX/BMYYLONptCk1DJWtH4T7ZSOop
         myCKrDkLRIlx/LkIFWDJMu4mzfy1510i55BH5J2tU5DLOOGCG4Xn8qMkOGmySiw4n1
         OCfdMLxWzP6eLtuH2sQ7aput/WPPwXmi85iBo/dhqqG0DMe9PX54cF01u24do0i4mu
         qRU4y/dtX4ufQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     tglx@linutronix.de
Cc:     maz@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v1 2/4] dt-bindings: interrupt-controller: mediatek,cirq: Document MT8192
Date:   Fri, 18 Nov 2022 11:06:37 +0100
Message-Id: <20221118100639.33704-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
References: <20221118100639.33704-1-angelogioacchino.delregno@collabora.com>
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
---
 .../bindings/interrupt-controller/mediatek,mtk-cirq.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml b/Documentation/devicetree/bindings/interrupt-controller/mediatek,mtk-cirq.yaml
index 21e709169907..e0d483d3b1fb 100644
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

