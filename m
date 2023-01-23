Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93774677D53
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjAWOAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:00:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjAWOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:00:38 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D6225E25
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:00:20 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P0s3j2Mrqz9v7H3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 21:52:17 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP1 (Coremail) with SMTP id LxC2BwCHDgrNks5jaou+AA--.11465S2;
        Mon, 23 Jan 2023 14:59:54 +0100 (CET)
Message-ID: <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
Date:   Mon, 23 Jan 2023 14:59:37 +0100
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
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwCHDgrNks5jaou+AA--.11465S2
X-Coremail-Antispam: 1UD129KBjvJXoWfJr1Dtw43CFWUtrykGr47twb_yoWkWF43pF
        W5K3WIkF4kJrn2vw1Iyr1rXF1Skw4rAF4rJF95Cw1Fy398J392qr1ftw4YvFy5Gws7Ca1j
        q3yjvFyDXry5CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2023 9:56 PM, Alan Stern wrote:
> On Sat, Jan 21, 2023 at 01:41:16AM +0100, Jonas Oberhauser wrote:
>>
>> On 1/20/2023 5:32 PM, Alan Stern wrote:
>>> On Fri, Jan 20, 2023 at 12:12:50PM +0100, Jonas Oberhauser wrote:
>>>> On 1/19/2023 9:06 PM, Alan Stern wrote:
>>>>> That's backward logic.  Being strong isn't the reason the fences are
>>>>> A-cumulative.  Indeed, the model could have been written not to assume
>>>>> that strong fences are A-cumulative.
>>>> It's not just the model, it's also how strong fences are introduced in the
>>>> documentation.
>>> The documentation can be updated.
>> Sure. But what would be the benefit?
> Aren't you interested in making the memory model more understandable to
> students?

Of course : )

>> The second one is that a strong-fence is an A-cumulative fence which
>> additionally has that guarantee.
>>
>> What I meant is that reading the documentation or the model, one might come
>> to the conclusion that it means the second thing, and in that interpretation
>> fences that are strong must be A-cumulative.
> Okay, so let's change the documentation/model to ensure this doesn't
> happen.
>
>> I don't see anything wrong with that, especially since I don't think
>> strong-fence is a standard term that exists in a vacuum and means the first
>> thing by convention.
>>
>> Obviously there's some elegance in making things orthogonal rather than
>> hierarchical.
>> So I can understand why you defend the first interpretation.
>> But there's really only a benefit if that opens up some interesting design
>> space. I just don't see that right now.
>>
>> So if hypothetically you were ok to change the meaning of strong fence to
>> include A-cumulativity -- and I think from the model and documentation
>> perspective it doesn't take much to do that if anything -- then saying "all
>> strong-fence properties are covered exactly in pb" isn't a big step.
> I believe that the difference between strong and weak fences is much
> more fundamental and important than the difference between A-cumulative
> and non-A-cumulative fences.
>
> Consider an analogy: Some animals are capable of walking around, but no
> plants are.  Would you ever want to say that a plant is a non-walking
> living thing with various properties that differentiate it from animals?
> Or does it make more sense to say that plants are living things with
> various fundamental properties, and in addition some animals can walk?

I agree that the difference between (the strict definition of) strong 
and weak is more important than between A-cumulative and not.
The analogy doesn't work well for me though.
Being A-cumulative is also a form of "strength". Definitely if you 
replace a non-A-cumulative fence with an otherwise equivalent but 
A-cumulative one (assume such fences exist), then you can never get more 
behaviors, but you might get fewer.
I think that's why it's more natural for me to think of strong fences in 
terms of having multiple strong properties, the chief among which is 
that it requires "earlier" stores to propagate before po-later 
instructions execute but another one being A-cumulativity, than it would 
be of thinking of plants as being things that don't walk and have some 
other properties.


>>>> It's a bit like asking in C11 for a barrier that has the sequential
>>>> consistency guarantee of appearing in the global order S, but doesn't have
>>>> release or acquire semantics. Yes you could define that, but would it really
>>>> make sense?
>>> You're still missing the point.  The important aspect of the fences in
>>> cumul-fence is that they are A-cumulative, not whether they are strong.
>> I completely understand that. I just don't think there's anything
>> fundamentally wrong with alternatively creating a more disjoint hierarchy of
>> - fences that aren't A-cumulative but order propagation (in cumul-fence,
>> without A-cumul)
>> - fences that are A-cumulative but aren't strong (in cumul-fence, with
>> A-cumul)
>> - fences that are strong (in pb)
> There is yet another level of fences in the hierarchy: those which order
> instruction execution but not propagation (smp_rmb() and acquire).  One
> of the important points about cumul-fence is that it excludes this
> level.
>
> That's for a functional reason -- prop simply doesn't work for those
> fences, so it has to exclude them.  But it does work for strong fences,
> so excluding them would be an artificial restriction.

Hm, so could we say some fences order
1) propagation with propagation (weak fences)
2) execution with execution (rmb, acquire)
3) propagation with execution (strong fences)

where ordering with execution implicitly orders with propagation as well 
because things can only propagate after they execute.
However, the 4th possibility (execution with only propagation) happens 
not to exist. I'm not sure if it would even be distinguishable from the 
second type. In the operational model, can you forward from stores that 
have not executed yet?



>
>> Right now, both pb and cumul-fence deal with strong fences. And again, I
> I would say that cumul-fence _allows_ strong fences, or _can work with_
> strong fences.  And I would never want to say that cumul-fence and prop
> can't be used with strong fences.  In fact, if you find a situation
> where this happens, it might incline you to consider if the fence could
> be replaced with a weaker one.

