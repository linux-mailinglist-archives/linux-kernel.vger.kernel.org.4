Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4077E676283
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Jan 2023 01:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjAUAl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 19:41:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjAUAl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 19:41:56 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD978FF34
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 16:41:54 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4NzHRS3fxLz9v7Nc
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jan 2023 08:33:56 +0800 (CST)
Received: from [10.81.218.54] (unknown [10.81.218.54])
        by APP2 (Coremail) with SMTP id GxC2BwCHW2KvNMtjUKSxAA--.5437S2;
        Sat, 21 Jan 2023 01:41:31 +0100 (CET)
Message-ID: <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
Date:   Sat, 21 Jan 2023 01:41:16 +0100
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwCHW2KvNMtjUKSxAA--.5437S2
X-Coremail-Antispam: 1UD129KBjvJXoW3KF1fJryfJr1kKr4xuF4xCrg_yoWDtF1fpF
        WYk3Z2kr4kJrn2v34xtw4fXw4fuw4rJFW5Jr9Ykwn5A398Xa92qr4ftr4Y9F9rCrs2k3yj
        qF40va4kArs8CFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UZ18PUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/20/2023 5:32 PM, Alan Stern wrote:
> On Fri, Jan 20, 2023 at 12:12:50PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/19/2023 9:06 PM, Alan Stern wrote:
>>> That's backward logic.  Being strong isn't the reason the fences are
>>> A-cumulative.  Indeed, the model could have been written not to assume
>>> that strong fences are A-cumulative.
>> It's not just the model, it's also how strong fences are introduced in the
>> documentation.
> The documentation can be updated.

Sure. But what would be the benefit?
Anyways, what I meant is something else.
There are (at least) two interpretations of what a strong-fence is.
The first that you have in mind as far as I understand, that every store 
affected by the strong-fence must propagate to every other CPU before 
any instruction behind the strong-fence executes. (but it doesn't talk 
about which stores are being affected).
The second one is that a strong-fence is an A-cumulative fence which 
additionally has that guarantee.

What I meant is that reading the documentation or the model, one might 
come to the conclusion that it means the second thing, and in that 
interpretation fences that are strong must be A-cumulative.
I don't see anything wrong with that, especially since I don't think 
strong-fence is a standard term that exists in a vacuum and means the 
first thing by convention.

Obviously there's some elegance in making things orthogonal rather than 
hierarchical.
So I can understand why you defend the first interpretation.
But there's really only a benefit if that opens up some interesting 
design space. I just don't see that right now.

So if hypothetically you were ok to change the meaning of strong fence 
to include A-cumulativity -- and I think from the model and 
documentation perspective it doesn't take much to do that if anything -- 
then saying "all strong-fence properties are covered exactly in pb" 
isn't a big step.


>
>> I agree though that you could decouple the notion of strong from
>> A-cumulativity.
>> But would anyone want a strong fence that is not A-cumulative?
> Why would anyone want a weak fence that isn't A-cumulative?  :-)
> Architecture designers sometimes do strange things...

(as a side note and out of curiosity: Which architecture has a weak 
fence that isn't A-cumulative? Is it alpha?)

As for strong fences that aren't A-cumulative, I remember someone 
telling me not too long ago that one shouldn't worry about strange 
hypothetical architectures ; )
More to the point, I find it improbable that the performance benefit of 
this vs just using however smp_mb() maps on that architecture would ever 
warrant the inclusion of such a fence in the LKMM.

>> It's a bit like asking in C11 for a barrier that has the sequential
>> consistency guarantee of appearing in the global order S, but doesn't have
>> release or acquire semantics. Yes you could define that, but would it really
>> make sense?
> You're still missing the point.  The important aspect of the fences in
> cumul-fence is that they are A-cumulative, not whether they are strong.

I completely understand that. I just don't think there's anything 
fundamentally wrong with alternatively creating a more disjoint 
hierarchy of
- fences that aren't A-cumulative but order propagation (in cumul-fence, 
without A-cumul)
- fences that are A-cumulative but aren't strong (in cumul-fence, with 
A-cumul)
- fences that are strong (in pb)


Right now, both pb and cumul-fence deal with strong fences. And again, I 
understand that one point of view here is that this is not because 
strong fences need to inherently be A-cumulative and included in 
cumul-fence by using the strong-fence identifier.
Indeed one could have, in theory, strong fences that aren't 
A-cumulative, and using strong-fence is as you wrote just a convenient 
way to list all the A-cumulative strong fences because that currently 
happens to be all of the strong fences.

Another POV is that one might instead formally describe things in terms 
of these three more disjoint classes, adapt the documentation of 
cumul-fence to say that it does not deal with strong fences because 
those are dealt with in a later relation, and not worry about 
hypothetical barriers that currently don't have a justifying use case.
(And I suppose to some extent you already don't worry about it, because 
pb would have to be defined differently if such fences ever made their 
way into LKMM.)

