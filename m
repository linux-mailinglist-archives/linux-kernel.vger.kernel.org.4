Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061066DC0B9
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229675AbjDIQtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjDIQtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:10 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032D49CF;
        Sun,  9 Apr 2023 09:48:59 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id c17-20020a4aa4d1000000b005418821052aso1410982oom.6;
        Sun, 09 Apr 2023 09:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058938;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ShVq2ADCVfvgmdX2n9FqpBRVYZ0AkpDjoaZsweYGyEM=;
        b=V81w79oxd3ulj+0F+26TD9hgwJl2xMWEYyYshXlgHMurE9DPBRgJGjmgdDSgi24I8Q
         CYYmbSaCYaojRpevx13uDvWr2pf9VBmtUVfea2aB98Us9OR6aknT20Htlyj7Np5BLpUl
         3HYdmoHzGcOg0FHCFbEX0fzGwwF1xX6S0w/qRmNnEVhM3wqThlwq//LaTdiFKgk6B3Kd
         aPjTKr5PR/hjvOqfMazrrc5UH2ir+JsLiOgpwqG7lrRECbtCjcueVw2oN22yraY+6b2u
         JQrkpf/f7QS0PFeP4SRt3A6LshHVee1Bt1o05gDWtw8lT7xePRHuefKUlbYx+DumRzfb
         P3pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058938;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ShVq2ADCVfvgmdX2n9FqpBRVYZ0AkpDjoaZsweYGyEM=;
        b=EEA/csuFTb3wFOx8ucbn0OrGJUWE8mXA0w766bRzRs9kPES6L9aNIwMM3UGTyKbrJE
         iyv5BExKQVsBr4gK2wqcc1Y6rpb5R58G5p4tuYZRU23MUe2EzMzM++hGkeDSgwp924c5
         niHNOmZKxmCCcjyh6dixIr4Wwmx9zzjy0vJBoalhba8qmBwcmY1VHjjTg1SgaLFPtXJm
         bjxrd3daKLpdejbWuAvy6eZ+dEB6+NqU3rbGsgtClNIIGl26XO5HRjjdQQRw78PYY3xp
         iE20/dtLmHXYeK39N0MnHSVruxQT/wPEF3jSbiIhE/hHAy5LEiDbEMFUAEa1w9/KgPxJ
         BC5g==
X-Gm-Message-State: AAQBX9eCnMJZuEbR97N4DAksoaC0k3+Z4ITcFtkDOPVcAtPHaOFzJL/I
        j7v0YHJTvUrinhEaqePeHEM=
X-Google-Smtp-Source: AKy350btk/hCnNhN1EHuQ1bNiRpWw/zHbruw1IkdBHuupiL/eyaTg9HHk99yUnBn0NNFKG9VSaxLjA==
X-Received: by 2002:a4a:88cf:0:b0:541:b668:31c5 with SMTP id q15-20020a4a88cf000000b00541b66831c5mr1976534ooh.8.1681058938269;
        Sun, 09 Apr 2023 09:48:58 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id t8-20020a4aadc8000000b00541854d066bsm3709260oon.10.2023.04.09.09.48.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:57 -0700 (PDT)
