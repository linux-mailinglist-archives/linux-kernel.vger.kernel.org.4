Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A0D6798F5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 14:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233533AbjAXNOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 08:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbjAXNOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 08:14:45 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EAF310ABF
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 05:14:42 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4P1S0f6FPLz9v7Yt
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 21:06:42 +0800 (CST)
Received: from [10.48.129.122] (unknown [10.48.129.122])
        by APP1 (Coremail) with SMTP id LxC2BwBn7Qie2c9jCMfCAA--.14182S2;
        Tue, 24 Jan 2023 14:14:18 +0100 (CET)
Message-ID: <1a189694-57b4-81d0-625a-64dd069b1953@huaweicloud.com>
Date:   Tue, 24 Jan 2023 14:14:03 +0100
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
References: <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
 <Y8mirwPeCBWY7tCH@rowland.harvard.edu>
 <d941c33e-27db-8764-3a9e-515dfb481cca@huaweicloud.com>
 <Y8rCBOkM/hY+Z27t@rowland.harvard.edu>
 <2f656643-deef-552e-e489-b7afd0dc777f@huaweicloud.com>
 <Y8xRe1Gr6LNjKD4S@rowland.harvard.edu>
 <41a14c54-8f17-d3ba-fc03-f9af4645881d@huaweicloud.com>
 <Y87D0ekKCHFLjzeP@rowland.harvard.edu>
 <8908438d-da93-b843-f0e0-831ba7070c86@huaweicloud.com>
 <Y873uBB5rAW8tjdd@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y873uBB5rAW8tjdd@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBn7Qie2c9jCMfCAA--.14182S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JFW7uF1ruryfAF1xJFW3Awb_yoW7Xw1xpa
        y3KanFkF1DAr4S9wn2yrnYqryS9w4kAF4rJrn8A39Ykws8Wa1IkF4fKr4YyF9rXrs7Ca1j
        vF45ZF9rZFy5Z3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/23/2023 10:10 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 08:33:42PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/23/2023 6:28 PM, Alan Stern wrote:
>>
>>>
>>> I guess one would have to put
>>>
>>> 	(cumul-fence+ ; [W])?
>>>
>>> or something like it in the definition.
>> I suppose it's true that Y being a load would be an exception, but that
>> would only be if the cumul-fence+ sequence either ends in a strong-fence, or
>> in po-unlock-lock-po.
>>
>> We can ignore the first case (and the ordering would be provided anyways
>> through pb at that point).
>> For the po-unlock-lock-po, you can just take Y:=the LKW event of the unlock
>> and repeat the argument.
> And yet you complained about the reasoning needed to understand that
> (pb ; hb) <= pb!

Eh, I can't help it, my first instinct is always going to be to make 
things shorter :D

> Not to mention the brittleness of this argument; what
> if in the future cumul-fence gets another term ending in a load?

After mulling it over a bit in my big old head, I consider that even 
though dropping the [W] may be shorter, it might make for the simpler 
model by excluding lots of cases.
That makes me think you should do it for real in the definition of prop. 
And not just at the very end, because in fact each cumul-fence link 
might come from a non-A-cumulative fence. So the same argument you are 
giving should be applied recursively.
Either

	prop = (overwrite & ext)? ; (cumul-fence; [W])* ; rfe?

or integrate it directly into cumul-fence.


>> So I don't think the [W] is necessary. (and if it was maybe it would also be
>> necessary in the definition of prop/cumul-fence itself, to account for all
>> the non-A-cumulative fences in there).
>>
>> I think part of my weird feeling comes from this asymmetry between A-cumul()
>> putting the rfe? to the left and prop putting the rfe? to the right. Or more
>> precisely, that the latter is sometimes in anticipation of an A-cumulative
>> fence (where the A-cumul would normally take it to the left of that fence)
>> and sometimes just to express the idea of propagation, and that these are
>> the same, which should somehow lead to a simpler definition but doesn't.
> Well, consider that maybe they aren't the same.  :-)
>
> The definition of prop is a little more complicated than one might
> expect, because the overwrite and cumul-fence parts are both optional.
> Leaving one or both of them out is valid, but it requires a little extra
> thought to see why.
Let's at this point in time not get started on the overwrite part being 
optional :D (see, this is me successfully holding myself back from 
opening another discussion! I can do it!).

>
>>>> I'm not against this partially overlapping kind of redundancy, but I dislike
>>>> subsuming kind of redundancy where some branches of the logic just never
>>>> need to be used.
>>> Consider: Could we remove all propagation-ordering fences from ppo
>>> because they are subsumed by prop?  (Or is that just wrong?)
>> Surely not, since prop doesn't usually provide ordering by itself.
> Sorry, I meant the prop-related non-ppo parts of hb and pb.

I still don't follow :( Can you write some equations to show me what you 
mean?

>>>>> In fact, I wouldn't mind removing the happens-before, propagation, and
>>>>> rcu axioms from LKMM entirely, replacing them with the single
>>>>> executes-before axiom.
>>>> I was planning to propose the same thing, however, I would also propose to
>>>> redefine hb and rb by dropping the hb/pb parts at the end of these
>>>> relations.
>>>>
>>>>    hb = ....
>>>>    pb = prop ; strong-fence ; [Marked]
>>>>    rb = prop ; rcu-fence ; [Marked]
>>>>
>>>>    xb = hb|pb|rb
>>>>    acyclic xb
>>> I'm not so sure that's a good idea.  For instance, it would require the
>>> definitions of rcu-link and rb to be changed from having (hb* ; pb*) to
>>> having (hb | pb)*.
>> I think that's an improvement. It's obvious that (hb | pb)* is right and so
>> is (pb | hb)*.
>> For (hb* ; pb*), the first reaction is "why do all the hb edges need to be
>> before the pb edges?", until one realizes that pb actually allows hb* at the
>> end, so in a sense this is  hb* ; (pb ; hb*)*, and then one has to
>> understand that this means that the prop;strong-fence edges can appear any
>> number of times at arbitrary locations. It just seems like defining (pb |
>> hb)* with extra steps.
> This can be mentioned explicitly as a comment or in explanation.txt.
Ok, but why not just use  (pb|hb)* and (pb|hb|rb)* and not worry about 
having to explain anything?
And make the hb and rb definitions simpler at the same time?

>> The order of nesting seems to be also somewhat a matter of preference,
>> perhaps in some weird alternative universe the LKMM says pb = (prop\id)&int
>> | prop;strong-fence  and hb = (rfe | ppo);pb*. (Personally I think the
>> current way is more reasonable than this one, but that might be because our
>> preferences happen to align in this instance.)
> You can't define hb that way, because the definition of hb appears
> before the definition of pb.  And it has to be this way, because hb is
> used in the definition of pb.
Note that in that alternative universe,

     pb = (prop\id)&int | prop;strong-fence

which doesn't require any definition of hb.

Best wishes,
jonas

