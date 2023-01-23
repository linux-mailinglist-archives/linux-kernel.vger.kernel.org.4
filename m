Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F40696784DF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 19:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAWS2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 13:28:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbjAWS2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 13:28:18 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8726EB7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 10:27:38 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4P0yym23tgz9xGX4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 02:18:24 +0800 (CST)
Received: from [10.81.216.232] (unknown [10.81.216.232])
        by APP2 (Coremail) with SMTP id GxC2BwBXKF8w0c5jQna9AA--.11766S2;
        Mon, 23 Jan 2023 19:26:05 +0100 (CET)
Message-ID: <1180fe22-5e1d-ec8b-8012-b6578b1ca7c0@huaweicloud.com>
Date:   Mon, 23 Jan 2023 19:25:48 +0100
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
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwBXKF8w0c5jQna9AA--.11766S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1UWw1UArW8Gr43Kr15Arb_yoW8AFWUpF
        yFya1kKr4vy3Wv9FnFkr4Fqw1Iyw1IyryrJr4kuwn0v3y5Xa9xur1IqrWY9Fn8Zrn7Ca1q
        vr1Yva45XFyDZ3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Alright, after some synchronization in the other parts of this thread I 
am beginning to prepare the next iteration of the patch.

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
> superseded by pb as well, but it seems odd not to have it in hb.

How should we resolve this?
My current favorite (compromise :D) solution would be to
1. still eliminate both po and co cases from first definition of 
strong-fence which is used in ppo,
2. define a relation equal to the strong-order in this patch (with 
po|rf) but call it strong-fence for now (in response to Andrea's valid 
criticism that this patch is doing maybe more than just fix ppo)
3. use the extended strong-fence in the definition of cumul-fence and pb

So I'd still simplify po|co to po|rf and drop the po case from ppo, but 
return both of those cases in cumul-fence, to be consistent with the 
idea that cumul-fence should deal with the weak properties of the fences 
including this after-unlock-lock fence.


Would that be acceptable?
jonas

