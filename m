Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A51B64E7EC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 08:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiLPHu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 02:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiLPHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 02:50:56 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2992711C0A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:50:55 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id c13so1246421pfp.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 23:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=plqPOP9E2ubaoFS6DW5h9ydb8poIl/D4ntZ2wVLE5E4=;
        b=juS+nlVgzXB56Is+QqBJn2KSMNY50ggwA3GhylkR4NV+7iKJRyDprWzbFYHSU7a83K
         Z464sRmXE5SDWbekroWAh6eZqujmB6DwngG9ACGNnnmOIbShKtMY3K9zBFpis5l608qy
         gbW7B6+1LR0vCv99Ebh5peUqSdKwrmstPBshCX5A0FTKuzZ6ZgSQlBiCUCc34OL/+g2w
         vxfKDZZopoCywV3a493NiA2LfuI+CFJF6s8XG61SXc2kEeu1jcvIq990VGCwGoG5TeZX
         xvxB6ORI7WbNe2Hx95c/zs/TKsPFqmD7ASlqadDBFkFbyOIBQhQkYU2wjN3S09EM7JDh
         5HLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plqPOP9E2ubaoFS6DW5h9ydb8poIl/D4ntZ2wVLE5E4=;
        b=brv3b8v4yQGXtLHA/V0ISLWqYgxUGZ5aWivbuT19jab5W8ugdF4R5j19cQJ4JpBi9P
         Dx/3cfshzLPNsL5Tw/Fw0UIvtvET4x/JV9u+Jhyw6vVEasQ9QdD9cuDcc+/CI6EfAkJv
         9S0Am13TMzx7LvDsQ+bdFinu27TNJHM+7FrwuJhhTSo3j1hPzKhP/pa8RAyQPCO6UPAd
         oOq0yxfk/M9sal71kvxT5JPOGkewQICIdMNnx5xtMnu55uxIyvg9ME/D5Nh8kUw8MT4T
         utJK1zuzI4VLFORndMr9dz2ZSfypdtVg+WnEOqnJhkuJ54MLwyORkwrQ+zjZy78tSvne
         sXJg==
X-Gm-Message-State: ANoB5pmc6P0vLM7AD8t9haXR/jXjEGolDwQkwjRVEy6YrNdvGNvAWUgl
        MqkVWkbT50yk8kKCsNcRuNOcgQ==
X-Google-Smtp-Source: AA0mqf5giShMulLT63zqcqb2jYMomIH45GR1i9Q6ybdNfQokeF9aEBtdAp7yRTA5N3C9LDaMK4H0VQ==
X-Received: by 2002:a05:6a00:1d04:b0:578:8533:9573 with SMTP id a4-20020a056a001d0400b0057885339573mr17844250pfx.22.1671177054676;
        Thu, 15 Dec 2022 23:50:54 -0800 (PST)
Received: from [10.54.29.146] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id p8-20020aa79e88000000b005748029bab8sm817596pfq.156.2022.12.15.23.50.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Dec 2022 23:50:54 -0800 (PST)
Message-ID: <a1b0d3c8-d6c2-2f22-5269-92a32f78614e@shopee.com>
Date:   Fri, 16 Dec 2022 15:50:49 +0800
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
 <abec13da-c74a-0fd8-74e0-3cdc547e4e08@shopee.com>
 <20221216064210.krxtxebuwc7dijzu@google.com>
 <13c73151-4b28-4324-afd5-8b84b82bc25d@shopee.com>
 <20221216073640.xjtpsyigoej77v5h@google.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221216073640.xjtpsyigoej77v5h@google.com>
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



On 2022/12/16 15:36, Shakeel Butt wrote:
> On Fri, Dec 16, 2022 at 03:28:53PM +0800, Haifeng Xu wrote:
>>
>>
>> On 2022/12/16 14:42, Shakeel Butt wrote:
>>> On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
>>>>
>>>>
>>>> On 2022/12/16 02:18, Shakeel Butt wrote:
>>>>> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
>>>>>> The memory events aren't supported on root cgroup, so there is no need
>>>>>> to account MEMCG_OOM_KILL on root memcg.
>>>>>>
>>>>>
>>>>> Can you explain the scenario where this is happening and causing issue
>>>>> for you?
>>>>>
>>>> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
>>>> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
>>>> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
>>>> does not count any memory event.
>>>>
>>>
>>> What about v1's memory.oom_control?
>>>
>>  
>> The memory.oom_control doesn't set the CFTYPE_NOT_ON_ROOT flag. But oom_kill_disable or
>> under_oom actually only support non-root memcg, so the memory_events should be consistent
>> with them.
> 
> Did you take a look at mem_cgroup_oom_control_read()? It is displaying
> MEMCG_OOM_KILL for root memcg. Irrespective it makes sense or not, you
> want to change behavior of user visible interface. If you really want to
> then propose for the deprecation of that interface.

Yes, I have see it in mem_cgroup_oom_control_read() and I think that 
showing MEMCG_OOM_KILL for root memcg doesn't make much sense.

Shoud I add the CFTYPE_NOT_ON_ROOT flag for cgroup v1?

