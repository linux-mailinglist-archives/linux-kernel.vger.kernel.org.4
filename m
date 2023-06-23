Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9482273ADF4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 02:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjFWAv1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 20:51:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbjFWAvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 20:51:25 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FE02107;
        Thu, 22 Jun 2023 17:51:23 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E42CD3200932;
        Thu, 22 Jun 2023 20:51:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 22 Jun 2023 20:51:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1687481481; x=1687567881; bh=0Q/gP+COjG4Go
        WKY4HaA9nt8py5Rh2ey5cbB5lWAv3U=; b=XPD377TVN8SB0YtwM68dFTwOH91D/
        oz/BW650ynDMf3lV8+/n3UxZPVQC6aqEaVs2DMUXnCEPUBEYhdume9vUrXJxTxCv
        BZVIggFQINpeO8Tel2Wsq6k+qjjknJAr314S2xkDTLK7W/Ji+PgRsM8JIKLmk8JU
        6eQg231UcNzK0xlw2+9IFsRp+umTZKMt0UhNf7lDTT1/ofrg7WWZ5UvxoCe8/erw
        UBQnFCvQyUZYFTsYHW/78NCeobpsFcDnDIF9sxdwmDGqQkSQB1BqFfyCeqZqzRZJ
        qbQBvbkPF7FGUXB9GEbEwlp+VFRkvWidqMU5Gdmp/fLMlwCjhPJMeRkLA==
X-ME-Sender: <xms:ieyUZK6acEzn9YyEXmN7N6GfOpMtraYTFF3672nGqcDVVP3dQewYjA>
    <xme:ieyUZD5MSHuQBSiYAIMfRq1xMWhHxqDZzc7g1r1ee_bBfoHfHyGKXr-1dl2iXZjgo
    MSvpiBJF1NrXGJrfk0>
X-ME-Received: <xmr:ieyUZJeC0HbXk31M2nNTmacZ1PU91DKnyrob9_afMJieDII1JIC-Z6J7X6RR9guyCgmN6K1EBUyH-ibpxsTo05f9bHUX6fSHMnw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeegvddgfedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevufgjkfhfgggtsehttdertddttddvnecuhfhrohhmpefhihhnnhcu
    vfhhrghinhcuoehfthhhrghinheslhhinhhugidqmheikehkrdhorhhgqeenucggtffrrg
    htthgvrhhnpeefieehjedvtefgiedtudethfekieelhfevhefgvddtkeekvdekhefftdek
    vedvueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhthhgrihhnsehlihhnuhigqdhmieek
    khdrohhrgh
X-ME-Proxy: <xmx:ieyUZHKwMoapk1sOrB6t1QwRIGW5evy2d3NdJv-rkN7knoXt6G4uaQ>
    <xmx:ieyUZOJQd2-rx46V_LRfCBMIu7lursjJw0T2n1gCikcfNKPb2iXtnA>
    <xmx:ieyUZIwYt7UEqR7swRzXGSEJ6vcxJ0_Kuf-upUnU6Z-DsY65h6iQpA>
    <xmx:ieyUZAjXl2HU64dSv3Huca7p2WNyz28zkQUm1TK4QriK_HoBPLUYjA>
Feedback-ID: i58a146ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Jun 2023 20:51:19 -0400 (EDT)
Date:   Fri, 23 Jun 2023 10:52:08 +1000 (AEST)
From:   Finn Thain <fthain@linux-m68k.org>
To:     Theodore Ts'o <tytso@mit.edu>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        tech-board-discuss@lists.linux-foundation.org,
        Kees Cook <keescook@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: Linux Contribution Maturity Model and
 the wider community
In-Reply-To: <20230622173913.GA34229@mit.edu>
Message-ID: <f54e2fc8-0aba-3b62-7870-023f25e11e8f@linux-m68k.org>
References: <20230620212502.GI286961@mit.edu> <5490402b-8b9f-f52d-3896-41090e639e51@linux-m68k.org> <2023062144-hefty-why-305d@gregkh> <04cd7204-cdee-c333-8815-57acbab82721@linux-m68k.org> <20230622173913.GA34229@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jun 2023, Theodore Ts'o wrote:

