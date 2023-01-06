Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1414660887
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:54:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235862AbjAFUyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235962AbjAFUyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:54:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 786A36346;
        Fri,  6 Jan 2023 12:54:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0DD6461F71;
        Fri,  6 Jan 2023 20:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A220DC433D2;
        Fri,  6 Jan 2023 20:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673038444;
        bh=2XFVyFO90sv15IXbHfuoR96vEeg0uVA9f6scATbkw5I=;
        h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
        b=mHfJQe+ghzVdgZxSVelgm1jSG5vA5KgBsk91CsnOdE6+vYEnKP07FXxBqc+wIWjNc
         /ney0ntA5oVoXHpljLmbG/ptlT/69CqOGDRiBfs67lVR/GpQtfA4SFKxt6Hqv2BrBx
         /Zil7U7xTEbnwogsadNwFzIvOXp6M8oDMMmGpSRt/t2pBweXijPjNQBXjJ4Hz0fpTX
         qSPyHb2Bu6mdIo6QJC/HJCYTeL5tzoccdmge+vm1oc6K4rSnBht9HhRe3PbU0FE3ZW
         aP0OkfFtzOACThVhMDHKsjFKc34/bLpq9aJjwF+moBB4D8aQh33Cwmke0C/NvktWH2
         FqeZFd7BC2/Uw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 798D327C0054;
        Fri,  6 Jan 2023 15:54:02 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Fri, 06 Jan 2023 15:54:02 -0500
X-ME-Sender: <xms:aYq4Y-HpRJ9B9KVZyG6iVEM6s8NDCETv5X-KrsUs5WE5OYU3DXhsxw>
    <xme:aYq4Y_XW2bsYUXDLlsowJxX4un9TnJD8ALkVdygkeHk166HmYyfqqNhrlDRbmSbZ8
    fRUS-pwOvmyKPYVEqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrkedtgddugedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepvdfhuedvtdfhudffhfekkefftefghfeltdelgeffteehueegjeff
    udehgfetiefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:aYq4Y4L8HErcX2HRlQKr0dw1B7SrsvMkRW9QTjnonJuhU-hAl0LKqw>
    <xmx:aYq4Y4G772EnhzgLQ69UtH1UMRr7vy4DshAEEJ42s6kcmdGFJQp3YQ>
    <xmx:aYq4Y0WAuAq2TWSCMZ7Wx8xq4jkY6HXE77C4c58bGSdFK0VwRwDZKw>
    <xmx:aoq4Y5VRPXbo6ksg6EpyLzGFFIiWUfS8hsisPDiECVffoznwvBoMwg>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id AC89E31A03FD; Fri,  6 Jan 2023 15:54:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <f36f19ee-5bff-4cd0-b9a9-0fe987cf6d38@app.fastmail.com>
In-Reply-To: <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
References: <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com>
 <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com>
 <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com>
 <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com>
 <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
 <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
Date:   Fri, 06 Jan 2023 12:53:41 -0800
From:   "Andy Lutomirski" <luto@kernel.org>
To:     "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     "Yann Droneaud" <ydroneaud@opteya.com>,
        "Ingo Molnar" <mingo@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        patches@lists.linux.dev, "Thomas Gleixner" <tglx@linutronix.de>,
        "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>,
        "Linux API" <linux-api@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Adhemerval Zanella Netto" <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        "Florian Weimer" <fweimer@redhat.com>,
        "Arnd Bergmann" <arnd@arndb.de>, "Jann Horn" <jannh@google.com>,
        "Christian Brauner" <brauner@kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always lazily
 freeable mappings
Content-Type: text/plain
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, Jan 5, 2023, at 6:08 PM, Linus Torvalds wrote:
> On Thu, Jan 5, 2023 at 5:02 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> None of what you ask for is for any kind of real security, it's all
>> just crazy "but I want to feel the warm and fuzzies and take shortcuts
>> elsewhere, and push my pain onto other people".
>
> Actually, let me maybe soften that a bit and say that it's
> "convenience features". It might make some things more _convenient_ to
> do, exactly because it might allow other parts to do short-cuts.
>
> But because it's a convenience-feature, it had also better either be
> (a) really easy and clear to do in the kernel and (b) have
> sufficiently *wide* convenience so that it doesn't end up being one of
> those "corner case things we have to maintain forever and nobody
> uses".
>
> And I think VM_DROPPABLE matches (a), and would be fine if it had some
> other non-made-up use (although honestly, we should solve the 32-bit
> problem first - ignoring it isn't fine for anything that is supposed
> to be widely useful).
>
> We *have* talked about features kind of like it before, for people
> doing basically caches in user space that they can re-create on demand
> and are ok with just going away under memory pressure.
>
> But those people almost invariably want dropped pages to cause a
> SIGSEGV or SIGBUS, not to come back as zeroes.
>
> So you were insulting when you said kernel people don't care about
> security issues.  And I'm just telling you that's not true, but it
> *is* 100% true that kernel people are often really fed up with
> security people who have their blinders on, focus on some small thing,
> and think nothing else ever matters.
>
> So yes, the way to get something like VM_DROPPABLE accepted is to
> remove the blinders, and have it be something more widely useful, and
> not be a "for made up bad code".

I'm going to suggest a very very different approach: fix secret storage in memory for real.  That is, don't lock "super secret sensitive stuff" into memory, and don't wipe it either.  *Encrypt* it.

This boils down to implementing proper encrypted swap support, which is not conceptually that difficult.  The kernel already has identifiers (mapping, offset, etc) for every page in swap and already stores some metadata.  Using that as part of a cryptographic operation seems conceptually fairly straightforward.

And a nice implementation of this could be on by default, and the kernel could even tell userspace that it's on, and then userspace could just stop worrying about this particular issue.
