Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6406A43A9
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjB0OEG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:04:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjB0OEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:04:04 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227F465AB
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:04:01 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PQMT66x6Tz9v7Yl
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 21:55:22 +0800 (CST)
Received: from [10.45.159.185] (unknown [10.45.159.185])
        by APP2 (Coremail) with SMTP id GxC2BwBnMVgouPxjkb1WAQ--.3612S2;
        Mon, 27 Feb 2023 15:03:33 +0100 (CET)
Message-ID: <dd87369d-825f-e932-dd86-8e46e92d1a7e@huaweicloud.com>
Date:   Mon, 27 Feb 2023 15:03:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu> <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
 <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
 <Y/uOA3umovz06/SV@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y/uOA3umovz06/SV@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwBnMVgouPxjkb1WAQ--.3612S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKr15AF43XFWUXry7Jr15CFg_yoWxZw47pr
        ZxKF98KF1Dtrs3Kr4vqw40qFySyF4xJFn8XFnYqryjy390qr1aqFyxKFWrCF9rGrs3t3yj
        vrW0yr9rCF98ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
        wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
        7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2023 5:51 PM, Alan Stern wrote:
> On Sun, Feb 26, 2023 at 12:17:31PM +0100, Jonas Oberhauser wrote:
>>
>> On 2/26/2023 4:30 AM, Alan Stern wrote:
>>> On Sat, Feb 25, 2023 at 07:09:05PM -0800, Boqun Feng wrote:
>>>> On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
>>>>> On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
>>>>>> A few other oddities:
>>>>>>
>>>>>> litmus/auto/C-LB-Lww+R-OC.litmus
>>>>>>
>>>>>> 	Both versions flag a data race, which I am not seeing.	It appears
>>>>>> 	to me that P1's store to u0 cannot happen unless P0's store
>>>>>> 	has completed.  So what am I missing here?
>>>>> The LKMM doesn't believe that a control or data dependency orders a
>>>>> plain write after a marked read.  Hence in this test it thinks that P1's
>>>>> store to u0 can happen before the load of x1.  I don't remember why we
>>>>> did it this way -- probably we just wanted to minimize the restrictions
>>>>> on when plain accesses can execute.  (I do remember the reason for
>>>>> making address dependencies induce order; it was so RCU would work.)
>>>>>
>>>> Because plain store can be optimzed as an "store only if not equal"?
>>>> As the following sentenses in the explanations.txt:
>>>>
>>>> 	The need to distinguish between r- and w-bounding raises yet another
>>>> 	issue.  When the source code contains a plain store, the compiler is
>>>> 	allowed to put plain loads of the same location into the object code.
>>>> 	For example, given the source code:
>>>>
>>>> 		x = 1;
>>>>
>>>> 	the compiler is theoretically allowed to generate object code that
>>>> 	looks like:
>>>>
>>>> 		if (x != 1)
>>>> 			x = 1;
>>>>
>>>> 	thereby adding a load (and possibly replacing the store entirely).
>>>> 	For this reason, whenever the LKMM requires a plain store to be
>>>> 	w-pre-bounded or w-post-bounded by a marked access, it also requires
>>>> 	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
>>>> 	where the compiler adds a load.
>>> Good guess; maybe that was the reason.  [...]
>>> So perhaps the original reason is not valid now
>>> that the memory model explicitly includes tests for stores being
>>> r-pre/post-bounded.
>>>
>>> Alan
>> I agree, I think you could relax that condition.
> Here's a related question to think about.  Suppose a compiler does make
> this change, adding a load-and-test in front of a store.  Can that load
> cause a data race?
>
> Normally I'd say no, because compilers aren't allowed to create data
> races where one didn't already exist.

I don't think that's completely true. At least N1570 says

      Transformations that introduce a speculative read of a potentially shared memory location may
      not preserve the semantics of the program as defined in this standard, since they potentially introduce a data
      race. However, they are typically valid in the context of an optimizing compiler that targets a specific
      machine with well-defined semantics for data races.

