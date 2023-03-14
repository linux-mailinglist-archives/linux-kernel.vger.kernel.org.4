Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC996B8C98
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjCNIGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231124AbjCNIGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:06:12 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23027E8A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:53 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id a9so15687641plh.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 01:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1678781153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zofjmH9Q5aLfBFZc7HV7oQNC01Mahqnpw6fc67IAu0Q=;
        b=TqPeHLlxt+F38sKCcnkgaOT5lWLkZzxRtnCfpoXlUWquYoDTvbMD+eM86TnuaxG8B3
         VtNATnpKMEgHr/It1hiU/FWA+IlY7IJgp0stC2njjzp+von3ODGndgtHKQuAczxg3HJX
         YENfeINnpQwnjlH/J4VhinGw1kQZnr+HIHMwQVFpIF8AXxpxH7q3atgGxkTA3AlU6cav
         6BRdebn3MYNCutep7ZOPqKEBX3ej9JjDLhMBBQB/EOzMNFTcTK0sBN9ddk3Loiikppp1
         zkvcUgG1u8WeMwUauv7MpH/dBy7RfdT4Ofdsw/cvpWxdN99mJzoP6HGIgsTeWy6xBJCD
         pULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678781153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zofjmH9Q5aLfBFZc7HV7oQNC01Mahqnpw6fc67IAu0Q=;
        b=7jfOnIvJtLb0Ev+ToxrgXto+YVX1ion0wtWh3PMFLi02/BK+jRKv6bJfSbzyR3IhEX
         0+Lg98Km652jQkyIOzXRlU4lEh5sSbWrLAEWBuwzzPahScQ4sQj5bIMPE03QpYf2P7NA
         AQ21yETZuCwIXlLX/AlpDmKnw4iIQs6xqvsRdcGvnnMbTpfaS8hvYZG8TddC3DEtEYjE
         KD28F3+5aMhv2JlIk+ggCUp14H/s7SaJlqacMOwjmh1e2ApPXcyBSld0MDR4yTQP70/B
         JmQMcXESEvmYFO9LC1+tH73rOqqw4W0VIAzHu2Gcp2yjflTAZFdoKw4WzS6nzMqnYryd
         I3yw==
X-Gm-Message-State: AO0yUKX709lc0DKq4dgGCqeg2pw+Z7E1xTfe/Yefe/NO73AfoaUhSan2
        jHA5fUg72LJFVv43fuBCGVJ+02gwW3ZsvXkIsVZbzQ==
X-Google-Smtp-Source: AK7set80ZkoLirdNQgNwxAYx5Ddt06terUlVQgUQ+9/FrNVH2HWodhhM0lz+fm4NourTSW9hbCS7CQ==
X-Received: by 2002:a17:903:187:b0:19d:16fa:ba48 with SMTP id z7-20020a170903018700b0019d16faba48mr45153942plg.28.1678781153069;
        Tue, 14 Mar 2023 01:05:53 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id j7-20020a170903024700b001a043e84bf0sm1091071plh.209.2023.03.14.01.05.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 01:05:52 -0700 (PDT)
Message-ID: <b07c5e99-b251-2509-dfac-0f8e571d39d7@shopee.com>
Date:   Tue, 14 Mar 2023 16:05:47 +0800
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
> 
> Is 2.3ms the total time for writing to that 1GiB of memory or how did you derive that number? Posting both results would be cleaner (with more digits ;) ).
> 

Hi Daivd, the details of test result were posted last week. Do you have any suggestions or more concerns about this change?

Thanks.
