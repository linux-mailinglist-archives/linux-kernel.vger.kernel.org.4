Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7B369EE44
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 06:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjBVFUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 00:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbjBVFUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 00:20:16 -0500
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB9B34C19;
        Tue, 21 Feb 2023 21:20:15 -0800 (PST)
Received: by mail-qt1-x82b.google.com with SMTP id l12so6654606qtr.0;
        Tue, 21 Feb 2023 21:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xebHx0fmRw14DsWgky1E/MJbe/f5Tna5A5xkHVpYj/Y=;
        b=e+Nds39p44KRzQKt4W+01CoZJjqQ6SlIIFMrZN5fwdvjbgciAEdgkR9NYmQBvEbiBZ
         yvWr4iFmPUmlO/JJgPUYhZnCU2UPg+lYIebdDGVCKZYK6F7m4PqA8xkdUdCmAwN41p9Y
         4Q3rjYMEMDD2mEZhB7ykY1ochuJ+OSudePWGRm6ODZ2PTSbmHdWk+9AF90Dc/U/sp1J4
         AiUHKRmv3lEWxjB4K7Rf7EyAM7+EfUFz34GCAy6PxvrEAMfWnIgo53bPMffK1A9OjQD9
         2Id3jIH1YZRCiGGjg4ZCHXpX/hRyLgP+YIaUZGmV92yP6oDmWa9TLlDhZJ3d3k7X3qnE
         qTtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xebHx0fmRw14DsWgky1E/MJbe/f5Tna5A5xkHVpYj/Y=;
        b=EyjQGDcztqpHw9KVixCIkII6fSj4Tde6xMpBE1wYfLLfSaemcZhHvjuCskDqRX28nb
         cBB7bqDyP3GIlXixJnIl6IYUyhoiaZkdGRjH4U2t1rmbQXStyTAp/iwB0niRykKLmQ3o
         4np+LCg6thK28X6h1ur/Ld27bFLaRREZxJD27J+jol1I5m+iZIbhev6FHf7w77Bgo602
         pJS9zDHuATO5VVcNXdd4K/r3glSZXL+zJQB5lMzqwC648GsIhVkgdQfbhMcSH7yGwelW
         gg9r+VAdzGWftqnK/zSptsb2ZOBBE6UACUFpYIxPm+yPr3qR/EmOt9UtE/K7PAiI5RpW
         SdZQ==
X-Gm-Message-State: AO0yUKVXaaEyxja170zJoE4f0jdvaUP/vHhIapxnS8jaGmd5ldXgCZFy
        VZrjb6f64Fn5w7GgrHkAlas=
X-Google-Smtp-Source: AK7set9/XaaBRrrt8oDjuA0cf0WRGfFeC+fLtZ8hSH+1Eeu12Zav+OxtxxFaFIjGoJ0vbTVURZFpuQ==
X-Received: by 2002:a05:622a:186:b0:3be:36c7:a15c with SMTP id s6-20020a05622a018600b003be36c7a15cmr24091081qtw.49.1677043214522;
        Tue, 21 Feb 2023 21:20:14 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o185-20020a375ac2000000b007339c5114a9sm12109872qkb.103.2023.02.21.21.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 21:20:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5778427C0054;
        Wed, 22 Feb 2023 00:20:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 22 Feb 2023 00:20:13 -0500
X-ME-Sender: <xms:DKb1Y0MBv_wLE_MoIIi5KyqCt5UBpQlC0AjSz4UMFJxMjBdU-GIw2Q>
    <xme:DKb1Y6_XL8TsW8TndPhjKRbkFpdLS4kRS0ovr2_zKENGQG3CG6cMyaWiInvDEf8t9
    K5LD7mIVQm6yfAmdQ>
X-ME-Received: <xmr:DKb1Y7Rn2hJBdpQk9Ph1pcWEp631122fLHYOnOBL8OsUypPSWXO_4Xnz5ag8Y6-Wo8_QX2dgg6uqCAGKAcwBI5Bb36DW4dDm6dA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejkedgkedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:DKb1Y8tL_TYv74nfJavAuO2mudwx3u762nVJIN9mOybraSwjd5xcnw>
    <xmx:DKb1Y8drWSFA2CFn_Gxn8eVR08yqmW4eI4MQcvvmW-PJwPNJXWupaA>
    <xmx:DKb1Yw1KQvjmWFrMsVgGyCgni_LwvKi-BnQupxTt6aoFY18ofoPGIg>
    <xmx:DKb1Y7_xzZLjP-eRH2RVEuHeTBIsPmENjhuqySLinyB_RiksaE0a5g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 00:20:12 -0500 (EST)
