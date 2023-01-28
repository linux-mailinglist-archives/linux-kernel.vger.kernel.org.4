Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6328C67F734
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 11:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjA1KmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 05:42:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjA1KmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 05:42:22 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACE27579A;
        Sat, 28 Jan 2023 02:42:20 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id me3so19832044ejb.7;
        Sat, 28 Jan 2023 02:42:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PYXQ6y4tnsXnbUqH94uPaeMEdJKcw2pfX5I+cBHlYf8=;
        b=avTe51zoFYXZXvrLW3lxlAPIwM+c5zshIxmy6JOY4OLy5qXj4Grw/6z6PgxpPPagFS
         q2USpUEzIO8+RhKCsET0GZ3H5NdjzDc6Ph9Q2ObzITihr89dvzfwC7J1dIC7nRlpcvcV
         VKOh9oTHOtWUFQ1sQiWodN91oQMmXrkcTpqb81ywtjeKRPGWN50rW2R0r5VNqTXvhhE4
         P+VgnOiEfKX+LdupL8S2w1ZL2+wDCMmM1UKHRuFSBzs5/2whoscHiG2VwXN6dzr+YOD4
         3oG6N0JRMybh6eYi1Fb0gEbQxEV7Zk7ckLJB66CRx1f0+/4FCc26cgRoJ+GHa3FNMVUD
         Clpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PYXQ6y4tnsXnbUqH94uPaeMEdJKcw2pfX5I+cBHlYf8=;
        b=F4evYAVoRSM3OnJ7aQhJEdMTqBoWHJOKx7mLBnOOPIOHyj99beNhAmCDoKK1F4JytE
         RvJjoC6BlSfwAXowCtvBzS3FjpiNcAxRlVLKxmSEyuwuyl9tXqmkA8p/g8h2PqYFH3Lc
         sarWSe17Gk664CpzrMCm5eqqZ9qYc8OjNVFp6RlEC4OKT0i31V3t1X/Ack5cVLzTBKyL
         6w7hPBCatgt31+WacM4lQk2EOctqiuLKrPBXpDLNnzNH6y2tW9+27Wy5cw2qWcDIENdZ
         EEgaOq0RYZV9AsDoA+6G5Ok1f1HqPgOYIax4AwQG0jhePF98RSTpGMNEb3NK9hqW+/AO
         oGHA==
X-Gm-Message-State: AO0yUKVDSsAEdQHZxdT7q0QD7f6ZuF2Nm/ixOLmS/8Y+sgwW1bf+TxVC
        UrFNZR/x0l7H0W0owzhf6T0=
X-Google-Smtp-Source: AK7set/yW0OZZRNqFYkmIbRRHLDMwioxqPb9ezI60AVwC15BeTZAuQbc/HrOw1xXfz3uV6Z9AS0IAg==
X-Received: by 2002:a17:906:a093:b0:878:7349:5ce6 with SMTP id q19-20020a170906a09300b0087873495ce6mr8122326ejy.71.1674902539006;
        Sat, 28 Jan 2023 02:42:19 -0800 (PST)
Received: from localhost (93-55-83-125.ip262.fastwebnet.it. [93.55.83.125])
        by smtp.gmail.com with ESMTPSA id gv52-20020a1709072bf400b00865ef3a3109sm3739944ejc.66.2023.01.28.02.42.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Jan 2023 02:42:18 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 28 Jan 2023 11:42:17 +0100
Message-Id: <CQ3REBB7KREM.1VLAO66X5NWV6@vincent>
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.8.2
References: <20230119174036.64046-1-wedsonaf@gmail.com>
 <20230119174036.64046-2-wedsonaf@gmail.com>
In-Reply-To: <20230119174036.64046-2-wedsonaf@gmail.com>
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
> It was originally called `PointerWrapper`. It is used to convert
> a Rust object to a pointer representation (void *) that can be
> stored on the C side, used, and eventually returned to Rust.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

> ---
>  rust/kernel/lib.rs   |  1 +
>  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index e0b0e953907d..223564f9f0cc 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -16,6 +16,7 @@
>  #![feature(coerce_unsized)]
>  #![feature(core_ffi_c)]
>  #![feature(dispatch_from_dyn)]
> +#![feature(generic_associated_types)]
>  #![feature(receiver_trait)]
>  #![feature(unsize)]
> =20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index f0ad4472292d..5475f6163002 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -9,6 +9,60 @@ use core::{
>      ops::{Deref, DerefMut},
>  };
> =20
> +/// Used to transfer ownership to and from foreign (non-Rust) languages.
> +///
> +/// Ownership is transferred from Rust to a foreign language by calling =
[`Self::into_foreign`] and
> +/// later may be transferred back to Rust by calling [`Self::from_foreig=
n`].
> +///
> +/// This trait is meant to be used in cases when Rust objects are stored=
 in C objects and
> +/// eventually "freed" back to Rust.
> +pub trait ForeignOwnable {
> +    /// Type of values borrowed between calls to [`ForeignOwnable::into_=
foreign`] and
> +    /// [`ForeignOwnable::from_foreign`].
> +    type Borrowed<'a>;
> +
> +    /// Converts a Rust-owned object to a foreign-owned one.
> +    ///
> +    /// The foreign representation is a pointer to void.
> +    fn into_foreign(self) -> *const core::ffi::c_void;
> +
> +    /// Borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow_mut`]
> +    /// for this object must have been dropped.
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowe=
d<'a>;
> +
> +    /// Mutably borrows a foreign-owned object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.
> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_voi=
d) -> ScopeGuard<T, fn(T)> {
> +        // SAFETY: The safety requirements ensure that `ptr` came from a=
 previous call to
> +        // `into_foreign`.
> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {
> +            d.into_foreign();
> +        })
> +    }
> +
> +    /// Converts a foreign-owned object back to a Rust-owned one.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
> +}
> +
>  /// Runs a cleanup function/closure when dropped.
>  ///
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function f=
rom running.
> --=20
> 2.34.1

