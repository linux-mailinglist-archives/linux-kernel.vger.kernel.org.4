Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71E965755C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 11:36:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232658AbiL1Kg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 05:36:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiL1Kgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 05:36:50 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791F3267C;
        Wed, 28 Dec 2022 02:36:48 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E26A55C0114;
        Wed, 28 Dec 2022 05:36:47 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 05:36:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1672223807; x=
        1672310207; bh=0slE/oRFVLbJz9/ts8cgECrW96Odx70qZ3hEiZYd6AI=; b=r
        Ad3jxfKYKanH0OEQW5uYj5Ha45JMaOA29g9Wx4mGEEl0bKbX4HigqrBWXy26SS63
        XIuzyz7MUaZZRbqcjh1EIPUDHzOROlC2WsIkRlHfnb04fwoXfQLN3MTSdZq6yyVT
        CyUBoq8pOzPmZsv134BtPHZLV+aEvxVjTyukskEFijuxu3I0dP301E+g0xXcHKsA
        4BJFrxgz+cGexJ5U025ObzRw4Du+FJ0qS9b6dNGAnrXi/SMdRFnImUgFN9Rklqtm
        xb1wkvrGVENVVy0rAOhGYSGCJiU0sp8CCcMGOC96gDO8WsZYtQqBTH96zl5OZ4Hn
        oUv8rcNBB+aKlTlQZi7RA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672223807; x=
        1672310207; bh=0slE/oRFVLbJz9/ts8cgECrW96Odx70qZ3hEiZYd6AI=; b=H
        yVHI5MAYdhg0aLAYx/B4p+k06BEKE2vqlfmUmGbaAdyBanqlxToFp0BT6xKe8GYD
        ETQQZJ6FNf1uUBcPOqa6Nmb8qUGKzy4wX272sVHDVj7IC6aRx0SlObJyxF1lZke9
        QFr3w+qbyQdnLndU9MjZeOQKSKaVk8bBRyYsaRUxNlYq8CdaC0t65Pd4oDfa4j7J
        ph/Jfz92ylDhk1MP/DQaAMOQGqc98HY085dFDqrc5IBpCcRYzCnSa+P/12yw4ytn
        48meg2vMTOZgHBhWSMT7OYNnXuEZedTZIE3td7DJSXE0BQbuPNB8ht3LTaQJ5A75
        /f7TED+7jmLPTcdGBmhdw==
X-ME-Sender: <xms:PxysY3VFKgv4WNOSzYMO9ucXU3ktiCreogyrgOMUEvkC1MqFL31X7g>
    <xme:PxysY_nMOIEDgXAzCzhbWpwmTvvlDhDJlXnFGrhklaGqvk1_pqYBX4EPIdnvY2MfT
    1adJnYSbYoN9D81CA>
X-ME-Received: <xmr:PxysYzZUQ-hX4a5AYJbK65OCKEUeX3EjBYyJ0gwU1UY5x4yIwIAmH0hfVLUutFayMrvcamPV0XBUEqNtweQjxO7snw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehlihgt
    vgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnhepve
    duhfduheetgeevieevudetfeekhefhkeffffeuueeuvdevtefggeehgfefveevnecuffho
    mhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgpdhpthhrrdgrshenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvsehrhihhlhdrihho
X-ME-Proxy: <xmx:PxysYyXL_hyOKtwOyY5Qyw-J4xG-sP3FoHHV1V7VFMJQZUJ_mtZMxQ>
    <xmx:PxysYxmBX9u3qvrbBBLTs74md66q3BepvNfrWBMm8FSO13egb8ykmQ>
    <xmx:PxysY_cJmWfMjVx961OWNhZNBY8_opzgaISlqDZf2qDltA-Fs7gLXw>
    <xmx:PxysYyj_IGQt2eisSNX0J9ADELfManQPcgpJnwUdJ0F6pCnRHl_KiQ>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 05:36:45 -0500 (EST)
Message-ID: <d00d2225-24be-ab44-169a-989950130b93@ryhl.io>
Date:   Wed, 28 Dec 2022 11:38:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Content-Language: en-US
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <a23d715d-19c1-dff4-f7e6-504ebb0e2c6c@ryhl.io>
 <CANeycqqRzOJSiHrSsrJi+VFKjssBtbpaEAWP-z4VVZyiSUnT-w@mail.gmail.com>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <CANeycqqRzOJSiHrSsrJi+VFKjssBtbpaEAWP-z4VVZyiSUnT-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/28/22 11:14, Wedson Almeida Filho wrote:
