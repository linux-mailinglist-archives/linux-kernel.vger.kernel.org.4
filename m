Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E64680236
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Jan 2023 23:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbjA2WUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Jan 2023 17:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235130AbjA2WUN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jan 2023 17:20:13 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAC81DBB4
        for <linux-kernel@vger.kernel.org>; Sun, 29 Jan 2023 14:20:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P4lsZ1l0qz9xGYC
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:12:02 +0800 (CST)
Received: from [10.81.212.248] (unknown [10.81.212.248])
        by APP2 (Coremail) with SMTP id GxC2BwAn81n38NZjovnXAA--.7399S2;
        Sun, 29 Jan 2023 23:19:46 +0100 (CET)
Message-ID: <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
Date:   Sun, 29 Jan 2023 23:19:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org, urezki@gmail.com,
        quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu> <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwAn81n38NZjovnXAA--.7399S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtw1DGrW5Aw45GF15GFW7urg_yoWxKryrpF
        Wrtan0kFWktrZ5Zw1Dtw1UXa4fCw4Fyw4Yvw18J3W8C3s8Xr92qF40grWj93srGrs2gayU
        ZrWjyFZrZFyDZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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


Hi all, apologies on the confusion about the litmus test.
I should have explained it better but it seems you mostly figured it out.
As Alan said I'm tricking a little bit by not unlocking in certain 
places to filter out all executions that aren't what I'm looking for.
I didn't have much time when I sent it (hence also the lack of 
explanation and why I haven't responded earlier), so I didn't have time 
to play around with the filter feature to do this the "proper"/non-cute way.
As such it really isn't about deadlocks.

I think one question is whether the distinction between the models could 
be reproduced without using any kind of filtering at all.
I have a feeling it should be possible but I haven't had time to think 
up a litmus test that does that.


On 1/28/2023 11:59 PM, Alan Stern wrote:
> On Sat, Jan 28, 2023 at 11:14:17PM +0100, Andrea Parri wrote:
>>> Evidently the plain-coherence check rules out x=1 at the
>>> end, because when I relax that check, x=1 becomes a possible result.
>>> Furthermore, the graphical output confirms that this execution has a
>>> ww-incoh edge from Wx=2 to Wx=1.  But there is no ww-vis edge from Wx=1
>>> to Wx=2!  How can this be possible?  It seems like a bug in herd7.
>> By default, herd7 performs some edges removal when generating the
>> graphical outputs.  The option -showraw can be useful to increase
>> the "verbosity", for example,
>>
>>    [with "exists (x=2)", output in /tmp/T.dot]
>>    $ herd7 -conf linux-kernel.cfg T.litmus -show prop -o /tmp -skipchecks plain-coherence -doshow ww-vis -showraw ww-vis
> Okay, thanks, that helps a lot.
>
> So here's what we've got.  The litmus test:
>
>
> C hb-and-int
> {}
>
> P0(int *x, int *y)
> {
>      *x = 1;
>      smp_store_release(y, 1);
> }
>
> P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
> {
>      spin_lock(l);
>      int r1 = READ_ONCE(*dy);
>      if (r1==1)
>          spin_unlock(l);
>
>      int r0 = smp_load_acquire(y);
>      if (r0 == 1) {
>          WRITE_ONCE(*dx,1);
>      }
> }
>
> P2(int *dx, int *dy)
> {
>      WRITE_ONCE(*dy,READ_ONCE(*dx));
> }
>
>
> P3(int *x, spinlock_t *l)
> {
>      spin_lock(l);
>      smp_mb__after_unlock_lock();
>      *x = 2;
> }
>
> exists (x=2)
>
>
> The reason why Wx=1 ->ww-vis Wx=2:
>
> 	0:Wx=1 ->po-rel 0:Wy=1 and po-rel < fence < ww-post-bounded.
>
> 	0:Wy=1 ->rfe 1:Ry=1 ->(hb* & int) 1:Rdy=1 and
> 		(rfe ; hb* & int) <= (rfe ; xbstar & int) <= vis.
>
> 	1:Rdy=1 ->po 1:unlock ->rfe 3:lock ->po 3:Wx=2
> 		so 1:Rdy=1 ->po-unlock-lock-po 3:Wx=2
> 		and po-unlock-lock-po <= mb <= fence <= w-pre-bounded.
>
> [...]
>
> This explains why the memory model says there isn't a data race.  This
> doesn't use the smp_mb__after_unlock_lock at all.

