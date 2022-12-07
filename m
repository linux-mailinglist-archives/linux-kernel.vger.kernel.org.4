Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930856455C0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 09:46:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbiLGIqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 03:46:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbiLGIoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 03:44:54 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B540D37224;
        Wed,  7 Dec 2022 00:44:28 -0800 (PST)
X-UUID: 1b5e0f83ab18413bb0997a8fb3012620-20221207
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=zEUOhTsnuyPRTvL6gD9qbIGzbMknApF9SjLnNIYL0hE=;
        b=qeBrehY1h7cizAkjWCyoR5hzytNg70cgOHtydUAnCq9z+mUHiDhkhKayvYk66K50eRtMa/hAgSR2GIxzlf+dgtkqX9OKFNaBDBXKstB0O5a2TyihN6OPejfxjyA/IxHlM/c6QMLNOsk74+YcCfQrGMvObizpFIyB30rhsKAqUKk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:39b4373c-4998-4016-9742-e7164c8752a9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:dcaaed0,CLOUDID:5cfacb16-b863-49f8-8228-cbdfeedd1fa4,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1b5e0f83ab18413bb0997a8fb3012620-20221207
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <moudy.ho@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1857642800; Wed, 07 Dec 2022 16:44:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 7 Dec 2022 16:44:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 7 Dec 2022 16:44:14 +0800
From:   Moudy Ho <moudy.ho@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Moudy Ho <moudy.ho@mediatek.com>
Subject: [PATCH v2 12/12] media: platform: mtk-mdp3: add 8195 component settings
Date:   Wed, 7 Dec 2022 16:44:12 +0800
Message-ID: <20221207084412.14075-13-moudy.ho@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221207084412.14075-1-moudy.ho@mediatek.com>
References: <20221207084412.14075-1-moudy.ho@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend the MDP3 component settings used in MT8195 platform.
Besides, all component settings need to be read in a specific way to
align shared memory data structure lengths in each platform.

Signed-off-by: Moudy Ho <moudy.ho@mediatek.com>
---
 .../platform/mediatek/mdp3/mtk-mdp3-cmdq.c    |  57 ++
 .../platform/mediatek/mdp3/mtk-mdp3-comp.c    | 781 +++++++++++++++++-
 2 files changed, 836 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
index d22b6a62cf21..9731b6e3523d 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-cmdq.c
@@ -38,6 +38,10 @@ static bool is_output_disabled(int id, const struct img_compparam *param, u32 co
 		num = CFG_COMP(MT8183, param, num_subfrms);
 		dis_output = CFG_COMP(MT8183, param, frame.output_disable);
 		dis_tile = CFG_COMP(MT8183, param, frame.output_disable);
+	} else if (CFG_CHECK(MT8195, id)) {
+		num = CFG_COMP(MT8195, param, num_subfrms);
+		dis_output = CFG_COMP(MT8195, param, frame.output_disable);
+		dis_tile = CFG_COMP(MT8195, param, frame.output_disable);
 	}
 
 	return (count < num) ? (dis_output || dis_tile) : true;
