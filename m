Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2EF6B8287
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 21:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbjCMUSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 16:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjCMUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 16:18:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DAC87A2E;
        Mon, 13 Mar 2023 13:17:10 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (zone.collabora.co.uk [167.235.23.81])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5A8116603095;
        Mon, 13 Mar 2023 20:17:03 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678738627;
        bh=a0ACMrsAE4Kq1AVU9P7WDGQSsNeM2g+il8kNy0WJLjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y+eBKtdwxY4ew+09WRNe7pex08M81kOrK5Z4izSfBQm9xlUCvQZIH843H4eFkYni4
         V1mxjkCBY1vJDkjvpHoLd4+/HTn0ZYLBdewh95oun40KKf+TMZUFsmoDyk3aRjapjk
         jSPirxiGeK9cxyfbG3DijUbCF+W3bE+y3b2eWoFoiTyN25VChObNkt23aNVza/SQDM
         sr68ezhR8jPGxgYuHXj5hC3YZOdz5wCwGT/pLAMk9U2+Lm55V71Vpv43NTpGlDbPDE
         thztXU+VMbHEFc9xCZtYuW60oQOQwUqWx2dICb/cq6GipAl9acyygdz1v7t0lCqsRp
         /VU76VJUTDRBQ==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?q?Bernhard=20Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/5] dt-bindings: arm64: dts: mediatek: Add rev4 of spherion
Date:   Mon, 13 Mar 2023 16:14:40 -0400
Message-Id: <20230313201443.2275101-3-nfraprado@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230313201443.2275101-1-nfraprado@collabora.com>
References: <20230313201443.2275101-1-nfraprado@collabora.com>
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

Add binding for newer version of Google Spherion (Acer Chromebook 514):
rev4.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---

(no changes since v1)

 Documentation/devicetree/bindings/arm/mediatek.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
index 11458cd16109..fd6587253191 100644
--- a/Documentation/devicetree/bindings/arm/mediatek.yaml
+++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
@@ -144,6 +144,11 @@ properties:
           - const: google,hayato-rev1
           - const: google,hayato
           - const: mediatek,mt8192
+      - description: Google Spherion rev4 (Acer Chromebook 514)
+        items:
+          - const: google,spherion-rev4
+          - const: google,spherion
+          - const: mediatek,mt8192
       - description: Google Spherion (Acer Chromebook 514)
         items:
           - const: google,spherion-rev3
-- 
2.39.2

