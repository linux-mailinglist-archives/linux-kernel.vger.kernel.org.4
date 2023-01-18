Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F19672B05
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbjARWD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbjARWDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:03:24 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55086646B7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:03:19 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4Ny01R0gmBz9v7P2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 05:55:23 +0800 (CST)
Received: from [10.48.135.81] (unknown [10.48.135.81])
        by APP2 (Coremail) with SMTP id GxC2BwC3hl2EbMhjj6qoAA--.1278S2;
        Wed, 18 Jan 2023 23:02:55 +0100 (CET)
Message-ID: <4a917e54-d029-9341-aef4-a447746b7743@huaweicloud.com>
Date:   Wed, 18 Jan 2023 23:02:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] tools/memory-model: Make ppo a subrelation of po
To:     Andrea Parri <parri.andrea@gmail.com>
Cc:     paulmck@kernel.org, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        akiyks@gmail.com, dlustig@nvidia.com, joel@joelfernandes.org,
        urezki@gmail.com, quic_neeraju@quicinc.com, frederic@kernel.org,
        linux-kernel@vger.kernel.org
References: <20230117193159.22816-1-jonas.oberhauser@huaweicloud.com>
 <Y8hk6JrUXei6ZInI@andrea>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y8hk6JrUXei6ZInI@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwC3hl2EbMhjj6qoAA--.1278S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4UurWDKFW3Jry5tF1xAFb_yoWrZr1fpF
        W8taySgw4kJFn5Wwn7AayDZryFkws3Ja1UJFyDWwn5Cwn8Jr1I9Fnrta15ZFW8Grs5C3Wj
        vr4av3WkX34DCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
        e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
        Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a
        6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
        kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
        67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU13rcDUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing the documentation.
You made me realize that the patch is already doing two things -- trying 
to fix the incorrectness of the documentation where it claims that 
fences like strong-fence only relate po-earlier to po-later events, and 
trying to make ppo a subrelation of po.

Perhaps it would be better to do this in two steps. First like you 
suggest only do the ppo fix, and then in a second step (after agreeing 
with Alan on terminology) fix the documentation in a unified way 
(instead of only for strong-fence like in this patch).
Of course you're free to re-state your disagreement about such a change 
then :D

Either way, the specific comments are helpful.

On 1/18/2023 10:30 PM, Andrea Parri wrote:

>> +	Whenever any CPU C' executes an unlock operation U such that
>> +	CPU C executes a lock operation L followed by a po-later
>> +	smp_mb__after_unlock_lock() fence, and L is either a later lock
>> +	operation on the lock released by U or is po-after U, then any
>> +	store that propagates to C' before U must propagate to all other
>> +	CPUs before any instructions po-after the fence are executed on C.
> The barrier is never mentioned in this document.  This is a relatively
> oddball/rare barrier.  Also, IMO, this description doesn't add much to
> the notions of execution and propagation being introduced.  I'd rather
> move it (or parts of it) to ODDS AND ENDS where smp_mb__after_spinlock()
> and other smp_mb__*() are currently briefly described.

I understand your concern.
However, I think the extended strong-order relation needs to be 
mentioned for defining pb. Having a strong ordering operation at this 
point of the manual also helps introducing rcu-fence later which works 
similarly.
I'm hoping if we can make a single renaming patch, we can essentially 
kill most of the explanation of how rcu-fence links events by different 
threads by just pointing to how strong-order is doing the same thing.


>> +While smp_wmb() and release fences only force certain earlier stores
>> +to propagate to another CPU C' before certain later stores propagate
>> +to the same CPU C',
> If "earlier" means po-earlier, this statement is wrong, cf. the comment
> about A-cumulativity.  IAC, it should be clarified.
Indeed I don't mean po-earlier, and agree it should be clarified.
But I'm not sure yet how to clarify "earlier" and "later" considering 
that the precise definition of earlier and later depends on the barrier.

>
>
>> strong fences and smp_mb__after_unlock_lock()
>> +force those stores to propagate to all other CPUs before any later
>> +instruction is executed.  We collectively refer to the latter
>> +operations as strong ordering operations, as they provide much
>> +stronger ordering in two ways:
>> +
>> +	Firstly, strong ordering operations also create order between
>> +	earlier stores and later reads.
> Switching back to "execution order" I guess; need clarification.
>
(Same as above)
>> +
>> +	Secondly, strong ordering operations create a form of global
>> +	ordering: When an earlier store W propagates to CPU C and is
>> +	ordered by a strong ordering operation with a store W' of C,
>> +	and another CPU C' observes W' and in response issues yet
>> +	another store W'', then W'' also can not propagate to any CPU
>> +	before W.  By contrast, a release fence or smp_wmb() would only
>> +	order W and W', but not force any ordering between W and W''.
>> +	To summarize, the ordering forced by strong ordering operations
>> +	extends to later stores of all CPUs, while other fences only
>> +	force ordering with relation to stores on the CPU that executes
>> +	the fence.
>> +
>> +The propagation ordering enforced by release fences and strong ordering
>> +operations affects stores from other CPUs that propagate to CPU C before
>> +the fence is executed, as well as stores that are executed on C before
>> +the fence.  We describe this property by saying that release fences and
>> +strong ordering operations are A-cumulative.  By contrast, smp_wmb()
>> +fences are not A-cumulative; they only affect the propagation of stores
>> +that are executed on C before the fence (i.e., those which precede the
>> +fence in program order).
> [lots of renaming unless I missed something]

The second paragraph is just renaming, but the first part is new.

Best wishes and let me know if you agree on rearranging the submission 
like that,
jonas

