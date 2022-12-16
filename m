Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D22464E82F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 09:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiLPIh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 03:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiLPIhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 03:37:54 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC1236C50
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:37:53 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id n4so1662582plp.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 00:37:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J2qNfvt65JwdwwMrbQB5NaE92K4Di8NRU5gAuThxsfA=;
        b=PMl1YQNQ+YwdUAZjP9JXJpeNsZknWwPh2b8M/gX3nCWz1X8lbhbmwu0iWPo1ENQ/BP
         SeW33qBrB5xq09MVP+6C57uJvt4MKlhhFmrXgdMBgKe7IDF1pEpP0IHocAq7SL76JTSV
         9aIxhVGRYVHPl/4dwKnZj8R6dpULUY18kfSod3Nftq6X/7y3gd0cClsmHTQCh2vncnK1
         OZY+MylS7T8zagT9DjwlaGSWw2ZBnJB6VUriuVM+oC0DcbQgK1nMoMShXerLiwrihnL9
         LEcAAWP1UEnLiuWTxXavquASt7v0PHN3JwenvGLRggURgev6oyic94gKR+DUYaa0ql+3
         Waqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=J2qNfvt65JwdwwMrbQB5NaE92K4Di8NRU5gAuThxsfA=;
        b=i/Ew/aBJiNvMGJy2FuUw71GRi7kLNcB0Hgvg7YmVihtstMlSes5MXZbMukVVaWxT5d
         LN+6SWbVCDnjiIHz6FUco8C6LJutPx33+NIcCaCog1WjsGt3S/BkyaneLqCbcwtAm3R3
         c/almJsVVB5SAFmdD5RJNIokYig+IiA5fqq7m0BKht6bT4Fl3Qj3yD29VJVNcxGZgV3X
         xjDrpm83EM7q40TN1yR/2BPc/FZAVlKkVhVTbqVUm4sqJrh2NjueByRfWElW+KBThFAB
         QA558pLalYwiKshOZR8sccJ/xcNHF/Lf4ugkb+4KpdGsT+k2+ovOIDCKsp8AYIFAI/c3
         84NA==
X-Gm-Message-State: ANoB5pmOIOIxA61Es9nUYBYG7Obs1a2JcvOb0tz8SFQgaZWesNbAbiN0
        dHqpPcbIqL/O5bM8d7q9EElM1Q==
X-Google-Smtp-Source: AA0mqf7Phzd/ndVYygqV1A2ma/zXcczqaZFCmSOL0pNPc7c/aOMACjXSWZi4/t82ug2FT+xPLx/K+A==
X-Received: by 2002:a17:90a:7890:b0:221:4338:a6ae with SMTP id x16-20020a17090a789000b002214338a6aemr22720466pjk.33.1671179872809;
        Fri, 16 Dec 2022 00:37:52 -0800 (PST)
Received: from [10.54.29.146] (static-ip-147-99-134-202.rev.dyxnet.com. [202.134.99.147])
        by smtp.gmail.com with ESMTPSA id x20-20020a17090ab01400b00219186abd7csm899082pjq.16.2022.12.16.00.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 00:37:52 -0800 (PST)
Message-ID: <c1d2cf16-8fba-4c79-4c1e-f95e5685e509@shopee.com>
Date:   Fri, 16 Dec 2022 16:37:49 +0800
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
 <a1b0d3c8-d6c2-2f22-5269-92a32f78614e@shopee.com>
 <20221216081716.7o4o33sg3eof2iww@google.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20221216081716.7o4o33sg3eof2iww@google.com>
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



On 2022/12/16 16:17, Shakeel Butt wrote:
> On Fri, Dec 16, 2022 at 03:50:49PM +0800, Haifeng Xu wrote:
>>
>>
>> On 2022/12/16 15:36, Shakeel Butt wrote:
>>> On Fri, Dec 16, 2022 at 03:28:53PM +0800, Haifeng Xu wrote:
>>>>
>>>>
>>>> On 2022/12/16 14:42, Shakeel Butt wrote:
>>>>> On Fri, Dec 16, 2022 at 09:43:02AM +0800, Haifeng Xu wrote:
>>>>>>
>>>>>>
>>>>>> On 2022/12/16 02:18, Shakeel Butt wrote:
>>>>>>> On Thu, Dec 15, 2022 at 09:19:07AM +0000, Haifeng Xu wrote:
>>>>>>>> The memory events aren't supported on root cgroup, so there is no need
>>>>>>>> to account MEMCG_OOM_KILL on root memcg.
>>>>>>>>
>>>>>>>
>>>>>>> Can you explain the scenario where this is happening and causing issue
>>>>>>> for you?
>>>>>>>
>>>>>> If the victim selected by oom killer belongs to root memcg, memcg_memory_event_mm
>>>>>> still counts the MEMCG_OOM_KILL event. This behavior is meaningless because the
>>>>>> flag of events/events.local in memory_files is CFTYPE_NOT_ON_ROOT. The root memcg
>>>>>> does not count any memory event.
>>>>>>
>>>>>
>>>>> What about v1's memory.oom_control?
>>>>>
>>>>  
>>>> The memory.oom_control doesn't set the CFTYPE_NOT_ON_ROOT flag. But oom_kill_disable or
>>>> under_oom actually only support non-root memcg, so the memory_events should be consistent
>>>> with them.
>>>
>>> Did you take a look at mem_cgroup_oom_control_read()? It is displaying
>>> MEMCG_OOM_KILL for root memcg. Irrespective it makes sense or not, you
>>> want to change behavior of user visible interface. If you really want to
>>> then propose for the deprecation of that interface.
>>
>> Yes, I have see it in mem_cgroup_oom_control_read() and I think that 
>> showing MEMCG_OOM_KILL for root memcg doesn't make much sense.
>>
> 
> It doesn't matter as there might already be users using it.
> 
>> Shoud I add the CFTYPE_NOT_ON_ROOT flag for cgroup v1?
>>
> 
> Before doing anything, I am still not seeing why we really need this
> patch? What exactly is the issue this patch is trying to solve? To me
> this patch is negatively impacting the readability of the code. Unless
> you are seeing some real production issues, I don't think we need to add
> any special casing for MEMCG_OOM_KILL here.

As we can see in memcg_memory_event(), memory event never be count in root
memcg. Passing the root memcg to it seems somewhat self-contradictory. Also,
cgroup v2 doesn't need this.
