Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04E06248FB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 19:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiKJSC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 13:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKJSCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 13:02:22 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7050645EF7;
        Thu, 10 Nov 2022 10:02:03 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id w4so1405005qts.0;
        Thu, 10 Nov 2022 10:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZPE4joWy866q/SHh0gyurtiqJscsxJcgbNN6o6AR7dw=;
        b=bEuu01uGo06uRFrgMgWdgcKuEzlx3XfiKtvmbkHSXYJvtdWcR0Vz4hiLnoeDKvuUbi
         Q6JurZLZSDKn4oBCHAf+EdEe7iMQRF1EmKqyyPI4CitSUbKcOiWLfw3JCaZtA3OWSht+
         8gcy8Dxatu61F8kcxRXImAPTPvpP1LrTb8kaxJQkKwxw0g6iDwewszc4WbOlOaNF865C
         S0vL6la+OhVzVMhjjNEtWFExD4jcOCGfEKIEamBKZMX4gkn9vK63HY+UBzs8c7YsEkuq
         A5nJwd591BwftuQ1aIfO15Cnuc8pUJrJXxKQ68qOtJv4hpYs3UE4Kr5xFsTuUqQZCrTJ
         1wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPE4joWy866q/SHh0gyurtiqJscsxJcgbNN6o6AR7dw=;
        b=gxlRFGssyCxrxK93WpUm50KlMWdzN48WHebeybsMLkdn3x9eNh4drZggdOHHpSrKHz
         i8MVfuqgXr6aLtg5SWd2Tsbn2kmvsS8Hd1iGUnvPyjOxiwuYljbhNXDu9qrDymD3Nk9Z
         m/W5ufmQAgVBnHh8muWKFUTJZRF3Pw7nsoXduRh5Kj27u+qTXzdU7s43n2/pINchBGgF
         g1gm2NtqkxL+3cySybXLFGbpPJtk5jV+rdZWBiCtzREPDREgWrAdqaJWpWzPAYPY5ela
         cz1gOhRKj00vXW/v9wj7D2K9N93Cu0I0HP7E00GTFTrOCnFy5ZQfNWJvAbhGpSH60FxH
         6ScA==
X-Gm-Message-State: ACrzQf3Ac38BROrohVqS3XV1y5BDPsdmrPBLg5Kh95ka24G01HfD+KeH
        Q4xsGpPNWjyjeMHEYL5CRj8=
X-Google-Smtp-Source: AMsMyM74gQpU+hz4s52tjqXFUooT8vpmba1u0o5n0eK/kgVr5nP/fq91ZceWNEsP+yeGOrO9sdplaw==
X-Received: by 2002:a05:622a:1f89:b0:3a5:1bb7:72bd with SMTP id cb9-20020a05622a1f8900b003a51bb772bdmr1513739qtb.686.1668103322330;
        Thu, 10 Nov 2022 10:02:02 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a3-20020ac84d83000000b003a530a32f67sm11318696qtw.65.2022.11.10.10.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 10:02:01 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id B314F27C0054;
        Thu, 10 Nov 2022 13:02:00 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 10 Nov 2022 13:02:00 -0500
X-ME-Sender: <xms:lzxtY4H7OmRwZNjO7yHcrkWtHApy0rKj5l85ctfULg_gEH-Kz5RnaQ>
    <xme:lzxtYxUY9au-4e5DYNfXeK7DBAPXg-qS3CybN6E1Ot5bySdcZuLyohNl793tlEP5A
    bB9kHnIDbC-GdJspQ>
X-ME-Received: <xmr:lzxtYyJ3ussfeT9CxmdXcIZ7u07-gvR2t-74X4w6p9U1Uw-FYhxRpDCfa9uC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeeggddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpefhgfeggfefffejteethfdujefgheeuteevueejueejvefggfehffdtffdv
    uefhtdenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhruhhsthdqlhgrnhhgrdhorh
    hgpdhmrggtrhhoshdrrhhspdhkvghrnhgvlhdrohhrghdpshhtrggtkhhovhgvrhhflhho
    fidrtghomhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeeh
    tdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmse
    hfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:lzxtY6GxqNmpDJjc1pLM0sAkMxI4vysAOuEJ5BrMA8OGk_uSUCbEdg>
    <xmx:lzxtY-ULGtcG2uw5rw0_8rjE2bhIedgEBEaAvZUlUFmaNJ2NNMz-Vg>
    <xmx:lzxtY9NqyQozVKaJkbJXE5IQSGOHEOrUHFUgYy1n5-HQHDsMIW2O0w>
    <xmx:mDxtYypsXSIIjuJfXDQtlOqrIgGHbnngY-JAQSXw-kQ8v856aiGN2g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Nov 2022 13:01:59 -0500 (EST)
