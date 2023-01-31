Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00636682E82
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbjAaN4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:56:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjAaN4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:56:40 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FB14B1B8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 05:56:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P5mbc0vZYz9v7gm
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 21:48:28 +0800 (CST)
Received: from [10.45.157.21] (unknown [10.45.157.21])
        by APP2 (Coremail) with SMTP id GxC2BwD3zGPzHdljyi3fAA--.48937S2;
        Tue, 31 Jan 2023 14:56:14 +0100 (CET)
Message-ID: <001f7d74-0ef9-a667-b656-bbd18491d5c1@huaweicloud.com>
Date:   Tue, 31 Jan 2023 14:56:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Andrea Parri <parri.andrea@gmail.com>, paulmck@kernel.org,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu> <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
 <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwD3zGPzHdljyi3fAA--.48937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43Xr1kAF1UArWrtrWUArb_yoW5tw1rpF
        Z5tFWrKFn5Ar9Yvw1xXwn8XFySyryFyF45GFnYqrWrC398GryF9r1UtayY9Fy7Cr4kWa1U
        Z3yjyFn7Ga4DCaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/30/2023 3:39 AM, Alan Stern wrote:
> On Sun, Jan 29, 2023 at 11:19:32PM +0100, Jonas Oberhauser wrote:
>> You could do it, by turning the relation into one massive recursive
>> definition.
> Which would make pretty much the entire memory model one big recursion.
> I do not want to do that.

Neither do I :D

>
>> Thinking about what the options are:
>> 1) accept the difference and run with it by making it consistent inside the
>> axiomatic model
>> 2) fix it through the recursive definition, which seems to be quite ugly but
>> also consistent with the power operational model as far as I can tell
>> 3) weaken the operational model... somehow
>> 4) just ignore the anomaly
>> 5) ???
>>
>> Currently my least favorite option is 4) since it seems a bit off that the
>> reasoning applies in one specific case of LKMM, more specifically the data
>> race definition which should be equivalent to "the order of the two races
>> isn't fixed", but here the order isn't fixed but it's a data race.
>> I think the patch happens to almost do 1) because the xbstar&int at the end
>> should already imply ordering through the prop&int <= hb rule.
>> What would remain is to also exclude rcu-fence somehow.
> IMO 1) is the best choice.

I have some additional thoughts now. It seems that you could weaken the 
operational model by stating that an A-cumulative fence orders 
propagation of all *external* stores (in addition to all po-earlier 
stores) that propagated to you before the fence is executed.

It seems that on power, from an operational model perspective, there's 
currently no difference between propagation fences ordering all stores 
vs only external stores that propagated to the CPU before the fence is 
executed, because they only have bidirectional (*->W) fences (sync, 
lwsync) and not uni-directional (acquire, release), and so it is not 
possible for a store that is po-later than the barrier to be executed 
before the barrier; i.e., on power, every internal store that propagates 
to a CPU before the fence executes is also po-earler than the fence.

If power did introduce release stores, I think you could potentially 
create implementations that allow the behavior in the example you have 
given, but I don't think they are the most natural ones:

> {}
>
> P0(int *x, int *y, int *z)
> {
> 	int r1;
>
> 	r1 = READ_ONCE(*x);
> 	smp_store_release(y, 1);
> 	WRITE_ONCE(*z, 1);
> }
>
> P1(int *x, int *y, int *z)
> {
> 	int r2;
>
> 	r2 = READ_ONCE(*z);
> 	WRITE_ONCE(*x, r2);
> }
>
> P2(int *x, int *y, int *z)
> {
> 	int r3;
> 	int r4;
>
> 	r3 = READ_ONCE(*y);
> 	smp_rmb();
> 	r4 = READ_ONCE(*z);
> }
>
> exists (0:r1=1 /\ 2:r3=1 /\ 2:r4=0)

I could imagine that P0 posts both of its stores in a shared store 
buffer before reading *x, but marks the release store as "not ready".
Then P1 forwards *z=1 from the store buffer and posts *x=1, which P0 
reads, and subsequently marks its release store as "ready".
Then the release store is sent to the cache, where P2 reads *y=1 and 
then *z=0.
Finally P0 sends its *z=1 store to the cache.

However, a perhaps more natural implementation would not post the 
release store to the store buffer until it is "ready", in which case the 
order in the store buffer would be *z=1 before *y=1, and in this case 
the release ordering would presumably work like your current operational 
model.

Nevertheless, perhaps this slightly weaker operational model isn't as 
absurd as it sounds. And I think many people wouldn't be shocked if the 
release store didn't provide ordering with *z=1.

Best wishes, jonas

