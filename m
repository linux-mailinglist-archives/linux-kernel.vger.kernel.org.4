Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD09D66E63F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 19:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235219AbjAQSkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 13:40:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjAQSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 13:34:25 -0500
X-Greylist: delayed 1084 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 17 Jan 2023 10:06:58 PST
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331BE53FB7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 10:06:37 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4NxGQL0jzZz9v7H1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 01:40:58 +0800 (CST)
Received: from [10.81.216.132] (unknown [10.81.216.132])
        by APP2 (Coremail) with SMTP id GxC2BwBXKF9e38ZjtbCjAA--.64797S2;
        Tue, 17 Jan 2023 18:48:26 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------HU0gedSp0p4IhSekddJSECt9"
Message-ID: <804a70fb-2028-a2d8-440e-347ee018c093@huaweicloud.com>
Date:   Tue, 17 Jan 2023 18:48:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: Internal vs. external barriers (was: Re: Interesting LKMM litmus
 test)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "parri.andrea" <parri.andrea@gmail.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>, npiggin <npiggin@gmail.com>,
        dhowells <dhowells@redhat.com>,
        "j.alglave" <j.alglave@ucl.ac.uk>,
        "luc.maranget" <luc.maranget@inria.fr>, akiyks <akiyks@gmail.com>,
        dlustig <dlustig@nvidia.com>, joel <joel@joelfernandes.org>,
        urezki <urezki@gmail.com>,
        quic_neeraju <quic_neeraju@quicinc.com>,
        frederic <frederic@kernel.org>,
        Kernel development list <linux-kernel@vger.kernel.org>
References: <20220921173109.GA1214281@paulmck-ThinkPad-P17-Gen-1>
 <YytfFiMT2Xsdwowf@rowland.harvard.edu>
 <YywXuzZ/922LHfjI@hirez.programming.kicks-ass.net>
 <114ECED5-FED1-4361-94F7-8D9BC02449B7> <Y77rgeg+UgozV/oF@rowland.harvard.edu>
 <07579baee4b84532a76ea8b0b33052bb@huawei.com>
 <20230112215716.GS4028633@paulmck-ThinkPad-P17-Gen-1>
 <e51c82a113484b6bb62354a49376f248@huawei.com>
 <Y8LbeLflWLyivOz9@rowland.harvard.edu>
In-Reply-To: <Y8LbeLflWLyivOz9@rowland.harvard.edu>
X-CM-TRANSID: GxC2BwBXKF9e38ZjtbCjAA--.64797S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Kry5WF18Zw4ftrW8Gr47XFb_yoWDtrW8pF
        W8KF95KryDJr48uwnrJr1UXryUAw1UJw45tryrtFyUAw15Jr1jvr4jqr4Y9F15Grs7JF1j
        vr4DtFnrZw1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21le4C267I2x7xF54xIwI1l5I8C
        rVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxV
        WUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFcxC0VAYjxAxZF0Ex2Iq
        xwACI402YVCY1x02628vn2kIc2xKxwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7V
        AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8C
        rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
        CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x02
        67AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI
        0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8Jr1l6VACY4xI67k04243AbIYCTnI
        WIevJa73UjIFyTuYvjxUw89NDUUUU
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------HU0gedSp0p4IhSekddJSECt9
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


[I set up my huaweicloud.com address to send and receive mail, allegedly 
huaweicloud.com has fewer problems. Let's see. Also snipping together 
some mails that were sent to me in the meantime.]

On 1/14/2023 5:42 PM, Alan Stern wrote:
>
> On Fri, Jan 13, 2023 at 02:55:34PM +0000, Jonas Oberhauser wrote:
>>
>> I think the whole rcu-order topic can be summarized as the 'one 
>> rule': "if a grace period happens before a rcsc-unlock, it must also 
>> happen before the rcsc -lock, and analogously if rcsc-lock happens 
>> before a grace period, the rcsc-unlock also happens before the grace 
>> period" .
>
> There is more to it than that, as I mentioned earlier. A complete 
> description can be found the explanation.txt document; it says: For 
> any critical section C and any grace period G, at least one of the 
> following statements must hold: (1) C ends before G does, and in 
> addition, every store that propagates to C's CPU before the end of C 
> must propagate to every CPU before G ends. (2) G starts before C does, 
> and in addition, every store that propagates to G's CPU before the 
> start of G must propagate to every CPU before C starts.

Yes, this difference took me a while to appreciate. If there was only (a 
strict interpretation of) the rule I mentioned, then the RCU axioms 
could be stated as just a regular atomicity axiom.

But because it also affects the surrounding operations, the recursion 
becomes necessary.


