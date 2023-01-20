Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292DF674D54
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 07:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjATGYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 01:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjATGYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 01:24:33 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB5A77CCCA;
        Thu, 19 Jan 2023 22:24:02 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id x7so3438452qtv.13;
        Thu, 19 Jan 2023 22:24:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m/MI+VcYhdwx96fyONVt/5n6r1oLpaMorbRp8iU9Y1A=;
        b=TctN8tdVzAAQVuXr7I+CkW7I1UpND2PNCiWNO+Uu98aJd0TyUEtqaOTghrptdHqQyz
         lfuJPlHOPG2uvNa31M5fVV2IhUQupLxNXESjDsk2sO/7MBSsQQKJfHhBuhmhiVvjW36U
         jwjd/Frt8o9nSBbeTpJsls834H4VqHOfnde0LaGIWcXsQAggQ+OYAjb4irf02Nwr6WLw
         A83cPqT5CSOq1ZtClGj036m+mwSNE5gPcgUoB/NYmeg0pEJV8FcFKrYGfZwSHBUPPJOf
         vHOoeXNYrhiIaW2j6g/v9/da2U5+fUPnya9op/u9CHvYk0YR5ZEBdJNJG63cope9ThgU
         pLzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m/MI+VcYhdwx96fyONVt/5n6r1oLpaMorbRp8iU9Y1A=;
        b=g/PDHu6+I5MoOOg76QGjMQksSCS4uipL9YDGmbnzZUMWvxl9nOIBJL96aLyXFLusNK
         SzpaZmEMYcXMqFXfkgZ0WEXSN+uqk9jOiB3/Za7plpegYAEkhDYI1fO14PFyC6UZFIUp
         RtPPMzY4CrEZ5DcWwXLzBERL9UXYCFrwMSAPcePtB4kskMr69TCw0e2mNzk6G8wK2CBm
         mPWCatQmrdzQYsHKFsCPmtU76wwMNld6xK3e4PENEOswgjbq7FCKnx8hUvC1G8C4EdaT
         DqXk6EyiTpvmhR3GdIIGnDH5tK6CcQWZEYJUXUBX0x971Ih6YCthrL7e5o22m6v7bv7H
         uXKw==
X-Gm-Message-State: AFqh2koSPpA1HttiWXiYRhCGunqwxmdCE4qi/IeYheDpT7aQ2a3vkF5h
        LvTjPhSiV2lzY3oR0J14i6e0qpsbP28=
X-Google-Smtp-Source: AMrXdXsTu1G6XKc4SEt3rUe0C4Zh2bIgrN8+qw3b/6w8jJ/5IQ/qnKEogMDIEL4Tfd9WUj3LjOcDBQ==
X-Received: by 2002:ac8:7a93:0:b0:3b1:c538:7026 with SMTP id x19-20020ac87a93000000b003b1c5387026mr18699715qtr.42.1674195840824;
        Thu, 19 Jan 2023 22:24:00 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q30-20020a37f71e000000b006ec62032d3dsm13983436qkj.30.2023.01.19.22.23.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 22:24:00 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id C783D27C0054;
        Fri, 20 Jan 2023 01:23:59 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 20 Jan 2023 01:23:59 -0500
X-ME-Sender: <xms:fzPKYzgftebfWomkY8PRPI9Zq5r06zh08YLK7zyEU7-dcKs5bvn40Q>
    <xme:fzPKYwC3wJQ6O7ZiI3h7QEq_l63dQqI2VfOe2sM_1ntfpEnHNlWsBBmI5lpR6v565
    Zfm1xTtxv_HR6wMpA>
X-ME-Received: <xmr:fzPKYzFD2CXfb05-NoKx_hkE1XEoG1FE2PrFnmt_o4f-GITmoZfkVlKZPy32CSJ0On3dCuJk3nn4FTZ1MPYyNMd61wBgj0mgbKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudduuddgleejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeehudfgudffffetuedtvdehueevledvhfelleeivedtgeeuhfegueeviedu
    ffeivdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    gsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdei
    gedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfih
    igmhgvrdhnrghmvg
X-ME-Proxy: <xmx:fzPKYwQOgh3CgJ9b7Ou8vlN1-wkJmSAGfIzI93afgyQ6pll5ofDkvw>
    <xmx:fzPKYwxU6wgcLZiapPvqNjGRG5foc0J8n4MLc6mPCIikesb3lan4bA>
    <xmx:fzPKY24trJ3ht2lxIt39ow0YhTui_y5hLwyP5bK_9x0tJTGWb6IuKw>
    <xmx:fzPKY3nCCM8Vk9DhpXKuMN67zwB3bc93w52_36OhF8VbGa_4PX8z7w>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Jan 2023 01:23:58 -0500 (EST)