Date:   Tue, 21 Feb 2023 21:20:10 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev,
        Heghedus Razvan <heghedus.razvan@protonmail.com>
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <Y/WmCtTw2NPFdJBC@Boquns-Mac-mini.local>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx>
 <Y/TP6as7qqwfcI42@boqun-archlinux>
 <87h6vfnh0f.ffs@tglx>
 <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
 <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
 <87o7pmmtre.ffs@tglx>
 <Y/WDz013yBIfQPDq@boqun-archlinux>
 <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03e9af69-3fea-032d-6dc3-ac0ea8e57471@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:45:58PM +0900, Asahi Lina wrote:
> On 22/02/2023 11.54, Boqun Feng wrote:
> > On Wed, Feb 22, 2023 at 01:24:53AM +0100, Thomas Gleixner wrote:
> >> Miguel!
> >>
> >> On Tue, Feb 21 2023 at 23:29, Miguel Ojeda wrote:
> >>> On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>>>
> >>>> But xb abd xr are the same datatype because they represent a time delta.
> >>>
> >>> In principle, one could also have different duration types too. For
> >>> instance, C++'s `std::chrono::duration` type is parametrized on the
> >>> representation type and the tick period, and thus an operation between
> >>> two time points like t1 - t0 returns a duration type that depends on
> >>> the type of the time points, i.e. which clock they were obtained from.
> >>
> >> Correct, but for practical purposes I'd assume that the timestamps
> >> retrieved via ktime_get*() have the same granularity, i.e. 1ns.
> >>
> >> TBH, that's not entirely correct because:
> >>
> >>     - the underlying hardware clocksource might not have a 1ns
> >>       resolution
> >>
> >>     - the CLOCK_*_COARSE implementations are only advanced once per
> >>       tick, but are executing significantly faster because they avoid
> >>       the hardware counter access.
> >>
> >> But that's an assumption which has proven to be workable and correct
> >> with the full zoo of hardware supported by the kernel.
> >>
> >> The point is that all CLOCK_* variants, except CLOCK_REALTIME and
> >> CLOCK_TAI are guaranteed to never go backwards.
> >>
> >> CLOCK_REALTIME and CLOCK_TAI are special as they can be set by user
> >> space and CLOCK_REALTIME has the extra oddities of leap seconds.  But
> >> that's a well understood issue and is not specific to the kernel.
> >>
> >> Back to time deltas (or duration types). Independent of the above it
> >> might make sense to be type strict about these as well. Especially if we
> >> go one step further and have timers based on CLOCK_* which need to be
> >> armed by either timestamps for absolute expiry or time deltas for
> >> relative to now expiry. I definitely can see a point for requiring
> >> matching time delta types there.
> >>
> >> That said, I have no strong opinions about this particular detail and
> >> leave it to the Rusties to agree on something sensible.
> >>
> > 
> > I'd like to propose something below to make thing forward quickly:
> > 
> > Given Lina only uses CLOCK_BOOTTIME and CLOCK_MONOTONIC, I'd say we
> > reuse core::time::Duration and probably remain its ">=0" semantics even
> > in the future we change its internal representation to u64.
> > 
> > For timestamp type, use Instant semantics and use different types for
> > different clocks, i.e. similar to the implementation from Heghedus (much
> > better than mine!). But we can avoid implementing a fully version of
> > Instant, and focus on just the piece that Lina needs, which I believe
> > it's elapsed()?
> > 
> > For the future, if we were to support non-monotonic timestamp, maybe we
> > use the different type name like TimeStamp and TimeDelta.
> > 
> > In short:
> > 
> > *	For monotonic clocks, Instant + Duration, and keep them similar
> > 	to std semantics.
> > 
> > *	For non-monotonic clocks, don't worry it right now, and
> > 	probably different types for both stamps and deltas.
> > 
> > Thoughts?
> 
> I actually only used CLOCK_MONOTONIC in the end, so I could even leave
> CLOCK_BOOTTIME for later, though I like the idea of having scaffolding
> for several clock types even if we only implement one initially.
> 
> This works for me, if you're happy with the idea I'll give it a spin
> based on Heghedus' example. Heghedus, is it okay if I put you down as
> Co-developed-by and can I get a signoff? ^^
> 
> For the actual Instant type, I was thinking it makes sense to just
> internally represent it as a newtype of Duration as well. Then all the
> math becomes trivial based on Duration operations, and when we replace
> Duration with a new u64 type it'll all work out the same. Fundamentally
> that means Instant types are internally stored as the Duration between
> the epoch (e.g. system boot) subject to the way that clock ticks, which
> I think is a reasonable internal representation? (In other words, it's

Sounds even better ;-) It means Instant and Duration have the exact same
behavior about sub and so on.

Regards,
Boqun

> the same as my original patch behind the scenes, but wrapped in type
> safety).
> 
> ~~ Lina
