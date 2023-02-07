Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F768D0B4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbjBGHj7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:39:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjBGHjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:39:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E711F32E7F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 23:39:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85779611DF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 07:39:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70426C433D2;
        Tue,  7 Feb 2023 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675755591;
        bh=YTDIuELkk0jgNtsvv2JQqBBhkB1tLuJS+oEPaYrPHjo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SXgUdq2isvqNmMChmKKKF3emA7YX3Y7LPie8f/SbNGXX8TT1+Qe4GKGlF1t2BJ2+g
         HPWkRPSvdEIf3pHwN0CWw9YkMFvZqteSQPQQbT4/gjBTp0IVw8h4aDuKCnPH7eXzFN
         VtMDRq82VOK2zFRaVdYBgl08JuxHYcVUei2ujZc0=
Date:   Tue, 7 Feb 2023 08:39:48 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y+IARPmLHzTGbEoG@kroah.com>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:25:57AM +0100, Guru Mehar Rachaputi wrote:
> On Mon, Feb 06, 2023 at 10:43:56AM +0100, Greg Kroah-Hartman wrote:
> > On Mon, Feb 06, 2023 at 12:39:08AM +0100, Guru Mehar Rachaputi wrote:
> > > On Sun, Feb 05, 2023 at 08:12:31PM +0100, Christophe JAILLET wrote:
> > > > Le 05/02/2023 à 19:11, Guru Mehar Rachaputi a écrit :
> > > > > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > > > > as '(iobase)' to avoid precedence issues" changed to inline function. In
> > > > > relation to this, names of the callers of macro are also modified to call
> > > > > this function.
> > > > > 
> > > > > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> > > > 
> > > > Hi,
> > > > 
> > > > this patch should be v4.
> > > > You re-sent it with a modified commit message (the position of your S-o-b)
> > > > 
> > > > The idea behind patch versions is to help maintainer. With the way you did,
> > > > now 2 patches stating v3 are available.
> > > > Which one is the correct one?
> > > > The maintainer would need to look at both, search for differences, maybe
> > > > look at the date of the mails.
> > > > A v4 would be much easier for him.
> > > > 
> > > > 
> > > > Also, when you send an updated version of a patch, it should always be
> > > > "complete". I mean that the patch below seems to need v2, and maybe even v1
> > > > (which is apparently not on the linux-kernel mailing list).
> > > > 
> > > > A maintainer can't know by himself what is needed and what is not.
> > > > 
> > > > So you should resend a new patch.
> > > > It should be a v4, and it should include what is needed from (v1?), v2 and
> > > > v3 all together.
> > > > 
> > > > CJ
> > > > 
> > > > 
> > > > > ---
> > > > > Changes in v3:
> > > > > 	- Whitespace error from checkpatch fixed
> > > > > 
> > > > > Changes in v2:
> > > > > 	- Macros with one statement that is to call 'iowrite8' function changed
> > > > > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > > > > 	In relation to this, names of the callers of macro are also modified
> > > > > 	to call this function.
> > > > > ---
> > > > >   drivers/staging/vt6655/card.c    | 3 +--
> > > > >   drivers/staging/vt6655/channel.c | 2 +-
> > > > >   drivers/staging/vt6655/mac.h     | 4 ++--
> > > > >   3 files changed, 4 insertions(+), 5 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> > > > > index a6ff496b01b6..d2d122dc16d8 100644
> > > > > --- a/drivers/staging/vt6655/card.c
> > > > > +++ b/drivers/staging/vt6655/card.c
> > > > > @@ -643,8 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
> > > > >   				   &byRsvTime);
> > > > >   	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
> > > > >   	/* Set to Page0 */
> > > > > -        vt6655_mac_select_page0(priv->port_offset);
> > > > > -
> > > > > +	vt6655_mac_select_page0(priv->port_offset);
> > > > >   	spin_unlock_irqrestore(&priv->lock, flags);
> > > > >   }
> > > > > diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> > > > > index e9a44bcebe32..60b445c38424 100644
> > > > > --- a/drivers/staging/vt6655/channel.c
> > > > > +++ b/drivers/staging/vt6655/channel.c
> > > > > @@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
> > > > >   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
> > > > >   		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
> > > > >   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
> > > > > -	        vt6655_mac_select_page0(priv->port_offset);
> > > > > +		vt6655_mac_select_page0(priv->port_offset);
> > > > >   		spin_unlock_irqrestore(&priv->lock, flags);
> > > > >   	}
> > > > > diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> > > > > index b9a7ca0fe604..ae3064303691 100644
> > > > > --- a/drivers/staging/vt6655/mac.h
> > > > > +++ b/drivers/staging/vt6655/mac.h
> > > > > @@ -539,12 +539,12 @@
> > > > >   static inline void vt6655_mac_select_page0(void __iomem *iobase)
> > > > >   {
> > > > > -        iowrite8(0, iobase + MAC_REG_PAGE1SEL);
> > > > > +	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
> > > > >   }
> > > > >   static inline void  vt6655_mac_select_page1(void __iomem *iobase)
> > > > >   {
> > > > > -        iowrite8(1, iobase + MAC_REG_PAGE1SEL);
> > > > > +	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
> > > > >   }
> > > > >   #define MAKEWORD(lb, hb) \
> > > > 
> > > 
> > > Thanks for the explaination.
> > > Since I amended commit message and thought as there is no new commit it
> > > should still be the same patch.
> > > 
> > > Is it ok if I send a new patchset based on the previous conversations?
> > > I have four commits now, 4th commit being just the commit message and
> > > this patchset doesn't have s-o-b issue.
> > 
> > Look at other submissions on the mailing lists.  When you submit a new
> > version of a patch, it is stand-alone, with no dependancies on anything
> > else, otherwise tracking that would be impossible, right?
> > 
> > I suggest reading through the kernelnewbies.org "first patch submission"
> > tutorial first as I think it will answer questions like this.
> > 
> > good luck!
> > 
> > greg k-h
> 
> Thanks for taking time.
> 
> If my understanding is correct, every version of the patch should
> include all the patches/patchfiles and it should explain what happened in each
> version(in decrement order) through a coverletter. Please correct me otherwise.

I recommend reading the in-kernel documentation about all of this which
can be found at Documentation/process/submitting-patches.rst in the
kernel source tree.  That should explain all of this and is recommended
reading first if you have questions about how to create and submit a
patch.

If after reading that, you have specific questions, please let us know.

thanks,

greg k-h
