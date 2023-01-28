Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C897C67FB4A
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 23:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjA1WH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 17:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbjA1WH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 17:07:56 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08FA9B771;
        Sat, 28 Jan 2023 14:07:55 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id q15so7156625qtn.0;
        Sat, 28 Jan 2023 14:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0igDSerwF77i7AIMbsX05sAqEwSGgs8x8niAb1twpuQ=;
        b=csBLGvP9LipZqxSTKNGC3pWizhpklIZlxmwo5gUyGdADmTUyqdPO2pVazGCoATyWyB
         UrVmHDjo0hfdE0LdDQ/5bZMTyKWO9wQDsbjofep2u+Gri7otaxnhcR3yDsR4NTTau4Ku
         SQbtpYRL6Q9BE4sxPzoNPKNnQpwAGBJdIUAjUCoh4NuDmS3I1G6CMQ50VGm8tsa6ZVag
         G5gzGXdIFOCfo4DmGOIGlcXUmun55AdcZOfhupQ4zqk2WU+YX67BxAnFfMEZ8fJ/lqvn
         gAkVF8rmoXa6u7hgDBkYmY/NY5q5ot8ud+gkhUXLpbt507HY/rtTdN4NWcU9D9tgS4aM
         l+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0igDSerwF77i7AIMbsX05sAqEwSGgs8x8niAb1twpuQ=;
        b=rlyWBx3kB7GIt4ANnG61pUVEBFJgbR5l9n01OpCiKSKB62yocTGnC2oUGr+a1VSpJq
         rHiCvyVhbWMRHqVIVxsW159c9Fa+0UYVdUANz+KQ6y+wxS5kbBN2yw2dBmsdW3G0btix
         3hq4+Okau88EASCm0o1qBsN8JWCiQSSQ88BnS9yOQ/CEZh9nr9JrmJy6RCBrp4TTsmZX
         Q8tHN+RyRo2O7AAX6atqZSE7zepY2bdF91KGrmSrvq0luXiXurjBdR+kMeIHlORCpE3F
         Jw3ungCpClw1DXzDbSoyIIQxj9XI4+QlrwW1GpKeklWYPpvAmns+5tPzCjo4oqzmg7jg
         NXhA==
X-Gm-Message-State: AFqh2kqef5A6Y/aaZcJUqz8U517myMw9IETOC/Hp/8OyKW/krST48z+o
        d+gxq0Pb+1ymYu5VuU3WlituXWgUKBQ=
X-Google-Smtp-Source: AMrXdXsfdF21vR9jQeFUI46lSH8l25JaqkteIlptCa2s2A6G5ZECMFXY/LVZNfPn6KveEmx9Dy/GHQ==
X-Received: by 2002:ac8:58c3:0:b0:3b6:3594:3470 with SMTP id u3-20020ac858c3000000b003b635943470mr85163143qta.43.1674943674119;
        Sat, 28 Jan 2023 14:07:54 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j7-20020a37b907000000b00706c1fc62desm5365432qkf.112.2023.01.28.14.07.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 14:07:53 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0216C27C0054;
        Sat, 28 Jan 2023 17:07:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 17:07:53 -0500
X-ME-Sender: <xms:uJzVY89T7EXRWrRGC_Rp2c05gsMldlmjpGOUpzJ7pljwh3F6eJmZkA>
    <xme:uJzVY0vFtSXm0CQYoRF2b3KntrM7nw6cb0W9aXhhs9CsUxUMKWI3ZrZ8IZmo6KBmC
    mB4jcNyb307QqwmwQ>
X-ME-Received: <xmr:uJzVYyC7KkBPVtyV5gYLS4W9aM6jT9HfvPjz0V3fPVBMznXlK3O8hBT9g14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhg
    sehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrhhnpeehudfgudffffetuedtvdehue
    evledvhfelleeivedtgeeuhfegueevieduffeivdenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvg
    hrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhf
    vghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:uJzVY8fYszzCvcdyShDyyl2egK3pOELopAyUY4maxBTD3qMSOk8MWg>
    <xmx:uJzVYxPbDRNJ7kKH3fJY1eNW1JuiRTqUHjakNtqfX_zJnLjg2q9G-Q>
    <xmx:uJzVY2n1I4DItu47D79yfBXtxOeLhX6Sy7ny9yunsw4MysyZ6lIFZQ>
    <xmx:uJzVY0c4F3fHCGZ1NID47nC-QPJ9hBChr-_iDJqIkIG_EsnT-FKbAw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 17:07:52 -0500 (EST)
