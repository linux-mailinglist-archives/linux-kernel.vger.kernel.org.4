Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5003F6DC0BA
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjDIQtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjDIQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:49:09 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 677F940F6;
        Sun,  9 Apr 2023 09:48:50 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id q23-20020a05683031b700b006a1370e214aso21202043ots.11;
        Sun, 09 Apr 2023 09:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058929;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CVneb6OYiMinQ5p0dlncZuPPU9lAegSvQn29UsBdjUE=;
        b=KFB9z4aioORvto9Ef3yRjDgI1Pp984ICtaaIvKt9I10XtbM5s2QcXfkrWLxkgE96gr
         U7devhuJqzVQoSZJsGDLMeIE8hOzqMg4xGava/LygHMekhCj/QZveDVbYzgbKe6zTuQs
         AU7XEH03KvVU3Wn3NFVRsMNMVv/GxIZ65a8+7zPjt+j9dPY9Nkr531pd9ybeOwcwA80v
         tg9OuUN9Pb58ydMjCB3aQrjPmn4KNK8X3qPuX8RI/Z8cm/U/Lhc9rQ3QR3u26A4flHOg
         Mhc2dTlbv0Nz95M+vtl7thp1VupxBwYn4oAxj2RHQmVuIKmDGjmZcjA2A6ix3FxhrvEJ
         gUPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058929;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CVneb6OYiMinQ5p0dlncZuPPU9lAegSvQn29UsBdjUE=;
        b=0JNVn1bbecqskNaGj+DkxAFiZ2ta2aYO+iVxLmu4yj6ylAtRO6/xGC/pkSa7VG9qSP
         DUuqT1OzUB+AUmCAJLn5ULJGXDDUhpRC/nTk1L4CSdOCa2M6aq4rvVJbXDDOssZvFlTH
         mqiHVj4VX9AjpxpnzD84KcTEUwvCykeVVVGfr7VckWxpm7Lh/BD81QHcV7Q3rYee8Lf8
         a/ot5nN01btSPVOTXfCW4Nfg06UartQTXA5b5jhH2GpOnBc2uLakgjCi2Ngp1dgpVRst
         1+r9flcjx46jpjFAmlaoWvtsfkgLrfQcs+orePePaCzwJ6ngG6HeC0FhqPJsD+CRwoit
         BZKQ==
X-Gm-Message-State: AAQBX9cQCl1XCHVoeSQ74t597Hd8w8QoEqsURepargsqMAPZFvn3I3lj
        HObcF5ynIViwjwrSMAvyOPfQNcOW+W8=
X-Google-Smtp-Source: AKy350YIXiO+LGeYWScxgLvpy/Fwg9de6hjFBbsxUjTTA+uSkJQ5M/PoD6PQRHF3WfBZmrvMgXzjDQ==
X-Received: by 2002:a05:6830:188:b0:699:5ac8:17b9 with SMTP id q8-20020a056830018800b006995ac817b9mr3367170ota.26.1681058929594;
        Sun, 09 Apr 2023 09:48:49 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id r7-20020a9d7507000000b006a30260ccfdsm3546700otk.11.2023.04.09.09.48.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:49 -0700 (PDT)
Message-ID: <f40d17ae-37c6-ac8e-59da-91ae5d1eca15@gmail.com>
Date:   Sun, 9 Apr 2023 13:48:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 09/13] rust: add basic `Task`
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
 <20230408075340.25237-9-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-9-wedsonaf@gmail.com>
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
> It is an abstraction for C's `struct task_struct`. It implements
> `AlwaysRefCounted`, so the refcount of the wrapped object is managed
> safely on the Rust side.
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: Wrap task_struct with `Opaque` instead of `UnsafeCell`
> 
>  rust/bindings/bindings_helper.h |  1 +
>  rust/helpers.c                  | 19 +++++++++
>  rust/kernel/lib.rs              |  1 +
>  rust/kernel/task.rs             | 75 +++++++++++++++++++++++++++++++++
>  4 files changed, 96 insertions(+)
>  create mode 100644 rust/kernel/task.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 75d85bd6c592..03656a44a83f 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -8,6 +8,7 @@
>  
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
> +#include <linux/sched.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index e42f5b446f92..58a194042c86 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -23,6 +23,7 @@
>  #include <linux/refcount.h>
>  #include <linux/mutex.h>
>  #include <linux/spinlock.h>
> +#include <linux/sched/signal.h>
>  
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -75,6 +76,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
>  
> +int rust_helper_signal_pending(struct task_struct *t)
> +{
> +	return signal_pending(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> +
>  refcount_t rust_helper_REFCOUNT_INIT(int n)
>  {
>  	return (refcount_t)REFCOUNT_INIT(n);
> @@ -93,6 +100,18 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>  
> +void rust_helper_get_task_struct(struct task_struct *t)
> +{
> +	get_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
> +
> +void rust_helper_put_task_struct(struct task_struct *t)
> +{
> +	put_task_struct(t);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 2d7606135ef6..ee27e10da479 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -44,6 +44,7 @@ mod static_assert;
>  pub mod std_vendor;
>  pub mod str;
>  pub mod sync;
> +pub mod task;
>  pub mod types;
>  
>  #[doc(hidden)]
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> new file mode 100644
> index 000000000000..d70cad131956
> --- /dev/null
> +++ b/rust/kernel/task.rs
> @@ -0,0 +1,75 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Tasks (threads and processes).
> +//!
> +//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
> +
> +use crate::{bindings, types::Opaque};
> +use core::ptr;
> +
> +/// Wraps the kernel's `struct task_struct`.
> +///
> +/// # Invariants
> +///
> +/// All instances are valid tasks created by the C portion of the kernel.
> +///
> +/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
> +/// that the allocation remains valid at least until the matching call to `put_task_struct`.
> +#[repr(transparent)]
> +pub struct Task(pub(crate) Opaque<bindings::task_struct>);
> +
> +// SAFETY: It's OK to access `Task` through references from other threads because we're either
> +// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
> +// synchronised by C code (e.g., `signal_pending`).
> +unsafe impl Sync for Task {}
> +
> +/// The type of process identifiers (PIDs).
> +type Pid = bindings::pid_t;
> +
> +impl Task {
> +    /// Returns the group leader of the given task.
> +    pub fn group_leader(&self) -> &Task {
> +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> +        // have a valid group_leader.
> +        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
> +
> +        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
> +        // and given that a task has a reference to its group leader, we know it must be valid for
> +        // the lifetime of the returned task reference.
> +        unsafe { &*ptr.cast() }
> +    }
> +
> +    /// Returns the PID of the given task.
> +    pub fn pid(&self) -> Pid {
> +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> +        // have a valid pid.
> +        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
> +    }
> +
> +    /// Determines whether the given task has pending signals.
> +    pub fn signal_pending(&self) -> bool {
> +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> +        unsafe { bindings::signal_pending(self.0.get()) != 0 }
> +    }
> +
> +    /// Wakes up the task.
> +    pub fn wake_up(&self) {
> +        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> +        // And `wake_up_process` is safe to be called for any valid task, even if the task is
> +        // running.
> +        unsafe { bindings::wake_up_process(self.0.get()) };
> +    }
> +}
> +
> +// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
> +unsafe impl crate::types::AlwaysRefCounted for Task {
> +    fn inc_ref(&self) {
> +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> +        unsafe { bindings::get_task_struct(self.0.get()) };
> +    }
> +
> +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> +        unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
> +    }
> +}

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
