Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 326915B34EA
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbiIIKMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiIIKLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:11:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC669D5725
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:11:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 202so1110696pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SRI4wh7Fwu8h0zS14s8T21ZiMPBz23QkwFTFihu9AUA=;
        b=Q3vi/YCoUCLWrpIMMcaoZR48Vq4l561030ALbXoqQuSLIm/CIlFO3LnXnogY+j7JJi
         EwPoSlYZnhB4JPQ7rhY4IP8GDB6+39wko8foLrH61Oe+0oN3qCC+j7Q+xJhWZUvE0l4i
         JDl1/psKbC07ZE+Ec8TDhgDrbRJmW7hkNRH5V1VoywLmswXvZ5XKdX3DcxtZuouAcSS+
         XmYBPXfXbUbmOek5syM8Ag+ZRl02aI0FTnDxc543/AvXjqbG4x9NVZ6LvRCy+83Fll6X
         fl0TLjjzcvFWImCaAxcUDOtM9O22vTe/ABOjLhle/qRzkItqIIWzd42aplzhRPkahLHM
         BhJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SRI4wh7Fwu8h0zS14s8T21ZiMPBz23QkwFTFihu9AUA=;
        b=4tkw3hlPVHsALHF8V6vqN4SxFksIN98+Wayzw5lMi1ZdXjppHIaIk2FvZDsiPLFVqU
         z576LU8R1I7uEa/z9VVOb/jA8DEXfnPa5+27yYt4JaHezboXlciY6xHqCLbaI13ReP+t
         LYoYxpfD937oJTxmSmyXz6NbEQyNHj8fB0yPKVIFNaDL/Wg5vWMdhhDhFlR36ITsa4DW
         6ly56L/s4/H1/lv4czbGtbl7jkO4MBV2C6AHeL5lBwW0RGG6sLjQBJKzeUhSOuWKBTrM
         lqdluAwl6TrTYpc85ffVQCvZOVjzmsWti5gfusztLvJweNs3vCCFnp8Wd6F6l/QYbPMJ
         Vhdg==
X-Gm-Message-State: ACgBeo0i1PV/77IdEJeU0Mq6dLyRhwUjiZc9Rj3hRbRQGPmDv3WxpcPT
        la5eCRGCjFdWJsdLD9eW+hjzaZMRCE7KTg==
X-Google-Smtp-Source: AA6agR4o6H/0IjMorg/A/LFHczVUB7GNNTwHKm3z+Ae8Vss4eaYjdJLLkJPALAiyOE4gLleFDQDUFQ==
X-Received: by 2002:a63:b705:0:b0:434:731f:c233 with SMTP id t5-20020a63b705000000b00434731fc233mr11449228pgf.140.1662718302380;
        Fri, 09 Sep 2022 03:11:42 -0700 (PDT)
Received: from [10.255.170.59] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b0016c1a1c1405sm74107plf.222.2022.09.09.03.11.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 03:11:42 -0700 (PDT)
Message-ID: <b36277e8-130b-72de-3fbe-4fea4f202372@bytedance.com>
Date:   Fri, 9 Sep 2022 18:11:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v5 2/5] sched/fair: Limited scan for idle cores when
 overloaded
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-3-wuyun.abel@bytedance.com>
 <YxsHljS5uwt+cNF2@chenyu5-mobl1>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YxsHljS5uwt+cNF2@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/22 5:29 PM, Chen Yu wrote:
