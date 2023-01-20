Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 537FA675339
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 12:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjATLOF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 06:14:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjATLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 06:14:03 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68344F36C
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 03:13:36 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NyxVk0bH2z9v7Zh
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 19:05:34 +0800 (CST)
Received: from [10.48.133.21] (unknown [10.48.133.21])
        by APP1 (Coremail) with SMTP id LxC2BwD3fQk1d8pjwwSxAA--.5799S2;
        Fri, 20 Jan 2023 12:13:05 +0100 (CET)
Message-ID: <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
Date:   Fri, 20 Jan 2023 12:12:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fQk1d8pjwwSxAA--.5799S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Ar1fWr4DKF43Jr43WF4Uurg_yoW7Kr47pF
        WrKan7Kw4qyr1v9wnFyws5Xr1Iyw4rJryrJrn8Gr1rA398W3sF9r1rtr45uF9rCrs2yayY
        vrWrZasxZrn8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
        uYvjxUFDGOUUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 9:06 PM, Alan Stern wrote:
> On Thu, Jan 19, 2023 at 04:05:38PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/19/2023 4:13 AM, Alan Stern wrote:
>>> On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
>>>> On 1/18/2023 8:52 PM, Alan Stern wrote:
>>>>> On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
>>>>>> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>>>>>> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>>>>>> -		fencerel(After-unlock-lock) ; [M])
>>>>>> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
>>>>> Shouldn't the po case of (co | po) remain intact here?
>>>> You can leave it here, but it is already covered by two other parts: the
>>>> ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
>>>> ppo, and the ordering given through pb is covered by its inclusion in
>>>> strong-order.
>>> What about the ordering given through
>>> A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be
>>> superseded by pb as well,
>> Indeed, in fact all of A-cumul(strong-fence) is already covered through pb.
>>> but it seems odd not to have it in hb.
>>> In general, the idea in the memory model is that hb ordering relies on
>>> the non-strong properties of fences, whereas pb relies on the properties
>>> of strong fences, and rb relies on the properties of the RCU fences.
>> I agree in the sense that all strong-ordering operations are A-cumulative
>> and not including them in A-cumul is weird.
>
>> On the other side  the model becomes a tiny bit smaller and simpler when all
>> ordering of prop;strong-ordering goes through a single place (pb).
>>
>> If you want, you could think of the A-cumulativity of strong ordering
>> operations as being a consequence of their strong properties. Mathematically
> That's backward logic.  Being strong isn't the reason the fences are
> A-cumulative.  Indeed, the model could have been written not to assume
> that strong fences are A-cumulative.

It's not just the model, it's also how strong fences are introduced in 
the documentation.
I agree though that you could decouple the notion of strong from 
A-cumulativity.
But would anyone want a strong fence that is not A-cumulative?
It's a bit like asking in C11 for a barrier that has the sequential 
consistency guarantee of appearing in the global order S, but doesn't 
have release or acquire semantics. Yes you could define that, but would 
it really make sense?


>>>>>> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>>>>>>     (* Write and fence propagation ordering *)
>>>>>>     (****************************************)
>>>>>> -(* Propagation: Each non-rf link needs a strong fence. *)
>>>>>> -let pb = prop ; strong-fence ; hb* ; [Marked]
>>>>>> +(* Strong ordering operations *)
>>>>>> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
>>>>>> +		[After-unlock-lock] ; po ; [M])
>>>>> This is not the same as the definition removed above.  In particular,
>>>>> po-unlock-lock-po only allows one step along the locking chain -- it has
>>>>> rf where the definition above has co.
>>>> Indeed it is not, but the subsequent lock-unlock sequences are in hb*. For
>>>> this reason it can be simplified to just consider the directly following
>>>> unlock().
>>> I'm not sure that argument is right.  The smp_mb__after_unlock_lock
>>> needs to go after the _last_ lock in the sequence, not after the first.
>>> So you don't have to worry about subsequent lock-unlock sequences; you
>>> have to worry about preceding lock-unlock sequences.
>> I formalized a proof of equivalence in Coq a few months ago, but I was
>> recalling the argument incorrectly from memory.
>> I think the correct argument is that the previous po-unlock-lock-po form a
>> cumul-fence*;rfe;po sequence that starts with a po-rel.
>> so any
>>      prop; .... ; co ; ... ; this fence ;...
>> can be rewritten to
>>      prop; cumul_fence* ; po-unlock-lock-po ; this fence ;...
>> and because the the first cumul-fence here needs to start with po-release,
>> the prop ;cumul-fence* can be merged into a larger prop, leaving
>>      prop; po-unlock-lock-po ; this fence ;...
> This may be so, but I would like to point out that the memory model was
> not particularly designed to be as short or as simple as possible, but
> more to reflect transparently the intuitions that kernel programmers
> have about the ways ordering should work in the kernel.  It may very
> well include redundancies as a result.  I don't think that's a bad
> point.

I agree that sometimes redundancies have value. But I think having, 
where possible, a kind of minimal responsibility principle where each 
fence appears in as few relations as possible also has value.
I've seen that when I try to help people in my team learn to use LKMM: 
they see a specific type of fence and get stuck for a while chasing one 
of its uses. For example, they may chase a long prop link using the only 
strong fence in the example somewhere in the middle, which will then 
later turn out to be a dead-end because what they need to use is pb.

For someone who doesn't know that we never need to rely on that use to 
get ordering, it basically doubles the amount of time spent looking at 
the graph and chasing definitions. And for very good reasons there 
already are alot of definitions even when redundancies are eliminated.

Perhaps I would say that including these redundancies is good for 
understanding why the formalization makes sense, but excluding them is 
better for actually using the formalization.
This includes both when looking at code while having a printout of the 
model next to you, but also when trying to reason about LKMM itself 
(e.g., what one might do when changes are made to LKMM and one wants to 
check that they interact well with the existing parts of LKMM).

I think in the long term, increasing the usability is more important 
than the obvious correctness. But maybe I'm biased because I'm mostly on 
the user side of LKMM :D

