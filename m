Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF9EC67A3C5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbjAXUXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:23:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbjAXUXo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:23:44 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7733B7D8D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:23:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P1dWW1xqTz9xFn2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 04:15:35 +0800 (CST)
Received: from [10.45.158.189] (unknown [10.45.158.189])
        by APP1 (Coremail) with SMTP id LxC2BwD3ewcpPtBj3BXEAA--.14580S2;
        Tue, 24 Jan 2023 21:23:17 +0100 (CET)
Message-ID: <40447973-6f6b-86f7-1147-d8f20a943767@huaweicloud.com>
Date:   Tue, 24 Jan 2023 21:23:02 +0100
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
References: <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
 <Y873uBB5rAW8tjdd@rowland.harvard.edu>
 <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
 <Y9AR4Gr10SyCKovo@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9AR4Gr10SyCKovo@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3ewcpPtBj3BXEAA--.14580S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Wr1rKF4kGrW5CFWkKr13CFg_yoWxXr1Upa
        yfKFsY9r1kJr1I9r92ywn5XF1Skw48JF4fJrnYy3WrAws8Xr1IyF15K3yF9FyUJr4vyF4j
        vF45Aas7ZasxZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
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
        67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/24/2023 6:14 PM, Alan Stern wrote:
> On Tue, Jan 24, 2023 at 02:14:03PM +0100, Jonas Oberhauser wrote:
>> After mulling it over a bit in my big old head, I consider that even though
>> dropping the [W] may be shorter, it might make for the simpler model by
>> excluding lots of cases.
>> That makes me think you should do it for real in the definition of prop. And
>> not just at the very end, because in fact each cumul-fence link might come
>> from a non-A-cumulative fence. So the same argument you are giving should be
>> applied recursively.
>> Either
>>
>> 	prop = (overwrite & ext)? ; (cumul-fence; [W])* ; rfe?
>>
>> or integrate it directly into cumul-fence.
> I dislike this sort of argument.  I understand the formal memory model
> by relating it to the informal operational model.  Thus, cumul-fence
> links a write W to another event E when the fence guarantees that W will
> propagate to E's CPU before E executes.

I later wondered why it's not defined like this and realized that prop 
means that it's before E executes.

> That's how the memory model
> expresses the propagation properties of these fences.

I don't think that's really a perfect match though.
For example, W ->wmb E (and thus cumul-fence) does guarantee that W 
propagates to E's CPU before E executes.
But the propagation property of wmb is that W propagates to every CPU 
before E propagates to that CPU.
It just so happens that the time E propagates to E's CPU is the time it 
executes.

Indeed, looking at the non-strong properties of fences only, should give 
rise to a relation that only says "W propagates to any CPU before E 
propagates to that CPU" and that is a relation between stores. And quite 
different from "W propagates to E's CPU before E executes".

I believe that relation is (cumul-fence;[W])+.
Then
   X ->(overwrite&ext);(cumul-fence;[W])* E
means that there is some W co-after X which propagates to any CPU no 
later than E due to the weak properties of fences along that path.
And
   X ->(overwrite&ext);(cumul-fence;[W])*;rfe? E
implies that there is some W co-after X which propagates to the CPU 
executing E no later than E executes. (because E observes or executes 
and hence propapagated to itself a store that must propagate to E's CPU 
no earlier than W).

I think this is closer to the idea of expressing the (non-strong) 
propagation properties of the fences.

> I don't want to
> rule out the possibility that E is a read merely because cumul-fence
> might be followed by another, A-cumulative fence.
Perhaps you mean non-A-cumulative fence?
The A-cumulative fences (when their A-cumulativity is actually used) 
already rule out reads because they use
overwrite;cumul-fence*;rfe;(the a-cumulativity)

>
>>>>> Consider: Could we remove all propagation-ordering fences from ppo
>>>>> because they are subsumed by prop?  (Or is that just wrong?)
>>>> Surely not, since prop doesn't usually provide ordering by itself.
>>> Sorry, I meant the prop-related non-ppo parts of hb and pb.
>> I still don't follow :( Can you write some equations to show me what you
>> mean?
> Consider:
>
> 	Rx=1			Ry=1
> 	Wrelease Y=1		Wx=1
>
> Here we have Wx=1 ->hb* Ry=1 by (prop \ id) & int, using the fact that
> Wy=1 is an A-cumulative release fence.  But we also have
>
> 	Wx=1 ->rfe Rx=1 ->ppo Wy=1 ->rfe Ry=1.
>
> Thus there are two distinct ways of proving that Wx=1 ->hb* Ry=1.  If we
> removed the fence term from the definition of ppo (or weakened it to
> just rmb | acq), we would eliminate the second, redundant proof.  Is
> this the sort of thing you think we should do?

The reason I wouldn't do something like that is that firstly, the fence 
does preserve the program order, and secondly there are proofs where you 
need to use that fact.

>>>>>>> In fact, I wouldn't mind removing the happens-before, propagation, and
>>>>>>> rcu axioms from LKMM entirely, replacing them with the single
>>>>>>> executes-before axiom.
>>>>>> I was planning to propose the same thing, however, I would also propose to
>>>>>> redefine hb and rb by dropping the hb/pb parts at the end of these
>>>>>> relations.
>>>>>>
>>>>>>     hb = ....
>>>>>>     pb = prop ; strong-fence ; [Marked]
>>>>>>     rb = prop ; rcu-fence ; [Marked]
>>>>>>
>>>>>>     xb = hb|pb|rb
>>>>>>     acyclic xb
>>>>> I'm not so sure that's a good idea.  For instance, it would require the
>>>>> definitions of rcu-link and rb to be changed from having (hb* ; pb*) to
>>>>> having (hb | pb)*.
>>>> I think that's an improvement. It's obvious that (hb | pb)* is right and so
>>>> is (pb | hb)*.
>>>> For (hb* ; pb*), the first reaction is "why do all the hb edges need to be
>>>> before the pb edges?", until one realizes that pb actually allows hb* at the
>>>> end, so in a sense this is  hb* ; (pb ; hb*)*, and then one has to
>>>> understand that this means that the prop;strong-fence edges can appear any
>>>> number of times at arbitrary locations. It just seems like defining (pb |
>>>> hb)* with extra steps.
>>> This can be mentioned explicitly as a comment or in explanation.txt.
>> Ok, but why not just use  (pb|hb)* and (pb|hb|rb)* and not worry about
>> having to explain anything?
>> And make the hb and rb definitions simpler at the same time?
> Do you think (pb | hb)* is simpler than pb* (as in the statement of the
> propagation axiom)?
pb+,  however aren't you thinking of getting rid of the propagation axiom?
I still think (pb' | hb)+ where pb' is the simpler definition of pb is 
simpler than pb*, where pb=pb';hb*.

> Besides, remember what I said about understanding the formal memory
> model in terms of the operational model.  pb relates a write W to
> another event E when the strong fence guarantees that W will propagate
> to E's CPU before E executes.
I suppose to every CPU before E executes?

> If the hb* term were omitted from the definition of pb, this wouldn't be true any more.  Or at least, not as
> true as it should be.

Why is that the right level of how true it should be?

doesn't W ->pb;rb E also guarantee that W will propagate to E's CPU 
before E executes?
Or even just W ->pb;pb E?
Why only consider W->pb;hb E?

I'd rather think of it in terms of "this is the basic block that implies 
that it W executes before E because it propagates to every CPU before E 
executes, and then you can of course extend it by adding any of pb,rb, 
and hb at the end to get a longer "executes before"".

Best wishes, jonas