Note as Andrea said that po-unlock-lock-po is generally not in mb (and 
also not otherwise in fence).
Only po-unlock-lock-po;[After-unlock-lock];po is in mb (resp. ...&int in 
fence).
While the example uses smp_mb__after_unlock_lock, the anomaly should 
generally cover any extended fences.


[Snipping in a part of an earlier e-mail you sent]



> I think that herd7_should_  say there is a data race.
>
> On the other hand, I also think that the operational model says there
> isn't.  This is a case where the formal model fails to match the
> operational model.
>
> The operational model says that if W is a release-store on CPU C and W'
> is another store which propagates to C before W executes, then W'
> propagates to every CPU before W does.  (In other words, releases are
> A-cumulative).  But the formal model enforces this rule only in cases
> the event reading W' on C is po-before W.
>
> In your litmus test, the event reading y=1 on P1 is po-after the
> spin_unlock (which is a release).  Nevertheless, any feasible execution
> requires that P1 must execute Ry=1 before the unlock.  So the
> operational model says that y=1 must propagate to P3 before the unlock
> does, i.e., before P3 executes the spin_lock().  But the formal model
> doesn't require this.


I see now. Somehow I thought stores must execute in program order, but I 
guess it doesn't make sense.
In that sense, W ->xbstar&int X always means W propagates to X's CPU 
before X executes.


> Ideally we would fix this by changing the definition of po-rel to:
>
> 	[M] ; (xbstar & int) ; [Release]
>
> (This is closely related to the use of (xbstar & int) in the definition
> of vis that you asked about.)

This misses the property of release stores that any po-earlier store 
must also execute before the release store.
Perhaps it could be changed to the old  po-rel | [M] ; (xbstar & int) ; 
[Release] but then one could instead move this into the definition of 
cumul-fence.
In fact you'd probably want this for all the propagation fences, so 
cumul-fence and pb should be the right place.

> Unfortunately we can't do this, because
> po-rel has to be defined long before xbstar.

You could do it, by turning the relation into one massive recursive 
definition.

Thinking about what the options are:
1) accept the difference and run with it by making it consistent inside 
the axiomatic model
2) fix it through the recursive definition, which seems to be quite ugly 
but also consistent with the power operational model as far as I can tell
3) weaken the operational model... somehow
4) just ignore the anomaly
5) ???

Currently my least favorite option is 4) since it seems a bit off that 
the reasoning applies in one specific case of LKMM, more specifically 
the data race definition which should be equivalent to "the order of the 
two races isn't fixed", but here the order isn't fixed but it's a data race.
I think the patch happens to almost do 1) because the xbstar&int at the 
end should already imply ordering through the prop&int <= hb rule.
What would remain is to also exclude rcu-fence somehow.

2) seems the most correct choice but also to complicate LKMM a lot.

Seems like being between a rock and hard place.
jonas

PS:
>> The other cases of *-pre-bounded seem to work out: they all link stuff via
>> xbstar to the instruction that is linked via po-unlock-lock-po ;
>> [After-unlock-lock] ; po to the potentially racy access, and
>> po-unlock-lock-po;po   is xbstar ; acq-po, which allows closing the gap.
> I could not follow your arguments at all; the writing was too confusing.

Sorry, I collapsed some cases. I'll show an example. I think all the 
other cases are the same.
Let's pick an edge that links two events with ww-vis through
   w-post-bounded ; vis ; w-pre-bounded
where the vis comes from
   cumul-fence* ; rfe? ; [Marked] ;
     (strong-fence ; [Marked] ; xbstar)  <= vis
and the w-pre-bounded came from po-unlock-lock-po;[After-unlock-lock];po 
but not po-unlock-lock-po & int.

Note that such po-unlock-lock-po;[After-unlock-lock];po must come from
   po-rel ; rfe ; acq-po

So we have
   w-post-bounded ;  cumul-fence* ; rfe? ; [Marked] ;
      strong-fence ; [Marked] ; xbstar ; po-rel ; rfe ; acq-po
<=
   w-post-bounded ;  cumul-fence* ; rfe? ; [Marked] ;
      strong-fence ; [Marked] ; xbstar ; hb ; hb ;  acq-po
<=
   w-post-bounded ;  cumul-fence* ; rfe? ; [Marked] ;
      strong-fence ; [Marked] ; xbstar ;                fence
<= ww-vis

All the other cases where w-pre-bounded are used have the shape
     ... ; xbstar ; w-pre-bounded
which can all be handled in the same manner.