@@ -113,6 +117,8 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 
 	if (CFG_CHECK(MT8183, plat_id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
+	else if (CFG_CHECK(MT8195, plat_id))
+		num_comp = CFG_GET(MT8195, path->config, num_components);
 
 	/* Decide which mutex to use based on the current pipeline */
 	index = __get_pipe(path->mdp_dev, path->comps[0].comp->public_id);
@@ -125,6 +131,9 @@ static int mdp_path_subfrm_require(const struct mdp_path *path,
 
 		if (CFG_CHECK(MT8183, plat_id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, plat_id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -160,12 +169,17 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
+	else if (CFG_CHECK(MT8195, id))
+		num_comp = CFG_GET(MT8195, path->config, num_components);
 
 	/* Wait WROT SRAM shared to DISP RDMA */
 	/* Clear SOF event for each engine */
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -184,6 +198,9 @@ static int mdp_path_subfrm_run(const struct mdp_path *path,
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -206,6 +223,8 @@ static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
+	else if (CFG_CHECK(MT8195, id))
+		num_comp = CFG_GET(MT8195, path->config, num_components);
 
 	if (num_comp < 1)
 		return -EINVAL;
@@ -215,10 +234,15 @@ static int mdp_path_ctx_init(struct mdp_dev *mdp, struct mdp_path *path)
 
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		if (CFG_CHECK(MT8183, id))
 			param = (void *)CFG_ADDR(MT8183, path->config, components[index]);
+		else if (CFG_CHECK(MT8195, id))
+			param = (void *)CFG_ADDR(MT8195, path->config, components[index]);
 		ret = mdp_comp_ctx_config(mdp, &path->comps[index],
 					  param, path->param);
 		if (ret)
@@ -242,9 +266,13 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
+	else if (CFG_CHECK(MT8195, id))
+		num_comp = CFG_GET(MT8195, path->config, num_components);
 
 	if (CFG_CHECK(MT8183, id))
 		ctrl = CFG_ADDR(MT8183, path->config, ctrls[count]);
+	else if (CFG_CHECK(MT8195, id))
+		ctrl = CFG_ADDR(MT8195, path->config, ctrls[count]);
 
 	/* Acquire components */
 	ret = mdp_path_subfrm_require(path, cmd, &pipe, count);
@@ -260,6 +288,9 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	for (index = (num_comp - 1); index >= 0; index--) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -277,6 +308,9 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -290,6 +324,9 @@ static int mdp_path_config_subfrm(struct mdp_cmdq_cmd *cmd,
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -319,15 +356,22 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, path->config, num_components);
+	else if (CFG_CHECK(MT8195, id))
+		num_comp = CFG_GET(MT8195, path->config, num_components);
 
 	if (CFG_CHECK(MT8183, id))
 		num_sub = CFG_GET(MT8183, path->config, num_subfrms);
+	else if (CFG_CHECK(MT8195, id))
+		num_sub = CFG_GET(MT8195, path->config, num_subfrms);
 
 	/* Config path frame */
 	/* Reset components */
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -342,11 +386,16 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 
 		if (CFG_CHECK(MT8183, id))
 			out = CFG_COMP(MT8183, ctx->param, outputs[0]);
+		else if (CFG_CHECK(MT8195, id))
+			out = CFG_COMP(MT8195, ctx->param, outputs[0]);
 
 		compose = path->composes[out];
 		ctx = &path->comps[index];
@@ -365,6 +414,9 @@ static int mdp_path_config(struct mdp_dev *mdp, struct mdp_cmdq_cmd *cmd,
 	for (index = 0; index < num_comp; index++) {
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[index].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[index].type);
+
 		if (is_dummy_engine(path->mdp_dev, inner_id))
 			continue;
 		ctx = &path->comps[index];
@@ -519,6 +571,8 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 
 	if (CFG_CHECK(MT8183, id))
 		num_comp = CFG_GET(MT8183, param->config, num_components);
+	else if (CFG_CHECK(MT8195, id))
+		num_comp = CFG_GET(MT8195, param->config, num_components);
 	else
 		goto err_destroy_pkt;
 	comps = kcalloc(num_comp, sizeof(*comps), GFP_KERNEL);
@@ -572,6 +626,9 @@ int mdp_cmdq_send(struct mdp_dev *mdp, struct mdp_cmdq_param *param)
 
 		if (CFG_CHECK(MT8183, id))
 			inner_id = CFG_GET(MT8183, path->config, components[i].type);
+		else if (CFG_CHECK(MT8195, id))
+			inner_id = CFG_GET(MT8195, path->config, components[i].type);
+
 		if (is_dummy_engine(mdp, inner_id))
 			continue;
 		memcpy(&comps[i], path->comps[i].comp,
diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
index d54d7319af9a..59559a354e1b 100644
--- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
+++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
@@ -15,6 +15,14 @@
 #include "mdp_reg_rdma.h"
 #include "mdp_reg_ccorr.h"
 #include "mdp_reg_rsz.h"
+#include "mdp_reg_fg.h"
+#include "mdp_reg_aal.h"
+#include "mdp_reg_tdshp.h"
+#include "mdp_reg_hdr.h"
+#include "mdp_reg_color.h"
+#include "mdp_reg_ovl.h"
+#include "mdp_reg_pad.h"
+#include "mdp_reg_merge.h"
 #include "mdp_reg_wrot.h"
 #include "mdp_reg_wdma.h"
 
@@ -114,6 +122,7 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 	bool en_ufo = MDP_COLOR_IS_UFP(colorformat);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 rdma_con_mask = 0;
 	u32 reg = 0;
 
 	if (mdp_cfg && mdp_cfg->rdma_support_10bit) {
@@ -134,6 +143,8 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 	/* Setup source frame info */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.src_ctrl);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.src_ctrl);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_CON, reg,
 		     0x03C8FE0F);
 
@@ -142,69 +153,161 @@ static int config_rdma_frame(struct mdp_comp_ctx *ctx,
 			/* Setup source buffer base */
 			if (CFG_CHECK(MT8183, p_id))
 				reg = CFG_COMP(MT8183, ctx->param, rdma.ufo_dec_y);
+			else if (CFG_CHECK(MT8195, p_id))
+				reg = CFG_COMP(MT8195, ctx->param, rdma.ufo_dec_y);
 			MM_REG_WRITE(cmd, subsys_id,
 				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_Y,
 				     reg, 0xFFFFFFFF);
+
 			if (CFG_CHECK(MT8183, p_id))
 				reg = CFG_COMP(MT8183, ctx->param, rdma.ufo_dec_c);
+			else if (CFG_CHECK(MT8195, p_id))
+				reg = CFG_COMP(MT8195, ctx->param, rdma.ufo_dec_c);
 			MM_REG_WRITE(cmd, subsys_id,
 				     base, MDP_RDMA_UFO_DEC_LENGTH_BASE_C,
 				     reg, 0xFFFFFFFF);
+
 			/* Set 10bit source frame pitch */
 			if (block10bit) {
 				if (CFG_CHECK(MT8183, p_id))
 					reg = CFG_COMP(MT8183, ctx->param, rdma.mf_bkgd_in_pxl);
+				else if (CFG_CHECK(MT8195, p_id))
+					reg = CFG_COMP(MT8195, ctx->param, rdma.mf_bkgd_in_pxl);
 				MM_REG_WRITE(cmd, subsys_id,
 					     base, MDP_RDMA_MF_BKGD_SIZE_IN_PXL,
 					     reg, 0x001FFFFF);
 			}
 		}
 
-	if (CFG_CHECK(MT8183, p_id))
+	if (CFG_CHECK(MT8183, p_id)) {
 		reg = CFG_COMP(MT8183, ctx->param, rdma.control);
+		rdma_con_mask = 0x1110;
+	} else if (CFG_CHECK(MT8195, p_id)) {
+		reg = CFG_COMP(MT8195, ctx->param, rdma.control);
+		rdma_con_mask = 0x1130;
+	}
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_CON, reg,
-		     0x1110);
+		     rdma_con_mask);
+
 	/* Setup source buffer base */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_0, reg,
 		     0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_1, reg,
 		     0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_BASE_2, reg,
 		     0xFFFFFFFF);
+
 	/* Setup source buffer end */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova_end[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova_end[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_0,
 		     reg, 0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova_end[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova_end[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_1,
 		     reg, 0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.iova_end[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.iova_end[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_END_2,
 		     reg, 0xFFFFFFFF);
+
 	/* Setup source frame pitch */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.mf_bkgd);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.mf_bkgd);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_BKGD_SIZE_IN_BYTE,
 		     reg, 0x001FFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.sf_bkgd);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.sf_bkgd);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SF_BKGD_SIZE_IN_BYTE,
 		     reg, 0x001FFFFF);
+
 	/* Setup color transform */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.transform);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.transform);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_TRANSFORM_0,
 		     reg, 0x0F110000);
 
