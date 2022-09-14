Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77D775B7E21
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 03:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiINBLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 21:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbiINBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 21:11:14 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347011C0F;
        Tue, 13 Sep 2022 18:11:07 -0700 (PDT)
X-UUID: 14fa1acf332e4e8ebd25eb2c58bd22ef-20220914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=OSvNiugJ11pReBtWe7UQLxlrPiTmtjqprSkbNNjArYk=;
        b=PcP85df+GjVboT7h7RBgI0a9m8NbJ8uv7FD5twTEtjvRkYt8syxlIMo1KlPmwdB5qJxpvXBmFvuCMEYp4V1Auv2QPBgH6NFFmT2dWxPUYR161OrCC7SzIOo9mX4YC5dgcDANqouarw75JVgRRQjrCbY8B15oaIOSMFZxZ6f9VK0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:6ff19e9f-006d-4f4e-8bbe-8f2428cfb411,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:3f268b5d-5ed4-4e28-8b00-66ed9f042fbd,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 14fa1acf332e4e8ebd25eb2c58bd22ef-20220914
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <jason-jh.lin@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2002186123; Wed, 14 Sep 2022 09:10:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 14 Sep 2022 09:10:57 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 14 Sep 2022 09:10:57 +0800
Message-ID: <b83434dacff497fa738f84ced33fe1dc2ef32ff9.camel@mediatek.com>
Subject: Re: [PATCH RESEND v3 3/9] drm/mediatek: Adjust
 mtk_drm_gamma_set_common parameters
From:   Jason-JH Lin <jason-jh.lin@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
CC:     Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Wed, 14 Sep 2022 09:10:56 +0800
In-Reply-To: <44d19c4ea29bdbf3a07890ed25fd637f8805b6c6.camel@mediatek.com>
References: <20220912013006.27541-1-jason-jh.lin@mediatek.com>
         <20220912013006.27541-4-jason-jh.lin@mediatek.com>
         <44d19c4ea29bdbf3a07890ed25fd637f8805b6c6.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,RDNS_NONE,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,
        URIBL_CSS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi CK, 

Thanks for the reviews.

On Mon, 2022-09-12 at 10:48 +0800, CK Hu wrote:
> Hi, Jason:
> 
> On Mon, 2022-09-12 at 09:30 +0800, Jason-JH.Lin wrote:
> > Adjust the parameters in mtk_drm_gamma_set_common()
> >   - add (struct device *dev) to get lut_diff from gamma's driver
> > data
> >   - remove (bool lut_diff) and use false as default value in the
> > function
> > 
> > Fixes: 051524cbe62d ("FROMGIT: drm/mediatek: Add lut diff flag for
> > new gamma hardware support")
> > Signed-off-by: Jason-JH.Lin <jason-jh.lin@mediatek.com>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_aal.c   |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_disp_drv.h   |  2 +-
> >  drivers/gpu/drm/mediatek/mtk_disp_gamma.c | 13 +++++++------
> >  3 files changed, 9 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> > b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> > index 0f9d7efb61d7..6517e0a5a7d8 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_aal.c
> > @@ -66,7 +66,7 @@ void mtk_aal_gamma_set(struct device *dev, struct
> > drm_crtc_state *state)
> >  	struct mtk_disp_aal *aal = dev_get_drvdata(dev);
> >  
> >  	if (aal->data && aal->data->has_gamma)
> > -		mtk_gamma_set_common(aal->regs, state, false);
> > +		mtk_gamma_set_common(NULL, aal->regs, state);
> >  }
> >  
> >  void mtk_aal_start(struct device *dev)
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > index 33e61a136bbc..a83e5fbc8724 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_drv.h
> > @@ -52,7 +52,7 @@ void mtk_gamma_config(struct device *dev,
> > unsigned
> > int w,
> >  		      unsigned int h, unsigned int vrefresh,
> >  		      unsigned int bpc, struct cmdq_pkt *cmdq_pkt);
> >  void mtk_gamma_set(struct device *dev, struct drm_crtc_state
> > *state);
> > -void mtk_gamma_set_common(void __iomem *regs, struct
> > drm_crtc_state
> > *state, bool lut_diff);
> > +void mtk_gamma_set_common(struct device *dev, void __iomem *regs,
> > struct drm_crtc_state *state);
> 
> This function is called by both aal and gamma driver, so I would like
> to pass struct device dev because priv data of aal and gamma are
> different. Make this function command for both aal and gamma driver.
> 
> Regards,
> CK
> 
I think handle the priv data of AAL in the gamma_set_common function
will make this function coupling with AAL.
So I'll drop this patch and move the gamma priv data to gamma_set and
just pass the necessary parameters for gamma_set_common.


Regards,
Jason-JH.Lin
> >  void mtk_gamma_start(struct device *dev);
> >  void mtk_gamma_stop(struct device *dev);
> >  
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > index bbd558a036ec..f54a6a618348 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_gamma.c
> > @@ -54,14 +54,19 @@ void mtk_gamma_clk_disable(struct device *dev)
> >  	clk_disable_unprepare(gamma->clk);
> >  }
> >  
> > -void mtk_gamma_set_common(void __iomem *regs, struct
> > drm_crtc_state
> > *state, bool lut_diff)
> > +void mtk_gamma_set_common(struct device *dev, void __iomem *regs,
> > struct drm_crtc_state *state)
> >  {
> > +	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
> > +	bool lut_diff = false;
> >  	unsigned int i, reg;
> >  	struct drm_color_lut *lut;
> >  	void __iomem *lut_base;
> >  	u32 word;
> >  	u32 diff[3] = {0};
> >  
> > +	if (gamma && gamma->data)
> > +		lut_diff = gamma->data->lut_diff;
> > +
> >  	if (state->gamma_lut) {
> >  		reg = readl(regs + DISP_GAMMA_CFG);
> >  		reg = reg | GAMMA_LUT_EN;
> > @@ -91,12 +96,8 @@ void mtk_gamma_set_common(void __iomem *regs,
> > struct drm_crtc_state *state, bool
> >  void mtk_gamma_set(struct device *dev, struct drm_crtc_state
> > *state)
> >  {
> >  	struct mtk_disp_gamma *gamma = dev_get_drvdata(dev);
> > -	bool lut_diff = false;
> > -
> > -	if (gamma->data)
> > -		lut_diff = gamma->data->lut_diff;
> >  
> > -	mtk_gamma_set_common(gamma->regs, state, lut_diff);
> > +	mtk_gamma_set_common(dev, gamma->regs, state);
> >  }
> >  
> >  void mtk_gamma_config(struct device *dev, unsigned int w,
> 
> 
-- 
Jason-JH Lin <jason-jh.lin@mediatek.com>

