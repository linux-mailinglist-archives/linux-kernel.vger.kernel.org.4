Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE73B6891C3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 09:14:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbjBCIO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 03:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjBCIOC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 03:14:02 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2106B92EC7;
        Fri,  3 Feb 2023 00:13:45 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4P7T1v6mk1z4f3mHy;
        Fri,  3 Feb 2023 16:13:39 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP3 (Coremail) with SMTP id _Ch0CgDHcyEywtxj+U+kCg--.47152S3;
        Fri, 03 Feb 2023 16:13:40 +0800 (CST)
Subject: Re: [PATCH -next] block: Revert "block: increase BLKCG_MAX_POLS"
To:     Oleksandr Natalenko <oleksandr@natalenko.name>, tj@kernel.org,
        axboe@kernel.dk, Yu Kuai <yukuai1@huaweicloud.com>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20230203081357.1385168-1-yukuai1@huaweicloud.com>
 <2666358.mvXUDI8C0e@natalenko.name>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <957f8218-ef4d-7841-0bb2-07d8de6ae28d@huaweicloud.com>
Date:   Fri, 3 Feb 2023 16:13:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2666358.mvXUDI8C0e@natalenko.name>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgDHcyEywtxj+U+kCg--.47152S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Gr13tF4UCr1Utr4fWw4UJwb_yoW8JF1Dpa
        n7CF47Cr48Krnrua4kXw1fuas7X3yvyr1ruFy3Wry3u342qrs7Ww1ktrn8KFyku392kr4j
        gr12g34F934jvrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
        CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
        2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
        W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
        IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
        v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
        c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
        0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
        6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUdHU
        DUUUUU=
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

ÔÚ 2023/02/03 15:59, Oleksandr Natalenko Ð´µÀ:
> Hello.
> 
> On p¨¢tek 3. ¨²nora 2023 9:13:57 CET Yu Kuai wrote:
>> From: Yu Kuai <yukuai3@huawei.com>
>>
>> This reverts commit ec645dc96699ea6c37b6de86c84d7288ea9a4ddf.
>>
>> This can save some memory, because after commit 0f7839955114 ("Revert
>> "block/mq-deadline: Add cgroup support""), there are total 5 policies.
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> ---
>>   include/linux/blkdev.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
>> index 41a41561b773..c6861c7fdad9 100644
>> --- a/include/linux/blkdev.h
>> +++ b/include/linux/blkdev.h
>> @@ -54,7 +54,7 @@ extern struct class block_class;
>>    * Maximum number of blkcg policies allowed to be registered concurrently.
>>    * Defined here to simplify include dependency.
>>    */
>> -#define BLKCG_MAX_POLS		6
>> +#define BLKCG_MAX_POLS		5
>>   
>>   #define DISK_MAX_PARTS			256
>>   #define DISK_NAME_LEN			32
> 
> Last time I asked about reverting this change, it was suggested that we may keep it [1].
> 
> [1] https://lore.kernel.org/linux-block/1dc051a8-4d59-8137-2406-f74026b170bd@kernel.dk/
> 

I see now, thanks for the reply.

Kuai

