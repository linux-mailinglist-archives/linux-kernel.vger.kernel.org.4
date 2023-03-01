Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013146A6B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 11:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbjCAKw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 05:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjCAKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 05:52:53 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456093646A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 02:52:49 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PRW716j6hz9xFrp
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 18:43:41 +0800 (CST)
Received: from [10.81.214.141] (unknown [10.81.214.141])
        by APP1 (Coremail) with SMTP id LxC2BwDXVwNbLv9j5TphAQ--.8360S2;
        Wed, 01 Mar 2023 11:52:23 +0100 (CET)
Message-ID: <90270e25-e272-d3f7-0c1b-04e74d2af6f9@huaweicloud.com>
Date:   Wed, 1 Mar 2023 11:52:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     paulmck@kernel.org
Cc:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu> <Y/0HEESX2wDWtPS1@andrea>
 <bf2881fb-039b-06ab-68f9-806b29a84188@huaweicloud.com>
 <20230227222120.GI2948950@paulmck-ThinkPad-P17-Gen-1>
 <9b5a04e9-39e7-ffa1-b43e-831a4f0c4b73@huaweicloud.com>
 <20230228154030.GT2948950@paulmck-ThinkPad-P17-Gen-1>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <20230228154030.GT2948950@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwDXVwNbLv9j5TphAQ--.8360S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4kZw4kXF4fKw48Ary7Jrb_yoWrAF18pF
        W8K3W8Kr4kJ3ZIgr1Iyw47Zw1Svw1rJrW3Xrn8Kry8A3s0qryfGr4Ikw45uFZrZrs3Gw12
        v3yjv3sxW3Z8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvKb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkvb40E47kJMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF
        0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x07boZ2-UUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,URIBL_SBL_A autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/28/2023 4:40 PM, Paul E. McKenney wrote:
> On Tue, Feb 28, 2023 at 09:49:07AM +0100, Jonas Oberhauser wrote:
>>
>> On 2/27/2023 11:21 PM, Paul E. McKenney wrote:
>>> On Mon, Feb 27, 2023 at 09:13:01PM +0100, Jonas Oberhauser wrote:
>>>> On 2/27/2023 8:40 PM, Andrea Parri wrote:
>>>>>> The LKMM doesn't believe that a control or data dependency orders a
>>>>>> plain write after a marked read.  Hence in this test it thinks that P1's
>>>>>> store to u0 can happen before the load of x1.  I don't remember why we
>>>>>> did it this way -- probably we just wanted to minimize the restrictions
>>>>>> on when plain accesses can execute.  (I do remember the reason for
>>>>>> making address dependencies induce order; it was so RCU would work.)
>>>>>>
>>>>>> The patch below will change what the LKMM believes.  It eliminates the
>>>>>> positive outcome of the litmus test and the data race.  Should it be
>>>>>> adopted into the memory model?
>>>>> (Unpopular opinion I know,) it should drop dependencies ordering, not
>>>>> add/promote it.
>>>>>
>>>>>      Andrea
>>>> Maybe not as unpopular as you think... :)
>>>> But either way IMHO it should be consistent; either take all the
>>>> dependencies that are true and add them, or drop them all.
>>>> In the latter case, RCU should change to an acquire barrier. (also, one
>>>> would have to deal with OOTA in some yet different way).
>>>>
>>>> Generally my position is that unless there's a real-world benchmark with
>>>> proven performance benefits of relying on dependency ordering, one should
>>>> use an acquire barrier. I haven't yet met such a case, but maybe one of you
>>>> has...
>>> https://www.msully.net/thesis/thesis.pdf page 128 (PDF page 141).
>>>
>>> Though this is admittedly for ARMv7 and PowerPC.
>>>
>> Thanks for the link.
>>
>> It's true that on architectures that don't have an acquire load (and have to
>> use a fence), the penalty will be bigger.
>>
>> But the more obvious discussion would be what constitutes a real-world
>> benchmark : )
>> In my experience you can get a lot of performance benefits out of optimizing
>> barriers in code if all you execute is that code.
>> But once you embed that into a real-world application, often 90%-99% of time
>> spent will be in the business logic, not in the data structure.
>>
>> And then the benefits suddenly disappear.
>> Note that a lot of barriers are a lot cheaper as well when there's no
>> contention.
>>
>> Because of that, making optimization decisions based on microbenchmarks can
>> sometimes lead to a very poor "time invested" vs "total product improvement"
>> ratio.
> All true, though that 2x and 4x should be worth something.

I think the most egregious case we had (not barrier related, but cache 
related) was something like ~100x in specific benchmarks and then I 
think somewhere around 1% system-wide. I think the issue was that in the 
larger system, we couldn't keep the cache hot, so our greatly improved 
data locality was being diluted.
But of course it always depends on how much that component actually 
contributes to the overall system performance.
Which IMHO should be one of the measurements taken before starting to 
invest heavily into optimizations.

Surprisingly, many people don't want to do that. I think it's something 
about the misleading calculus of "2 months implementing the optimization 
+ 2 weeks building robust benchmarks & profiling infrastructure > 2 
months implementing the optimization" instead of "2 weeks building 
robust benchmarks & profiling infrastructure + 0 months implementing a 
useless optimization < 2 months implementing the optimization", which 
seems to be the more common case.


> The real-world examples I know of involved garbage collectors, and the
> improvement was said to be a few percent system-wide.  But that was a
> verbal exchange, so I don't have a citation for you.

Thanks for the example, it sounds very reasonable (at least for 
platforms like PowerPC).
GC has all the hallmarks of a good optimization target: measurable 
impact on system wide throughput and latency, and pointer chasing 
(=dependency ordering) being a hot part inside the algorithm.

Best wishes,
jonas

