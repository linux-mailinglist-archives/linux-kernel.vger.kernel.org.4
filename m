Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFD16DFBB0
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 18:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbjDLQqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 12:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjDLQq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 12:46:26 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA628A56
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:02 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1a5266d204dso3776075ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1681317892; x=1683909892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mblYIOQp15DPpNJLZonRj1Q4Mutz9sHweMpSOIOysuo=;
        b=erPiXlRdUqCIakRu1oMia3Dog0aIQXlkglwS6vTrMxlss7fwcC+h+CTYbqa1cPR5H/
         dKdLJa+uCjEG41vNTzeplvpf8rTd8HxLjoxXX/G3XvC3g9HeHbRcUYbJvnf2h0tpBRZN
         4wrAirJiciiw/Jc6xh89K4G6K4i4bAUANPAFlj7Q4YDNWcTnZpR0t2t/U4/ZSZ/GcH1C
         pMGIuEsx+S5VTpO0f0GnX4bFUKdrDUBS7243d7a3TVGZ269Rj34Ojq1Xbfb37bBOA6th
         dUHli54N2TWld3+dGHW1ieY9Bkh4I9wkeirVd5Y23BH8rlRKJmvAp8jZajpJ1mUFgX19
         WmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681317892; x=1683909892;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mblYIOQp15DPpNJLZonRj1Q4Mutz9sHweMpSOIOysuo=;
        b=IAo04hFgwtdADxQX/l+MOcOANK5ici7iTv8Mn15VXxak+2fX2fLnjn9IK9PPpzulgd
         SCEPQiqWlr2e30w42VJdELykInH3mTRkFw/8/OeYkvj8dPuaA5Gs6bOjTI7ZIu/X9+Wz
         L/rTSqeG1Q53djOFFAYcfiPa6XL7FYUJ0uFJofyVFsWePeoa+Sx4ij9cQkdJ6pReSVq/
         osQYL3upYDHXchstsEF3fUPSepQzKxs7+InnvVYF6Bjc8126ExXUY8SUhhInnaSqyYok
         nLkHnmswOzrZMZEMSA9haxxmjmAydl0sJdVptZry7FYIzLmCMow1xPAi3XfZ+YdT6HDs
         9TRA==
X-Gm-Message-State: AAQBX9dX6LTAsE3na8IFVmA1033x3sG0+VndOZpe3r62B6brRCmFLl7u
        cnk0Ecq5FwwXFyUHtUfX2fjTriR3R4//ZKPWGhU=
X-Google-Smtp-Source: AKy350bJt65jHqdmpGK2wF697D8XC8+bpLyMk+/sJfcfIg118HnQ/s1c7ViNh3qzSLz6Ou7D2topVA==
X-Received: by 2002:a17:902:8f82:b0:19d:1e21:7f59 with SMTP id z2-20020a1709028f8200b0019d1e217f59mr19185705plo.0.1681317892609;
        Wed, 12 Apr 2023 09:44:52 -0700 (PDT)
Received: from [10.200.10.123] ([139.177.225.225])
        by smtp.gmail.com with ESMTPSA id iz14-20020a170902ef8e00b001a2104d706fsm1873858plb.225.2023.04.12.09.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 09:44:52 -0700 (PDT)
Message-ID: <76e15f10-d3f1-2cab-63cb-25aa3b4f2cd4@bytedance.com>
Date:   Thu, 13 Apr 2023 00:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: slub: annotate kmem_cache_node->list_lock as
 raw_spinlock
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        "42.hyeyoo@gmail.com" <42.hyeyoo@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "roman.gushchin@linux.dev" <roman.gushchin@linux.dev>,
        "iamjoonsoo.kim@lge.com" <iamjoonsoo.kim@lge.com>,
        "rientjes@google.com" <rientjes@google.com>,
        "penberg@kernel.org" <penberg@kernel.org>,
        "cl@linux.com" <cl@linux.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Zhao Gongyi <zhaogongyi@bytedance.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>
