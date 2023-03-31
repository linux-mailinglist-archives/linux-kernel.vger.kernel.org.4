Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 025C66D18A1
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 09:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCaHcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 03:32:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCaHcj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 03:32:39 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C941733;
        Fri, 31 Mar 2023 00:32:37 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 836655C01A0;
        Fri, 31 Mar 2023 03:32:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 31 Mar 2023 03:32:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1680247956; x=1680334356; bh=Q/B4T30X2b42IMrzFs3a89ZTi4QhgYECDXb
        6nVPSW5A=; b=NpHCzPVvzQkWspa1jPiArUmeZnAMnV/8Oz2XjI3WUwjT1iYdzyB
        V5gcj750cF49YujRsHDchMi/LDmj2hcWfThm+DH/Ow0Psh7d746j1iZDk7rocxIR
        3SX7shBBZs2jHmZcFIsECJLo7GWkgs+DaQG3E01wYXo3kva6vc+0n1W7pkD0Mhdt
        umwj0aVqLA3CXqa/Uy+fuMal+85vMs/R9tuUd60uex6syyf2j5oE8NQF5ir/Qcna
        /1yS+jzefpbl+EJL0RNa06gVj0do6nBYaZiq42jKvan6IGjdKAb9PmHCKl69wcTo
        CiSc1v6qegflCFp/5QF7A//G7hjMl3b+caQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680247956; x=1680334356; bh=Q/B4T30X2b42IMrzFs3a89ZTi4QhgYECDXb
        6nVPSW5A=; b=nSO1DzntpFog/z6bDkbpzfkwPhpqy8Ds8OiZ9kCGpUAzUbcmaJ9
        mQH2ryUbZp58matfZSM1yWXs4/vzV6px+m4F+KsyxRK6hHjXyKhQwnPuYmfTeN1p
        o4tm7UEg4ZsqKrPLtof++yaNloH30D004+nPN/w5hrcktznkV4SVc2LJ+ETMRi0Y
        CCLp1zMh2pkO48azGLSDJHJ9HytegHhChxbemYPC/nVQoqMKQL1U2mQtUeF7ZL/M
        fHzxD7cAJuYBm70xweQV5MntQY6AwCglo+3sFTr2ADX54Db5XmJXEEgeEqghSdUK
        KpqsWkNbKgVSaN2Z9/DDc13q9CBsVRUjFqA==
X-ME-Sender: <xms:lIwmZMIciDCA0VenndYavsqi4wkjPxeHIdUlK5uReEw-lrbivYaZAQ>
    <xme:lIwmZMKmmPogCzJCjedqIU48CLFZjcRBfCqoORcEnAPkhywCUFiISbqaCPGTdpXeI
    mAPGgKWhcdV6OGQtA>
X-ME-Received: <xmr:lIwmZMukCccwyqFodfwEDVlVrLB37SwHorW551lH3xHcGUpYwNKsDNZ8hIBwfPY0UVNe8K-r68yD5Zcyfi49jrAjxQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeitddguddvtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomheptehl
    ihgtvgcutfihhhhluceorghlihgtvgesrhihhhhlrdhioheqnecuggftrfgrthhtvghrnh
    epheduuddvteekvdektdduledugfffhfdugeejgeeuvdevtdetveejheehiefffeegnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprghlihgtvg
    esrhihhhhlrdhioh
X-ME-Proxy: <xmx:lIwmZJb4MKMauQkpP1-skLWPkl2SETIBoM1p31mJjbH6flgJ_5hyqw>
    <xmx:lIwmZDZgvPUS5sf-4YOQFGRMiGH61uWfhXSpYm831eJNkCWvbJOnYg>
    <xmx:lIwmZFAXVOazdH7PvXpN16GXKZK1WlbcdtYJEeVEVH_sv1frBbGC7A>
    <xmx:lIwmZNlqbdJQoB4evwBoYQatjdwkV4fbovTPhWjwZKpx2HyMBIjJbA>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 31 Mar 2023 03:32:34 -0400 (EDT)
