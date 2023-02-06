Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD87868B944
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 11:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjBFKBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 05:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjBFKBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 05:01:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23CA41F487;
        Mon,  6 Feb 2023 02:01:19 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A6ABA6602FA0;
        Mon,  6 Feb 2023 10:01:17 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675677678;
        bh=u7Y8n/T80FWNXiD40Mx6s06d8MGoJpyrDLmIqXuDbtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HbO+scaczhc4zrIb+JeSoZxSJKgzEGwFlMZVTp5fkRD8QgTGlHdx6c75PhiooPdcN
         5NZXcb5/yQawZjTfupEUvKMlflUiYTvC+aV7zXs441xF7s+OSQVGqaPpn+6PYXyRdF
         dei+PIFgU1UkGnU0YAKrVr38VzhnkaVcuyapDP/yMYhxEueH2q5QAPJneE+gXXjj6y
         X03gAD61BZup9byr8GUJJcnz8dLep2xSHjpHOUrv701ff+H3NWECBDroEG4Uw+Ip6X
         5XPLMeHA8wlNZIt9HS64jF/BIgvXQM0Bz2pq0VCTePA4FQUSMtCHpdNnrLETUN/UxY
         l2wn26x2rZJLg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v3 3/7] dt-bindings: clock: mediatek,mt8186-fhctl: Support MT6795, MT8173/92/95
Date:   Mon,  6 Feb 2023 11:01:01 +0100
Message-Id: <20230206100105.861720-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com>
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

MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
compatibles for them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 .../devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml   | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
index cfd042ac1e14..d00327d12e1e 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-fhctl.yaml
@@ -16,7 +16,12 @@ description: |
 
 properties:
   compatible:
-    const: mediatek,mt8186-fhctl
+    enum:
+      - mediatek,mt6795-fhctl
+      - mediatek,mt8173-fhctl
+      - mediatek,mt8186-fhctl
+      - mediatek,mt8192-fhctl
+      - mediatek,mt8195-fhctl
 
   reg:
     maxItems: 1
-- 
2.39.1

