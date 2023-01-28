Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEC5C67F8DC
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 15:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234238AbjA1OyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Jan 2023 09:54:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234236AbjA1Ox7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jan 2023 09:53:59 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DD028D0A;
        Sat, 28 Jan 2023 06:53:51 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-15f97c478a8so10027475fac.13;
        Sat, 28 Jan 2023 06:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I35hMBLj+gQ46cnP7/cbmgYIA1WQF5HE8dkz5wshcwo=;
        b=aViHCU4/SDR+d2zxmIrWnJiH485QWTk31JQ8L8wJb9l4iQdeLKhvPkqJx4sUI/OPvZ
         LjMqkYka2pdZ6YZamseVlpsql9jVb24iZGA2ixi4sUp9P/YtXLp1yi0EcCSM1U6ofqE1
         J/6GCVJ4YRaGnJNknMbqTMXbN1mq6fRK4uPnDVvJ478845K3j0MmV+JnCvDU4sa+wGUr
         8iaAW1s8KkcberbNAATvJ3WZxkAoiS+hj1zvds8/H9eigiDX+uqBGWURwa3CWUM7lBzw
         MD8e6b1mHIwxdVvC2+L6UYPgM2u+5KLe7Hk+X4JK5ORAGAw0e/uKq+IgEb7cLzS6TXXm
         0YUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I35hMBLj+gQ46cnP7/cbmgYIA1WQF5HE8dkz5wshcwo=;
        b=LTr5xvcfe1LFT0ArUM+pc28sz6xQ1KKrlVyZfOnqSNIddPCjsQobLfJZ+LZs2uAipG
         CIfv2hGfXKYEijI43gqYwCtSXcR6oocY8VcL/8MoVAsJtbza4X24IN7H+wFlVNp6tXOu
         PYE0ajUa8NzOsUK//Y+pvvex4Hb+ZKDjUMIUyHeNtaedn/d02QG5fzfGIcT+KOtIySd4
         zwN/sf/UPlABSeNvtBa8VHVMmEii+9C2KPxEGzM/KUalrbI2wMhsBmcKT4EKjHz1fJkE
         cUao+O8cEKBBbLPodiY/LIkgjFEazZKpE1ilv1Evn/gW8FIreBkiErsyKMft4w+3VK5k
         w+rw==
X-Gm-Message-State: AO0yUKXZ44C8lRJuaVSjv1MeFltduBNHCKUd0ZnG7e0JoPSvpsxdsbFD
        7qceWdzA1KVwr+/ZBaJ2iag=
X-Google-Smtp-Source: AK7set+xfBIz1d2NTd7lwk9N1z5NPmcO/eSykkaoeZZksBjhnkYIstgkLJZKgQUENp7nfpMEQgqDoQ==
X-Received: by 2002:a05:6870:ac20:b0:163:9f85:cb4c with SMTP id kw32-20020a056870ac2000b001639f85cb4cmr152173oab.16.1674917631205;
        Sat, 28 Jan 2023 06:53:51 -0800 (PST)
Received: from tx3000mach.io (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id de3-20020a05687075c300b001446a45bb49sm3121201oab.23.2023.01.28.06.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jan 2023 06:53:50 -0800 (PST)
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
To:     wedsonaf@gmail.com
Cc:     alex.gaynor@gmail.com, bjorn3_gh@protonmail.com,
        boqun.feng@gmail.com, gary@garyguo.net,
        linux-kernel@vger.kernel.org, ojeda@kernel.org,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/5] rust: types: introduce `ForeignOwnable`
