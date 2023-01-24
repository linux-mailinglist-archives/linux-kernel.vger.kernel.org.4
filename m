Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90AA96798A5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 13:55:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbjAXMzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 07:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjAXMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 07:55:41 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40D27289
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 04:55:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P1RYp4fCFz9xqd0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 20:46:54 +0800 (CST)
Received: from [10.48.129.122] (unknown [10.48.129.122])
        by APP1 (Coremail) with SMTP id LxC2BwD3fgr51M9jFLbCAA--.13412S2;
        Tue, 24 Jan 2023 13:54:30 +0100 (CET)
Message-ID: <6f8575f3-f8b9-7738-24f0-5e390b50ac40@huaweicloud.com>
Date:   Tue, 24 Jan 2023 13:54:14 +0100
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
 <c22ec058-b058-0b6e-718b-348ff5cb5004@huaweicloud.com>
 <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
 <1180fe22-5e1d-ec8b-8012-b6578b1ca7c0@huaweicloud.com>
 <Y87tHNcvb5E+t3da@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y87tHNcvb5E+t3da@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwD3fgr51M9jFLbCAA--.13412S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww43ZFW7Aw4ruw4kGw1Utrb_yoW5JFyrpF
        yrta1vqrykJr4v9rnrKw1ft342y3y8tw18Jr4UW3W5A3s8XryS9r10grWY93W5Zrs7Gayq
        yF45Z3W7ZFyDAw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 1/23/2023 9:25 PM, Alan Stern wrote:
> On Mon, Jan 23, 2023 at 07:25:48PM +0100, Jonas Oberhauser wrote:
>> Alright, after some synchronization in the other parts of this thread I am
>> beginning to prepare the next iteration of the patch.
>>
>> On 1/19/2023 4:13 AM, Alan Stern wrote:
>>> On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
>>>> On 1/18/2023 8:52 PM, Alan Stern wrote:
>>>>> On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
>>>>>> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>>>>>> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>>>>>> -		fencerel(After-unlock-lock) ; [M])
>>>>>> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
>>>>> Shouldn't the po case of (co | po) remain intact here?
>>>> You can leave it here, but it is already covered by two other parts: the
>>>> ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
>>>> ppo, and the ordering given through pb is covered by its inclusion in
>>>> strong-order.
>>> What about the ordering given through
>>> A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be
>>> superseded by pb as well, but it seems odd not to have it in hb.
>> How should we resolve this?
>> My current favorite (compromise :D) solution would be to
>> 1. still eliminate both po and co cases from first definition of
>> strong-fence which is used in ppo,
>> 2. define a relation equal to the strong-order in this patch (with po|rf)
> Wouldn't it need to have po|co?  Consider:
>
> 	Wx=1	Rx=1		Ry=1		Rz=1
> 		lock(s)		lock(s)		lock(s)
> 		unlock(s)	unlock(s)	unlock(s)
> 		Wy=1		Wz=1		smp_mb__after_unlock_lock
> 						Rx=0
>
> With the co term this is forbidden.  With only the rf term it is
> allowed, because po-unlock-lock-po isn't A-cumulative.
No, but unlock() is ( 
https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/tree/tools/memory-model/lock.cat?h=dev.2023.01.19a#n67 
). So you get

   Rx=0 ->overwrite Wx=1  ->rfe Rx1 ->po-rel  T1:unlock(s) ->rfe 
T2:lock(s) ->po-unlock-lock-po;after ... fence;po Rx=0
which is
   Rx=0          ->prop ;                           
po-unlock-lock-po;after ... fence;po Rx=0

Are you ok going forward like this then?

If not, I might prefer to redefine po-unlock-lock-po into something that 
works for all its use cases if possible. I think
|

   po ; [UL] ; (po|co?;rf) ; [LKR] ; po

|might be such a definition but haven't fully thought about it.

best wishes, jonas

