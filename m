Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 545A867866D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 20:34:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbjAWTe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 14:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjAWTe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 14:34:26 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A526430E90
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 11:34:24 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P10TD4f2Lz9xHfJ
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 03:26:24 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP1 (Coremail) with SMTP id LxC2BwBHywYa4c5jC4C_AA--.11884S2;
        Mon, 23 Jan 2023 20:33:59 +0100 (CET)
Message-ID: <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
Date:   Mon, 23 Jan 2023 20:33:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Jonas Oberhauser <jonas.oberhauser@huawei.com>, paulmck@kernel.org,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
References: <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHywYa4c5jC4C_AA--.11884S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Gw1DZF48Jr4kXF1xJF4Utwb_yoW3Zw45pF
        WrKa1kKF1kJr4IkrnFyw1rXFWSkr48AF4rJFn5Z3Wvk398GrZ2yr18trWYvFyrCrs2ya1j
        vFWjvasrXF98AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 6:28 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 02:59:37PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/21/2023 9:56 PM, Alan Stern wrote:
>>> There is yet another level of fences in the hierarchy: those which order
>>> instruction execution but not propagation (smp_rmb() and acquire).  One
>>> of the important points about cumul-fence is that it excludes this
>>> level.
>>>
>>> That's for a functional reason -- prop simply doesn't work for those
>>> fences, so it has to exclude them.  But it does work for strong fences,
>>> so excluding them would be an artificial restriction.
>> Hm, so could we say some fences order
>> 1) propagation with propagation (weak fences)
>> 2) execution with execution (rmb, acquire)
>> 3) propagation with execution (strong fences)
>>
>> where ordering with execution implicitly orders with propagation as well
>> because things can only propagate after they execute.
>> However, the 4th possibility (execution with only propagation) happens not
>> to exist. I'm not sure if it would even be distinguishable from the second
>> type.
> Only in that such a memory barrier would order po-earlier anything
> against po-later stores, whereas rmb orders loads against loads and
> acquire orders loads against anything.
>
>>   In the operational model, can you forward from stores that have not
>> executed yet?
> Yes, it is explicitly allowed.  But forwarding doesn't apply in this
> situation because stores can be forwarded only to po-later loads, not to
> po-earlier ones.

The reason I was asking is because if forwarding was forbidden from 
non-executed stores, execute-to-prop frences could potentially have 
observably different behavior from comparable execute-to-execute cases. 
It's moot because it's not forbidden, but if you want to see the 
reasoning, consider a case like this:

   load from y ; execute-to-prop-fence ; store to x ; ... ; load from x
   load from y ; execute-to-execute-fence ; store to x ; ... ; load from x

(where both fences only order load->store).
In the first case, x could execute before the load from y and the load 
from x could already execute.
In the second case, x couldn't execute before the load from y and so 
(assuming you couldn't forward from non-executed stores) x couldn't execute.
As a result, the second type of fence would have ordered the loads but 
the first one wouldn't.

>>> Not quite right.  A hypothetical non-A-cumulative case for pb would have
>>> to omit the cumul-fence term entirely.
>> Wouldn't that violate the transitivity of "X is required to propagate before
>> Y" ?
>> If I have
>>     X ->cumul-fence+ Y ->weird-strong-fence Z
>> doesn't that mean that for every CPU C,
>> 1. X is required to propagate to C before Y propagates to C
>> 2. Y is required to propagate to C before any instruction po-after Z
>> executes
> Not if Y is a load.
>
> I guess one would have to put
>
> 	(cumul-fence+ ; [W])?
>
> or something like it in the definition.

I suppose it's true that Y being a load would be an exception, but that 
would only be if the cumul-fence+ sequence either ends in a 
strong-fence, or in po-unlock-lock-po.
We can ignore the first case (and the ordering would be provided anyways 
through pb at that point).
For the po-unlock-lock-po, you can just take Y:=the LKW event of the 
unlock and repeat the argument.

So I don't think the [W] is necessary. (and if it was maybe it would 
also be necessary in the definition of prop/cumul-fence itself, to 
account for all the non-A-cumulative fences in there).