> On Thu, Jun 22, 2023 at 05:02:10PM +1000, Finn Thain wrote:
> > 
> > You mentioned wasted resources. If you want to generate e-waste, 
> > remove drivers from the kernel. If you want to prevent e-waste, add 
> > drivers for obsolete hardware and then watch the user count climb from 
> > zero as devices get pulled from drawers and dusted off.
> 
> You seem to making a lot of assumptions here, with no evidence to back 
> up your assertions.  The driver question is from twenty years ago, and 
> talks to SCSI cards using LVD (low-voltage diferential) SCSI 3 cables 
> (for 160 MB/s).  SCSI Disks from that era are typically 20GB to 30GB. 
> Compare that to modern SATA disks today that are 10-18 TB in size, and 
> SATA-3 transfers data at 600 MB/s.
> 
> So you are assuming (a) that people just "happen" to have ancient, 20 
> year old cards justlying around in drawers, (b) they have 20 year old 
> SCSI disks and SCSI cables that these cards would actually talk to, and 
> (c) they would think it would make sense from a power, space, and 
> cooling perspective to take this kind of antique storage solutions are 
> use it for actually storing data.
> 

No, those are not my assumptions, those are my observations.

Also, you've incorrectly conflated my comment about "devices in drawers" 
(which was a reference to old Android phones and the like) with an old 
thread about an HBA driver. The former comment goes to the value of old 
code. The latter goes to the size of the talent pool.

> > Anyway, your reaction is an interesting example of strong feelings in 
> > the community as to how contributed code should or should not be used. 
> > E.g. some get upset if their code runs on weapons systems, others get 
> > upset if the latest release might not run on suitable hardware in the 
> > immediate future. Some add or remove licence terms according to their 
> > convictions.
> 
> Um, I don't even know where this came from.

I'll explain it.

> In any case, the Linux Kernel is licensed under the GPL2, which, like 
> all Open Source compliant licenses, does not distribute against fields 
> of endeavor (such as weapons systems, etc.)
> 

As I understand it, supporting ancient hardware in certain sectors is 
highly profitable, where red tape prevents those customers from upgrading.

> As far as getting upset if the latest release doesn't run on "suitable 
> hardware", if they are upset they can submit a bug report, or better 
> yet, submit a patch to address the situation. 

I think you've missed my point, which was that some maintainers require 
that released code is executed promptly otherwise it should be deleted. 
Please see also, 
https://lore.kernel.org/all/7c2a6687-9c4e-efed-5e25-774b582e9a27@linux-m68k.org/

> What people seem to forget is that free software does not mean that 
> people will fix your software for your use case for free.  It means that 
> *you* are free to fix the software, or to pay someone to fix the 
> software in question.
> 
> > If there was consensus, it might be feasible to give a formula for 
> > "recognized usage" which could be quantified. From there we could 
> > create a kind of heat map to show which commits, maintainers, 
> > processes, models, modules etc. were the most "useful" within some 
> > time interval.
> 
> The best we have is we can see what users submit bug reports about 
> (especially, for example, when we discover that some driver was 
> accidentally broken a few years ago due to the need to upgrade code to 
> use newer API's as we improve and refactor code, and no one has 
> complained about the driver being used --- that's a good hint that no 
> one cares), and what individuals and companies choose to spend time 
> working to improve certain parts of the kernel.  If code is under active 
> maintenance, then it's worth *someone's* time to keep maintained.
> 
> And of course, if remove a driver because it is unmaintained and is for 
> obsolete hardware, if someone shows up saying (a) they care about that 
> driver, and (b) they are willing to volunteer to maintain the driver, or 
> are willing to pay someone to maintain the driver, and they have 
> contracted with XYZ developer working for ABC company, then it's super 
> simple to revert the driver removal.  It is, after all, only a "git 
> revert" away.
> 
> I do have to concur with Greg that relying on this as way to get new 
> people to be work on Linux kernel is a *terrible* idea.  The number of 
> people who are interested in retro-computing is quite small, in my 
> experience.
> 

Given that products like mobile phones etc. often get made obsolete within 
a few years from launch, my guess is that billions of users are now 
interested in retro-computing.

> Cheers,
> 
> 					- Ted
> 
