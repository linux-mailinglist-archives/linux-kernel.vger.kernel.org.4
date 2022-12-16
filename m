Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64264E5B9
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 02:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiLPBnK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 20:43:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiLPBnI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 20:43:08 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73DD1BEAB
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:43:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id l10so851802plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 17:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M3bl4UlR2ZcmE+wbLjIQKp132H3xh9wcWxdKp3Ki0Vo=;
        b=WsOSjxTTxmG4Bnupyy9VvM+8kbXNSRMATvMEnnUODJ4+2jMio6CNxV1qGo3YVp4nMd
         MgzEhouemprQ5q8dnDTE9UmGNINZpujvxgiK/q46Iagxo5oS677SxK/EiaRuJAZpziXI
         n5C5gBIoMG8DF0eU5ISG5feyykXDcDJUcG/MaE9KGRlVz18feycKZA+mpb9IkETrZBLD
         sMORjfZ5r0Ogbf1hYFU9RUA2KmiSxDe3SXrHfVVVLN8whnfggQMyvTyfu6rC4qoCAIE/
         3si4zdSEUDWHy4y1/mxA3D0Xt+U44bR3AzjBhCm+7jmFhayV2MFTCM8s0A4BONMiu7z7
         FOEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M3bl4UlR2ZcmE+wbLjIQKp132H3xh9wcWxdKp3Ki0Vo=;
        b=7xl1ZMA5ed1DkVALvATHa39Q3VLt7ubQ5HYIa650K4tdgAdCm3fgEluBuEJ9Fcs5z8
         mYj+XSoqEhYslGYG3PUKFYiGSOdrItOPzXE82kBVpO9nMT4dyaaTGJQF4CHO9BdpSa62
         eTzXz5Gx3YiUyRCx+yj0Ls/RJk+5Yw/Q9BuwBVAMEDLVyu9GRAfapBcgl4ujyUxsQB5O
         J8LaVWmoIp6AffgQqGwnaA3MryiZjj9YTPTBGFyWTXIb9nTRBynIcUgxX2ACaNFRd9FA
         1zqVmaQXlxusqz/ClPvcL2XVSgeB3LqD7x1sPN94wxz7FfdbzEIgYOYyva/OXpSp01GM
         kGxw==
X-Gm-Message-State: ANoB5pmXkTtHd5vQ+645TrvubjXnA8P2MAu+8VH0AwfuAkACdaXG9I7q
        Ox525ivjxqR67FkrO0sSqWMPNw==
X-Google-Smtp-Source: AA0mqf4UJMWOHCpttM2yknN6XURNBSLmClQmRZksjZ03M37bZIYT6RFYs+nm6fY5gL4oJdW6EUWN/Q==
X-Received: by 2002:a17:903:14b:b0:189:596c:b20e with SMTP id r11-20020a170903014b00b00189596cb20emr28722840plc.48.1671154987270;
        Thu, 15 Dec 2022 17:43:07 -0800 (PST)
Received: from [10.54.29.146] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id i16-20020a170902cf1000b00190f5e3bcd9sm308551plg.23.2022.12.15.17.43.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 17:43:07 -0800 (PST)
Message-ID: <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
Date:   Fri, 16 Dec 2022 09:43:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH] mm/memcontrol: Skip root memcg in memcg_memory_event_mm
To:     Shakeel Butt <shakeelb@google.com>
Cc:     akpm@linux-foundation.org, roman.gushchin@linux.dev,
        songmuchun@bytedance.com, hannes@cmpxchg.org, vbabka@suse.cz,
        willy@infradead.org, vasily.averin@linux.dev,
        linux-kernel@vger.kernel.org
References: <20221215091907.763801-1-haifeng.xu@shopee.com>
 <20221215181803.ome46pkh6g7qu3t4@google.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221215181803.ome46pkh6g7qu3t4@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/12/16 02:18, Shakeel Butt wrote:
> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
>> The memory events aren't supported on root cgroup, so there is no need
>> to account MEMCG_OOM_KILL on root memcg.
>>
> 
> Can you explain the scenario where this is happening and causing issue
> for you?
> 
If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
does not count any memory event.

>> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
>> ---
>>  include/linux/memcontrol.h | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
>> index 567f12323f55..09f75161a3bc 100644
>> --- a/include/linux/memcontrol.h
>> +++ b/include/linux/memcontrol.h
>> @@ -1142,7 +1142,7 @@ static inline void memcg_memory_event_mm(struct mm_struct *mm,
>>  
>>  	rcu_read_lock();
>>  	memcg = mem_cgroup_from_task(rcu_dereference(mm->owner));
>> -	if (likely(memcg))
>> +	if (likely(memcg && !mem_cgroup_is_root(memcg)))
> 
> Even if we need this additional check, this is not the right place.
> 
>>  		memcg_memory_event(memcg, event);
>>  	rcu_read_unlock();
>>  }
>> -- 
>> 2.25.1
>>
