Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303E165DBA8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240023AbjADRxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 12:53:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240103AbjADRxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 12:53:00 -0500
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6A2E0A2;
        Wed,  4 Jan 2023 09:52:58 -0800 (PST)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1442977d77dso40639463fac.6;
        Wed, 04 Jan 2023 09:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pzRN+ThvK9tCIgke9+TLEirKqYpVwfmOcXrEgIxAajI=;
        b=Bh+eN9QLMyipT6Z9HuZkAw5U7DOXS0Yx86HMEMI1AQBref5j0cYWdKlY5pro1eo5Ij
         of6QbL7Spuzk6CPXZGDPJIXYypt377XLxZChKWDpQvyoxzlpyynetvJKRlI3mZ7wytrO
         IOQGPvzOde80/6rR7tpK9Vn1LpJMMPN7A3Fq+b9WRkUFk+Kn/AMqoqbvFCnIX1ksj7kJ
         XOOyoaxzgOUSoH0temzpJ7qYs7Apg6I+KLygDD0ffiO8WYc4fuI/UNcrtmEX44KRUPsh
         eYN3bJqXDU46KyU6P+aYthrIj7UEYBAxG6zGu8LoLDyOg2uKp+mjQY3ZkKPwRj3J2SZF
         VDsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pzRN+ThvK9tCIgke9+TLEirKqYpVwfmOcXrEgIxAajI=;
        b=LYgJTr3QrNhbq2KDGUWVlhFvAP/Ef476BZIx0lw/LZuHnZLutUhkJeASRCqh1CYi0E
         9uw1vH0kLZO/brFoGq+fFzYKDdJ2GWLnhDVtMkX+ryUnoCscE3BB+rfHJo+3YY+54vFs
         DziqxbI1heAHefds2GonQjAbjFAfdA8bpffR5QeDJHjo4Ehjl/MssFmwI7DoUp2pX/3y
         wEkhnSYaD+iX0fDHTNqy8Oty/tVDps1tHb/SnsYjewQ9csiISPKzK70SbQ9BVOZPGt0f
         b1ZH2BhPxObW1c0MTZXGkyova4wwgwg0rDwJI685Nq+5G6X9EHOUfUX0crQBz/+Znnv3
         xP2w==
X-Gm-Message-State: AFqh2kqKM4RQsEIYRpKt3k9iGpBsERGmjVIFZFcOHZnbXjisvNFHCrgR
        BRCfPqCypFaax8EutmN/3vipQF6JhMq4iN2ggI8=
X-Google-Smtp-Source: AMrXdXtD98iNnP9l7LW63xiy0OQEGh+Cg1ggoDhD+5dqZSCaUmMt1C4pJrxjmNENyM2O1Wio9LnMyetUHjAgFag9Lv8=
X-Received: by 2002:a05:6870:ac10:b0:144:bf10:eecd with SMTP id
 kw16-20020a056870ac1000b00144bf10eecdmr3806466oab.204.1672854777368; Wed, 04
 Jan 2023 09:52:57 -0800 (PST)
MIME-Version: 1.0
References: <20221228060346.352362-1-wedsonaf@gmail.com> <20221228060346.352362-4-wedsonaf@gmail.com>
 <20221231194352.55cf0a26.gary@garyguo.net> <CANeycqrVsbNJ+A+A26LXkBezBNUHvnZU2Q3_whexCwwG5ZcgPQ@mail.gmail.com>
 <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
