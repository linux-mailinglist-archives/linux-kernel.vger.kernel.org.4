Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A5E9719A9E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232894AbjFALIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232331AbjFALIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:24 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CD8107;
        Thu,  1 Jun 2023 04:08:22 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EE2946606EC7;
        Thu,  1 Jun 2023 12:08:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617701;
        bh=7QDKHi+A/gqA9xknsWF5jEq2ws7Pw6cLm96d6FgjS6M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xx+cHzrVM/7QBN8zx2IGQc44p3xQUNdFoCjaNWsOuAxvqd6YW6PADm/kQBCn00y6E
         Kqt13x3/yukpW5PRkDNzlM2Q4Ciw1ksxMRw6b6LRiWzBg0/MioNAi2MDKyVjpHIPu5
         uWnSS5QzqH/vV51900qxbSe8yEMSPA8z33g44GaPwX3N1afhNG2eFiFxzAHshe/wX4
         ENHO8u0j060kKWaAOKB/QUFXmT2t4AyIY8wXTm5OgE6XzS/IaUjr7QU10jQUUZYkh3
         2iH88ZuNPIWJY6PpuNJJxoe9ocyyKAYi9MaMNwGXTkaYHLelqGRMV/KfVSZM6u9Oeq
         Sfk6VcdTDDhNg==
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
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH v3 3/8] dt-bindings: leds: leds-mt6323: Support WLED output
Date:   Thu,  1 Jun 2023 13:08:08 +0200
Message-Id: <20230601110813.2373764-4-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
References: <20230601110813.2373764-1-angelogioacchino.delregno@collabora.com>
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

Some PMICs have a separated WLED string output: add a property
`mediatek,is-wled` to indicate which LED string is a WLED.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 Documentation/devicetree/bindings/leds/leds-mt6323.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/leds/leds-mt6323.txt b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
index 052dccb8f2ce..904b2222a5fe 100644
--- a/Documentation/devicetree/bindings/leds/leds-mt6323.txt
+++ b/Documentation/devicetree/bindings/leds/leds-mt6323.txt
@@ -30,6 +30,7 @@ Optional properties for the LED child node:
 - label : See Documentation/devicetree/bindings/leds/common.txt
 - linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
 - default-state: See Documentation/devicetree/bindings/leds/common.txt
+- mediatek,is-wled: LED string is connected to WLED output
 
 Example:
 
-- 
2.40.1

