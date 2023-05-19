Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA50708CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjESA3m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:29:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230048AbjESA3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:29:40 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 494101BD3;
        Thu, 18 May 2023 17:29:08 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a82841e582so179819a34.1;
        Thu, 18 May 2023 17:29:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456147; x=1687048147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oPtCHkDQxb8jka0MLHwCfUFpyGiljZFSFC0icEAAC9c=;
        b=WvvuohwzWbQMIqyo0Tzftsi/sG5397/XLweRRcG1vh0hG+QBoE2wwGa/O/h2/pdiJ7
         ybl96LPl6r4rNLMpopdKkAPJ9KkyohPoKN3Z/b32KKMKCESmC94V4IJuhQn6SEN/z4k3
         nBWAO6N0idBtV51Oumk7XIq66LtNBpoC89jiTggavlyTPE1CRwY9nXf1tDPttb55AseL
         f1NLdcqnx0olMKmv35FIkQRawFtpOiHR5q4jNwLqCEfywkvZnyHFPQX8oqArOwzbyQUN
         laXjp4GA3e1f6iXdl9IDejXUMzLik/Q9U4dXEOX519rwmwG2DynUwMp7TII1JHS/RAEN
         FNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456147; x=1687048147;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oPtCHkDQxb8jka0MLHwCfUFpyGiljZFSFC0icEAAC9c=;
        b=AGFmhlXtAPGiBR8qENMn6ZFkJkXonhHsbNvhPTTG3vjzW+muUbDSfnQqb+CpkkOMyJ
         SDgIaVGHGZprYIc/12WL9w9HkCHLMRJC2EKovYp5ZephawsUlqvYj+vzWVyScixeSRva
         /r+cBhEGQbCdMohwu/9Ar5prMsQHq2JY5akL2J1KLO0LPmGuz2x+tu7GYPjD85kX6/PV
         OElvY9pc9xZXXtHsbFKQwXyqwsFWBaBXEz1u+NtVwlYRzJ3wZghVG+DxnlYorpKg1h9S
         9zgGeQ0fx4/HTHv8ZN7I1y6trNuGx3zwQfMrb+UqR7DMq+XieWG2pdI2aTggdImL3x0o
         xKUA==
X-Gm-Message-State: AC+VfDwt16XZjuK1b8NWYz0DDCbQpuRD7iFsF6omNvSvsDIoBcSms6jA
        PghxrLPB9gVO5pZzEvNJK0Vx1Z+O9mU=
X-Google-Smtp-Source: ACHHUZ56NPeOBvdWmdOifZBkybGA0d+n6hi1s/Lb1LWLzH3Y5qH852YLu8wlX/GQBQdqLRCU4FazEg==
X-Received: by 2002:a05:6830:1208:b0:6a7:cdb1:88ff with SMTP id r8-20020a056830120800b006a7cdb188ffmr390175otp.14.1684456146947;
        Thu, 18 May 2023 17:29:06 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id h7-20020a056830164700b006a62aac5736sm1185054otr.28.2023.05.18.17.29.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:29:06 -0700 (PDT)
