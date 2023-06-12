Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DC372C268
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 13:05:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbjFLLFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 07:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238842AbjFLLFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 07:05:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1097A24E;
        Mon, 12 Jun 2023 03:53:35 -0700 (PDT)
X-UUID: 5d92964e090f11eeb20a276fd37b9834-20230612
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=BgarHxns2Qzd3950VexAn5nS3mSkft96ZC3ZvkYecA0=;
        b=c1kWt8bnBBAoj+VG7r7Joa38/7ssCo/2qnQazPbZU1E1AgodDcW/srpxxgbHLsFqGB7bwHCWuUxyicV4+wbeJB9my4VEIZa1um26yGz53ylnbxs8q79t1VRBdbLalTGgV+jL1+4SojTlL96eezbygRBJd3wJd4dakpwQScdq5c4=;
X-CID-CACHE: Type:Local,Time:202306121844+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:82090e57-c2c8-4947-ab05-c7a1f57270dc,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:cb9a4e1,CLOUDID:f37b293e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 5d92964e090f11eeb20a276fd37b9834-20230612
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <maso.huang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 342511137; Mon, 12 Jun 2023 18:53:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 12 Jun 2023 18:53:28 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 12 Jun 2023 18:53:28 +0800
From:   Maso Hunag <maso.huang@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Trevor Wu <trevor.wu@mediatek.com>,
        Jiaxin Yu <jiaxin.yu@mediatek.com>,
        Ren Zhijie <renzhijie2@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
CC:     Maso Huang <maso.huang@mediatek.com>
Subject: [PATCH 1/7] ASoC: mediatek: mt79xx: add common header
Date:   Mon, 12 Jun 2023 18:52:44 +0800
Message-ID: <20230612105250.15441-2-maso.huang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230612105250.15441-1-maso.huang@mediatek.com>
References: <20230612105250.15441-1-maso.huang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maso Huang <maso.huang@mediatek.com>

Add header files for register definition and structure.

Signed-off-by: Maso Huang <maso.huang@mediatek.com>
---
 sound/soc/mediatek/mt79xx/mt79xx-afe-common.h |  49 +++++
 sound/soc/mediatek/mt79xx/mt79xx-reg.h        | 206 ++++++++++++++++++
 2 files changed, 255 insertions(+)
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
 create mode 100644 sound/soc/mediatek/mt79xx/mt79xx-reg.h

diff --git a/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h b/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
new file mode 100644
index 000000000000..13c9e51d7b38
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-afe-common.h
@@ -0,0 +1,49 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt79xx-afe-common.h  --  MediaTek 79xx audio driver definitions
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT_79XX_AFE_COMMON_H_
+#define _MT_79XX_AFE_COMMON_H_
+
+#include <sound/soc.h>
+#include <linux/list.h>
+#include <linux/regmap.h>
+#include "../common/mtk-base-afe.h"
+
+enum {
+	MT79XX_MEMIF_DL1,
+	MT79XX_MEMIF_VUL12,
+	MT79XX_MEMIF_NUM,
+	MT79XX_DAI_ETDM = MT79XX_MEMIF_NUM,
+	MT79XX_DAI_NUM,
+};
+
+enum {
+	MT79XX_IRQ_0,
+	MT79XX_IRQ_1,
+	MT79XX_IRQ_2,
+	MT79XX_IRQ_NUM,
+};
+
+struct clk;
+
+struct mt79xx_afe_private {
+	struct clk **clk;
+
+	int pm_runtime_bypass_reg_ctl;
+
+	/* dai */
+	void *dai_priv[MT79XX_DAI_NUM];
+};
+
+unsigned int mt79xx_afe_rate_transform(struct device *dev,
+				       unsigned int rate);
+
+/* dai register */
+int mt79xx_dai_etdm_register(struct mtk_base_afe *afe);
+#endif
diff --git a/sound/soc/mediatek/mt79xx/mt79xx-reg.h b/sound/soc/mediatek/mt79xx/mt79xx-reg.h
new file mode 100644
index 000000000000..28c0aeba9bdf
--- /dev/null
+++ b/sound/soc/mediatek/mt79xx/mt79xx-reg.h
@@ -0,0 +1,206 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * mt79xx-reg.h  --  MediaTek 79xx audio driver reg definition
+ *
+ * Copyright (c) 2021 MediaTek Inc.
+ * Author: Vic Wu <vic.wu@mediatek.com>
+ *         Maso Huang <maso.huang@mediatek.com>
+ */
+
+#ifndef _MT79XX_REG_H_
+#define _MT79XX_REG_H_
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

