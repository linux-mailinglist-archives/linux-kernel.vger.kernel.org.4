Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0546A4324
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:43:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbjB0Nnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjB0Nnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:43:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B075F1B336
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:43:48 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id p26so4251764wmc.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 05:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=fx8qDAvCLDvqdcXgANGHuVjmctvQswRQGOVBMs2g0GM=;
        b=hcgNUCw6tj0Kjj5Mb97K+TQi1lQCZQqG1T9JBXu7dx+4YMDFQ3rTdFn8r6SwXgrE5v
         ERxaGivwNTwEzHl17Yc21EW0Ll4hWDYdSJn1ZLvd809YZ2myLcx6nFkl90s0NZ5IjJ6C
         Xds4+0TR8cY15+1m7THrT2zoGuL089Wjjc71N86RdLOP0Bmi512pvFU+8qHnnBTS3d4F
         lmCcR4OjP8YmhM91izbDUbUdibYNuwv0GfGqsLHmg3PluaS8XCD9e43E+umO4sTUm2ub
         7xm+u2fDI+2bioiSGPAB5ekNfa7fjiQgRUeifZtl7DnjmiIH0ASzmPzLfVpXKf9fbMPZ
         pW5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fx8qDAvCLDvqdcXgANGHuVjmctvQswRQGOVBMs2g0GM=;
        b=M3zLDdfEu/NkAOJ1t8Rtl5dPjz2NG2M7XEApgWHghIEUoQ6MNiTvFzvgtlqw3Mz4vE
         Lekd8i4jNCncTlILHTXeEHVd2XzFwglBCvBSr/kMFDfqmucYxqCCqJggJXhLJ4yWyHKj
         doO3qt1W3FZL48Hl+ZLr1gjPWKBLZEVgZ7JeaFTTW447l8imTJAPDmpXIWLH3s1t1NI3
         kAi63bzNX3ZhOaGcwoD2JWCS5xW+sl2ekmQAw68XUj13xBuX+r9ZP/M1OyF36uouy0GP
         DSNBSXr8VXTrIjC+A44RXG43MXv43doDvZmzFB96WDp3fSA85IxQFMOdIvpuiQqp6LNF
         aKdw==
X-Gm-Message-State: AO0yUKXtEKrQ465g7m1bUldJaLMGdoKPiYcxBo4FOh8Nyla2ND4cl33p
        milXIxUfr8lCt8yF04H+CtwSHQ==
X-Google-Smtp-Source: AK7set/QZmmdoWC9gmVNJw7Ijf5hJKUMmiZ3+bk6jfrAyO0GugLR1LUl3jT2I/ykylqOS0c12k4l4A==
X-Received: by 2002:a05:600c:170a:b0:3eb:37ce:4c3d with SMTP id c10-20020a05600c170a00b003eb37ce4c3dmr5326214wmn.38.1677505427133;
        Mon, 27 Feb 2023 05:43:47 -0800 (PST)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id j24-20020a05600c1c1800b003e22508a343sm9832291wms.12.2023.02.27.05.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 05:43:46 -0800 (PST)
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-4-f8f9a9a87303@asahilina.net>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 4/5] rust: error: Add a helper to convert a C ERR_PTR to
 a `Result`
Date:   Mon, 27 Feb 2023 14:41:25 +0100
In-reply-to: <20230224-rust-error-v1-4-f8f9a9a87303@asahilina.net>
Message-ID: <87a60z9qb2.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Asahi Lina <lina@asahilina.net> writes:

> From: Sven Van Asbroeck <thesven73@gmail.com>
>
> Some kernel C API functions return a pointer which embeds an optional
> `errno`. Callers are supposed to check the returned pointer with
> `IS_ERR()` and if this returns `true`, retrieve the `errno` using
> `PTR_ERR()`.
>
> Create a Rust helper function to implement the Rust equivalent:
> transform a `*mut T` to `Result<*mut T>`.
>
> Lina: Imported from rust-for-linux/linux, with subsequent refactoring
> and contributions squashed in and attributed below. Replaced usage of
> from_kernel_errno_unchecked() with an open-coded constructor, since this
> is the only user anyway.
>
> Co-developed-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Co-developed-by: Fox Chen <foxhlchen@gmail.com>
> Signed-off-by: Fox Chen <foxhlchen@gmail.com>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c       | 12 ++++++++++++
>  rust/kernel/error.rs | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 89f4cd1e0df3..04b9be46e887 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -53,6 +53,18 @@ __force void *rust_helper_ERR_PTR(long err)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_ERR_PTR);
>  
> +bool rust_helper_IS_ERR(__force const void *ptr)
> +{
> +	return IS_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_IS_ERR);
> +
> +long rust_helper_PTR_ERR(__force const void *ptr)
> +{
> +	return PTR_ERR(ptr);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 1e8371f28746..cf3d089477d2 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -177,3 +177,52 @@ pub fn to_result(err: core::ffi::c_int) -> Result {
>          Ok(())
>      }
>  }
> +
> +/// Transform a kernel "error pointer" to a normal pointer.
> +///
> +/// Some kernel C API functions return an "error pointer" which optionally
> +/// embeds an `errno`. Callers are supposed to check the returned pointer
> +/// for errors. This function performs the check and converts the "error pointer"
> +/// to a normal pointer in an idiomatic fashion.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use kernel::from_kernel_err_ptr;
> +/// # use kernel::bindings;
> +/// fn devm_platform_ioremap_resource(
> +///     pdev: &mut PlatformDevice,
> +///     index: u32,
> +/// ) -> Result<*mut core::ffi::c_void> {
> +///     // SAFETY: FFI call.
> +///     unsafe {
> +///         from_kernel_err_ptr(bindings::devm_platform_ioremap_resource(
> +///             pdev.to_ptr(),
> +///             index,
> +///         ))
> +///     }
> +/// }
> +/// ```
> +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> +#[allow(dead_code)]
> +pub(crate) fn from_kernel_err_ptr<T>(ptr: *mut T) -> Result<*mut T> {

For consistency, if `from_kernel_errno()` should be `from_errno()` this
should be `from_err_ptr()` as well?

BR Andreas

> +    // CAST: Casting a pointer to `*const core::ffi::c_void` is always valid.
> +    let const_ptr: *const core::ffi::c_void = ptr.cast();
> +    // SAFETY: The FFI function does not deref the pointer.
> +    if unsafe { bindings::IS_ERR(const_ptr) } {
> +        // SAFETY: The FFI function does not deref the pointer.
> +        let err = unsafe { bindings::PTR_ERR(const_ptr) };
> +        // CAST: If `IS_ERR()` returns `true`,
> +        // then `PTR_ERR()` is guaranteed to return a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`,
> +        // which always fits in an `i16`, as per the invariant above.
> +        // And an `i16` always fits in an `i32`. So casting `err` to
> +        // an `i32` can never overflow, and is always valid.
> +        //
> +        // SAFETY: `IS_ERR()` ensures `err` is a
> +        // negative value greater-or-equal to `-bindings::MAX_ERRNO`.
> +        #[cfg_attr(CONFIG_ARM, allow(clippy::unnecessary_cast))]
> +        return Err(Error(err as i32));
> +    }
> +    Ok(ptr)
> +}

