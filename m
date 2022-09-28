Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD335ED316
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbiI1ClN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbiI1ClH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:41:07 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F09C10253C;
        Tue, 27 Sep 2022 19:41:04 -0700 (PDT)
X-UUID: 0116d708030d4f4794d5bae4c99aee36-20220928
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=zoVsh+lBpo2kny9dOeVB7K/RKMo8E8eyudzqFaV/N2w=;
        b=HMLzuwVhQUv9fun+rv1k2zOt8bo+rAt3MGJQgaJsh3/LQWZY5q4MYAQK9Tb8kPs2uO7MGhsc4Ng0MfdA2/DS21g/8mypnT4pbxo7kRU9Xp2Mr90rD6eSXDhvBt0I82rYylp75lxcHcUf7JT7jb5wF4iFjbgHtS2aej+iB4jFjXw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:73bf7f0f-e40b-4efc-a84c-afd2fc491e7f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:6faf73e4-87f9-4bb0-97b6-34957dc0fbbe,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 0116d708030d4f4794d5bae4c99aee36-20220928
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1773477499; Wed, 28 Sep 2022 10:41:01 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Wed, 28 Sep 2022 10:41:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Sep 2022 10:40:59 +0800
Message-ID: <da5c39fb351a7ca5a9dfa1c938d2e3d914ecb0d2.camel@mediatek.com>
Subject: Re: [PATCH v1 14/17] phy: mediatek: add support for
 phy-mtk-hdmi-mt8195
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Guillaume Ranquet <granquet@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao shi <jitao.shi@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Michael Turquette" <mturquette@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-mediatek@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        Pablo Sun <pablo.sun@mediatek.com>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>
Date:   Wed, 28 Sep 2022 10:40:59 +0800
In-Reply-To: <CABnWg9v4OuAU0x7n1q09gO7u3faOsmeq_4PFpw=_wAn1+erF8A@mail.gmail.com>
References: <20220919-v1-0-4844816c9808@baylibre.com>
         <20220919-v1-14-4844816c9808@baylibre.com>
         <d1346dcf6b6906d153c13c086bf963dc89c5549b.camel@mediatek.com>
         <CABnWg9v4OuAU0x7n1q09gO7u3faOsmeq_4PFpw=_wAn1+erF8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-09-27 at 06:23 -0700, Guillaume Ranquet wrote:
> On Tue, 20 Sep 2022 09:46, Chunfeng Yun <chunfeng.yun@mediatek.com>
> wrote:
> > On Mon, 2022-09-19 at 18:56 +0200, Guillaume Ranquet wrote:
> > > Add basic support for the mediatek hdmi phy on MT8195 SoC
> > > 
> > > Signed-off-by: Guillaume Ranquet <granquet@baylibre.com>
> > > 
> > > diff --git a/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> > > b/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> > > index bb7593ea4c86..0157acdce56c 100644
> > > --- a/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> > > +++ b/drivers/gpu/drm/mediatek/mtk_mt8195_hdmi.c
> > > @@ -1344,6 +1344,8 @@ static void mtk_hdmi_bridge_disable(struct
> > > drm_bridge *bridge,
> > >  	mtk_hdmi_disable_hdcp_encrypt(hdmi);
> > >  	usleep_range(50000, 50050);
> > > 
> > > +	phy_power_off(hdmi->phy);
> > > +
> > >  	hdmi->enabled = false;
> > >  }
> > > 
> > > diff --git a/drivers/phy/mediatek/Makefile
> > > b/drivers/phy/mediatek/Makefile
> > > index fb1f8edaffa7..c9a50395533e 100644
> > > --- a/drivers/phy/mediatek/Makefile
> > > +++ b/drivers/phy/mediatek/Makefile
> > > @@ -12,6 +12,7 @@ obj-$(CONFIG_PHY_MTK_XSPHY)		+= phy-
> > > mtk-
> > > xsphy.o
> > >  phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
> > >  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-
> > > mt2701.o
> > >  phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-
> > > mt8173.o
> > > +phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-
> > > mt8195.o
> > >  obj-$(CONFIG_PHY_MTK_HDMI)		+= phy-mtk-hdmi-drv.o
> > > 
> > >  phy-mtk-mipi-dsi-drv-y			:= phy-mtk-mipi-dsi.o
> > > diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> > > b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> > > new file mode 100644
> > > index 000000000000..149015b64c02
> > > --- /dev/null
> > > +++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c
> > > @@ -0,0 +1,673 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2021 MediaTek Inc.
> > > + * Copyright (c) 2021 BayLibre, SAS
> > > + */
> > > +#include <linux/delay.h>
> > > +#include <linux/io.h>
> > > +#include <linux/mfd/syscon.h>
> > > +#include <linux/module.h>
> > > +#include <linux/phy/phy.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/types.h>
> > > +#include <linux/nvmem-consumer.h>
> > > +
> > > +#include "phy-mtk-hdmi.h"
> > > +#include "phy-mtk-hdmi-mt8195.h"
> > > +
> > > +static void mtk_hdmi_ana_fifo_en(struct mtk_hdmi_phy *hdmi_phy)
> > > +{
> > > +	/* make data fifo writable for hdmi2.0 */
> > > +	mtk_hdmi_phy_mask(hdmi_phy, HDMI_ANA_CTL,
> > > REG_ANA_HDMI20_FIFO_EN,
> > > +			  REG_ANA_HDMI20_FIFO_EN);
> > > +}
> > > +
> > > +static void
> > > +mtk_mt8195_phy_tmds_high_bit_clk_ratio(struct mtk_hdmi_phy
> > > *hdmi_phy,
> > > +				       bool enable)
> > > +{
> > > +	mtk_hdmi_ana_fifo_en(hdmi_phy);
> > > +
> > > +	/* HDMI 2.0 specification, 3.4Gbps <= TMDS Bit Rate <= 6G,
> > > +	 * clock bit ratio 1:40, under 3.4Gbps, clock bit ratio 1:10
> > > +	 */
> > > +	if (enable)
> > > +		mtk_hdmi_phy_mask(hdmi_phy, HDMI20_CLK_CFG,
> > > +				  0x2 << REG_TXC_DIV_SHIFT,
> > 
> > Use FIELD_PREP() macro, then no need define REG_TXC_DIV_SHIFT
> > anymore.
> > 
> 
> Didn't know about FIELD_* macros, will use them for V2.
> 
> Thx for the suggestion.
Please use helpers defined in phy-mtk-io.h, the register access helpers
of mtk_hdmi_phy_* are already removed in phy next branch.

Thanks a lot


