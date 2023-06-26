Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425E773D5DD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 04:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjFZCf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 22:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjFZCfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 22:35:51 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491E9E70;
        Sun, 25 Jun 2023 19:35:32 -0700 (PDT)
X-UUID: 1b34a0f613ca11eeb20a276fd37b9834-20230626
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DCSEruFMAgNAqC8DL50kDW4p9kaypb69s82jBsdbPB4=;
        b=ijn42tM8NDHhcWPHmGi2dyQLDNzjAtoenXTWy3x09f1yq/lDwS7aonsfMAFsIuJi8kHrcfssG1WT0YsDYjShctvWcaWGtg3aPWmiD9VYSNK5ydHtEFAHCut4P7LYb+oh0OlroL6srl+yUwWcH6qY7ff14aYb0DOqUFeCr4SpoGI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e255f346-7fd0-4473-b6b6-33164f3fcef2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.27,REQID:e255f346-7fd0-4473-b6b6-33164f3fcef2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:01c9525,CLOUDID:f4d3a03f-7aa7-41f3-a6bd-0433bee822f3,B
        ulkID:230626103528MSLVJ232,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,TF_CID_SPAM_ASC,TF_CID_SPAM_FAS,
        TF_CID_SPAM_FSD
X-UUID: 1b34a0f613ca11eeb20a276fd37b9834-20230626
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2136040430; Mon, 26 Jun 2023 10:35:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 26 Jun 2023 10:35:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 26 Jun 2023 10:35:24 +0800
From:   Maso Huang <maso.huang@mediatek.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH v2 1/7] ASoC: mediatek: mt7986: add common header
Date:   Mon, 26 Jun 2023 10:34:55 +0800
Message-ID: <20230626023501.11120-2-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230626023501.11120-1-maso.huang@mediatek.com>
References: <20230626023501.11120-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add header files for register definition and structure.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt7986/mt7986-afe-common.h |  51 +++++
 sound/soc/mediatek/mt7986/mt7986-reg.h        | 206 ++++++++++++++++++
 2 files changed, 257 insertions(+)
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-afe-common.h
 create mode 100644 sound/soc/mediatek/mt7986/mt7986-reg.h

