Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77453713A15
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 16:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjE1O2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 10:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjE1O2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 10:28:13 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090BFB8;
        Sun, 28 May 2023 07:28:08 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0EE50320024A;
        Sun, 28 May 2023 10:28:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 28 May 2023 10:28:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685284085; x=1685370485; bh=bO
        uIPzG12g4gcSOpXVBNfgdgSQC3jGZB6+tVXF5BZVk=; b=f1Jky7Op27OksrZFCD
        vQ0Al/TDdm+YKHS5v3n3kLZh7e/6Y87v4DgW6bvtGdJyHABVQHecKn7jxNRjj7PT
        X1fxDRwOeNDz7j6JPQck322kbHsEfvvXaOEx5YZz/22+c08NECltzZHKXQqx1DJ4
        af/e97FlhKYIWRkxo84uGrW4bAS/lhNVtwDTf68eQDJpdgFU47oD1b+GtEbBCbpa
        pJ4LJtaCvwZJAKhZAp2xMmeJM4ucHbEsU6kQfFvdDClgdRtoi2B/sykUBPzINZns
        wpsjBFzzS64JF2PuhYxDOc5bViaI1hTJVY47BrwebDbupCm7szM1GOuaPSbLRowT
        6Jmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685284085; x=1685370485; bh=bOuIPzG12g4gc
        SOpXVBNfgdgSQC3jGZB6+tVXF5BZVk=; b=zIWxzHLpDyEPbkPWrVuL5DdLo1j/U
        FJoe26iyhouOJpAd3lHEs0HqycHZpG1Ow5Gd3ananFchXW5tJztMKIK3yT40c+YN
        P7tfqSmRGTzUnCu1ArV3VVW2HybRvjMwvP7zg+i2raUbowG2lyoYZRkN5F9Ss4gB
        lX2erYqTvYRD5hBjOgf2VeNL0lV4irto6cJkGhsOKVY30ZBdliR+9SYuLYojcmpw
        KYMPhfBkkzjq3w0N5zzDn/EkjpLLMS6sqDRrZU6lJo+bQY1bJ9wnqsC8hxWCb1H3
        HRG6WNJ3cDQtRDfA5y87gDFEpePPbF3vgN2IBcUnpqwcrUHuQ42qhOf7g==
X-ME-Sender: <xms:9WRzZIf2nflnW_626wl-lP4HnPnwDk8B9xcTDbYcgDM4D46DO-gsPA>
    <xme:9WRzZKNdKdIJ9wGKxpoZ3JEG7MXiN4fO3IMzwEeq6P2EI6lhl2XgZtI0IPZ5u07Mu
    K3iAutrdpQNwg>
X-ME-Received: <xmr:9WRzZJioYUmClCDHxHXq_OvW3818hR1BYfVt7aRiXKrctvH3E1HCAfDfrI7l>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekfedgjeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:9WRzZN_EEH0qKpInUKLeGkNvHVeJPuBPPJJjN8x0y73Po6Oe4aEx8w>
    <xmx:9WRzZEvx22ymQP87oirK2HZhtmZVSwzYk7LuCWFgw1-_5Fbu50z7rA>
    <xmx:9WRzZEG7efAqjL8Ifp2qg_QT2T11FY0yInoPH31HwJGGZ7bQ6oAuwg>
    <xmx:9WRzZCDnqwEU5R7aIeh0jv1Nt2Iq8WbNiYos8kEUQSEkmpzPqFP0vA>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 May 2023 10:28:04 -0400 (EDT)
Date:   Sun, 28 May 2023 15:28:03 +0100
From:   Greg KH <greg@kroah.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2023052846-surfer-spore-e873@gregkh>
References: <20230515123524.74e7bda3@canb.auug.org.au>
 <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 15, 2023 at 02:01:08PM +0300, Roger Quadros wrote:
> Hi Stephen,
> 
> On 15/05/2023 05:35, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Today's linux-next merge of the usb tree got a conflict in:
> > 
> >   drivers/usb/dwc3/gadget.c
> > 
> > between commit:
> > 
> >   c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
> > 
> > from the usb.current tree and commit:
> > 
> >   813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens")
> > 
> > from the usb tree.
> > 
> > I fixed it up (I think - see below) and can carry the fix as
> > necessary. This is now fixed as far as linux-next is concerned, but any
> > non trivial conflicts should be mentioned to your upstream maintainer
> > when your tree is submitted for merging.  You may also want to consider
> > cooperating with the maintainer of the conflicting tree to minimise any
> > particularly complex conflicts.
> > 
> 
> > diff --cc drivers/usb/dwc3/gadget.c
> > index d831f5acf7b5,5965796bc5d5..000000000000
> > --- a/drivers/usb/dwc3/gadget.c
> > +++ b/drivers/usb/dwc3/gadget.c
> > @@@ -2700,21 -2699,6 +2700,26 @@@ static int dwc3_gadget_soft_disconnect(
> >   	return ret;
> >   }
> >   
> >  +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
> >  +{
> > ++	int	ret;
> > ++
> >  +	/*
> >  +	 * In the Synopsys DWC_usb31 1.90a programming guide section
> >  +	 * 4.1.9, it specifies that for a reconnect after a
> >  +	 * device-initiated disconnect requires a core soft reset
> >  +	 * (DCTL.CSftRst) before enabling the run/stop bit.
> >  +	 */
> >  +	dwc3_core_soft_reset(dwc);
> 
> Please drop above call to dwc3_core_soft_reset().
> 
> > ++	ret = dwc3_core_soft_reset(dwc);
> > ++	if (ret)
> > ++		return ret;
> >  +
> >  +	dwc3_event_buffers_setup(dwc);
> >  +	__dwc3_gadget_start(dwc);
> >  +	return dwc3_gadget_run_stop(dwc, true);
> >  +}
> >  +
> >   static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >   {
> >   	struct dwc3		*dwc = gadget_to_dwc(g);
> 

Can you verify I got this right in my usb-next branch now?

thanks,

greg k-h