Date:   Sat, 28 Jan 2023 14:07:02 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     wedsonaf@gmail.com, alex.gaynor@gmail.com,
        bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Message-ID: <Y9WchuzdL8HBrqq7@boqun-archlinux>
References: <20230119174036.64046-2-wedsonaf@gmail.com>
 <20230128145345.1770912-1-yakoyoku@gmail.com>
 <Y9VV4+KCkShRex9m@boqun-archlinux>
 <3dcd0379-b375-32d2-4956-c42afd451693@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dcd0379-b375-32d2-4956-c42afd451693@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 05:46:50PM -0300, Martin Rodriguez Reboredo wrote:
> On 1/28/23 14:05, Boqun Feng wrote:
> > On Sat, Jan 28, 2023 at 11:53:45AM -0300, Martin Rodriguez Reboredo wrote:
> > [...]
> >>> +    /// Borrows a foreign-owned object.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> >>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> >>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> >>> +    /// for this object must have been dropped.
> >>> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> >>> +
> >>> +    /// Mutably borrows a foreign-owned object.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> >>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> >>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> >>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> >>> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
> >>> +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> >>> +        // `into_foreign`.
> >>> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> >>> +            d.into_foreign();
> >>> +        })
> >>> +    }
> >>
> >> Could these three methods have a borrowing equivalent? When I was
> >> working on some features for the USB module I've stumbled upon the case
> >> of having to encode a pointer (with a pivot) and I cannot do it without
> >> taking ownership of the pointer.
> >>
> > 
> > *const T is Copy, so you can still use it after pass it to a function or
> > a new binding, e.g.
> > 
> > 	pub fn use_ptr(ptr: *const i32) { .. }
> > 
> > 	let p: *const i32 = some_func();
> > 
> > 	let q = p;
> > 
> > 	// q is just a copy of p
> > 	use_ptr(p);
> > 	// passing to a function parameter is just copying
> > 	use_ptr(p);
> > 
> > maybe I'm missing something subtle, but if you have an example I can
> > help take a look.
> > 
> > Regards,
> > Boqun
> > 
> 
> I'll use a much more simple example. If I want to take the byte offset
> between two `ForeignWrapper`s I'd have to take ownership of them, but I
> don't see it desirable in some cases.
> 
>     fn byte_offset<P: PointerWrapper>(ptr: P, pivot: P) -> isize {
>         unsafe {
>             ptr.into_pointer().cast::<u8>()
>                 .byte_offset(pivot.into_pointer().cast())
>         }
>     }
> 
> But if there was an `as_pointer(&self) -> *const c_void` method then the
> above function will be able to borrow both `ForeignWrapper`s.
> 
>     fn byte_offset<P: PointerWrapper>(ptr: &P, pivot: &P) -> isize {
>         unsafe {
>             ptr.as_pointer().cast::<u8>()
>                 .byte_offset(pivot.as_pointer().cast())
>         }
>     }
> 
> Obviously those methods that borrow will announce invariancies in their
> doc comments. If these can exist then great and if not then another
> solution could be explored.
> 

For this particular use case, IIUC, what you need is exactly `AsRef`:

     fn byte_offset<T, P: AsRef<T>>(ptr: &P, pivot: &P) -> isize {
         unsafe {
             (ptr.as_ref() as *const _).cast::<u8>()
                 .byte_offset((pivot.as_ref() *const _).cast())
         }
     }

or you can implement a as_pointer() helper function to avoid the
duplicate `.as_ref() as *const _`:

    fn as_pointer<T, P: AsRef<T>>(ptr: &P) -> *const T {
        ptr.as_ref() as *const T
    }

Although, we need to `impl AsRef<T> for Arc<T>` to make it work for
`Arc<T>`, which is currently missing.

Regards,
Boqun

> >>> +
> >>> +    /// Converts a foreign-owned object back to a Rust-owned one.
> >>> +    ///
> >>> +    /// # Safety
> >>> +    ///
> >>> +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> >>> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> >>> +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> >>> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> >>> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> >>> +}
> >>> +
> >>>  /// Runs a cleanup function/closure when dropped.
> >>>  ///
> >>>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> >>> -- 
> >>> 2.34.1
> >>
> >> Aside from these comments I observe that there's a possibility to make
> >> ForeignOwnable a const trait and have non const implementors. Otherwise
> >> if these things are out of scope, no problem whatsoever and this has my
> >> OK.
> >>
> >> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
