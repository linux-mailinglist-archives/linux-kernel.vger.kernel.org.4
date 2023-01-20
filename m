Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE467564A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjATOCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjATOCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:02:17 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CAE3C459D;
        Fri, 20 Jan 2023 06:02:16 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C545332007E8;
        Fri, 20 Jan 2023 09:02:14 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 20 Jan 2023 09:02:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1674223334; x=1674309734; bh=bQ9pm+mBpB
        l5Sw4+mLHdw4/LhiTKozGr7tRAm3ulMBw=; b=jfWtK1/DtpEe2YmkTVXbg0xKqw
        sNivVbVU9DqXhWzBSAPPo3ua6IePXct6Dk+gQRcS2eAkAR/98H7znP72jbrJV8Nm
        MulQ2pUubrw7RC8zSZqTWEROqYYDlHiPFu9mYi8fzNWRQ6VAyTdlE/pLsojl02b2
        m60NIcopTzAiKD3McLcUHMZUqgw+nvOZqCBzMc19jWvBkVhBJ7G9BOsxZR+sqXZ6
        FL6D3JraRhQEi4OK2OCT8+aJMH9lcEjuUysKh1aDIo6c/ahnva/uPaAkGUIGPkD5
        lRMhsc6UMajgZQXccaUUAynvjGtMrs9S5tiGzACcVDin1+WLxosRwv+/vvUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1674223334; x=1674309734; bh=bQ9pm+mBpBl5Sw4+mLHdw4/LhiTK
        ozGr7tRAm3ulMBw=; b=N73LA3YmczIJv1ovZVcLu1E6t1sGMHGK/n3REBrWdz3f
        Wsztx9uy9KA96L3IOyuE7aFCtgLZpGueKnJX+bx3sTopfhLR6yZihVKhYRahgVK7
        eJGgDCMKfsj1BcmbGHH8vhdCf8wuSq9bu/DJlxWiQLRPW0l0ZXGZBAYL89Sw3mIR
        U2Z4lpE20olV8fCTJceymyki9XSaZrXy8tr2eOSg8NAWWtb0m5qj9WMy1eKEoIRm
        pw16ZkG+ahVfdk4nXjAGpnJH222aL6I+Of2Z1OAEdMJODLltlv/076bul94ZMbob
        viKHB5C/3fHeiH5l1UlqSZ7ncg/6fAYzb9dIHXsMyQ==
X-ME-Sender: <xms:5Z7KY1UahBWRTJYL_YLwTo2yVRsbyo-Emm-Y653O8hwK7Todc7GG8A>
    <xme:5Z7KY1mwOR3uKZygcQHOwc10kb-CpyspZpJpjx3-ypPv0ih9CnErBcOmVeHV_ljPd
    fqxE9y8jfMlFw>
X-ME-Received: <xmr:5Z7KYxZkbP109MeMm2jVKD-A-E2SaKFVsKjkvrIa9-opeRUIZOIj3o_uYkN_sht94kHtheWQkiejAywVKm-AS7vjfwQOr00E_QkXJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduvddgiedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepifhrvghg
    ucfmjfcuoehgrhgvgheskhhrohgrhhdrtghomheqnecuggftrfgrthhtvghrnhepheegvd
    evvdeljeeugfdtudduhfekledtiefhveejkeejuefhtdeufefhgfehkeetnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorg
    hhrdgtohhm
X-ME-Proxy: <xmx:5Z7KY4XNPeYC83KS9yCA4JPbDOgAryn_r4LQ5oCR2BueGdmvV6hAcg>
    <xmx:5Z7KY_nD1ZcY5UVb0Udom-nZsb1Fk2C46M-MmxE9owEKVqlZHI_zuQ>
    <xmx:5Z7KY1fDiMzNG9XPyZhArhUnU0MfQrgtnhAuHXcomW4u9HE-k1f0aA>
    <xmx:5p7KYx1O1Xm4ZSHQDBbraiPMU9ZJx_-OA1RUdAEZs2MwRnpcajea8Q>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 09:02:12 -0500 (EST)
Date:   Fri, 20 Jan 2023 15:02:10 +0100
From:   Greg KH <greg@kroah.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Sing-Han Chen <singhanc@nvidia.com>,
        Wayne Chang <waynec@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: duplicate patches in the phy-next tree
Message-ID: <Y8qe4hd52B3ltXH8@kroah.com>
References: <20230119153145.598885cf@canb.auug.org.au>
 <Y8jfW2TTnHd3J7R1@matsya>
 <Y8jpFw5mfvyRLX/C@kroah.com>
 <Y8lJiJHHcUO7MXQY@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8lJiJHHcUO7MXQY@orome>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:45:44PM +0100, Thierry Reding wrote:
> On Thu, Jan 19, 2023 at 07:54:15AM +0100, Greg KH wrote:
> > On Thu, Jan 19, 2023 at 11:42:43AM +0530, Vinod Koul wrote:
> > > On 19-01-23, 15:31, Stephen Rothwell wrote:
> > > > Hi all,
> > > > 
> > > > The following commits are also in the usb tree as different commits
> > > > (but the same patches):
> > > > 
> > > >   5c7f94f8bad8 ("phy: tegra: xusb: Add Tegra234 support")
> > > >   e5f9124404d0 ("phy: tegra: xusb: Disable trk clk when not in use")
> > > > 
> > > > they are commits
> > > > 
> > > >   d8163a32ca95 ("phy: tegra: xusb: Add Tegra234 support")
> > > >   71d9e899584e ("phy: tegra: xusb: Disable trk clk when not in use")
> > > 
> > > Ah, ideally these should go thru phy tree!
> > 
> > Yeah, but they were submitted as a larger set of patches with USB
> > changes to me, so I took the whole series (it's hard to pick and choose
> > from a series).
> 
> This has been a recurring theme, so I'm trying to get a better
> understanding of what people expect here. Some maintainers want to see
> a whole series for a single feature (in this case it was Tegra234 USB
> support) even if it crosses multiple subsystems/trees. This has the
> advantage that patches can be arranged such that all dependencies are
> resolved. Other maintainers like things to be split up so that patches
> are easier to pick up.
> 
> Submitters can spell out in the cover letter how they think things
> should be picked up, but they're not always aware of what else is going
> on in the respective trees, so they may get it wrong.
> 
> I personally prefer to pick up DT bindings into the platform tree since
> we're getting into a place where device trees can be properly validated
> and keeping bindings and DTS files in the same tree helps with that.
> 
> But I know that DT maintainers prefer bindings to go through subsystem
> trees because it can help reduce conflicts and that outweighs the DT
> validation benefits, which some platforms may still be far away from
> being able to use.
> 
> DTS changes on the other hand are a different thing. In my opinion it is
> much better for them to be applied through platform trees because of the
> greater potential for conflicts. In any given cycle there are often
> multiple patches touching the same DTS files and currently a lot of
> clean up is going on for validation.
> 
> So I wonder if we should just move away from the current process of how
> we submit series. Maybe a less confusing way would be to strictly
> separate driver and DTS changes into two series. That way maintainers
> would better understand what patches to pick. It also has its own set of
> disadvantages (can't validate DTS changes against DT bindings, and it
> may not even be clear where certain DTS changes are documented).

I don't like splitting them up, so keeping them all together is good.
Make it simple for developers to do, and also simple for maintainers.
If we end up with duplicates at times, what's the harm?

thanks,

greg k-h
