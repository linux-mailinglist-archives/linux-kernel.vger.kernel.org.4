Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2E568C1B2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:34:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbjBFPen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjBFPeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:34:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B52342B291;
        Mon,  6 Feb 2023 07:31:42 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 42E686602FA2;
        Mon,  6 Feb 2023 15:30:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697443;
        bh=AXqX968TBKOM3eXq4Eobvq/6nMoQsQ7ZOJPn9J7khw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L9wUUrvx8s/XmtJTwAc0HWq/fyHUYL/uV40Se9R+PXLv0oa1LY1YWI6rLCoAvOVhQ
         Xd/W2kIOE7Fey8+jJwsIbH+AT5v0DVAEuYRxehnSuoaRUpD8FfeU3sTZNnxyiTqWD/
         A2K4V33uQfcs30JNF9Q1nYhQ9RrWAeFRTW5+NSz2RBbt9MPogCoe5AMyQylpH9JoY9
         KkwO8EpThPE3nJXji56ipzBrLU4cteIn9h7oPrAwfSU/ggMrFZM7mQjuMgUmkXT2mI
         ZdUL/R/HMfbIXn2Lx1pwJCbsA9G0jfWgzA9PZuz/kAvxCjSzvRaCK85gxaRAwSuMFj
         G40D4rT5jN2hQ==
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
Subject: [PATCH v1 41/45] clk: mediatek: Allow building most MT6797 clock drivers as modules
Date:   Mon,  6 Feb 2023 16:29:24 +0100
Message-Id: <20230206152928.918562-42-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

Most of the MT6797 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 5444af1570ae..1497171a65ef 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -312,25 +312,25 @@ config COMMON_CLK_MT6797
 	  This driver supports MediaTek MT6797 basic clocks.
 
 config COMMON_CLK_MT6797_MMSYS
-	bool "Clock driver for MediaTek MT6797 mmsys"
+	tristate "Clock driver for MediaTek MT6797 mmsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 mmsys clocks.
 
 config COMMON_CLK_MT6797_IMGSYS
-	bool "Clock driver for MediaTek MT6797 imgsys"
+	tristate "Clock driver for MediaTek MT6797 imgsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 imgsys clocks.
 
 config COMMON_CLK_MT6797_VDECSYS
-	bool "Clock driver for MediaTek MT6797 vdecsys"
+	tristate "Clock driver for MediaTek MT6797 vdecsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 vdecsys clocks.
 
 config COMMON_CLK_MT6797_VENCSYS
-	bool "Clock driver for MediaTek MT6797 vencsys"
+	tristate "Clock driver for MediaTek MT6797 vencsys"
 	depends on COMMON_CLK_MT6797
 	help
 	  This driver supports MediaTek MT6797 vencsys clocks.
-- 
2.39.1

