Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9F36EEBD1
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 03:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjDZBNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 21:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbjDZBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 21:13:15 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60F7B209;
        Tue, 25 Apr 2023 18:13:13 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Q5gpr6zJ6z4f4tZq;
        Wed, 26 Apr 2023 09:13:08 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP4 (Coremail) with SMTP id gCh0CgBH_rGkekhknfmkIA--.45975S3;
        Wed, 26 Apr 2023 09:13:10 +0800 (CST)
Subject: Re: [PATCH] Remove blkg node after destroying blkg
To:     Yu Kuai <yukuai1@huaweicloud.com>, Tao Su <tao1.su@linux.intel.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        tj@kernel.org, josef@toxicpanda.com, axboe@kernel.dk,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230425075911.839539-1-tao1.su@linux.intel.com>
 <aa5de32c-c92b-d032-e9bb-83d2436ff72c@huawei.com>
 <ZEegQCCZ96ij6mw5@linux.bj.intel.com>
 <6d486f85-87ed-fa35-00cb-4c37fef17536@huaweicloud.com>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <9f5eeba2-fbc9-3b56-c7ed-d8ecc1c888b3@huaweicloud.com>
Date:   Wed, 26 Apr 2023 09:13:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <6d486f85-87ed-fa35-00cb-4c37fef17536@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgBH_rGkekhknfmkIA--.45975S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WFWkKw4rXrW8KFy7XrW3trb_yoW8KryUpa
        1xJ3WYyay5JFn29w1Iq3Wag348ta18J34UWw4UWFyrCr9FqryvqF129r1q9Fy7ZF4xGrs0
        vr45Jrya9w1j9w7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_
        Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUoOJ5UU
        UUU
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

在 2023/04/25 19:09, Yu Kuai 写道:
> Hi,
> 
> 在 2023/04/25 17:41, Tao Su 写道:
>> On Tue, Apr 25, 2023 at 04:09:34PM +0800, Yu Kuai wrote:
>>> Hi,
>>>
>>> 在 2023/04/25 15:59, Tao Su 写道:
>>>> Kernel hang when poweroff or reboot, due to infinite restart in 
>>>> function
>>>> blkg_destroy_all. It will goto restart label when a batch of blkgs are
>>>> destroyed, but not remove blkg node in blkg_list. So the blkg_list is
>>>> same in every 'restart' and result in kernel hang.
>>>>
>>>> By adding list_del to remove blkg node after destroying, can solve this
>>>> kernel hang issue and satisfy the previous will to 'restart'.
>>>>
>>>> Reported-by: Xiangfei Ma <xiangfeix.ma@intel.com>
>>>> Tested-by: Xiangfei Ma <xiangfeix.ma@intel.com>
>>>> Tested-by: Farrah Chen <farrah.chen@intel.com>
>>>> Signed-off-by: Tao Su <tao1.su@linux.intel.com>
>>>> ---
>>>>    block/blk-cgroup.c | 1 +
>>>>    1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
>>>> index bd50b55bdb61..960eb538a704 100644
>>>> --- a/block/blk-cgroup.c
>>>> +++ b/block/blk-cgroup.c
>>>> @@ -530,6 +530,7 @@ static void blkg_destroy_all(struct gendisk *disk)
>>>>            spin_lock(&blkcg->lock);
>>>>            blkg_destroy(blkg);
>>>> +        list_del(&blkg->q_node);
>>>
>>> blkg should stay on the queue list until blkg_free_workfn(), otherwise
>>> parent blkg can be freed before child, which will cause some known
>>> issue.
>>
>> Yes, directly removing blkg node is not appropriate, which I noticed some
>> comments in blkg_destroy(), thanks for pointing out this issue.
>>
>>>
>>> I think this hung happens when total blkg is greater than
>>> BLKG_DESTROY_BATCH_SIZE, right?
>>
>> Yes, you are right.
>>
>>>
>>> Can you try if following patch fix your problem?
>>
>> This patch can also fix my problem, and indeed is a more secure way.
> 
> Thanks for the test, for a better solution, I think 'blkcg_mutex' can
> be used to protect 'blkg->q_node' list instead of 'queue_lock', so that
> the 'restart' can be removed because softlockup can be avoided.
> 

I looked into this, and I found that this is not a easy thing to do.

Anyway, feel free to submit a new patch based on my orignial suggestion.

Thanks,
Kuai