Message-ID: <8d76bb7f-73d8-cfe9-462c-d02d97f436b0@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:54 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 10/13] rust: introduce `current`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-10-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-10-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 04:53, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This allows Rust code to get a reference to the current task without
> having to increment the refcount, but still guaranteeing memory safety.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Make `current` a macro to prevent it from escaping the caller
> v2 -> v3:
> - Mention `current` macro in `Task::current`
> - Hide implementation of `TaskRef` inside `Task::current`
> 
>  rust/helpers.c         |  6 +++
>  rust/kernel/prelude.rs |  2 +
>  rust/kernel/task.rs    | 88 +++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 95 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 58a194042c86..96441744030e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +struct task_struct *rust_helper_get_current(void)
> +{
> +	return current;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_current);
> +
>  void rust_helper_get_task_struct(struct task_struct *t)
>  {
>  	get_task_struct(t);
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index fcdc511d2ce8..c28587d68ebc 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -36,3 +36,5 @@ pub use super::error::{code::*, Error, Result};
>  pub use super::{str::CStr, ThisModule};
>  
>  pub use super::init::{InPlaceInit, Init, PinInit};
> +
> +pub use super::current;
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index d70cad131956..5269a562cb1b 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -5,7 +5,17 @@
>  //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
>  
>  use crate::{bindings, types::Opaque};
> -use core::ptr;
> +use core::{marker::PhantomData, ops::Deref, ptr};
> +
> +/// Returns the currently running task.
> +#[macro_export]
> +macro_rules! current {
> +    () => {
> +        // SAFETY: Deref + addr-of below create a temporary `TaskRef` that cannot outlive the
> +        // caller.
> +        unsafe { &*$crate::task::Task::current() }
> +    };
> +}
>  
>  /// Wraps the kernel's `struct task_struct`.
>  ///
> @@ -15,6 +25,42 @@ use core::ptr;
>  ///
>  /// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
>  /// that the allocation remains valid at least until the matching call to `put_task_struct`.
> +///
> +/// # Examples
> +///
> +/// The following is an example of getting the PID of the current thread with zero additional cost
> +/// when compared to the C version:
> +///
> +/// ```
> +/// let pid = current!().pid();
> +/// ```
> +///
> +/// Getting the PID of the current process, also zero additional cost:
> +///
> +/// ```
> +/// let pid = current!().group_leader().pid();
> +/// ```
> +///
> +/// Getting the current task and storing it in some struct. The reference count is automatically
> +/// incremented when creating `State` and decremented when it is dropped:
> +///
> +/// ```
> +/// use kernel::{task::Task, types::ARef};
> +///
> +/// struct State {
> +///     creator: ARef<Task>,
> +///     index: u32,
> +/// }
> +///
> +/// impl State {
> +///     fn new() -> Self {
> +///         Self {
> +///             creator: current!().into(),
> +///             index: 0,
> +///         }
> +///     }
> +/// }
> +/// ```
>  #[repr(transparent)]
>  pub struct Task(pub(crate) Opaque<bindings::task_struct>);
>  
> @@ -27,6 +73,46 @@ unsafe impl Sync for Task {}
>  type Pid = bindings::pid_t;
>  
>  impl Task {
> +    /// Returns a task reference for the currently executing task/thread.
> +    ///
> +    /// The recommended way to get the current task/thread is to use the
> +    /// [`current`](crate::current) macro because it is safe.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the returned object doesn't outlive the current task/thread.
> +    pub unsafe fn current() -> impl Deref<Target = Task> {
> +        pub struct TaskRef<'a> {
> +            task: &'a Task,
> +            _not_send: PhantomData<*mut ()>,
> +        }

I'd had named this as `CurrentTaskRef`, but since this is not exposed to
users then there are no problems whatsoever.

> +
> +        impl Deref for TaskRef<'_> {
> +            type Target = Task;
> +
> +            fn deref(&self) -> &Self::Target {
> +                self.task
> +            }
> +        }
> +
> +        impl From<TaskRef<'_>> for crate::types::ARef<Task> {
> +            fn from(t: TaskRef<'_>) -> Self {
> +                t.deref().into()
> +            }
> +        }
> +
> +        // SAFETY: Just an FFI call with no additional safety requirements.
> +        let ptr = unsafe { bindings::get_current() };
> +
> +        TaskRef {
> +            // SAFETY: If the current thread is still running, the current task is valid. Given
> +            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
> +            // (where it could potentially outlive the caller).
> +            task: unsafe { &*ptr.cast() },
> +            _not_send: PhantomData,
> +        }
> +    }
> +
>      /// Returns the group leader of the given task.
>      pub fn group_leader(&self) -> &Task {
>          // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
