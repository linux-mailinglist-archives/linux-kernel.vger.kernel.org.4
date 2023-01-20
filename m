Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56F67675651
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:04:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbjATOEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjATOEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:04:31 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC488213C;
        Fri, 20 Jan 2023 06:04:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 3400132008FB;
        Fri, 20 Jan 2023 09:04:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 20 Jan 2023 09:04:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674223468; x=1674309868; bh=vsKSj2CvmP
        6CpsO03AZ7BlYEKXrxtx0vQGIeYW1xqzo=; b=fxDb9sZGMAtqfEKORRdgVZO4Ol
        mSzJzjMjfP3WI0K6lTiN2mu7AV6AwIN4R+Ehd4oqgyOirxlcG4O8aMv014j/KNEz
        jmA05ls8FGo/o9HXImna++YWDsKFWu/bcd3/ugqQj/ToTXQriM6Dv6LUuemt9ljY
        6CNn6SPQI1JrjalzperDv+tEKjjZ53U+lwp2sm4sNL5LNYNlHGcez+Bl9IgSDim7
        e3RtQE6NV3xoSqBJVU1i84OxJW40D1S+0yCMmPHIO1iB/dQookTM3a2xceSsqgPM
        Nf1xU2nABtC9R9r84TEST/6OG+U5qcDd6b1KbwCVP+dyvXRCpI0f7NqYCcNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674223468; x=1674309868; bh=vsKSj2CvmP6CpsO03AZ7BlYEKXrx
        tx0vQGIeYW1xqzo=; b=ILiMhwlotDUzS/kZTwsNwwHoduMY+BmiLULsnitGrKIF
        Qg1rD5keKqa6+cVI/bouS+lOPAOmLngmbn3pZ49HcQuiDe5Q5lyj0u5Q639QIhAp
        qYbuWFBTzHMy+wEu+5G9lz6fNhh9MhjpZvm3/YwZon8gMgAVI0C7Y+b4MzotxHTl
        8eW4+sNYQP9K+BcHuPlYxwDtekGqAJNm356OR3zFJEsH8EkyOAnwp7C75FU2C6vW
        2rygOafQROActU6DJYGy1R+S6RlpZztpN7KC82L81QJGmmqltFrGsIgGzidJcWFg
        PSoo2KFZ4lSUDFhZRSf1hsToqOIM5HIczcVNZr6IGg==
X-ME-Sender: <xms:bJ_KY4P0gOcShmEscZo27LT8AEFGfaYo7hg_c-6FlXyEgCBW1UQz8Q>
    <xme:bJ_KY-_pT7jMenKrsT6KggKtMaBJRhgdGg2Ak7wOqufAFxqi3iXtToi23gT7yRAgt
    B_GbndBcTZCTg>
X-ME-Received: <xmr:bJ_KY_Ss5yfotXpvIxxB2LQtyf3tvEGhePi0kB3GX6d5b2CP-foivjy_23AUpvUesdg0fvUv3yk9vMo8ZVh3WVFyTWnikDy09pdM9g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:bJ_KYwtI23BdXoO61LHYJEqdfwZ_MFWobyqvz6HoPtjrBQBZGtTD0A>
    <xmx:bJ_KYwdTf0AT0LtqJ5-4ss5hOMTLIJcM3EKPFs2pQj3amyNKSyoZzA>
    <xmx:bJ_KY01AKfhSfxYE5hTWkUc-gDWBtz6p2pVTbOQ__ebehdDgG1NcVA>
    <xmx:bJ_KYzt4SDciNPj0CmnCGfBtpxfDtbQsS3vWQwUfYOEs4IUbSeC2Bg>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 09:04:27 -0500 (EST)
Date:   Fri, 20 Jan 2023 15:04:26 +0100
From:   Greg KH <greg@kroah.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Colin Cross <ccross@android.com>,
        Olof Johansson <olof@lixom.net>,
        Thierry Reding <treding@nvidia.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patch in the usb tree
Message-ID: <Y8qfavvwqZyvq4Kw@kroah.com>
References: <20230119152605.03588e9b@canb.auug.org.au>
 <Y8kyJcSYW0IOMuzU@kroah.com>
 <Y8lEhwT3VWEn9w+R@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lEhwT3VWEn9w+R@orome>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:24:23PM +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2023 at 01:05:57PM +0100, Greg KH wrote:
> > On Thu, Jan 19, 2023 at 03:26:05PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > The following commit is also in the tegra tree as a different commit
> > > (but the same patch):
> > > 
> > >   2648f68bd0ac ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller binding")
> > > 
> > > this is commit
> > > 
> > >   20cdc1607ea0 ("dt-bindings: usb: Add NVIDIA Tegra234 XUSB host controller binding")
> > > 
> > > in the tegra tree.
> > 
> > Is that going to be a problem?  Git should handle merging that just
> > fine, right?
> 
> This one shouldn't be a problem. I can also back this out of the Tegra
> tree. However, I also carry
> 
> 	6e505dd6804f ("arm64: tegra: Enable XUSB host function on Jetson AGX Orin")
> 
> which you picked up as
> 
> 	1b17df99730a ("arm64: tegra: Enable XUSB host function on Jetson AGX Orin")
> 
> That one is a bit problematic because I had to manually apply it on top
> of the Tegra tree because of some rework of the DTS files. I think this
> managed to thoroughly confuse everyone and the version in linux-next is
> now not what it should be.
> 
> Is there any chance you could drop it? If not I could back out the DTS
> rework and schedule that for the next release. I'd rather not since I've
> been trying to get that in for a while now, but it's not worth a revert
> in your tree.

Now reverted in my tree.  If there's anything else I need to revert,
just let me know.

thanks,

greg k-h