>
>
>>>
>>> IMO it's generally better to think of grace periods as not being 
>>> instantaneous but as occurring over a prolonged period of time. Thus 
>>> we should say: If a grace period ends before an unlock occurs, it 
>>> must start before the corresponding lock. And contrapositively, if a 
>>> lock occurs before a grace period starts, the corresponding unlock 
>>> must occur before the grace period ends.
>>
>> I started thinking about it like this and comparing start/end times. 
>> That made it more complicated, but the math came out the same in the 
>> end. I could imagine that there are some scenarios where the 
>> intuition of collapsing the grace period to a single event could 
>> cause problems, but I haven't seen any.
>
>
>
> IIRC (and it has been a long time), this may be vaguely connected with 
> the reason why the definitions of gp, rcu-link, and rcu-fence have po 
> one side but po? on the other.  But I can't remember the details.



There's at least some connection. And I think from an operational model 
perspective, the distinction has some effect.

That's because part (1) of the rule you quoted forces propagation before 
G ends, which allows propagation to G's CPU after the start or before 
the end.

Stores propagated in that time period are not forced to propagate by 
part (2).

If the two events in the operational model were merged, then all stores 
that need to propagate to G's CPU through rule (1) would also need to 
propagate to other CPU's through part (2).

In particular, if we had an execution with 3 CPUs like below (time from 
top to bottom, also attached as a text file in case my e-mail client 
messes up the formatting)

CPU1             | CPU2           | CPU3
start CS;        |                |
read stage==0    |                |
                  | stage = 1;     |
                  |                |
                  | GP {           |
x = 1;           |                |
                  |                | start CS;
                  |                | read x == 0;
end CS;          |                |
                  | }              |
                  | stage = 2;     |
                  |                | read stage == 2;
                  |                | read x == 1;
                  |                | end CS;

then we allow x=1 not to propagate to the third CPU before it reads x. 
But if there was only a single grace period step, which would not 
overlap with either CS, then this outcome would be forbidden.
Because stage=1 didn't propagate to CPU1, the grace period would need to 
be after CPU1's critical section.
Because stage=2 did propagate to CPU3, the grace period would need to be 
before CPU3's critical section.
But then x=1 would need to propagate to CPU3 before the grace period, 
and thus before its CS starts.

I think it's because things can't happen "at the same time" in the 
operational model. Otherwise, x=1 could propagate "at the same time" as 
it executes the grace period, and then wouldn't be affected by rule (2) 
anymore.