+	if (mdp_cfg && mdp_cfg->rdma_esl_setting) {
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.dmabuf_con0);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_DMABUF_CON_0,
+			     reg, 0x0FFF00FF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_high_con0);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_HIGH_CON_0,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_low_con0);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_LOW_CON_0,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.dmabuf_con1);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_DMABUF_CON_1,
+			     reg, 0x0F7F007F);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_high_con1);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_HIGH_CON_1,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_low_con1);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_LOW_CON_1,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.dmabuf_con2);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_DMABUF_CON_2,
+			     reg, 0x0F3F003F);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_high_con2);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_HIGH_CON_2,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.ultra_th_low_con2);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_ULTRA_TH_LOW_CON_2,
+			     reg, 0x3FFFFFFF);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rdma.dmabuf_con3);
+		MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_DMABUF_CON_3,
+			     reg, 0x0F3F003F);
+	}
+
 	return 0;
 }
 
@@ -226,6 +329,8 @@ static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
 	/* Set Y pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].offset[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].offset[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_0,
 		     reg, 0xFFFFFFFF);
 
@@ -234,6 +339,8 @@ static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
 		if (mdp_cfg->rdma_support_10bit && block10bit && en_ufo) {
 			if (CFG_CHECK(MT8183, p_id))
 				reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].offset_0_p);
+			else if (CFG_CHECK(MT8195, p_id))
+				reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].offset_0_p);
 			MM_REG_WRITE(cmd, subsys_id, base,
 				     MDP_RDMA_SRC_OFFSET_0_P,
 				     reg, 0xFFFFFFFF);
@@ -243,32 +350,49 @@ static int config_rdma_subfrm(struct mdp_comp_ctx *ctx,
 	/* Set U pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].offset[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].offset[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_1,
 		     reg, 0xFFFFFFFF);
+
 	/* Set V pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].offset[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].offset[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_SRC_OFFSET_2,
 		     reg, 0xFFFFFFFF);
+
 	/* Set source size */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].src);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].src);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_SRC_SIZE, reg,
 		     0x1FFF1FFF);
+
 	/* Set target size */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].clip);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].clip);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_CLIP_SIZE,
 		     reg, 0x1FFF1FFF);