Message-ID: <b54801cd-1afb-2190-3b8a-4a095d04fdff@gmail.com>
Date:   Thu, 18 May 2023 21:17:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 6/7] rust: workqueue: add safe API to workqueue
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-7-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230517203119.3160435-7-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:31, Alice Ryhl wrote:
> This commit introduces `ArcWorkItem`, `BoxWorkItem`, and
> `define_work_adapter_newtype!` that make it possible to use the
> workqueue without any unsafe code whatsoever.
> 
> The `ArcWorkItem` and `BoxWorkItem` traits are used when a struct has a
> single `work_struct` field.
> 
> The `define_work_adapter_newtype!` macro is used when a struct has
> multiple `work_struct` fields. For each `work_struct` field, a newtype
> struct is defined that wraps `Arc<TheStruct>`, and pushing an instance
> of the newtype to a workqueue will enqueue it using the associated
> `work_struct` field. The newtypes are matched with `work_struct` fields
> by having the T in `Work<T>` be the newtype.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
> +
> +unsafe impl<T> WorkItem for Arc<T>
> +where
> +    T: ArcWorkItem + HasWork<Self> + ?Sized,
> +{
> +    type EnqueueOutput = Result<(), Self>;
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        let ptr = Arc::into_raw(self);
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_raw`.
> +        let off = unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr = unsafe { (ptr as *const u8).add(off) as *const Work<Self> };
> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {

Match for boolean is not a good pattern in my eyes, if-else should be
used instead. Also aren't the parens around the closure unnecessary?

> +            true => Ok(()),
> +            // SAFETY: The work queue has not taken ownership of the pointer.
> +            false => Err(unsafe { Arc::from_raw(ptr) }),
> +        }
> +    }
> +}
> +
> [...]
> +
> +unsafe impl<T> WorkItem for Pin<Box<T>>
> +where
> +    T: BoxWorkItem + HasWork<Self> + ?Sized,
> +{
> +    // When a box is in a workqueue, the workqueue has exclusive ownership of the box. Therefore,
> +    // it's not possible to enqueue a box while it is in a workqueue.
> +    type EnqueueOutput = ();
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F)
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        // SAFETY: We will not used the contents in an unpinned manner.
> +        let ptr = unsafe { Box::into_raw(Pin::into_inner_unchecked(self)) };
> +
> +        // Using `get_work_offset` here for object-safety.
> +        //
> +        // SAFETY: The pointer is valid since we just got it from `into_raw`.
> +        let off = unsafe { (&*ptr).get_work_offset() };
> +
> +        // SAFETY: The `HasWork` impl promises that this offset gives us a field of type
> +        // `Work<Self>` in the same allocation.
> +        let work_ptr = unsafe { (ptr as *mut u8).add(off) as *mut Work<Self> };
> +        // SAFETY: The pointer is not dangling.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        match (queue_work_on)(work_ptr) {

Same as above.

> +            true => {}
> +            // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
> +            // workqueue.
> +            false => unsafe { core::hint::unreachable_unchecked() },
> +        }
> +    }
> +}
> +
> [...]
> +
> +/// Helper macro for structs with several `Work` fields that can be in several queues at once.
> +///
> +/// For each `Work` field in your type `T`, a newtype struct that wraps an `Arc<T>` or
> +/// `Pin<Box<T>>` should be defined.
> +///
> +/// # Examples
> +///
> +/// ```

There must be those work macro and type imports here I think.

> +/// struct MyStruct {
> +///     work1: Work<MyStructWork1>,
> +///     work2: Work<MyStructWork2>,
> +/// }
> +///
> +/// impl_has_work! {
> +///     impl HasWork<MyStructWork1> for MyStruct { self.work1 }
> +///     impl HasWork<MyStructWork2> for MyStruct { self.work2 }
> +/// }
> +///
> +/// define_work_adapter_newtype! {
> +///     struct MyStructWork1(Arc<MyStruct>);
> +///     struct MyStructWork2(Arc<MyStruct>);
> +/// }
> +///
> +/// impl MyStructWork1 {
> +///     fn run(self) {
> +///         // ...
> +///     }
> +/// }
> +///
> +/// impl MyStructWork2 {
> +///     fn run(self) {
> +///         // ...
> +///     }
> +/// }
> +/// ```
> +///
> +/// This will let you push a `MyStructWork1(arc)` or `MyStructWork2(arc)` to a work queue. The [`Arc`]
> +/// can be in two work queues at the same time, and the `run` method on the wrapper type is called
> +/// when the work item is called.
> +///
> +/// [`Arc`]: crate::sync::Arc
> +#[macro_export]
> +macro_rules! define_work_adapter_newtype {
> +    (
> +        $(#[$outer:meta])*
> +        $pub:vis struct $name:ident(
> +            $(#[$innermeta:meta])*
> +            $fpub:vis Arc<$inner:ty> $(,)?
> +        );
> +        $($rest:tt)*
> +    ) => {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub $crate::sync::Arc<$inner>);
> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput = ::core::result::Result<(), $name>;
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struct) -> bool,
> +            {
> +                let ptr = $crate::sync::Arc::into_raw(self.0);
> +
> +                // SAFETY: The pointer is not dangling since we just got it from Arc::into_raw.
> +                let work_ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::raw_get_work(ptr.cast_mut()) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr = unsafe { $crate::workqueue::Work::raw_get(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {

Same as what I've said on those `WorkItem` impls.

> +                    true => Ok(()),
> +                    // SAFETY: The work queue has not taken ownership of the pointer.
> +                    false => Err($name(unsafe { $crate::sync::Arc::from_raw(ptr) })),
> +                }
> +            }
> +        }
> [...]
> +    };
> +
> +    (
> +        $(#[$outer:meta])*
> +        $pub:vis struct $name:ident(
> +            $(#[$innermeta:meta])*
> +            $fpub:vis Pin<Box<$inner:ty>> $(,)?
> +        );
> +        $($rest:tt)*
> +    ) => {
> +        $(#[$outer])*
> +        $pub struct $name($(#[$innermeta])* $fpub ::core::pin::Pin<::alloc::boxed::Box<$inner>>);
> +
> +        unsafe impl $crate::workqueue::WorkItem for $name {
> +            type EnqueueOutput = ();
> +
> +            unsafe fn __enqueue<F>(self, queue_work_on: F)
> +            where
> +                F: ::core::ops::FnOnce(*mut $crate::bindings::work_struct) -> bool,
> +            {
> +                // SAFETY: We will not used the contents in an unpinned manner.
> +                let boxed = unsafe { ::core::pin::Pin::into_inner_unchecked(self.0) };
> +                let ptr = ::alloc::boxed::Box::into_raw(boxed);
> +
> +                // SAFETY: The pointer is not dangling since we just got it from Box::into_raw.
> +                let work_ptr = unsafe { <$inner as $crate::workqueue::HasWork::<$name>>::raw_get_work(ptr) };
> +
> +                // SAFETY: The pointer is not dangling.
> +                let work_ptr = unsafe { $crate::workqueue::Work::raw_get(work_ptr) };
> +
> +                match (queue_work_on)(work_ptr) {

Same as above.

> +                    true => {},
> +                    // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
> +                    // workqueue.
> +                    false => unsafe { ::core::hint::unreachable_unchecked() },
> +                }
> +            }
> +        }
> +
> [...]