>
>
>> Thinking about prop and pb along these lines gives me a weird feeling.
>> Trying to pinpoint it down, it seems a little bit weird that A-cumul doesn't
>> appear around the strong-fence in pb.
> I think the reason it got left out was because all strong fences are
> A-cumulative.  If some of them weren't, it would have to appear there in
> some form.
>
>>   Of course it should not appear after
>> prop which already has an rfe? at the end. Nevertheless, having the rfe? at
>> the end is clearly important to representing the idea behind prop. If it
>> weren't for the fact that A-cumul is needed to define prop, it almost makes
>> me think that it would be nice to express the difference between
>> A-cumulative and non-A-cumulative fences (that order propagation) by saying
>> that an A-cumulative fence has
>>    prop ; a-cumul-fence;rfe? <= prop
>> while the non-A-cumulative fence has
>>    prop-without-rfe ; non-a-cumul-fence <= prop-without-rfe
> Isn't this just a more complicated way of saying what the A-cumul()
> macro expresses?

In the sense that I'm just stating some consequences of A-cumul works 
inside the model, yes.
But at a syntactic level, no.  The A-cumul puts the rfe? to the front. 
Here I put the rfe? behind the A-cumulative fence.
And I distinguish between a prop that may have rfe? at the end, and one 
that doesn't, while the use of A-cumul only applies the 
"prop-without-rfe" in the sense of
prop-without-rfe ; (A-cumul(...) | ...) <= prop-without-rfe

I think part of my weird feeling comes from this asymmetry between 
A-cumul() putting the rfe? to the left and prop putting the rfe? to the 
right. Or more precisely, that the latter is sometimes in anticipation 
of an A-cumulative fence (where the A-cumul would normally take it to 
the left of that fence) and sometimes just to express the idea of 
propagation, and that these are the same, which should somehow lead to a 
simpler definition but doesn't.

>> I'm not against this partially overlapping kind of redundancy, but I dislike
>> subsuming kind of redundancy where some branches of the logic just never
>> need to be used.
> Consider: Could we remove all propagation-ordering fences from ppo
> because they are subsumed by prop?  (Or is that just wrong?)

Surely not, since prop doesn't usually provide ordering by itself.


>>> In fact, I wouldn't mind removing the happens-before, propagation, and
>>> rcu axioms from LKMM entirely, replacing them with the single
>>> executes-before axiom.
>> I was planning to propose the same thing, however, I would also propose to
>> redefine hb and rb by dropping the hb/pb parts at the end of these
>> relations.
>>
>>   hb = ....
>>   pb = prop ; strong-fence ; [Marked]
>>   rb = prop ; rcu-fence ; [Marked]
>>
>>   xb = hb|pb|rb
>>   acyclic xb
> I'm not so sure that's a good idea.  For instance, it would require the
> definitions of rcu-link and rb to be changed from having (hb* ; pb*) to
> having (hb | pb)*.
I think that's an improvement. It's obvious that (hb | pb)* is right and 
so is (pb | hb)*.
For (hb* ; pb*), the first reaction is "why do all the hb edges need to 
be before the pb edges?", until one realizes that pb actually allows hb* 
at the end, so in a sense this is  hb* ; (pb ; hb*)*, and then one has 
to understand that this means that the prop;strong-fence edges can 
appear any number of times at arbitrary locations. It just seems like 
defining (pb | hb)* with extra steps.

The order of nesting seems to be also somewhat a matter of preference, 
perhaps in some weird alternative universe the LKMM says pb = 
(prop\id)&int | prop;strong-fence  and hb = (rfe | ppo);pb*. (Personally 
I think the current way is more reasonable than this one, but that might 
be because our preferences happen to align in this instance.)

> Also, although it's not mentioned anywhere, the
> definition of xbstar could be changed to hb* ; pb* ; rb* because each of
> these relations absorbs a weaker one to its right.

I wouldn't want to need to do this reasoning just to understand that it 
has arbitrarily many hb, pb, and rb edges.

>>>> I'm wondering a little if there's some way in the middle, e.g., by writting
>>>> short comments in the model wherever something is redundant. Something like
>>>> (* note: strong-fence is included here for completeness, and can be safely
>>>> ignored *).
>>> I have no objection to doing that.  It seems like a good idea.
>>>
>>> Alan
>> Perhaps we can start a new thread then to discuss a few points where
>> redundancies might be annotated this way or eliminated.
> Sure, go ahead.

I'll put it on my to-do-list, let's converge on some topics first :D

best wishes, jonas

