Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF192696543
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbjBNNpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:45:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232809AbjBNNpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:45:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758B5298C8;
        Tue, 14 Feb 2023 05:43:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0843666021A3;
        Tue, 14 Feb 2023 13:42:34 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382156;
        bh=1Zw+WwD/n0iAM0hckpkHEz54EWoKuGPv/qSAZAPe7Uc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RiqvSrXD8uUMPlqxkKG7fSeySh0t1QwM5GxLHgeqH1Nv+iBEmko8eBtzhjVIJ9l+Z
         P0NTd3sOWqkyt/McqJ6c+JHqbjTTgvRO9+DndA/l5kt+bX4C+KTrp06Jd5n6PcWblp
         jH9TCrTGk0N9NdjIovagNoZhuYw8a70tRbhtpuxPbKa9n1coHzX8njHJsemusK/Kw/
         IhW7VxuiOv9H7h9D8xs1jo9p8begKqDP+vFXduLqPqScjfu92u08kDng9hfHb0+eTg
         gybhf11dXgovH7UW/Zf8tAKnyPEeXptJalQDMBI1wDLyNSKyv3jcaRDzLpT0q9MT47
         vr2eG0Dmn9lbA==
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
Subject: [PATCH v2 41/47] clk: mediatek: Allow all MT8183 clocks to be built as modules
Date:   Tue, 14 Feb 2023 14:41:21 +0100
Message-Id: <20230214134127.59273-42-angelogioacchino.delregno@collabora.com>
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

All MT8183 clocks are platform drivers now! Allow module build for
all of them.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 54f59f4b2b1a..4a05b210624d 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -511,7 +511,7 @@ config COMMON_CLK_MT8173_VENCSYS
 	  This driver supports MediaTek MT8173 vencsys clocks.
 
 config COMMON_CLK_MT8183
-	bool "Clock driver for MediaTek MT8183"
+	tristate "Clock driver for MediaTek MT8183"
 	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK && ARM64
@@ -519,77 +519,77 @@ config COMMON_CLK_MT8183
 	  This driver supports MediaTek MT8183 basic clocks.
 
 config COMMON_CLK_MT8183_AUDIOSYS
-	bool "Clock driver for MediaTek MT8183 audiosys"
+	tristate "Clock driver for MediaTek MT8183 audiosys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 audiosys clocks.
 
 config COMMON_CLK_MT8183_CAMSYS
-	bool "Clock driver for MediaTek MT8183 camsys"
+	tristate "Clock driver for MediaTek MT8183 camsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 camsys clocks.
 
 config COMMON_CLK_MT8183_IMGSYS
-	bool "Clock driver for MediaTek MT8183 imgsys"
+	tristate "Clock driver for MediaTek MT8183 imgsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 imgsys clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE0
-	bool "Clock driver for MediaTek MT8183 ipu_core0"
+	tristate "Clock driver for MediaTek MT8183 ipu_core0"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core0 clocks.
 
 config COMMON_CLK_MT8183_IPU_CORE1
-	bool "Clock driver for MediaTek MT8183 ipu_core1"
+	tristate "Clock driver for MediaTek MT8183 ipu_core1"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_core1 clocks.
 
 config COMMON_CLK_MT8183_IPU_ADL
-	bool "Clock driver for MediaTek MT8183 ipu_adl"
+	tristate "Clock driver for MediaTek MT8183 ipu_adl"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_adl clocks.
 
 config COMMON_CLK_MT8183_IPU_CONN
-	bool "Clock driver for MediaTek MT8183 ipu_conn"
+	tristate "Clock driver for MediaTek MT8183 ipu_conn"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 ipu_conn clocks.
 
 config COMMON_CLK_MT8183_MFGCFG
-	bool "Clock driver for MediaTek MT8183 mfgcfg"
+	tristate "Clock driver for MediaTek MT8183 mfgcfg"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mfgcfg clocks.
 
 config COMMON_CLK_MT8183_MMSYS
-	bool "Clock driver for MediaTek MT8183 mmsys"
+	tristate "Clock driver for MediaTek MT8183 mmsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 mmsys clocks.
 
 config COMMON_CLK_MT8183_VDECSYS
-	bool "Clock driver for MediaTek MT8183 vdecsys"
+	tristate "Clock driver for MediaTek MT8183 vdecsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
 	  This driver supports MediaTek MT8183 vdecsys clocks.
 
 config COMMON_CLK_MT8183_VENCSYS
-	bool "Clock driver for MediaTek MT8183 vencsys"
+	tristate "Clock driver for MediaTek MT8183 vencsys"
 	depends on COMMON_CLK_MT8183
 	default COMMON_CLK_MT8183
 	help
-- 
2.39.1