> On 2022-09-09 at 13:53:01 +0800, Abel Wu wrote:
>> The has_idle_cores hint could be misleading due to some kind of
>> rapid idling workloads, especially when LLC is overloaded. If this
>> is the case, then there will be some full scan cost incurred that
>> often fails to find a core.
>>
>> So limit the scan depth for idle cores in such case to make a
>> speculative inspection at a reasonable cost.
>>
>> Benchmark
>> =========
>>
>> Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
>> Xeon(R) Platinum 8260, with SNC configuration:
>>
>> 	SNC on:  4 NUMA nodes each of which has 12C/24T
>> 	SNC off: 2 NUMA nodes each of which has 24C/48T
>>
>> All of the benchmarks are done inside a normal cpu cgroup in a clean
>> environment with cpu turbo disabled.
>>
>> Based on tip sched/core 0fba527e959d (v5.19.0) plus previous patches
>> of this series.
>>
>> Results
>> =======
>>
>> hackbench-process-pipes
>>                           unpatched		  patched
>> (SNC on)
>> Amean     1        0.4470 (   0.00%)      0.4557 (  -1.94%)
>> Amean     4        0.5947 (   0.00%)      0.6033 (  -1.46%)
>> Amean     7        0.7450 (   0.00%)      0.7627 (  -2.37%)
>> Amean     12       1.1053 (   0.00%)      1.0653 (   3.62%)
>> Amean     21       1.9420 (   0.00%)      2.0283 *  -4.45%*
>> Amean     30       2.9267 (   0.00%)      2.9670 (  -1.38%)
>> Amean     48       4.7027 (   0.00%)      4.6863 (   0.35%)
>> Amean     79       7.7097 (   0.00%)      7.9443 *  -3.04%*
>> Amean     110     10.0680 (   0.00%)     10.2393 (  -1.70%)
>> Amean     141     12.5450 (   0.00%)     12.6343 (  -0.71%)
>> Amean     172     15.0297 (   0.00%)     14.9957 (   0.23%)
>> Amean     203     16.8827 (   0.00%)     16.9133 (  -0.18%)
>> Amean     234     19.1183 (   0.00%)     19.2433 (  -0.65%)
>> Amean     265     20.9893 (   0.00%)     21.6917 (  -3.35%)
>> Amean     296     23.3920 (   0.00%)     23.8743 (  -2.06%)
>> (SNC off)
>> Amean     1        0.2717 (   0.00%)      0.3143 ( -15.71%)
>> Amean     4        0.6257 (   0.00%)      0.6070 (   2.98%)
>> Amean     7        0.7740 (   0.00%)      0.7960 (  -2.84%)
>> Amean     12       1.2410 (   0.00%)      1.1947 (   3.73%)
>> Amean     21       2.6410 (   0.00%)      2.4837 (   5.96%)
>> Amean     30       3.7620 (   0.00%)      3.4577 (   8.09%)
>> Amean     48       6.7757 (   0.00%)      5.5227 *  18.49%*
>> Amean     79       8.8827 (   0.00%)      9.2933 (  -4.62%)
>> Amean     110     11.0583 (   0.00%)     11.0443 (   0.13%)
>> Amean     141     13.3387 (   0.00%)     13.1360 (   1.52%)
>> Amean     172     15.9583 (   0.00%)     15.7770 (   1.14%)
>> Amean     203     17.8757 (   0.00%)     17.9557 (  -0.45%)
>> Amean     234     20.0543 (   0.00%)     20.4373 *  -1.91%*
>> Amean     265     22.6643 (   0.00%)     23.6053 *  -4.15%*
>> Amean     296     25.6677 (   0.00%)     25.6803 (  -0.05%)
>>
>> Run to run variations is large in the 1 group test, so can be safely
>> ignored.
>>
>> With limited scan for idle cores when the LLC is overloaded, a slight
>> regression can be seen on the smaller LLC machine. It is because the
>> cost of full scan on these LLCs is much smaller than the machines with
>> bigger LLCs. So when comes to the SNC off case, the limited scan can
>> provide obvious benefit especially when the frequency of such scan is
>> relatively high, e.g. <48 groups.
>>
>> It's not a universal win, but considering the LLCs are getting bigger
>> nowadays, we should be careful on the scan depth and limited scan on
>> certain circumstance is indeed necessary.
>>
>> tbench4 Throughput
>>                           unpatched		  patched
>> (SNC on)
>> Hmean     1        309.43 (   0.00%)      301.54 *  -2.55%*
>> Hmean     2        613.92 (   0.00%)      607.81 *  -0.99%*
>> Hmean     4       1227.84 (   0.00%)     1210.64 *  -1.40%*
>> Hmean     8       2379.04 (   0.00%)     2381.73 *   0.11%*
>> Hmean     16      4634.66 (   0.00%)     4601.21 *  -0.72%*
>> Hmean     32      7592.12 (   0.00%)     7626.84 *   0.46%*
>> Hmean     64      9241.11 (   0.00%)     9251.51 *   0.11%*
>> Hmean     128    17870.37 (   0.00%)    20620.98 *  15.39%*
>> Hmean     256    19370.92 (   0.00%)    20406.51 *   5.35%*
>> Hmean     384    19413.92 (   0.00%)    20312.97 *   4.63%*
>> (SNC off)
>> Hmean     1        287.90 (   0.00%)      292.37 *   1.55%*
>> Hmean     2        575.52 (   0.00%)      583.29 *   1.35%*
>> Hmean     4       1137.94 (   0.00%)     1155.83 *   1.57%*
>> Hmean     8       2250.42 (   0.00%)     2297.63 *   2.10%*
>> Hmean     16      4363.41 (   0.00%)     4562.44 *   4.56%*
>> Hmean     32      7338.06 (   0.00%)     7425.69 *   1.19%*
>> Hmean     64      8914.66 (   0.00%)     9021.77 *   1.20%*
>> Hmean     128    19978.59 (   0.00%)    20257.76 *   1.40%*
>> Hmean     256    20057.49 (   0.00%)    20043.54 *  -0.07%*
>> Hmean     384    19846.74 (   0.00%)    19528.03 *  -1.61%*
>>
>> Conclusion
>> ==========
>>
>> Limited scan for idle cores when LLC is overloaded is almost neutral
>> compared to full scan given smaller LLCs, but is an obvious win at
>> the bigger ones which are future-oriented.
>>
>> Suggested-by: Mel Gorman <mgorman@techsingularity.net>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 26 +++++++++++++++++++++-----
>>   1 file changed, 21 insertions(+), 5 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5af9bf246274..7abe188a1533 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6437,26 +6437,42 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   		time = cpu_clock(this);
>>   	}
>>   
>> -	if (sched_feat(SIS_UTIL) && !has_idle_core) {
>> +	if (sched_feat(SIS_UTIL)) {
> [1/5] patch added !has_idle_core, but this patch removes the check.
> I'm trying to figure out the reason. Is it to better illustrating the
> benchmark difference?

This patch moves the check inside the SIS_UTIL block to limit the scan
depth when (!nr_idle_scan && has_idle_core), but if !nr_idle_scan which
means the LLC is not overloaded, a full scan will be triggered like
before. So in general, this patch turns nr_idle_scan to a boolean value
if has_idle_core.

Best Regards,
Abel
