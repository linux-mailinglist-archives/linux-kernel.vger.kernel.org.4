Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60A371F46E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 23:10:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbjFAVKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 17:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjFAVKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 17:10:19 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6B128;
        Thu,  1 Jun 2023 14:10:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-75b2726f04cso113635685a.3;
        Thu, 01 Jun 2023 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685653815; x=1688245815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRkLCtm/2t4nM1Hj+K53sJanop38MkOVUSZ+C5sKwdo=;
        b=Rje78LDSW0Bo/k0B3xoKY/WFS56OY199KeIgpkWhxSi8Z2+D0ox+TWQ8mXNFQryVWj
         TFxxHmG0mm+dFVipfOSfmEOzqxfzol2EH6g2MI3pd0yXhtguAbhmgCtjxN4H84xOKL8I
         GKJjYeWqGoioHkP8L/6tkGuD+gVzaAFvCfWtptvPm+KwQ2iWIKen3ZW5WpmeKbBL0SY4
         GeTkWwh6SZTb9zNafFzNMLONOhRZy+SGv9CtMyPsVAdH2DxZsJGQL01zp1hM6TEpq3dQ
         98qgT2g5bNyoE5cMgAKzt48SPMWzcuTKY3PYFAqfISiiNlJGo+AcnMSGQLiRQ+EYJhrC
         0UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685653815; x=1688245815;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRkLCtm/2t4nM1Hj+K53sJanop38MkOVUSZ+C5sKwdo=;
        b=iNYFI728KagHdJ7pEnja+d5ql7u4wSweqFkkDA5KmwUGyIKsBflg1zgr+ERw/16IFT
         o1IjG3xTJRYr6NuG2fDGsb+b/tVJYXbgmi6jI3PaVYMUqZmuicUKJrQlToSuKourcUzz
         1gyGP09LslNPOyZCFWlBaz6qFI8nlDtKEqMev74wRgJUv0xG0ZMQROD+gcHJ7ONY1r7g
         26OGCCw0KM0vvLlXvL+Szk7yeq6K1VBx9J6sEXcjOCHy/YU4mASDbMueZIR9mm6fv7KS
         zy298wl7jdBbQA0UxnMALttc6mw1gBNO76Fdr1ldrk7Q1AEe8VoRKQuIhFpM8b4eXgRR
         G4fw==
X-Gm-Message-State: AC+VfDxQXDmQe11oDV8vJJpmZsaus59JIVpukQTAqnyvwsOmjcIdbHWd
        DIsjVTCGGjeUABQRhvebnQw=
X-Google-Smtp-Source: ACHHUZ577G+41pMS3I4wB0LxPaprLCqY2T3fBfUJHve0czV3zJVK5jUMTK7xgadRibRENFjUT3JgZA==
X-Received: by 2002:a05:620a:618d:b0:75b:23a1:8e7b with SMTP id or13-20020a05620a618d00b0075b23a18e7bmr11223900qkn.76.1685653815342;
        Thu, 01 Jun 2023 14:10:15 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id e14-20020a05620a12ce00b00755951e48desm7006936qkl.135.2023.06.01.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jun 2023 14:10:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 65D1A27C0054;
        Thu,  1 Jun 2023 17:10:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 01 Jun 2023 17:10:14 -0400
X-ME-Sender: <xms:Ngl5ZCCGYq4At35VdgFUh64sgVR6fN596EZ1MjCc1GkHJxh-aCnLhw>
    <xme:Ngl5ZMj36XHOuxsmV2Q241msySSRatchFAr-C2mbS6Oz6KaQTHYtKTLID_emBDo3H
    LCGR9EZ8pdL7FJdew>
X-ME-Received: <xmr:Ngl5ZFmI_IhJnlx-ANJ9PXdpu8QQEH0jWpJKpCdTKubxBM-yN8I2PgFf-sA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Ngl5ZAxw9VrRKye0M-ALKhRgMz8dTA4VzxekVjau4qWZTedg6CEghQ>
    <xmx:Ngl5ZHRBfyyBTVoARrMBG9lYNU1_Yptxdd6gHFvQP6tc_sVCtTE35A>
    <xmx:Ngl5ZLay07ZyBVvYHLwRcHJ7wCXiQQVUdzA02SHhJeaZ2LPuoZQo2Q>
    <xmx:Ngl5ZPbeM4zjNQnPu7TAAxKsWd0EUDGy_oaOAHUgJP2TWMJw-AtRGQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 17:10:13 -0400 (EDT)
