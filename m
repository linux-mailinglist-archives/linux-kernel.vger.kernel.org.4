Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC791673D0E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjASPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:06:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjASPGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:06:22 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05BA87EFA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:06:16 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4NyQjk54d0z9v7c6
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 22:58:18 +0800 (CST)
Received: from [10.81.219.171] (unknown [10.81.219.171])
        by APP1 (Coremail) with SMTP id LxC2BwB3_wpFXMljUWCtAA--.3338S2;
        Thu, 19 Jan 2023 16:05:52 +0100 (CET)
Message-ID: <75c74fe1-a846-aed8-c00c-45deeb1cfdda@huaweicloud.com>
Date:   Thu, 19 Jan 2023 16:05:38 +0100
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
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8i1QNjnZwim5uMq@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwB3_wpFXMljUWCtAA--.3338S2
X-Coremail-Antispam: 1UD129KBjvJXoWxZFW3Zw4kGw43ArW7WrW7urg_yoW5tr4kpF
        W8Kan7Ka1vyrnY9r92ywn8Z342yw1fJry8Jr1DC3W5Aw45W3yIkry0gw4Ygas8Ars2ya98
        ZryrZF9xXrWDZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/2023 4:13 AM, Alan Stern wrote:
> On Wed, Jan 18, 2023 at 10:38:11PM +0100, Jonas Oberhauser wrote:
>>
>> On 1/18/2023 8:52 PM, Alan Stern wrote:
>>> On Tue, Jan 17, 2023 at 08:31:59PM +0100, Jonas Oberhauser wrote:
>>>> -	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M]) |
>>>> -	([M] ; po ; [UL] ; (co | po) ; [LKW] ;
>>>> -		fencerel(After-unlock-lock) ; [M])
>>>> +	([M] ; po? ; [LKW] ; fencerel(After-spinlock) ; [M])
>>> Shouldn't the po case of (co | po) remain intact here?
>> You can leave it here, but it is already covered by two other parts: the
>> ordering given through ppo/hb is covered by the po-unlock-lock-po & int in
>> ppo, and the ordering given through pb is covered by its inclusion in
>> strong-order.
> What about the ordering given through
> A-cumul(strong-fence)/cumul-fence/prop/hb?  I suppose that might be
> superseded by pb as well,
Indeed, in fact all of A-cumul(strong-fence) is already covered through pb.
> but it seems odd not to have it in hb.
> In general, the idea in the memory model is that hb ordering relies on
> the non-strong properties of fences, whereas pb relies on the properties
> of strong fences, and rb relies on the properties of the RCU fences.

I agree in the sense that all strong-ordering operations are 
A-cumulative and not including them in A-cumul is weird.
On the other side  the model becomes a tiny bit smaller and simpler when 
all ordering of prop;strong-ordering goes through a single place (pb).

If you want, you could think of the A-cumulativity of strong ordering 
operations as being a consequence of their strong properties. 
Mathematically it already is the case, since
   overwrite&ext ; cumul-fence* ; rfe ; strong-fence ; cumul-fence* ; rfe?
is a subset of
   prop ; strong-fence ; hb*



>>>> @@ -91,8 +89,12 @@ acyclic hb as happens-before
>>>>    (* Write and fence propagation ordering *)
>>>>    (****************************************)
>>>> -(* Propagation: Each non-rf link needs a strong fence. *)
>>>> -let pb = prop ; strong-fence ; hb* ; [Marked]
>>>> +(* Strong ordering operations *)
>>>> +let strong-order = strong-fence | ([M] ; po-unlock-lock-po ;
>>>> +		[After-unlock-lock] ; po ; [M])
>>> This is not the same as the definition removed above.  In particular,
>>> po-unlock-lock-po only allows one step along the locking chain -- it has
>>> rf where the definition above has co.
>> Indeed it is not, but the subsequent lock-unlock sequences are in hb*. For
>> this reason it can be simplified to just consider the directly following
>> unlock().
> I'm not sure that argument is right.  The smp_mb__after_unlock_lock
> needs to go after the _last_ lock in the sequence, not after the first.
> So you don't have to worry about subsequent lock-unlock sequences; you
> have to worry about preceding lock-unlock sequences.

I formalized a proof of equivalence in Coq a few months ago, but I was 
recalling the argument incorrectly from memory.
I think the correct argument is that the previous po-unlock-lock-po form 
a cumul-fence*;rfe;po sequence that starts with a po-rel.
so any
     prop; .... ; co ; ... ; this fence ;...
can be rewritten to
     prop; cumul_fence* ; po-unlock-lock-po ; this fence ;...
and because the the first cumul-fence here needs to start with 
po-release, the prop ;cumul-fence* can be merged into a larger prop, leaving
     prop; po-unlock-lock-po ; this fence ;...

Best wishes,
jonas