In-Reply-To: <df2f6c0b-fb4c-97e5-b607-7df626ea5933@crisal.io>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 4 Jan 2023 17:52:46 +0000
Message-ID: <CANeycqrBLoYSMcdNbD=SCbDc4dMFy3qi0rc2AznaBn5rQ0auEQ@mail.gmail.com>
Subject: Re: [PATCH 4/7] rust: sync: introduce `ArcBorrow`
To:     =?UTF-8?Q?Emilio_Cobos_=C3=81lvarez?= <emilio@crisal.io>
Cc:     Gary Guo <gary@garyguo.net>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 4 Jan 2023 at 16:06, Emilio Cobos =C3=81lvarez <emilio@crisal.io> w=
rote:
>
> Sorry for the drive-by comment, but maybe it saves some work.
>
> On 1/4/23 16:29, Wedson Almeida Filho wrote:
> > On Sat, 31 Dec 2022 at 19:43, Gary Guo <gary@garyguo.net> wrote:
> >>
> >> On Wed, 28 Dec 2022 06:03:43 +0000
> >> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> >>
> >>> This allows us to create references to a ref-counted allocation witho=
ut
> >>> double-indirection and that still allow us to increment the refcount =
to
> >>> a new `Arc<T>`.
> >>>
> >>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> >>> ---
> >>>   rust/kernel/sync.rs     |  2 +-
> >>>   rust/kernel/sync/arc.rs | 97 ++++++++++++++++++++++++++++++++++++++=
+++
> >>>   2 files changed, 98 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> >>> index 39b379dd548f..5de03ea83ea1 100644
> >>> --- a/rust/kernel/sync.rs
> >>> +++ b/rust/kernel/sync.rs
> >>> @@ -7,4 +7,4 @@
> >>>
> >>>   mod arc;
> >>>
> >>> -pub use arc::Arc;
> >>> +pub use arc::{Arc, ArcBorrow};
> >>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> >>> index dbc7596cc3ce..f68bfc02c81a 100644
> >>> --- a/rust/kernel/sync/arc.rs
> >>> +++ b/rust/kernel/sync/arc.rs
> >>> @@ -19,6 +19,7 @@ use crate::{bindings, error::Result, types::Opaque}=
;
> >>>   use alloc::boxed::Box;
> >>>   use core::{
> >>>       marker::{PhantomData, Unsize},
> >>> +    mem::ManuallyDrop,
> >>>       ops::Deref,
> >>>       ptr::NonNull,
> >>>   };
> >>> @@ -164,6 +165,18 @@ impl<T: ?Sized> Arc<T> {
> >>>               _p: PhantomData,
> >>>           }
> >>>       }
> >>> +
> >>> +    /// Returns an [`ArcBorrow`] from the given [`Arc`].
> >>> +    ///
> >>> +    /// This is useful when the argument of a function call is an [`=
ArcBorrow`] (e.g., in a method
> >>> +    /// receiver), but we have an [`Arc`] instead. Getting an [`ArcB=
orrow`] is free when optimised.
> >>> +    #[inline]
> >>> +    pub fn as_arc_borrow(&self) -> ArcBorrow<'_, T> {
> >>> +        // SAFETY: The constraint that the lifetime of the shared re=
ference must outlive that of
> >>> +        // the returned `ArcBorrow` ensures that the object remains =
alive and that no mutable
> >>> +        // reference can be created.
> >>> +        unsafe { ArcBorrow::new(self.ptr) }
> >>> +    }
> >>>   }
> >>>
> >>>   impl<T: ?Sized> Deref for Arc<T> {
> >>> @@ -208,3 +221,87 @@ impl<T: ?Sized> Drop for Arc<T> {
> >>>           }
> >>>       }
> >>>   }
> >>> +
> >>> +/// A borrowed reference to an [`Arc`] instance.
> >>> +///
> >>> +/// For cases when one doesn't ever need to increment the refcount o=
n the allocation, it is simpler
> >>> +/// to use just `&T`, which we can trivially get from an `Arc<T>` in=
stance.
> >>> +///
> >>> +/// However, when one may need to increment the refcount, it is pref=
erable to use an `ArcBorrow<T>`
> >>> +/// over `&Arc<T>` because the latter results in a double-indirectio=
n: a pointer (shared reference)
> >>> +/// to a pointer (`Arc<T>`) to the object (`T`). An [`ArcBorrow`] el=
iminates this double
> >>> +/// indirection while still allowing one to increment the refcount a=
nd getting an `Arc<T>` when/if
> >>> +/// needed.
> >>> +///
> >>> +/// # Invariants
> >>> +///
> >>> +/// There are no mutable references to the underlying [`Arc`], and i=
t remains valid for the
> >>> +/// lifetime of the [`ArcBorrow`] instance.
> >>> +///
> >>> +/// # Example
> >>> +///
> >>> +/// ```
> >>> +/// use crate::sync::{Arc, ArcBorrow};
> >>> +///
> >>> +/// struct Example;
> >>> +///
> >>> +/// fn do_something(e: ArcBorrow<'_, Example>) -> Arc<Example> {
> >>> +///     e.into()
> >>> +/// }
> >>> +///
> >>> +/// let obj =3D Arc::try_new(Example)?;
> >>> +/// let cloned =3D do_something(obj.as_arc_borrow());
> >>> +///
> >>> +/// // Assert that both `obj` and `cloned` point to the same underly=
ing object.
> >>> +/// assert!(core::ptr::eq(&*obj, &*cloned));
> >>> +/// ```
> >>> +pub struct ArcBorrow<'a, T: ?Sized + 'a> {
> >>> +    inner: NonNull<ArcInner<T>>,
> >>> +    _p: PhantomData<&'a ()>,
> >>> +}
> >>> +
> >>> +impl<T: ?Sized> Clone for ArcBorrow<'_, T> {
> >>> +    fn clone(&self) -> Self {
> >>> +        *self
> >>> +    }
> >>> +}
> >>> +
> >>> +impl<T: ?Sized> Copy for ArcBorrow<'_, T> {}
> >>
> >> Couldn't this just be derived `Clone` and `Copy`?
> >
> > Indeed. I'll send a v2 with this.
>
> I'm not sure this is true. Deriving will add the T: Copy and T: Clone
> bound, which I think is not what you want here.
>
> i.e., I assume you want an ArcBorrow to be Copy even if the underlying T
> is not.
>
> See <https://github.com/rust-lang/rust/issues/26925> for the relevant
> (really long-standing) Rust issue.

Thanks for the heads up, Emilio!

After trying this out, derive doesn't work. The errors brought me back
memories of when I first implemented this over a year ago, though I
didn't take the time to try to understand why it was failing.

So no v2. The series will remain as is.

Cheers

>
> Cheers,
>
>   -- Emilio
