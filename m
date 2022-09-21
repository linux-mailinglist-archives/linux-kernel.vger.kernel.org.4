Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0367C5BFA85
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 11:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbiIUJP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 05:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiIUJPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 05:15:20 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F69273912;
        Wed, 21 Sep 2022 02:15:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8B38F660202C;
        Wed, 21 Sep 2022 10:15:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663751717;
        bh=eyajYqNVKDTgswRO+Ss8BbVgBHVgMdMs6W0zHuDq5jM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uf3PaS7cLu3o4X7T+sePAkh19iwuLXzj9BD0Y1sOZjjEFx9ERMi3khaZYAKpd3xLL
         6cKkfGRimdAi6nZUn6Uc7K22GG9lLtizBWJxkA1g/f99qYVCMCvlA7GxhplCD1rEHs
         sx/ErNXSJZNF55xwLUqyFMKXFT0b4UzV4ex0fdurwYziUFK9ty62tKSULQAR18amv/
         x+Jsl296xaXjiunev3ClC612bq4btRapbLuVQbIu3qXeaT3Y+WwLEteJE6UmJREN8q
         yv2XqDWaiUFYPvPnnvLcw1+ydYU99CTWiceLcgqH346Pw3VO96P+k/EiNQQx4xczSJ
         YcUTbupf5ZNkQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, p.zabel@pengutronix.de,
        y.oudjana@protonmail.com, angelogioacchino.delregno@collabora.com,
        jason-jh.lin@mediatek.com, ck.hu@mediatek.com,
        fparent@baylibre.com, rex-bc.chen@mediatek.com,
        tinghan.shen@mediatek.com, ikjn@chromium.org,
        miles.chen@mediatek.com, sam.shih@mediatek.com, wenst@chromium.org,
        bgolaszewski@baylibre.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        konrad.dybcio@somainline.org, marijn.suijten@somainline.org,
        martin.botka@somainline.org, ~postmarketos/upstreaming@lists.sr.ht,
        phone-devel@vger.kernel.org, kernel@collabora.com
Subject: [RESEND PATCH v6 5/8] clk: mediatek: clk-apmixed: Remove unneeded __init annotation
Date:   Wed, 21 Sep 2022 11:14:52 +0200
Message-Id: <20220921091455.41327-6-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
References: <20220921091455.41327-1-angelogioacchino.delregno@collabora.com>
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

Remove an unneeded __init annotation from the declaration of function
mtk_clk_register_ref2usb_tx(): this avoids section mismatch warnings
during modpost phase when called from functions that have no such
annotation (useful when clocks are platform drivers).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/clk-apmixed.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-apmixed.c b/drivers/clk/mediatek/clk-apmixed.c
index fc3d4146f482..6b0ab0a346e8 100644
--- a/drivers/clk/mediatek/clk-apmixed.c
+++ b/drivers/clk/mediatek/clk-apmixed.c
@@ -70,7 +70,7 @@ static const struct clk_ops mtk_ref2usb_tx_ops = {
 	.unprepare	= mtk_ref2usb_tx_unprepare,
 };
 
-struct clk_hw * __init mtk_clk_register_ref2usb_tx(const char *name,
+struct clk_hw *mtk_clk_register_ref2usb_tx(const char *name,
 			const char *parent_name, void __iomem *reg)
 {
 	struct mtk_ref2usb_tx *tx;
-- 
2.37.2