References: <20230411130854.46795-1-zhengqi.arch@bytedance.com>
 <c6ea3b17-a89c-6f66-5c86-967f1da601b4@suse.cz>
 <ccaf5e8e-3457-a2cf-b6eb-794cbf1b46f5@bytedance.com>
 <f54cfeb9-f1c3-e656-d344-4cbf97a7c28a@suse.cz>
 <932bf921-a076-e166-4f95-1adb24d544cf@bytedance.com>
 <ZDZG6wlWIE4dzd4W@Boquns-Mac-mini.local>
 <PH0PR11MB58805856C1C47D49D1BA8092DA9B9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <e6a21ac6-939c-c686-387b-20f81ba5be53@suse.cz>
 <20230412124735.GE628377@hirez.programming.kicks-ass.net>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20230412124735.GE628377@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/12 20:47, Peter Zijlstra wrote:
> On Wed, Apr 12, 2023 at 08:50:29AM +0200, Vlastimil Babka wrote:
> 
>>> --- a/lib/debugobjects.c
>>> +++ b/lib/debugobjects.c
>>> @@ -562,10 +562,10 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>>>          unsigned long flags;
>>>
>>>          /*
>>> -        * On RT enabled kernels the pool refill must happen in preemptible
>>> +        * The pool refill must happen in preemptible
>>>           * context:
>>>           */
>>> -       if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
>>> +       if (preemptible())
>>>                  fill_pool();
>>
>> +CC Peterz
>>
>> Aha so this is in fact another case where the code is written with
>> actual differences between PREEMPT_RT and !PREEMPT_RT in mind, but
>> CONFIG_PROVE_RAW_LOCK_NESTING always assumes PREEMPT_RT?
> 
> Ooh, tricky, yes. PROVE_RAW_LOCK_NESTING always follows the PREEMP_RT
> rules and does not expect trickery like the above.
> 
> Something like the completely untested below might be of help..
> 
> ---
> diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
> index d22430840b53..f3120d6a7d9e 100644
> --- a/include/linux/lockdep_types.h
> +++ b/include/linux/lockdep_types.h
> @@ -33,6 +33,7 @@ enum lockdep_wait_type {
>   enum lockdep_lock_type {
>   	LD_LOCK_NORMAL = 0,	/* normal, catch all */
>   	LD_LOCK_PERCPU,		/* percpu */
> +	LD_LOCK_WAIT,		/* annotation */
>   	LD_LOCK_MAX,
>   };
>   
> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
> index 50d4863974e7..a4077f5bb75b 100644
> --- a/kernel/locking/lockdep.c
> +++ b/kernel/locking/lockdep.c
> @@ -2279,8 +2279,9 @@ static inline bool usage_skip(struct lock_list *entry, void *mask)
>   	 * As a result, we will skip local_lock(), when we search for irq
>   	 * inversion bugs.
>   	 */
> -	if (entry->class->lock_type == LD_LOCK_PERCPU) {
> -		if (DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
> +	if (entry->class->lock_type != LD_LOCK_NORMAL) {
> +		if (entry->class->lock_type == LD_LOCK_PERCPU &&
> +		    DEBUG_LOCKS_WARN_ON(entry->class->wait_type_inner < LD_WAIT_CONFIG))
>   			return false;
>   
>   		return true;
> @@ -4752,7 +4753,8 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   
>   	for (; depth < curr->lockdep_depth; depth++) {
>   		struct held_lock *prev = curr->held_locks + depth;
> -		u8 prev_inner = hlock_class(prev)->wait_type_inner;
> +		struct lock_class *class = hlock_class(prev);
> +		u8 prev_inner = class->wait_type_inner;
>   
>   		if (prev_inner) {
>   			/*
> @@ -4762,6 +4764,12 @@ static int check_wait_context(struct task_struct *curr, struct held_lock *next)
>   			 * Also due to trylocks.
>   			 */
>   			curr_inner = min(curr_inner, prev_inner);
> +
> +			/*
> +			 * Allow override for annotations.
> +			 */
> +			if (unlikely(class->lock_type == LD_LOCK_WAIT))
> +				curr_inner = prev_inner;
>   		}
>   	}
>   
> diff --git a/lib/debugobjects.c b/lib/debugobjects.c
> index df86e649d8be..fae71ef72a16 100644
> --- a/lib/debugobjects.c
> +++ b/lib/debugobjects.c
> @@ -565,8 +565,16 @@ __debug_object_init(void *addr, const struct debug_obj_descr *descr, int onstack
>   	 * On RT enabled kernels the pool refill must happen in preemptible
>   	 * context:
>   	 */
> -	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible())
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) || preemptible()) {
> +		static lockdep_map dep_map = {

                 static struct lockdep_map dep_map = {

> +			.name = "wait-type-override",
> +			.wait_type_inner = LD_WAIT_SLEEP,
> +			.lock_type = LD_LOCK_WAIT,
> +		};
> +		lock_map_acquire(&dep_map);
>   		fill_pool();
> +		lock_map_release(&dep_map);
> +	}
>   
>   	db = get_bucket((unsigned long) addr);
>   

I just tested the above code, and then got the following
warning:

[    0.001000][    T0] =============================
[    0.001000][    T0] [ BUG: Invalid wait context ]
[    0.001000][    T0] 6.3.0-rc6-next-20230412+ #21 Not tainted
[    0.001000][    T0] -----------------------------
[    0.001000][    T0] swapper/0/0 is trying to lock:
[    0.001000][    T0] ffffffff825bcb80 
(wait-type-override){....}-{4:4}, at: __debug_object_init+0x0/0x590
[    0.001000][    T0] other info that might help us debug this:
[    0.001000][    T0] context-{5:5}
[    0.001000][    T0] 2 locks held by swapper/0/0:
[    0.001000][    T0]  #0: ffffffff824f5178 
(timekeeper_lock){....}-{2:2}, at: timekeeping_init+0xf1/0x270
[    0.001000][    T0]  #1: ffffffff824f5008 
(tk_core.seq.seqcount){....}-{0:0}, at: start_kernel+0x31a/0x800
[    0.001000][    T0] stack backtrace:
[    0.001000][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 
6.3.0-rc6-next-20230412+ #21
[    0.001000][    T0] Hardware name: QEMU Standard PC (i440FX + PIIX, 
1996), BIOS 1.14.0-2 04/01/2014
[    0.001000][    T0] Call Trace:
[    0.001000][    T0]  <TASK>
[    0.001000][    T0]  dump_stack_lvl+0x77/0xc0
[    0.001000][    T0]  __lock_acquire+0xa74/0x2960
[    0.001000][    T0]  ? save_trace+0x3f/0x320
[    0.001000][    T0]  ? add_lock_to_list+0x97/0x130
[    0.001000][    T0]  lock_acquire+0xe0/0x300
[    0.001000][    T0]  ? debug_object_active_state+0x180/0x180
[    0.001000][    T0]  __debug_object_init+0x47/0x590
[    0.001000][    T0]  ? debug_object_active_state+0x180/0x180
[    0.001000][    T0]  ? lock_acquire+0x100/0x300
[    0.001000][    T0]  hrtimer_init+0x23/0xc0
[    0.001000][    T0]  ntp_init+0x70/0x80
[    0.001000][    T0]  timekeeping_init+0x12c/0x270
[    0.001000][    T0]  ? start_kernel+0x31a/0x800
[    0.001000][    T0]  ? _printk+0x5c/0x80
[    0.001000][    T0]  start_kernel+0x31a/0x800
[    0.001000][    T0]  secondary_startup_64_no_verify+0xf4/0xfb
[    0.001000][    T0]  </TASK>

It seems that the LD_WAIT_SLEEP we set is already greater than the
LD_WAIT_SPIN of the current context.

-- 
Thanks,
Qi
