Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 033C668B2E4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 00:39:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229523AbjBEXjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 18:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjBEXjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 18:39:14 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD7D199E8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 15:39:12 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id lu11so29717625ejb.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 15:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PWuWsZM39bUXwfvV+mE+c8HaXpPK0kUbfUyDhM2lnpI=;
        b=UwV7HjXhEIWOwPVMs4jyXvikTMeH2OCs48EnIeBs+AUb0n5dTxf5kbDjajhm8LqH/4
         VMVfYLxxnRY3LHj5eOR+VN4Fq3ej4f5MCgho5kQNa5vEz1rfOY6rUPovaKG0wQEY27mh
         tT/99xR90WmHArWyAuLhYHqdb6rARSPu6I7aD4MZmsFI8fc+6As4Sp8O03gvjlABMw6r
         iLspryHGzcD+BeZRd9Cq2njzyZwb47WuA5Y5+zqNwzpSwqND4C0a5GjXUhtOZ5Liw2nZ
         ZGl0J0g3Vqf/qbRRoSBjNv573Z7RBaCRX7MzshR/0GIGrEOXi8YVM6L0r5lJIzjOq8lp
         ysQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PWuWsZM39bUXwfvV+mE+c8HaXpPK0kUbfUyDhM2lnpI=;
        b=mQZwCQWxhv2iOGYczY7gEmgBFCrgUccrdKxPx/VnQ2Fn9lp3jbpZKLm/zRd6mZ3axO
         3m+Ol1+onR4D6nkW1YWt40duti55HaRKmnS3r8sKIhNskPQQvt6icmL9hrOol9mZcnRu
         on5NnqKbgsn/9IHxfJ5hR+FwJndwpvyb4NceEyg2nMag+5IBFrglNNY80NV1pgooqgfQ
         eVsjJh22Zj7io7HHppN0fYvWayS8cyEtxtVSeb71jG2oxwLakN4Md29xbFfw7PyDYjki
         DfmBYDCnJlaSzMrSQmxcW46qBB9dyFnelyz22HdjGDOz/FSpjpUv/B9XIJjaqg+2pyB1
         fIoA==
X-Gm-Message-State: AO0yUKXCFOVgQKzNB3xaklVG4kOERHudsWcwabtfZZzer5v8qCLXhRIo
        CP/7Kb/us20yLP0u0d5v+207h84VXu0=
X-Google-Smtp-Source: AK7set8z7Hiw9gkweCqS/mS3UXiV0FnY+h9kHYs+fVqrFE6N7xKAkB6S9KqvFfp+Dmyl1LsTLLxJHg==
X-Received: by 2002:a17:906:230f:b0:844:d342:3566 with SMTP id l15-20020a170906230f00b00844d3423566mr17691530eja.22.1675640350894;
        Sun, 05 Feb 2023 15:39:10 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id jo10-20020a170906f6ca00b00878812a8d14sm4666954ejb.85.2023.02.05.15.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Feb 2023 15:39:10 -0800 (PST)
