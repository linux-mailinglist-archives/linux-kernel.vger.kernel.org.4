Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8835FB2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 14:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJKM7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 08:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiJKM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 08:59:44 -0400
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEFAE21;
        Tue, 11 Oct 2022 05:59:39 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4MmwmJ2DlBz6Pq81;
        Tue, 11 Oct 2022 20:57:20 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgD39si2aEVjv75sAA--.42468S3;
        Tue, 11 Oct 2022 20:59:35 +0800 (CST)
Subject: Re: [PATCH] block: put the reference of the io scheduler module after
 switching back
To:     Yu Kuai <yukuai1@huaweicloud.com>,
        Jinlong Chen <chenjinlong2016@outlook.com>, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        "yukuai (C)" <yukuai3@huawei.com>
References: <OS0P286MB0338069A20BA87C2C9B2F2E0BE239@OS0P286MB0338.JPNP286.PROD.OUTLOOK.COM>
 <a0d0c50e-061b-ce4e-0341-35156dde00c7@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <7f6cb343-bf97-c73a-c3da-c22d7543bd4a@huaweicloud.com>
Date:   Tue, 11 Oct 2022 20:59:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a0d0c50e-061b-ce4e-0341-35156dde00c7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgD39si2aEVjv75sAA--.42468S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr43WF1kAr1DJw1xGw17Jrb_yoW8XryDpr
        WkGa4YkrZIqr1vgay8Ga13Wa48ArWvgrs8Crn5uF1fZw1fGryIqFy8Xr4q9r1rCws7Jr4D
        Jr1UXrs7ZFy5JrJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r4j
        6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUZa9
        -UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

在 2022/10/11 20:54, Yu Kuai 写道:
> Hi!
> 
> 在 2022/10/11 18:21, Jinlong Chen 写道:
>> We got a reference of the io scheduler module in
>> blk_mq_elv_switch_none to prevent the module from
>> being removed. We need to put that reference back
>> once we are done.
> 
> However, if blk_mq_elv_switch_none() failed due to OOM, and module
> reference is not acquired, blk_mq_elv_switch_back() will still be
> called. This seems not to be the right fix.

Please ignore this.

I got it now if switch none failed, old queue is not added to the list,
and later blk_lookup_qe_pair() will fail to lookup the queue.

Thanks,
Kuai
> 
> Thanks,
> Kuai
>>
>> Signed-off-by: Jinlong Chen <chenjinlong2016@outlook.com>
>> ---
>>   block/blk-mq.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>> index 8070b6c10e8d..8dfe3bf3e599 100644
>> --- a/block/blk-mq.c
>> +++ b/block/blk-mq.c
>> @@ -4595,6 +4595,13 @@ static void blk_mq_elv_switch_back(struct 
>> list_head *head,
>>       mutex_lock(&q->sysfs_lock);
>>       elevator_switch(q, t);
>> +    /**
>> +     * We got a reference of the io scheduler module in
>> +     * blk_mq_elv_switch_none to prevent the module from
>> +     * being removed. We need to put that reference back
>> +     * once we are done.
>> +     */
>> +    module_put(t->elevator_owner);
>>       mutex_unlock(&q->sysfs_lock);
>>   }
>>
> 
> .
> 

