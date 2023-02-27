Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01C5E6A4C0F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 21:13:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjB0UNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 15:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbjB0UNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 15:13:45 -0500
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88622D527
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 12:13:41 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4PQWg802rMz9v7Gc
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 04:04:36 +0800 (CST)
Received: from [10.45.159.185] (unknown [10.45.159.185])
        by APP1 (Coremail) with SMTP id LxC2BwBX1QDRDv1jECVaAQ--.4486S2;
        Mon, 27 Feb 2023 21:13:16 +0100 (CET)
Message-ID: <bf2881fb-039b-06ab-68f9-806b29a84188@huaweicloud.com>
Date:   Mon, 27 Feb 2023 21:13:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v3] tools/memory-model: Make ppo a subrelation of po
To:     Andrea Parri <parri.andrea@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonas Oberhauser <jonas.oberhauser@huawei.com>,
        will@kernel.org, peterz@infradead.org, boqun.feng@gmail.com,
        npiggin@gmail.com, dhowells@redhat.com, j.alglave@ucl.ac.uk,
        luc.maranget@inria.fr, akiyks@gmail.com, dlustig@nvidia.com,
        joel@joelfernandes.org, urezki@gmail.com, quic_neeraju@quicinc.com,
        frederic@kernel.org, linux-kernel@vger.kernel.org
References: <20230224135251.24989-1-jonas.oberhauser@huaweicloud.com>
 <Y/jYm0AZfPHkIalK@rowland.harvard.edu>
 <20230224183758.GQ2948950@paulmck-ThinkPad-P17-Gen-1>
 <20230226010110.GA1576556@paulmck-ThinkPad-P17-Gen-1>
 <Y/rEH2r9i0BtfxEW@rowland.harvard.edu> <Y/0HEESX2wDWtPS1@andrea>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <Y/0HEESX2wDWtPS1@andrea>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID: LxC2BwBX1QDRDv1jECVaAQ--.4486S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ArWxtw1rKw1DuryUJrWDArb_yoW8JFy3p3
        yxAF17Kr4kXFs0kF15Ar47C3W3trna9F98Jr90kr1kCas8XFy3ZF47Gw48uFW5Cr93uw1j
        v3yqv34DWF1kZaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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



On 2/27/2023 8:40 PM, Andrea Parri wrote:
>> The LKMM doesn't believe that a control or data dependency orders a
>> plain write after a marked read.  Hence in this test it thinks that P1's
>> store to u0 can happen before the load of x1.  I don't remember why we
>> did it this way -- probably we just wanted to minimize the restrictions
>> on when plain accesses can execute.  (I do remember the reason for
>> making address dependencies induce order; it was so RCU would work.)
>>
>> The patch below will change what the LKMM believes.  It eliminates the
>> positive outcome of the litmus test and the data race.  Should it be
>> adopted into the memory model?
> (Unpopular opinion I know,) it should drop dependencies ordering, not
> add/promote it.
>
>    Andrea

Maybe not as unpopular as you think... :)
But either way IMHO it should be consistent; either take all the 
dependencies that are true and add them, or drop them all.
In the latter case, RCU should change to an acquire barrier. (also, one 
would have to deal with OOTA in some yet different way).

Generally my position is that unless there's a real-world benchmark with 
proven performance benefits of relying on dependency ordering, one 
should use an acquire barrier. I haven't yet met such a case, but maybe 
one of you has...

Best wishes,
jonas


