Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2660B6AC2CF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjCFOQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjCFOPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:15:33 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7739C2DE70;
        Mon,  6 Mar 2023 06:14:17 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA1306602FEF;
        Mon,  6 Mar 2023 14:06:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111607;
        bh=u+85KFrTJW9KMkltvtIWWNJiIYnLSxDNpI6kH+kpZXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O17qZJJKWPYGfCPHKiw+Vyb2Idl3qGb1ms6c8qtjeYr6bv0Z3m8DhWnKshQGoet+k
         5kWTfZX1UKD4A5Zz5PMiMNPGiByzqiOCeL46OFXHp2C/FrU2M0KOcyb8uV6PVkfNtg
         IbtnAgSPkKoOW3hbzLY6GNokuwwHmkfA/SyNj8ZkH8/xSe07jj4WIE4qmthQKa0oCW
         RNAipckYQyRNT8p/twb45eStDrBSTG4HSGshoh3B5qrY+o/HfmXJ2jESm408QmOpSg
         JmAgPT1APK/pdeXlNormc1i3oJAiGV4neCxdH8B0IWi05xV8fH9Z0Wz7Mwpv495EVA
         GuHbkfOZDmMQg==
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
Subject: [PATCH v6 37/54] clk: mediatek: Add MODULE_LICENSE() where missing
Date:   Mon,  6 Mar 2023 15:05:26 +0100
Message-Id: <20230306140543.1813621-38-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
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

