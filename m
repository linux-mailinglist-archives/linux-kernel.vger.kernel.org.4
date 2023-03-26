Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF36C9232
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 05:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjCZDTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 23:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjCZDTZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 23:19:25 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C413EB455
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 20:19:23 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4BB5F5C00D8;
        Sat, 25 Mar 2023 23:19:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 25 Mar 2023 23:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1679800761; x=1679887161; bh=3UntI3/+PCVTg
        DIuGFOF1Ecl1yOb72vFBAvaAjk/4Pk=; b=MVPMXGCRwlm3K+F0ilbAPfuvy6lkd
        3hS3mt49wzQCCk7aNzzZrRsV61rI+kjBvwiDO/Zj7IRjkMkzurs9Kz4FFb7al6c2
        fC8Mc2HF/CslE0pINnCrf2R/oJ0shKgndd/MwmONsCJUS9nDe/qUKnYv952ogucv
        OslATkKfzJugje6eCvVxBGUInDgda3qZwrOK6vFCn8JEFqvkAv+SuIQj1XdUvd7W
        SWhllxEHzH0m9vG6gvtw2fFl/uIbSY8HWUgggCqfDS1uWQeSeU1YH6sVXlQzlY+e
        TSVDfuXui0CmDvupWNyMkrFhZ7H9fP8tpzfzDe6XU3cMTLpHq1uk5T33Q==
X-ME-Sender: <xms:uLkfZFDne9UiEiN2PYnLFJrlrJeEIgToPAjbyDG0vIgpWOsAJC55FQ>
    <xme:uLkfZDh5SR1dzgtdgY4FbjY4f0WBFen1r6fHyixhnL8xMIbsZI-Udvu_uRt20xs2l
    eBMtgQiXdB7Ko5gYuo>
X-ME-Received: <xmr:uLkfZAlFMcInPaKBWGeEjioqaplhPC8bmeD9yrh69q-VN18XG3qBiLCBq4fAsHkpjYxHewBLidGsBITa0_XHz_nyZRX8fFL1UZg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegledgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeelueehleehkefgueevtdevteejkefhffekfeffffdtgfejveekgeefvdeu
    heeuleenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hfthhhrghinheslhhinhhugidqmheikehkrdhorhhg
X-ME-Proxy: <xmx:uLkfZPzmL6p7fyVrG_v8UhO4QvbpQIkWrIDaRM09o47sUjSiZJoxRQ>
    <xmx:uLkfZKSFfzTesv8ADXwsm3J0uM_HBr-cHi83B3qL_eu3iGUuwvpOgQ>
    <xmx:uLkfZCbbc9gSSwfpOagSg_sYiygtIxe3xjKm5YrnxSKQUY_bmxkWXA>
    <xmx:ubkfZNJVZrJsAj0YMmthgSB3QicgXgCoH8lI3mwdoM_b0TuQTmv0qA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 25 Mar 2023 23:19:18 -0400 (EDT)
Date:   Sun, 26 Mar 2023 14:22:14 +1100 (AEDT)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Brad Boyer <flar@allandria.com>
cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nubus: Don't list card resources by default
In-Reply-To: <20230326000056.GA31801@allandria.com>
Message-ID: <2b42fa38-18f3-971f-635c-b37609b4beae@linux-m68k.org>
References: <5b7c473247d66776343d82a55b9815195b1b11fb.1679551394.git.fthain@linux-m68k.org> <CAMuHMdUJ6kbpYGTjyY5dX+-YRv3pL0ydG3HQ-H1khyeqLOa05A@mail.gmail.com> <072fd894-ec50-ae5f-2be5-ebbeb0e7b39b@linux-m68k.org> <20230324085927.GA6354@allandria.com>
 <0cd7f288-ba43-7764-01a7-2e1e5c7a1640@linux-m68k.org> <20230326000056.GA31801@allandria.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-0.7 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Mar 2023, Brad Boyer wrote:

> On Sat, Mar 25, 2023 at 10:35:52AM +1100, Finn Thain wrote:
> 
> > 
> > I think those cards are in the same category as video cards in the 
> > sense that userspace drivers would need /dev/mem.
> 
> Probably. I was just thinking that having some of the information 
> already parsed out might be useful. It's hard to say without having 
> anything written to use it.
> 

If someone wanted to write something that uses the procfs information they 
could still do so, but they would have to enable a kernel parameter first.

> ...
> However, the system ROM doesn't use exactly the same structure as a 
> NuBus expansion ROM. That might complicate such work. It might be easier 
> to use the firmware infrastructure to load them from files and extract 
> the drivers from the latest system software that still supported 
> anything with an IOP. The updated IOP drivers are each separate 
> resources in the system file that could be extracted with native 
> developer utilities in MacOS. Then we presumably have the latest. I've 
> never found any hint that the IOP hardware was any different between 
> models that have them.
> 

My thinking was that a firmware cutter (whether it was for ROM resources 
or slot resources) would remain separate from the kernel, as that seems to 
be the usual pattern. The existing mechanisms for distributing to 
/lib/firmware and loading from /lib/firmware could be leveraged.

> > I can't figure out why procfs access to the slot resources from pseudo 
> > slot 0 would be desirable (?)
> 
> I'm not sure. Someone clearly thought it was useful in the past.

That's not clear to me.

Someone clearly thought that the procfs files may be useful for some 
unknown purpose in userspace. And someone clearly thought that the slot 0 
resources may be useful for configuring drivers in kernelspace.
Neither of those panned out.

The only possible use I can think of for slot 0 resources in userspace 
(e.g. a "TechTool" for Linux) would be better served by mmap'ing the ROM 
using /dev/mem.

> I don't think I have any models with anything interesting there. I 
> suspect the main thing would be an equivalent to the ROM on a video card 
> for the built-in display adapter on those systems.
> 

Only to the extent that such hardware cannot be probed or simply inferred 
from bootinfo records already provided (like gestalt id). But the slot 0 
vs. bootinfo question seems unrelated to the procfs question, right?
