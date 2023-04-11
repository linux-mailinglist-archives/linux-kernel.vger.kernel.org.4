Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9BC56DCFF5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:08:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDKDIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbjDKDI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:08:29 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E310F10E6;
        Mon, 10 Apr 2023 20:08:26 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54f6a796bd0so20219447b3.12;
        Mon, 10 Apr 2023 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fhqgnTCQ3K0uKW+ZKOK5N1hOM3ec71CIwP5bhwZCUTk=;
        b=bBSUw5no5LNAt7pZNqTWKD6yKYNYHZBok3BESmZt1aIwP0LDCsHOR+e5qAMLtxeaq4
         Qo3aRHZT5FIwtOJsN1LMThss3lXxBWz7MNCOZTd2KBr6+l9RloKjtLvLSLrQ+qp+etKA
         EbbE0DPRlrG/GO88dVO0YU01KiaNjCrW4B6myaokUK28r5rY/Zp9qM9TUSGLKFRYTXCa
         xbu/ep8YNdIJcaL/ByoZzvhzJ7r/E0N49wl2SlV9zxwDW9tpRAyapDpUmDN3IoJoGuFk
         LNyvv1rHo9yPZwohDHU9BeUV6otUHy+lf/J/oyhECupA4Dcmx9o0e+J9/I0gDhVtsrKG
         SRaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182506;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fhqgnTCQ3K0uKW+ZKOK5N1hOM3ec71CIwP5bhwZCUTk=;
        b=lDRfc8TxXpZ5ujWzaieL6Jr4tioqUK8YOVnh0ioAKDOZ+WhvZGPtX9K3gQZKRbXX6j
         4yY/oCk7E+TqUY6tHYIpX8OMOac4x8MCNI325Ar9Qqc7X4GGYClvWcRoXfSwezNQLDS6
         zuVKpxTEtsT/EF10jZNKFPxjdqGdOHS6XAny/CNrquwD59JWXCKQ6j4NgF3ukR8PCT2q
         gn1AB9CZ7hvOQ7f80icp+gR74kvFTpahsEnFPshgWyzEUF4FVG/yf6OdPKlQtc5KG5ig
         ztffok52GMD0ZHVK7PIQKfTdxE+23jwDyd1ZtATuSByelenx4qB+ZCngqx5UbPSjOzrt
         YtZg==
X-Gm-Message-State: AAQBX9eaIOuHjNR9FYtr9eohfgUFURTb2q8ReajGMnY2KzZasL/yz8Lb
        YSHjH/+TUcF7gG3MXraLw7fmaebkrJh5BBGQ3SE=
X-Google-Smtp-Source: AKy350aFfvuI/vAHLq/CuDYYXjKE78yn42JGVxpK2AHGKoeyp3e3AM+3o9nxPRF00mluo6A7327ykmmSvrboV7lc3XA=
X-Received: by 2002:a05:690c:a84:b0:545:f3ed:d251 with SMTP id
 ci4-20020a05690c0a8400b00545f3edd251mr8177594ywb.1.1681182505976; Mon, 10 Apr
 2023 20:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230408075340.25237-1-wedsonaf@gmail.com> <20230408075340.25237-10-wedsonaf@gmail.com>
 <08df022b-c0e9-bac6-a57f-296217dc81ed@protonmail.com>
