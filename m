Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6415D69D008
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:04:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbjBTPEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:04:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbjBTPDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:03:24 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D477A1F912;
        Mon, 20 Feb 2023 07:02:14 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5E39066021C5;
        Mon, 20 Feb 2023 15:02:08 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905329;
        bh=vmZboqnY88zhAaEwDm8Q0/dnSl1U3JPvdAiFCCN2+8o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UaUTf00yKdUCYO8hhmC1pnqicu+zw35t48TSwAwzGJ7dmKmNE4dem+IfNe1FxYtuG
         BSQL1uukt8AotRWvHuOQwJXEVm7Gc2d7aK+2JyGDwh9c8K/X1X+ecRvZejlHJuooCQ
         RXq+GnWlzUIyKgDqaWm7ziSKcv+AYrY28IgW7H46X+m+xhCbmN6OsH9RDclWlMv9Ht
         Wpkb5NPfbsw9c5k9+nL6NpnIrTMhzEh0jZQ25znAEvU/ZEqDaN2aM5CtoMqIKRLTvI
         xSTZcLunPCl2/CBWJK/nYgT2sOdzLS3dKuUxF2PlyEofB72avYeYTR5kE3WYYHovt9
         DJC8tx6Mfz86g==
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
Subject: [PATCH v3 38/55] clk: mediatek: mt2712: Change Kconfig options to allow module build
Date:   Mon, 20 Feb 2023 16:00:54 +0100
Message-Id: <20230220150111.77897-39-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

All of the mt2712 drivers have been converted to platform drivers!
Change the Kconfig options for all MT2712 clocks to tristate to allow
building all clock drivers as modules.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/Kconfig | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index b9c0a9e21cf1..45b7aea7648d 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -75,7 +75,7 @@ config COMMON_CLK_MT2701_G3DSYS
 	  This driver supports MediaTek MT2701 g3dsys clocks.
 
 config COMMON_CLK_MT2712
-	bool "Clock driver for MediaTek MT2712"
+	tristate "Clock driver for MediaTek MT2712"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM64
@@ -83,43 +83,43 @@ config COMMON_CLK_MT2712
 	  This driver supports MediaTek MT2712 basic clocks.
 
 config COMMON_CLK_MT2712_BDPSYS
-	bool "Clock driver for MediaTek MT2712 bdpsys"
+	tristate "Clock driver for MediaTek MT2712 bdpsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 bdpsys clocks.
 
 config COMMON_CLK_MT2712_IMGSYS
-	bool "Clock driver for MediaTek MT2712 imgsys"
+	tristate "Clock driver for MediaTek MT2712 imgsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 imgsys clocks.
 
 config COMMON_CLK_MT2712_JPGDECSYS
-	bool "Clock driver for MediaTek MT2712 jpgdecsys"
+	tristate "Clock driver for MediaTek MT2712 jpgdecsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 jpgdecsys clocks.
 
 config COMMON_CLK_MT2712_MFGCFG
-	bool "Clock driver for MediaTek MT2712 mfgcfg"
+	tristate "Clock driver for MediaTek MT2712 mfgcfg"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 mfgcfg clocks.
 
 config COMMON_CLK_MT2712_MMSYS
-	bool "Clock driver for MediaTek MT2712 mmsys"
+	tristate "Clock driver for MediaTek MT2712 mmsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 mmsys clocks.
 
 config COMMON_CLK_MT2712_VDECSYS
-	bool "Clock driver for MediaTek MT2712 vdecsys"
+	tristate "Clock driver for MediaTek MT2712 vdecsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 vdecsys clocks.
 
 config COMMON_CLK_MT2712_VENCSYS
-	bool "Clock driver for MediaTek MT2712 vencsys"
+	tristate "Clock driver for MediaTek MT2712 vencsys"
 	depends on COMMON_CLK_MT2712
 	help
 	  This driver supports MediaTek MT2712 vencsys clocks.
-- 
2.39.1

