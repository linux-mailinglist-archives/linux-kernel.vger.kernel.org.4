Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C126DB8A8
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 05:54:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbjDHDyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 23:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjDHDyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 23:54:13 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF84D324;
        Fri,  7 Apr 2023 20:54:11 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54c061acbc9so147921377b3.11;
        Fri, 07 Apr 2023 20:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680926051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7gEJXihiIgEi5hOdoVM5mvz8W2727HP3ueRmkcGO4TM=;
        b=CEegcGznRYGa8mfqJijTCurYdAk0bT4dcYShcQvoIPOJTjRifG1dsRCRVFzWScFgp4
         IEgKjaODaYDKSNf3qBjFnsO0X71T6pQcC3trl4XT+jICI1p+uylqCoiy2GuvKOXugqHK
         J8ebw/JeLEAvAD/pHnm2KPmUDAzpEtYvi+Y+UpV0xdD6Jtms3CsV+zFdusPdAljLh3gy
         FRR0Li/xrmBcY4Ox3S+SmDaobWPVZPvzDIySGNzJSSN1BDS94f7Gaj1hS4StkslyiwUd
         iBZ2EyXQQ+61m5lwBlZJ2mtX1l6EexGjfybfxoR1cUMSx5qJ5IEo3YGH1KYRvIc2ovAO
         Hf4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680926051;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7gEJXihiIgEi5hOdoVM5mvz8W2727HP3ueRmkcGO4TM=;
        b=hkTQGVq4jfWo+9Wq9QCNIqG4RGLXwbQtcAUvKYUvD/kSdQyaI2DLNlhlfvuTA5R75s
         p5TsSkZgM81eZoo+wvTVREmCs3djyIXIesvIzXhgB8MnldcLs9k0tvqe1gz/mnJuYf5c
         0ezlVu8RuYlifkHHrOomai6QGyJgbnMYNJmYelj+7XZjlHH4ei1ckaCjFRb/61H5i/at
         D6N2uUV6KZmZiLgNA8LeYWuaBVpDHoadu0rlVEnv7PUKFS/cKohUsIX5TOR4U+YtomHQ
         Wq0+eE5hvwdUWOx+VGY8H/2q4RJZN2gbss3qBqiAFyMAcyOXnXWITysN6cLYfQz15Mgl
         8bgQ==
X-Gm-Message-State: AAQBX9fsJARNCH4H7KBhkM7mYuowktkjAmeiXPQYelSptNueS4ZOxZPk
        Pf7AQQokMtFVU7QbvNwO+xH2V6rOkShOWiNko44=
X-Google-Smtp-Source: AKy350Y9WHQnAK1FOA4Q47KM6btVQYrqbexO7gGO9FhWf4gVvQRygK6C2XCpiRlWkGJ/USwJR5NOTocuyFGrxj9orC4=
X-Received: by 2002:a81:ef0c:0:b0:549:2cc8:6e3e with SMTP id
 o12-20020a81ef0c000000b005492cc86e3emr2197885ywm.9.1680926050673; Fri, 07 Apr
 2023 20:54:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-10-wedsonaf@gmail.com>
 <d5e55c0f-ed6e-19ee-4bb7-58c8fdad8e29@protonmail.com>
In-Reply-To: <d5e55c0f-ed6e-19ee-4bb7-58c8fdad8e29@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 8 Apr 2023 00:54:03 -0300
Message-ID: <CANeycqrpUEtQJG1zDfNv+3Ot+k3sLskH1v51ndiWKM6dikrxNw@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] rust: introduce `current`
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

On Fri, 7 Apr 2023 at 19:36, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 05.04.23 19:51, Wedson Almeida Filho wrote:
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
> >
> >   rust/helpers.c         |  6 +++
> >   rust/kernel/prelude.rs |  2 +
> >   rust/kernel/task.rs    | 93 +++++++++++++++++++++++++++++++++++++++++-
> >   3 files changed, 100 insertions(+), 1 deletion(-)
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
> > index 8d7a8222990f..468387a5f7eb 100644
> > --- a/rust/kernel/task.rs
> > +++ b/rust/kernel/task.rs
> > @@ -5,7 +5,17 @@
> >   //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
> >
> >   use crate::bindings;
> > -use core::{cell::UnsafeCell, ptr};
> > +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, ptr};
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
> > @@ -13,6 +23,42 @@ use core::{cell::UnsafeCell, ptr};
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
> >   pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
> >
> > @@ -25,6 +71,24 @@ unsafe impl Sync for Task {}
> >   type Pid = bindings::pid_t;
> >
> >   impl Task {
> > +    /// Returns a task reference for the currently executing task/thread.
> > +    ///
>
> Add a link to the `current!` macro as a safe version of this function.

Good idea, I'll add it in v3.

> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that the returned [`TaskRef`] doesn't outlive the current task/thread.
> > +    pub unsafe fn current<'a>() -> TaskRef<'a> {
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
> >           // SAFETY: By the type invariant, we know that `self.0` is valid.
> > @@ -69,3 +133,30 @@ unsafe impl crate::types::AlwaysRefCounted for Task {
> >           unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
> >       }
> >   }
> > +
> > +/// A wrapper for a shared reference to [`Task`] that isn't [`Send`].
> > +///
> > +/// We make this explicitly not [`Send`] so that we can use it to represent the current thread
> > +/// without having to increment/decrement the task's reference count.
> > +///
> > +/// # Invariants
> > +///
> > +/// The wrapped [`Task`] remains valid for the lifetime of the object.
> > +pub struct TaskRef<'a> {
> > +    task: &'a Task,
> > +    _not_send: PhantomData<*mut ()>,
> > +}
> > +
> > +impl Deref for TaskRef<'_> {
> > +    type Target = Task;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        self.task
> > +    }
> > +}
> > +
> > +impl From<TaskRef<'_>> for crate::types::ARef<Task> {
> > +    fn from(t: TaskRef<'_>) -> Self {
> > +        t.deref().into()
> > +    }
> > +}
>
> Maybe we can hide this struct and return an `impl Deref<Target = Task>`
> in `Task::current` instead (it will still be `!Send`)? Users do not
> really need to see this implementation detail.

Hmm, I was a bit concerned with the impl of `From<TaskRef>` for
`ARef<Task>`, but it seems to work. I moved the whole type into
`Task::current` for v3.

Thanks for review!

Cheers,
-Wedson
