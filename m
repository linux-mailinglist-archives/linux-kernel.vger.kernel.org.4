Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C506F696558
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233051AbjBNNth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:49:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjBNNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:49:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE7229E0E;
        Tue, 14 Feb 2023 05:49:04 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 53EE6660217F;
        Tue, 14 Feb 2023 13:42:36 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676382157;
        bh=Fj6wRRRqEs8IY2MV0RP2l4XtY1i3b2reHY98Krc418s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZjdGz7tIf6aSQBHvt0SuvBCv4104vJXKZjJfmHyHS/qGmAJseb9JnwKIdJeDpvubK
         j1nz7aNBAxzq+81MMpdKenric234GVk8IHXXxAzMyKZKlEGGNGzb9kBKdkr9hlO/B0
         +VGzwSh4EINA8w9/5j7gbqhWwQhVnM1Sq2xGecqt/dC4KoI5uE/KqGQ0gy0S0JVoOw
         txzVINjlJpsg5hVvNhbOoh1EqHz6leYQUb6cVyX2AsAPTM3u9FF1XkiXfDqj0+HMyn
         /ejPOQzPu4KrS4mejA52TWGdNXMydP9lyZbIuLUTerzsYmxdKycZ/GYaEhoPZuJNh/
         tL/FoYaRu1/qA==
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
Subject: [PATCH v2 42/47] clk: mediatek: Allow building most MT6765 clock drivers as modules
Date:   Tue, 14 Feb 2023 14:41:22 +0100
Message-Id: <20230214134127.59273-43-angelogioacchino.delregno@collabora.com>
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

Most of the MT6765 clock drivers can be built as modules: change them
to tristate to allow that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index 4a05b210624d..5444af1570ae 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -133,79 +133,79 @@ config COMMON_CLK_MT6765
          This driver supports MediaTek MT6765 basic clocks.
 
 config COMMON_CLK_MT6765_AUDIOSYS
-       bool "Clock driver for MediaTek MT6765 audiosys"
+       tristate "Clock driver for MediaTek MT6765 audiosys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 audiosys clocks.
 
 config COMMON_CLK_MT6765_CAMSYS
-       bool "Clock driver for MediaTek MT6765 camsys"
+       tristate "Clock driver for MediaTek MT6765 camsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 camsys clocks.
 
 config COMMON_CLK_MT6765_GCESYS
-       bool "Clock driver for MediaTek MT6765 gcesys"
+       tristate "Clock driver for MediaTek MT6765 gcesys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 gcesys clocks.
 
 config COMMON_CLK_MT6765_MMSYS
-       bool "Clock driver for MediaTek MT6765 mmsys"
+       tristate "Clock driver for MediaTek MT6765 mmsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mmsys clocks.
 
 config COMMON_CLK_MT6765_IMGSYS
-       bool "Clock driver for MediaTek MT6765 imgsys"
+       tristate "Clock driver for MediaTek MT6765 imgsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 imgsys clocks.
 
 config COMMON_CLK_MT6765_VCODECSYS
-       bool "Clock driver for MediaTek MT6765 vcodecsys"
+       tristate "Clock driver for MediaTek MT6765 vcodecsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 vcodecsys clocks.
 
 config COMMON_CLK_MT6765_MFGSYS
-       bool "Clock driver for MediaTek MT6765 mfgsys"
+       tristate "Clock driver for MediaTek MT6765 mfgsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mfgsys clocks.
 
 config COMMON_CLK_MT6765_MIPI0ASYS
-       bool "Clock driver for MediaTek MT6765 mipi0asys"
+       tristate "Clock driver for MediaTek MT6765 mipi0asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0asys clocks.
 
 config COMMON_CLK_MT6765_MIPI0BSYS
-       bool "Clock driver for MediaTek MT6765 mipi0bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi0bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi0bsys clocks.
 
 config COMMON_CLK_MT6765_MIPI1ASYS
-       bool "Clock driver for MediaTek MT6765 mipi1asys"
+       tristate "Clock driver for MediaTek MT6765 mipi1asys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi1asys clocks.
 
 config COMMON_CLK_MT6765_MIPI1BSYS
-       bool "Clock driver for MediaTek MT6765 mipi1bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi1bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi1bsys clocks.
 
 config COMMON_CLK_MT6765_MIPI2ASYS
-       bool "Clock driver for MediaTek MT6765 mipi2asys"
+       tristate "Clock driver for MediaTek MT6765 mipi2asys"
        depends on COMMON_CLK_MT6765
       help
          This driver supports MediaTek MT6765 mipi2asys clocks.
 
 config COMMON_CLK_MT6765_MIPI2BSYS
-       bool "Clock driver for MediaTek MT6765 mipi2bsys"
+       tristate "Clock driver for MediaTek MT6765 mipi2bsys"
        depends on COMMON_CLK_MT6765
        help
          This driver supports MediaTek MT6765 mipi2bsys clocks.
-- 
2.39.1

