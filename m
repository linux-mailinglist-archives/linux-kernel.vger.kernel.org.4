Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01D7E658A6C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 09:21:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbiL2IVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 03:21:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232731AbiL2IVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 03:21:09 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC1CC28;
        Thu, 29 Dec 2022 00:21:06 -0800 (PST)
X-UUID: 88ca326cd7674b848a6254c0d0564ccf-20221229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=HORV9bMIP2LGFNhuhm7UuJjpXIYYSO+nEqUSjtucA64=;
        b=ZqQORkXKc0FXCVkrXWlcGmciE2mqA3pl3o8oVeVjFL79KQvZtLwheEdRXYCvqB019ANXgSU+d+iNNrzEVvG9dB/JK16L1Qi5KzDJCdGTxd8mhI3+kzHke7OX6a5Qg0Rx2c2t/i7G7ZshW/fJIGPQhDdwJFBvB5lXEyh8mloPOo4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:9564ab36-ded9-4df7-8f0b-db2fbc4aa091,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.14,REQID:9564ab36-ded9-4df7-8f0b-db2fbc4aa091,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:dcaaed0,CLOUDID:3db548f4-ff42-4fb0-b929-626456a83c14,B
        ulkID:221229162104179HRAPB,BulkQuantity:0,Recheck:0,SF:28|17|19|48|102,TC:
        nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 88ca326cd7674b848a6254c0d0564ccf-20221229
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 311895922; Thu, 29 Dec 2022 16:21:04 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 29 Dec 2022 16:21:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Thu, 29 Dec 2022 16:21:03 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chun-jie.chen@mediatek.com>, <daniel@makrotopia.org>,
        <devicetree@vger.kernel.org>, <fparent@baylibre.com>,
        <ikjn@chromium.org>, <johnson.wang@mediatek.com>,
        <jose.exposito89@gmail.com>, <kernel@collabora.com>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <msp@baylibre.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <pablo.sun@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <robh+dt@kernel.org>, <ryder.lee@kernel.org>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <weiyi.lu@mediatek.com>, <wenst@chromium.org>,
        <y.oudjana@protonmail.com>, <yangyingliang@huawei.com>
Subject: Re: [PATCH v2 18/23] clk: mediatek: clk-mtk: Register MFG notifier in mtk_clk_simple_probe()
Date:   Thu, 29 Dec 2022 16:21:03 +0800
Message-ID: <20221229082103.21064-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221223094259.87373-19-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-19-angelogioacchino.delregno@collabora.com>
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

>In preparation for commonizing topckgen probe on various MediaTek SoCs
>clock drivers, add the ability to register the MFG MUX notifier in
>mtk_clk_simple_probe() by passing a custom notifier register function
>pointer, as this function will be slightly different across different
>SoCs.
>
>Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>---
> drivers/clk/mediatek/clk-mtk.c | 8 ++++++++
> drivers/clk/mediatek/clk-mtk.h | 3 +++
> 2 files changed, 11 insertions(+)
>
>diff --git a/drivers/clk/mediatek/clk-mtk.c b/drivers/clk/mediatek/clk-mtk.c
>index b0a6225cd7b2..df6281492fb6 100644
>--- a/drivers/clk/mediatek/clk-mtk.c
>+++ b/drivers/clk/mediatek/clk-mtk.c
>@@ -533,6 +533,14 @@ int mtk_clk_simple_probe(struct platform_device *pdev)
> 			goto unregister_composites;
> 	}
> 
>+	if (mcd->clk_notifier_func) {
>+		struct clk *mfg_mux = clk_data->hws[mcd->mfg_clk_idx]->clk;
>+
>+		r = mcd->clk_notifier_func(&pdev->dev, mfg_mux);
>+		if (r)
>+			goto unregister_clks;
>+	}

Should we have a IS_ERR_OR_NULL() check for clk_data->hws[mcd->mfg_clk_idx]?

thanks,
Miles
>+
> 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
> 	if (r)
