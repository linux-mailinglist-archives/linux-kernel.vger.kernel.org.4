Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37B2967E851
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 15:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233202AbjA0OcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 09:32:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbjA0OcN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 09:32:13 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8612283278
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 06:32:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P3KZP1f1tz9v7JD
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 22:23:57 +0800 (CST)
Received: from [10.81.218.251] (unknown [10.81.218.251])
        by APP1 (Coremail) with SMTP id LxC2BwD3dwNA4NNjNCvQAA--.2670S2;
        Fri, 27 Jan 2023 15:31:38 +0100 (CET)
Message-ID: <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
Date:   Fri, 27 Jan 2023 15:31:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/2] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     paulmck@kernel.org, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230126134604.2160-1-jonas.oberhauser@huaweicloud.com>
 <20230126134604.2160-3-jonas.oberhauser@huaweicloud.com>
 <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3dwNA4NNjNCvQAA--.2670S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAFWDArykZry3Zr45XFWfuFg_yoWrtrWkpr
        WfKws3Kayvyrn5uw1UJw1DXFyrCw4rAw1rJF18ua4F93y5Wa929F40gr4j9Fy7GrZ7Jayj
        qr4Yy34kZr4kZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/26/2023 5:36 PM, Alan Stern wrote:
> On Thu, Jan 26, 2023 at 02:46:04PM +0100, Jonas Oberhauser wrote:
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
>> The ppo relation will link P0's spin_lock(x) and P1's *y=1, because
>> P0 passes a lock to P1 which then uses this fence.
>>
>> The patch makes ppo a subrelation of po by eliminating this possibility
>> from mb (but not strong-fence) and relying explicitly on mb|gp instead
>> of strong-fence when defining ppo.
>>
>> Signed-off-by: Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
>> ---
> This changes the meaning of the fence relation, which is used in
> w-pre-bounded, w-post-bounded, ww-vis, wr-vis, and rw-xbstar.  Have you
> checked that they won't be affected by the change?

Good point, in fact it changes the nonrw-fence as well which is used in 
the r-* relations.
I had missed this completely. That's what I get for not looking at the 
data race relations!


Let's go through the individual cases.
If we had e.g. *-post-bounded because of the 
po-unlock-lock-po;[After-unlock-lock];po edge, this may be either due to 
the fence rule or due to (...fence ; vis ; *-pre-bounded).
In the first case we have po-rel ; rfe ; acq-po and get 
fence;rfe;(xbstar&int);fence which gives us *-post-bounded.
In the second case we now have strong-fence, with vis <= xbstar we see 
that **-vis is preserved here by switching from the fence rule to the 
strong-fence;xbstar;... case.

For *-pre-bounded, the situtation is tricky because of the xbstar&int 
that can be at the end of vis, when *-pre-bounded is used to define 
w*-vis through (w-post-bounded;vis;*-pre-bounded). In this case, the 
xbstar&int can point in the opposite direction of po, which means that 
the unlock that creates the strong fence might not be po-after the 
instruction that starts the link.

Here's a litmus test illustrating the difference, where P1 has a 
backwards-pointing xbstar&int. Currently there's no data race, but with 
the proposed patch there is.

P0(int *x, int *y)
{
     *x = 1;
     smp_store_release(y, 1);
}

P1(int *x, int *y, int *dx, int *dy, spinlock_t *l)
{
     spin_lock(l);
     int r1 = READ_ONCE(*dy);
     if (r1==1)
         spin_unlock(l);

     int r0 = smp_load_acquire(y);
     if (r0 == 1) {
         WRITE_ONCE(*dx,1);
     }
}

P2(int *dx, int *dy)
{
     WRITE_ONCE(*dy,READ_ONCE(*dx));
}


P3(int *x, spinlock_t *l)
{
     spin_lock(l);
     smp_mb__after_unlock_lock();
     *x = 2;
}


This actually makes me wonder. I thought the reason for the xbstar & int 
is that it ensures that the overall relation, after shuffling around a 
little bit, becomes prop&int ; hb*.

Like in case the *x=2 is co-before the *x=1, we get
   Wx2 ->overwrite Wx1 ->cumul-fence*;rfe  (some event on the same CPU 
as Wx2)  ->fence Wx2
which is
   Wx2 -> prop&int some other event ->hb Wx2
which must be irreflexive.

However, that's not the case at all, because the fence relation 
currently doesn't actually have to relate events of the same CPU.
So we get
   Wx2 ->overwrite Wx1 ->cumul-fence*;rfe  (some event on some other CPU 
than Wx2's) ->(hb*&int);fence Wx2
i.e.,
   Wx2 ->prop&ext;hb*;strong-fence Wx2

which shouldn't provide any ordering in general.

In fact, replacing the *x=1 and *x=2 with WRITE_ONCEs, (pilot errors 
notwithstanding) both Wx1 ->co Wx2 and Wx2 ->co Wx1 become allowed in 
the current LKMM (in graphs where all other edges are equal).

Shouldn't this actually *be* a data race? And potentially the same with 
rcu-fence?

The other cases of *-pre-bounded seem to work out: they all link stuff 
via xbstar to the instruction that is linked via po-unlock-lock-po ; 
[After-unlock-lock] ; po to the potentially racy access, and 
po-unlock-lock-po;po   is xbstar ; acq-po, which allows closing the gap.

Best wishes, jonas

