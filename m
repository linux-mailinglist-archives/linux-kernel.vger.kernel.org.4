Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB5169ED1D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 03:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjBVCyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 21:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBVCyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 21:54:33 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906B2114;
        Tue, 21 Feb 2023 18:54:27 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id b6so428520qtb.1;
        Tue, 21 Feb 2023 18:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHRgFDjdCNtxsMXTHo3oNRXzpcc2Lih+Urp2I1rPznE=;
        b=C99udQt2AY4jNQWut5o1gOfr2s+GSniAFcc3Ck38w/oDosFdN7exbHbfD+9UpqST93
         12pcPYcjChJkIQO2XNXo3jHBWN0doJhl3Ws9HWp3F6AWTU79agWeSHUwr661cXqmGsFA
         aTHY0fuupi2Qz6FZ5IuOkV8z6gYOaEIaCQp/a1ZGEiMxR9bsvqNvy5a09aYwMKHmqh26
         wzE0uB3KgX+8AaaDe2TaXX5jDf6BFaiVgVdcJgnsbuKPnEgwR5rmzZmOpe/kWJpinRjp
         XMZa8fxW0BqA07De5ac40FhDHj0+h6AgYVKhn8DLv2w/oh5np+HC4/k90yG3J/6vIo8Y
         2aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rHRgFDjdCNtxsMXTHo3oNRXzpcc2Lih+Urp2I1rPznE=;
        b=zjWjQyg98Wtiwj5dcpU4VyvuSWqaRImO4WMt2EiHok4vg+T2CpWWNmY9YqHcKlMVBO
         Mq28EW+pZN9we0Ky/FaVeunhpvZbExrh5bT/gY1+7a2C+nPubM5/6KubI9Jy3+3/vy+9
         Dd2fo/V7qUXx3FnKUuRDltsRubZWdkxYBfmlFVYPB8IdsCB5Cla9sy13OdIt3fXdiKSj
         4RQ68QROHEw1L8j3Aej5LtnIqgWI/UEqGkqGo1de9XE0z4DnEra/ScSbiq4ttp8u9r+l
         N5cQLPv3UBpHT65pAVZiVay3DS/nYrw2yzgdnWZojgHpGFvK4olAPh4DSBq8YM7YYc1m
         O12A==
X-Gm-Message-State: AO0yUKXvW8J4zi7rz6M0hIbrRXTpATNDyyvP64qud1zFTO1Tsnj3RYo6
        wr8/dd31RjqVlZv1PVUO4ik=
X-Google-Smtp-Source: AK7set+07P0JGkGIY6ECNvu+wXWIQIkmpirlk+SWN8qjq/J67G2GUnwvDDExW7bQF9Y0QPBiqG/RYA==
X-Received: by 2002:ac8:7f01:0:b0:3be:5727:cda6 with SMTP id f1-20020ac87f01000000b003be5727cda6mr12532240qtk.58.1677034466528;
        Tue, 21 Feb 2023 18:54:26 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id p81-20020a374254000000b0073b275607f0sm2978930qka.65.2023.02.21.18.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 18:54:25 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4538827C0054;
        Tue, 21 Feb 2023 21:54:24 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 21 Feb 2023 21:54:25 -0500
X-ME-Sender: <xms:4IP1Y3H-EH6fuCOFWg7Y3TWwib-GfQ5Oc0h5uAsJe8o0pL1h9EIDwA>
    <xme:4IP1Y0X498dwmuJ9q6rCVXMu4Bp1a9mSLgABZ3kzsKDfViHmx_5EoyuTP10A-brZs
    cek0ppmr45_tlf5KA>
