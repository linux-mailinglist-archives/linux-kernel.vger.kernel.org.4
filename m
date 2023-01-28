Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618ED67F727
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbjA1Kin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:38:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjA1Kil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:38:41 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BE311671;
        Sat, 28 Jan 2023 02:38:39 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s3so6840871edd.4;
        Sat, 28 Jan 2023 02:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C7T3kTWhyhW5Qw+zVPgMHUZkXCCLAl+xDP5/+Vyr24Q=;
        b=ih92+b6mJO4vrIMzcyhIVjB7bENSyXVOXx5IGrR4DrdMHGVdCcd3aG/wylRf34umr/
         QnBFral6cPDbPcB5AlIk2TfcY2boAfa/r+cXyA96J95KGcXkJUcTY/cCV1URVfQoikaP
         XQWJKJDvVf2om/TGBW4fJSomgCSKs/Fc4qjdx3AjjQ8ulO+P/1RYmB4o9vanzH/0qbXn
         yTfE6+a7Lm9Vd0zdP0CFKqHda6R/f1tVth8vI7QJkW0EDddR1CWFLPqxwXzFxIwY0TO6
         OEgGmyJRhrY4PgduAFjzsMiN1PRVcVsB0AdgitaSPuEPv/jWlep2JGg1RCnSQfMCK6en
         Edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C7T3kTWhyhW5Qw+zVPgMHUZkXCCLAl+xDP5/+Vyr24Q=;
        b=TDFVM0CFhsy4ZHj8NfZw9KRPvb8ezf2EQwgT6ge8QeYz9vA+FHeABO1Qk/Y3ccNzh5
         u6Bg0QO5pI1XJxKyBPsL71JQL+FDQBIomv7X59DcZa89ZA+McWPESjLabYGGRSQLgrGz
         prHDbojR3pMuleJvYGA1KYJ/0rhcl+weNGLIJ9o4yVP1ROaBYeU6b4J52dmSouDRrvUA
         JcPArJSiTCGLrL76l5E2lm9E2n4bqS7E6msl5oJSnq+ZPrNEXwMU0takAIX7+KQ5LD5J
         HU2xQlMQ+/AMJvJ9RIbfAJkEU308DgEGdPWR5SQs2ZMat5jdXFX+0QDwr9bzQfAxD1Ld
         FOLg==
X-Gm-Message-State: AO0yUKUa4HNZttT3p9CfS+5ilaMAKTVVAQ/Qe7rebgYabsgMxrgMT48k
        FdByMXEMdlyvATM5Wb60dki4tDIQDAlzbnNL
X-Google-Smtp-Source: AK7set8EJORsnSF3U/OvSvkAKlqdqZiNDT/OFKJv+qFpy10DJKR830FEE539Wkiwp3ndtRV8jtelCA==
X-Received: by 2002:a05:6402:35d6:b0:4a2:2e8a:14d8 with SMTP id z22-20020a05640235d600b004a22e8a14d8mr646227edc.30.1674902318402;
        Sat, 28 Jan 2023 02:38:38 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:645c:8576:916a:8c99])
        by smtp.gmail.com with ESMTPSA id r15-20020a1709067fcf00b0087fa83790d8sm1372727ejs.13.2023.01.28.02.38.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:38:37 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 11:38:36 +0100
Message-Id: <CQ3RBI3EBELP.206VKZ8X6P301@vincent>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/5] rust: types: introduce `ScopeGuard`
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
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

On Thu Jan 19, 2023 at 6:40 PM CET, Wedson Almeida Filho wrote:
> This allows us to run some code when the guard is dropped (e.g.,
> implicitly when it goes out of scope). We can also prevent the
> guard from running by calling its `dismiss()` method.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

>  rust/kernel/types.rs | 127 ++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 126 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index e84e51ec9716..f0ad4472292d 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -2,7 +2,132 @@
> =20
>  //! Kernel types.
> =20
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
> +/// The [`ScopeGuard::dismiss`] function prevents the cleanup function f=
rom running.
> +///
> +/// # Examples
> +///
> +/// In the example below, we have multiple exit paths and we want to log=
 regardless of which one is
> +/// taken:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example1(arg: bool) {
> +///     let _log =3D ScopeGuard::new(|| pr_info!("example1 completed\n")=
);
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
> +/// In the example below, we want to log the same message on all early e=
xits but a different one on
> +/// the main exit path:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example2(arg: bool) {
> +///     let log =3D ScopeGuard::new(|| pr_info!("example2 returned early=
\n"));
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
> +/// In the example below, we need a mutable object (the vector) to be ac=
cessible within the log
> +/// function, so we wrap it in the [`ScopeGuard`]:
> +/// ```
> +/// # use kernel::ScopeGuard;
> +/// fn example3(arg: bool) -> Result {
> +///     let mut vec =3D
> +///         ScopeGuard::new_with_data(Vec::new(), |v| pr_info!("vec had =
{} elements\n", v.len()));
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
> +/// The value stored in the struct is nearly always `Some(_)`, except be=
tween
> +/// [`ScopeGuard::dismiss`] and [`ScopeGuard::drop`]: in this case, it w=
ill be `None` as the value
> +/// will have been returned to the caller. Since  [`ScopeGuard::dismiss`=
] consumes the guard,
> +/// callers won't be able to use it anymore.
> +pub struct ScopeGuard<T, F: FnOnce(T)>(Option<(T, F)>);
> +
> +impl<T, F: FnOnce(T)> ScopeGuard<T, F> {
> +    /// Creates a new guarded object wrapping the given data and with th=
e given cleanup function.
> +    pub fn new_with_data(data: T, cleanup_func: F) -> Self {
> +        // INVARIANT: The struct is being initialised with `Some(_)`.
> +        Self(Some((data, cleanup_func)))
> +    }
> +
> +    /// Prevents the cleanup function from running and returns the guard=
ed data.
> +    pub fn dismiss(mut self) -> T {
> +        // INVARIANT: This is the exception case in the invariant; it is=
 not visible to callers
> +        // because this function consumes `self`.
> +        self.0.take().unwrap().0
> +    }
> +}
> +
> +impl ScopeGuard<(), Box<dyn FnOnce(())>> {
> +    /// Creates a new guarded object with the given cleanup function.
> +    pub fn new(cleanup: impl FnOnce()) -> ScopeGuard<(), impl FnOnce(())=
> {
> +        ScopeGuard::new_with_data((), move |_| cleanup())
> +    }
> +}
> +
> +impl<T, F: FnOnce(T)> Deref for ScopeGuard<T, F> {
> +    type Target =3D T;
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
> +        if let Some((data, cleanup)) =3D self.0.take() {
> +            cleanup(data)
> +        }
> +    }
> +}
> =20
>  /// Stores an opaque value.
>  ///
> --=20
> 2.34.1

