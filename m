Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC965D841
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 17:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjADQNU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 11:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbjADQMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 11:12:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7324F26E8;
        Wed,  4 Jan 2023 08:12:04 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id i15so49294210edf.2;
        Wed, 04 Jan 2023 08:12:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Hlvv2tc0F9GFZmQLiemf82atd7u3rSszUw1WF2uBwc=;
        b=SlVpJcknrODgQBazYB40N0B0/ZOgkZhuTJwDUmcttV6IrHpP83dkyXRxcAOKqciv8L
         FZicATQiPNly+oNlvEYTj0DXzhHWua1hRUrD6Li3A0DBNekyagw79hFDS7uY/6dRYHPw
         no6xTYUAdazMheCKy2EWrpft/ENfqBLRveWDAYMp1AuFvEGwo7OQ+Id1uC66Q8TwnMMH
         2qEIZbT0ldTyHzY501ehBzha8xxOjl122/rBgsYWVj+3kMR9Rsia/7Nyo667CFZpFp8F
         jn/L7r6K04Bx3WWtnwGO6uF7h8IOlsU2/9WGErqla1gsHVflfV1PZGg6x2NRt8X71jSm
         328g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Hlvv2tc0F9GFZmQLiemf82atd7u3rSszUw1WF2uBwc=;
        b=3AJaLLaxA7no7h7rxABmXgKlqSz89VoqJznaAaBY/wOItzg+qDywNz93SeS8mw46+d
         2dBCRGYxV7dmKiK2boCYPSpuHGAgDNFU9/bBEkkeIrMnVW374T2HoQ4iKR4o1ifwoPzW
         yx5fWr5ULH0EkHHlrE6N0hi893AIo8pwR9zor76AjRx7HUcwFq1iCFm9YX8QK/FXhbRJ
         PFsEJ2uiS3iYomGY1JoYOJx/wVtw+pcP+PPfonHzLx2xebF5F4z6fgCDcxKUO9WapqkR
         JRX4AviJsvM9NTzYWxf+fuMRhoR6+7O4/qa8z26WiOLqUPZ+8UfufD2HOdWGwJ/+mV3m
         kn/Q==
X-Gm-Message-State: AFqh2kqdLSlHaFA6vPvoyWQJaRbdY0oWmJwyPudm9MLpGb3YlKVMux3m
        6V2OTZ+UY5MesxptHtA+/MKH9glrSJUYGHVfjILuVh/+
X-Google-Smtp-Source: AMrXdXsz6eHmdBrBex19tiGWru1doEWBInQQIXo0rHiN8/WwvYWvuIkisQ8fVlxIRYnYs/O3nn7ncQ==
X-Received: by 2002:a05:6402:541a:b0:46c:6ed1:83b0 with SMTP id ev26-20020a056402541a00b0046c6ed183b0mr42542184edb.9.1672848723061;
        Wed, 04 Jan 2023 08:12:03 -0800 (PST)
Received: from localhost (host-82-60-200-213.retail.telecomitalia.it. [82.60.200.213])
        by smtp.gmail.com with ESMTPSA id d24-20020a50fb18000000b004615f7495e0sm14929712edq.8.2023.01.04.08.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Jan 2023 08:12:02 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 04 Jan 2023 17:12:00 +0100
Message-Id: <CPJJDOW2K1LG.2WV6VKIM191EG@vincent>
To:     "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        <rust-for-linux@vger.kernel.org>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] rust: sync: allow type of `self` to be `Arc<T>` or
 variants
From:   "Vincenzo" <vincenzopalazzodev@gmail.com>
X-Mailer: aerc 0.8.2
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <20221228060346.352362-2-wedsonaf@gmail.com>
In-Reply-To: <20221228060346.352362-2-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>

On Wed Dec 28, 2022 at 7:03 AM CET, Wedson Almeida Filho wrote:
> This allows associated functions whose `self` argument has `Arc<T>` or
> variants as their type. This, in turn, allows callers to use the dot
> syntax to make calls.
>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> ---
>  rust/kernel/lib.rs      |  1 +
>  rust/kernel/sync/arc.rs | 28 ++++++++++++++++++++++++++++
>  2 files changed, 29 insertions(+)
>
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index ace064a3702a..1a10f7c0ddd9 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>  #![no_std]
>  #![feature(allocator_api)]
>  #![feature(core_ffi_c)]
> +#![feature(receiver_trait)]
> =20
>  // Ensure conditional compilation based on the kernel configuration work=
s;
>  // otherwise we may silently break things like initcall handling.
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index 22290eb5ab9b..e2eb0e67d483 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -57,6 +57,31 @@ use core::{marker::PhantomData, ops::Deref, ptr::NonNu=
ll};
>  ///
>  /// // The refcount drops to zero when `cloned` goes out of scope, and t=
he memory is freed.
>  /// ```
> +///
> +/// Using `Arc<T>` as the type of `self`:
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct Example {
> +///     a: u32,
> +///     b: u32,
> +/// }
> +///
> +/// impl Example {
> +///     fn take_over(self: Arc<Self>) {
> +///         // ...
> +///     }
> +///
> +///     fn use_reference(self: &Arc<Self>) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// let obj =3D Arc::try_new(Example { a: 10, b: 20 })?;
> +/// obj.use_reference();
> +/// obj.take_over();
> +/// ```
>  pub struct Arc<T: ?Sized> {
>      ptr: NonNull<ArcInner<T>>,
>      _p: PhantomData<ArcInner<T>>,
> @@ -68,6 +93,9 @@ struct ArcInner<T: ?Sized> {
>      data: T,
>  }
> =20
> +// This is to allow [`Arc`] (and variants) to be used as the type of `se=
lf`.
> +impl<T: ?Sized> core::ops::Receiver for Arc<T> {}
> +
>  // SAFETY: It is safe to send `Arc<T>` to another thread when the underl=
ying `T` is `Sync` because
>  // it effectively means sharing `&T` (which is safe because `T` is `Sync=
`); additionally, it needs
>  // `T` to be `Send` because any thread that has an `Arc<T>` may ultimate=
ly access `T` directly, for
> --=20
> 2.34.1

