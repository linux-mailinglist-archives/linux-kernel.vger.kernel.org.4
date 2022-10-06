Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAD95F69DD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 16:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231721AbiJFOme (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 10:42:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiJFOmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:42:31 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B675AA3CE
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 07:42:25 -0700 (PDT)
X-UUID: cc7458097c88412da1f52f6716c3c17a-20221006
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=mz8P8A145cMKwKse6W1eLLO9DhD8+e7R2Wf+MraeiEE=;
        b=KWRGzHBcUbg5d5+3RgUKXtlLPpmUYHGwYnkHYKjAtmdRxtFnHjExFyrsNFkp7VcFVr32kwyvAkV6vyzZyHdkz4cEXJl8TDE2U6pNkTZbsl/wpYKrdWvF5LDEfMKnV2oeLLkc82Gfgo+dEUufv6FpUv1bOvUVHo1bqIzzAY2Hbis=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:10ece3e0-17e2-45e1-ad66-43c10da8b12e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:51
X-CID-INFO: VERSION:1.1.11,REQID:10ece3e0-17e2-45e1-ad66-43c10da8b12e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:51,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
        elease,TS:51
X-CID-META: VersionHash:39a5ff1,CLOUDID:3b5b1ee1-2948-402a-a6e4-b5d31fe11eb7,B
        ulkID:221006224220ZKAF7UNE,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48|823|
        824|102,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,B
        EC:nil,COL:0
X-UUID: cc7458097c88412da1f52f6716c3c17a-20221006
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1917635810; Thu, 06 Oct 2022 22:42:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Thu, 6 Oct 2022 22:42:17 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Thu, 6 Oct 2022 22:42:15 +0800
Message-ID: <6ca1eb83b7a776fd6b7e58e6940eab5ce5f7fb63.camel@mediatek.com>
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
Date:   Thu, 6 Oct 2022 22:42:15 +0800
In-Reply-To: <09bc1393-dd30-3c96-3309-f822994f4aab@collabora.com>
References: <20220929080926.1272-1-chunfeng.yun@mediatek.com>
         <20220929080926.1272-2-chunfeng.yun@mediatek.com>
         <09bc1393-dd30-3c96-3309-f822994f4aab@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-09-29 at 11:02 +0200, AngeloGioacchino Del Regno wrote:
> Il 29/09/22 10:09, Chunfeng Yun ha scritto:
> > These debugfs files are mainly used to make eye diagram test
> > easier,
> > especially helpful to do HQA test for a new IC without efuse
> > enabled.
> > 
> > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > ---
> > v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by AngeloGioacchino
> > ---
> >   drivers/phy/mediatek/Kconfig        |   5 +
> >   drivers/phy/mediatek/phy-mtk-tphy.c | 403
> > +++++++++++++++++++++++++++-
> >   2 files changed, 407 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/phy/mediatek/Kconfig
> > b/drivers/phy/mediatek/Kconfig
> > index 3125ecb5d119..e9fdfe9f519f 100644
> > --- a/drivers/phy/mediatek/Kconfig
> > +++ b/drivers/phy/mediatek/Kconfig
> > @@ -27,6 +27,11 @@ config PHY_MTK_TPHY
> >   	  multi-ports is first version, otherwise is second version,
> >   	  so you can easily distinguish them by banks layout.
> >   
> > +config PHY_MTK_TPHY_DEBUGFS
> > +	bool "Add T-PHY Debugfs Files"
> > +	help
> > +	  Say Y here to add debugfs files mainly for T-PHY HQA test.
> > +
> >   config PHY_MTK_UFS
> >   	tristate "MediaTek UFS M-PHY driver"
> >   	depends on ARCH_MEDIATEK || COMPILE_TEST
> > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > index e906a82791bd..d9509e1314a4 100644
> > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > @@ -7,6 +7,7 @@
> >   
> >   #include <dt-bindings/phy/phy.h>
> >   #include <linux/clk.h>
> > +#include <linux/debugfs.h>
> >   #include <linux/delay.h>
> >   #include <linux/iopoll.h>
> >   #include <linux/mfd/syscon.h>
> > @@ -264,6 +265,8 @@
> >   
> >   #define TPHY_CLKS_CNT	2
> >   
> > +#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
> > +
> >   enum mtk_phy_version {
> >   	MTK_PHY_V1 = 1,
> >   	MTK_PHY_V2,
> > @@ -310,6 +313,7 @@ struct mtk_phy_instance {
> >   	struct clk_bulk_data clks[TPHY_CLKS_CNT];
> >   	u32 index;
> >   	u32 type;
> > +	struct dentry *dbgfs;
> 
> Unused when !IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
Yes, it will be NULL.

> 
> >   	struct regmap *type_sw;
> >   	u32 type_sw_reg;
> >   	u32 type_sw_index;
> > @@ -332,10 +336,389 @@ struct mtk_tphy {
> >   	const struct mtk_phy_pdata *pdata;
> >   	struct mtk_phy_instance **phys;
> >   	int nphys;
> > +	struct dentry *dbgfs_root;
> 
> Same here
> 
> >   	int src_ref_clk; /* MHZ, reference clock for slew rate
> > calibrate */
> >   	int src_coef; /* coefficient for slew rate calibrate */
> >   };
> >   
> > +#if IS_ENABLED(CONFIG_PHY_MTK_TPHY_DEBUGFS)
> > +
> 
> ..snip..
> 
> > +
> > +static void tphy_debufs_init(struct mtk_tphy *tphy, struct
> > mtk_phy_instance *inst)
> 
> Please fix typo "debufs" -> "debugfs", 
Will fix it, thanks a lot

> here and everywhere else.
> 
> Apart from that, it looks good to me.
> 
> Regards,
> Angelo

