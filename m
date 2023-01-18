Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE56C672AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:39:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjARVjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:39:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjARVjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:39:00 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1498459C2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 13:38:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NxzTH5Nm4z9v7P2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:30:59 +0800 (CST)
Received: from [10.48.135.81] (unknown [10.48.135.81])
        by APP1 (Coremail) with SMTP id LxC2BwBHywbHZshjqD6qAA--.1903S2;
        Wed, 18 Jan 2023 22:38:29 +0100 (CET)
Message-ID: <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
Date:   Wed, 18 Jan 2023 22:38:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org, viktor@mpi-sws.org
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8hN7vs/w8LhMasT@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBHywbHZshjqD6qAA--.1903S2
X-Coremail-Antispam: 1UD129KBjvJXoW3ury3tFWUXFWxXr4fAF43ZFb_yoWDZr45pF
        W5Ka93KF4kJryv9wnrAa9rZryjvws5WFW8Jr15Jw1rAw15Jw1Ivr4xtr4YvFy5Crs3KFyY
        vr4jyw1vvan8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IUbG2NtUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/18/2023 8:52 PM, Alan Stern wrote:
> On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
>> As stated in the documentation and implied by its name, the ppo
>> (preserved program order) relation is intended to link po-earlier
>> to po-later instructions under certain conditions.  However, a
>> corner case currently allows instructions to be linked by ppo that
>> are not executed by the same thread, i.e., instructions are being
>> linked that have no po relation.
>>
>> This happens due to the mb/strong-fence relations, which (as one
>> case) provide order when locks are passed between threads followed
>> by an smp_mb__after_unlock_lock() fence.  This is illustrated in
>> the following litmus test (as can be seen when using herd7 with
>> `doshow ppo`):
>>
>> P0(int *x, int *y)
>> {
>>      spin_lock(x);
>>      spin_unlock(x);
>> }
>>
>> P1(int *x, int *y)
>> {
>>      spin_lock(x);
>>      smp_mb__after_unlock_lock();
>>      *y = 1;
>> }
>>
>> The ppo relation will link P0's spin_lock(x) and P1's *y=1,
>> because P0 passes a lock to P1 which then uses this fence.
>>
>> The patch makes ppo a subrelation of po by eliminating this
>> possibility from mb and strong-fence, and instead introduces the
>> notion of strong ordering operations, which are allowed to link
>> events of distinct threads.
>>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> ---
> I'm just going to comment on the changes to the cat file.  I'll review
> the documentation changes later.
>
>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
>> index 07f884f9b2bf..1d91edbc10fe 100644
>> --- a/tools/memory-model/linux-kernel.cat
>> +++ b/tools/memory-model/linux-kernel.cat
>> @@ -36,9 +36,7 @@ let wmb = [W] ; fencerel(Wmb) ; [W]
>>   let mb = ([M] ; fencerel(Mb) ; [M]) |
>>   	([M] ; fencerel(Before-atomic) ; [RMW] ; po? ; [M]) |
>>   	([M] ; po? ; [RMW] ; fencerel(After-atomic) ; [M]) |
>> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>> -		fencerel(After-unlock-lock) ; [M])
>> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
> Shouldn't the po case of (co | po) remain intact here?

You can leave it here, but it is already covered by two other parts: the 
ordering given through ppo/hb is covered by the po-unlock-lock-po & int 
in ppo, and the ordering given through pb is covered by its inclusion in 
strong-order.

Now whether it should be included in strong-order or not is a matter of 
grouping: is it better to leave all cases ordered by the 
[After-unlock-lock] fence together, or is it better to keep the <=po 
parts of the fences together and the external parts together?
Right now I prefer to group things around the fences because that is 
more of an isolated idea, rather than around whether they order 
internally or externally.

As a side bonus I like that

    po-unlock-lock-po ; [After-unlock-lock]

"rhymes" nicely. If we split the strong-order definition and move the po 
part back into mb, that would disappear.


>>   let gp = po ; [Sync-rcu | Sync-srcu] ; po?
>>   let strong-fence = mb | gp
>>   
>> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>>   (* Write and fence propagation ordering *)
>>   (****************************************)
>>   
>> -(* Propagation: Each non-rf link needs a strong fence. *)
>> -let pb = prop ; strong-fence ; hb* ; [Marked]
>> +(* Strong ordering operations *)
>> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
>> +		[After-unlock-lock] ; po ; [M])
> This is not the same as the definition removed above.  In particular,
> po-unlock-lock-po only allows one step along the locking chain -- it has
> rf where the definition above has co.

Indeed it is not, but the subsequent lock-unlock sequences are in hb*. 
For this reason it can be simplified to just consider the directly 
following unlock(). As a consequence, LKW becomes de-emphasized. Note 
that if you remove the explicit references to LKW from the model, you 
can argue about programs that don't use trylock as though LKW didn't 
exist, which is what some people in academia do, e.g., 
https://people.mpi-sws.org/~viktor/papers/oopsla2019-lapor.pdf (I added 
Viktor in CC, in case he wants to add something).
Since it doesn't cost anything I decided to include it like this.

I don't feel extremely strong about either point, but I've written them 
according to my preference.