+
 	/* Set crop offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rdma.subfrms[index].clip_ofst);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rdma.subfrms[index].clip_ofst);
 	MM_REG_WRITE(cmd, subsys_id, base, MDP_RDMA_MF_OFFSET_1,
 		     reg, 0x003F001F);
 
 	if (CFG_CHECK(MT8183, p_id)) {
 		csf_l = CFG_COMP(MT8183, ctx->param, subfrms[index].in.left);
 		csf_r = CFG_COMP(MT8183, ctx->param, subfrms[index].in.right);
+	} else if (CFG_CHECK(MT8195, p_id)) {
+		csf_l = CFG_COMP(MT8195, ctx->param, subfrms[index].in.left);
+		csf_r = CFG_COMP(MT8195, ctx->param, subfrms[index].in.right);
 	}
 	if (mdp_cfg && mdp_cfg->rdma_upsample_repeat_only)
 		if ((csf_r - csf_l + 1) > 320)
@@ -305,6 +429,61 @@ static const struct mdp_comp_ops rdma_ops = {
 	.wait_comp_event = wait_rdma_event,
 };
 
+static int init_fg(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_TRIGGER, BIT(2), BIT(2));
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_TRIGGER, 0x0, BIT(2));
+
+	return 0;
+}
+
+static int config_fg_frame(struct mdp_comp_ctx *ctx,
+			   struct mdp_cmdq_cmd *cmd,
+			   const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, fg.ctrl_0);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_FG_CTRL_0, reg, BIT(0));
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, fg.ck_en);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_FG_CK_EN, reg, 0x7);
+
+	return 0;
+}
+
+static int config_fg_subfrm(struct mdp_comp_ctx *ctx,
+			    struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, fg.subfrms[index].info_0);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_TILE_INFO_0, reg, 0xFFFFFFFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, fg.subfrms[index].info_1);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_FG_TILE_INFO_1, reg, 0xFFFFFFFF);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops fg_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_fg,
+	.config_frame = config_fg_frame,
+	.config_subfrm = config_fg_subfrm,
+};
+
 static int init_rsz(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 {
 	phys_addr_t base = ctx->comp->reg_base;
@@ -315,6 +494,10 @@ static int init_rsz(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, 0x0, BIT(16));
 	/* Enable RSZ */
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_ENABLE, BIT(0), BIT(0));
+
+	if (CFG_CHECK(MT8195, p_id))
+		mtk_mmsys_vpp_rsz_dcm_config(ctx->comp->mdp_dev->mdp_mmsys2, true);
+
 	return 0;
 }
 
@@ -322,13 +505,19 @@ static int config_rsz_frame(struct mdp_comp_ctx *ctx,
 			    struct mdp_cmdq_cmd *cmd,
 			    const struct v4l2_rect *compose)
 {
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
 	bool bypass = FALSE;
 	u32 reg = 0;
 
+	if (mdp_cfg && mdp_cfg->rsz_etc_control)
+		MM_REG_WRITE(cmd, subsys_id, base, RSZ_ETC_CONTROL, 0x0, 0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		bypass = CFG_COMP(MT8183, ctx->param, frame.bypass);
+	else if (CFG_CHECK(MT8195, p_id))
+		bypass = CFG_COMP(MT8195, ctx->param, frame.bypass);
 
 	if (bypass) {
 		/* Disable RSZ */
@@ -338,20 +527,32 @@ static int config_rsz_frame(struct mdp_comp_ctx *ctx,
 
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.control1);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.control1);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_1, reg,
 		     0x03FFFDF3);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.control2);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.control2);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, reg,
 		     0x0FFFC290);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.coeff_step_x);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.coeff_step_x);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_HORIZONTAL_COEFF_STEP,
 		     reg, 0x007FFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.coeff_step_y);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.coeff_step_y);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_VERTICAL_COEFF_STEP,
 		     reg, 0x007FFFFF);
+
 	return 0;
 }
 
@@ -361,21 +562,30 @@ static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
 	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
 	phys_addr_t base = ctx->comp->reg_base;
 	u8 subsys_id = ctx->comp->subsys_id;
+	u32 id;
 	u32 csf_l = 0, csf_r = 0;
 	u32 reg = 0;
 
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.subfrms[index].control2);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.subfrms[index].control2);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_CONTROL_2, reg,
 		     0x00003800);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.subfrms[index].src);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.subfrms[index].src);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_INPUT_IMAGE, reg,
 		     0xFFFFFFFF);
 
 	if (CFG_CHECK(MT8183, p_id)) {
 		csf_l = CFG_COMP(MT8183, ctx->param, subfrms[index].in.left);
 		csf_r = CFG_COMP(MT8183, ctx->param, subfrms[index].in.right);
+	} else if (CFG_CHECK(MT8195, p_id)) {
+		csf_l = CFG_COMP(MT8195, ctx->param, subfrms[index].in.left);
+		csf_r = CFG_COMP(MT8195, ctx->param, subfrms[index].in.right);
 	}
 	if (mdp_cfg && mdp_cfg->rsz_disable_dcm_small_sample)
 		if ((csf_r - csf_l + 1) <= 16)
@@ -384,37 +594,95 @@ static int config_rsz_subfrm(struct mdp_comp_ctx *ctx,
 
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].luma.left);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].luma.left);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_HORIZONTAL_INTEGER_OFFSET,
 		     reg, 0xFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].luma.left_subpix);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].luma.left_subpix);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_LUMA_HORIZONTAL_SUBPIXEL_OFFSET,
 		     reg, 0x1FFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].luma.top);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].luma.top);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_INTEGER_OFFSET,
 		     reg, 0xFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].luma.top_subpix);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].luma.top_subpix);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_LUMA_VERTICAL_SUBPIXEL_OFFSET,
 		     reg, 0x1FFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].chroma.left);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].chroma.left);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_CHROMA_HORIZONTAL_INTEGER_OFFSET,
 		     reg, 0xFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, subfrms[index].chroma.left_subpix);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, subfrms[index].chroma.left_subpix);
 	MM_REG_WRITE(cmd, subsys_id,
 		     base, PRZ_CHROMA_HORIZONTAL_SUBPIXEL_OFFSET,
 		     reg, 0x1FFFFF);
 
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, rsz.subfrms[index].clip);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, rsz.subfrms[index].clip);
 	MM_REG_WRITE(cmd, subsys_id, base, PRZ_OUTPUT_IMAGE, reg,
 		     0xFFFFFFFF);
 
