Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B038C6DFA36
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjDLPd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230507AbjDLPdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:33:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665F465A1;
        Wed, 12 Apr 2023 08:33:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3D7A966031FE;
        Wed, 12 Apr 2023 16:33:17 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681313597;
        bh=EHR1tsOkZg+sMKl6Vd5ksBS1wb0tpOxwzLny0ukBUrU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiATp0qJbbv8G77QFQUTh91t/g8efaCPwVvgvleE8jMQ+mpBS/VsFu7mdWZVZyaBl
         9tIfsi8DLVRE5uWVzqe9o1sTFn5dPzQCa/LqBEhY/a6bUTucSRWGJNJ46Lf38La8h8
         NZXWJdqDUKry+W7vHA/ne0Mc1ak5KMBYE9qn3bm7wUWXThOwAQTqPIcHcpMeBJOBHQ
         dh+6hEVU0oxYii7szpaqNbj1gdAc4Pbp9ZatL24GytooWQvGZBOQxyxDyRiyI98m7R
         EHbNJxSti+7nfIzsyOavy8ITyelZI7PKUU17/GdtfNSNftBjPsSxVp9fIvCLl+i2jk
         2ZB6RAx6U3U6Q==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     pavel@ucw.cz
Cc:     lee@kernel.org, sean.wang@mediatek.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 1/7] dt-bindings: leds: leds-mt6323: Document mt6331 compatible
Date:   Wed, 12 Apr 2023 17:33:04 +0200
Message-Id: <20230412153310.241046-2-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
References: <20230412153310.241046-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add mediatek,mt6331-led compatible for the LED controller found
in the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/leds/leds-mt6323.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 73353692efa1..7dc63af41562 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -12,7 +12,9 @@ For MediaTek PMIC wrapper bindings see:
 Documentation/devicetree/bindings/soc/mediatek/mediatek,pwrap.yaml
 
 Required properties:
-- compatible : Must be "mediatek,mt6323-led"
+- compatible : Must be one of
+  - "mediatek,mt6323-led"
+  - "mediatek,mt6331-led"
 - address-cells : Must be 1
 - size-cells : Must be 0
 
-- 
2.40.0

