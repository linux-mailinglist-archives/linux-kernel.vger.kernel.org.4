Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C450F6A2F4A
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbjBZLSR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 06:18:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjBZLSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 06:18:13 -0500
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B344159D0
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 03:18:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4PPgrH0KdSz9v7ZX
        for <linux-kernel@vger.kernel.org>; Sun, 26 Feb 2023 19:09:35 +0800 (CST)
Received: from [10.45.157.166] (unknown [10.45.157.166])
        by APP2 (Coremail) with SMTP id GxC2BwDHk1rPP_tjRNZRAQ--.1420S2;
        Sun, 26 Feb 2023 12:17:46 +0100 (CET)
Message-ID: <a862ee59-ca12-b609-48cc-0784c7ce24af@huaweicloud.com>
Date:   Sun, 26 Feb 2023 12:17:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Alan Stern <stern@rowland.harvard.edu>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu> <Y/rNUfW509AQYCYn@boqun-archlinux>
 <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y/rSQ2FNTJyj2bqR@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: GxC2BwDHk1rPP_tjRNZRAQ--.1420S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar43XF1fXrWrKF1UAF13urg_yoW8KF15pr
        9IqFy5KF4DJwsayw4vvw4I9FZIyrW8GFs8XrnYgryFy398WF1Y9a10gF15uF9rWr9Yq34j
        yrW8A3srAas8ZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/26/2023 4:30 AM, Alan Stern wrote:
> On Sat, Feb 25, 2023 at 07:09:05PM -0800, Boqun Feng wrote:
>> On Sat, Feb 25, 2023 at 09:29:51PM -0500, Alan Stern wrote:
>>> On Sat, Feb 25, 2023 at 05:01:10PM -0800, Paul E. McKenney wrote:
>>>> A few other oddities:
>>>>
>>>> litmus/auto/C-LB-Lww+R-OC.litmus
>>>>
>>>> 	Both versions flag a data race, which I am not seeing.	It appears
>>>> 	to me that P1's store to u0 cannot happen unless P0's store
>>>> 	has completed.  So what am I missing here?
>>> The LKMM doesn't believe that a control or data dependency orders a
>>> plain write after a marked read.  Hence in this test it thinks that P1's
>>> store to u0 can happen before the load of x1.  I don't remember why we
>>> did it this way -- probably we just wanted to minimize the restrictions
>>> on when plain accesses can execute.  (I do remember the reason for
>>> making address dependencies induce order; it was so RCU would work.)
>>>
>> Because plain store can be optimzed as an "store only if not equal"?
>> As the following sentenses in the explanations.txt:
>>
>> 	The need to distinguish between r- and w-bounding raises yet another
>> 	issue.  When the source code contains a plain store, the compiler is
>> 	allowed to put plain loads of the same location into the object code.
>> 	For example, given the source code:
>>
>> 		x = 1;
>>
>> 	the compiler is theoretically allowed to generate object code that
>> 	looks like:
>>
>> 		if (x != 1)
>> 			x = 1;
>>
>> 	thereby adding a load (and possibly replacing the store entirely).
>> 	For this reason, whenever the LKMM requires a plain store to be
>> 	w-pre-bounded or w-post-bounded by a marked access, it also requires
>> 	the store to be r-pre-bounded or r-post-bounded, so as to handle cases
>> 	where the compiler adds a load.
> Good guess; maybe that was the reason.  [...]
> So perhaps the original reason is not valid now
> that the memory model explicitly includes tests for stores being
> r-pre/post-bounded.
>
> Alan

I agree, I think you could relax that condition.

Note there's also rw-xbstar (used with fr) which doesn't check for
r-pre-bounded, but it should be ok. That's because only reads would be
unordered, as a result the read (in the if (x != ..) x=..) should provide
the correct value. The store would be issued as necessary, and the issued
store would still be ordered correctly w.r.t the read.

Best wishes,
jonas