Date:   Thu, 10 Nov 2022 10:01:57 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Niklas Mohrin <dev@niklasmohrin.de>
Subject: Re: [PATCH v1 23/28] rust: std_vendor: add `dbg!` macro based on
 `std`'s one
Message-ID: <Y208lVCN3VweD5iI@Boquns-Mac-mini.local>
References: <20221110164152.26136-1-ojeda@kernel.org>
 <20221110164152.26136-24-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110164152.26136-24-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,WEIRD_PORT autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 05:41:35PM +0100, Miguel Ojeda wrote:
> From: Niklas Mohrin <dev@niklasmohrin.de>
> 
> The Rust standard library has a really handy macro, `dbg!` [1,2].
> It prints the source location (filename and line) along with the raw
> source code that is invoked with and the `Debug` representation
> of the given expression, e.g.:
> 
>     let a = 2;
>     let b = dbg!(a * 2) + 1;
>     //      ^-- prints: [src/main.rs:2] a * 2 = 4
>     assert_eq!(b, 5);
> 
> Port the macro over to the `kernel` crate, using `pr_info!`
> instead of `eprintln!`, inside a new module called `std_vendor`.
> 

I got confused when I saw `dbg!` uses `pr_info` instead of `pr_debug`,
but then I saw the discussion:

	https://github.com/Rust-for-Linux/linux/pull/483#discussion_r689881969

and I'm almost convinced ;-) Better add the gist of discussion into
comment/document/commit log? Users need to know when to use `dbg!` and
when to use `pr_debug!`, right?

Regards,
Boqun

