Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2B46B1BF4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 08:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjCIHHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 02:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCIHG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 02:06:59 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B869545C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 23:06:37 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y10so870542pfi.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 23:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678345596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7pyIae5ogOSpb2gjOaxlcqc6rpugEeu+oHZHBt618ew=;
        b=TWczwbVm2E+9FsUKVqwuQb5c/yI1a4b2Me1B40ILSupz0qmwlIA4PTtHTLSda+f2SU
         qgCUV4cOx9MbTzYCCUFHNIuWhU32EHXPoclDex8/q4z7hOVTVv5r7EehIaTlmUcVuyUS
         qopQCVexd0kppXrB3GOev3VMq9/bXv1aUicjtpEt9dtjSj3eto+w2zdYl7NBFJNxTKIY
         P6zH4WnSF+E2+ObONWRF2bMW0uVCVAO1fk0+auTjmQRxPKZyutHFfQEWbAz6aducFXaT
         6kTqr/B9IqmDJ3Ehyo7aOjB3VPbWetyx6cStpt5G6D4VET4OKynRZ0ism8lyg6uzYQKe
         /UNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678345596;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7pyIae5ogOSpb2gjOaxlcqc6rpugEeu+oHZHBt618ew=;
        b=O3Qc/MwI9Tp5KHUVaoPscTgU3an3pJdEJDiUtzoM/f8YrLrIqliNuixf3vkiE9nVfN
         wUun99/Or0Qz1vbWnpdvJbvfprPXQeX2+p3Vwz1QSQEH3swW3F59adTuzE9dp/3CkY2H
         +tssY3gle/Xb7UwTmcFcuB6Av9jPpdaVAcHSb2qYoa1DmGYH267dxnfTyt19hpU8WSH2
         6iDvtl9677n0+/7feo+NPiD5kpIzheWc5C7J6PBehGoCMgRwmjYi5nBB6Jdjw1p7c4Ya
         hWLDk8ten+6/K6I70RbK5CRfAfGW95n6PN4o9KXB2RtnCkd7PLv2fJ2zsNZveYOha4zB
         XkSQ==
X-Gm-Message-State: AO0yUKVza9JeF0ggEq1Er6BqfZysA1lv0PD6g2xCBIG/3SidNg8adHqR
        DpFpKThnL5xuVZD1+L51+C64Gg==
X-Google-Smtp-Source: AK7set8QeNKGCSLw+WADxAJznvqY1wSU07FOHQhMa8fgjmh9znYBwK8n+VMcLNTniZPst802esCEbQ==
X-Received: by 2002:a05:6a00:2d29:b0:5e4:f141:568b with SMTP id fa41-20020a056a002d2900b005e4f141568bmr20349309pfb.3.1678345596631;
        Wed, 08 Mar 2023 23:06:36 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id 1-20020aa79241000000b005a7ae8b3a09sm10498506pfp.32.2023.03.08.23.06.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 23:06:35 -0800 (PST)
Message-ID: <07078623-b7ef-ceb4-eccc-8872a4067273@bytedance.com>
Date:   Thu, 9 Mar 2023 15:06:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        christian.koenig@amd.com
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
 <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kirill,

On 2023/3/9 06:39, Kirill Tkhai wrote:
> On 07.03.2023 09:56, Qi Zheng wrote:
>> Now there are no readers of shrinker_rwsem, so
>> synchronize_shrinkers() does not need to hold the
>> writer of shrinker_rwsem to wait for all running
>> shinkers to complete, synchronize_srcu() is enough.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   mm/vmscan.c | 8 ++------
>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 7aaf6f94ac1b..ac7ab4aa344f 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>>   /**
>>    * synchronize_shrinkers - Wait for all running shrinkers to complete.
>>    *
>> - * This is equivalent to calling unregister_shrink() and register_shrinker(),
>> - * but atomically and with less overhead. This is useful to guarantee that all
>> - * shrinker invocations have seen an update, before freeing memory, similar to
>> - * rcu.
>> + * This is useful to guarantee that all shrinker invocations have seen an
>> + * update, before freeing memory.
>>    */
>>   void synchronize_shrinkers(void)
>>   {
>> -	down_write(&shrinker_rwsem);
>> -	up_write(&shrinker_rwsem);
>>   	atomic_inc(&shrinker_srcu_generation);
>>   	synchronize_srcu(&shrinker_srcu);
>>   }
> 
> Just curious, callers of synchronize_shrinkers() don't want to have parallel register_shrinker() and unregister_shrink() are completed?
> Here we only should wait for parallel shrink_slab(), correct?

I think yes.

The synchronize_shrinkers() is currently only used by TTM pool.

In TTM pool, a shrinker named "drm-ttm_pool" is registered, and
the scan_objects callback will pick an entry from its own shrinker_list:

ttm_pool_shrink
--> spin_lock(&shrinker_lock);
     pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
     list_move_tail(&pt->shrinker_list, &shrinker_list);
     spin_unlock(&shrinker_lock);

These entries have been removed from shrinker_list before calling
synchronize_shrinkers():

ttm_pool_fini
--> ttm_pool_type_fini
     --> spin_lock(&shrinker_lock);
	list_del(&pt->shrinker_list);
	spin_unlock(&shrinker_lock);
     synchronize_shrinkers

So IIUC, we only need to wait for the parallel shrink_slab() here. Like
its comment says:

/* We removed the pool types from the LRU, but we need to also make sure
  * that no shrinker is concurrently freeing pages from the pool.
  */

+ CC: Christian König :)

Thanks,
Qi
