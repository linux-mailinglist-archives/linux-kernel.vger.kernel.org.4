Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50FDA6B193B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 03:33:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjCICdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 21:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjCICdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 21:33:09 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF42BF28
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:33:06 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id b20so619381pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 18:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678329186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eWBrUih/RRXh6LptA2jqLQdR79LGfEQflDsOHRkNIYE=;
        b=TndqUjuz2mhJFsHfOlTwlNVgmSD8i0JOsy5RdKaE+OooTm/W5IcvtRod7Jj015SPmK
         3jTaQOKL39NKi7wJcXvgYamueR8FWE91YVcQC7WL0odLoO+33gplRO1qY+KI+kqN/1hf
         REe3qIWTvHS69jUUmmIuBXVUzYL+bIaKsi/z98XYGKVBalJUpYdyuSBP0/PpdTE7RCer
         61+NSoLRWLxr13xZGDBDh+MBp1Z0wlBjPrHZUK4injVDofq9LtLkt2v54/0T3n7dO1Vd
         aOq101hb8lm0LSjt3NgoN3NMpy4rIq0F9pLuZMnHMd0esDZvO5UE6LcqqVk6refFWpKb
         tsWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678329186;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eWBrUih/RRXh6LptA2jqLQdR79LGfEQflDsOHRkNIYE=;
        b=fcKecLUOiHbulCedrTexoZ85LMID54crWqavPj3TqgI8lHVUJ97Q3fn8q5jX/Nln7B
         DY1S+TwqegDf/Q+8z9eKXUlSAlMaF5xM2N6LAsSQP4yMAYeP2tL/K/Zl3DCCKm7zECGF
         PQVf1WD8dizIu92N0pcVl5Ka/I+gChVYOEzRk7ibofJYEiRcOFPBUTEDh2/ETmANsQmr
         b7RhmDjCogsaDIq3OdL4j9U58aRi1SdNULivnS26HHUb4UWsTTZItY6cOqxyqLDBxmTO
         z7R3Hj9k5imYRkjb+9IHoOEIdam4QCJCvAs9SAAg23Wc0yaX9UUa+n7WzMG18VDHkneI
         7UmA==
X-Gm-Message-State: AO0yUKXdF6O15VZUTstnQS8O0PmXza8D1F+SsVDwEYByPx5jQAIKOBjI
        AqdC7GdEn++AFwsKOmdEi8j2/wjYmhKaox95rCM=
X-Google-Smtp-Source: AK7set+aAhmSeEQpM5/fO0SMwY482EMidsA9DAGvcoxnyQXhsAvVF4n/vUkj32hjwPt95szWOR1DGQ==
X-Received: by 2002:aa7:9418:0:b0:5cd:d766:8a26 with SMTP id x24-20020aa79418000000b005cdd7668a26mr17477255pfo.8.1678329186221;
        Wed, 08 Mar 2023 18:33:06 -0800 (PST)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b005dc70330d9bsm10009545pfa.26.2023.03.08.18.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 18:33:05 -0800 (PST)
Message-ID: <060b2056-35c3-dbd3-e097-a53423737e45@shopee.com>
Date:   Thu, 9 Mar 2023 10:33:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] mm: remove redundant check in handle_mm_fault
To:     David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230306024959.131468-1-haifeng.xu@shopee.com>
 <df3997ed-a844-597b-fbb1-154caad78543@redhat.com>
 <354360d5-dce6-a11c-ee61-d41e615bfa05@shopee.com>
 <ZAamFX/hq6Y/iNJb@casper.infradead.org>
 <6df72872-2829-47ab-552c-7ef8a6470e6f@shopee.com>
 <562e9cc3-d0aa-23e9-bd19-266b5aef2ae7@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <562e9cc3-d0aa-23e9-bd19-266b5aef2ae7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/8 17:13, David Hildenbrand wrote:
> On 08.03.23 10:03, Haifeng Xu wrote:
>>
>>
>> On 2023/3/7 10:48, Matthew Wilcox wrote:
>>> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>>>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>>>> set or not, so remove the check in handle_mm_fault().
>>>>>
>>>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>>>
>>>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>>>
>>>>>
>>>>
>>>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>>>
>>>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible
>>>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
>>>
>>> I suggest you measure it.
>>
>> test steps:
>> 1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
>> 2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.
>>
>> The test result shows that whether using indirect function call or not, the time spent in user fault
>> is almost the same, about 2.3ms.
> 
> I guess most of the benchmark time is consumed by allocating fresh pages in your test (also, why exactly do you use MAP_SHARED?).

Yes, most of the time consumption is page allocation. MAP_SHARED or MAP_PRIVATE doesn't affect the result，so I just use one of them at will,
although no process share memory with it.

> 
> Is 2.3ms the total time for writing to that 1GiB of memory or how did you derive that number? Posting both results would be cleaner (with more digits ;) ).
> 

I'm sorry I got the measuring unit wrong，actually it is 2.3us for every page fault. The details are as follows.

without change
-------------------------------------------------------------------------------------------------
cost time(ms)			number of page fault			time of page faults(ns)
599				262144					2285
590				262144					2251
595				262144					2270
595				262144					2270
594				262144					2266
597				262144					2277
596				262144					2274
598				262144					2281
594				262144					2266
598				262144					2281
-------------------------------------------------------------------------------------------------
									average: 2272

with change
-------------------------------------------------------------------------------------------------
cost time(ms)			number of page fault			time of page faults(ns)
600				262144					2289
597				262144					2277
596				262144					2274
596				262144					2274
597				262144					2277
595				262144					2270
598				262144					2281
588				262144					2243
596				262144					2274
598				262144					2281
-------------------------------------------------------------------------------------------------
									average: 2274