Date:   Mon, 6 Feb 2023 00:39:08 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 05, 2023 at 08:12:31PM +0100, Christophe JAILLET wrote:
> Le 05/02/2023 à 19:11, Guru Mehar Rachaputi a écrit :
> > This patch is to fix checkpatch warning: "Macro argument 'iobase' may be better
> > as '(iobase)' to avoid precedence issues" changed to inline function. In
> > relation to this, names of the callers of macro are also modified to call
> > this function.
> > 
> > Signed-off-by: Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
> 
> Hi,
> 
> this patch should be v4.
> You re-sent it with a modified commit message (the position of your S-o-b)
> 
> The idea behind patch versions is to help maintainer. With the way you did,
> now 2 patches stating v3 are available.
> Which one is the correct one?
> The maintainer would need to look at both, search for differences, maybe
> look at the date of the mails.
> A v4 would be much easier for him.
> 
> 
> Also, when you send an updated version of a patch, it should always be
> "complete". I mean that the patch below seems to need v2, and maybe even v1
> (which is apparently not on the linux-kernel mailing list).
> 
> A maintainer can't know by himself what is needed and what is not.
> 
> So you should resend a new patch.
> It should be a v4, and it should include what is needed from (v1?), v2 and
> v3 all together.
> 
> CJ
> 
> 
> > ---
> > Changes in v3:
> > 	- Whitespace error from checkpatch fixed
> > 
> > Changes in v2:
> > 	- Macros with one statement that is to call 'iowrite8' function changed
> > 	to inline function as reviewed by gregkh@linuxfoundation.org.
> > 	In relation to this, names of the callers of macro are also modified
> > 	to call this function.
> > ---
> >   drivers/staging/vt6655/card.c    | 3 +--
> >   drivers/staging/vt6655/channel.c | 2 +-
> >   drivers/staging/vt6655/mac.h     | 4 ++--
> >   3 files changed, 4 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> > index a6ff496b01b6..d2d122dc16d8 100644
> > --- a/drivers/staging/vt6655/card.c
> > +++ b/drivers/staging/vt6655/card.c
> > @@ -643,8 +643,7 @@ void CARDvSetRSPINF(struct vnt_private *priv, u8 bb_type)
> >   				   &byRsvTime);
> >   	iowrite16(MAKEWORD(byTxRate, byRsvTime), priv->port_offset + MAC_REG_RSPINF_A_72);
> >   	/* Set to Page0 */
> > -        vt6655_mac_select_page0(priv->port_offset);
> > -
> > +	vt6655_mac_select_page0(priv->port_offset);
> >   	spin_unlock_irqrestore(&priv->lock, flags);
> >   }
> > diff --git a/drivers/staging/vt6655/channel.c b/drivers/staging/vt6655/channel.c
> > index e9a44bcebe32..60b445c38424 100644
> > --- a/drivers/staging/vt6655/channel.c
> > +++ b/drivers/staging/vt6655/channel.c
> > @@ -121,7 +121,7 @@ bool set_channel(struct vnt_private *priv, struct ieee80211_channel *ch)
> >   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWRCCK);
> >   		RFbSetPower(priv, RATE_6M, priv->byCurrentCh);
> >   		iowrite8(priv->byCurPwr, priv->port_offset + MAC_REG_PWROFDM);
> > -	        vt6655_mac_select_page0(priv->port_offset);
> > +		vt6655_mac_select_page0(priv->port_offset);
> >   		spin_unlock_irqrestore(&priv->lock, flags);
> >   	}
> > diff --git a/drivers/staging/vt6655/mac.h b/drivers/staging/vt6655/mac.h
> > index b9a7ca0fe604..ae3064303691 100644
> > --- a/drivers/staging/vt6655/mac.h
> > +++ b/drivers/staging/vt6655/mac.h
> > @@ -539,12 +539,12 @@
> >   static inline void vt6655_mac_select_page0(void __iomem *iobase)
> >   {
> > -        iowrite8(0, iobase + MAC_REG_PAGE1SEL);
> > +	iowrite8(0, iobase + MAC_REG_PAGE1SEL);
> >   }
> >   static inline void  vt6655_mac_select_page1(void __iomem *iobase)
> >   {
> > -        iowrite8(1, iobase + MAC_REG_PAGE1SEL);
> > +	iowrite8(1, iobase + MAC_REG_PAGE1SEL);
> >   }
> >   #define MAKEWORD(lb, hb) \
> 

Thanks for the explaination.
Since I amended commit message and thought as there is no new commit it
should still be the same patch.

Is it ok if I send a new patchset based on the previous conversations?
I have four commits now, 4th commit being just the commit message and
this patchset doesn't have s-o-b issue.

or

should I undo all the amends?

-- 
Thanks & Regards,
Guru
