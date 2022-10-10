Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A7B5F9A8F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 10:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiJJIBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 04:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiJJIBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 04:01:33 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6735280B
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 01:01:24 -0700 (PDT)
X-UUID: 7e0a3ff158a54cfa8336bbc321bd532e-20221010
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/q651Gv19ju5ws8l4dkc83n5wn/z5DCbrzuyetVRLBI=;
        b=J0Hs4o4sa/Df3ysEe0QAiw7Ut/Oi441C1QztUUetZw/xfHV/dLTjHdsSIMsfWchGHvYgpLKZSRJYZFJoIgqk7gOY78tlsRRrq1BHykP9A+a7ooZlBKsULVqsQrN4jjvRzs76su0DqRjdPX8/YY7dzwYpaMyP0m1pDcnOmcDczwY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:bb370d0e-9755-4aeb-8045-9ea2da7036a5,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:2f466ae1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7e0a3ff158a54cfa8336bbc321bd532e-20221010
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 911802916; Mon, 10 Oct 2022 16:01:19 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 10 Oct 2022 16:01:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 10 Oct 2022 16:01:17 +0800
Message-ID: <b35143437ee159ae968fcd36bb3d15649ea2899c.camel@mediatek.com>
Subject: Re: [PATCH v2 2/2] phy: mediatek: tphy: add debugfs files
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Vinod Koul <vkoul@kernel.org>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
Date:   Mon, 10 Oct 2022 16:01:15 +0800
In-Reply-To: <6dbfaee8-8c72-85b5-495d-dcb62f18c154@collabora.com>
References: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
         <20220929080926.1272-2-chunfeng.yun@mediatek.com>
         <09bc1393-dd30-3c96-3309-f822994f4aab@collabora.com>
         <6ca1eb83b7a776fd6b7e58e6940eab5ce5f7fb63.camel@mediatek.com>
         <6dbfaee8-8c72-85b5-495d-dcb62f18c154@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-10-06 at 16:54 +0200, AngeloGioacchino Del Regno wrote:
> Il 06/10/22 16:42, Chunfeng Yun ha scritto:
> > On Thu, 2022-09-29 at 11:02 +0200, AngeloGioacchino Del Regno
> > wrote:
> > > Il 29/09/22 10:09, Chunfeng Yun ha scritto:
> > > > These debugfs files are mainly used to make eye diagram test
> > > > easier,
> > > > especially helpful to do HQA test for a new IC without efuse
> > > > enabled.
> > > > 
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > > v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by
> > > > AngeloGioacchino
> > > > ---
> > > >    drivers/phy/mediatek/Kconfig        |   5 +
> > > >    drivers/phy/mediatek/phy-mtk-tphy.c | 403
> > > > +++++++++++++++++++++++++++-
> > > >    2 files changed, 407 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/phy/mediatek/Kconfig
> > > > b/drivers/phy/mediatek/Kconfig
> > > > index 3125ecb5d119..e9fdfe9f519f 100644
> > > > --- a/drivers/phy/mediatek/Kconfig
> > > > +++ b/drivers/phy/mediatek/Kconfig
> > > > @@ -27,6 +27,11 @@ config PHY_MTK_TPHY
> > > >    	  multi-ports is first version, otherwise is second
> > > > version,
> > > >    	  so you can easily distinguish them by banks layout.
> > > >    
> > > > +config PHY_MTK_TPHY_DEBUGFS
> > > > +	bool "Add T-PHY Debugfs Files"
> > > > +	help
> > > > +	  Say Y here to add debugfs files mainly for T-PHY HQA
> > > > test.
> > > > +
> > > >    config PHY_MTK_UFS
> > > >    	tristate "MediaTek UFS M-PHY driver"
> > > >    	depends on ARCH_MEDIATEK || COMPILE_TEST
> > > > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > index e906a82791bd..d9509e1314a4 100644
> > > > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > @@ -7,6 +7,7 @@
> > > >    
> > > >    #include <dt-bindings/phy/phy.h>
> > > >    #include <linux/clk.h>
> > > > +#include <linux/debugfs.h>
> > > >    #include <linux/delay.h>
> > > >    #include <linux/iopoll.h>
> > > >    #include <linux/mfd/syscon.h>
> > > > @@ -264,6 +265,8 @@
> > > >    
> > > >    #define TPHY_CLKS_CNT	2
> > > >    
> > > > +#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
> > > > +
> > > >    enum mtk_phy_version {
> > > >    	MTK_PHY_V1 = 1,
> > > >    	MTK_PHY_V2,
> > > > @@ -310,6 +313,7 @@ struct mtk_phy_instance {
> > > >    	struct clk_bulk_data clks[TPHY_CLKS_CNT];
> > > >    	u32 index;
> > > >    	u32 type;
> > > > +	struct dentry *dbgfs;
> > > 
> > > Unused when !IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
> > 
> > Yes, it will be NULL.
> > 
> 
> I was meaning that you should ifdef that out...
That's no side-effect, but just wastes some bytes, leave it unchanged


> 
> Regards,
> Angelo
> 
> > > 
> > > >    	struct regmap *type_sw;
> > > >    	u32 type_sw_reg;
> > > >    	u32 type_sw_index;
> > > > @@ -332,10 +336,389 @@ struct mtk_tphy {
> > > >    	const struct mtk_phy_pdata *pdata;
> > > >    	struct mtk_phy_instance **phys;
> > > >    	int nphys;
> > > > +	struct dentry *dbgfs_root;
> > > 
> > > Same here
> > > 
> > > >    	int src_ref_clk; /* MHZ, reference clock for slew rate
> > > > calibrate */
> > > >    	int src_coef; /* coefficient for slew rate calibrate */
> > > >    };
> > > >    
> > > > +#if IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
> > > > +
> > > 
> > > ..snip..
> > > 
> > > > +
> > > > +static void tphy_debufs_init(struct mtk_tphy *tphy, struct
> > > > mtk_phy_instance *inst)
> > > 
> > > Please fix typo "debufs" -> "debugfs",
> > 
> > Will fix it, thanks a lot
> > 
> > > here and everywhere else.
> > > 
> > > Apart from that, it looks good to me.
> > > 
> > > Regards,
> > > Angelo
> 
> 

