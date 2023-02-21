Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E3469DF90
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 12:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjBUL6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 06:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234546AbjBUL5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 06:57:21 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9B628223;
        Tue, 21 Feb 2023 03:56:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D6C4D66021E3;
        Tue, 21 Feb 2023 11:56:33 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676980595;
        bh=xhH2n5XmogkvcmxqMIc1jv/49UOL0BNOcn3TahthPEQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WyAxRrYfivG5Ofwl9YHj2bkOqcFSuVICCa2nj8wHfmpg3F2fe7fxRQ0K09lZE5ot9
         wBkkyYAjRCetcAwFCXb9GbYcQJKSgPN3SU3BwXMT64Oo+UDb9ZmQmgJv6faZ8drn79
         UtDGn09GXzT4NYJ7v5Ar+a2NfBGQkPg6f+aVTsHCuJtWFUxRWYOnGpVl2Aw6GSo6dy
         l+TmtHk+j/coHSMVoJlaWFx15Bg94Hmx3uVcZK26ynA9WF3r2ELOH2cOKhTRRJOXO0
         AcPhkwE3dvLoD0xutf2HC/Hpa8jGsthI7pvYuRbe6rC1O2DnuIKjFEG8ZRBW/v4vT/
         PWWxhTAP7DkbA==
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
        linux-mediatek@lists.infradead.org
Subject: [PATCH v4 30/54] clk: mediatek: mt8516: Allow building clock drivers as modules
Date:   Tue, 21 Feb 2023 12:55:25 +0100
Message-Id: <20230221115549.360132-31-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
References: <20230221115549.360132-1-angelogioacchino.delregno@collabora.com>
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

Now that all MT8516 drivers have been converted to platform driver,
change the configuration options to tristate.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 2d14855dd37e..b9c0a9e21cf1 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -743,7 +743,7 @@ config COMMON_CLK_MT8365_VENC
 	  This driver supports MediaTek MT8365 venc clocks.
 
 config COMMON_CLK_MT8516
-	bool "Clock driver for MediaTek MT8516"
+	tristate "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
@@ -751,7 +751,7 @@ config COMMON_CLK_MT8516
 	  This driver supports MediaTek MT8516 clocks.
 
 config COMMON_CLK_MT8516_AUDSYS
-	bool "Clock driver for MediaTek MT8516 audsys"
+	tristate "Clock driver for MediaTek MT8516 audsys"
 	depends on COMMON_CLK_MT8516
 	help
 	  This driver supports MediaTek MT8516 audsys clocks.
-- 
2.39.1

