Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE5A69638C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 13:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbjBNMd6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 07:33:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbjBNMdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 07:33:35 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1FC5268
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:33:09 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id be8so16900478plb.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 04:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112; t=1676377989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jutmcD4jSNATI+S4GeRwN2zwV5Pm0sRRKs806WAK/7M=;
        b=yUnXjW3hI5+VBZQIkv9K9DgzqBnUW4hN3QxbGeAkFx1qy3Z6AXr0EZ4b38VDRcNanl
         8oIV/53oPXQsw0HvuzxZM5sGPBTWwdmL84SRBElBoVwJ7ZevF7F69YT9hwWnVzNK1KTC
         Q0qETFhPlhJUQJbsMvC1n55p2+iWLaWu0vS61+zUmHMAQeEySuWLICyyj1ZaWU/GTcdd
         XocogZzZOFT4vRgQ5yiOt3yIapHAusNlFKtNa3mG7C3TSVlUUxPWSSQ2wzbmLncgO0On
         HSHX6pfEfZeGnvsitebZ1569wquBd4bQBNVOzUY4R8iWcYpXl5SJFWQdZwkfPPE9wCdC
         mZ0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676377989;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jutmcD4jSNATI+S4GeRwN2zwV5Pm0sRRKs806WAK/7M=;
        b=kVwwy3EOGa4iCQpVvRjJ9Wl4bmm9ypivKXvc2bW77P03fVgDDE3JZF9CXjLd752AaS
         TeX2XCm9cAd3FPdP9QCumPvqqCf+KnEG5C5M1hDvVCb1DaP8LTcma84qf4lFvLeMed2W
         JnkrRVW49v+6/DNNRl87bR/LePYsuxEpxCaf3a9UbeQkVVUvhTZNU2WvtpLu3Vv/j7hr
         2gGKRQ1eEfVFhLMlEI0ZCjIZhRL9woUwCTXdTnLNBmgB8ypyMdaws4Lq21FSptAHJwZJ
         ll+K7UeOi+PGMHwLFPrPqNP1zG1eT7HJ7SXprs3ctNz7oEgV5BovxF/hJU2CWw2qiYlW
         QelA==
X-Gm-Message-State: AO0yUKXYejV+e6uVc0ijLWinu9DGnxBRjyA+tkpKe1PXrY6tdPVL4xqV
        cJEYWiGStO8m/+3G3lIxh1jdRg==
X-Google-Smtp-Source: AK7set9w9LKMqYtL583q3vYcQx6jjoA3kSbBRe2e1eKS6HeqJqPJ60al1GH7DN+dxppcIpYG1U9e+w==
X-Received: by 2002:a17:902:f549:b0:197:8e8e:f15 with SMTP id h9-20020a170902f54900b001978e8e0f15mr2748471plf.6.1676377989265;
        Tue, 14 Feb 2023 04:33:09 -0800 (PST)
Received: from [10.200.11.190] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id y17-20020a170902b49100b001947ba0ac8fsm10063019plr.236.2023.02.14.04.33.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 04:33:08 -0800 (PST)
Message-ID: <632e6be8-f1e2-b57f-a70c-f3aec3adabd1@bytedance.com>
Date:   Tue, 14 Feb 2023 20:33:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] mm: page_alloc: don't allocate page from memoryless nodes
Content-Language: en-US
To:     Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>,
        Vlastimil Babka <vbabka@suse.cz>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Teng Hu <huteng.ht@bytedance.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <muchun.song@linux.dev>
References: <20230212110305.93670-1-zhengqi.arch@bytedance.com>
 <2484666e-e78e-549d-e075-b2c39d460d71@suse.cz>
 <85af4ada-96c8-1f99-90fa-9b6d63d0016e@bytedance.com>
 <c6908bd0-5f76-47eb-2b77-ce8f7bf9fbff@suse.cz>
 <eefc40e5-a14b-22c5-3480-6786afa1c8f4@redhat.com>
 <Y+tXrK/g1Nrd/q1h@kernel.org>
 <67240e55-af49-f20a-2b4b-b7d574cd910d@gmail.com>
 <22f0e262-982e-ea80-e52a-a3c924b31d58@redhat.com>
 <dbfbd982-27f3-0d72-49e0-d3dd5fe636a8@bytedance.com>
 <4386151c-0328-d207-9a71-933ef61817f9@redhat.com>
 <Y+t0Bhu7BCzH2Dp4@kernel.org>
From:   Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Y+t0Bhu7BCzH2Dp4@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/2/14 19:44, Mike Rapoport wrote:
> (added x86 folks)
> 
> On Tue, Feb 14, 2023 at 12:29:42PM +0100, David Hildenbrand wrote:
>> On 14.02.23 12:26, Qi Zheng wrote:
>>> On 2023/2/14 19:22, David Hildenbrand wrote:
>>>>
>>>> TBH, this is the first time I hear of NODE_MIN_SIZE and it seems to be a
>>>> pretty x86 specific thing.
>>>>
>>>> Are we sure we want to get NODE_MIN_SIZE involved?
>>>
>>> Maybe add an arch_xxx() to handle it?
>>
>> I still haven't figured out what we want to achieve with NODE_MIN_SIZE at
>> all. It smells like an arch-specific hack looking at
>>
>> "Don't confuse VM with a node that doesn't have the minimum amount of
>> memory"
>>
>> Why shouldn't mm-core deal with that?
> 
> Well, a node with <4M RAM is not very useful and bears all the overhead of
> an extra live node.
> 
> But, hey, why won't we just drop that '< NODE_MIN_SIZE' and let people with
> weird HW configurations just live with this?

Just to sum up, whether we deal with '< NODE_MIN_SIZE' or not, IIUC, the
following two should be modified:

1) we should skip memoryless nodes completely in find_next_best_node():

@@ -6382,8 +6378,11 @@ int find_next_best_node(int node, nodemask_t
*used_node_mask)
          int min_val = INT_MAX;
          int best_node = NUMA_NO_NODE;

-       /* Use the local node if we haven't already */
-       if (!node_isset(node, *used_node_mask)) {
+       /*
+        * Use the local node if we haven't already. But for memoryless
local
+        * node, we should skip it and fallback to other nodes.
+        */
+       if (!node_isset(node, *used_node_mask) && node_state(node,
N_MEMORY)) {
                  node_set(node, *used_node_mask);
                  return node;
          }

This also fixes the bug mentioned in commit message.

2) we should call node_states_clear_node() before build_all_zonelists()
in offline_pages():

@@ -1931,12 +1931,12 @@ int __ref offline_pages(unsigned long start_pfn, 
unsigned long nr_pages,
         /* reinitialise watermarks and update pcp limits */
         init_per_zone_wmark_min();

+       node_states_clear_node(node, &arg);
         if (!populated_zone(zone)) {
                 zone_pcp_reset(zone);
                 build_all_zonelists(NULL);
         }

-       node_states_clear_node(node, &arg);
         if (arg.status_change_nid >= 0) {
                 kcompactd_stop(node);
                 kswapd_stop(node);

Otherwise, the node whose N_MEMORY state is about to be cleared will 
still be established in the fallback list of other nodes.

Right?

Thanks,
Qi

>   
>> I'd appreciate an explanation of the bigger picture, what the issue is and
>> what the approach to solve it is (including memory onlining/offlining).
>>
>> -- 
>> Thanks,
>>
>> David / dhildenb
>>
> 

-- 
Thanks,
Qi
