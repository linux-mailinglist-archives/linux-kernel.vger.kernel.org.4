Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9654D5EA13F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbiIZKq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236684AbiIZKo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:44:26 -0400
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0670D4D4FF;
        Mon, 26 Sep 2022 03:25:23 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Mbf3q6wvbzl51S;
        Mon, 26 Sep 2022 18:23:35 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
        by APP2 (Coremail) with SMTP id Syh0CgC3VW8PfjFjaLywBQ--.62510S3;
        Mon, 26 Sep 2022 18:25:20 +0800 (CST)
Subject: Re: [PATCH v3 1/5] wbt: don't show valid wbt_lat_usec in sysfs while
 wbt is disabled
To:     Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai1@huaweicloud.com, yi.zhang@huawei.com,
        "yukuai (C)" <yukuai3@huawei.com>
References: <20220922113558.1085314-1-yukuai3@huawei.com>
 <20220922113558.1085314-2-yukuai3@huawei.com>
 <20220926094434.jrl6gnlbjqkex3wa@quack3>
From:   Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <6736753f-b5ae-39f1-b0c4-508b7f45d701@huaweicloud.com>
Date:   Mon, 26 Sep 2022 18:25:18 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20220926094434.jrl6gnlbjqkex3wa@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgC3VW8PfjFjaLywBQ--.62510S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW8CryrCw1rCr15JrWkJFb_yoW5tFy5pa
        yUJF4aka1IgFW2ga4IqrsrWrZIkw48trWxGrWxG3yayrn0kry29F10krW8uas5AFWxCr4x
        Zr1YyFsxurW2grJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jan

在 2022/09/26 17:44, Jan Kara 写道:
> On Thu 22-09-22 19:35:54, Yu Kuai wrote:
>> Currently, if wbt is initialized and then disabled by
>> wbt_disable_default(), sysfs will still show valid wbt_lat_usec, which
>> will confuse users that wbt is still enabled.
>>
>> This patch shows wbt_lat_usec as zero and forbid to set it while wbt
>> is disabled.
> 
> So I agree we should show 0 in wbt_lat_usec if wbt is disabled by
> wbt_disable_default(). But why do you forbid setting of wbt_lat_usec?
> IMHO if wbt_lat_usec is set, admin wants to turn on wbt so we should just
> update rwb->enable_state to WBT_STATE_ON_MANUAL.

I was thinking that don't enable wbt if elevator is bfq. Since we know
that performance is bad, thus it doesn't make sense to me to do that,
and user might doesn't aware of the problem.

However, perhaps admin should be responsible if wbt is turned on while
elevator is bfq.

Thanks,
Kuai
> 
> 								Honza
> 
>>
>> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
>> Reported-and-tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
>> ---
>>   block/blk-sysfs.c | 9 ++++++++-
>>   block/blk-wbt.c   | 7 +++++++
>>   block/blk-wbt.h   | 5 +++++
>>   3 files changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
>> index e1f009aba6fd..1955bb6a284d 100644
>> --- a/block/blk-sysfs.c
>> +++ b/block/blk-sysfs.c
>> @@ -467,10 +467,14 @@ static ssize_t queue_io_timeout_store(struct request_queue *q, const char *page,
>>   
>>   static ssize_t queue_wb_lat_show(struct request_queue *q, char *page)
>>   {
>> +	u64 lat;
>> +
>>   	if (!wbt_rq_qos(q))
>>   		return -EINVAL;
>>   
>> -	return sprintf(page, "%llu\n", div_u64(wbt_get_min_lat(q), 1000));
>> +	lat = wbt_disabled(q) ? 0 : div_u64(wbt_get_min_lat(q), 1000);
>> +
>> +	return sprintf(page, "%llu\n", lat);
>>   }
>>   
>>   static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>> @@ -493,6 +497,9 @@ static ssize_t queue_wb_lat_store(struct request_queue *q, const char *page,
>>   			return ret;
>>   	}
>>   
>> +	if (wbt_disabled(q))
>> +		return -EINVAL;
>> +
>>   	if (val == -1)
>>   		val = wbt_default_latency_nsec(q);
>>   	else if (val >= 0)
>> diff --git a/block/blk-wbt.c b/block/blk-wbt.c
>> index a9982000b667..68851c2c02d2 100644
>> --- a/block/blk-wbt.c
>> +++ b/block/blk-wbt.c
>> @@ -422,6 +422,13 @@ static void wbt_update_limits(struct rq_wb *rwb)
>>   	rwb_wake_all(rwb);
>>   }
>>   
>> +bool wbt_disabled(struct request_queue *q)
>> +{
>> +	struct rq_qos *rqos = wbt_rq_qos(q);
>> +
>> +	return !rqos || RQWB(rqos)->enable_state == WBT_STATE_OFF_DEFAULT;
>> +}
>> +
>>   u64 wbt_get_min_lat(struct request_queue *q)
>>   {
>>   	struct rq_qos *rqos = wbt_rq_qos(q);
>> diff --git a/block/blk-wbt.h b/block/blk-wbt.h
>> index 7e44eccc676d..e42465ddcbb6 100644
>> --- a/block/blk-wbt.h
>> +++ b/block/blk-wbt.h
>> @@ -94,6 +94,7 @@ void wbt_enable_default(struct request_queue *);
>>   
>>   u64 wbt_get_min_lat(struct request_queue *q);
>>   void wbt_set_min_lat(struct request_queue *q, u64 val);
>> +bool wbt_disabled(struct request_queue *);
>>   
>>   void wbt_set_write_cache(struct request_queue *, bool);
>>   
>> @@ -125,6 +126,10 @@ static inline u64 wbt_default_latency_nsec(struct request_queue *q)
>>   {
>>   	return 0;
>>   }
>> +static inline bool wbt_disabled(struct request_queue *q)
>> +{
>> +	return true;
>> +}
>>   
>>   #endif /* CONFIG_BLK_WBT */
>>   
>> -- 
>> 2.31.1
>>

