Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 891EB72B28A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbjFKPst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjFKPsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:48:47 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E0113D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 08:48:42 -0700 (PDT)
Date:   Sun, 11 Jun 2023 15:48:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686498520; x=1686757720;
        bh=llThXYR/g/KbQkmoR17RlJfSDl2qAR2F4OAIJumA+eM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=g76RGSywGB6xjzPyW6VilVGaHlM7ho5EX2WpRqG99kgZWilxwRCfzqVLT2W6o274F
         hRVuaInH2oI/6DujaUJjG0rCtWBNjKAiXjr/pLtr3oI29QAQsyihS0cyeCxReuQglm
         VjbecqsZjI0HuPBP/V//q4BKPwUI1DksRhlJzo/48OHPKL9TsYoZFejq+xqjtWTwHr
         uD7l55KIffo5GLfHE7qCj0Om49ZamNqoqTalUiDWqxDh5bJPZxmB/Moq8ZVLX1YTGH
         qoXDjZzTfef0nzYthtmsnPo+6dkWGz3yMwN8E3e7sgVW8iXXLjiTq3WKBJDfC5DCnd
         eEle7bJ7aInHQ==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 3/8] rust: sync: add `Arc::{from_raw, into_raw}`
Message-ID: <IpzwVmcwX_B9GjTOYg1fc7xC6F3zXmdH-zopjNRU3nyHhQN8K1PT4sE6Xv9e4s4vPYnmKwl6GvMdWiJtk3Vr8ECz8I7OAdofoyyqAwbQ9WY=@proton.me>
In-Reply-To: <20230601134946.3887870-4-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com> <20230601134946.3887870-4-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:49, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> These methods can be used to turn an `Arc` into a raw pointer and back,
> in a way that preserves the metadata for fat pointers.
>=20
> This is done using the unstable ptr_metadata feature [1]. However, it
> could also be done using the unstable pointer_byte_offsets feature [2],
> which is likely to have a shorter path to stabilization than
> ptr_metadata.
>=20
> Link: https://github.com/rust-lang/rust/issues/81513 [1]
> Link: https://github.com/rust-lang/rust/issues/96283 [2]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>   rust/kernel/lib.rs      |  1 +
>   rust/kernel/sync/arc.rs | 42 ++++++++++++++++++++++++++++++++++++++++-
>   2 files changed, 42 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 7ea777b731e6..ad9142928fb1 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -17,6 +17,7 @@
>   #![feature(const_refs_to_cell)]
>   #![feature(dispatch_from_dyn)]
>   #![feature(new_uninit)]
> +#![feature(ptr_metadata)]
>   #![feature(receiver_trait)]
>   #![feature(unsize)]
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..684be9f73aca 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -24,7 +24,7 @@
>   };
>   use alloc::boxed::Box;
>   use core::{
> -    alloc::AllocError,
> +    alloc::{AllocError, Layout},
>       fmt,
>       marker::{PhantomData, Unsize},
>       mem::{ManuallyDrop, MaybeUninit},
> @@ -212,6 +212,46 @@ unsafe fn from_inner(inner: NonNull<ArcInner<T>>) ->=
 Self {
>           }
>       }
>=20
> +    /// Convert the [`Arc`] into a raw pointer.
> +    ///
> +    /// The raw pointer has ownership of the refcount that this Arc obje=
ct owned.
> +    pub fn into_raw(self) -> *const T {
> +        let ptr =3D self.ptr.as_ptr();
> +        core::mem::forget(self);
> +        // SAFETY: The pointer is valid.
> +        unsafe { core::ptr::addr_of!((*ptr).data) }
> +    }
> +
> +    /// Recreates an [`Arc`] instance previously deconstructed via [`Arc=
::into_raw`].
> +    ///
> +    /// This code relies on the `repr(C)` layout of structs as described=
 in
> +    /// <https://doc.rust-lang.org/reference/type-layout.html#reprc-stru=
cts>.
> +    ///
> +    /// # Safety
> +    ///
> +    /// `ptr` must have been returned by a previous call to [`Arc::into_=
raw`]. Additionally, it
> +    /// can only be called once for each previous call to [`Arc::into_ra=
w`].
> +    pub unsafe fn from_raw(ptr: *const T) -> Self {
> +        let refcount_layout =3D Layout::new::<bindings::refcount_t>();
> +        // SAFETY: The caller guarantees that the pointer is valid.
> +        let val_layout =3D unsafe { Layout::for_value(&*ptr) };
> +        // SAFETY: We're computing the layout of a real struct that exis=
ted when compiling this
> +        // binary, so its layout is not so large that it can trigger ari=
thmetic overflow.
> +        let val_offset =3D unsafe { refcount_layout.extend(val_layout).u=
nwrap_unchecked().1 };
> +
> +        // This preserves the metadata in the pointer, if any.
> +        //
> +        // Note that `*const T` and `*const ArcInner<T>` have the same m=
etadata as documented at
> +        // <https://doc.rust-lang.org/std/ptr/trait.Pointee.html>.
> +        let metadata =3D core::ptr::metadata(ptr as *const ArcInner<T>);
> +        let ptr =3D (ptr as *mut u8).wrapping_sub(val_offset) as *mut ()=
;
> +        let ptr =3D core::ptr::from_raw_parts_mut(ptr, metadata);
> +
> +        // SAFETY: By the safety requirements we know that `ptr` came fr=
om `Arc::into_raw`, so the
> +        // reference count held then will be owned by the new `Arc` obje=
ct.
> +        unsafe { Self::from_inner(NonNull::new_unchecked(ptr)) }
> +    }
> +
>       /// Returns an [`ArcBorrow`] from the given [`Arc`].
>       ///
>       /// This is useful when the argument of a function call is an [`Arc=
Borrow`] (e.g., in a method
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>=20

