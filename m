Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D036965A0
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233142AbjBNOAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233174AbjBNOAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:00:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235512A143
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:00:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78F3061614
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 14:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B0EC433A0;
        Tue, 14 Feb 2023 14:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676383213;
        bh=mBTD57A30/LvcZnwFqjcP9HsmHOnRFYQxkmV8hVd5Fw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEcUGLmTTaI9Iqgb81PXHajzB0u+y2Sc3bj5iiwGhYrmyPgN2k5j/7WkEKPX88o/g
         JpBdwhZ/YckttBYaOVYZs50doO8ujqXMZdFjYC/9M7PF6RNLjcWFTVA3u26WsYVrZ0
         Ro8HmkWRC+x53l7iw9+m2qxR9/8M4FpBhY2I2O6spbVITzhZzmqnKj6zPkwy2pvfbJ
         MBUyl79rOhYdEugYO3+V3Jo1tgj+x16XmD0mppJ3VDGP86WHP7jxUUt+wmXE6MPC+q
         aYZ03abiyTbHFKuKlZwtR41bR9m0xHIQy7cIR3ryTr53B30n2FftrHA9jLjaZl4AJ+
         hHv5tEQFycgxw==
Date:   Tue, 14 Feb 2023 19:30:09 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eddie Hung =?utf-8?B?KOa0quato+mRqyk=?= 
        <Eddie.Hung@mediatek.com>
Subject: Re: [PATCH v8] phy: mediatek: tphy: add debugfs files
Message-ID: <Y+uT6VoJra+056zj@matsya>
References: <20230210085827.7970-1-chunfeng.yun@mediatek.com>
 <Y+ZjPYDEbC9iblsj@matsya>
 <4e5d86502cc6b2278d7079dfca688af63bbcb523.camel@mediatek.com>
 <eec940a49f4f9ec9e5bd7ad763e436d34b42be22.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eec940a49f4f9ec9e5bd7ad763e436d34b42be22.camel@mediatek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-02-23, 08:22, Chunfeng Yun (云春峰) wrote:
> On Mon, 2023-02-13 at 16:21 +0800, chunfeng yun wrote:
> > On Fri, 2023-02-10 at 21:01 +0530, Vinod Koul wrote:
> > > On 10-02-23, 16:58, Chunfeng Yun wrote:
> > > > These debugfs files are mainly used to make eye diagram test
> > > > easier,
> > > > especially helpful to do HQA test for a new IC without efuse
> > > > enabled.
> > > > 
> > > > Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> > > > ---
> > > > v8: abandon patch to create phy debug root file
> > > >     /sys/kernel/debug/phy/ suggested by Vinod
> > > 
> > > Sorry that was not my suggestion
> > 
> > Sorry, I misunderstood you means
> > > 
> > > > 
> > > > v6~v7: no changes
> > > > 
> > > > v5: using common debugfs config CONFIG_DEBUG_FS
> > > > 
> > > > v4: fix build warning of sometimes uninitialized variable
> > > > 
> > > > v3: fix typo of "debugfs" suggested by AngeloGioacchino
> > > > 
> > > > v2: add CONFIG_PHY_MTK_TPHY_DEBUGFS suggested by AngeloGioacchino
> > > > ---
> > > >  drivers/phy/mediatek/phy-mtk-tphy.c | 405
> > > > +++++++++++++++++++++++++++-
> > > >  1 file changed, 404 insertions(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > index e906a82791bd..65a95c3726bf 100644
> > > > --- a/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > +++ b/drivers/phy/mediatek/phy-mtk-tphy.c
> > > > @@ -7,6 +7,7 @@
> > > >  
> > > >  #include <dt-bindings/phy/phy.h>
> > > >  #include <linux/clk.h>
> > > > +#include <linux/debugfs.h>
> > > >  #include <linux/delay.h>
> > > >  #include <linux/iopoll.h>
> > > >  #include <linux/mfd/syscon.h>
> > > > @@ -264,6 +265,8 @@
> > > >  
> > > >  #define TPHY_CLKS_CNT	2
> > > >  
> > > > +#define USER_BUF_LEN(count) min_t(size_t, 8, (count))
> > > > +
> > > >  enum mtk_phy_version {
> > > >  	MTK_PHY_V1 = 1,
> > > >  	MTK_PHY_V2,
> > > > @@ -310,6 +313,7 @@ struct mtk_phy_instance {
> > > >  	struct clk_bulk_data clks[TPHY_CLKS_CNT];
> > > >  	u32 index;
> > > >  	u32 type;
> > > > +	struct dentry *dbgfs;
> > > >  	struct regmap *type_sw;
> > > >  	u32 type_sw_reg;
> > > >  	u32 type_sw_index;
> > > > @@ -332,10 +336,391 @@ struct mtk_tphy {
> > > >  	const struct mtk_phy_pdata *pdata;
> > > >  	struct mtk_phy_instance **phys;
> > > >  	int nphys;
> > > > +	struct dentry *dbgfs_root;
> > > >  	int src_ref_clk; /* MHZ, reference clock for slew rate
> > > > calibrate */
> > > >  	int src_coef; /* coefficient for slew rate calibrate */
> > > >  };
> > > 
> > > I asked the struct dentry *debugfs be part of struct phy. Debugfs
> > > would
> > > be created by core but rather than exported, it should be populated
> > > in
> > > phy and you can use it here in the driver
> > > 
> > > >  
> > 
> > Ok, I'll do the following steps:
> > 
> > 0. put a struct dentry *debugfs in struct phy;
> > 1. define a static struct dentry *phy_debugfs_root in phy-core.c,
> > then
> >    create a root directory (/sys/kernel/debug/phy/) for phy
> > subsystem 
> > in phy_core_init();
> > 2. create directory for each phy under the root directory
> > (/sys/kernel/debug/phy/);
> >    this step has two ways:
> >    A: create the directory @debugfs of struct phy in phy_create() by
> > default;

That sounds good to me

> >    B: provide some api for user to create/destory the directory
> > @debugfs or others when need;
> > 3. add private debugfs files in @debugfs of struct phy;
> > 
> > For the case in tphy driver, it provides some struct phy, the driver
> > may want to create debugfs files which not belongs to any struct phy
> > in
> > the root directory (/sys/kernel/debug/phy/), then need provide a api.
> > 
> >    Do you have any suggestions?
> >    Which way do you prefer to use in step 2?
> > 
> >    Thanks a lot;
> > 
> > > <skip>
> > > > +
> > > >  static struct platform_driver mtk_tphy_driver = {
> > > >  	.probe		= mtk_tphy_probe,
> > > > +	.remove		= mtk_tphy_remove,
> > > >  	.driver		= {
> > > >  		.name	= "mtk-tphy",
> > > >  		.of_match_table = mtk_tphy_id_table,
> > > > -- 
> > > > 2.18.0
> > > 
> > > 

-- 
~Vinod