But in the axiomatic model, we can use the po; ... to state that things 
must happen "strictly before" the start of G (instead of "kinda at the 
same time"). If there is a po-earlier event that observes the 
propagation, then the propagation happened before the start of G. If 
there is no po-earlier event that observes the propagation, then the 
store may as well have propagated at the same time as G (or "between the 
start and end"). So having the distinction of start and end of grace 
periods becomes at least less important.

I still haven't wrapped my head fully around why the other side has to 
be po?.

I asked Hernan to run all the old litmus tests with rcu-fence = po ; 
rcu-order ; po and he reported no difference in those tests either.

Now I'm thinking if it can be proven that some of them aren't necessary, 
or could be simplified.

Pretending for simplicity that rscs and grace periods aren't 
reads&writes (and that prop must always start with overwrite&ext, but 
this can be done wlog if we define the rcu relations with prop? instead 
of prop).

I'm first looking at the rcu-link relation.
Any use of rcu-link in rcu-order is preceded by an rscs or gp. 
Considering the cases where po? is not taken, the first edge of 
hb*;pb*;prop? can't be any of prop, rfe, or prop&int because the 
rcu-order never ends in write/reads. This leaves only ppo (or nothing), 
and we can use ppo <= po (with the patch that's currently lying on my 
hard disk :D) to get that he complete edge a subset of

(po ; hb*;pb*;prop? | id);po

Therefore I think we have rcu-link = (po ; hb*;pb*;prop? ; po) | po

Next, I look at rcu-fence in rb = prop? ; rcu-fence ; hb* ; pb*.
An rcu-fence ; hb* ; pb* which doesn't have the po at the end of 
rcu-fence can not have prop, rfe, or prop&int after the rcu-fence 
either. This leaves two cases, either the rb comes from prop? ; po ; 
rcu-order or from prop? ; po ; rcu-order ; ppo ; hb* ; pb*.

In the latter case we can use ppo <= po and get back  prop? ; po ; 
rcu-order ; po ; hb* ; pb, so considering po? here is not necessary.

In the former case, we can ask instead if po ; rcu-order ; prop? is 
irreflexive, and since prop can't follow on rcu-order, this is the same 
as po ; rcu-order.

This can only have an identity edge if at least some of the rcu-links in 
rcu-order are not just po. So let's look at the last such edge, when 
abbreviating RCU cs and grace periods as R we get

   po; (R ; rcu-link)* ; R ; po ; hb*;pb*;prop? ; (po ; R)+

where overall the number of gps >= number of rscs, and this can be 
rewritten as

   prop? ; (po ; R)+; po; (rcu-order ; rcu-link)? ; R ; po ; hb*;pb*

and I believe (po ; R)+; po; (R ; rcu-link)* ; R ; po  <= po ; rcu-order 
; po (using the fact that overall the number of gps is still >= the 
number of rscs)

so then it simplifies again to

   prop? ; po ; rcu-order ; po ; hb*;pb*

and po? is again not necessary.

I'm again ignoring srcu here. I don't know if we can still shuffle the 
gp/rscs around like above when the locations have to match.

Either way if you can confirm my suspicion that the po? in rcu-fence 
could be replaced by po, and that the po? in rcu-link could be replaced 
by (po ; ... ; po) | po, or have a counter example and some additional 
explanation for why the po? makes sense, I'd be thankful.


> There was also something about what should happen when you have two 
> grace periods in a row. 

Note that two grace periods in a row are a subset of po;rcu-gp;po and 
thus gp, and so there's nothing to be done.
Something more interesting happens with critical sections, where 
currently po ; rcu-rcsci ; po ; rcu-rcsci ; po should be a subset of po 
; rcu-rcsci ; po  because of the forbidden partial overlap. But I 
currently don't think it's necessary to consider such cases.

The other thing that causes complications is when all the pb*,hb*,and 
prop links in rcu-link are just id, and then rcu-link becomes po?;po = 
po. Currently I don't understand why such pure po links should be 
necessary at all, since they should just merge with the neighboring 
rcu-gps into a gp edge.

>>
>> The only way I'd count rcu-link' as adding a case is if you say that 
>> the (...)* has two cases :D (or infinitely many :D) I don't count the 
>> existence of the definition because you could always inline it (but 
>> lose a lot of clarity imho).
>
>
>
> If you did inline it, you'd probably find that the end result was 
> exactly what is currently in the LKMM.

Not quite. There are two differences. The first is that the 
rcu-order;rcu-link;rcu-order case disappears.

The second is that the ...;rcu-link;... and 
...;rcu-link;rcu-order;rcu-link;... subcases get merged, and not to 
...;rcu-link;(rcu-order;rcu-link)?;... but to 
...;rcu-link;(rcu-order;rcu-link)*;...

Indeed the definitions of rcu-extend and rcu-order can't become exactly 
the same because they are different relations, e.g., rcu-order can begin 
and end with a grace period but rcu-extend can't.

That's why an additional non-recursive layer of

    rcu-order = rcu-extend ; (rcu-link; rcu-extend)*

is necessary to define rcu-order in terms of rcu-extend. But as I 
mentioned I don't think rcu-order is necessary at all to define LKMM, 
and one can probably just use rcu-extend instead of rcu-order (and in 
fact even a version of rcu-extend without any lone rcu-gps).

>
>>
>> the law is, well, um, "primarily empirical in nature"
>
>
>
> Actually it isn't, not any more. That quote was written before we 
> formalized RCU in the LKMM.

I meant that the original formulation was empirical; of course you have 
formalized it, but how do you know that the formalization is valid? I 
think the correspondence with "what's intended" is always an empirical 
thing, even if you formally prove the correctness of the imlementation 
against the specification you might have missed some parts or added some 
parts that are actually just implementation details.

best wishes,

jonas
--------------HU0gedSp0p4IhSekddJSECt9
Content-Type: text/plain; charset=UTF-8; name="gp-case.txt"
Content-Disposition: attachment; filename="gp-case.txt"
Content-Transfer-Encoding: base64

Q1BVMSAgICAgICAgICAgICB8IENQVTIgICAgICAgICAgIHwgQ1BVMw0Kc3RhcnQgQ1M7ICAg
ICAgICB8ICAgICAgICAgICAgICAgIHwNCnJlYWQgc3RhZ2U9PTAgICAgfCAgICAgICAgICAg
ICAgICB8DQogICAgICAgICAgICAgICAgIHwgc3RhZ2UgPSAxOyAgICAgfA0KICAgICAgICAg
ICAgICAgICB8ICAgICAgICAgICAgICAgIHwNCiAgICAgICAgICAgICAgICAgfCBHUCB7ICAg
ICAgICAgICB8DQp4ID0gMTsgICAgICAgICAgIHwgICAgICAgICAgICAgICAgfA0KICAgICAg
ICAgICAgICAgICB8ICAgICAgICAgICAgICAgIHwgc3RhcnQgQ1M7DQogICAgICAgICAgICAg
ICAgIHwgICAgICAgICAgICAgICAgfCByZWFkIHggPT0gMDsNCmVuZCBDUzsgICAgICAgICAg
fCAgICAgICAgICAgICAgICB8DQogICAgICAgICAgICAgICAgIHwgfSAgICAgICAgICAgICAg
fA0KICAgICAgICAgICAgICAgICB8IHN0YWdlID0gMjsgICAgIHwNCiAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICB8IHJlYWQgc3RhZ2UgPT0gMjsNCiAgICAgICAgICAgICAg
ICAgfCAgICAgICAgICAgICAgICB8IHJlYWQgeCA9PSAxOw0KICAgICAgICAgICAgICAgICB8
ICAgICAgICAgICAgICAgIHwgZW5kIENTOw0K

--------------HU0gedSp0p4IhSekddJSECt9--