In order to successfully build clock drivers as modules it is required
to declare a module license: add it where missing.
While at it, also change the MODULE_LICENSE text from "GPL v2" to
"GPL" (which means the same) on clk-mt7981-eth.c.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Miles Chen <miles.chen@mediatek.com>
Tested-by: Chen-Yu Tsai <wenst@chromium.org> # MT8183, MT8192, MT8195 Chromebooks
---
 drivers/clk/mediatek/clk-mt2701-aud.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-bdp.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-eth.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-g3d.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-hif.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-img.c          | 1 +
 drivers/clk/mediatek/clk-mt2701-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt2701-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt2701.c              | 1 +
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c   | 1 +
 drivers/clk/mediatek/clk-mt2712-bdp.c          | 1 +
 drivers/clk/mediatek/clk-mt2712-img.c          | 1 +
 drivers/clk/mediatek/clk-mt2712-jpgdec.c       | 1 +
 drivers/clk/mediatek/clk-mt2712-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt2712-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt2712-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt2712-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt2712.c              | 1 +
 drivers/clk/mediatek/clk-mt6765-audio.c        | 1 +
 drivers/clk/mediatek/clk-mt6765-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt6765-img.c          | 1 +
 drivers/clk/mediatek/clk-mt6765-mipi0a.c       | 1 +
 drivers/clk/mediatek/clk-mt6765-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt6765-vcodec.c       | 1 +
 drivers/clk/mediatek/clk-mt6765.c              | 1 +
 drivers/clk/mediatek/clk-mt6797-img.c          | 1 +
 drivers/clk/mediatek/clk-mt6797-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt6797-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt6797-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt6797.c              | 1 +
 drivers/clk/mediatek/clk-mt7622-aud.c          | 1 +
 drivers/clk/mediatek/clk-mt7622-eth.c          | 1 +
 drivers/clk/mediatek/clk-mt7622-hif.c          | 1 +
 drivers/clk/mediatek/clk-mt7629-eth.c          | 1 +
 drivers/clk/mediatek/clk-mt7629-hif.c          | 1 +
 drivers/clk/mediatek/clk-mt7629.c              | 1 +
 drivers/clk/mediatek/clk-mt7981-apmixed.c      | 1 +
 drivers/clk/mediatek/clk-mt7981-eth.c          | 2 +-
 drivers/clk/mediatek/clk-mt7981-infracfg.c     | 1 +
 drivers/clk/mediatek/clk-mt7981-topckgen.c     | 1 +
 drivers/clk/mediatek/clk-mt7986-apmixed.c      | 1 +
 drivers/clk/mediatek/clk-mt7986-topckgen.c     | 1 +
 drivers/clk/mediatek/clk-mt8135.c              | 1 +
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c   | 1 +
 drivers/clk/mediatek/clk-mt8167-aud.c          | 1 +
 drivers/clk/mediatek/clk-mt8167-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8167-mfgcfg.c       | 1 +
 drivers/clk/mediatek/clk-mt8167-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt8167-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8167.c              | 1 +
 drivers/clk/mediatek/clk-mt8183-apmixedsys.c   | 1 +
 drivers/clk/mediatek/clk-mt8183-audio.c        | 1 +
 drivers/clk/mediatek/clk-mt8183-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8183-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8183-ipu0.c         | 1 +
 drivers/clk/mediatek/clk-mt8183-ipu1.c         | 1 +
 drivers/clk/mediatek/clk-mt8183-ipu_adl.c      | 1 +
 drivers/clk/mediatek/clk-mt8183-ipu_conn.c     | 1 +
 drivers/clk/mediatek/clk-mt8183-mfgcfg.c       | 1 +
 drivers/clk/mediatek/clk-mt8183-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt8183-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8183-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt8183.c              | 1 +
 drivers/clk/mediatek/clk-mt8186-apmixedsys.c   | 1 +
 drivers/clk/mediatek/clk-mt8186-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8186-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c | 1 +
 drivers/clk/mediatek/clk-mt8186-infra_ao.c     | 1 +
 drivers/clk/mediatek/clk-mt8186-ipe.c          | 1 +
 drivers/clk/mediatek/clk-mt8186-mdp.c          | 1 +
 drivers/clk/mediatek/clk-mt8186-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt8186-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt8186-topckgen.c     | 1 +
 drivers/clk/mediatek/clk-mt8186-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8186-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt8186-wpe.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-aud.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c | 1 +
 drivers/clk/mediatek/clk-mt8192-ipe.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-mdp.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt8192-mm.c           | 1 +
 drivers/clk/mediatek/clk-mt8192-msdc.c         | 1 +
 drivers/clk/mediatek/clk-mt8192-scp_adsp.c     | 1 +
 drivers/clk/mediatek/clk-mt8192-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8192-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt8192.c              | 1 +
 drivers/clk/mediatek/clk-mt8195-apmixedsys.c   | 1 +
 drivers/clk/mediatek/clk-mt8195-apusys_pll.c   | 1 +
 drivers/clk/mediatek/clk-mt8195-cam.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-ccu.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-img.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c | 1 +
 drivers/clk/mediatek/clk-mt8195-infra_ao.c     | 1 +
 drivers/clk/mediatek/clk-mt8195-ipe.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-mfg.c          | 1 +
 drivers/clk/mediatek/clk-mt8195-peri_ao.c      | 1 +
 drivers/clk/mediatek/clk-mt8195-scp_adsp.c     | 1 +
 drivers/clk/mediatek/clk-mt8195-topckgen.c     | 1 +
 drivers/clk/mediatek/clk-mt8195-vdec.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vdo0.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vdo1.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-venc.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vpp0.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-vpp1.c         | 1 +
 drivers/clk/mediatek/clk-mt8195-wpe.c          | 1 +
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c   | 1 +
 109 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index cff6c3b8896f..113ab5b0bf8d 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -164,3 +164,4 @@ static struct platform_driver clk_mt2701_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index dad9a35e9310..e7b43329d305 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -105,3 +105,4 @@ static struct platform_driver clk_mt2701_bdp_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_bdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 2c4781f9141a..d30567ac4ff1 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -59,3 +59,4 @@ static struct platform_driver clk_mt2701_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 2fed9f96d1e5..6f881eabdc67 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -58,3 +58,4 @@ static struct platform_driver clk_mt2701_g3d_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_g3d_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index ac47a20047da..b2ee73c4de4e 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -56,3 +56,4 @@ static struct platform_driver clk_mt2701_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_hif_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-img.c b/drivers/clk/mediatek/clk-mt2701-img.c
