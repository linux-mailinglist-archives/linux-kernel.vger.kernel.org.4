Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854F468647A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 11:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbjBAKjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 05:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjBAKid (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 05:38:33 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F570CC0E
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 02:38:11 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.228])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4P6J886bS0z9v7Tw
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 18:30:00 +0800 (CST)
Received: from [10.81.213.150] (unknown [10.81.213.150])
        by APP1 (Coremail) with SMTP id LxC2BwAHiwbyQNpjz+fkAA--.12899S2;
        Wed, 01 Feb 2023 11:37:47 +0100 (CET)
Message-ID: <b00114a8-6dbd-9791-cff8-e63812589649@huaweicloud.com>
Date:   Wed, 1 Feb 2023 11:37:36 +0100
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
References: <Y9Kr+GntQyGKPH3K@rowland.harvard.edu>
 <47acbaa7-8280-48f2-678f-53762cf3fe9d@huaweicloud.com>
 <Y9V+CyKIjg8sgVAC@rowland.harvard.edu> <Y9WeOTmGCCfjMUtG@andrea>
 <Y9Wo6OttHC4sUxCS@rowland.harvard.edu>
 <0da94668-c041-1d59-a46d-bd13562e385e@huaweicloud.com>
 <Y9ct1aAnOTGCy9n2@rowland.harvard.edu>
 <001f7d74-0ef9-a667-b656-bbd18491d5c1@huaweicloud.com>
 <Y9kugMJrR2oJhUVv@rowland.harvard.edu>
 <878cef1b-d4e5-f710-dc0a-a9329ad483d8@huaweicloud.com>
 <Y9lH97/Hw+W90gj0@rowland.harvard.edu>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y9lH97/Hw+W90gj0@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwAHiwbyQNpjz+fkAA--.12899S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5Gry7Gw4UuF47KFy8Krg_yoW8CrykpF
        yvyF45trWktFZ7ur1DAr43XFWFkw1rAFZxJrnYgF1xA345JryIvw42qayj9ayUCryvk3Wj
        qa4ayFy7Za4DZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvIb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
        07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
        02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_
        WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
        CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE
        14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf
        9x07UdxhLUUUUU=
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/31/2023 5:55 PM, Alan Stern wrote:
> On Tue, Jan 31, 2023 at 04:33:25PM +0100, Jonas Oberhauser wrote:
>>
>> More precisely, I would change
>>
>>> 	For each other CPU C', any store which propagates to C before
>>> 	a release fence is executed (including all po-earlier
>>> 	stores executed on C) is forced to propagate to C' before the
>>> 	store associated with the release fence does.
>> Into something like
>>
>>
>>       For each other CPU C', any *external* store which propagates to C
>> before
>>       a release fence is executed as well as any po-earlier
>>       store executed on C is forced to propagate to C' before the
>>       store associated with the release fence does.
>>
>> The difference is that po-later stores that happen to propagate to C before
>> the release fence is executed would no longer be ordered.
>> That should be consistent with the axiomatic model.
> I had to check that it wouldn't affect the (xbstar & int) part of vis,
> but it looks all right.  This seems like a reasonable change.
>
> However, it only fixes part of the problem.  Suppose an external write
> is read by an instruction po-after the release-store, but the read
> executes before the release-store.  The operational model would still
> say the external write has to obey the propagation ordering, whereas the
> formal model doesn't require it.


Ouch. I had only thought about the [W];(xbstar & int);[Release] case, 
but there's also the rfe;(xbstar & int);[Release] case....


>> Any additional concerns/changes for this patch?
> It should give the same data-race diagnostics as the current LKMM.  This
> probably means the patch will need to punch up the definitions of
> *-pre-bounded and *-post-bounded, unless you can think of a better
> approach.
>
> Alan

Seems the 1 thing per patch mentally hasn't yet become ingrained in me. 
Thanks!

jonas

