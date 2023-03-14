Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634EB6B9009
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 11:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjCNKbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 06:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjCNKbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 06:31:23 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0271F5CECD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:30:28 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso4441095pjb.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 03:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678789769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/RQ7mWXsm5nOn5iTdig0BZupC24/edzn6kL9P/DXE88=;
        b=ZAJM0LIjrseRVXre3LRe6Al3qgCDvyKlNDAKUm0HNH8KyTcd1lbeCDLjCfMNRtWpou
         nZVtvgC7k4k+bqLCoZFbTZXaV9Z99VVW7aGCAR0UtaXvseq27HJQHgtLZ60mo42MyWmw
         kddHwuLnRBKrey0aGh3J7V5L6/Yx2RPX1H38/B0je4w+X/jNJre59GvKeKW1kK+jLq2n
         tODx8VAszrAI6aBkjDAtarfbiJkMHDTwXshgUUiQmAiFFuNNgMY3dM0iZR005fpVX/5q
         khM6PZopUlU234RXSU2Nx53h7jBBb3FcMe+OJhag7y81sRg8vi3FDU38JLaw//AmSKlh
         muCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678789769;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/RQ7mWXsm5nOn5iTdig0BZupC24/edzn6kL9P/DXE88=;
        b=SHi4xI4iQ6/VgXdYAMZ5O7OnG6ybqMbTHDDPti46Pb9nyPgOUU1QFzLAochXpDIpvV
         kOco7jtuYRD0tkoVjU7vJvbsHhhZ9BNGWQ6CnA9XjAn8D2/YAyVk0O+1KhS5UjyTbsmJ
         cFIDYTuFziW2178lmOmMivoCgs079cSf0Hzg1qb5/1p5RPndyQV9hoiehLGRHzV8DhVS
         01cjeOnCgG6Tf8BYqgZSxLx85/aln7FSRQQ16QQhKAQY6zRkLg4r+1noD2/+730OVB1v
         sk0B/p2O1WE3MatkopMC6ssy+pgW723E/+dreY/rBeKuPz6ySI394GJxkpiIWCLo9Zr3
         51KA==
X-Gm-Message-State: AO0yUKUtyeq9j5Ay5lRrW4kvepllpJ4oTGApwtxgieGAoZA3MNxDWXst
        g9oL6TGaOh+KczyakbtESXc/ZA==
X-Google-Smtp-Source: AK7set9mUSvk/kq+Bk4twl54/IKbbe4N6ucB0PK4Q97gelKvrEI7IzhE/28YDnL9BFzdhnlStGGixg==
X-Received: by 2002:a17:90b:1b0c:b0:237:97a3:1479 with SMTP id nu12-20020a17090b1b0c00b0023797a31479mr40754894pjb.28.1678789768905;
        Tue, 14 Mar 2023 03:29:28 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id gk14-20020a17090b118e00b00230b8431323sm1404793pjb.30.2023.03.14.03.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 03:29:28 -0700 (PDT)
Message-ID: <1b21ee01-116d-d432-7308-8515510c89f2@shopee.com>
Date:   Tue, 14 Mar 2023 18:29:24 +0800
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
 <b07c5e99-b251-2509-dfac-0f8e571d39d7@shopee.com>
 <70abf872-99d1-6ff4-3332-d86d320abff2@redhat.com>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <70abf872-99d1-6ff4-3332-d86d320abff2@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/14 17:09, David Hildenbrand wrote:
> On 14.03.23 09:05, Haifeng Xu wrote:
>>
>>
>> On 2023/3/8 17:13, David Hildenbrand wrote:
>>> On 08.03.23 10:03, Haifeng Xu wrote:
>>>>
>>>>
>>>> On 2023/3/7 10:48, Matthew Wilcox wrote:
>>>>> On Tue, Mar 07, 2023 at 10:36:55AM +0800, Haifeng Xu wrote:
>>>>>> On 2023/3/6 21:49, David Hildenbrand wrote:
>>>>>>> On 06.03.23 03:49, Haifeng Xu wrote:
>>>>>>>> mem_cgroup_oom_synchronize() has checked whether current memcg_in_oom is
>>>>>>>> set or not, so remove the check in handle_mm_fault().
>>>>>>>
>>>>>>> "mem_cgroup_oom_synchronize() will returned immediately if memcg_in_oom is not set, so remove the check from handle_mm_fault()".
>>>>>>>
>>>>>>> However, that requires now always an indirect function call -- do we care about dropping that optimization?
>>>>>>>
>>>>>>>
>>>>>>
>>>>>> If memcg_in_oom is set, we will check it twice, one is from handle_mm_fault(), the other is from mem_cgroup_oom_synchronize(). That seems a bit redundant.
>>>>>>
>>>>>> if memcg_in_oom is not set, mem_cgroup_oom_synchronize() returns directly. Though it's an indirect function call, but the time spent can be negligible
>>>>>> compare to the whole mm user falut preocess. And that won't cause stack overflow error.
>>>>>
>>>>> I suggest you measure it.
>>>>
>>>> test steps:
>>>> 1) Run command: ./mmap_anon_test(global alloc, so the memcg_in_oom is not set)
>>>> 2) Calculate the quotient of cost time and page-fault counts, run 10 rounds and average the results.
>>>>
>>>> The test result shows that whether using indirect function call or not, the time spent in user fault
>>>> is almost the same, about 2.3ms.
>>>
>>> I guess most of the benchmark time is consumed by allocating fresh pages in your test (also, why exactly do you use MAP_SHARED?).
>>>
>>> Is 2.3ms the total time for writing to that 1GiB of memory or how did you derive that number? Posting both results would be cleaner (with more digits ;) ).
>>>
>>
>> Hi Daivd, the details of test result were posted last week. Do you have any suggestions or more concerns about this change?
> 
> No, I guess it really doesn't matter performance wise.
> 
> One valid question would be: why perform this change at all? The redundancy doesn't seem to harm performance either.
> 
> If the change would obviously improve code readability it would be easy to justify. I'm not convinced, that is the case, but maybe for others.

Yes, this change doesn't optimize performance, just improve the code readability. 
It seems that nobody ack this change, should I change the commit message and resend this patch?

Thanks.
> 
> So FWIW, the change looks good to me and should not affect performance in one way or the other. So no objections from my side ...
> 
