Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628DF6561A5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Dec 2022 10:44:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbiLZJoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Dec 2022 04:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiLZJnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Dec 2022 04:43:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7F92BC6;
        Mon, 26 Dec 2022 01:43:01 -0800 (PST)
X-UUID: 6b3d8e50cb064e099566a24ef5e590ae-20221226
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=CRIPLnz3sU+O7fa5cTPEYIkA+5QeBpoeurMOnstPztM=;
        b=Co9JHDIeF7mvVkZ1yaybg1jn7VNY/hD2Pg54XKoOQZhRjpbmUWlxSjInyivuex3BX0PnX3h/0SSTbzdxVqgqM1k0qJ3V5Wc8xVCId7ceWMQCQmw57uCMjgcsPGXu90rydMBKuSqehft/rorrka8lvDgWTCFdtEsmj2pXND+tAsI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:f6fb174f-3728-486b-a4a6-201e455858d5,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:90
X-CID-INFO: VERSION:1.1.14,REQID:f6fb174f-3728-486b-a4a6-201e455858d5,IP:0,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTIO
        N:quarantine,TS:90
X-CID-META: VersionHash:dcaaed0,CLOUDID:e4166a8a-8530-4eff-9f77-222cf6e2895b,B
        ulkID:221226174253JTUY3JFQ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 6b3d8e50cb064e099566a24ef5e590ae-20221226
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <roger.lu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1332186330; Mon, 26 Dec 2022 17:42:50 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Mon, 26 Dec 2022 17:42:50 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 26 Dec 2022 17:42:50 +0800
From:   Roger Lu <roger.lu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>
CC:     Fan Chen <fan.chen@mediatek.com>, Roger Lu <roger.lu@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Subject: [PATCH v1 05/13] soc: mediatek: mtk-svs: delete superfluous platform data entries
Date:   Mon, 26 Dec 2022 17:42:40 +0800
Message-ID: <20221226094248.4506-6-roger.lu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221226094248.4506-1-roger.lu@mediatek.com>
References: <20221226094248.4506-1-roger.lu@mediatek.com>
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

From: Matthias Brugger <matthias.bgg@gmail.com>

The platform name and efuse parsing function pointer are only used while
probing the device. Use them from the svs_platform_data struct instead.

Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Roger Lu <roger.lu@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index 24d2d07d2d3d..5c9ca373e646 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -311,14 +311,12 @@ static const u32 svs_regs_v2[] = {
 
 /**
  * struct svs_platform - svs platform control
- * @name: svs platform name
  * @base: svs platform register base
  * @dev: svs platform device
  * @main_clk: main clock for svs bank
  * @pbank: svs bank pointer needing to be protected by spin_lock section
  * @banks: svs banks that svs platform supports
  * @rst: svs platform reset control
- * @efuse_parsing: svs platform efuse parsing function pointer
  * @efuse_max: total number of svs efuse
  * @tefuse_max: total number of thermal efuse
  * @regs: svs platform registers map
@@ -327,14 +325,12 @@ static const u32 svs_regs_v2[] = {
  * @tefuse: thermal efuse data received from NVMEM framework
  */
 struct svs_platform {
-	char *name;
 	void __iomem *base;
 	struct device *dev;
 	struct clk *main_clk;
 	struct svs_bank *pbank;
 	struct svs_bank *banks;
 	struct reset_control *rst;
-	bool (*efuse_parsing)(struct svs_platform *svsp);
 	size_t efuse_max;
 	size_t tefuse_max;
 	const u32 *regs;
@@ -2009,7 +2005,7 @@ static bool svs_is_efuse_data_correct(struct svs_platform *svsp)
 	svsp->efuse_max /= sizeof(u32);
 	nvmem_cell_put(cell);
 
-	return svsp->efuse_parsing(svsp);
+	return true;
 }
 
 static struct device *svs_get_subsys_device(struct svs_platform *svsp,
@@ -2338,9 +2334,7 @@ static int svs_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	svsp->dev = &pdev->dev;
-	svsp->name = svsp_data->name;
 	svsp->banks = svsp_data->banks;
-	svsp->efuse_parsing = svsp_data->efuse_parsing;
 	svsp->regs = svsp_data->regs;
 	svsp->bank_max = svsp_data->bank_max;
 
@@ -2351,6 +2345,12 @@ static int svs_probe(struct platform_device *pdev)
 	if (!svs_is_efuse_data_correct(svsp)) {
 		dev_notice(svsp->dev, "efuse data isn't correct\n");
 		ret = -EPERM;
+		goto svs_probe_free_efuse;
+	}
+
+	if (!svsp_data->efuse_parsing(svsp)) {
+		dev_err(svsp->dev, "efuse data parsing failed\n");
+		ret = -EPERM;
 		goto svs_probe_free_resource;
 	}
 
@@ -2388,7 +2388,7 @@ static int svs_probe(struct platform_device *pdev)
 	}
 
 	ret = devm_request_threaded_irq(svsp->dev, svsp_irq, NULL, svs_isr,
-					IRQF_ONESHOT, svsp->name, svsp);
+					IRQF_ONESHOT, svsp_data->name, svsp);
 	if (ret) {
 		dev_err(svsp->dev, "register irq(%d) failed: %d\n",
 			svsp_irq, ret);
@@ -2416,11 +2416,13 @@ static int svs_probe(struct platform_device *pdev)
 	clk_disable_unprepare(svsp->main_clk);
 
 svs_probe_free_resource:
-	if (!IS_ERR_OR_NULL(svsp->efuse))
-		kfree(svsp->efuse);
 	if (!IS_ERR_OR_NULL(svsp->tefuse))
 		kfree(svsp->tefuse);
 
+svs_probe_free_efuse:
+	if (!IS_ERR_OR_NULL(svsp->efuse))
+		kfree(svsp->efuse);
+
 	return ret;
 }
 
-- 
2.18.0

