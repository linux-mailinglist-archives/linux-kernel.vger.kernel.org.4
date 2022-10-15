Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E44F5FF844
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Oct 2022 05:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJODcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 23:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiJODcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 23:32:33 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720A55A3C4;
        Fri, 14 Oct 2022 20:32:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cl1so6465927pjb.1;
        Fri, 14 Oct 2022 20:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3X1YHPGMVMz9p937nmfPncWHRU0pK6n3WkNJ71zGW8c=;
        b=qZOYjuMIHm2a7sUO10OWEHy1YaQmQiq8v+76AhwjwAPYvGvUOYD6zimKX9rtxWZf2H
         jGg+pRk7a/52+VNiPImjLnxqyR6XUWMNIQtolTwbh/dwOFxoNSNYY49Sp/JHtaY5uFQE
         uQX9Pzj0HG5c27NBXgDOefK9wDdn1/qcYKCe8RPpJqD1mMy+OtTYiRI/s4Nu9nXeJvhk
         0qMo3WYwbxudi00dIvCa3mu+bkt/GuwgTT6hc8Zpas45Pa0OTuR7uv9kxkSzgT5oMdMs
         FdQiK2cUEHx21V9XAi4PTcEsRgCLHyMhZbc7TcecRSCDdK8a48Rv0TLKkol8qb8wEJCl
         WgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3X1YHPGMVMz9p937nmfPncWHRU0pK6n3WkNJ71zGW8c=;
        b=LNZu9N4nfqPz7FRKVnvj5WKi/S8zzW7Kfis4WZhn4yBlVfttYg5hwcITWbJx8PVw19
         VKxVDU73HdUT9MoXFGtkzjJ0obDG8k0oZp7NsBaZWmEY7wTZxGGDOn7ZB3DRqnUFQn/I
         b4HiGBlqqYwEswVwlgw9A0OZEzYmc/Sajk+hw2fPVh2hwuP1lX5R6adL1jFd3+vKvpCP
         Mxlz7VQJOayW4k0hDZZ71/8VizvUNM9lTjX97CWYHribOnFrBSxT+sVuRjVT6mY3FHuy
         xSQR6qB20Y/q6dd7eBQgUQsgEvrRtJ+0R4QZfYjhaKFcwW/tSP6n60bkVMiCZf75nsVu
         uJQQ==
X-Gm-Message-State: ACrzQf1TGMHovtE/zXmGRojarJfFS076DpedU90VuvcYBjqmgWRJdJCU
        Q/s9Fr2xdarCv1tbMykvotQZGHODs8aPXIQw
X-Google-Smtp-Source: AMsMyM7bRKKhBmM8H5v3Fdw2YBvrgvt4v8rtI1+aXZNNil39g1VJSTtclF8oOTblJqwLreyqbxJKIw==
X-Received: by 2002:a17:90a:fa46:b0:20d:5efa:84fc with SMTP id dt6-20020a17090afa4600b0020d5efa84fcmr20334052pjb.20.1665804751836;
        Fri, 14 Oct 2022 20:32:31 -0700 (PDT)
Received: from [10.114.96.6] ([129.227.152.6])
        by smtp.gmail.com with ESMTPSA id w2-20020a62c702000000b00562f431f3d2sm2542125pfg.83.2022.10.14.20.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Oct 2022 20:32:31 -0700 (PDT)
Message-ID: <57bd392b-45a6-929c-8be1-b0f6cff1da31@gmail.com>
Date:   Sat, 15 Oct 2022 11:32:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] bfq: do try insert merge before bfq_init_rq() call
To:     Jan Kara <jack@suse.cz>
Cc:     paolo.valente@linaro.org, axboe@kernel.dk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yuwei.Guan@zeekrlife.com
References: <20221013135321.174-1-Yuwei.Guan@zeekrlife.com>
 <20221014145004.gqqpa5uvgg576tej@quack3>
From:   Yuwei Guan <ssawgyw@gmail.com>
In-Reply-To: <20221014145004.gqqpa5uvgg576tej@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/10/14 22:50, Jan Kara wrote:
> On Thu 13-10-22 21:53:21, Yuwei Guan wrote:
>> It's useless to do bfq_init_rq(rq), if the rq can do merge first.
>>
>> In the patch 5f550ede5edf8, it moved to bfq_init_rq() before
>> blk_mq_sched_try_insert_merge(), but it's pointless,
>> as the fifo_time of next is not set yet,
>> and !list_empty(&next->queuelist) is 0, so it does not
>> need to reposition rq's fifo_time.
>>
>> And for the "hash lookup, try again" situation, as follow,
>> bfq_requests_merged() call can work normally.
>>
>> blk_mq_sched_try_insert_merge
>>    elv_attempt_insert_merge
>>      elv_rqhash_find
>>
>> Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
> OK, after some thinking I agree. How much testing has this patch got?
> Because I'd like to verify we didn't overlook something.
>
> 							Honza
Thanks for reviewing.
I tested it with fio seq read case like bellow,
then check blk trace and bfq log.

[global]
name=fio-seq-reads
filename=fio-seq-reads
rw=read
bs=16K
direct=1
numjobs=4

[file1]
size=32m
ioengine=psync

What kinds of test cases you perfer to do, I will deal with them,
or we verify this patch together, if you have free time. :)
>> ---
>>   block/bfq-iosched.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
>> index 7ea427817f7f..9845370a701c 100644
>> --- a/block/bfq-iosched.c
>> +++ b/block/bfq-iosched.c
>> @@ -6147,7 +6147,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   		bfqg_stats_update_legacy_io(q, rq);
>>   #endif
>>   	spin_lock_irq(&bfqd->lock);
>> -	bfqq = bfq_init_rq(rq);
>> +
>>   	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
>>   		spin_unlock_irq(&bfqd->lock);
>>   		blk_mq_free_requests(&free);
>> @@ -6156,6 +6156,7 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
>>   
>>   	trace_block_rq_insert(rq);
>>   
>> +	bfqq = bfq_init_rq(rq);
>>   	if (!bfqq || at_head) {
>>   		if (at_head)
>>   			list_add(&rq->queuelist, &bfqd->dispatch);
>> -- 
>> 2.34.1
>>
