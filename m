Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE4067F9BD
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 18:06:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjA1RGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 12:06:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbjA1RGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 12:06:32 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C76B3EFA4;
        Sat, 28 Jan 2023 09:06:31 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id w11so960574qtc.3;
        Sat, 28 Jan 2023 09:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6LkjGYc1DQBixcrRx3f5l/Lm3c/gvRvkhxMH5vPTMoQ=;
        b=Ynd+q6s5C8ZoTVXBeMX+2eJg9EHqbUKkwUzy8i1K+9WX5fQW5wKKxv7EvNrtoFnM6E
         Mm912V/a5Xj05LOcBw6/+Q0hExtjZy1YFMaOxqsvWNU7Hsjnd+TTHlUEEyPPEKV1XbEp
         hh1iVFfK1W5h27/bICIXSV5eV8zOzQmDQXBJhH5r3UvMfexgbwm6TmuBHFbeaYx9SOWi
         UJ1T81ygypDa4VKFtOn3L3Bj5h6A7JV/JgE3P9u0rBYio2MWXgxeriX1ZyqsfUaacp7L
         mUCNqlYLltuJL8YzEA58CRCE5dfZw1zPuQMToY16LAEaVltL2T1m/3af37XlNwHe2nCD
         gm8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6LkjGYc1DQBixcrRx3f5l/Lm3c/gvRvkhxMH5vPTMoQ=;
        b=sJL1Y+VCZRgkqf1Uf8tHcpZAm/geDoRzXoSXgZSR3I+hpVTXhtaLRLVRxnM7SbXBHu
         LYO/9uF8L9iR7g60MmZiFHzD3j5TdzH4a0/EaBzedh7sk1bx7JNETcg1pigMGlQ0jtQX
         x9PURILOX4cBVo4OPURPBuM6ij5/P4EX4OZmte2+8ZzzpI6zsYtt8TqoxVc0ViQuQ/0x
         Jqd/1V8UHhLU2qpPY1dQWgXAn6USW2GAYXyYavNxcgec2ubmR3FBIk0gm12rgF8bIjGy
         cmtnrRGfNULKTmdpb6R4zp9RqMPJLGZXsmKfdbY1r1HJG3LwhJwm7U1D7/LkNr9gKV0+
         UWIQ==
X-Gm-Message-State: AFqh2krcr5VxdI68IYrOqZMZMdb2Y4qP9BqKY+HdnX8+eKuaSu284gI8
        CTbo/bSIgsnil+5yhX1/oPU=
X-Google-Smtp-Source: AMrXdXtGA6gGcQ9ASmGp1QprWmmPiPydXpMJnuJYMeBL5xcz3tgX0HjxMVUshxo9UT88MuPhgA2TEw==
X-Received: by 2002:ac8:6e83:0:b0:3b6:3406:81cb with SMTP id c3-20020ac86e83000000b003b6340681cbmr66219576qtv.14.1674925590957;
        Sat, 28 Jan 2023 09:06:30 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id f8-20020ac840c8000000b003b84b92052asm755797qtm.57.2023.01.28.09.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 09:06:30 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0B71927C0054;
        Sat, 28 Jan 2023 12:06:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sat, 28 Jan 2023 12:06:30 -0500
X-ME-Sender: <xms:FVbVY9oLvpMu7xecBGhaA8qhLZqgV9sQoJWNQyg0QM4mVruWNRcGqg>
    <xme:FVbVY_oDf-dun-mq5bzqjrAxvs5NDmKU_FI3X7G77BM4eq5QkXqiy40d6zhB6T8CW
    MJrAODSCnKavbrCKQ>
X-ME-Received: <xmr:FVbVY6Olfxxj_PBRvSENRL5AUJoAR1LB5FcZwD1sToBpHCp3ymf6_uFt5k8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddvkedgleeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
    ertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghes
    ghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephedugfduffffteeutddvheeuve
    elvdfhleelieevtdeguefhgeeuveeiudffiedvnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrh
    hsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgv
    nhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:FVbVY45kUSK75QVkYr9lGN6KOIzGEBt-G3gl7Jk_qWbAaycyxTQr1A>
    <xmx:FVbVY84oK9AeTeWVfmJAYsZ42SqPyljc3lwy5TUTLg2-ItnPt9oqEQ>
    <xmx:FVbVYwgQ2CvAL5oz5Zjur01grUo9ZO6LPvTT_FjpZXVZkspl3CxZHA>
    <xmx:FVbVY7aA-UR5lv7YeyouY7p-JiuagWk42utTO6FpRvFDTEbmJFboEA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jan 2023 12:06:29 -0500 (EST)
Date:   Sat, 28 Jan 2023 09:05:39 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     wedsonaf@gmail.com, alex.gaynor@gmail.com,
        bjorn3_gh@protonmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Message-ID: <Y9VV4+KCkShRex9m@boqun-archlinux>
References: <20230119174036.64046-2-wedsonaf@gmail.com>
 <20230128145345.1770912-1-yakoyoku@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230128145345.1770912-1-yakoyoku@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 28, 2023 at 11:53:45AM -0300, Martin Rodriguez Reboredo wrote:
[...]
> > +    /// Borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow_mut`]
> > +    /// for this object must have been dropped.
> > +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowed<'a>;
> > +
> > +    /// Mutably borrows a foreign-owned object.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_void) -> ScopeGuard<T, fn(T)> {
> > +        // SAFETY: The safety requirements ensure that `ptr` came from a previous call to
> > +        // `into_foreign`.
> > +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> > +            d.into_foreign();
> > +        })
> > +    }
> 
> Could these three methods have a borrowing equivalent? When I was
> working on some features for the USB module I've stumbled upon the case
> of having to encode a pointer (with a pivot) and I cannot do it without
> taking ownership of the pointer.
> 

*const T is Copy, so you can still use it after pass it to a function or
a new binding, e.g.

	pub fn use_ptr(ptr: *const i32) { .. }

	let p: *const i32 = some_func();

	let q = p;

	// q is just a copy of p
	use_ptr(p);
	// passing to a function parameter is just copying
	use_ptr(p);

maybe I'm missing something subtle, but if you have an example I can
help take a look.

Regards,
Boqun

> > +
> > +    /// Converts a foreign-owned object back to a Rust-owned one.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must have been returned by a previous call to [`ForeignOwnable::into_foreign`] for
> > +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn't been called yet.
> > +    /// Additionally, all instances (if any) of values returned by [`ForeignOwnable::borrow`] and
> > +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dropped.
> > +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> > +}
> > +
> >  /// Runs a cleanup function/closure when dropped.
> >  ///
> >  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> > -- 
> > 2.34.1
> 
> Aside from these comments I observe that there's a possibility to make
> ForeignOwnable a const trait and have non const implementors. Otherwise
> if these things are out of scope, no problem whatsoever and this has my
> OK.
> 
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
