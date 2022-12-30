Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBC365952C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 06:55:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiL3Fzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 00:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbiL3FzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 00:55:03 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8115418381;
        Thu, 29 Dec 2022 21:54:59 -0800 (PST)
X-UUID: cb5fd4b943214e1588b7980b3dcf8046-20221230
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=++zVTriA/mMkt0v3+36ev1Ksb/TKezyurkseBzX7V3I=;
        b=PTFkNsnh1xHac3ykAgFBanjY33DsMrvRfV6LYRHM1lE6+gfuaK3tVuvVrL7MUF/w713LOjB/UwrD0/14gNKxcAIyOEaaILoIybLOKlg/vdlpHLfLdmdLWDiPezLubb8Zg7HJYBacaDsQmGJBjUgHPKg5jSWQONRmzR8IpXnTAOw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.16,REQID:551793d9-346d-484b-824e-62d34be33a61,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:09771b1,CLOUDID:3333d18a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0
X-CID-BVR: 0,NGT
X-UUID: cb5fd4b943214e1588b7980b3dcf8046-20221230
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 434454763; Fri, 30 Dec 2022 13:54:51 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 30 Dec 2022 13:54:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 30 Dec 2022 13:54:50 +0800
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <matthias.bgg@gmail.com>,
        <p.zabel@pengutronix.de>
CC:     <trevor.wu@mediatek.com>,
        <angelogioacchino.delregno@collabora.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 12/13] ASoC: mediatek: mt8188: add machine driver with mt6359
Date:   Fri, 30 Dec 2022 13:54:42 +0800
Message-ID: <20221230055443.16024-13-trevor.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221230055443.16024-1-trevor.wu@mediatek.com>
References: <20221230055443.16024-1-trevor.wu@mediatek.com>
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

Add support for mt8188 board with mt6359.

Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 sound/soc/mediatek/Kconfig                |  11 +
 sound/soc/mediatek/mt8188/Makefile        |   3 +
 sound/soc/mediatek/mt8188/mt8188-mt6359.c | 785 ++++++++++++++++++++++
 3 files changed, 799 insertions(+)
 create mode 100644 sound/soc/mediatek/mt8188/mt8188-mt6359.c

diff --git a/sound/soc/mediatek/Kconfig b/sound/soc/mediatek/Kconfig
index 799894e6dc3e..6eaa4991d99a 100644
--- a/sound/soc/mediatek/Kconfig
+++ b/sound/soc/mediatek/Kconfig
@@ -218,6 +218,17 @@ config SND_SOC_MT8188
 	  Select Y if you have such device.
 	  If unsure select "N".
 
+config SND_SOC_MT8188_MT6359
+	tristate "ASoC Audio driver for MT8188 with MT6359 and I2S codecs"
+	depends on SND_SOC_MT8188 && MTK_PMIC_WRAP
+	select SND_SOC_MT6359
+	select SND_SOC_HDMI_CODEC
+	help
+	  This adds support for ASoC machine driver for MediaTek MT8188
+	  boards with the MT6359 and other I2S audio codecs.
+	  Select Y if you have such device.
+	  If unsure select "N".
+
 config SND_SOC_MT8192
 	tristate "ASoC support for Mediatek MT8192 chip"
 	depends on ARCH_MEDIATEK
diff --git a/sound/soc/mediatek/mt8188/Makefile b/sound/soc/mediatek/mt8188/Makefile
index fa5d383c5e47..781e61cbb22b 100644
--- a/sound/soc/mediatek/mt8188/Makefile
+++ b/sound/soc/mediatek/mt8188/Makefile
@@ -10,3 +10,6 @@ snd-soc-mt8188-afe-objs := \
 	mt8188-dai-pcm.o
 
 obj-$(CONFIG_SND_SOC_MT8188) += snd-soc-mt8188-afe.o