> Since the source code for the macro is taken from the standard
> library source (with only minor adjustments), the new file is
> licensed under `Apache 2.0 OR MIT`, just like the original [3,4].
> 
> Link: https://doc.rust-lang.org/std/macro.dbg.html [1]
> Link: https://github.com/rust-lang/rust/blob/master/library/std/src/macros.rs#L212 [2]
> Link: https://github.com/rust-lang/rust/blob/master/library/std/Cargo.toml [3]
> Link: https://github.com/rust-lang/rust/blob/master/COPYRIGHT [4]
> Signed-off-by: Niklas Mohrin <dev@niklasmohrin.de>
> [Reworded, adapted for upstream and applied latest changes]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
>  rust/kernel/lib.rs        |   2 +
>  rust/kernel/prelude.rs    |   2 +-
>  rust/kernel/std_vendor.rs | 160 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 163 insertions(+), 1 deletion(-)
>  create mode 100644 rust/kernel/std_vendor.rs
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ffc6626a6d29..d6371c9c8453 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -26,6 +26,8 @@ mod allocator;
>  pub mod error;
>  pub mod prelude;
>  pub mod print;
> +#[doc(hidden)]
> +pub mod std_vendor;
>  pub mod str;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index 89c2c9f4e7a7..345fc9075d1f 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -17,7 +17,7 @@ pub use alloc::{boxed::Box, vec::Vec};
>  
>  pub use macros::{module, vtable};
>  
> -pub use super::{pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
> +pub use super::{dbg, pr_alert, pr_crit, pr_debug, pr_emerg, pr_err, pr_info, pr_notice, pr_warn};
>  
>  pub use super::error::{code::*, Error, Result};
>  
> diff --git a/rust/kernel/std_vendor.rs b/rust/kernel/std_vendor.rs
> new file mode 100644
> index 000000000000..da57b4e521f4
> --- /dev/null
> +++ b/rust/kernel/std_vendor.rs
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +//! The contents of this file come from the Rust standard library, hosted in
> +//! the <https://github.com/rust-lang/rust> repository, licensed under
> +//! "Apache-2.0 OR MIT" and adapted for kernel use. For copyright details,
> +//! see <https://github.com/rust-lang/rust/blob/master/COPYRIGHT>.
> +
> +/// [`std::dbg`], but using [`pr_info`] instead of [`eprintln`].
> +///
> +/// Prints and returns the value of a given expression for quick and dirty
> +/// debugging.
> +///
> +/// An example:
> +///
> +/// ```rust
> +/// let a = 2;
> +/// # #[allow(clippy::dbg_macro)]
> +/// let b = dbg!(a * 2) + 1;
> +/// //      ^-- prints: [src/main.rs:2] a * 2 = 4
> +/// assert_eq!(b, 5);
> +/// ```
> +///
> +/// The macro works by using the `Debug` implementation of the type of
> +/// the given expression to print the value with [`printk`] along with the
> +/// source location of the macro invocation as well as the source code
> +/// of the expression.
> +///
> +/// Invoking the macro on an expression moves and takes ownership of it
> +/// before returning the evaluated expression unchanged. If the type
> +/// of the expression does not implement `Copy` and you don't want
> +/// to give up ownership, you can instead borrow with `dbg!(&expr)`
> +/// for some expression `expr`.
> +///
> +/// The `dbg!` macro works exactly the same in release builds.
> +/// This is useful when debugging issues that only occur in release
> +/// builds or when debugging in release mode is significantly faster.
> +///
> +/// Note that the macro is intended as a debugging tool and therefore you
> +/// should avoid having uses of it in version control for long periods
> +/// (other than in tests and similar).
> +///
> +/// # Stability
> +///
> +/// The exact output printed by this macro should not be relied upon
> +/// and is subject to future changes.
> +///
> +/// # Further examples
> +///
> +/// With a method call:
> +///
> +/// ```rust
> +/// # #[allow(clippy::dbg_macro)]
> +/// fn foo(n: usize) {
> +///     if dbg!(n.checked_sub(4)).is_some() {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// foo(3)
> +/// ```
> +///
> +/// This prints to the kernel log:
> +///
> +/// ```text,ignore
> +/// [src/main.rs:4] n.checked_sub(4) = None
> +/// ```
> +///
> +/// Naive factorial implementation:
> +///
> +/// ```rust
> +/// # #[allow(clippy::dbg_macro)]
> +/// # {
> +/// fn factorial(n: u32) -> u32 {
> +///     if dbg!(n <= 1) {
> +///         dbg!(1)
> +///     } else {
> +///         dbg!(n * factorial(n - 1))
> +///     }
> +/// }
> +///
> +/// dbg!(factorial(4));
> +/// # }
> +/// ```
> +///
> +/// This prints to the kernel log:
> +///
> +/// ```text,ignore
> +/// [src/main.rs:3] n <= 1 = false
> +/// [src/main.rs:3] n <= 1 = false
> +/// [src/main.rs:3] n <= 1 = false
> +/// [src/main.rs:3] n <= 1 = true
> +/// [src/main.rs:4] 1 = 1
> +/// [src/main.rs:5] n * factorial(n - 1) = 2
> +/// [src/main.rs:5] n * factorial(n - 1) = 6
> +/// [src/main.rs:5] n * factorial(n - 1) = 24
> +/// [src/main.rs:11] factorial(4) = 24
> +/// ```
> +///
> +/// The `dbg!(..)` macro moves the input:
> +///
> +/// ```ignore
> +/// /// A wrapper around `usize` which importantly is not Copyable.
> +/// #[derive(Debug)]
> +/// struct NoCopy(usize);
> +///
> +/// let a = NoCopy(42);
> +/// let _ = dbg!(a); // <-- `a` is moved here.
> +/// let _ = dbg!(a); // <-- `a` is moved again; error!
> +/// ```
> +///
> +/// You can also use `dbg!()` without a value to just print the
> +/// file and line whenever it's reached.
> +///
> +/// Finally, if you want to `dbg!(..)` multiple values, it will treat them as
> +/// a tuple (and return it, too):
> +///
> +/// ```
> +/// # #[allow(clippy::dbg_macro)]
> +/// assert_eq!(dbg!(1usize, 2u32), (1, 2));
> +/// ```
> +///
> +/// However, a single argument with a trailing comma will still not be treated
> +/// as a tuple, following the convention of ignoring trailing commas in macro
> +/// invocations. You can use a 1-tuple directly if you need one:
> +///
> +/// ```
> +/// # #[allow(clippy::dbg_macro)]
> +/// # {
> +/// assert_eq!(1, dbg!(1u32,)); // trailing comma ignored
> +/// assert_eq!((1,), dbg!((1u32,))); // 1-tuple
> +/// # }
> +/// ```
> +///
> +/// [`std::dbg`]: https://doc.rust-lang.org/std/macro.dbg.html
> +/// [`eprintln`]: https://doc.rust-lang.org/std/macro.eprintln.html
> +/// [`printk`]: https://www.kernel.org/doc/html/latest/core-api/printk-basics.html
> +#[macro_export]
> +macro_rules! dbg {
> +    // NOTE: We cannot use `concat!` to make a static string as a format argument
> +    // of `pr_info!` because `file!` could contain a `{` or
> +    // `$val` expression could be a block (`{ .. }`), in which case the `pr_info!`
> +    // will be malformed.
> +    () => {
> +        $crate::pr_info!("[{}:{}]\n", ::core::file!(), ::core::line!())
> +    };
> +    ($val:expr $(,)?) => {
> +        // Use of `match` here is intentional because it affects the lifetimes
> +        // of temporaries - https://stackoverflow.com/a/48732525/1063961
> +        match $val {
> +            tmp => {
> +                $crate::pr_info!("[{}:{}] {} = {:#?}\n",
> +                    ::core::file!(), ::core::line!(), ::core::stringify!($val), &tmp);
> +                tmp
> +            }
> +        }
> +    };
> +    ($($val:expr),+ $(,)?) => {
> +        ($($crate::dbg!($val)),+,)
> +    };
> +}
> -- 
> 2.38.1
> 