In fact I vaguely recall certain optimizations that do introduce data races, like load hoisting.
The issue is that some optimizations are only valid in the absence of data races, and therefore these optimizations and the optimizations that introduce data races can't be used on the same portion of code at the same time.

https://cs.nju.edu.cn/hongjin/teaching/concurrency/03_C11MM_ViktorVafeiadis.pdf

I think in generall it's not about whether the compiler introduces races or not, but whether those races create new behaviors that you don't see in LKMM.


>    But that restriction is part of
> the C/C++ standard, and what we consider to be a data race differs from
> what the standard considers.
>
> So what's the answer?  Is the compiler allowed to translate:
>
> 	r1 = READ_ONCE(*x);
> 	if (r1)
> 		*y = 1;
>
> into something resembling:
>
> 	r1 = READ_ONCE(*x);
> 	rtemp = *y;
> 	if (r1) {
> 		if (rtemp != 1)
> 			*y = 1;
> 	}
>
> (Note that whether the load to rtemp occurs inside the "if (r1)"
> conditional or not makes no difference; either way the CPU can execute
> it before testing the condition.  Even before reading the value of *x.)
>
> _If_ we assume that these manufactured loads can never cause a data race
> then it should be safe to remove the r-pre/post-bounded tests for plain
> writes.

Note that I don't want to remove the r-pre/post-bounded tests.
What I agreed to is that the restriction to only addr for plain writes 
is an overly conservative "r-pre/post-bounded-style" test which is made 
redundant by the existence of the actual r-pre/post-bounded test.

>
> But what if rtemp reads from a plain write that was torn, and the
> intermediate value it observes happens to be 1, even though neither the
> initial nor the final value of *y was 1?

Of course, and you don't even need a torn write to cause problems 
without requiring r-bounding.
For example, if the other side does *y=1; *y=2; mb(); *x=&y;, then 
r1==&x seems to imply that y always end up as ==1 from a 
compiler-oblivious perspective, but because of the data race it could be 
==2 instead.


>> Note there's also rw-xbstar (used with fr) which doesn't check for
>> r-pre-bounded, but it should be ok. That's because only reads would be
>> unordered, as a result the read (in the if (x != ..) x=..) should provide
>> the correct value. The store would be issued as necessary, and the issued
>> store would still be ordered correctly w.r.t the read.
> That isn't the reason I left r-pre-bounded out from rw-xbstar.  If the
> write gets changed to a read there's no need for rw-xbstar to check
> r-pre-bounded, because then rw-race would be comparing a read with
> another read (instead of with a write) and so there would be no
> possibility of a race in any case.

That is the first part of my explanation (only reads would be unordered) 
but I don't think it's sufficient in general.
Imagine a hypothetical memory model with a release fence that upgrades 
the next memory operation only (and only stores) to release (e.g., to 
save some opcode design space you do weird_release_fence;str x1 x2 
instead of stlr x1 x2).
Then in the message passing pattern

T1 {
    u = a;
    release(&x, 1);
}

T2 {
   t = READ_ONCE(&x);
   weird_release_fence;
   a = 1;
}

where T2 is changed by the compiler to

T2 {
   t = READ_ONCE(&x);
   weird_release_fence();
   if (a!=1) a = 1;
}

In the specific executions where t==1, there wouldn't be a data race 
when just considering the equivalent of rw-xbstar, but u==1 and t==1 
would be possible (even though it might not seem so from the first example).

Of course in LKMM there's no such fence, but I think to make the 
argument complete you still need to go through every case that provides 
the w-pre-bounding and make sure it still provides the necessary order 
in the compiler-generated version. (or you can try a more complicated 
argument of the form "there would be another execution of the same 
program that would have a data race", which works at least for this 
example, not sure in general)

Have fun,
jonas

