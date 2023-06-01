Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB60719A97
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 13:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjFALIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 07:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbjFALIW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 07:08:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BDF211F;
        Thu,  1 Jun 2023 04:08:21 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EB0E06606EC5;
        Thu,  1 Jun 2023 12:08:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685617699;
        bh=ScQ7kKihgBtg3AcCk3l1ETxEXGYmfLUNT184j6M9Ju0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cmAGKNR1IT+lhZThpHLX0MdSf5TkGukrcV/RrUFoWp1RxYuCOmTKKL46NhrI4jots
         9cp5/of+xDG2g3qv+VInqNBm7WSfakKs++Dbp85ma4L2D7HWvzaGrh08vB4l2RLkw8
         fkFL5Zb0wvJFg+qjPd23JaHe5vhVMLad0Rhn7Sdcb8kTo6lFQ1IYXZFH4JVjbgUxto
         1AfxZIOjlS8ke2/XMftDSKeP3nMTxxHQY5IZti5eIzTStrsERScobtpQ3bxu0rjLL1
         VEZvdI1xPOR+uoiOb6Nl4T0lUHTCVDAImz0zxAYLU2Q8l05JZq47v4AnsbpNtcVpXZ
         TIkCUj3SjKziA==
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alexandre Mergnat <amergnat@baylibre.com>
Subject: [PATCH v3 1/8] dt-bindings: leds: leds-mt6323: Document mt6331 compatible
Date:   Thu,  1 Jun 2023 13:08:06 +0200
Message-Id: <20230601110813.2373764-2-angelogioacchino.delregno@collabora.com>
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

Add mediatek,mt6331-led compatible for the LED controller found
in the MT6331 PMIC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>
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
2.40.1