> On Wed, 28 Dec 2022 at 10:02, Alice Ryhl <alice@ryhl.io> wrote:
>>
>> On 12/28/22 07:03, Wedson Almeida Filho wrote:
>>> This is a basic implementation of `Arc` backed by C's `refcount_t`. It
>>> allows Rust code to idiomatically allocate memory that is ref-counted.
>>>
>>> Cc: Will Deacon <will@kernel.org>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Boqun Feng <boqun.feng@gmail.com>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>>
>> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> 
> Thanks for reviewing!
> 
>> Instead of Box::leak, it would be more idiomatic to use Box::into_raw,
>> but both approaches will work.
> 
> `Box::into_raw` returns a `*mut T`, whose conversion to `NonNull<T>`
> is fallible (because it could be null). `Box::leak`, OTOH, returns an
> `&mut T`, which cannot be null so it can be converted to `NonNull<T>`
> infallibly.
> 

The raw pointer returned by Box::into_raw is guaranteed to be non-null, 
so the conversion isn't fallible. You can go through 
NonNull::new_unchecked. (It's the same pointer as the one Box::leak 
returns, so it must be non-null.)

Regardless, researching more on this topic, it appears that other people 
think that going through leak *is* the idiomatic way, even though it 
involves going through a reference and back, which is otherwise very 
unidiomatic for code dealing with raw pointers.

I am fine with keeping it as-is.