In-Reply-To: <08df022b-c0e9-bac6-a57f-296217dc81ed@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 11 Apr 2023 00:08:15 -0300
Message-ID: <CANeycqqPf3LJYVBJFbrkPd0nyYZgwmLOKq25h3_bPt60jP3POw@mail.gmail.com>
Subject: Re: [PATCH v3 10/13] rust: introduce `current`
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Apr 2023 at 15:05, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 08.04.23 09:53, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows Rust code to get a reference to the current task without
> > having to increment the refcount, but still guaranteeing memory safety.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: Make `current` a macro to prevent it from escaping the caller
> > v2 -> v3:
> > - Mention `current` macro in `Task::current`
> > - Hide implementation of `TaskRef` inside `Task::current`
> >
> >   rust/helpers.c         |  6 +++
> >   rust/kernel/prelude.rs |  2 +
> >   rust/kernel/task.rs    | 88 +++++++++++++++++++++++++++++++++++++++++-
> >   3 files changed, 95 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 58a194042c86..96441744030e 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
> >   }
> >   EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
> >
> > +struct task_struct *rust_helper_get_current(void)
> > +{
> > +     return current;
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_get_current);
> > +
> >   void rust_helper_get_task_struct(struct task_struct *t)
> >   {
> >       get_task_struct(t);
> > diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> > index fcdc511d2ce8..c28587d68ebc 100644
> > --- a/rust/kernel/prelude.rs
> > +++ b/rust/kernel/prelude.rs
> > @@ -36,3 +36,5 @@ pub use super::error::{code::*, Error, Result};
> >   pub use super::{str::CStr, ThisModule};
> >
> >   pub use super::init::{InPlaceInit, Init, PinInit};
> > +
> > +pub use super::current;
> > diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> > index d70cad131956..5269a562cb1b 100644
> > --- a/rust/kernel/task.rs
> > +++ b/rust/kernel/task.rs
> > @@ -5,7 +5,17 @@
> >   //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
> >
> >   use crate::{bindings, types::Opaque};
> > -use core::ptr;
> > +use core::{marker::PhantomData, ops::Deref, ptr};
> > +
> > +/// Returns the currently running task.
> > +#[macro_export]
> > +macro_rules! current {
> > +    () => {
> > +        // SAFETY: Deref + addr-of below create a temporary `TaskRef` that cannot outlive the
> > +        // caller.
> > +        unsafe { &*$crate::task::Task::current() }
> > +    };
> > +}
> >
> >   /// Wraps the kernel's `struct task_struct`.
> >   ///
> > @@ -15,6 +25,42 @@ use core::ptr;
> >   ///
> >   /// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
> >   /// that the allocation remains valid at least until the matching call to `put_task_struct`.
> > +///
> > +/// # Examples
> > +///
> > +/// The following is an example of getting the PID of the current thread with zero additional cost
> > +/// when compared to the C version:
> > +///
> > +/// ```
> > +/// let pid = current!().pid();
> > +/// ```
> > +///
> > +/// Getting the PID of the current process, also zero additional cost:
> > +///
> > +/// ```
> > +/// let pid = current!().group_leader().pid();
> > +/// ```
> > +///
> > +/// Getting the current task and storing it in some struct. The reference count is automatically
> > +/// incremented when creating `State` and decremented when it is dropped:
> > +///
> > +/// ```
> > +/// use kernel::{task::Task, types::ARef};
> > +///
> > +/// struct State {
> > +///     creator: ARef<Task>,
> > +///     index: u32,
> > +/// }
> > +///
> > +/// impl State {
> > +///     fn new() -> Self {
> > +///         Self {
> > +///             creator: current!().into(),
> > +///             index: 0,
> > +///         }
> > +///     }
> > +/// }
> > +/// ```
> >   #[repr(transparent)]
> >   pub struct Task(pub(crate) Opaque<bindings::task_struct>);
> >
> > @@ -27,6 +73,46 @@ unsafe impl Sync for Task {}
> >   type Pid = bindings::pid_t;
> >
> >   impl Task {
> > +    /// Returns a task reference for the currently executing task/thread.
> > +    ///
> > +    /// The recommended way to get the current task/thread is to use the
> > +    /// [`current`](crate::current) macro because it is safe.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> > +    pub unsafe fn current() -> impl Deref<Target = Task> {
> > +        pub struct TaskRef<'a> {
> > +            task: &'a Task,
> > +            _not_send: PhantomData<*mut ()>,
> > +        }
> > +
> > +        impl Deref for TaskRef<'_> {
> > +            type Target = Task;
> > +
> > +            fn deref(&self) -> &Self::Target {
> > +                self.task
> > +            }
> > +        }
> > +
> > +        impl From<TaskRef<'_>> for crate::types::ARef<Task> {
> > +            fn from(t: TaskRef<'_>) -> Self {
> > +                t.deref().into()
> > +            }
> > +        }
>
> I think we can remove this `From` impl, since the type is never exposed
> to the outside (there still is the `From<&T> for ARef<T>` impl, so users
> can still do `current!().into()` to get an `ARef<Task>`).

Hmm, this also allows me to remove the `pub` visibility from
`TaskRef`. I will make this change for v4.

> --
> Cheers,
> Benno
>
> > +
> > +        // SAFETY: Just an FFI call with no additional safety requirements.
> > +        let ptr = unsafe { bindings::get_current() };
> > +
> > +        TaskRef {
> > +            // SAFETY: If the current thread is still running, the current task is valid. Given
> > +            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
> > +            // (where it could potentially outlive the caller).
> > +            task: unsafe { &*ptr.cast() },
> > +            _not_send: PhantomData,
> > +        }
> > +    }
> > +
> >       /// Returns the group leader of the given task.
> >       pub fn group_leader(&self) -> &Task {
> >           // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> > --
> > 2.34.1
> >
>
