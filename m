Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 244C660DB0F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 08:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233108AbiJZGRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 02:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232948AbiJZGRR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 02:17:17 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7711B97B9;
        Tue, 25 Oct 2022 23:17:10 -0700 (PDT)
X-UUID: b9b860828a294f1db966d5a06ce57cb0-20221026
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=rpNH4LZY0Q+sw8pDhES08ltr0IYHiCV8h5oPREgY/yQ=;
        b=pbLZFMNlXvS7pmNxOzZHRGkmgjsNoMF1SLJXoaiy5aebsoRHiOXy/ZzjLkihc/ixNiF+XLO7IQhK55NTYpsD4DYe7ugDpDvOxG3jFZLREUMwOwbTuh6KxZ7cyaAJWGV8HU/7y+tXl7OWkjDZoraSaRyzlTbJhu/CDBinbovXDB8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:5fce6a6e-d8d7-4ef4-91ac-dd6e9c4ed5d6,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:62cd327,CLOUDID:f6902a27-9eb1-469f-b210-e32d06cfa36e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: b9b860828a294f1db966d5a06ce57cb0-20221026
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <sam.shih@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1255250453; Wed, 26 Oct 2022 14:17:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 26 Oct 2022 14:17:06 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Wed, 26 Oct 2022 14:17:06 +0800
Message-ID: <df08d62655e57d00ab5596bc90a4c40c332cee6b.camel@mediatek.com>
Subject: Re: [PATCH 1/2] pwm: mediatek: Add support for MT7986
From:   Sam Shih <sam.shih@mediatek.com>
To:     Daniel Golle <daniel@makrotopia.org>
CC:     <linux-pwm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Wed, 26 Oct 2022 14:17:06 +0800
In-Reply-To: <Y1fPLzwUz/E9C3I1@makrotopia.org>
References: <Y1K5ym1EL8kwzQEt@makrotopia.org>
         <b5ab84b4d595713588f1d8a68a1585ca3ae5521e.camel@mediatek.com>
         <Y1fPLzwUz/E9C3I1@makrotopia.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-10-25 at 12:57 +0100, Daniel Golle wrote:
> On Tue, Oct 25, 2022 at 02:35:43PM +0800, Sam Shih wrote:
> > Hi Daniel:
> > 
> > On Fri, 2022-10-21 at 16:24 +0100, Daniel Golle wrote:
> > > Add support for PWM on MT7986 which has 2 PWM channels, one of
> > > them
> > > is
> > > typically used for a temperature controlled fan.
> > > 
> > > Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> > > ---
> > >  drivers/pwm/pwm-mediatek.c | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-
> > > mediatek.c
> > > index 6901a44dc428de..2219cba033e348 100644
> > > --- a/drivers/pwm/pwm-mediatek.c
> > > +++ b/drivers/pwm/pwm-mediatek.c
> > > @@ -329,6 +329,12 @@ static const struct pwm_mediatek_of_data
> > > mt8365_pwm_data = {
> > >  	.has_ck_26m_sel = true,
> > >  };
> > >  
> > > +static const struct pwm_mediatek_of_data mt7986_pwm_data = {
> > > +	.num_pwms = 2,
> > > +	.pwm45_fixup = false,
> > > +	.has_ck_26m_sel = true,
> > 
> > For MT7986 SoC, I think the value of "has_ck_26m_sel" should be
> > 'false'
> 
> That's a bit surprising, please explain why.
> 

The clock tree of MT7981/MT7986 PWM BCLK is as bellow:
PLL --> topckgen fix-factors --> TOP_PWM_SEL (topckgen clock mux) -->
--
> CLK_INFRA_PWM_BSEL (infra clock mux) --> PWM BCLK (gate)

We do have the clock multiplexer to select the source clock for PWM_BCLK
https://github.com/torvalds/linux/blob/master/drivers/clk/mediatek/clk-mt7986-infracfg.c#L63

In my knowledge, the pwm hardware of MT7981/MT7986 SoC should ignore
this register directtly, but we still keep the register for backword
compatibility.

In fact, the MT7986 SoC is also working whether 'has_ck_26m_sel' is
'true' or 'false'.

Going back to the definition of 'has_ck_26m_sel', if it means
"PWM_CK_26M_SEL" register exists or not, we should use 'true', but if
it means clock from 26M clock or BUS clock, we should use 'false'

> Reading the commit adding .has_ck_26m_sel field:
> > commit 0c0ead76235db0bcfaab83f04db546995449d002
> > Author: Fabien Parent <fparent@baylibre.com>
> > Date:   Mon Oct 19 16:07:02 2020 +0200
> > 
> > pwm: mediatek: Always use bus clock
> > 
> > The MediaTek PWM IP can sometimes use the 26 MHz source clock to
> > generate the PWM signal, but the driver currently assumes that we
> > always
> > use the PWM bus clock to generate the PWM signal.
> > 
> > This commit modifies the PWM driver in order to force the PWM IP to
> > always use the bus clock as source clock.
> > 
> > I do not have the datasheet of all the MediaTek SoC, so I don't
> > know if
> > the register to choose the source clock is present in all the SoCs
> > or
> > only in subset. As a consequence I made this change optional by
> > using a
> > platform data paremeter to says whether this register is supported
> > or
> > not. On all the SoCs I don't have the datasheet (MT2712, MT7622,
> > MT7623,
> > MT7628, MT7629) I kept the behavior to be the same as before this
> > change.
> > 
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Signed-off-by: Thierry Reding <thierry.reding@gmail.com>
> 
> From MT7986 datasheet:
> > 0x10048210 PWM_CK_26M_SEL PWM BCLK Selection
> > Reset value 0x00000001
> > Description
> > 0: Select bus CLK as BCLK
> > 1: Select 26M fix CLK as BCLK
> So after reset, the 26M clock is selected by default.
> 
> In pwm-mediatek.c I read:
> > #define PWM_CK_26M_SEL          0x210
> > ...
> >         /* Make sure we use the bus clock and not the 26MHz clock
> > */
> >         if (pc->soc->has_ck_26m_sel)
> >                 writel(0, pc->regs + PWM_CK_26M_SEL);
> 
> So this PWM_CK_26M_SEL register does exist on MT7986 and has the
> same address as expected by the driver ($PWM_BASE + 0x210).
> The default value selected after reset (0x00000001) matches the
> problem and solution described in the commit description
> "pwm: mediatek: Always use bus clock".
> 
> Sidenode: I've tried with both, .has_ck_26m_sel = true as well as
> .has_ck_26m_sel = false. Both do work, but the behavior is slightly
> different, again matching the commit description above.

What is the difference between the two?

I tried to config the pwm ch0 period=1000000 and duty=500000,
Modify PWM_CK_26M_SEL, and measure the output waveform, the waveform
keep the same.


Regards,
Sam