> 
>> Regards,
>> Alice Ryhl
>>
>>> ---
>>>    rust/bindings/bindings_helper.h |   1 +
>>>    rust/bindings/lib.rs            |   1 +
>>>    rust/helpers.c                  |  19 ++++
>>>    rust/kernel/lib.rs              |   1 +
>>>    rust/kernel/sync.rs             |  10 ++
>>>    rust/kernel/sync/arc.rs         | 157 ++++++++++++++++++++++++++++++++
>>>    6 files changed, 189 insertions(+)
>>>    create mode 100644 rust/kernel/sync.rs
>>>    create mode 100644 rust/kernel/sync/arc.rs
>>>
>>> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
>>> index c48bc284214a..75d85bd6c592 100644
>>> --- a/rust/bindings/bindings_helper.h
>>> +++ b/rust/bindings/bindings_helper.h
>>> @@ -7,6 +7,7 @@
>>>     */
>>>
>>>    #include <linux/slab.h>
>>> +#include <linux/refcount.h>
>>>
>>>    /* `bindgen` gets confused at certain things. */
>>>    const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
>>> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
>>> index 6c50ee62c56b..7b246454e009 100644
>>> --- a/rust/bindings/lib.rs
>>> +++ b/rust/bindings/lib.rs
>>> @@ -41,6 +41,7 @@ mod bindings_raw {
>>>    #[allow(dead_code)]
>>>    mod bindings_helper {
>>>        // Import the generated bindings for types.
>>> +    use super::bindings_raw::*;
>>>        include!(concat!(
>>>            env!("OBJTREE"),
>>>            "/rust/bindings/bindings_helpers_generated.rs"
>>> diff --git a/rust/helpers.c b/rust/helpers.c
>>> index b4f15eee2ffd..09a4d93f9d62 100644
>>> --- a/rust/helpers.c
>>> +++ b/rust/helpers.c
>>> @@ -20,6 +20,7 @@
>>>
>>>    #include <linux/bug.h>
>>>    #include <linux/build_bug.h>
>>> +#include <linux/refcount.h>
>>>
>>>    __noreturn void rust_helper_BUG(void)
>>>    {
>>> @@ -27,6 +28,24 @@ __noreturn void rust_helper_BUG(void)
>>>    }
>>>    EXPORT_SYMBOL_GPL(rust_helper_BUG);
>>>
>>> +refcount_t rust_helper_REFCOUNT_INIT(int n)
>>> +{
>>> +     return (refcount_t)REFCOUNT_INIT(n);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_REFCOUNT_INIT);
>>> +
>>> +void rust_helper_refcount_inc(refcount_t *r)
>>> +{
>>> +     refcount_inc(r);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_inc);
>>> +
>>> +bool rust_helper_refcount_dec_and_test(refcount_t *r)
>>> +{
>>> +     return refcount_dec_and_test(r);
>>> +}
>>> +EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>>> +
>>>    /*
>>>     * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>>>     * as the Rust `usize` type, so we can use it in contexts where Rust
>>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>>> index 53040fa9e897..ace064a3702a 100644
>>> --- a/rust/kernel/lib.rs
>>> +++ b/rust/kernel/lib.rs
>>> @@ -31,6 +31,7 @@ mod static_assert;
>>>    #[doc(hidden)]
>>>    pub mod std_vendor;
>>>    pub mod str;
>>> +pub mod sync;
>>>    pub mod types;
>>>
>>>    #[doc(hidden)]
>>> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
>>> new file mode 100644
>>> index 000000000000..39b379dd548f
>>> --- /dev/null
>>> +++ b/rust/kernel/sync.rs
>>> @@ -0,0 +1,10 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! Synchronisation primitives.
>>> +//!
>>> +//! This module contains the kernel APIs related to synchronisation that have been ported or
>>> +//! wrapped for usage by Rust code in the kernel.
>>> +
>>> +mod arc;
>>> +
>>> +pub use arc::Arc;
>>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>>> new file mode 100644
>>> index 000000000000..22290eb5ab9b
>>> --- /dev/null
>>> +++ b/rust/kernel/sync/arc.rs
>>> @@ -0,0 +1,157 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +
>>> +//! A reference-counted pointer.
>>> +//!
>>> +//! This module implements a way for users to create reference-counted objects and pointers to
>>> +//! them. Such a pointer automatically increments and decrements the count, and drops the
>>> +//! underlying object when it reaches zero. It is also safe to use concurrently from multiple
>>> +//! threads.
>>> +//!
>>> +//! It is different from the standard library's [`Arc`] in a few ways:
>>> +//! 1. It is backed by the kernel's `refcount_t` type.
>>> +//! 2. It does not support weak references, which allows it to be half the size.
>>> +//! 3. It saturates the reference count instead of aborting when it goes over a threshold.
>>> +//! 4. It does not provide a `get_mut` method, so the ref counted object is pinned.
>>> +//!
>>> +//! [`Arc`]: https://doc.rust-lang.org/std/sync/struct.Arc.html
>>> +
>>> +use crate::{bindings, error::Result, types::Opaque};
>>> +use alloc::boxed::Box;
>>> +use core::{marker::PhantomData, ops::Deref, ptr::NonNull};
>>> +
>>> +/// A reference-counted pointer to an instance of `T`.
>>> +///
>>> +/// The reference count is incremented when new instances of [`Arc`] are created, and decremented
>>> +/// when they are dropped. When the count reaches zero, the underlying `T` is also dropped.
>>> +///
>>> +/// # Invariants
>>> +///
>>> +/// The reference count on an instance of [`Arc`] is always non-zero.
>>> +/// The object pointed to by [`Arc`] is always pinned.
>>> +///
>>> +/// # Examples
>>> +///
>>> +/// ```
>>> +/// use kernel::sync::Arc;
>>> +///
>>> +/// struct Example {
>>> +///     a: u32,
>>> +///     b: u32,
>>> +/// }
>>> +///
>>> +/// // Create a ref-counted instance of `Example`.
>>> +/// let obj = Arc::try_new(Example { a: 10, b: 20 })?;
>>> +///
>>> +/// // Get a new pointer to `obj` and increment the refcount.
>>> +/// let cloned = obj.clone();
>>> +///
>>> +/// // Assert that both `obj` and `cloned` point to the same underlying object.
>>> +/// assert!(core::ptr::eq(&*obj, &*cloned));
>>> +///
>>> +/// // Destroy `obj` and decrement its refcount.
>>> +/// drop(obj);
>>> +///
>>> +/// // Check that the values are still accessible through `cloned`.
>>> +/// assert_eq!(cloned.a, 10);
>>> +/// assert_eq!(cloned.b, 20);
>>> +///
>>> +/// // The refcount drops to zero when `cloned` goes out of scope, and the memory is freed.
>>> +/// ```
>>> +pub struct Arc<T: ?Sized> {
>>> +    ptr: NonNull<ArcInner<T>>,
>>> +    _p: PhantomData<ArcInner<T>>,
>>> +}
>>> +
>>> +#[repr(C)]
>>> +struct ArcInner<T: ?Sized> {
>>> +    refcount: Opaque<bindings::refcount_t>,
>>> +    data: T,
>>> +}
>>> +
>>> +// SAFETY: It is safe to send `Arc<T>` to another thread when the underlying `T` is `Sync` because
>>> +// it effectively means sharing `&T` (which is safe because `T` is `Sync`); additionally, it needs
>>> +// `T` to be `Send` because any thread that has an `Arc<T>` may ultimately access `T` directly, for
>>> +// example, when the reference count reaches zero and `T` is dropped.
>>> +unsafe impl<T: ?Sized + Sync + Send> Send for Arc<T> {}
>>> +
>>> +// SAFETY: It is safe to send `&Arc<T>` to another thread when the underlying `T` is `Sync` for the
>>> +// same reason as above. `T` needs to be `Send` as well because a thread can clone an `&Arc<T>`
>>> +// into an `Arc<T>`, which may lead to `T` being accessed by the same reasoning as above.
>>> +unsafe impl<T: ?Sized + Sync + Send> Sync for Arc<T> {}
>>> +
>>> +impl<T> Arc<T> {
>>> +    /// Constructs a new reference counted instance of `T`.
>>> +    pub fn try_new(contents: T) -> Result<Self> {
>>> +        // INVARIANT: The refcount is initialised to a non-zero value.
>>> +        let value = ArcInner {
>>> +            // SAFETY: There are no safety requirements for this FFI call.
>>> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }),
>>> +            data: contents,
>>> +        };
>>> +
>>> +        let inner = Box::try_new(value)?;
>>> +
>>> +        // SAFETY: We just created `inner` with a reference count of 1, which is owned by the new
>>> +        // `Arc` object.
>>> +        Ok(unsafe { Self::from_inner(Box::leak(inner).into()) })
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized> Arc<T> {
>>> +    /// Constructs a new [`Arc`] from an existing [`ArcInner`].
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The caller must ensure that `inner` points to a valid location and has a non-zero reference
>>> +    /// count, one of which will be owned by the new [`Arc`] instance.
>>> +    unsafe fn from_inner(inner: NonNull<ArcInner<T>>) -> Self {
>>> +        // INVARIANT: By the safety requirements, the invariants hold.
>>> +        Arc {
>>> +            ptr: inner,
>>> +            _p: PhantomData,
>>> +        }
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized> Deref for Arc<T> {
>>> +    type Target = T;
>>> +
>>> +    fn deref(&self) -> &Self::Target {
>>> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>>> +        // safe to dereference it.
>>> +        unsafe { &self.ptr.as_ref().data }
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized> Clone for Arc<T> {
>>> +    fn clone(&self) -> Self {
>>> +        // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.
>>> +        // SAFETY: By the type invariant, there is necessarily a reference to the object, so it is
>>> +        // safe to increment the refcount.
>>> +        unsafe { bindings::refcount_inc(self.ptr.as_ref().refcount.get()) };
>>> +
>>> +        // SAFETY: We just incremented the refcount. This increment is now owned by the new `Arc`.
>>> +        unsafe { Self::from_inner(self.ptr) }
>>> +    }
>>> +}
>>> +
>>> +impl<T: ?Sized> Drop for Arc<T> {
>>> +    fn drop(&mut self) {
>>> +        // SAFETY: By the type invariant, there is necessarily a reference to the object. We cannot
>>> +        // touch `refcount` after it's decremented to a non-zero value because another thread/CPU
>>> +        // may concurrently decrement it to zero and free it. It is ok to have a raw pointer to
>>> +        // freed/invalid memory as long as it is never dereferenced.
>>> +        let refcount = unsafe { self.ptr.as_ref() }.refcount.get();
>>> +
>>> +        // INVARIANT: If the refcount reaches zero, there are no other instances of `Arc`, and
>>> +        // this instance is being dropped, so the broken invariant is not observable.
>>> +        // SAFETY: Also by the type invariant, we are allowed to decrement the refcount.
>>> +        let is_zero = unsafe { bindings::refcount_dec_and_test(refcount) };
>>> +        if is_zero {
>>> +            // The count reached zero, we must free the memory.
>>> +            //
>>> +            // SAFETY: The pointer was initialised from the result of `Box::leak`.
>>> +            unsafe { Box::from_raw(self.ptr.as_ptr()) };
>>> +        }
>>> +    }
>>> +}
