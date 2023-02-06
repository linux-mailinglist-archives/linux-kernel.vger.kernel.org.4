Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA5F668C1A2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjBFPdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:33:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjBFPcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:32:22 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBB82A995;
        Mon,  6 Feb 2023 07:30:52 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 823F86602FA0;
        Mon,  6 Feb 2023 15:30:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697433;
        bh=Kd96p7pKpHKeeyr1JOuOBk1NN1kDh5Z/wH/kDel9O2k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hMfYY17g2I9yQVMV391+ZzZgZu6L2aptA/mQa0d9UUi/fdG09f0o91CIceDMr+5O/
         wiOOtI7BHJzhLTRwT6MdZGNLggv0UXuJ8tw0DIxLMRubXwpY6folVABK1Fmh0NTwCi
         6cA+8hE22lZecR52n/XCRLmiom/8HYsfSwAx2b7GSM8XSErSp90YzOQKNQbQ9bNlfq
         TIlqQbg8sqBjyIMZWUmeuVpMrNDElWKyobfi+BrziA8IwECTY3ZhamAPlumc5+gRR7
         md/+hopMTUADpZaKvNUOeuaDLCWWzcrexK/Nor3+cP3ayQRDqGJbMQofsLaB1OSjA1
         AcqMAHoBNIY3g==
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
Subject: [PATCH v1 34/45] clk: mediatek: Add MODULE_LICENSE() where missing
Date:   Mon,  6 Feb 2023 16:29:17 +0100
Message-Id: <20230206152928.918562-35-angelogioacchino.delregno@collabora.com>
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

