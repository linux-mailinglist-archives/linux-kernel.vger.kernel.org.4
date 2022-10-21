Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EE607426
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJUJfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 05:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbiJUJfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 05:35:30 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F6F187DDD
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:35:25 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c24so1836539pls.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n5keT/+VSiNfRqOdCNBuwui1oti79FRunGV9Eaf99lw=;
        b=cOfcKBEJKb5ogsRTf/BkHS5EHuhfPLGWFXlln1pIK7Pv9ngy/r1YbFea9C+FCChzVh
         DsJztj2aK5CG+PuIocS6IdWBwQqflYGNiJn+ZWYEG/6tAHTtwc+UW3o50/olwHFVmvdA
         M/QNkgmHLKxLe1dL7MyxtR34OvkDRhh0eBtyoE66td+s0GcQgBSv0QYJYhL7m3wXJ6RX
         ofY8z2RNGJpf/xu0vFl9cR8YPraD0MxvwmdIYCLEEZkOW0ayRGQnK051Rh90yQhnRzSr
         kjqfTaElibgmrErcKYhfHQ0VfJuz5Q9Tv+t3CaSKUgKqcLtygnkgMEZP9q0Hv8+raZYC
         zndw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n5keT/+VSiNfRqOdCNBuwui1oti79FRunGV9Eaf99lw=;
        b=favpVt1IGIB+7To3s7pMbTE/6qMZANrA7Sk7PHFGMBjtYbX8dzJoTKwfzgtdYnntSl
         KoOILA7g7GJbUYwMhFVUp0TpRQuizWNyc/D7++9hsqRFmbRxUhmrn8+RUjd9jKWvGLeM
         3d7mhAKvoM5wqPwig9f4kYQs0a4kCDs+0N0cFTpajHgfqzREUDjN5lMsrcSVaZv7xN4f
         t2baELNwUGzuOzZa9WTtq150AaEoL3cWgloPuaivhlrW6FlERvM8TcnVqQUN/QAqHzYn
         VbTNiNJU0WEeOdJr+HRKcWzkO2cElm9cfFc6t5wrT63R5eAXuJyrhbw3OIe+61ARSavT
         Ju5w==
X-Gm-Message-State: ACrzQf0iaOd0E4+k5WtWuXlA89ZFtaewU5ccFDGR2vn7v8zvckd5YbEA
        1784EjctLRFN8yupRYj/0OHMIpmsrLnp8Q==
X-Google-Smtp-Source: AMsMyM7Ag/azwechDKsxIHcYl01JAXRf30c8f3l81hORa3maftOgZQ53DNeKk1IMbt2yQXZMvj9lKA==
X-Received: by 2002:a17:902:e841:b0:180:49a2:8e6c with SMTP id t1-20020a170902e84100b0018049a28e6cmr18296388plg.143.1666344914036;
        Fri, 21 Oct 2022 02:35:14 -0700 (PDT)
Received: from [10.255.20.103] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id u2-20020a170902e80200b001785dddc703sm14606696plg.120.2022.10.21.02.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Oct 2022 02:35:13 -0700 (PDT)
Message-ID: <03be9c79-bc59-cd4a-869b-ed4c85c61224@bytedance.com>
Date:   Fri, 21 Oct 2022 17:35:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.3
Subject: Re: [PATCH v6 3/4] sched/fair: Introduce SIS_CORE
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Barry Song <21cnbao@gmail.com>, linux-kernel@vger.kernel.org
References: <20221019122859.18399-1-wuyun.abel@bytedance.com>
 <20221019122859.18399-4-wuyun.abel@bytedance.com>
 <Y1IZ/DZ1SWMn0QDs@chenyu5-mobl1>
 <9ec8a474-d923-953c-0b73-02ba2fd6ea82@bytedance.com>
 <Y1IhQPWMX3TX+sYo@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Y1IhQPWMX3TX+sYo@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/21/22 12:34 PM, Chen Yu wrote:
> On 2022-10-21 at 12:30:56 +0800, Abel Wu wrote:
>> Hi Chen, thanks for your reviewing!
>>
>> On 10/21/22 12:03 PM, Chen Yu wrote:
>>> On 2022-10-19 at 20:28:58 +0800, Abel Wu wrote:
>>> [cut]
>>>> A major concern is the accuracy of the idle cpumask. A cpu present
>>>> in the mask might not be idle any more, which is called the false
>>>> positive cpu. Such cpus will negate lots of benefit this feature
>>>> brings. The strategy against the false positives will be introduced
>>>> in next patch.
>>>>
>>> I was thinking that, if patch[3/4] needs [4/4] to fix the false positives,
>>> maybe SIS_CORE could be disabled by default in 3/4 but enabled
>>> in 4/4? So this might facilicate git bisect in case of any regression
>>> check?
>>
>> Agreed. Will fix in next version.
>>
>>> [cut]
>>>> + * To honor the rule of CORE granule update, set this cpu to the LLC idle
>>>> + * cpumask only if there is no cpu of this core showed up in the cpumask.
>>>> + */
>>>> +static void update_idle_cpu(int cpu)
>>>> +{
>>>> +	struct sched_domain_shared *sds;
>>>> +
>>>> +	if (!sched_feat(SIS_CORE))
>>>> +		return;
>>>> +
>>>> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>>> +	if (sds) {
>>>> +		struct cpumask *icpus = to_cpumask(sds->icpus);
>>>> +
>>>> +		/*
>>>> +		 * This is racy against clearing in select_idle_cpu(),
>>>> +		 * and can lead to idle cpus miss the chance to be set to
>>>> +		 * the idle cpumask, thus the idle cpus are temporarily
>>>> +		 * out of reach in SIS domain scan. But it should be rare
>>>> +		 * and we still have ILB to kick them working.
>>>> +		 */
>>>> +		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
>>>> +			cpumask_set_cpu(cpu, icpus);
>>> Maybe I miss something, here we only set one CPU in the icpus, but
>>> when we reach update_idle_cpu(), all SMT siblings of 'cpu' are idle,
>>> is this intended for 'CORE granule update'?
>>
>> The __update_idle_core() is called by all the cpus that need to go idle
>> to update has_idle_core if necessary, and update_idle_cpu() is called
>> before that check.
>>
> I see.
> 
> Since __update_idle_core() has checked all SMT siblings of 'cpu' if
> they are idle, can that information also be updated to icpus?

I think this will simply fallback to the original per-cpu proposal and
lose the opportunity to spread tasks to different cores.
