Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD8A9713A77
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 18:07:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbjE1QHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjE1QHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 12:07:11 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4664EB9;
        Sun, 28 May 2023 09:07:10 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 8515F3200564;
        Sun, 28 May 2023 12:07:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 28 May 2023 12:07:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685290026; x=1685376426; bh=3U
        4mYHfz/R9tY91h8fKoPaz8ksrmh2SRnSoLZa0qe3A=; b=r7MVG1xw3NnLv6kxfo
        I+kjH4tTgmYYqL/icGvMTi6Xg+0/nZgmXZn0i4Cryv94ltvZqwmRlN0V8kqQgzYE
        S8085h0PALFu1xu5wjv871FfG/ZSKSG4BDpizWuqO4Bchgxs8o3BuUvSYZnLprwK
        HVZVlV/TCNm1cbZRzsaT8h/WVScher5E5qUNBifgTA5inbEv+v63vKFQnU2Ev9gH
        iMZlPkPZaKadHdxrLlPjh99L8BCZEl5qhojTaXKVu3PtV/RDaqv9f2ESAmCQqj7S
        7wbwYhMiIi+au+InrUmBQGuDlaCrAnM+zU6CYkh9sfPnxYP5Hy3qLEJ1yX+svNa5
        nagg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685290026; x=1685376426; bh=3U4mYHfz/R9tY
        91h8fKoPaz8ksrmh2SRnSoLZa0qe3A=; b=mNxsXAlTiNoIeWRGaKyQBV4JNjNbx
        ntYPDg7VJEjFi1CZQ+MXOr8EH2LV9JaVP996qUTSY2MZyFnQQKiXY/yLkQPlmkVi
        hEXN0RAZLmO65OZEWKeKlqzK4lJ7SK4jAeJIB4y27OenglO70iQmOgFWtxJ+7zuU
        GVRgVHjUn+veXmItqrYBKTWK3OBLLqoshi3kH2gFVYOerDnMgAELz9RNVD1RB0B6
        Rr/C62B/78SgTQ+XDCEY0NrsINKElXzD+6ud5rY0leabygKqMD+G4avTdtmPV12s
        b+zTMAbLHd9UlNrl2jPjZoe8pV9SfGIfOPC+vjV60HixDVsDF3JmZmhSQ==
X-ME-Sender: <xms:KXxzZEl2ipkmXaYBeIxPfEBK0vUeoHOGDxdObJDgUd7x7JZy5nqz6Q>
    <xme:KXxzZD0PfGdnDPcBRJtiL1n9M6NEqCnuHX4Ql5Jz1wLBqkqETJu70TQXaHEau-c2H
    rcdYggg40wbTw>
X-ME-Received: <xmr:KXxzZCqjH28oVptQ__Rvot8pzDO5zV79SJ7JL5mNWVHat43S_dWAhzw8Lozc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekfedgleekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:KXxzZAmhq9iMivWFvzU6FZBlNPSrDdbfrRfsZHUURAs-QCrjF68xhw>
    <xmx:KXxzZC1rUfLFVBFm-GJHMcMl4dvHtYUMm821kjiaMikWdJOunEeF5Q>
    <xmx:KXxzZHusV6dRlwPNlDO1HXZra8WEjxNL1kYpHWhyCjOulLhuFoAqjw>
    <xmx:KnxzZLsiTSonMFSOj1uwjdbXp69BNOBlAgm3hDJpgz0Zkq-ac25M-Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 May 2023 12:07:04 -0400 (EDT)
Date:   Sun, 28 May 2023 17:07:03 +0100
From:   Greg KH <greg@kroah.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Krishna Kurapati <quic_kriskura@quicinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: Re: linux-next: manual merge of the usb tree with the usb.current
 tree
Message-ID: <2023052843-marina-scarecrow-1454@gregkh>
References: <20230515123524.74e7bda3@canb.auug.org.au>
 <5082d743-54b1-7b4c-432c-dfdce1bb772a@kernel.org>
 <2023052846-surfer-spore-e873@gregkh>
 <f604f836-7858-6140-4ec1-9ba95cba6991@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f604f836-7858-6140-4ec1-9ba95cba6991@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 06:48:12PM +0300, Roger Quadros wrote:
> Hi Greg,
> 
> On 28/05/2023 17:28, Greg KH wrote:
> > On Mon, May 15, 2023 at 02:01:08PM +0300, Roger Quadros wrote:
> >> Hi Stephen,
> >>
> >> On 15/05/2023 05:35, Stephen Rothwell wrote:
> >>> Hi all,
> >>>
> >>> Today's linux-next merge of the usb tree got a conflict in:
> >>>
> >>>   drivers/usb/dwc3/gadget.c
> >>>
> >>> between commit:
> >>>
> >>>   c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
> >>>
> >>> from the usb.current tree and commit:
> >>>
> >>>   813f44d57e19 ("usb: dwc3: gadget: Bail out in pullup if soft reset timeout happens")
> >>>
> >>> from the usb tree.
> >>>
> >>> I fixed it up (I think - see below) and can carry the fix as
> >>> necessary. This is now fixed as far as linux-next is concerned, but any
> >>> non trivial conflicts should be mentioned to your upstream maintainer
> >>> when your tree is submitted for merging.  You may also want to consider
> >>> cooperating with the maintainer of the conflicting tree to minimise any
> >>> particularly complex conflicts.
> >>>
> >>
> >>> diff --cc drivers/usb/dwc3/gadget.c
> >>> index d831f5acf7b5,5965796bc5d5..000000000000
> >>> --- a/drivers/usb/dwc3/gadget.c
> >>> +++ b/drivers/usb/dwc3/gadget.c
> >>> @@@ -2700,21 -2699,6 +2700,26 @@@ static int dwc3_gadget_soft_disconnect(
> >>>   	return ret;
> >>>   }
> >>>   
> >>>  +static int dwc3_gadget_soft_connect(struct dwc3 *dwc)
> >>>  +{
> >>> ++	int	ret;
> >>> ++
> >>>  +	/*
> >>>  +	 * In the Synopsys DWC_usb31 1.90a programming guide section
> >>>  +	 * 4.1.9, it specifies that for a reconnect after a
> >>>  +	 * device-initiated disconnect requires a core soft reset
> >>>  +	 * (DCTL.CSftRst) before enabling the run/stop bit.
> >>>  +	 */
> >>>  +	dwc3_core_soft_reset(dwc);
> >>
> >> Please drop above call to dwc3_core_soft_reset().
> >>
> >>> ++	ret = dwc3_core_soft_reset(dwc);
> >>> ++	if (ret)
> >>> ++		return ret;
> >>>  +
> >>>  +	dwc3_event_buffers_setup(dwc);
> >>>  +	__dwc3_gadget_start(dwc);
> >>>  +	return dwc3_gadget_run_stop(dwc, true);
> >>>  +}
> >>>  +
> >>>   static int dwc3_gadget_pullup(struct usb_gadget *g, int is_on)
> >>>   {
> >>>   	struct dwc3		*dwc = gadget_to_dwc(g);
> >>
> > 
> > Can you verify I got this right in my usb-next branch now?
> 
> No, the end result is not correct.
> 
> Please apply the below patch to fix it. Thanks.

Many thanks, I got that totally wrong :(

Now fixed up with your commit.

greg k-h