diff --git a/sound/soc/mediatek/mt7986/mt7986-afe-common.h b/sound/soc/mediatek/mt7986/mt7986-afe-common.h
new file mode 100644
index 000000000000..646e1be4fdce
--- /dev/null
+++ b/sound/soc/mediatek/mt7986/mt7986-afe-common.h
@@ -0,0 +1,51 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt7986-afe-common.h  --  MediaTek 7986 audio driver definitions
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT_7986_AFE_COMMON_H_
+#define _MT_7986_AFE_COMMON_H_
+
+#include <sound/soc.h>
+#include <linux/clk.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "../common/mtk-base-afe.h"
+
+enum {
+	MT7986_MEMIF_DL1,
+	MT7986_MEMIF_VUL12,
+	MT7986_MEMIF_NUM,
+	MT7986_DAI_ETDM = MT7986_MEMIF_NUM,
+	MT7986_DAI_NUM,
+};
+
+enum {
+	MT7986_IRQ_0,
+	MT7986_IRQ_1,
+	MT7986_IRQ_2,
+	MT7986_IRQ_NUM,
+};
+
+struct clk;
+
+struct mt7986_afe_private {
+	struct clk_bulk_data *clks;
+	int num_clks;
+
+	int pm_runtime_bypass_reg_ctl;
+
+	/* dai */
+	void *dai_priv[MT7986_DAI_NUM];
+};
+
+unsigned int mt7986_afe_rate_transform(struct device *dev,
+				       unsigned int rate);
+
+/* dai register */
+int mt7986_dai_etdm_register(struct mtk_base_afe *afe);
+#endif
diff --git a/sound/soc/mediatek/mt7986/mt7986-reg.h b/sound/soc/mediatek/mt7986/mt7986-reg.h
new file mode 100644
index 000000000000..6433cdf3da92
--- /dev/null
+++ b/sound/soc/mediatek/mt7986/mt7986-reg.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt7986-reg.h  --  MediaTek 7986 audio driver reg definition
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT7986_REG_H_
+#define _MT7986_REG_H_
+
+#define AUDIO_TOP_CON2                  0x0008
+#define AUDIO_TOP_CON4                  0x0010
+#define AUDIO_ENGEN_CON0                0x0014
+#define AFE_IRQ_MCU_EN                  0x0100
+#define AFE_IRQ_MCU_STATUS              0x0120
+#define AFE_IRQ_MCU_CLR                 0x0128
+#define AFE_IRQ0_MCU_CFG0               0x0140
+#define AFE_IRQ0_MCU_CFG1               0x0144
+#define AFE_IRQ1_MCU_CFG0               0x0148
+#define AFE_IRQ1_MCU_CFG1               0x014c
+#define AFE_IRQ2_MCU_CFG0               0x0150
+#define AFE_IRQ2_MCU_CFG1               0x0154
+#define ETDM_IN5_CON0                   0x13f0
+#define ETDM_IN5_CON1                   0x13f4
+#define ETDM_IN5_CON2                   0x13f8
+#define ETDM_IN5_CON3                   0x13fc
+#define ETDM_IN5_CON4                   0x1400
+#define ETDM_OUT5_CON0                  0x1570
+#define ETDM_OUT5_CON4                  0x1580
+#define ETDM_OUT5_CON5                  0x1584
+#define ETDM_4_7_COWORK_CON0            0x15e0
+#define ETDM_4_7_COWORK_CON1            0x15e4
+#define AFE_CONN018_1                   0x1b44
+#define AFE_CONN018_4                   0x1b50
+#define AFE_CONN019_1                   0x1b64
+#define AFE_CONN019_4                   0x1b70
+#define AFE_CONN124_1                   0x2884
+#define AFE_CONN124_4                   0x2890
+#define AFE_CONN125_1                   0x28a4
+#define AFE_CONN125_4                   0x28b0
+#define AFE_CONN_RS_0                   0x3920
+#define AFE_CONN_RS_3                   0x392c
+#define AFE_CONN_16BIT_0                0x3960
+#define AFE_CONN_16BIT_3                0x396c
+#define AFE_CONN_24BIT_0                0x3980
+#define AFE_CONN_24BIT_3                0x398c
+#define AFE_MEMIF_CON0                  0x3d98
+#define AFE_MEMIF_RD_MON                0x3da0
+#define AFE_MEMIF_WR_MON                0x3da4
+#define AFE_DL0_BASE_MSB                0x3e40
+#define AFE_DL0_BASE                    0x3e44
+#define AFE_DL0_CUR_MSB                 0x3e48
+#define AFE_DL0_CUR                     0x3e4c
+#define AFE_DL0_END_MSB                 0x3e50
+#define AFE_DL0_END                     0x3e54
+#define AFE_DL0_RCH_MON                 0x3e58
+#define AFE_DL0_LCH_MON                 0x3e5c
+#define AFE_DL0_CON0                    0x3e60
+#define AFE_VUL0_BASE_MSB               0x4220
+#define AFE_VUL0_BASE                   0x4224
+#define AFE_VUL0_CUR_MSB                0x4228
+#define AFE_VUL0_CUR                    0x422c
+#define AFE_VUL0_END_MSB                0x4230
+#define AFE_VUL0_END                    0x4234
+#define AFE_VUL0_CON0                   0x4238
+
+#define AFE_MAX_REGISTER AFE_VUL0_CON0
+#define AFE_IRQ_STATUS_BITS             0x7
+#define AFE_IRQ_CNT_SHIFT               0
+#define AFE_IRQ_CNT_MASK	        0xffffff
+
+/* AUDIO_TOP_CON2 */
+#define CLK_OUT5_PDN                    BIT(14)
+#define CLK_OUT5_PDN_MASK               BIT(14)
+#define CLK_IN5_PDN                     BIT(7)
+#define CLK_IN5_PDN_MASK                BIT(7)
+
+/* AUDIO_TOP_CON4 */
+#define PDN_APLL_TUNER2                 BIT(12)
+#define PDN_APLL_TUNER2_MASK            BIT(12)
+
+/* AUDIO_ENGEN_CON0 */
+#define AUD_APLL2_EN                    BIT(3)
+#define AUD_APLL2_EN_MASK               BIT(3)
+#define AUD_26M_EN                      BIT(0)
+#define AUD_26M_EN_MASK                 BIT(0)
+
+/* AFE_DL0_CON0 */
+#define DL0_ON_SFT                      28
+#define DL0_ON_MASK                     0x1
+#define DL0_ON_MASK_SFT                 BIT(28)
+#define DL0_MINLEN_SFT                  20
+#define DL0_MINLEN_MASK                 0xf
+#define DL0_MINLEN_MASK_SFT             (0xf << 20)
+#define DL0_MODE_SFT                    8
+#define DL0_MODE_MASK                   0x1f
+#define DL0_MODE_MASK_SFT               (0x1f << 8)
+#define DL0_PBUF_SIZE_SFT               5
+#define DL0_PBUF_SIZE_MASK              0x3
+#define DL0_PBUF_SIZE_MASK_SFT          (0x3 << 5)
+#define DL0_MONO_SFT                    4
+#define DL0_MONO_MASK                   0x1
+#define DL0_MONO_MASK_SFT               BIT(4)
+#define DL0_HALIGN_SFT                  2
+#define DL0_HALIGN_MASK                 0x1
+#define DL0_HALIGN_MASK_SFT             BIT(2)
+#define DL0_HD_MODE_SFT                 0
+#define DL0_HD_MODE_MASK                0x3
+#define DL0_HD_MODE_MASK_SFT            (0x3 << 0)
+
+/* AFE_VUL0_CON0 */
+#define VUL0_ON_SFT                     28
+#define VUL0_ON_MASK                    0x1
+#define VUL0_ON_MASK_SFT                BIT(28)
+#define VUL0_MODE_SFT                   8
+#define VUL0_MODE_MASK                  0x1f
+#define VUL0_MODE_MASK_SFT              (0x1f << 8)
+#define VUL0_MONO_SFT                   4
+#define VUL0_MONO_MASK                  0x1
+#define VUL0_MONO_MASK_SFT              BIT(4)
+#define VUL0_HALIGN_SFT                 2
+#define VUL0_HALIGN_MASK                0x1
+#define VUL0_HALIGN_MASK_SFT            BIT(2)
+#define VUL0_HD_MODE_SFT                0
+#define VUL0_HD_MODE_MASK               0x3
+#define VUL0_HD_MODE_MASK_SFT           (0x3 << 0)
+
+/* AFE_IRQ_MCU_CON */
+#define IRQ_MCU_MODE_SFT                4
+#define IRQ_MCU_MODE_MASK               0x1f
+#define IRQ_MCU_MODE_MASK_SFT           (0x1f << 4)
+#define IRQ_MCU_ON_SFT                  0
+#define IRQ_MCU_ON_MASK                 0x1
+#define IRQ_MCU_ON_MASK_SFT             BIT(0)
+#define IRQ0_MCU_CLR_SFT                0
+#define IRQ0_MCU_CLR_MASK               0x1
+#define IRQ0_MCU_CLR_MASK_SFT           BIT(0)
+#define IRQ1_MCU_CLR_SFT                1
+#define IRQ1_MCU_CLR_MASK               0x1
+#define IRQ1_MCU_CLR_MASK_SFT           BIT(1)
+#define IRQ2_MCU_CLR_SFT                2
+#define IRQ2_MCU_CLR_MASK               0x1
+#define IRQ2_MCU_CLR_MASK_SFT           BIT(2)
+
+/* ETDM_IN5_CON2 */
+#define IN_CLK_SRC(x)                   ((x) << 10)
+#define IN_CLK_SRC_SFT                  10
+#define IN_CLK_SRC_MASK                 GENMASK(12, 10)
+
+/* ETDM_IN5_CON3 */
+#define IN_SEL_FS(x)                    ((x) << 26)
+#define IN_SEL_FS_SFT                   26
+#define IN_SEL_FS_MASK                  GENMASK(30, 26)
+
+/* ETDM_IN5_CON4 */
+#define IN_RELATCH(x)                   ((x) << 20)
+#define IN_RELATCH_SFT                  20
+#define IN_RELATCH_MASK                 GENMASK(24, 20)
+#define IN_CLK_INV                      BIT(18)
+#define IN_CLK_INV_MASK                 BIT(18)
+
+/* ETDM_IN5_CON0 & ETDM_OUT5_CON0 */
+#define RELATCH_SRC(x)                  ((x) << 28)
+#define RELATCH_SRC_SFT                 28
+#define RELATCH_SRC_MASK                GENMASK(30, 28)
+#define ETDM_CH_NUM(x)                  (((x) - 1) << 23)
+#define ETDM_CH_NUM_SFT                 23
+#define ETDM_CH_NUM_MASK                GENMASK(27, 23)
+#define ETDM_WRD_LEN(x)                 (((x) - 1) << 16)
+#define ETDM_WRD_LEN_SFT                16
+#define ETDM_WRD_LEN_MASK               GENMASK(20, 16)
+#define ETDM_BIT_LEN(x)                 (((x) - 1) << 11)
+#define ETDM_BIT_LEN_SFT                11
+#define ETDM_BIT_LEN_MASK               GENMASK(15, 11)
+#define ETDM_FMT(x)                     ((x) << 6)
+#define ETDM_FMT_SFT                    6
+#define ETDM_FMT_MASK                   GENMASK(8, 6)
+#define ETDM_SYNC                       BIT(1)
+#define ETDM_SYNC_MASK                  BIT(1)
+#define ETDM_EN                         BIT(0)
+#define ETDM_EN_MASK                    BIT(0)
+
+/* ETDM_OUT5_CON4 */
+#define OUT_RELATCH(x)                  ((x) << 24)
+#define OUT_RELATCH_SFT                 24
+#define OUT_RELATCH_MASK                GENMASK(28, 24)
+#define OUT_CLK_SRC(x)                  ((x) << 6)
+#define OUT_CLK_SRC_SFT                 6
+#define OUT_CLK_SRC_MASK                GENMASK(8, 6)
+#define OUT_SEL_FS(x)                   ((x) << 0)
+#define OUT_SEL_FS_SFT                  0
+#define OUT_SEL_FS_MASK                 GENMASK(4, 0)
+
+/* ETDM_OUT5_CON5 */
+#define ETDM_CLK_DIV                    BIT(12)
+#define ETDM_CLK_DIV_MASK               BIT(12)
+#define OUT_CLK_INV                     BIT(9)
+#define OUT_CLK_INV_MASK                BIT(9)
+
+/* ETDM_4_7_COWORK_CON0 */
+#define OUT_SEL(x)                      ((x) << 12)
+#define OUT_SEL_SFT                     12
+#define OUT_SEL_MASK                    GENMASK(15, 12)
+#endif
-- 
2.18.0