Message-ID: <283f3831-a51c-1798-6871-cd19584bc03e@ryhl.io>
Date:   Fri, 31 Mar 2023 09:32:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 10/13] rust: introduce `Task::current`
Content-Language: en-US
To:     Gary Guo <gary@garyguo.net>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-10-wedsonaf@gmail.com>
 <20230331034701.0657d5f2.gary@garyguo.net>
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230331034701.0657d5f2.gary@garyguo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/31/23 04:47, Gary Guo wrote:
> On Thu, 30 Mar 2023 01:39:51 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
> 
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>
>> This allows Rust code to get a reference to the current task without
>> having to increment the refcount, but still guaranteeing memory safety.
>>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>> ---
>>   rust/helpers.c      |  6 ++++
>>   rust/kernel/task.rs | 83 ++++++++++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 88 insertions(+), 1 deletion(-)
>>
>> diff --git a/rust/helpers.c b/rust/helpers.c
>> index 58a194042c86..96441744030e 100644
>> --- a/rust/helpers.c
>> +++ b/rust/helpers.c
>> @@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r)
>>   }
>>   EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>>   
>> +struct task_struct *rust_helper_get_current(void)
>> +{
>> +	return current;
>> +}
>> +EXPORT_SYMBOL_GPL(rust_helper_get_current);
>> +
>>   void rust_helper_get_task_struct(struct task_struct *t)
>>   {
>>   	get_task_struct(t);
>> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
>> index 8d7a8222990f..8b2b56ba9c6d 100644
>> --- a/rust/kernel/task.rs
>> +++ b/rust/kernel/task.rs
>> @@ -5,7 +5,7 @@
>>   //! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
>>   
>>   use crate::bindings;
>> -use core::{cell::UnsafeCell, ptr};
>> +use core::{cell::UnsafeCell, marker::PhantomData, ops::Deref, ptr};
>>   
>>   /// Wraps the kernel's `struct task_struct`.
>>   ///
>> @@ -13,6 +13,46 @@ use core::{cell::UnsafeCell, ptr};
>>   ///
>>   /// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
>>   /// that the allocation remains valid at least until the matching call to `put_task_struct`.
>> +///
>> +/// # Examples
>> +///
>> +/// The following is an example of getting the PID of the current thread with zero additional cost
>> +/// when compared to the C version:
>> +///
>> +/// ```
>> +/// use kernel::task::Task;
>> +///
>> +/// let pid = Task::current().pid();
>> +/// ```
>> +///
>> +/// Getting the PID of the current process, also zero additional cost:
>> +///
>> +/// ```
>> +/// use kernel::task::Task;
>> +///
>> +/// let pid = Task::current().group_leader().pid();
>> +/// ```
>> +///
>> +/// Getting the current task and storing it in some struct. The reference count is automatically
>> +/// incremented when creating `State` and decremented when it is dropped:
>> +///
>> +/// ```
>> +/// use kernel::{task::Task, ARef};
>> +///
>> +/// struct State {
>> +///     creator: ARef<Task>,
>> +///     index: u32,
>> +/// }
>> +///
>> +/// impl State {
>> +///     fn new() -> Self {
>> +///         Self {
>> +///             creator: Task::current().into(),
>> +///             index: 0,
>> +///         }
>> +///     }
>> +/// }
>> +/// ```
>>   #[repr(transparent)]
>>   pub struct Task(pub(crate) UnsafeCell<bindings::task_struct>);
>>   
>> @@ -25,6 +65,20 @@ unsafe impl Sync for Task {}
>>   type Pid = bindings::pid_t;
>>   
>>   impl Task {
>> +    /// Returns a task reference for the currently executing task/thread.
>> +    pub fn current<'a>() -> TaskRef<'a> {
>> +        // SAFETY: Just an FFI call with no additional safety requirements.
>> +        let ptr = unsafe { bindings::get_current() };
>> +
>> +        TaskRef {
>> +            // SAFETY: If the current thread is still running, the current task is valid. Given
>> +            // that `TaskRef` is not `Send`, we know it cannot be transferred to another thread
>> +            // (where it could potentially outlive the caller).
>> +            task: unsafe { &*ptr.cast() },
>> +            _not_send: PhantomData,
>> +        }
>> +    }
>> +
> 
> I don't think this API is sound, as you can do `&*Task::current()` and
> get a `&'static Task`, which is very problematic.
> 
> A sound API would be
> 
> 	pub fn with_current<R>(f: imp FnOnce(&Task) -> R) -> R { ... }
> 
> (which also is how thread local works in Rust)
> 
> You would have to write `Task::with_current(|cur| cur.pid())` though,
> which unfortunately is a bit less ergonomic.
> 
> Best,
> Gary

This is true, unfortunately. It would be possible to write a macro with 
a more similar API to the current implementation.
