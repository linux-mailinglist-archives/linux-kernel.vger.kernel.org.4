Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B30105B6EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 16:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiIMOCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 10:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiIMOCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 10:02:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28946205E8;
        Tue, 13 Sep 2022 07:02:08 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 281E96602006;
        Tue, 13 Sep 2022 15:02:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663077726;
        bh=ErT3ESbOa0vk9bZS+9TSr45Pf6iZdWC5H+hlE0INnY0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RJYmSs73FepwOwIMBcXJo14SVTarVl0tD9gnZ1PTlzIo2FTtmK1owHlvYSENheeBF
         opGwe37fjNsT4xRnC3Lg50PKtRmhjbxEmr5u3i1Yc+djPcqstgBvwN89imroO0+9w2
         L92faVBBCMJMKpX5mC8ZNXEzpFYWJb4NiU8+WBaTy98atXRHukmMLya5Ay9bEXNNb+
         HTzKRA3YPzCwFWsffE3cMkU+3AOdT0bVG6PbWIzznpWKWxhHgd8YVgC85RPanwH/hy
         WPApudvvt+iWgH2UCDJrzeGjFq5IUQSvPXUSegNf8Pu40KUuBwg444gEsl+B5aGdKs
         Uo8obMwIWxARg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     robh+dt@kernel.org
Cc:     krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, chunkuang.hu@kernel.org,
        jason-jh.lin@mediatek.com, rex-bc.chen@mediatek.com,
        moudy.ho@mediatek.com, allen-kh.cheng@mediatek.com,
        p.zabel@pengutronix.de, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: soc: mediatek: Add display mutex support for MT6795
Date:   Tue, 13 Sep 2022 16:01:20 +0200
Message-Id: <20220913140121.403637-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
References: <20220913140121.403637-1-angelogioacchino.delregno@collabora.com>
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

Add compatible for MT6795 Helio X10 SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/soc/mediatek/mediatek,mutex.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
index 234fa5dc07c2..9241e5fc7cff 100644
--- a/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
+++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,mutex.yaml
@@ -26,6 +26,7 @@ properties:
     enum:
       - mediatek,mt2701-disp-mutex
       - mediatek,mt2712-disp-mutex
+      - mediatek,mt6795-disp-mutex
       - mediatek,mt8167-disp-mutex
       - mediatek,mt8173-disp-mutex
       - mediatek,mt8183-disp-mutex
-- 
2.37.2