Can you explain the latter part?
What does it mean to 'find a situation where this happens'?
As I understand the sentence, in current LKMM I don't think this is 
possible.
Do you mean that if you find a case where you could make a cycle with 
cumul-fence/prop using strong fences, you might just rely on a weaker 
fence instead?


>
>> understand that one point of view here is that this is not because strong
>> fences need to inherently be A-cumulative and included in cumul-fence by
>> using the strong-fence identifier.
>> Indeed one could have, in theory, strong fences that aren't A-cumulative,
>> and using strong-fence is as you wrote just a convenient way to list all the
>> A-cumulative strong fences because that currently happens to be all of the
>> strong fences.
>>
>> Another POV is that one might instead formally describe things in terms of
>> these three more disjoint classes, adapt the documentation of cumul-fence to
>> say that it does not deal with strong fences because those are dealt with in
>> a later relation, and not worry about hypothetical barriers that currently
>> don't have a justifying use case.
>> (And I suppose to some extent you already don't worry about it, because pb
>> would have to be defined differently if such fences ever made their way into
>> LKMM.)
>>
>> Now cumul-fence/prop cares about the A-cumulativity aspect, and pb about the
>> strong-fence aspect, but of course the A-cumulativity also appears in pb,
>> just hidden right now through the additional rfe? at the end of prop (if
>> there were non-A-cumulative strong fences, I think it would need to be pb =
>> overwrite & ext ; cumul-fence* ; (A-cumul(...) | ...)). So I don't think one
> Not quite right.  A hypothetical non-A-cumulative case for pb would have
> to omit the cumul-fence term entirely.

Wouldn't that violate the transitivity of "X is required to propagate 
before Y" ?
If I have
    X ->cumul-fence+ Y ->weird-strong-fence Z
doesn't that mean that for every CPU C,
1. X is required to propagate to C before Y propagates to C
2. Y is required to propagate to C before any instruction po-after Z  
executes

But then also X is required to pragate to C before any instruction 
po-after Z  executes.
How is this enforced if there is no cumul-fence* in the new pb?

Thinking about prop and pb along these lines gives me a weird feeling.
Trying to pinpoint it down, it seems a little bit weird that A-cumul 
doesn't appear around the strong-fence in pb. Of course it should not 
appear after prop which already has an rfe? at the end. Nevertheless, 
having the rfe? at the end is clearly important to representing the idea 
behind prop. If it weren't for the fact that A-cumul is needed to define 
prop, it almost makes me think that it would be nice to express the 
difference between A-cumulative and non-A-cumulative fences (that order 
propagation) by saying that an A-cumulative fence has
   prop ; a-cumul-fence;rfe? <= prop
while the non-A-cumulative fence has
   prop-without-rfe ; non-a-cumul-fence <= prop-without-rfe

where prop links E and F if there is some coherence-later store after E 
that propagates to F's CPU by the time F executes, and prop-without-rfe 
links them if that store propagates to any CPU before F propagates to 
that CPU. (of course this ignores the interplay between these two 
relations that happens if you have a mix of a-cumul-fences and 
non-a-cumul-fences).


>
>> can draw the A-cumulativity aspect delineation between the relations clearly
>> (when allowing for orthogonality). I'm proposing instead to make
>> A-cumulativity a part of being a strong-fence and drawing the strong-fence
>> delineation clearly.
> Maybe so, in some sense.  But in practice you're asking to have strong
> fences removed from cumul-fence and prop.  I don't want to do that, even
> at the cost of some redundancy.
>
> Consider the RB pattern as another example.  Suppose the read -> write
> ordering on one or both sides is provided by a fence rather than a
> dependency or some such.  Would you want to keep such cycles out of the
> (ppo | rfe)+ part of hb+, on the basis that they also can be covered by
> ((prop \ id) & int)?

This is the kind of case I mentioned before, where there are still good 
uses for every individual part (i.e., if you have a fence, it might be 
important for ppo or prop to complete a circle), and the existance of 
the fences might just draw one into a more likely direction.
Besides, the model one obtains by trying to remove this redundancy just 
becomes more complicated, which is the opposite of what I want.

Another good example are the many different fences in cumul-fence, such 
as in a thread that looks like Rx;mb();Wy;wmb(); Wz... : here one can 
use either one or two cumul-fence edges (link the Wx that Rx reads from 
with Wy and then Wy with Wz, or link it directly to Wz), but trying to 
eliminate this redundancy just makes the model more complicated.

I'm not against this partially overlapping kind of redundancy, but I 
dislike subsuming kind of redundancy where some branches of the logic 
just never need to be used.


> In fact, I wouldn't mind removing the happens-before, propagation, and
> rcu axioms from LKMM entirely, replacing them with the single
> executes-before axiom.

I was planning to propose the same thing, however, I would also propose 
to redefine hb and rb by dropping the hb/pb parts at the end of these 
relations.

  hb = ....
  pb = prop ; strong-fence ; [Marked]
  rb = prop ; rcu-fence ; [Marked]

  xb = hb|pb|rb
  acyclic xb



>
>> I'm wondering a little if there's some way in the middle, e.g., by writting
>> short comments in the model wherever something is redundant. Something like
>> (* note: strong-fence is included here for completeness, and can be safely
>> ignored *).
> I have no objection to doing that.  It seems like a good idea.
>
> Alan

Perhaps we can start a new thread then to discuss a few points where 
redundancies might be annotated this way or eliminated.

Best wishes,
jonas