Date:   Thu, 19 Jan 2023 22:23:56 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] rust: types: introduce `ScopeGuard`
Message-ID: <Y8ozfNAYhuOPgL/7@Boquns-Mac-mini.local>
References: <20230119174036.64046-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230119174036.64046-1-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:40:32PM -0300, Wedson Almeida Filho wrote:
> This allows us to run some code when the guard is dropped (e.g.,
> implicitly when it goes out of scope). We can also prevent the
> guard from running by calling its `dismiss()` method.
> 
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/types.rs | 127 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e84e51ec9716..f0ad4472292d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,7 +2,132 @@
>  
>  //! Kernel types.
>  
> -use core::{cell::UnsafeCell, mem::MaybeUninit};
> +use alloc::boxed::Box;
> +use core::{
> +    cell::UnsafeCell,
> +    mem::MaybeUninit,
> +    ops::{Deref, DerefMut},
> +};
> +
> +/// Runs a cleanup function/closure when dropped.
> +///
> +/// The [`ScopeGuard::dismiss`] function prevents the cleanup function from running.
> +///
> +/// # Examples
> +///
> +/// In the example below, we have multiple exit paths and we want to log regardless of which one is
> +/// taken:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example1(arg: bool) {
> +///     let _log = ScopeGuard::new(|| pr_info!("example1 completed\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     pr_info!("Do something...\n");
> +/// }
> +///
> +/// # example1(false);
> +/// # example1(true);
> +/// ```
> +///
> +/// In the example below, we want to log the same message on all early exits but a different one on
> +/// the main exit path:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example2(arg: bool) {
> +///     let log = ScopeGuard::new(|| pr_info!("example2 returned early\n"));
> +///
> +///     if arg {
> +///         return;
> +///     }
> +///
> +///     // (Other early returns...)
> +///
> +///     log.dismiss();
> +///     pr_info!("example2 no early return\n");
> +/// }
> +///
> +/// # example2(false);
> +/// # example2(true);
> +/// ```
> +///
> +/// In the example below, we need a mutable object (the vector) to be accessible within the log
> +/// function, so we wrap it in the [`ScopeGuard`]:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example3(arg: bool) -> Result {
> +///     let mut vec =
> +///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had {} elements\n", v.len()));
> +///
> +///     vec.try_push(10u8)?;
> +///     if arg {
> +///         return Ok(());
> +///     }
> +///     vec.try_push(20u8)?;
> +///     Ok(())
> +/// }
> +///
> +/// # assert_eq!(example3(false), Ok(()));
> +/// # assert_eq!(example3(true), Ok(()));
> +/// ```
> +///
> +/// # Invariants
> +///
> +/// The value stored in the struct is nearly always `Some(_)`, except between
> +/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it will be `None` as the value
> +/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`] consumes the guard,
> +/// callers won't be able to use it anymore.
> +pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
> +
> +impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
> +    /// Creates a new guarded object wrapping the given data and with the given cleanup function.
> +    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
> +        // INVARIANT: The struct is being initialised with `Some(_)`.
> +        Self(Some((data, cleanup_func)))
> +    }
> +
> +    /// Prevents the cleanup function from running and returns the guarded data.
> +    pub fn dismiss(mut self) -> T {
> +        // INVARIANT: This is the exception case in the invariant; it is not visible to callers
> +        // because this function consumes `self`.
> +        self.0.take().unwrap().0
> +    }
> +}
> +
> +impl ScopeGuard<(), Box<dyn FnOnce(())>> {

How about `fn(())` here as a placeholder? I.e

	impl ScopeGuard<(), fn(())>


Regards,
Boqun

> +    /// Creates a new guarded object with the given cleanup function.
> +    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())> {
> +        ScopeGuard::new_with_data((), move |_| cleanup())
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
> +    type Target = T;
> +
> +    fn deref(&self) -> &T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &self.0.as_ref().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> DerefMut for ScopeGuard<T, F> {
> +    fn deref_mut(&mut self) -> &mut T {
> +        // The type invariants guarantee that `unwrap` will succeed.
> +        &mut self.0.as_mut().unwrap().0
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Drop for ScopeGuard<T, F> {
> +    fn drop(&mut self) {
> +        // Run the cleanup function if one is still present.
> +        if let Some((data, cleanup)) = self.0.take() {
> +            cleanup(data)
> +        }
> +    }
> +}
>  
>  /// Stores an opaque value.
>  ///
> -- 
> 2.34.1
> 
