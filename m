Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACEFF69E1FC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234197AbjBUOHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:07:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233109AbjBUOHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:07:07 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0352A980;
        Tue, 21 Feb 2023 06:06:51 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id h19so1578839qtk.7;
        Tue, 21 Feb 2023 06:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vUO6t4z536wZ5DIJRxXjGyPhgw90LS1wJiuXGEkrpa8=;
        b=fSs6JgfWyoIt8Aohte6ELurJFf+NyC8KPg34Op8Db+0emcIN86H9D8NBLMS08+DB2x
         ybijei573rxyQCF2byDcjhbjF3mUGw0n3cX4OkqTbhWTMzrzr13zhJU79JbYvncXXbdv
         a+zafqCbuPXnNzDjlKY6siysOow8skBpe+htYVtcCvk9KbiBK0x3z6MXCy1hhb8HsYYZ
         eOB5BPh1Ynv6Y74nXGfo6TV5rp6EV9xpKpk080290XGBrSo+KjDddBLYy+Q/QqyWA2iZ
         +4tvPTC0tRoDOEjiRV1n1JqANqQp3BMXqc/RBGZYD107Wjd8Y1Hs1X74L4c33pjdK88f
         liyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vUO6t4z536wZ5DIJRxXjGyPhgw90LS1wJiuXGEkrpa8=;
        b=lBwIyynAq98SM6SeVWCKzklnjTbWJ6ulxjbXy5CPRdgmYcAP0VTa8foWcA1k+efJ4T
         45ELbVEPsya4WtxA8owNAQxLlnEy3XRhjL28g9N1DIlcZ+JmyczUMLqmeH94g0Hdor8z
         ErvvGl3IdtklnwWN3Q+hVg/jOpHRYznS5V6hGbgcbwVZeJ0mPF2rCxgdpiGNL5l9sfbN
         tKIfVA7vr4NDv6JkXmNIzm2FeLJeTgLG2qitZ/xUE8bAVsw8+vezQs3SQu7ekZ8VK1eb
         ykZiC/rYXcpIxjXwh6DTRkgFhZM51jbB4gL8bQjMy2vrUOteugYhSsh+GAgf++C+2hZc
         6M5Q==
X-Gm-Message-State: AO0yUKV1npVppP8BDieILsgbxEsaYAXPb5SRXyCRxznHX4A9EMrTqerx
        XApI5vw7Gog1USdf8A9FdK4=
X-Google-Smtp-Source: AK7set8AfZ4Zg6fvmZaqbZYCwpCHxVaRYPJ9rJN6+1tySIAExL4LpcxgpkZ3UccVPkDAM8/ibHFdUg==
X-Received: by 2002:ac8:5c08:0:b0:3b8:63fa:11be with SMTP id i8-20020ac85c08000000b003b863fa11bemr6132084qti.66.1676988410305;
        Tue, 21 Feb 2023 06:06:50 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id 14-20020ac84e8e000000b003bd1a798f76sm2605874qtp.37.2023.02.21.06.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 06:06:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4376A27C005B;
        Tue, 21 Feb 2023 09:06:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 21 Feb 2023 09:06:49 -0500
X-ME-Sender: <xms:-M_0Y7eh3AjEyQ91mu3aJkmyDhdhVqd23LwNzzE0VI7Aum1rwtpGeA>
    <xme:-M_0YxNh5Q12Zo4JGMENkVDTrNzdkc_oPqr4otkQMk0WQYrSqvtQJo37lfCvraA9j
    C3VletdBxRXCNoNTQ>
X-ME-Received: <xmr:-M_0Y0i_xe4P1kV2tgsQR26WjlCqPwuYK60_J6SSrF8vG1UWQyX0Uzc0j-M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejjedgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:-M_0Y8-NUF9lERNcKMui1vpmVCOr9OhN-HXOsWEzy8usa-2GBdCvLg>
    <xmx:-M_0Y3sfzG0lpidUVkl8TqJcenaDF26MipL7P8sTYyIOSdWIro3G3A>
    <xmx:-M_0Y7GFfFQPqr9rlSly2Mr8axfTn5D1xEwfarMkypSboF2snQb_NA>
    <xmx:-M_0Y7Fmc5_-danI6sV49GD7HwQFQJRsG5ClFnciXcdZTWSRQ6fFEg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Feb 2023 09:06:47 -0500 (EST)
