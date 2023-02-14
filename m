Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E295696539
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231882AbjBNNpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:45:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233029AbjBNNoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:44:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7442823F;
        Tue, 14 Feb 2023 05:43:21 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8EAA966021B6;
        Tue, 14 Feb 2023 13:42:41 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382162;
        bh=7LnucdGUqjfNzMUJ9Y/GzXml6UH8wcuJkaRBmRWmx+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IJPCNR62a1TyRfn5c2f+fqNQtrzSZdz4sqaIMQddCGA6aa3AxGfiNpaK6YZgV7uxt
         XaHodfCd8e9NduIvn8JiFX4mG6h833oktVaL5jk0XuAdC7svkhc/Y4urRO+yRv0nhH
         aus6nnQ9E05f9/O9AYwjy+QIztrAd8JIIvumKzDINTz/utippH4LChLfjEWpBV8B0k
         WsOH3CKPQ2CtgBkstCHU2wGkIext6DOPAIIlfCaSPdRElgBTHZBGXRiZanmt6Cwzh0
         YLcQ6bd3HLLNfkfkAmQvTvyZ26EIBWSqV4ArPtJHfdLzWQkhYA7+LbheC0kvptAhjr
         a+IZpzKUgwlMQ==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 46/47] clk: mediatek: Kconfig: Allow module build for core mt8192 clocks
Date:   Tue, 14 Feb 2023 14:41:26 +0100
Message-Id: <20230214134127.59273-47-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com>
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

Bootloaders must in a way setup the SoC to boot Linux: this means
that it will be possible to decompress a ramdisk and eventually
insert the core clock driver module from there.
Allow module build for all MT8192 clocks by switching to tristate.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 706a7cf86ce0..e8034cbbe169 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -671,7 +671,7 @@ config COMMON_CLK_MT8186_WPESYS
 	  This driver supports MediaTek MT8186 Warp Engine clocks.
 
 config COMMON_CLK_MT8192
-	bool "Clock driver for MediaTek MT8192"
+	tristate "Clock driver for MediaTek MT8192"
 	depends on ARM64 || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARM64
-- 
2.39.1