index 776f470623ca..35a5fd938a6e 100644
--- a/drivers/clk/mediatek/clk-mt2701-img.c
+++ b/drivers/clk/mediatek/clk-mt2701-img.c
@@ -53,3 +53,4 @@ static struct platform_driver clk_mt2701_img_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index f23208b8dcba..75611d0ab865 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -86,3 +86,4 @@ static struct platform_driver clk_mt2701_mm_drv = {
 	.id_table = clk_mt2701_mm_id_table,
 };
 module_platform_driver(clk_mt2701_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-vdec.c b/drivers/clk/mediatek/clk-mt2701-vdec.c
index 57e7020aaab5..dca4335a52a7 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -58,3 +58,4 @@ static struct platform_driver clk_mt2701_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index e9c27b1364b6..d3097d9f0c7a 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -1032,3 +1032,4 @@ static int __init clk_mt2701_init(void)
 }
 
 arch_initcall(clk_mt2701_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index 2f4061c9a59e..eade747d2812 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -164,3 +164,4 @@ static struct platform_driver clk_mt2712_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_apmixed_drv)
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 5324544039b3..d4979f2fb1d3 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -75,3 +75,4 @@ static struct platform_driver clk_mt2712_bdp_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_bdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-img.c b/drivers/clk/mediatek/clk-mt2712-img.c
index c16453c6b421..cd2d2af6bd56 100644
--- a/drivers/clk/mediatek/clk-mt2712-img.c
+++ b/drivers/clk/mediatek/clk-mt2712-img.c
@@ -53,3 +53,4 @@ static struct platform_driver clk_mt2712_img_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-jpgdec.c b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
index c1363eb5d893..815be759e7c9 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt2712_jpgdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_jpgdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-mfg.c b/drivers/clk/mediatek/clk-mt2712-mfg.c
index d91d788babcf..9f958fadca86 100644
--- a/drivers/clk/mediatek/clk-mt2712-mfg.c
+++ b/drivers/clk/mediatek/clk-mt2712-mfg.c
@@ -48,3 +48,4 @@ static struct platform_driver clk_mt2712_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 6245b79bab90..2649d67f2a56 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -127,3 +127,4 @@ static struct platform_driver clk_mt2712_mm_drv = {
 	.id_table = clk_mt2712_mm_id_table,
 };
 module_platform_driver(clk_mt2712_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-vdec.c b/drivers/clk/mediatek/clk-mt2712-vdec.c
index 1d3e65f60808..1cb150fa7ab4 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -61,3 +61,4 @@ static struct platform_driver clk_mt2712_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 09f2683f0f13..4073fa6c040f 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt2712_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index d0e6a4fbfa99..b2cf91622ebf 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1001,3 +1001,4 @@ static struct platform_driver clk_mt2712_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 712e0da78b4b..c1fecf22f8ad 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -75,3 +75,4 @@ static struct platform_driver clk_mt6765_audio_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_audio_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index 0581a1f3971e..15737c8f6b69 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -56,3 +56,4 @@ static struct platform_driver clk_mt6765_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-img.c b/drivers/clk/mediatek/clk-mt6765-img.c
index 7c605dc155eb..7e421f4d01b8 100644
--- a/drivers/clk/mediatek/clk-mt6765-img.c
+++ b/drivers/clk/mediatek/clk-mt6765-img.c
@@ -52,3 +52,4 @@ static struct platform_driver clk_mt6765_img_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-mipi0a.c b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
index b299db047138..17186a308e94 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt6765_mipi0a_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_mipi0a_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-mm.c b/drivers/clk/mediatek/clk-mt6765-mm.c
index ec2b287cf1a3..af2213db17cb 100644
--- a/drivers/clk/mediatek/clk-mt6765-mm.c
+++ b/drivers/clk/mediatek/clk-mt6765-mm.c
@@ -78,3 +78,4 @@ static struct platform_driver clk_mt6765_mm_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-vcodec.c b/drivers/clk/mediatek/clk-mt6765-vcodec.c
index 17355923325e..48014cc71d9f 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -51,3 +51,4 @@ static struct platform_driver clk_mt6765_vcodec_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_vcodec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 0c20ce678350..61f93b6fdf8b 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -873,3 +873,4 @@ static int __init clk_mt6765_init(void)
 }
 
 arch_initcall(clk_mt6765_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-img.c b/drivers/clk/mediatek/clk-mt6797-img.c
index d46a3a3ac3ad..22779829370f 100644
--- a/drivers/clk/mediatek/clk-mt6797-img.c
+++ b/drivers/clk/mediatek/clk-mt6797-img.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt6797_img_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index 899a0e6fa988..8722fae10de9 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -99,3 +99,4 @@ static struct platform_driver clk_mt6797_mm_drv = {
 	.id_table = clk_mt6797_mm_id_table,
 };
 module_platform_driver(clk_mt6797_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-vdec.c b/drivers/clk/mediatek/clk-mt6797-vdec.c
index f2b979b1ea19..c5a82d4a958b 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -60,3 +60,4 @@ static struct platform_driver clk_mt6797_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index 9fbf4cd5160e..afdd288d313a 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -51,3 +51,4 @@ static struct platform_driver clk_mt6797_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 17b23ee4faee..4094fd75d16e 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -703,3 +703,4 @@ static int __init clk_mt6797_init(void)
 }
 
 arch_initcall(clk_mt6797_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 7cca52693a3f..4e14a4ff465a 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -155,3 +155,4 @@ static struct platform_driver clk_mt7622_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 89e68c836d40..4475d0846176 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -87,3 +87,4 @@ static struct platform_driver clk_mt7622_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 06ade985dfe2..19f394af1132 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -99,3 +99,4 @@ static struct platform_driver clk_mt7622_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_hif_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 719a47fef798..ee84a3de7f2c 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -154,3 +154,4 @@ static struct platform_driver clk_mt7629_eth_drv = {
 };
 
 builtin_platform_driver(clk_mt7629_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 79bcd91386fc..464c4131d98a 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -94,3 +94,4 @@ static struct platform_driver clk_mt7629_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7629_hif_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index 09c85fda43d8..f3279f002e93 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -693,3 +693,4 @@ static int clk_mt7629_init(void)
 }
 
 arch_initcall(clk_mt7629_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-apmixed.c b/drivers/clk/mediatek/clk-mt7981-apmixed.c
index 52b7123232bf..53c974c66f89 100644
--- a/drivers/clk/mediatek/clk-mt7981-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7981-apmixed.c
@@ -100,3 +100,4 @@ static struct platform_driver clk_mt7981_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7981_apmixed_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-eth.c b/drivers/clk/mediatek/clk-mt7981-eth.c
index 773350911be2..f27fadd6bf94 100644
--- a/drivers/clk/mediatek/clk-mt7981-eth.c
+++ b/drivers/clk/mediatek/clk-mt7981-eth.c
@@ -115,4 +115,4 @@ static struct platform_driver clk_mt7981_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_eth_drv);
-MODULE_LICENSE("GPL v2");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-infracfg.c b/drivers/clk/mediatek/clk-mt7981-infracfg.c
index 35cd126408b6..d1709323d34e 100644
--- a/drivers/clk/mediatek/clk-mt7981-infracfg.c
+++ b/drivers/clk/mediatek/clk-mt7981-infracfg.c
@@ -205,3 +205,4 @@ static struct platform_driver clk_mt7981_infracfg_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_infracfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index f4c31cb1c74e..e09ffc22b13a 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -420,3 +420,4 @@ static struct platform_driver clk_mt7981_topckgen_drv = {
 	},
 };
 module_platform_driver(clk_mt7981_topckgen_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7986-apmixed.c b/drivers/clk/mediatek/clk-mt7986-apmixed.c
index 227ca572056e..dc949ed1b587 100644
--- a/drivers/clk/mediatek/clk-mt7986-apmixed.c
+++ b/drivers/clk/mediatek/clk-mt7986-apmixed.c
@@ -98,3 +98,4 @@ static struct platform_driver clk_mt7986_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7986_apmixed_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index dacaf5492286..af9df453d6d7 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -314,3 +314,4 @@ static struct platform_driver clk_mt7986_topckgen_drv = {
 	},
 };
 module_platform_driver(clk_mt7986_topckgen_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 97a115d2c3da..98165b1f7c97 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -638,3 +638,4 @@ static void __init mtk_apmixedsys_init(struct device_node *node)
 }
 CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8135-apmixedsys",
 		mtk_apmixedsys_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
index 27597fdeb6e9..5d8b5093ed02 100644
--- a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -141,3 +141,4 @@ static struct platform_driver clk_mt8167_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8167_apmixed_drv)
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-aud.c b/drivers/clk/mediatek/clk-mt8167-aud.c
index 8869c53da79c..63736642f383 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -62,3 +62,4 @@ static struct platform_driver clk_mt8167_audsys_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_audsys_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-img.c b/drivers/clk/mediatek/clk-mt8167-img.c
index 6a068f2a9dce..c2537e149aa8 100644
--- a/drivers/clk/mediatek/clk-mt8167-img.c
+++ b/drivers/clk/mediatek/clk-mt8167-img.c
@@ -54,3 +54,4 @@ static struct platform_driver clk_mt8167_imgsys_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_imgsys_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
index 7fcb944134b6..340c608e7ddb 100644
--- a/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8167-mfgcfg.c
@@ -52,3 +52,4 @@ static struct platform_driver clk_mt8167_mfgcfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_mfgcfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index de6c2283b695..0344f9c98d36 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -93,3 +93,4 @@ static struct platform_driver clk_mt8167_mm_drv = {
 	.id_table = clk_mt8167_mm_id_table,
 };
 module_platform_driver(clk_mt8167_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167-vdec.c b/drivers/clk/mediatek/clk-mt8167-vdec.c
index b3eccc2eca58..35b0380f22dc 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -61,3 +61,4 @@ static struct platform_driver clk_mt8167_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 507e1ebe3ba8..d9a837686865 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -893,3 +893,4 @@ static struct platform_driver clk_mt8167_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
index e66e90163bb4..5addda17211f 100644
--- a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -191,3 +191,4 @@ static struct platform_driver clk_mt8183_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8183_apmixed_drv)
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index 24cc2178c769..fe510f02dadb 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -107,3 +107,4 @@ static struct platform_driver clk_mt8183_audio_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_audio_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-cam.c b/drivers/clk/mediatek/clk-mt8183-cam.c
index 7ff183da0075..7ecbfc50e8fe 100644
--- a/drivers/clk/mediatek/clk-mt8183-cam.c
+++ b/drivers/clk/mediatek/clk-mt8183-cam.c
@@ -57,3 +57,4 @@ static struct platform_driver clk_mt8183_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-img.c b/drivers/clk/mediatek/clk-mt8183-img.c
index e4a9d3201e33..e75d6e6205f9 100644
--- a/drivers/clk/mediatek/clk-mt8183-img.c
+++ b/drivers/clk/mediatek/clk-mt8183-img.c
@@ -57,3 +57,4 @@ static struct platform_driver clk_mt8183_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu0.c b/drivers/clk/mediatek/clk-mt8183-ipu0.c
index 68d4cda89d6f..d1dd76e7eafd 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu0.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu0.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt8183_ipu_core0_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_core0_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu1.c b/drivers/clk/mediatek/clk-mt8183-ipu1.c
index 50950bed9226..0b4906cca119 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu1.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu1.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt8183_ipu_core1_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_core1_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
index 2044d5c664b8..32a82ec965ef 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_adl.c
@@ -48,3 +48,4 @@ static struct platform_driver clk_mt8183_ipu_adl_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_adl_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
index 6e7833656c9a..1e2ebc0eab8b 100644
--- a/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
+++ b/drivers/clk/mediatek/clk-mt8183-ipu_conn.c
@@ -117,3 +117,4 @@ static struct platform_driver clk_mt8183_ipu_conn_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_ipu_conn_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
index 5a71ef094e03..20cdbd74817f 100644
--- a/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
+++ b/drivers/clk/mediatek/clk-mt8183-mfgcfg.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt8183_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 25a04f311dc3..a76e44ebf322 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -101,3 +101,4 @@ static struct platform_driver clk_mt8183_mm_drv = {
 	.id_table = clk_mt8183_mm_id_table,
 };
 module_platform_driver(clk_mt8183_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-vdec.c b/drivers/clk/mediatek/clk-mt8183-vdec.c
index 4c56d02a9d34..0182745e2a18 100644
--- a/drivers/clk/mediatek/clk-mt8183-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8183-vdec.c
@@ -61,3 +61,4 @@ static struct platform_driver clk_mt8183_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-venc.c b/drivers/clk/mediatek/clk-mt8183-venc.c
index 5b86d7d42613..c840e6ebe375 100644
--- a/drivers/clk/mediatek/clk-mt8183-venc.c
+++ b/drivers/clk/mediatek/clk-mt8183-venc.c
@@ -53,3 +53,4 @@ static struct platform_driver clk_mt8183_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 02176ee97cd2..5ae0f1f9ca0a 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -878,3 +878,4 @@ static struct platform_driver clk_mt8183_drv = {
 	},
 };
 module_platform_driver(clk_mt8183_drv)
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
index ab500b985900..e429d2cdc84a 100644
--- a/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8186-apmixedsys.c
@@ -193,3 +193,4 @@ static struct platform_driver clk_mt8186_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_apmixed_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
index 220c8af7848e..90d91d045909 100644
--- a/drivers/clk/mediatek/clk-mt8186-cam.c
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -88,3 +88,4 @@ static struct platform_driver clk_mt8186_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-img.c b/drivers/clk/mediatek/clk-mt8186-img.c
index bac0e52bd51c..11314dba4e41 100644
--- a/drivers/clk/mediatek/clk-mt8186-img.c
+++ b/drivers/clk/mediatek/clk-mt8186-img.c
@@ -66,3 +66,4 @@ static struct platform_driver clk_mt8186_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
index 9301dc3e86fb..f8d1ee294f09 100644
--- a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -65,3 +65,4 @@ static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_imp_iic_wrap_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-infra_ao.c b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
index e705d57032a6..766c8e6bcf8d 100644
--- a/drivers/clk/mediatek/clk-mt8186-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8186-infra_ao.c
@@ -237,3 +237,4 @@ static struct platform_driver clk_mt8186_infra_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_infra_ao_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
index 36f6338f8237..0876440839df 100644
--- a/drivers/clk/mediatek/clk-mt8186-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -53,3 +53,4 @@ static struct platform_driver clk_mt8186_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_ipe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
index faf5cdc7523f..194f20f16f8c 100644
--- a/drivers/clk/mediatek/clk-mt8186-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -78,3 +78,4 @@ static struct platform_driver clk_mt8186_mdp_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_mdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mfg.c b/drivers/clk/mediatek/clk-mt8186-mfg.c
index 468fa7e37074..f16d3c44ef41 100644
--- a/drivers/clk/mediatek/clk-mt8186-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8186-mfg.c
@@ -47,3 +47,4 @@ static struct platform_driver clk_mt8186_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 03dfb4d99930..9e9853a2ea91 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -76,3 +76,4 @@ static struct platform_driver clk_mt8186_mm_drv = {
 	.id_table = clk_mt8186_mm_id_table,
 };
 module_platform_driver(clk_mt8186_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 7f2a59347166..a48172d9c5ab 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -731,3 +731,4 @@ static struct platform_driver clk_mt8186_topck_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_topck_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
index 76e226be8f72..877ca9d8ff65 100644
--- a/drivers/clk/mediatek/clk-mt8186-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -86,3 +86,4 @@ static struct platform_driver clk_mt8186_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
index 96c15b859e37..a89e82285d4c 100644
--- a/drivers/clk/mediatek/clk-mt8186-venc.c
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt8186_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
index dbd8a81b170d..fba55f08129c 100644
--- a/drivers/clk/mediatek/clk-mt8186-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt8186_wpe_drv = {
 	},
 };
 module_platform_driver(clk_mt8186_wpe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index deb292cc9da1..9b14d8514b4f 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -117,3 +117,4 @@ static struct platform_driver clk_mt8192_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-cam.c b/drivers/clk/mediatek/clk-mt8192-cam.c
index 00dbd0d27fbc..321693aff33f 100644
--- a/drivers/clk/mediatek/clk-mt8192-cam.c
+++ b/drivers/clk/mediatek/clk-mt8192-cam.c
@@ -105,3 +105,4 @@ static struct platform_driver clk_mt8192_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-img.c b/drivers/clk/mediatek/clk-mt8192-img.c
index 00abbec6c666..b2c148ead7f8 100644
--- a/drivers/clk/mediatek/clk-mt8192-img.c
+++ b/drivers/clk/mediatek/clk-mt8192-img.c
@@ -68,3 +68,4 @@ static struct platform_driver clk_mt8192_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
index 6663b70a5d47..fd731eb6d62e 100644
--- a/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8192-imp_iic_wrap.c
@@ -117,3 +117,4 @@ static struct platform_driver clk_mt8192_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_imp_iic_wrap_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-ipe.c b/drivers/clk/mediatek/clk-mt8192-ipe.c
index 6a8d3fb7e0c5..3fd37977ea16 100644
--- a/drivers/clk/mediatek/clk-mt8192-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8192-ipe.c
@@ -55,3 +55,4 @@ static struct platform_driver clk_mt8192_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_ipe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mdp.c b/drivers/clk/mediatek/clk-mt8192-mdp.c
index 782f83fbe97b..817e8bf4543b 100644
--- a/drivers/clk/mediatek/clk-mt8192-mdp.c
+++ b/drivers/clk/mediatek/clk-mt8192-mdp.c
@@ -80,3 +80,4 @@ static struct platform_driver clk_mt8192_mdp_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_mdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mfg.c b/drivers/clk/mediatek/clk-mt8192-mfg.c
index c007e561f008..7f77e2d8b765 100644
--- a/drivers/clk/mediatek/clk-mt8192-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8192-mfg.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt8192_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index 184d7fb82abc..3e81018a038b 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -99,3 +99,4 @@ static struct platform_driver clk_mt8192_mm_drv = {
 	.id_table = clk_mt8192_mm_id_table,
 };
 module_platform_driver(clk_mt8192_mm_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-msdc.c b/drivers/clk/mediatek/clk-mt8192-msdc.c
index cb21a40dfe83..cde8c88673e4 100644
--- a/drivers/clk/mediatek/clk-mt8192-msdc.c
+++ b/drivers/clk/mediatek/clk-mt8192-msdc.c
@@ -62,3 +62,4 @@ static struct platform_driver clk_mt8192_msdc_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_msdc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
index b7aa68e6c555..df086b95d447 100644
--- a/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8192-scp_adsp.c
@@ -48,3 +48,4 @@ static struct platform_driver clk_mt8192_scp_adsp_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_scp_adsp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-vdec.c b/drivers/clk/mediatek/clk-mt8192-vdec.c
index 9ddc6e99c8d7..2ea8b6d4d405 100644
--- a/drivers/clk/mediatek/clk-mt8192-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8192-vdec.c
@@ -92,3 +92,4 @@ static struct platform_driver clk_mt8192_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192-venc.c b/drivers/clk/mediatek/clk-mt8192-venc.c
index 67136a341d77..d73c12bc2ae9 100644
--- a/drivers/clk/mediatek/clk-mt8192-venc.c
+++ b/drivers/clk/mediatek/clk-mt8192-venc.c
@@ -51,3 +51,4 @@ static struct platform_driver clk_mt8192_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8192_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 0f9f10172148..35afe496b1c1 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1242,3 +1242,4 @@ static int __init clk_mt8192_init(void)
 }
 
 arch_initcall(clk_mt8192_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
index 29124ed9398b..75cc4d7a39f9 100644
--- a/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8195-apmixedsys.c
@@ -231,3 +231,4 @@ static struct platform_driver clk_mt8195_apmixed_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_apmixed_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
index ca60d90e5257..b167b8d31bcc 100644
--- a/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
+++ b/drivers/clk/mediatek/clk-mt8195-apusys_pll.c
@@ -111,3 +111,4 @@ static struct platform_driver clk_mt8195_apusys_pll_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_apusys_pll_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-cam.c b/drivers/clk/mediatek/clk-mt8195-cam.c
index c0fd32270a8e..c515650214bd 100644
--- a/drivers/clk/mediatek/clk-mt8195-cam.c
+++ b/drivers/clk/mediatek/clk-mt8195-cam.c
@@ -141,3 +141,4 @@ static struct platform_driver clk_mt8195_cam_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_cam_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-ccu.c b/drivers/clk/mediatek/clk-mt8195-ccu.c
index 9e8220bcdf9f..a86f848a785d 100644
--- a/drivers/clk/mediatek/clk-mt8195-ccu.c
+++ b/drivers/clk/mediatek/clk-mt8195-ccu.c
@@ -49,3 +49,4 @@ static struct platform_driver clk_mt8195_ccu_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_ccu_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-img.c b/drivers/clk/mediatek/clk-mt8195-img.c
index 822efce6f79b..214baa2bc974 100644
--- a/drivers/clk/mediatek/clk-mt8195-img.c
+++ b/drivers/clk/mediatek/clk-mt8195-img.c
@@ -95,3 +95,4 @@ static struct platform_driver clk_mt8195_img_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_img_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
index 01f8fab27c22..191f482186ae 100644
--- a/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
+++ b/drivers/clk/mediatek/clk-mt8195-imp_iic_wrap.c
@@ -65,3 +65,4 @@ static struct platform_driver clk_mt8195_imp_iic_wrap_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_imp_iic_wrap_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-infra_ao.c b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
index 75084251ea74..6ad72a320d5e 100644
--- a/drivers/clk/mediatek/clk-mt8195-infra_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-infra_ao.c
@@ -239,3 +239,4 @@ static struct platform_driver clk_mt8195_infra_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_infra_ao_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-ipe.c b/drivers/clk/mediatek/clk-mt8195-ipe.c
index b713fea470dd..b547a99b4ad9 100644
--- a/drivers/clk/mediatek/clk-mt8195-ipe.c
+++ b/drivers/clk/mediatek/clk-mt8195-ipe.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt8195_ipe_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_ipe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-mfg.c b/drivers/clk/mediatek/clk-mt8195-mfg.c
index fcd2d0b7e3c9..75cf643ab885 100644
--- a/drivers/clk/mediatek/clk-mt8195-mfg.c
+++ b/drivers/clk/mediatek/clk-mt8195-mfg.c
@@ -48,3 +48,4 @@ static struct platform_driver clk_mt8195_mfg_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_mfg_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-peri_ao.c b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
index f66fbea2e080..7d65a478182d 100644
--- a/drivers/clk/mediatek/clk-mt8195-peri_ao.c
+++ b/drivers/clk/mediatek/clk-mt8195-peri_ao.c
@@ -61,3 +61,4 @@ static struct platform_driver clk_mt8195_peri_ao_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_peri_ao_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
index 1987172c98a4..24e09339ed7d 100644
--- a/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
+++ b/drivers/clk/mediatek/clk-mt8195-scp_adsp.c
@@ -46,3 +46,4 @@ static struct platform_driver clk_mt8195_scp_adsp_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_scp_adsp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index a9bb7e4687ec..adc6bb7ce750 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -1341,3 +1341,4 @@ static struct platform_driver clk_mt8195_topck_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_topck_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdec.c b/drivers/clk/mediatek/clk-mt8195-vdec.c
index a75ea99a9a4c..f9e2bd402627 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdec.c
@@ -103,3 +103,4 @@ static struct platform_driver clk_mt8195_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 1ed152b072bd..509780750e43 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -113,3 +113,4 @@ static struct platform_driver clk_mt8195_vdo0_drv = {
 	.id_table = clk_mt8195_vdo0_id_table,
 };
 module_platform_driver(clk_mt8195_vdo0_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index cbd0a34884c7..0a5214a1ed25 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -140,3 +140,4 @@ static struct platform_driver clk_mt8195_vdo1_drv = {
 	.id_table = clk_mt8195_vdo1_id_table,
 };
 module_platform_driver(clk_mt8195_vdo1_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-venc.c b/drivers/clk/mediatek/clk-mt8195-venc.c
index 8b46cbe9ce83..d050d87bb3f2 100644
--- a/drivers/clk/mediatek/clk-mt8195-venc.c
+++ b/drivers/clk/mediatek/clk-mt8195-venc.c
@@ -68,3 +68,4 @@ static struct platform_driver clk_mt8195_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
index ca1288b76990..84805a114387 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -105,3 +105,4 @@ static struct platform_driver clk_mt8195_vpp0_drv = {
 	.id_table = clk_mt8195_vpp0_id_table,
 };
 module_platform_driver(clk_mt8195_vpp0_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index d9a260b6ee30..3e91dfed2996 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -103,3 +103,4 @@ static struct platform_driver clk_mt8195_vpp1_drv = {
 	.id_table = clk_mt8195_vpp1_id_table,
 };
 module_platform_driver(clk_mt8195_vpp1_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-wpe.c b/drivers/clk/mediatek/clk-mt8195-wpe.c
index 8878b5ef9e44..52cebe297abf 100644
--- a/drivers/clk/mediatek/clk-mt8195-wpe.c
+++ b/drivers/clk/mediatek/clk-mt8195-wpe.c
@@ -142,3 +142,4 @@ static struct platform_driver clk_mt8195_wpe_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_wpe_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
index 6f0fdf92bbd2..55faa4e37116 100644
--- a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
@@ -162,3 +162,4 @@ static struct platform_driver clk_mt8365_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt8365_apmixed_drv)
+MODULE_LICENSE("GPL");
-- 
2.39.2