Now cumul-fence/prop cares about the A-cumulativity aspect, and pb about 
the strong-fence aspect, but of course the A-cumulativity also appears 
in pb, just hidden right now through the additional rfe? at the end of 
prop (if there were non-A-cumulative strong fences, I think it would 
need to be pb = overwrite & ext ; cumul-fence* ; (A-cumul(...) | ...)). 
So I don't think one can draw the A-cumulativity aspect delineation 
between the relations clearly (when allowing for orthogonality). I'm 
proposing instead to make A-cumulativity a part of being a strong-fence 
and drawing the strong-fence delineation clearly.


> You're fixating on an irrelevancy.

The only thing I'm fixating on is whether it makes sense to remove 
certain redundancies in LKMM.
And I don't think that's irrelevant; it's about reducing friction and 
making thinking about LKMM faster in the long run.

>>> This may be so, but I would like to point out that the memory model was
>>> not particularly designed to be as short or as simple as possible, but
>>> more to reflect transparently the intuitions that kernel programmers
>>> have about the ways ordering should work in the kernel.  It may very
>>> well include redundancies as a result.  I don't think that's a bad
>>> point.
>> I agree that sometimes redundancies have value. But I think having, where
>> possible, a kind of minimal responsibility principle where each fence
>> appears in as few relations as possible also has value.
>> I've seen that when I try to help people in my team learn to use LKMM: they
>> see a specific type of fence and get stuck for a while chasing one of its
>> uses. For example, they may chase a long prop link using the only strong
>> fence in the example somewhere in the middle, which will then later turn out
>> to be a dead-end because what they need to use is pb.
> People who make that particular mistake should take a lesson from it:
> The presence of a strong fence should point them toward looking for an
> application of pb before looking at prop, because pb is is based on the
> special properties of strong fences whereas prop is not.

Yes, with two caveats:
- you can remove the "before looking at prop" since there's never ever 
any point of looking at (extending) prop when you have a strong fence
- why give people the opportunity for that mistake in the first place? ...
> [...] by making a mistake through pursuing
> a redundant pathway, people can deepen their understanding.  That's how
> one learns.
... I do feel reminded about the discussion about building character : )

Honestly I would easily see your point if there were some uncommon 
reasons to use the strong fence to extend prop. Then the lesson is what 
you mentioned: usually, strong fences should be looked at through the pb 
lense, and only if you get stuck that way it makes sense to look through 
the prop lense (and probably one could develop a good intuition for 
which situation calls for which after some time).

But that's not the case here. There's nothing to learn here except that 
one should pretend that strong-fence didn't exist in prop.
That lesson could also be learned by not having it there in the first 
place.
And I think you can easily present LKMM in a way that makes this look 
reasonable.

>> For someone who doesn't know that we never need to rely on that use to get
>> ordering, it basically doubles the amount of time spent looking at the graph
>> and chasing definitions. And for very good reasons there already are alot of
>> definitions even when redundancies are eliminated.
> IMO, people who try to use the memory model this way need to develop a
> good understanding of it first.
I disagree; both for the reason you mention later, but also because IMHO 
the big advantage of a formal model is you don't need to get a good 
understanding before you can start going and tackling issues.
In German we say "entlanghangeln" which literally means "to make one's 
way hand over hand along a rope", as a metaphor for following formal 
definitions carefully step by step when one doesn't yet have a strong 
intuition to get everything right without needing to look at the 
formalism; the formalism is kind of a safety line that prevents one from 
falling into the abyss.
(and in the spirit of what you said below, while doing that with an 
attentive mind one builds intuition and understanding).

> (Although perhaps carrying out these
> sorts of exercises is _how_ people develop their understanding...)  I
> don't regard it as a bad thing that by making a mistake through pursuing
> a redundant pathway, people can deepen their understanding.  That's how
> one learns.

I agree.

>> Perhaps I would say that including these redundancies is good for
>> understanding why the formalization makes sense, but excluding them is
>> better for actually using the formalization.
>> This includes both when looking at code while having a printout of the model
>> next to you, but also when trying to reason about LKMM itself (e.g., what
>> one might do when changes are made to LKMM and one wants to check that they
>> interact well with the existing parts of LKMM).
> Not necessarily so.  You might _want_ a change to affect one of the
> redundant paths but not the other.

I definitely agree that it might very well be that the redundancy is 
dissolved at a later point in time through such discovery.
In this case one would have simplified too much : )

But what I mean is, for example, when introducing rmw-sequences a 
question that came up is whether they are sufficient to ensure monotonicity.

Analyzing stuff like this is much easier on a simplified model 
(including some other simplifications that are all equivalent to LKMM as 
written), because there are a lot fewer cases to cover.
It turns a proof that feels like a bookkeeping nightmare into something 
that I can manage in a few pages of paper.
Similarly when thinking about whether rcu could be understood through a 
lense that is closer to the Grace Period Guarantee rather than counting 
gps and rscs, I do this on the simplified model, because those 
equivalence proofs become easier.

I'm wondering a little if there's some way in the middle, e.g., by 
writting short comments in the model wherever something is redundant. 
Something like (* note: strong-fence is included here for completeness, 
and can be safely ignored *).

Best wishes,
   jonas