In order to successfully build clock drivers as modules it is required
to declare a module license: add it where missing.
While at it, also change the MODULE_LICENSE text from "GPL v2" to
"GPL" (which means the same) on clk-mt7981-eth.c.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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
index 8ec2397f4ccb..cbadc170637b 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -168,3 +168,4 @@ static struct platform_driver clk_mt2701_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-bdp.c b/drivers/clk/mediatek/clk-mt2701-bdp.c
index 16a28103a479..57088763c7db 100644
--- a/drivers/clk/mediatek/clk-mt2701-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2701-bdp.c
@@ -107,3 +107,4 @@ static struct platform_driver clk_mt2701_bdp_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_bdp_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index b4715f6911ee..301a45b36838 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -60,3 +60,4 @@ static struct platform_driver clk_mt2701_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index abd6e07eb37b..3d56d0bfb7a0 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -59,3 +59,4 @@ static struct platform_driver clk_mt2701_g3d_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_g3d_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index b7b96d221c96..1a7a8e132e5a 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -57,3 +57,4 @@ static struct platform_driver clk_mt2701_hif_drv = {
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
index aaed76513b54..f6ed4a5b6bf8 100644
--- a/drivers/clk/mediatek/clk-mt2701-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2701-vdec.c
@@ -60,3 +60,4 @@ static struct platform_driver clk_mt2701_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2701_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2701.c b/drivers/clk/mediatek/clk-mt2701.c
index d175fa4390e6..86ea304ff28f 100644
--- a/drivers/clk/mediatek/clk-mt2701.c
+++ b/drivers/clk/mediatek/clk-mt2701.c
@@ -1036,3 +1036,4 @@ static int __init clk_mt2701_init(void)
 }
 
 arch_initcall(clk_mt2701_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
index e841be3a02c9..2a3296c50093 100644
--- a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -150,3 +150,4 @@ static struct platform_driver clk_mt2712_apmixed_drv = {
 	},
 };
 builtin_platform_driver(clk_mt2712_apmixed_drv)
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-bdp.c b/drivers/clk/mediatek/clk-mt2712-bdp.c
index 66517c0cc54b..b83575a58b48 100644
--- a/drivers/clk/mediatek/clk-mt2712-bdp.c
+++ b/drivers/clk/mediatek/clk-mt2712-bdp.c
@@ -76,3 +76,4 @@ static struct platform_driver clk_mt2712_bdp_drv = {
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
index 8702b3b33028..733e32cbdea9 100644
--- a/drivers/clk/mediatek/clk-mt2712-jpgdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-jpgdec.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt2712_jpgdec_drv = {
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
index 418193f8e12b..81e922f61f52 100644
--- a/drivers/clk/mediatek/clk-mt2712-vdec.c
+++ b/drivers/clk/mediatek/clk-mt2712-vdec.c
@@ -63,3 +63,4 @@ static struct platform_driver clk_mt2712_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712-venc.c b/drivers/clk/mediatek/clk-mt2712-venc.c
index 0e534733057a..0776be4fc479 100644
--- a/drivers/clk/mediatek/clk-mt2712-venc.c
+++ b/drivers/clk/mediatek/clk-mt2712-venc.c
@@ -51,3 +51,4 @@ static struct platform_driver clk_mt2712_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 568c23620d21..932fc3cd465b 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1007,3 +1007,4 @@ static struct platform_driver clk_mt2712_drv = {
 	},
 };
 module_platform_driver(clk_mt2712_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-audio.c b/drivers/clk/mediatek/clk-mt6765-audio.c
index 55bbf94a8739..b2d1b1292adc 100644
--- a/drivers/clk/mediatek/clk-mt6765-audio.c
+++ b/drivers/clk/mediatek/clk-mt6765-audio.c
@@ -77,3 +77,4 @@ static struct platform_driver clk_mt6765_audio_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_audio_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765-cam.c b/drivers/clk/mediatek/clk-mt6765-cam.c
index fe45f843de02..1172f6817803 100644
--- a/drivers/clk/mediatek/clk-mt6765-cam.c
+++ b/drivers/clk/mediatek/clk-mt6765-cam.c
@@ -57,3 +57,4 @@ static struct platform_driver clk_mt6765_cam_drv = {
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
index 01af9ff50482..499238709a07 100644
--- a/drivers/clk/mediatek/clk-mt6765-mipi0a.c
+++ b/drivers/clk/mediatek/clk-mt6765-mipi0a.c
@@ -50,3 +50,4 @@ static struct platform_driver clk_mt6765_mipi0a_drv = {
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
index ee035d8c97b9..a5e15c0a5586 100644
--- a/drivers/clk/mediatek/clk-mt6765-vcodec.c
+++ b/drivers/clk/mediatek/clk-mt6765-vcodec.c
@@ -52,3 +52,4 @@ static struct platform_driver clk_mt6765_vcodec_drv = {
 	},
 };
 module_platform_driver(clk_mt6765_vcodec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 470a84748b8d..5e8a1796a7ab 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -881,3 +881,4 @@ static int __init clk_mt6765_init(void)
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
index 1b6c14aef135..875ac4ed8095 100644
--- a/drivers/clk/mediatek/clk-mt6797-vdec.c
+++ b/drivers/clk/mediatek/clk-mt6797-vdec.c
@@ -62,3 +62,4 @@ static struct platform_driver clk_mt6797_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797-venc.c b/drivers/clk/mediatek/clk-mt6797-venc.c
index d3b812d8f4e9..4319cbbf122e 100644
--- a/drivers/clk/mediatek/clk-mt6797-venc.c
+++ b/drivers/clk/mediatek/clk-mt6797-venc.c
@@ -52,3 +52,4 @@ static struct platform_driver clk_mt6797_venc_drv = {
 	},
 };
 module_platform_driver(clk_mt6797_venc_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt6797.c b/drivers/clk/mediatek/clk-mt6797.c
index 23c19e6426a1..df56097ac104 100644
--- a/drivers/clk/mediatek/clk-mt6797.c
+++ b/drivers/clk/mediatek/clk-mt6797.c
@@ -706,3 +706,4 @@ static int __init clk_mt6797_init(void)
 }
 
 arch_initcall(clk_mt6797_init);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index 92b93c469f02..0a1b42f664cb 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -159,3 +159,4 @@ static struct platform_driver clk_mt7622_aud_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_aud_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index f15ab29a4c7b..23825da94798 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -89,3 +89,4 @@ static struct platform_driver clk_mt7622_eth_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 78c0a1aa419e..78b17ece61f3 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -101,3 +101,4 @@ static struct platform_driver clk_mt7622_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7622_hif_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-eth.c b/drivers/clk/mediatek/clk-mt7629-eth.c
index 7c7292fd521a..0006e6e72a73 100644
--- a/drivers/clk/mediatek/clk-mt7629-eth.c
+++ b/drivers/clk/mediatek/clk-mt7629-eth.c
@@ -155,3 +155,4 @@ static struct platform_driver clk_mt7629_eth_drv = {
 	},
 };
 builtin_platform_driver(clk_mt7629_eth_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 35fb2e5ca95c..c4c915a0b969 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -96,3 +96,4 @@ static struct platform_driver clk_mt7629_hif_drv = {
 	},
 };
 module_platform_driver(clk_mt7629_hif_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt7629.c b/drivers/clk/mediatek/clk-mt7629.c
index fa1bce943c45..53db0813be56 100644
--- a/drivers/clk/mediatek/clk-mt7629.c
+++ b/drivers/clk/mediatek/clk-mt7629.c
@@ -697,3 +697,4 @@ static int clk_mt7629_init(void)
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
index 621f04313546..621bbb542e7b 100644
--- a/drivers/clk/mediatek/clk-mt8167-aud.c
+++ b/drivers/clk/mediatek/clk-mt8167-aud.c
@@ -63,3 +63,4 @@ static struct platform_driver clk_mt8167_audsys_drv = {
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
index 1980269ba30a..676858220088 100644
--- a/drivers/clk/mediatek/clk-mt8167-vdec.c
+++ b/drivers/clk/mediatek/clk-mt8167-vdec.c
@@ -63,3 +63,4 @@ static struct platform_driver clk_mt8167_vdec_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_vdec_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 2f8b663151ff..3d56170859a6 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -901,3 +901,4 @@ static struct platform_driver clk_mt8167_drv = {
 	},
 };
 module_platform_driver(clk_mt8167_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
index 710d344fa2cd..0a3d3cb0f400 100644
--- a/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
+++ b/drivers/clk/mediatek/clk-mt8183-apmixedsys.c
@@ -190,3 +190,4 @@ static struct platform_driver clk_mt8183_apmixed_drv = {
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
index 035fdd02f0be..028d13bf9114 100644
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
index 32d1e8a16c18..67c2509ae39e 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
@@ -109,3 +109,4 @@ static struct platform_driver clk_mt8195_vpp0_drv = {
 	},
 };
 module_platform_driver(clk_mt8195_vpp0_drv);
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
index 2d2f7c22ec5c..7e997a0794d8 100644
--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
@@ -107,3 +107,4 @@ static struct platform_driver clk_mt8195_vpp1_drv = {
 	},
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
2.39.1

