Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 170B069EDD5
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 05:14:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjBVEOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 23:14:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBVEOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 23:14:36 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257701C7EF;
        Tue, 21 Feb 2023 20:14:30 -0800 (PST)
X-UUID: 635ff480b26711ed945fc101203acc17-20230222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DshSKXiXcq26A7KQ+aa3UgT2BGCnX15r04XpZzcKrtQ=;
        b=eHOZ7f+bJQtDlQwD/XEhMpu5uL6s4p7ixCLbyck8u0HCskwB+02JLh9dH8ZIfkCqRLEVzbrBSH+DqebPqhSK2o4gxz5WTUAk1ClH5+YlUAEtMIWv+aw6xvWMY+W51l8fZ9NRWRhNEwV+dPJ5s9Qjqtwt2STICJ48NM95lQFHIOM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.20,REQID:bac9ce62-d505-423f-b0a4-8cb0ff43a4ae,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:45
X-CID-INFO: VERSION:1.1.20,REQID:bac9ce62-d505-423f-b0a4-8cb0ff43a4ae,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:45,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:45
X-CID-META: VersionHash:25b5999,CLOUDID:0f5ebff3-ddba-41c3-91d9-10eeade8eac7,B
        ulkID:230222121424KKY906VX,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48|102,
        TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:
        0,OSI:0,OSA:0,AV:0
X-CID-BVR: 1,FCT
X-UUID: 635ff480b26711ed945fc101203acc17-20230222
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 399368684; Wed, 22 Feb 2023 12:14:23 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 22 Feb 2023 12:14:22 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 22 Feb 2023 12:14:22 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <angelogioacchino.delregno@collabora.com>
CC:     <chen.zhong@mediatek.com>, <chun-jie.chen@mediatek.com>,
        <daniel@makrotopia.org>, <edward-jw.yang@mediatek.com>,
        <fparent@baylibre.com>, <granquet@baylibre.com>,
        <johnson.wang@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <miles.chen@mediatek.com>, <msp@baylibre.com>,
        <mturquette@baylibre.com>, <nfraprado@collabora.com>,
        <pablo.sun@mediatek.com>, <rex-bc.chen@mediatek.com>,
        <sam.shih@mediatek.com>, <sboyd@kernel.org>,
        <sean.wang@mediatek.com>, <wenst@chromium.org>,
        <yangyingliang@huawei.com>, <zhaojh329@gmail.com>
Subject: Re: [PATCH v4 49/54] clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
Date:   Wed, 22 Feb 2023 12:14:22 +0800
Message-ID: <20230222041422.4429-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230221115549.360132-50-angelogioacchino.delregno@collabora.com>
References: <20230221115549.360132-50-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SORTED_RECIPS,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> static struct platform_driver clk_mt8195_venc_drv = {
> 	.probe = mtk_clk_simple_probe,
>diff --git a/drivers/clk/mediatek/clk-mt8195-vpp0.c b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>index 84805a114387..3d1ad92b663e 100644
>--- a/drivers/clk/mediatek/clk-mt8195-vpp0.c
>+++ b/drivers/clk/mediatek/clk-mt8195-vpp0.c
>@@ -95,6 +95,7 @@ static const struct platform_device_id clk_mt8195_vpp0_id_table[] = {
> 	{ .name = "clk-mt8195-vpp0", .driver_data = (kernel_ulong_t)&vpp0_desc },
> 	{ /* sentinel */ }
> };
>+MODULE_DEVICE_TABLE(platform, of_match_clk_mt8195_vpp0);
> 
> static struct platform_driver clk_mt8195_vpp0_drv = {
> 	.probe = mtk_clk_pdev_probe,
>diff --git a/drivers/clk/mediatek/clk-mt8195-vpp1.c b/drivers/clk/mediatek/clk-mt8195-vpp1.c
>index 3e91dfed2996..b463f8e197c6 100644
>--- a/drivers/clk/mediatek/clk-mt8195-vpp1.c
>+++ b/drivers/clk/mediatek/clk-mt8195-vpp1.c
>@@ -93,6 +93,7 @@ static const struct platform_device_id clk_mt8195_vpp1_id_table[] = {
> 	{ .name = "clk-mt8195-vpp1", .driver_data = (kernel_ulong_t)&vpp1_desc },
> 	{ /* sentinel */ }
> };
>+MODULE_DEVICE_TABLE(platform, of_match_clk_mt8195_vpp1);

I got the following build break with ARCH=arm64 allmodconfig:
Do I miss something?

linux-next/drivers/clk/mediatek/clk-mt8195-vpp0.c:98:31: error: 'of_match_clk_mt8195_vpp0' undeclared here (not in a function)
linux-next/drivers/clk/mediatek/clk-mt8195-vpp1.c:96:31: error: 'of_match_clk_mt8195_vpp1' undeclared here (not in a function)

ARCH=arm64 allyesconfig, defconfig: passed

thanks,
Miles