Date:   Sat, 28 Jan 2023 11:53:45 -0300
Message-Id: <20230128145345.1770912-1-yakoyoku@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230119174036.64046-2-wedsonaf@gmail.com>
References: <20230119174036.64046-2-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 02:40:33PM -0300, Wedson Almeida Filho wrote:=0D
> It was originally called `PointerWrapper`. It is used to convert=0D
> a Rust object to a pointer representation (void *) that can be=0D
> stored on the C side, used, and eventually returned to Rust.=0D
> =0D
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>=0D
> ---=0D
>  rust/kernel/lib.rs   |  1 +=0D
>  rust/kernel/types.rs | 54 ++++++++++++++++++++++++++++++++++++++++++++=0D
>  2 files changed, 55 insertions(+)=0D
> =0D
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs=0D
> index e0b0e953907d..223564f9f0cc 100644=0D
> --- a/rust/kernel/lib.rs=0D
> +++ b/rust/kernel/lib.rs=0D
> @@ -16,6 +16,7 @@=0D
>  #![feature(coerce_unsized)]=0D
>  #![feature(core_ffi_c)]=0D
>  #![feature(dispatch_from_dyn)]=0D
> +#![feature(generic_associated_types)]=0D
>  #![feature(receiver_trait)]=0D
>  #![feature(unsize)]=0D
>  =0D
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs=0D
> index f0ad4472292d..5475f6163002 100644=0D
> --- a/rust/kernel/types.rs=0D
> +++ b/rust/kernel/types.rs=0D
> @@ -9,6 +9,60 @@ use core::{=0D
>      ops::{Deref, DerefMut},=0D
>  };=0D
>  =0D
> +/// Used to transfer ownership to and from foreign (non-Rust) languages.=
=0D
> +///=0D
> +/// Ownership is transferred from Rust to a foreign language by calling =
[`Self::into_foreign`] and=0D
> +/// later may be transferred back to Rust by calling [`Self::from_foreig=
n`].=0D
> +///=0D
> +/// This trait is meant to be used in cases when Rust objects are stored=
 in C objects and=0D
> +/// eventually "freed" back to Rust.=0D
> +pub trait ForeignOwnable {=0D
> +    /// Type of values borrowed between calls to [`ForeignOwnable::into_=
foreign`] and=0D
> +    /// [`ForeignOwnable::from_foreign`].=0D
> +    type Borrowed<'a>;=0D
=0D
Is it there a possibility that this could make use of borrowing features=0D
like AsRef/Borrowed/Deref?=0D
=0D
> +=0D
> +    /// Converts a Rust-owned object to a foreign-owned one.=0D
> +    ///=0D
> +    /// The foreign representation is a pointer to void.=0D
> +    fn into_foreign(self) -> *const core::ffi::c_void;=0D
> +=0D
> +    /// Borrows a foreign-owned object.=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for=0D
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.=0D
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow_mut`]=0D
> +    /// for this object must have been dropped.=0D
> +    unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrowe=
d<'a>;=0D
> +=0D
> +    /// Mutably borrows a foreign-owned object.=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for=0D
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.=0D
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and=0D
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.=0D
> +    unsafe fn borrow_mut<T: ForeignOwnable>(ptr: *const core::ffi::c_voi=
d) -> ScopeGuard<T, fn(T)> {=0D
> +        // SAFETY: The safety requirements ensure that `ptr` came from a=
 previous call to=0D
> +        // `into_foreign`.=0D
> +        ScopeGuard::new_with_data(unsafe { T::from_foreign(ptr) }, |d| {=
=0D
> +            d.into_foreign();=0D
> +        })=0D
> +    }=0D
=0D
Could these three methods have a borrowing equivalent? When I was=0D
working on some features for the USB module I've stumbled upon the case=0D
of having to encode a pointer (with a pivot) and I cannot do it without=0D
taking ownership of the pointer.=0D
=0D
> +=0D
> +    /// Converts a foreign-owned object back to a Rust-owned one.=0D
> +    ///=0D
> +    /// # Safety=0D
> +    ///=0D
> +    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for=0D
> +    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.=0D
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and=0D
> +    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.=0D
> +    unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;=0D
> +}=0D
> +=0D
>  /// Runs a cleanup function/closure when dropped.=0D
>  ///=0D
>  /// The [`ScopeGuard::dismiss`] function prevents the cleanup function f=
rom running.=0D
> -- =0D
> 2.34.1=0D
=0D
Aside from these comments I observe that there's a possibility to make=0D
ForeignOwnable a const trait and have non const implementors. Otherwise=0D
if these things are out of scope, no problem whatsoever and this has my=0D
OK.=0D
=0D
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>=0D