+	if (CFG_CHECK(MT8195, p_id)) {
+		struct mdp_comp *merge;
+		const struct mtk_mdp_driver_data *data = ctx->comp->mdp_dev->mdp_data;
+		enum mtk_mdp_comp_id public_id = ctx->comp->public_id;
+
+		switch (public_id) {
+		case MDP_COMP_RSZ2:
+			merge = ctx->comp->mdp_dev->comp[MDP_COMP_MERGE2];
+			break;
+		case MDP_COMP_RSZ3:
+			merge = ctx->comp->mdp_dev->comp[MDP_COMP_MERGE3];
+			break;
+		default:
+			goto rsz_subfrm_done;
+		}
+		id = data->comp_data[public_id].match.alias_id;
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rsz.subfrms[index].rsz_switch);
+		mtk_mmsys_vpp_rsz_merge_config(ctx->comp->mdp_dev->mdp_mmsys2, id, reg);
+
+		if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, rsz.subfrms[index].merge_cfg);
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_CFG_0, reg, 0xFFFFFFFF);
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_CFG_4, reg, 0xFFFFFFFF);
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_CFG_24, reg, 0xFFFFFFFF);
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_CFG_25, reg, 0xFFFFFFFF);
+
+		/* Bypass mode */
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_CFG_12, BIT(0), 0xFFFFFFFF);
+		MM_REG_WRITE(cmd, merge->subsys_id, merge->reg_base,
+			     MDP_MERGE_ENABLE, BIT(0), 0xFFFFFFFF);
+	}
+
+rsz_subfrm_done:
 	return 0;
 }
 
