Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DACD86EE0E7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 13:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbjDYLKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 07:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjDYLKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 07:10:03 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EA13C05;
        Tue, 25 Apr 2023 04:09:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5K5s0B3mz4f41GZ;
        Tue, 25 Apr 2023 19:09:53 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBnHbEAtUdk4hV8IA--.17578S3;
        Tue, 25 Apr 2023 19:09:54 +0800 (CST)
Subject: Re: [PATCH] Remove blkg node after destroying blkg
To:     Tao Su <tao1.su@linux.intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230425075911.839539-1-tao1.su@linux.intel.com>
 <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
 <ZEegQCCZ96ij6mw5@linux.bj.intel.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6d486f85-87ed-fa35-00cb-4c37fef17536@huaweicloud.com>
Date:   Tue, 25 Apr 2023 19:09:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ZEegQCCZ96ij6mw5@linux.bj.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBnHbEAtUdk4hV8IA--.17578S3
X-Coremail-Antispam: 1UD129KBjvJXoWxuFy8tFW3JrW8CF1Dur4DJwb_yoW5Jw17pw
        47G3WYya95tFn29a10g3Wagw40qa1kGry5W3yDWFy5Cr9rXrn2qF1j9rWDuF9rZF47Grs0
        vrW5tryakw48u3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

在 2023/04/25 17:41, Tao Su 写道:
> On Tue, Apr 25, 2023 at 04:09:34PM +0800, Yu Kuai wrote:
>> Hi,
>>
>> 在 2023/04/25 15:59, Tao Su 写道:
>>> Kernel hang when poweroff or reboot, due to infinite restart in function
>>> blkg_destroy_all. It will goto restart label when a batch of blkgs are
>>> destroyed, but not remove blkg node in blkg_list. So the blkg_list is
>>> same in every 'restart' and result in kernel hang.
>>>
>>> By adding list_del to remove blkg node after destroying, can solve this
>>> kernel hang issue and satisfy the previous will to 'restart'.
>>>
>>> Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
>>> Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
>>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>>> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
>>> ---
>>>    block/blk-cgroup.c | 1 +
>>>    1 file changed, 1 insertion(+)
>>>
>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>> index bd50b55bdb61..960eb538a704 100644
>>> --- a/block/blk-cgroup.c
>>> +++ b/block/blk-cgroup.c
>>> @@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
>>>    		spin_lock(&blkcg->lock);
>>>    		blkg_destroy(blkg);
>>> +		list_del(&blkg->q_node);
>>
>> blkg should stay on the queue list until blkg_free_workfn(), otherwise
>> parent blkg can be freed before child, which will cause some known
>> issue.
> 
> Yes, directly removing blkg node is not appropriate, which I noticed some
> comments in blkg_destroy(), thanks for pointing out this issue.
> 
>>
>> I think this hung happens when total blkg is greater than
>> BLKG_DESTROY_BATCH_SIZE, right?
> 
> Yes, you are right.
> 
>>
>> Can you try if following patch fix your problem?
> 
> This patch can also fix my problem, and indeed is a more secure way.

Thanks for the test, for a better solution, I think 'blkcg_mutex' can
be used to protect 'blkg->q_node' list instead of 'queue_lock', so that
the 'restart' can be removed because softlockup can be avoided.

Thanks,
Kuai

> 
> Thanks,
> Tao
> 
>>
>> index 1c1ebeb51003..0ecb4cce8af2 100644
>> --- a/block/blk-cgroup.c
>> +++ b/block/blk-cgroup.c
>> @@ -527,6 +527,9 @@ static void blkg_destroy_all(struct gendisk *disk)
>>          list_for_each_entry_safe(blkg, n, &q->blkg_list, q_node) {
>>                  struct blkcg *blkcg = blkg->blkcg;
>>
>> +               if (hlist_unhashed(&blkg->blkcg_node))
>> +                       continue;
>> +
>>                  spin_lock(&blkcg->lock);
>>                  blkg_destroy(blkg);
>>                  spin_unlock(&blkcg->lock);
>>
>>>    		spin_unlock(&blkcg->lock);
>>>    		/*
>>>
> 
> .
> 