Date:   Tue, 21 Feb 2023 06:06:33 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH] rust: time: New module for timekeeping functions
Message-ID: <Y/TP6as7qqwfcI42@boqun-archlinux>
References: <20230221-gpu-up-time-v1-1-bf8fe74b7f55@asahilina.net>
 <87v8jvnqq4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8jvnqq4.ffs@tglx>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2023 at 01:32:51PM +0100, Thomas Gleixner wrote:
> On Tue, Feb 21 2023 at 16:06, Asahi Lina wrote:
> > +
> > +use crate::bindings;
> > +use core::time::Duration;
> > +
> > +/// Returns the kernel time elapsed since boot, excluding time spent sleeping, as a [`Duration`].
> > +pub fn ktime_get() -> Duration {
> > +    // SAFETY: Function has no side effects and no inputs.
> > +    Duration::from_nanos(unsafe { bindings::ktime_get() }.try_into().unwrap())
> 
> Why is this a Duration? From the spec:
> 

I agree that returning a Duration may not be ideal, but..

>     Duration
> 
>         A Duration type to represent a span of time, typically used for
>         system timeouts.
> 
>     Instant
> 
>         A measurement of a monotonically nondecreasing clock. Opaque and
>         useful only with Duration.
> 
> In my understanding 'Duration' is a time span between two points, while
> ktime_get() and ktime_get_boottime() return the current time of
> monotonically nondecreasing clocks, i.e. they fall into the 'Instant'
> category.
> 
> Now the problem is that 'Instant' in it's specification is bound to
> CLOCK_MONOTONIC and there is no way to express CLOCK_BOOTTIME, but
> that's a shortcoming of the spec which ignores CLOCK_BOOTTIME
> completely. IOW, that's also a problem for user space.
> 
> This makes sense vs. the other representation:
> 
>      SystemTime
>      
>         A measurement of the system clock, useful for talking to
>         external entities like the file system or other processes.
> 
> This maps to CLOCK_REALTIME and CLOCK_TAI, i.e. ktime_get_real_ns() and
> ktime_get_clocktai().
> 
> Similar to 'Instant' 'SystemTime' is strictly bound to CLOCK_REALTIME
> by specification and there is no way to read CLOCK_TAI.
> 

..'Instant' and 'SystemTime' are in Rust std, we cannot use them
directly, similar as we cannot use userspace libc. To me, there seems
two options to provide Rust types for kernel time management:

*	Use KTime which maps to ktime_t, then we have the similar
	semantics around it: sometimes it's a duration, sometimes it's
	a point of time.. but I know "this is a safe language, you
	should do more" ;-)

*	Introduce kernel's own types, e.g. BootTime, RawTime, TAI,
	RealTime, and make them play with Duration (actually I'd prefer
	we have own Duration, because Rust core::time::Duration takes
	more than u64), something like below:


	pub struct BootTime {
	    d: Duration
	}

	impl BootTime {
	    fn now() -> Self {
	        unsafe { BootTime { d: ktime_to_duration(ktime_get_boottime())} }
	    }
	    fn add(self, d: Duration) -> Self {
	        <Add a duration, similar to ktime_add>
	    }
	    fn sub(self, other: Self) -> Duration {
	        ...
	    }
	...
	}

Thoughts?

Regards,
Boqun

> Please fix this in the spec and do not try to work around that by
> pretending that a clock read is a 'Duration'.
> 
> > +}
> > +
> > +/// Returns the kernel time elapsed since boot, including time spent sleeping, as a [`Duration`].
> > +pub fn ktime_get_boottime() -> Duration {
> > +    Duration::from_nanos(
> > +        // SAFETY: Function has no side effects and no variable inputs.
> > +        unsafe { bindings::ktime_get_with_offset(bindings::tk_offsets_TK_OFFS_BOOT) }
> 
> No. Please use ktime_get_boottime() and not the timekeeping internal function.
> 
> Thanks,
> 
>         tglx
