Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0BF6B1E43
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjCIIec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:34:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjCIIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:34:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FEAE1CAD
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 00:32:14 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so1406995pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 00:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1678350733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qnU/X2e95xsiSIu4tmW7SI2rnetIK140zKHdYOPsBoo=;
        b=E9v9mwYBcKzIl7SSCZrLhtYawGp6dt2Fx4EWTVJU1a5gN4PUjVBUkIMAwEGXi/5qsA
         roZHNoClMi7DB7BTo2PAbIJx7Qg2SvYjsIwmEF0OmcE/ZVcrPUclXPSJSix9kQ9jIpKq
         7oKIpSlFXrW4VLRa6NwiNtKMyjjBv3AyF2o+xJtKdUjgOYMGdslAZxBPJhjvsL3m0Zui
         LbLFg9axUYUS3YeEYQWZPuJNVbnXlgk1DVuTPovHqe7Ty1LFWTkm0CMmz1/6N/BDAn8o
         NaT41EQaSDl9jCs2SUVPW271hMSmspWAqLqgYPq9//hhC88hF+yHoEbqpTVWru6/po9L
         K2NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678350733;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qnU/X2e95xsiSIu4tmW7SI2rnetIK140zKHdYOPsBoo=;
        b=bc13Xq0eqEkb4mrUOG39TmU2baM3VUTXHD0chEruUaV7xVFlEAHke64DtZar/Am5QN
         FR/9iDkTJ2sdLAGVyhzwLhAK+T/ruokYZnMDzIExL9xwha436UEWhwU6ByTTKYmm72Bb
         o7OguvJ+/7Ld3jBUe1a66GCvm0P151xroXXWT7Du9OC3jqi2Cs9LJqw9yb1F6KHyi+1M
         HVyc8pAIfRE5B3jIPsvimxBy6fuY4LtJV7NugqdsP8ERK+8lOzSAjis0DudCImBBjsIq
         JizXxmMayqZQNM0ZJHZapStXklFg/WW0r/PbJ5cF9t8VgsUC5AIi6ozGujDPlR8ImIFP
         /W2Q==
X-Gm-Message-State: AO0yUKXqWaXl1k8D1hE/Ytjvgqfvrf68FDvTaMQHtVL5ka2WQfwFFf+W
        BiZKJSu1QgKV46/qv8gbTfucVg==
X-Google-Smtp-Source: AK7set8U5qMjIEdCVTmcRgFo+6Z+N52ZgShPBwPb/e4xh7nmvQ7lPwVM/tFDqThh5b+fHusqeekZdA==
X-Received: by 2002:a17:903:33c3:b0:19e:4cda:513 with SMTP id kc3-20020a17090333c300b0019e4cda0513mr2332008plb.5.1678350733572;
        Thu, 09 Mar 2023 00:32:13 -0800 (PST)
Received: from [10.70.252.135] ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id a14-20020a170902ecce00b0019906c4c9dcsm11036033plh.98.2023.03.09.00.32.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 00:32:12 -0800 (PST)
Message-ID: <85f9e200-dabe-7340-b76d-6525988054aa@bytedance.com>
Date:   Thu, 9 Mar 2023 16:32:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 7/8] mm: vmscan: remove shrinker_rwsem from
 synchronize_shrinkers()
Content-Language: en-US
To:     =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Kirill Tkhai <tkhai@ya.ru>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, muchun.song@linux.dev, david@redhat.com,
        shy828301@gmail.com, rppt@kernel.org
Cc:     sultan@kerneltoast.com, dave@stgolabs.net,
        penguin-kernel@I-love.SAKURA.ne.jp, paulmck@kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230307065605.58209-1-zhengqi.arch@bytedance.com>
 <20230307065605.58209-8-zhengqi.arch@bytedance.com>
 <bc829246-4606-cc8d-4a4f-da285255f5a3@ya.ru>
 <07078623-b7ef-ceb4-eccc-8872a4067273@bytedance.com>
 <d527005e-5f55-a6f7-21ce-817076860e99@amd.com>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <d527005e-5f55-a6f7-21ce-817076860e99@amd.com>
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