+
+# machine driver
+obj-$(CONFIG_SND_SOC_MT8188_MT6359) += mt8188-mt6359.o
diff --git a/sound/soc/mediatek/mt8188/mt8188-mt6359.c b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
new file mode 100644
index 000000000000..919d74ea1934
--- /dev/null
+++ b/sound/soc/mediatek/mt8188/mt8188-mt6359.c
@@ -0,0 +1,785 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mt8188-mt6359.c  --  MT8188-MT6359 ALSA SoC machine driver
+ *
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Trevor Wu <trevor.wu@mediatek.com>
+ */
+
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/pm_runtime.h>
+#include <sound/jack.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include "mt8188-afe-common.h"
+#include "../../codecs/mt6359.h"
+#include "../common/mtk-afe-platform-driver.h"
+#include "../common/mtk-soundcard-driver.h"
+
+/* FE */
+SND_SOC_DAILINK_DEFS(playback2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback7,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL7")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback8,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback10,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL10")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(playback11,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DL11")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture2,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL2")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture3,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL3")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture4,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL4")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture5,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL5")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture6,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL6")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture8,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL8")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture9,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL9")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(capture10,
+		     DAILINK_COMP_ARRAY(COMP_CPU("UL10")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+/* BE */
+SND_SOC_DAILINK_DEFS(adda,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ADDA")),
+		     DAILINK_COMP_ARRAY(COMP_CODEC("mt6359-sound",
+						   "mt6359-snd-codec-aif1")),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(dptx,
+		     DAILINK_COMP_ARRAY(COMP_CPU("DPTX")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(etdm1_in,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_IN")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(etdm2_in,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_IN")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(etdm1_out,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM1_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(etdm2_out,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM2_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(etdm3_out,
+		     DAILINK_COMP_ARRAY(COMP_CPU("ETDM3_OUT")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+SND_SOC_DAILINK_DEFS(pcm1,
+		     DAILINK_COMP_ARRAY(COMP_CPU("PCM1")),
+		     DAILINK_COMP_ARRAY(COMP_DUMMY()),
+		     DAILINK_COMP_ARRAY(COMP_EMPTY()));
+
+struct mt8188_mt6359_priv {
+	struct snd_soc_jack dp_jack;
+	struct snd_soc_jack hdmi_jack;
+};
+
+struct mt8188_card_data {
+	const char *name;
+	unsigned long quirk;
+};
+
+static const struct snd_soc_dapm_widget mt8188_mt6359_widgets[] = {
+	SND_SOC_DAPM_HP("Headphone", NULL),
+	SND_SOC_DAPM_MIC("Headset Mic", NULL),
+};
+
+static const struct snd_kcontrol_new mt8188_mt6359_controls[] = {
+	SOC_DAPM_PIN_SWITCH("Headphone"),
+	SOC_DAPM_PIN_SWITCH("Headset Mic"),
+};
+
+#define CKSYS_AUD_TOP_CFG 0x032c
+#define CKSYS_AUD_TOP_MON 0x0330
+
+static int mt8188_mt6359_mtkaif_calibration(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_afe =
+		snd_soc_rtdcom_lookup(rtd, AFE_PCM_NAME);
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+	struct mtk_base_afe *afe;
+	struct mt8188_afe_private *afe_priv;
+	struct mtkaif_param *param;
+	int chosen_phase_1, chosen_phase_2;
+	int prev_cycle_1, prev_cycle_2;
+	int test_done_1, test_done_2;
+	int cycle_1, cycle_2;
+	int mtkaif_chosen_phase[MT8188_MTKAIF_MISO_NUM];
+	int mtkaif_phase_cycle[MT8188_MTKAIF_MISO_NUM];
+	int mtkaif_calibration_num_phase;
+	bool mtkaif_calibration_ok;
+	unsigned int monitor = 0;
+	int counter;
+	int phase;
+	int i;
+
+	if (!cmpnt_afe)
+		return -EINVAL;
+
+	afe = snd_soc_component_get_drvdata(cmpnt_afe);
+	afe_priv = afe->platform_priv;
+	param = &afe_priv->mtkaif_params;
+
+	dev_dbg(afe->dev, "%s(), start\n", __func__);
+
+	param->mtkaif_calibration_ok = false;
+	for (i = 0; i < MT8188_MTKAIF_MISO_NUM; i++) {
+		param->mtkaif_chosen_phase[i] = -1;
+		param->mtkaif_phase_cycle[i] = 0;
+		mtkaif_chosen_phase[i] = -1;
+		mtkaif_phase_cycle[i] = 0;
+	}
+
+	if (IS_ERR(afe_priv->topckgen)) {
+		dev_info(afe->dev, "%s() Cannot find topckgen controller\n",
+			 __func__);
+		return 0;
+	}
+
+	pm_runtime_get_sync(afe->dev);
+	mt6359_mtkaif_calibration_enable(cmpnt_codec);
+
+	/* set test type to synchronizer pulse */
+	regmap_update_bits(afe_priv->topckgen,
+			   CKSYS_AUD_TOP_CFG, 0xffff, 0x4);
+	mtkaif_calibration_num_phase = 42;	/* mt6359: 0 ~ 42 */
+	mtkaif_calibration_ok = true;
+
+	for (phase = 0;
+	     phase <= mtkaif_calibration_num_phase && mtkaif_calibration_ok;
+	     phase++) {
+		mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
+						    phase, phase, phase);
+
+		regmap_set_bits(afe_priv->topckgen, CKSYS_AUD_TOP_CFG, 0x1);
+
+		test_done_1 = 0;
+		test_done_2 = 0;
+
+		cycle_1 = -1;
+		cycle_2 = -1;
+
+		counter = 0;
+		while (!(test_done_1 & test_done_2)) {
+			regmap_read(afe_priv->topckgen,
+				    CKSYS_AUD_TOP_MON, &monitor);
+			test_done_1 = (monitor >> 28) & 0x1;
+			test_done_2 = (monitor >> 29) & 0x1;
+
+			if (test_done_1 == 1)
+				cycle_1 = monitor & 0xf;
+
+			if (test_done_2 == 1)
+				cycle_2 = (monitor >> 4) & 0xf;
+
+			/* handle if never test done */
+			if (++counter > 10000) {
+				dev_info(afe->dev, "%s(), test fail, cycle_1 %d, cycle_2 %d, monitor 0x%x\n",
+					 __func__,
+					 cycle_1, cycle_2, monitor);
+				mtkaif_calibration_ok = false;
+				break;
+			}
+		}
+
+		if (phase == 0) {
+			prev_cycle_1 = cycle_1;
+			prev_cycle_2 = cycle_2;
+		}
+
+		if (cycle_1 != prev_cycle_1 &&
+		    mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] < 0) {
+			mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] = phase - 1;
+			mtkaif_phase_cycle[MT8188_MTKAIF_MISO_0] = prev_cycle_1;
+		}
+
+		if (cycle_2 != prev_cycle_2 &&
+		    mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] < 0) {
+			mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] = phase - 1;
+			mtkaif_phase_cycle[MT8188_MTKAIF_MISO_1] = prev_cycle_2;
+		}
+
+		regmap_clear_bits(afe_priv->topckgen, CKSYS_AUD_TOP_CFG, 0x1);
+
+		if (mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] >= 0 &&
+		    mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] >= 0)
+			break;
+	}
+
+	if (mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] < 0) {
+		mtkaif_calibration_ok = false;
+		chosen_phase_1 = 0;
+	} else {
+		chosen_phase_1 = mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0];
+	}
+
+	if (mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] < 0) {
+		mtkaif_calibration_ok = false;
+		chosen_phase_2 = 0;
+	} else {
+		chosen_phase_2 = mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1];
+	}
+
+	mt6359_set_mtkaif_calibration_phase(cmpnt_codec,
+					    chosen_phase_1,
+					    chosen_phase_2,
+					    0);
+
+	mt6359_mtkaif_calibration_disable(cmpnt_codec);
+	pm_runtime_put(afe->dev);
+
+	param->mtkaif_calibration_ok = mtkaif_calibration_ok;
+	param->mtkaif_chosen_phase[MT8188_MTKAIF_MISO_0] = chosen_phase_1;
+	param->mtkaif_chosen_phase[MT8188_MTKAIF_MISO_1] = chosen_phase_2;
+
+	for (i = 0; i < MT8188_MTKAIF_MISO_NUM; i++)
+		param->mtkaif_phase_cycle[i] = mtkaif_phase_cycle[i];
+
+	dev_info(afe->dev, "%s(), end, calibration ok %d\n",
+		 __func__, param->mtkaif_calibration_ok);
+
+	return 0;
+}
+
+static int mt8188_mt6359_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct snd_soc_component *cmpnt_codec =
+		asoc_rtd_to_codec(rtd, 0)->component;
+
+	/* set mtkaif protocol */
+	mt6359_set_mtkaif_protocol(cmpnt_codec,
+				   MT6359_MTKAIF_PROTOCOL_2_CLK_P2);
+
+	/* mtkaif calibration */
+	mt8188_mt6359_mtkaif_calibration(rtd);
+
+	return 0;
+}
+
+enum {
+	DAI_LINK_DL2_FE,
+	DAI_LINK_DL3_FE,
+	DAI_LINK_DL6_FE,
+	DAI_LINK_DL7_FE,
+	DAI_LINK_DL8_FE,
+	DAI_LINK_DL10_FE,
+	DAI_LINK_DL11_FE,
+	DAI_LINK_UL1_FE,
+	DAI_LINK_UL2_FE,
+	DAI_LINK_UL3_FE,
+	DAI_LINK_UL4_FE,
+	DAI_LINK_UL5_FE,
+	DAI_LINK_UL6_FE,
+	DAI_LINK_UL8_FE,
+	DAI_LINK_UL9_FE,
+	DAI_LINK_UL10_FE,
+	DAI_LINK_ADDA_BE,
+	DAI_LINK_DPTX_BE,
+	DAI_LINK_ETDM1_IN_BE,
+	DAI_LINK_ETDM2_IN_BE,
+	DAI_LINK_ETDM1_OUT_BE,
+	DAI_LINK_ETDM2_OUT_BE,
+	DAI_LINK_ETDM3_OUT_BE,
+	DAI_LINK_PCM1_BE,
+};
+
+static int mt8188_dptx_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *params)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	unsigned int rate = params_rate(params);
+	unsigned int mclk_fs_ratio = 256;
+	unsigned int mclk_fs = rate * mclk_fs_ratio;
+	struct snd_soc_dai *dai = asoc_rtd_to_cpu(rtd, 0);
+
+	return snd_soc_dai_set_sysclk(dai, 0, mclk_fs, SND_SOC_CLOCK_OUT);
+}
+
+static const struct snd_soc_ops mt8188_dptx_ops = {
+	.hw_params = mt8188_dptx_hw_params,
+};
+
+static int mt8188_dptx_hw_params_fixup(struct snd_soc_pcm_runtime *rtd,
+				       struct snd_pcm_hw_params *params)
+{
+	/* fix BE i2s format to 32bit, clean param mask first */
+	snd_mask_reset_range(hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT),
+			     0, (__force unsigned int)SNDRV_PCM_FORMAT_LAST);
+
+	params_set_format(params, SNDRV_PCM_FORMAT_S32_LE);
+
+	return 0;
+}
+
+static int mt8188_hdmi_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8188_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	int ret = 0;
+
+	ret = snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_JACK_LINEOUT,
+				    &priv->hdmi_jack);
+	if (ret) {
+		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_set_jack(component, &priv->hdmi_jack, NULL);
+	if (ret)
+		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			 __func__, component->name, ret);
+
+	return ret;
+}
+
+static int mt8188_dptx_codec_init(struct snd_soc_pcm_runtime *rtd)
+{
+	struct mt8188_mt6359_priv *priv = snd_soc_card_get_drvdata(rtd->card);
+	struct snd_soc_component *component = asoc_rtd_to_codec(rtd, 0)->component;
+	int ret = 0;
+
+	ret = snd_soc_card_jack_new(rtd->card, "DP Jack", SND_JACK_LINEOUT,
+				    &priv->dp_jack);
+	if (ret) {
+		dev_info(rtd->dev, "%s, new jack failed: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = snd_soc_component_set_jack(component, &priv->dp_jack, NULL);
+	if (ret)
+		dev_info(rtd->dev, "%s, set jack failed on %s (ret=%d)\n",
+			 __func__, component->name, ret);
+
+	return ret;
+}
+
+static struct snd_soc_dai_link mt8188_mt6359_dai_links[] = {
+	/* FE */
+	[DAI_LINK_DL2_FE] = {
+		.name = "DL2_FE",
+		.stream_name = "DL2 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback2),
+	},
+	[DAI_LINK_DL3_FE] = {
+		.name = "DL3_FE",
+		.stream_name = "DL3 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback3),
+	},
+	[DAI_LINK_DL6_FE] = {
+		.name = "DL6_FE",
+		.stream_name = "DL6 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback6),
+	},
+	[DAI_LINK_DL7_FE] = {
+		.name = "DL7_FE",
+		.stream_name = "DL7 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback7),
+	},
+	[DAI_LINK_DL8_FE] = {
+		.name = "DL8_FE",
+		.stream_name = "DL8 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback8),
+	},
+	[DAI_LINK_DL10_FE] = {
+		.name = "DL10_FE",
+		.stream_name = "DL10 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback10),
+	},
+	[DAI_LINK_DL11_FE] = {
+		.name = "DL11_FE",
+		.stream_name = "DL11 Playback",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(playback11),
+	},
+	[DAI_LINK_UL1_FE] = {
+		.name = "UL1_FE",
+		.stream_name = "UL1 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture1),
+	},
+	[DAI_LINK_UL2_FE] = {
+		.name = "UL2_FE",
+		.stream_name = "UL2 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture2),
+	},
+	[DAI_LINK_UL3_FE] = {
+		.name = "UL3_FE",
+		.stream_name = "UL3 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture3),
+	},
+	[DAI_LINK_UL4_FE] = {
+		.name = "UL4_FE",
+		.stream_name = "UL4 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture4),
+	},
+	[DAI_LINK_UL5_FE] = {
+		.name = "UL5_FE",
+		.stream_name = "UL5 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture5),
+	},
+	[DAI_LINK_UL6_FE] = {
+		.name = "UL6_FE",
+		.stream_name = "UL6 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_PRE,
+			SND_SOC_DPCM_TRIGGER_PRE,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture6),
+	},
+	[DAI_LINK_UL8_FE] = {
+		.name = "UL8_FE",
+		.stream_name = "UL8 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture8),
+	},
+	[DAI_LINK_UL9_FE] = {
+		.name = "UL9_FE",
+		.stream_name = "UL9 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture9),
+	},
+	[DAI_LINK_UL10_FE] = {
+		.name = "UL10_FE",
+		.stream_name = "UL10 Capture",
+		.trigger = {
+			SND_SOC_DPCM_TRIGGER_POST,
+			SND_SOC_DPCM_TRIGGER_POST,
+		},
+		.dynamic = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(capture10),
+	},
+	/* BE */
+	[DAI_LINK_ADDA_BE] = {
+		.name = "ADDA_BE",
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		.init = mt8188_mt6359_init,
+		SND_SOC_DAILINK_REG(adda),
+	},
+	[DAI_LINK_DPTX_BE] = {
+		.name = "DPTX_BE",
+		.ops = &mt8188_dptx_ops,
+		.be_hw_params_fixup = mt8188_dptx_hw_params_fixup,
+		.no_pcm = 1,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(dptx),
+	},
+	[DAI_LINK_ETDM1_IN_BE] = {
+		.name = "ETDM1_IN_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBP_CFP,
+		.dpcm_capture = 1,
+		.ignore_suspend = 1,
+		SND_SOC_DAILINK_REG(etdm1_in),
+	},
+	[DAI_LINK_ETDM2_IN_BE] = {
+		.name = "ETDM2_IN_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBP_CFP,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(etdm2_in),
+	},
+	[DAI_LINK_ETDM1_OUT_BE] = {
+		.name = "ETDM1_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(etdm1_out),
+	},
+	[DAI_LINK_ETDM2_OUT_BE] = {
+		.name = "ETDM2_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(etdm2_out),
+	},
+	[DAI_LINK_ETDM3_OUT_BE] = {
+		.name = "ETDM3_OUT_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		SND_SOC_DAILINK_REG(etdm3_out),
+	},
+	[DAI_LINK_PCM1_BE] = {
+		.name = "PCM1_BE",
+		.no_pcm = 1,
+		.dai_fmt = SND_SOC_DAIFMT_I2S |
+			SND_SOC_DAIFMT_NB_NF |
+			SND_SOC_DAIFMT_CBC_CFC,
+		.dpcm_playback = 1,
+		.dpcm_capture = 1,
+		SND_SOC_DAILINK_REG(pcm1),
+	},
+};
+
+static struct snd_soc_card mt8188_mt6359_soc_card = {
+	.owner = THIS_MODULE,
+	.dai_link = mt8188_mt6359_dai_links,
+	.num_links = ARRAY_SIZE(mt8188_mt6359_dai_links),
+	.dapm_widgets = mt8188_mt6359_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(mt8188_mt6359_widgets),
+	.controls = mt8188_mt6359_controls,
+	.num_controls = ARRAY_SIZE(mt8188_mt6359_controls),
+};
+
+static int mt8188_mt6359_dev_probe(struct platform_device *pdev)
+{
+	struct snd_soc_card *card = &mt8188_mt6359_soc_card;
+	struct device_node *platform_node;
+	struct mt8188_mt6359_priv *priv;
+	struct mt8188_card_data *card_data;
+	struct snd_soc_dai_link *dai_link;
+	int ret, i;
+
+	card_data = (struct mt8188_card_data *)of_device_get_match_data(&pdev->dev);
+	card->dev = &pdev->dev;
+
+	ret = snd_soc_of_parse_card_name(card, "model");
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "%s new card name parsing error\n",
+				     __func__);
+
+	if (!card->name)
+		card->name = card_data->name;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return  -ENOMEM;
+
+	if (of_property_read_bool(pdev->dev.of_node, "audio-routing")) {
+		ret = snd_soc_of_parse_audio_routing(card, "audio-routing");
+		if (ret)
+			return ret;
+	}
+
+	platform_node = of_parse_phandle(pdev->dev.of_node,
+					 "mediatek,platform", 0);
+	if (!platform_node) {
+		ret = -EINVAL;
+		return dev_err_probe(&pdev->dev, ret, "Property 'platform' missing or invalid\n");
+	}
+
+	ret = parse_dai_link_info(card);
+	if (ret)
+		goto err;
+
+	for_each_card_prelinks(card, i, dai_link) {
+		if (!dai_link->platforms->name)
+			dai_link->platforms->of_node = platform_node;
+
+		if (strcmp(dai_link->name, "DPTX_BE") == 0) {
+			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8188_dptx_codec_init;
+		} else if (strcmp(dai_link->name, "ETDM3_OUT_BE") == 0) {
+			if (strcmp(dai_link->codecs->dai_name, "snd-soc-dummy-dai"))
+				dai_link->init = mt8188_hdmi_codec_init;
+		}
+	}
+
+	snd_soc_card_set_drvdata(card, priv);
+
+	ret = devm_snd_soc_register_card(&pdev->dev, card);
+	if (ret)
+		dev_err_probe(&pdev->dev, ret, "%s snd_soc_register_card fail\n",
+			      __func__);
+err:
+	of_node_put(platform_node);
+	clean_card_reference(card);
+	return ret;
+}
+
+static struct mt8188_card_data mt8188_evb_card = {
+	.name = "mt8188_mt6359",
+};
+
+static const struct of_device_id mt8188_mt6359_dt_match[] = {
+	{
+		.compatible = "mediatek,mt8188-mt6359-evb",
+		.data = &mt8188_evb_card,
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, mt8188_mt6359_dt_match);
+
+static struct platform_driver mt8188_mt6359_driver = {
+	.driver = {
+		.name = "mt8188_mt6359",
+		.of_match_table = mt8188_mt6359_dt_match,
+		.pm = &snd_soc_pm_ops,
+	},
+	.probe = mt8188_mt6359_dev_probe,
+};
+
+module_platform_driver(mt8188_mt6359_driver);
+
+/* Module information */
+MODULE_DESCRIPTION("MT8188-MT6359 ALSA SoC machine driver");
+MODULE_AUTHOR("Trevor Wu <trevor.wu@mediatek.com>");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("mt8188 mt6359 soc card");
-- 
2.18.0