@@ -431,6 +699,9 @@ static int advance_rsz_subfrm(struct mdp_comp_ctx *ctx,
 		if (CFG_CHECK(MT8183, p_id)) {
 			csf_l = CFG_COMP(MT8183, ctx->param, subfrms[index].in.left);
 			csf_r = CFG_COMP(MT8183, ctx->param, subfrms[index].in.right);
+		} else if (CFG_CHECK(MT8195, p_id)) {
+			csf_l = CFG_COMP(MT8195, ctx->param, subfrms[index].in.left);
+			csf_r = CFG_COMP(MT8195, ctx->param, subfrms[index].in.right);
 		}
 
 		if ((csf_r - csf_l + 1) <= 16)
@@ -449,6 +720,410 @@ static const struct mdp_comp_ops rsz_ops = {
 	.advance_subfrm = advance_rsz_subfrm,
 };
 
+static int init_aal(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	/* Always set MDP_AAL enable to 1 */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_EN, BIT(0), BIT(0));
+
+	return 0;
+}
+
+static int config_aal_frame(struct mdp_comp_ctx *ctx,
+			    struct mdp_cmdq_cmd *cmd,
+			    const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, aal.cfg_main);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_CFG_MAIN, reg, BIT(7));
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, aal.cfg);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_CFG, reg, BIT(0));
+
+	return 0;
+}
+
+static int config_aal_subfrm(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, aal.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_SIZE,
+		     reg, MDP_AAL_SIZE_MASK);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, aal.subfrms[index].clip_ofst);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_OUTPUT_OFFSET,
+		     reg, 0x00FF00FF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, aal.subfrms[index].clip);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_AAL_OUTPUT_SIZE,
+		     reg, MDP_AAL_OUTPUT_SIZE_MASK);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops aal_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_aal,
+	.config_frame = config_aal_frame,
+	.config_subfrm = config_aal_subfrm,
+};
+
+static int init_hdr(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	/* Always set MDP_HDR enable to 1 */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_TOP, BIT(0), BIT(0));
+
+	return 0;
+}
+
+static int config_hdr_frame(struct mdp_comp_ctx *ctx,
+			    struct mdp_cmdq_cmd *cmd,
+			    const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.top);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_TOP, reg, BIT(29) | BIT(28));
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.relay);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_RELAY, reg, BIT(0));
+
+	return 0;
+}
+
+static int config_hdr_subfrm(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].win_size);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_TILE_POS,
+		     reg, MDP_HDR_TILE_POS_MASK);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_SIZE_0, reg, 0x1FFF1FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].clip_ofst0);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_SIZE_1, reg, 0x1FFF1FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].clip_ofst1);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_SIZE_2, reg, 0x1FFF1FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].hist_ctrl_0);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_HIST_CTRL_0, reg, 0x00003FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].hist_ctrl_1);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_HIST_CTRL_1, reg, 0x00003FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].hdr_top);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_TOP, reg, BIT(6) | BIT(5));
+
+	/* Enable histogram */
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, hdr.subfrms[index].hist_addr);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HDR_HIST_ADDR, reg, BIT(9));
+
+	return 0;
+}
+
+static const struct mdp_comp_ops hdr_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_hdr,
+	.config_frame = config_hdr_frame,
+	.config_subfrm = config_hdr_subfrm,
+};
+
+static void reset_luma_hist(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	const struct mdp_platform_config *mdp_cfg = __get_plat_cfg(ctx);
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 hist_num = mdp_cfg->tdshp_hist_num;
+	u32 i;
+
+	/* Reset histogram */
+	for (i = 0; i <= hist_num; i++)
+		MM_REG_WRITE_MASK(cmd, subsys_id, base,
+				  (MDP_LUMA_HIST_INIT + (i << 2)),
+				  0, 0xFFFFFFFF);
+
+	if (mdp_cfg && mdp_cfg->tdshp_constrain)
+		MM_REG_WRITE(cmd, subsys_id, base,
+			     MDP_DC_TWO_D_W1_RESULT_INIT, 0, 0xFFFFFFFF);
+
+	if (mdp_cfg && mdp_cfg->tdshp_contour)
+		for (i = 0; i < hist_num; i++)
+			MM_REG_WRITE_MASK(cmd, subsys_id, base,
+					  (MDP_CONTOUR_HIST_INIT + (i << 2)),
+					  0, 0xFFFFFFFF);
+}
+
+static int init_tdshp(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_CTRL, BIT(0), BIT(0));
+	/* Enable FIFO */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_CFG, BIT(1), BIT(1));
+	reset_luma_hist(ctx, cmd);
+
+	return 0;
+}
+
+static int config_tdshp_frame(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd,
+			      const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.cfg);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_CFG, reg, BIT(0));
+
+	return 0;
+}
+
+static int config_tdshp_subfrm(struct mdp_comp_ctx *ctx,
+			       struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.subfrms[index].src);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_INPUT_SIZE,
+		     reg, MDP_TDSHP_INPUT_SIZE_MASK);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.subfrms[index].clip_ofst);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_OUTPUT_OFFSET,
+		     reg, 0x00FF00FF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.subfrms[index].clip);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_TDSHP_OUTPUT_SIZE,
+		     reg, MDP_TDSHP_OUTPUT_SIZE_MASK);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.subfrms[index].hist_cfg_0);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HIST_CFG_00, reg, 0xFFFFFFFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, tdshp.subfrms[index].hist_cfg_1);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_HIST_CFG_01, reg, 0xFFFFFFFF);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops tdshp_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_tdshp,
+	.config_frame = config_tdshp_frame,
+	.config_subfrm = config_tdshp_subfrm,
+};
+
+static int init_color(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base,
+		     MDP_COLOR_START, 0x1, BIT(1) | BIT(0));
+	MM_REG_WRITE(cmd, subsys_id, base,
+		     MDP_COLOR_WIN_X_MAIN, 0xFFFF0000, 0xFFFFFFFF);
+	MM_REG_WRITE(cmd, subsys_id, base,
+		     MDP_COLOR_WIN_Y_MAIN, 0xFFFF0000, 0xFFFFFFFF);
+
+	/* Reset color matrix */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_CM1_EN, 0x0, BIT(0));
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_CM2_EN, 0x0, BIT(0));
+
+	/* Enable interrupt */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_INTEN, 0x7, 0x7);
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_OUT_SEL, 0x333, 0x333);
+
+	return 0;
+}
+
+static int config_color_frame(struct mdp_comp_ctx *ctx,
+			      struct mdp_cmdq_cmd *cmd,
+			      const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, color.start);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_START,
+		     reg, MDP_COLOR_START_MASK);
+
+	return 0;
+}
+
+static int config_color_subfrm(struct mdp_comp_ctx *ctx,
+			       struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, color.subfrms[index].in_hsize);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_INTERNAL_IP_WIDTH,
+		     reg, 0x00003FFF);
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, color.subfrms[index].in_vsize);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_COLOR_INTERNAL_IP_HEIGHT,
+		     reg, 0x00003FFF);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops color_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_color,
+	.config_frame = config_color_frame,
+	.config_subfrm = config_color_subfrm,
+};
+
+static int init_ovl(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_EN,
+		     BIT(0), MDP_OVL_EN_MASK);
+
+	/* Set to relay mode */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_SRC_CON,
+		     BIT(9), MDP_OVL_SRC_CON_MASK);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_DP_CON,
+		     BIT(0), MDP_OVL_DP_CON_MASK);
+
+	return 0;
+}
+
+static int config_ovl_frame(struct mdp_comp_ctx *ctx,
+			    struct mdp_cmdq_cmd *cmd,
+			    const struct v4l2_rect *compose)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, ovl.L0_con);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_L0_CON, reg, BIT(29) | BIT(28));
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, ovl.src_con);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_SRC_CON, reg, BIT(0));
+
+	return 0;
+}
+
+static int config_ovl_subfrm(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, ovl.subfrms[index].L0_src_size);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_L0_SRC_SIZE,
+		     reg, MDP_OVL_L0_SRC_SIZE_MASK);
+
+	/* Setup output size */
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, ovl.subfrms[index].roi_size);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_OVL_ROI_SIZE,
+		     reg, MDP_OVL_ROI_SIZE_MASK);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops ovl_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_ovl,
+	.config_frame = config_ovl_frame,
+	.config_subfrm = config_ovl_subfrm,
+};
+
+static int init_pad(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_PAD_CON,
+		     BIT(1), MDP_PAD_CON_MASK);
+	/* Reset */
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_PAD_W_SIZE,
+		     0, MDP_PAD_W_SIZE_MASK);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_PAD_H_SIZE,
+		     0, MDP_PAD_H_SIZE_MASK);
+
+	return 0;
+}
+
+static int config_pad_subfrm(struct mdp_comp_ctx *ctx,
+			     struct mdp_cmdq_cmd *cmd, u32 index)
+{
+	phys_addr_t base = ctx->comp->reg_base;
+	u16 subsys_id = ctx->comp->subsys_id;
+	u32 reg = 0;
+
+	if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, pad.subfrms[index].pic_size);
+	MM_REG_WRITE(cmd, subsys_id, base, MDP_PAD_PIC_SIZE,
+		     reg, MDP_PAD_PIC_SIZE_MASK);
+
+	return 0;
+}
+
+static const struct mdp_comp_ops pad_ops = {
+	.get_comp_flag = get_comp_flag,
+	.init_comp = init_pad,
+	.config_subfrm = config_pad_subfrm,
+};
+
 static int init_wrot(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 {
 	phys_addr_t base = ctx->comp->reg_base;
@@ -457,6 +1132,11 @@ static int init_wrot(struct mdp_comp_ctx *ctx, struct mdp_cmdq_cmd *cmd)
 	/* Reset WROT */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, BIT(0), BIT(0));
 	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, BIT(0), BIT(0));