>
>> +
>> +(* Propagation: Each non-rf link needs a strong ordering operation. *)
>> +let pb = prop ; strong-order ; hb* ; [Marked]
>>   acyclic pb as propagation
>>   
>>   (*******)
>> @@ -141,7 +143,7 @@ let rec rcu-order = rcu-gp | srcu-gp |
>>   	(rcu-order ; rcu-link ; rcu-order)
>>   let rcu-fence = po ; rcu-order ; po?
>>   let fence = fence | rcu-fence
> It would be nice here to have a separate term for a potentially
> cross-CPU fence.
>
> In fact, why don't we make a concerted effort to straighten out the
> terminology more fully?  Now seems like a good time to do it.

I agree; wrapping my head around this terminology-space is the whole 
reason why I started looking into the formalization of rcu, and I'm 
beginning to understand it a little bit.

> To begin with, let's be more careful about the difference between an
> order-inducing object (an event or pair of events) and the relation of
> being ordered by such an object.  For instance, given:
>
> 	A: WRITE_ONCE(x, 1);
> 	B: smp_mb();
> 	C: r1 = READ_ONCE(y);
>
> then B is an order-inducing object (a memory barrier), and (A,C) is a
> pair of events ordered by that object.  In general, an order is related
> to an order-inducing object by:
>
> 	order = po ; [order-inducing object] ; po

Yes! That's what I was trying to say in the rcu-order/rcu-fence 
discussion. (I would call it an operation rather than an object, since 
it may be something involving steps of multiple threads, like rcu, but 
let's stick with object for now).
However, while trying to rewrite the definition, I noticed that there 
*is* something around rb which requires playing with po?, just not in 
the current definition of rcu-fence or gp. This is currently covered in 
having po <= rcu-link.
A good example would be

    ... ->prop  X ->po;rcu-rcsc;rcu-link;rcu-gp Y ->po Z 
->rcu-gp;rcu-link;rcu-rscs;po ...

(I think this happens to be very similar if not the same as the code you 
sent earlier!).
in my view this includes two ordering objects (the two RCU law instances 
rcu-rcsc;rcu-link;rcu-gp and rcu-gp;rcu-link;rcu-rscs), but there's only 
one po! It can't be made to quite belong to either ordering object, so 
you don't have order;order here.

So I started wondering why the same isn't the case for pb, and whether 
perhaps it should be
     order = po ; [order-inducing object] ; po?
This way you'd get order;order here quite neatly.

I figured out that if we replace the first ordering object here with a 
pb related one like
    ... ->prop  X ->po;[mb fence] Y ->po Z ->rcu-gp;rcu-link;rcu-rscs;po ...
then we can just forget about the first ordering object and turn the 
whole thing into
    ... ->prop  X ->po Z ->rcu-gp;rcu-link;rcu-rscs;po ...

So in this case, the po can always be "stolen" by the second ordering 
object and we can completely forget about the first one, because the 
prop;po already has an ordering effect together with the second ordering 
object by itself.
This is also the case if the second ordering object is a pb-related one.
For this reason, the issue of po? never comes up when sticking to hb and 
pb, only when looking at rb.
That at least explains why using po is ok for defining strong-order.

I'm still not sure if just defining
     order = po ; [order-inducing object] ; po?
would also be ok for defining strong-order. This would have the benefit 
that it would just work for for rb-related order-inducing objects as well.
Do you remember why the current definition does not have a po? at the end?

>
> with suitable modifications for things like smp_store_release where
> one of the events being ordered _is_ the order-inducing event.
>
> So for example, we could consistently refer to all order-inducing events
> as either barriers or fences, and all order-reflecting relations as orders.  This would require widespread changes to the .cat file, but I
> think it would be worthwhile.

I agree that having a uniform language for this is worthwhile.
However you just dropped the cases of order-inducing objects that are 
not just a single event.
I am completely fine calling the individual *events* barriers.
(I don't like calling every barrier a fence though; Arm very explicitly 
doesn't do this and internally we don't either. However for LKMM I don't 
mind sticking to existing terminology here and calling them all fences; 
but to me a fence is something that orders certain things po-before the 
fence with certain things po-after).
But I would like to have a name for order-inducing objects that link two 
events.

I would call them an "ordering operation" where the first event is the 
event that "starts the operation", and the second event is the event 
that "completes that operation".
Then we can say things like "when CPU C starts an ordering operation of 
type blah that is completed by CPU C', then any store that propagates to 
C before C starts the operation must propagate to any CPU C'' before any 
store of C' that is executed after C' completes the execution propagates 
to C''  ".
This would be a weak ordering operation, and would probably imply that 
blah-order is a kind of happens-before order and would appear in 
cumul-fence.

Or  "when CPU C starts an ordering operation of type blubb that is 
completed by CPU C', then any store that propagates to C before C starts 
the operation must propagate to any other CPU before any instruction of 
C' po-after C' completes the execution is executed".
This would be a strong ordering operation which would imply that prop ; 
blubb-order is a kind of happens-before order.

> (Treating "barrier" and "fence" as synonyms seems to be too deeply
> entrenched to try and fight against.)
>
> Once that is straightened out, we can distinguish between fences or
> orders that are weak vs. strong.  And then we can divide up strong
> fences/orders into single-CPU vs. cross-CPU, if we want to.
With the distinction above, barriers and fences are always single-CPU, 
while ordering operations can be either cross-CPU or single-CPU. I'm not 
sure if there's still a need to distinguish more carefully than that.

Hope that makes sense,
jonas