X-ME-Received: <xmr:4IP1Y5ILn5psbyhxaDPjpH_1EfwBvZfzJmDaFwIIchmT2DMCTBf9gpjGqV8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejkedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:4IP1Y1GFmEWy2T1DFC8L2Y5UpYfuFQTur_-vtTksp6Oish3Pwx2y3A>
    <xmx:4IP1Y9VNpwonrEr2-8PwsxV9BY5g8WKdl5lJZgJvAHnvdY3G7drNzg>
    <xmx:4IP1YwMebNDcjgrzGzQhsVqYAN2Ztpgf5ErNjp-v4GSqCyrbUk7hQQ>
    <xmx:4IP1YyVDsEE4TWtefq3n8b8oInPPeFX4CTUZoURR5kpFujnxOiekew>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 21:54:23 -0500 (EST)
Date:   Tue, 21 Feb 2023 18:54:07 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
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
Message-ID: <Y/WDz013yBIfQPDq@boqun-archlinux>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx>
 <Y/TP6as7qqwfcI42@boqun-archlinux>
 <87h6vfnh0f.ffs@tglx>
 <7b93bf74-abdc-f8c1-9a12-7c7f080f9e19@asahilina.net>
 <87edqioo1e.ffs@tglx>
 <CANiq72n-++roTv3yDNOA=Mi_sscBZX3xPdZ6RZ0Oxx+T82pf5A@mail.gmail.com>
 <87o7pmmtre.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o7pmmtre.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 01:24:53AM +0100, Thomas Gleixner wrote:
> Miguel!
> 
> On Tue, Feb 21 2023 at 23:29, Miguel Ojeda wrote:
> > On Tue, Feb 21, 2023 at 7:45 PM Thomas Gleixner <tglx@linutronix.de> wrote:
> >>
> >> But xb abd xr are the same datatype because they represent a time delta.
> >
> > In principle, one could also have different duration types too. For
> > instance, C++'s `std::chrono::duration` type is parametrized on the
> > representation type and the tick period, and thus an operation between
> > two time points like t1 - t0 returns a duration type that depends on
> > the type of the time points, i.e. which clock they were obtained from.
> 
> Correct, but for practical purposes I'd assume that the timestamps
> retrieved via ktime_get*() have the same granularity, i.e. 1ns.
> 
> TBH, that's not entirely correct because:
> 
>     - the underlying hardware clocksource might not have a 1ns
>       resolution
> 
>     - the CLOCK_*_COARSE implementations are only advanced once per
>       tick, but are executing significantly faster because they avoid
>       the hardware counter access.
> 
> But that's an assumption which has proven to be workable and correct
> with the full zoo of hardware supported by the kernel.
> 
> The point is that all CLOCK_* variants, except CLOCK_REALTIME and
> CLOCK_TAI are guaranteed to never go backwards.
> 
> CLOCK_REALTIME and CLOCK_TAI are special as they can be set by user
> space and CLOCK_REALTIME has the extra oddities of leap seconds.  But
> that's a well understood issue and is not specific to the kernel.
> 
> Back to time deltas (or duration types). Independent of the above it
> might make sense to be type strict about these as well. Especially if we
> go one step further and have timers based on CLOCK_* which need to be
> armed by either timestamps for absolute expiry or time deltas for
> relative to now expiry. I definitely can see a point for requiring
> matching time delta types there.
> 
> That said, I have no strong opinions about this particular detail and
> leave it to the Rusties to agree on something sensible.
> 

I'd like to propose something below to make thing forward quickly:

Given Lina only uses CLOCK_BOOTTIME and CLOCK_MONOTONIC, I'd say we
reuse core::time::Duration and probably remain its ">=0" semantics even
in the future we change its internal representation to u64.

For timestamp type, use Instant semantics and use different types for
different clocks, i.e. similar to the implementation from Heghedus (much
better than mine!). But we can avoid implementing a fully version of
Instant, and focus on just the piece that Lina needs, which I believe
it's elapsed()?

For the future, if we were to support non-monotonic timestamp, maybe we
use the different type name like TimeStamp and TimeDelta.

In short:

*	For monotonic clocks, Instant + Duration, and keep them similar
	to std semantics.

*	For non-monotonic clocks, don't worry it right now, and
	probably different types for both stamps and deltas.

Thoughts?

Regards,
Boqun

> Thanks,
> 
>         tglx