+
+	/* Reset setting */
+	if (CFG_CHECK(MT8195, p_id))
+		MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, 0x0, 0xFFFFFFFF);
+
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_SOFT_RST, 0x0, BIT(0));
 	MM_REG_POLL(cmd, subsys_id, base, VIDO_SOFT_RST_STAT, 0x0, BIT(0));
 	return 0;
@@ -474,57 +1154,120 @@ static int config_wrot_frame(struct mdp_comp_ctx *ctx,
 	/* Write frame base address */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.iova[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.iova[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR, reg,
 		     0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.iova[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.iova[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_C, reg,
 		     0xFFFFFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.iova[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.iova[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_BASE_ADDR_V, reg,
 		     0xFFFFFFFF);
+
+	if (mdp_cfg) {
+		if (mdp_cfg->wrot_support_10bit) {
+			if (CFG_CHECK(MT8195, p_id))
+				reg = CFG_COMP(MT8195, ctx->param, wrot.scan_10bit);
+			MM_REG_WRITE(cmd, subsys_id, base, VIDO_SCAN_10BIT,
+				     reg, 0x0000000F);
+
+			if (CFG_CHECK(MT8195, p_id))
+				reg = CFG_COMP(MT8195, ctx->param, wrot.pending_zero);
+			MM_REG_WRITE(cmd, subsys_id, base, VIDO_PENDING_ZERO,
+				     reg, 0x04000000);
+		}
+
+		if (CFG_CHECK(MT8195, p_id)) {
+			reg = CFG_COMP(MT8195, ctx->param, wrot.bit_number);
+			MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL_2,
+				     reg, 0x00000007);
+		}
+	}
+
 	/* Write frame related registers */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.control);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.control);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CTRL, reg,
 		     0xF131510F);
+
+	/* Write pre-ultra threshold */
+	if (CFG_CHECK(MT8195, p_id)) {
+		reg = CFG_COMP(MT8195, ctx->param, wrot.pre_ultra);
+		MM_REG_WRITE(cmd, subsys_id, base, VIDO_DMA_PREULTRA, reg,
+			     0x00FFFFFF);
+	}
+
 	/* Write frame Y pitch */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.stride[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.stride[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE, reg,
 		     0x0000FFFF);
+
 	/* Write frame UV pitch */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.stride[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.stride[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_C, reg,
 		     0xFFFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.stride[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.stride[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_STRIDE_V, reg,
 		     0xFFFF);
+
 	/* Write matrix control */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.mat_ctrl);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.mat_ctrl);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAT_CTRL, reg, 0xF3);
 
 	/* Set the fixed ALPHA as 0xFF */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_DITHER, 0xFF000000,
 		     0xFF000000);
+
 	/* Set VIDO_EOL_SEL */
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_RSV_1, BIT(31), BIT(31));
+
 	/* Set VIDO_FIFO_TEST */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.fifo_test);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.fifo_test);
