Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864306C894A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 00:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjCXXd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 19:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbjCXXdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 19:33:24 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFBB22683
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 16:33:21 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 199FA5C00C3;
        Fri, 24 Mar 2023 19:33:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 24 Mar 2023 19:33:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679700799; x=1679787199; bh=tn7YA7EueD9nB
        ACO1dR5S4VU6L2ppxsc6YNtMLLFUKM=; b=AViPobqC3r4RMtsDEoRe6ykoJjDYF
        7tsqBpqUzdWchOd7Z9yWpsRARn+agZAhRgA4PIEoUhYeGKu7yiN0DzUJd4YGBIoL
        prqGGmQIiJ6u0ZKtIkdK/VJWtA9bhYvQZKrd/QvzGB9fFhmUyJBEOnZrnTeL9OrW
        DqRnzmHYk3RH3SY6Xyu2si+aNtcgK3XQmlVwcNQjvJOlCy1wMUMkUP+4fY1IGrh1
        T6fpdh3Bi0JUKMh50pnablaEHiYj4xAmpENr2eflz22lhFn20qL8Q2RSSM1GwUdV
        ks0B4ZlVdZzLkaW8TpeMFVz612AvRHbAnK9wiS0/O/w1t0FFjyU+6oKvQ==
X-ME-Sender: <xms:PjMeZBiaEOzh2QtvUEodGpl4dk1SjCr_DfdFCxyTxVWA_MBownnyQg>
    <xme:PjMeZGBImZMQsI8Od99Gh3SFC8cw-IIAnbVDVyqP-k-da_5iQynatsHGHpbbpbrkK
    JQI1e7BVLbgmKRdNto>
X-ME-Received: <xmr:PjMeZBFpKn_fyLeh_ldw0MzKLO9Ga_8xOVnkSCkeguhbkRQPBTutX-Kgo1goC7A4ErP_ILr34_nnMsqMQE2QWaZDhD_cB-StZm4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:PjMeZGRuAx5CRiorQU0GLNRVzsf0BvMEpj8WFMOcSaKh7q6HJk8Nog>
    <xmx:PjMeZOycF5WSVBDjfdZKfwemrutCotDIRo_k1NQoNi2Js2w6diDRLw>
    <xmx:PjMeZM50gIRjJH46-bihm6NgZDd1TJQ0nm9PfWgcViZSsE3kWFUVgw>
    <xmx:PzMeZDpizCt063bhH1tWbzezbE4RqnJsKczyTzRut7x7hVjDEM4cCA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 24 Mar 2023 19:33:16 -0400 (EDT)
Date:   Sat, 25 Mar 2023 10:35:52 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Brad Boyer <flar@allandria.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
In-Reply-To: <20230324085927.GA6354@allandria.com>
Message-ID: <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org> <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com> <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org> <20230324085927.GA6354@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brad,

On Fri, 24 Mar 2023, Brad Boyer wrote:

> On Fri, Mar 24, 2023 at 10:13:51AM +1100, Finn Thain wrote:
> > On Thu, 23 Mar 2023, Geert Uytterhoeven wrote:
> > > On Thu, Mar 23, 2023 at 7:02???AM Finn Thain <fthain@linux-m68k.org> wrote:
> > > > --- a/drivers/nubus/nubus.c
> > > > +++ b/drivers/nubus/nubus.c
> > > > @@ -34,6 +34,9 @@
> > > >
> > > >  LIST_HEAD(nubus_func_rsrcs);
> > > >
> > > > +bool procfs_rsrcs;
> > > > +module_param(procfs_rsrcs, bool, 0444);
> > > 
> > > With the expanded functionality, is "rsrcs" still a good name?
> > > Perhaps this should be an integer, so you can define different
> > > levels? E.g.
> > >   - 0 = just devices
> > >   - 1 = above + boards + public resources
> > >   - 2 = above + private resources
> > 
> > That really depends on how the proc entries get used. I think it's 
> > probably going to be developers who would use them so I consider all 
> > of this to be outside of the UAPI and subject to change. But it would 
> > be nice to hear from other developers on that point.
> 
> I don't know of anything that currently uses them, but there's a number 
> of potential uses depending on how far we want to take things. A real 
> video driver for X.org for some of the more advanced cards could take 
> advantage of some of the secondary information made available. I've got 
> a number of NuBus video cards with some acceleration capabilities that 
> were pretty advanced for the time.

Good point. I had not considered Xorg drivers. But I'm not sure why 
userspace drivers would access /proc when they already need /dev/mem or 
some more modern graphics API to be implemented by an in-kernel driver.

> There's even a driver in the ROM on video cards that could be used, but 
> that also requires more emulation of the MacOS environment. KVM could 
> potentially need more information if we got it running on m68k, although 
> I doubt any real Mac has enough RAM to make that useful.

You only need a few MB to run MacOS (or an early Linux distro). So I 
rather think that KVM could be workable with 64 or 128 MB of RAM.

The /proc/bus/nubus/boards file is not affected by this patch, so userland 
tools could still identify the available boards if need be.

> I haven't looked at a Radius Rocket (a Mac on a card) to see if it has 
> anything useful in these, but I wouldn't be surprised if there are 
> useful things there. I've never tried to boot Linux on a system with one 
> installed or booting Linux on the card itself. I have booted a second 
> instance of the MacOS on one, and I seem to recall it shows up as a 
> Q900. I have a couple x86 system cards that were intended to run DOS as 
> well. There was an Apple II card for the LC slot, but I don't own one. 
> LC slot cards show up in software as NuBus, as I recall.
> 

I think those cards are in the same category as video cards in the sense 
that userspace drivers would need /dev/mem.

> It wouldn't be in userspace, but we could end up needing to pull 
> firmware out of them for a number of different cards. I've got a couple 
> SCSI cards that would need to have firmware loaded at runtime, and the 
> ROM would have the default version even if we also allow a firmware file 
> to override that. Based on the existing qlogicpti.c code, the ISP 1000 
> chip (found on ATTO SiliconExpress IV cards) needs firmware. The older 
> SiliconExpress cards all appear to use various ESP chips, so they likely 
> don't need anything special. I suspect the various MCP based cards have 
> useful things on the ROM for a driver to use. They each have a 68000 
> chip on them running A/ROSE, which is presumably loaded from firmware as 
> well. I have both ethernet and serial cards based on this platform. It 
> appears that a driver for the specific card has to be loaded into A/ROSE 
> on the card after it boots.
> 

I had not considered that /proc could be used that way. Unfortunately, the 
length of procfs entries is limited to PAGESIZE. Larger entries are listed 
but have length 0. So I think this isn't going to fly.

Probably /dev/mem or a MacOS utility, or a ROM dump created by a MacOS 
utility, would be needed to extract firmware from the MacOS ROM, such as 
the firmware used by the IOP co-processors (which are standard equipment 
on some models). The same solutions (though not ideal) could also work for 
slot resources.

> I've got a bunch of cards that I've never even looked at the resources 
> built into the ROM chips, so I'm guessing on what might or might not be 
> useful. At one point I was buying every card I could find that looked 
> interesting, and many of them I've never tested. I have crates full of 
> stuff, plus a bunch stacked up that came in original boxes.
> 
> Checking them is disabled now, but some Macs have fake NuBus resources 
> for some of the onboard devices that show up as if they were in a 
> virtual NuBus slot 0. Scanning that apparently caused problems on some 
> models (presumably a bus error, since it would be accessing invalid 
> addresses). Really old kernels had code to scan that protected by a 
> compile time option.
> 

I can't figure out why procfs access to the slot resources from pseudo 
slot 0 would be desirable (?)
