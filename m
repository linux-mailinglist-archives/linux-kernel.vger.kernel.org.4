Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DCC6A44CA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 15:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230149AbjB0Ojw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 09:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjB0Oju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 09:39:50 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87C101E9D2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 06:39:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PQNFr56Lcz9v7Hb
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 22:30:40 +0800 (CST)
Received: from [10.45.159.185] (unknown [10.45.159.185])
        by APP2 (Coremail) with SMTP id GxC2BwA3BVyNwPxjYN1WAQ--.3696S2;
        Mon, 27 Feb 2023 15:39:20 +0100 (CET)
Message-ID: <a5f1695d-cc1f-04aa-fe61-f2b8687cfb0e@huaweicloud.com>
Date:   Mon, 27 Feb 2023 15:39:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/uHjpbJ3JmVAe9d@google.com>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y/uHjpbJ3JmVAe9d@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwA3BVyNwPxjYN1WAQ--.3696S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw18XrW3Jr4fWryUKF47twb_yoWrXw1xpr
        ZxGayfKa1DtryvvrykXws8ZFy5uw4rWrW8JFy5Ga4rZw13ZrnxXFy8KF4rZry7JFZ2kayj
        vr4j9Fyqy3yDAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2023 5:23 PM, Joel Fernandes wrote:
> On Fri, Feb 24, 2023 at 02:52:51PM +0100, Jonas Oberhauser wrote:
>> As stated in the documentation and implied by its name, the ppo
>> (preserved program order) relation is intended to link po-earlier
>> to po-later instructions under certain conditions.  However, a
>> corner case currently allows instructions to be linked by ppo that
>> are not executed by the same thread, i.e., instructions are being
>> linked that have no po relation.
>>
>> This happens due to the mb/strong-fence/fence relations, which (as
>> one case) provide order when locks are passed between threads
>> followed by an smp_mb__after_unlock_lock() fence.  This is
>> illustrated in the following litmus test (as can be seen when using
>> herd7 with `doshow ppo`):
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
>> The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
>> P0 passes a lock to P1 which then uses this fence.
>>
>> The patch makes ppo a subrelation of po by letting fence contribute
>> to ppo only in case the fence links events of the same thread.
>>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> ---
>>   tools/memory-model/linux-kernel.cat | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
>> index cfc1b8fd46da..adf3c4f41229 100644
>> --- a/tools/memory-model/linux-kernel.cat
>> +++ b/tools/memory-model/linux-kernel.cat
>> @@ -82,7 +82,7 @@ let rwdep = (dep | ctrl) ; [W]
>>   let overwrite = co | fr
>>   let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>>   let to-r = (addr ; [R]) | (dep ; [Marked] ; rfi)
>> -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
>> +let ppo = to-r | to-w | (fence & int) | (po-unlock-lock-po & int)
> Alternatively can be the following appended diff? Requires only single 'int'
> in ->ppo then and prevents future similar issues caused by sub relations.
> Also makes clear that ->ppo can only be CPU-internal.

I had thought about going in that direction, but it doesn't prevent 
future similar issues, at best makes them less likely.
For example, you could have an xfence that somehow goes back to the 
original thread, but to a po-earlier event (e.g., like prop).

Given that to-r and to-w are unlikely to ever become become inconsistent 
with po, I am not sure it even really helps much.

Personally I'm not too happy with the ad-hoc '& int' because it's like 
adding some unused stuff (via ... | unused-stuff) and then cutting it 
back out with &int, unlike prop & int which has a real semantic meaning 
(propagate back to the thread). The fastest move is the move we avoid 
doing, so I rather wouldn't add those parts in the first place.

However fixing the fence relation turned out to be a lot trickier, both 
because of the missed data race and also rmw-sequences, essentially I 
would have had to disambiguate between xfences and fences already in 
this patch. So I did this minimal local fix for now and we can discuss 
whether it makes sense to get rid of the '& int' once/if we have xfence etc.

Best wishes,
jonas

PS:
> ---8<-----------------------

haha that's so clever :D

>
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index 07f884f9b2bf..63052d1628e9 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -70,7 +70,7 @@ let rwdep = (dep | ctrl) ; [W]
>   let overwrite = co | fr
>   let to-w = rwdep | (overwrite & int) | (addr ; [Plain] ; wmb)
>   let to-r = addr | (dep ; [Marked] ; rfi)
> -let ppo = to-r | to-w | fence | (po-unlock-lock-po & int)
> +let ppo = (to-r | to-w | fence | po-unlock-lock-po) & int
>   
>   (* Propagation: Ordering from release operations and strong fences. *)
>   let A-cumul(r) = (rfe ; [Marked])? ; r