+
 	if (reg != 0)
 		MM_REG_WRITE(cmd, subsys_id, base, VIDO_FIFO_TEST,
 			     reg, 0xFFF);
+
 	/* Filter enable */
 	if (mdp_cfg && mdp_cfg->wrot_filter_constraint) {
 		if (CFG_CHECK(MT8183, p_id))
 			reg = CFG_COMP(MT8183, ctx->param, wrot.filter);
+		else if (CFG_CHECK(MT8195, p_id))
+			reg = CFG_COMP(MT8195, ctx->param, wrot.filter);
 		MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
 			     reg, 0x77);
+
+		/* Turn off WROT dma dcm */
+		if (CFG_CHECK(MT8195, p_id))
+			MM_REG_WRITE(cmd, subsys_id, base, VIDO_ROT_EN,
+				     (0x1 << 23) + (0x1 << 20), 0x900000);
 	}
 
 	return 0;
@@ -540,35 +1283,54 @@ static int config_wrot_subfrm(struct mdp_comp_ctx *ctx,
 	/* Write Y pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].offset[0]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].offset[0]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR,
 		     reg, 0x0FFFFFFF);
+
 	/* Write U pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].offset[1]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].offset[1]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_C,
 		     reg, 0x0FFFFFFF);
+
 	/* Write V pixel offset */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].offset[2]);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].offset[2]);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_OFST_ADDR_V,
 		     reg, 0x0FFFFFFF);
+
 	/* Write source size */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].src);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].src);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_IN_SIZE, reg,
 		     0x1FFF1FFF);
+
 	/* Write target size */
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].clip);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].clip);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_TAR_SIZE, reg,
 		     0x1FFF1FFF);
+
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].clip_ofst);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].clip_ofst);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_CROP_OFST, reg,
 		     0x1FFF1FFF);
 
 	if (CFG_CHECK(MT8183, p_id))
 		reg = CFG_COMP(MT8183, ctx->param, wrot.subfrms[index].main_buf);
+	else if (CFG_CHECK(MT8195, p_id))
+		reg = CFG_COMP(MT8195, ctx->param, wrot.subfrms[index].main_buf);
 	MM_REG_WRITE(cmd, subsys_id, base, VIDO_MAIN_BUF_SIZE,
 		     reg, 0x1FFF7F00);
 
@@ -778,6 +1540,13 @@ static const struct mdp_comp_ops *mdp_comp_ops[MDP_COMP_TYPE_COUNT] = {
 	[MDP_COMP_TYPE_WROT] =		&wrot_ops,
 	[MDP_COMP_TYPE_WDMA] =		&wdma_ops,
 	[MDP_COMP_TYPE_CCORR] =		&ccorr_ops,
+	[MDP_COMP_TYPE_HDR] =		&hdr_ops,
+	[MDP_COMP_TYPE_FG] =		&fg_ops,
+	[MDP_COMP_TYPE_AAL] =		&aal_ops,
+	[MDP_COMP_TYPE_TDSHP] =		&tdshp_ops,
+	[MDP_COMP_TYPE_COLOR] =		&color_ops,
+	[MDP_COMP_TYPE_OVL] =		&ovl_ops,
+	[MDP_COMP_TYPE_PAD] =		&pad_ops,
 };
 
 static const struct of_device_id mdp_comp_dt_ids[] = {
@@ -1226,6 +1995,8 @@ int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
 
 	if (CFG_CHECK(MT8183, p_id))
 		arg = CFG_COMP(MT8183, param, type);
+	else if (CFG_CHECK(MT8195, p_id))
+		arg = CFG_COMP(MT8195, param, type);
 	else
 		return -EINVAL;
 	public_id = get_comp_public_id(mdp, arg);
@@ -1243,16 +2014,22 @@ int mdp_comp_ctx_config(struct mdp_dev *mdp, struct mdp_comp_ctx *ctx,
 	ctx->param = param;
 	if (CFG_CHECK(MT8183, p_id))
 		arg = CFG_COMP(MT8183, param, input);
+	else if (CFG_CHECK(MT8195, p_id))
+		arg = CFG_COMP(MT8195, param, input);
 	else
 		return -EINVAL;
 	ctx->input = &frame->inputs[arg];
 	if (CFG_CHECK(MT8183, p_id))
 		idx = CFG_COMP(MT8183, param, num_outputs);
+	else if (CFG_CHECK(MT8195, p_id))
+		idx = CFG_COMP(MT8195, param, num_outputs);
 	else
 		return -EINVAL;
 	for (i = 0; i < idx; i++) {
 		if (CFG_CHECK(MT8183, p_id))
 			arg = CFG_COMP(MT8183, param, outputs[i]);
+		else if (CFG_CHECK(MT8195, p_id))
+			arg = CFG_COMP(MT8195, param, outputs[i]);
 		else
 			return -EINVAL;
 		ctx->outputs[i] = &frame->outputs[arg];
-- 
2.18.0