Hi Christian,

On 2023/3/9 16:11, Christian König wrote:
> Am 09.03.23 um 08:06 schrieb Qi Zheng:
>> Hi Kirill,
>>
>> On 2023/3/9 06:39, Kirill Tkhai wrote:
>>> On 07.03.2023 09:56, Qi Zheng wrote:
>>>> Now there are no readers of shrinker_rwsem, so
>>>> synchronize_shrinkers() does not need to hold the
>>>> writer of shrinker_rwsem to wait for all running
>>>> shinkers to complete, synchronize_srcu() is enough.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>   mm/vmscan.c | 8 ++------
>>>>   1 file changed, 2 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>>>> index 7aaf6f94ac1b..ac7ab4aa344f 100644
>>>> --- a/mm/vmscan.c
>>>> +++ b/mm/vmscan.c
>>>> @@ -796,15 +796,11 @@ EXPORT_SYMBOL(unregister_shrinker);
>>>>   /**
>>>>    * synchronize_shrinkers - Wait for all running shrinkers to 
>>>> complete.
>>>>    *
>>>> - * This is equivalent to calling unregister_shrink() and 
>>>> register_shrinker(),
>>>> - * but atomically and with less overhead. This is useful to 
>>>> guarantee that all
>>>> - * shrinker invocations have seen an update, before freeing memory, 
>>>> similar to
>>>> - * rcu.
>>>> + * This is useful to guarantee that all shrinker invocations have 
>>>> seen an
>>>> + * update, before freeing memory.
>>>>    */
>>>>   void synchronize_shrinkers(void)
>>>>   {
>>>> -    down_write(&shrinker_rwsem);
>>>> -    up_write(&shrinker_rwsem);
>>>>       atomic_inc(&shrinker_srcu_generation);
>>>>       synchronize_srcu(&shrinker_srcu);
>>>>   }
>>>
>>> Just curious, callers of synchronize_shrinkers() don't want to have 
>>> parallel register_shrinker() and unregister_shrink() are completed?
>>> Here we only should wait for parallel shrink_slab(), correct?
>>
>> I think yes.
>>
>> The synchronize_shrinkers() is currently only used by TTM pool.
>>
>> In TTM pool, a shrinker named "drm-ttm_pool" is registered, and
>> the scan_objects callback will pick an entry from its own shrinker_list:
>>
>> ttm_pool_shrink
>> --> spin_lock(&shrinker_lock);
>>     pt = list_first_entry(&shrinker_list, typeof(*pt), shrinker_list);
>>     list_move_tail(&pt->shrinker_list, &shrinker_list);
>>     spin_unlock(&shrinker_lock);
>>
>> These entries have been removed from shrinker_list before calling
>> synchronize_shrinkers():
>>
>> ttm_pool_fini
>> --> ttm_pool_type_fini
>>     --> spin_lock(&shrinker_lock);
>>     list_del(&pt->shrinker_list);
>>     spin_unlock(&shrinker_lock);
>>     synchronize_shrinkers
>>
>> So IIUC, we only need to wait for the parallel shrink_slab() here. Like
>> its comment says:
>>
>> /* We removed the pool types from the LRU, but we need to also make sure
>>  * that no shrinker is concurrently freeing pages from the pool.
>>  */
> 
> Yes your analyses is completely correct.
> 
> I just didn't wanted to add another SRCU into the critical code paths of 
> the TTM pool just for device hot plug when I have that functionality 
> already.
> 
> We just make sure that no shrinker is running in parallel with 
> destruction of the pool. Registering and unregistering is harmless.

That's great, thanks for confirming.

Thanks,
Qi

> 
> Regards,
> Christian.
> 
>>
>> + CC: Christian König :)
>>
>> Thanks,
>> Qi
> 
> 