Date:   Thu, 1 Jun 2023 14:09:04 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 5/8] rust: workqueue: add helper for defining
 work_struct fields
Message-ID: <ZHkI8LXrqUOJ7G5E@boqun-archlinux>
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-6-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601134946.3887870-6-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 01:49:43PM +0000, Alice Ryhl wrote:
> The main challenge with defining `work_struct` fields is making sure
> that the function pointer stored in the `work_struct` is appropriate for
> the work item type it is embedded in. It needs to know the offset of the
> `work_struct` field being used (even if there are several!) so that it
> can do a `container_of`, and it needs to know the type of the work item
> so that it can call into the right user-provided code. All of this needs
> to happen in a way that provides a safe API to the user, so that users
> of the workqueue cannot mix up the function pointers.
> 
> There are three important pieces that are relevant when doing this:
> 
>  * The pointer type.
>  * The work item struct. This is what the pointer points at.
>  * The `work_struct` field. This is a field of the work item struct.
> 
> This patch introduces a separate trait for each piece. The pointer type
> is given a `WorkItemPointer` trait, which pointer types need to
> implement to be usable with the workqueue. This trait will be
> implemented for `Arc` and `Box` in a later patch in this patchset.
> Implementing this trait is unsafe because this is where the
> `container_of` operation happens, but user-code will not need to
> implement it themselves.
> 
> The work item struct should then implement the `WorkItem` trait. This
> trait is where user-code specifies what they want to happen when a work
> item is executed. It also specifies what the correct pointer type is.
> 
> Finally, to make the work item struct know the offset of its
> `work_struct` field, we use a trait called `HasWork<T, ID>`. If a type
> implements this trait, then the type declares that, at the given offset,
> there is a field of type `Work<T, ID>`. The trait is marked unsafe
> because the OFFSET constant must be correct, but we provide an
> `impl_has_work!` macro that can safely implement `HasWork<T>` on a type.
> The macro expands to something that only compiles if the specified field
> really has the type `Work<T>`. It is used like this:
> 
> ```
> struct MyWorkItem {
>     work_field: Work<MyWorkItem, 1>,
> }
> 
> impl_has_work! {
>     impl HasWork<MyWorkItem, 1> for MyWorkItem { self.work_field }
> }
> ```
> 
> Note that since the `Work` type is annotated with an id, you can have
> several `work_struct` fields by using a different id for each one.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/helpers.c           |   8 ++
>  rust/kernel/workqueue.rs | 219 ++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 226 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..7f0c2fe2fbeb 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
> +#include <linux/workqueue.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -128,6 +129,13 @@ void rust_helper_put_task_struct(struct task_struct *t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>  
> +void rust_helper___INIT_WORK(struct work_struct *work, work_func_t func,
> +			     bool on_stack)
> +{
> +	__INIT_WORK(work, func, on_stack);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper___INIT_WORK);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index e37820f253f6..dbf0aab29a85 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -2,9 +2,34 @@
>  
>  //! Work queues.
>  //!
> +//! This file has two components: The raw work item API, and the safe work item API.
> +//!
> +//! One pattern that is used in both APIs is the `ID` const generic, which exists to allow a single
> +//! type to define multiple `work_struct` fields. This is done by choosing an id for each field,
> +//! and using that id to specify which field you wish to use. (The actual value doesn't matter, as
> +//! long as you use different values for different fields of the same struct.) Since these IDs are
> +//! generic, they are used only at compile-time, so they shouldn't exist in the final binary.
> +//!
> +//! # The raw API
> +//!
> +//! The raw API consists of the `RawWorkItem` trait, where the work item needs to provide an
> +//! arbitrary function that knows how to enqueue the work item. It should usually not be used
> +//! directly, but if you want to, you can use it without using the pieces from the safe API.
> +//!
> +//! # The safe API
> +//!
> +//! The safe API is used via the `Work` struct and `WorkItem` traits. Furthermore, it also includes
> +//! a trait called `WorkItemPointer`, which is usually not used directly by the user.
> +//!
> +//!  * The `Work` struct is the Rust wrapper for the C `work_struct` type.
> +//!  * The `WorkItem` trait is implemented for structs that can be enqueued to a workqueue.
> +//!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
> +//!    that implements `WorkItem`.
> +//!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
> -use crate::{bindings, types::Opaque};
> +use crate::{bindings, prelude::*, types::Opaque};
> +use core::marker::{PhantomData, PhantomPinned};
>  
>  /// A kernel work queue.
>  ///
> @@ -106,6 +131,198 @@ unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
>  
> +/// Defines the method that should be called directly when a work item is executed.
> +///
> +/// Typically you would implement [`WorkItem`] instead. The `run` method on this trait will
> +/// usually just perform the appropriate `container_of` translation and then call into the `run`
> +/// method from the [`WorkItem`] trait.
> +///
> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that [`__enqueue`] uses a `work_struct` initialized with the [`run`]
> +/// method of this trait as the function pointer.
> +///
> +/// [`__enqueue`]: RawWorkItem::__enqueue
> +/// [`run`]: WorkItemPointer::run
> +pub unsafe trait WorkItemPointer<const ID: u64>: RawWorkItem<ID> {
> +    /// Run this work item.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided `work_struct` pointer must originate from a previous call to `__enqueue` where
> +    /// the `queue_work_on` closure returned true, and the pointer must still be valid.
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct);
> +}
> +
> +/// Defines the method that should be called when this work item is executed.
> +///
> +/// This trait is used when the `work_struct` field is defined using the [`Work`] helper.
> +pub trait WorkItem<const ID: u64 = 0> {
> +    /// The pointer type that this struct is wrapped in. This will typically be `Arc<Self>` or
> +    /// `Pin<Box<Self>>`.
> +    type Pointer: WorkItemPointer<ID>;

This being an associate type makes me wonder how do we want to support
the following (totally made-up by me, but I think it makes sense)?:

Say we have a struct

	pub struct Foo {
		work: Work<Foo>,
		data: Data,
	}

	impl Foo {
		pub fn do_sth(&self) {
			...
		}
	}

and we want to queue both Pin<Box<Foo>> and Arc<Foo> as work items, but
the following doesn't work:

	// Pin<Box<Foo>> can be queued.
	impl WorkItem for Foo {
		type Pointer = Pin<Box<Foo>>;
		fn run(ptr: Self::Pointer) {
			ptr.do_sth();
		}
	}

	// Arc<Foo> can also be queued.
	impl WorkItem for Foo {
		type Pointer = Arc<Foo>;
		fn run(ptr: Self::Pointer) {
			ptr.do_sth();
		}
	}



Of course, we can use new type idiom, but that's not really great, and
we may have more smart pointer types in the future.

Am I missing something here?

Regards,
Boqun

> +
> +    /// The method that should be called when this work item is executed.
> +    fn run(this: Self::Pointer);
> +}
> +
> +/// Links for a work item.
> +///
> +/// This struct contains a function pointer to the `run` function from the [`WorkItemPointer`]
> +/// trait, and defines the linked list pointers necessary to enqueue a work item in a workqueue.
> +///
> +/// Wraps the kernel's C `struct work_struct`.
> +///
> +/// This is a helper type used to associate a `work_struct` with the [`WorkItem`] that uses it.
> +#[repr(transparent)]
> +pub struct Work<T: ?Sized, const ID: u64 = 0> {
> +    work: Opaque<bindings::work_struct>,
> +    _pin: PhantomPinned,
> +    _inner: PhantomData<T>,
> +}
> +
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Send for Work<T, ID> {}
> +// SAFETY: Kernel work items are usable from any thread.
> +//
> +// We do not need to constrain `T` since the work item does not actually contain a `T`.
> +unsafe impl<T: ?Sized, const ID: u64> Sync for Work<T, ID> {}
> +
> +impl<T: ?Sized, const ID: u64> Work<T, ID> {
> +    /// Creates a new instance of [`Work`].
> +    #[inline]
> +    #[allow(clippy::new_ret_no_self)]
> +    pub fn new() -> impl PinInit<Self>
> +    where
> +        T: WorkItem<ID>,
> +    {
> +        // SAFETY: The `WorkItemPointer` implementation promises that `run` can be used as the work
> +        // item function.
> +        unsafe {
> +            kernel::init::pin_init_from_closure(move |slot| {
> +                bindings::__INIT_WORK(Self::raw_get(slot), Some(T::Pointer::run), false);
> +                Ok(())
> +            })
> +        }
> +    }
> +
> +    /// Get a pointer to the inner `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must not be dangling and must be properly aligned. (But the memory
> +    /// need not be initialized.)
> +    #[inline]
> +    pub unsafe fn raw_get(ptr: *const Self) -> *mut bindings::work_struct {
> +        // SAFETY: The caller promises that the pointer is aligned and not dangling.
> +        //
> +        // A pointer cast would also be ok due to `#[repr(transparent)]`. We use `addr_of!` so that
> +        // the compiler does not complain that the `work` field is unused.
> +        unsafe { Opaque::raw_get(core::ptr::addr_of!((*ptr).work)) }
> +    }
> +}
> +
> +/// Declares that a type has a [`Work<T, ID>`] field.
> +///
> +/// # Safety
> +///
> +/// The [`OFFSET`] constant must be the offset of a field in Self of type [`Work<T, ID>`]. The methods on
> +/// this trait must have exactly the behavior that the definitions given below have.
> +///
> +/// [`Work<T, ID>`]: Work
> +/// [`OFFSET`]: HasWork::OFFSET
> +pub unsafe trait HasWork<T, const ID: u64 = 0> {
> +    /// The offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    const OFFSET: usize;
> +
> +    /// Returns the offset of the [`Work<T, ID>`] field.
> +    ///
> +    /// This method exists because the [`OFFSET`] constant cannot be accessed if the type is not Sized.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    /// [`OFFSET`]: HasWork::OFFSET
> +    #[inline]
> +    fn get_work_offset(&self) -> usize {
> +        Self::OFFSET
> +    }
> +
> +    /// Returns a pointer to the [`Work<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> }
> +    }
> +
> +    /// Returns a pointer to the struct containing the [`Work<T, ID>`] field.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The pointer must point at a [`Work<T, ID>`] field in a struct of type `Self`.
> +    ///
> +    /// [`Work<T, ID>`]: Work
> +    #[inline]
> +    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> +    where
> +        Self: Sized,
> +    {
> +        // SAFETY: The caller promises that the pointer points at a field of the right type in the
> +        // right kind of struct.
> +        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> +    }
> +}
> +
> +/// Used to safely implement the [`HasWork<T, ID>`] trait.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// use kernel::sync::Arc;
> +///
> +/// struct MyStruct {
> +///     work_field: Work<MyStruct, 17>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyStruct, 17> for MyStruct { self.work_field }
> +/// }
> +/// ```
> +///
> +/// [`HasWork<T, ID>`]: HasWork
> +#[macro_export]
> +macro_rules! impl_has_work {
> +    ($(impl$(<$($implarg:ident),*>)?
> +       HasWork<$work_type:ty $(, $id:tt)?>
> +       for $self:ident $(<$($selfarg:ident),*>)?
> +       { self.$field:ident }
> +    )*) => {$(
> +        // SAFETY: The implementation of `raw_get_work` only compiles if the field has the right
> +        // type.
> +        unsafe impl$(<$($implarg),*>)? $crate::workqueue::HasWork<$work_type $(, $id)?> for $self $(<$($selfarg),*>)? {
> +            const OFFSET: usize = $crate::offset_of!(Self, $field) as usize;
> +
> +            #[inline]
> +            unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_type $(, $id)?> {
> +                // SAFETY: The caller promises that the pointer is not dangling.
> +                unsafe {
> +                    ::core::ptr::addr_of_mut!((*ptr).$field)
> +                }
> +            }
> +        }
> +    )*};
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 
