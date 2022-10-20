Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00F13606924
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 21:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbiJTTw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 15:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiJTTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 15:52:54 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0031FAE6D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:52:52 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id w18so2030631ejq.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 12:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eoZ8TXCjNQL8+j4LJ9UpNMeIarr6RT3aU+ye9ienYGM=;
        b=bZLF4Eq0QD92L2z3qOirPPs2brHBplyiE3jeISPfCRHAbsNUdoeZBz2AvW4yBKnnJp
         XV61W4/8DVFsf3RgXjLZS+3IOLHKEaz+Rq9UDnUrrSMPh4uk0ESQfrV7nEjgMa4iUnO7
         GLAYXaDEhUK30ts9HCgGQC40PUUfUIIgu720dpCdDPDW49rnon0GLz3CvMtOBIhEHATe
         vyb7YOH70Jfl2TXpYLxfBc8lmJtqBCuEa0STMNc3X8mraI/7Urd/3YFVhH2N9i49GCSh
         lINdfl8Flg/x0tJurpKV/blPfurAKYc2gN7ELHVuhdTA5pdt77aUnbUVwutn/+IF51tG
         AiPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eoZ8TXCjNQL8+j4LJ9UpNMeIarr6RT3aU+ye9ienYGM=;
        b=fiDpsa0gHr5gsSIFs0JJczLSmALDcLWBPY4JhdIjdGnbGzQ0MRwJ76HFxL7ZC+7B83
         23DMkvF13chNB81KcPWwXGMin4TdhFYdL27vJuN1VEdBKsy4RRqi+I2VJF6+HDAY++R8
         9mRDKkyRjfh2am1A1Wakp58qwL0tK1oHH6vYS6KzT85Py1lnKFgfw4EuzJsvCs9iZbKH
         pHc8vmsNHHEjM4n8L1PhkGenoVI54++MYStCT5RCfs9xkd24N9u9AshzmzmFkBiRV+OE
         ZnNLtQSpn/NHzs5gNMBSLjZ/GF/F3kaDlWQpqJyIAn3ZyhYUMsamqhSuKHyMy0eLVy3G
         9yGg==
X-Gm-Message-State: ACrzQf0Ii3a/aB8a4YcIkzwYynF1da9aN/Z5Ug7v+LH29YuuwLt/OiRc
        rg+joZQmnlAyRC5a7doaGGXupg==
X-Google-Smtp-Source: AMsMyM4c/7V2H5LVXZfpSdztmKe72PZ3/flR7eZsOVBtHHfagkxjODm2ucnLVRm7cuGG95pAAACzNA==
X-Received: by 2002:a17:907:a429:b0:78d:b517:735 with SMTP id sg41-20020a170907a42900b0078db5170735mr12542588ejc.318.1666295570974;
        Thu, 20 Oct 2022 12:52:50 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:58a9:754a:8d78:b300? ([2a05:6e02:1041:c10:58a9:754a:8d78:b300])
        by smtp.googlemail.com with ESMTPSA id x9-20020a170906710900b0073a20469f31sm10718154ejj.41.2022.10.20.12.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 12:52:50 -0700 (PDT)
Message-ID: <71438330-dbfe-a10c-f289-24ba25c0d55f@linaro.org>
Date:   Thu, 20 Oct 2022 21:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional
 util-awareness
Content-Language: en-US
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com>
 <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y1F0GYlJJOnFQeYe@e126311.manchester.arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Kajetan,

On 20/10/2022 18:20, Kajetan Puchalski wrote:
> Hi Rafael,
> 
>> The avg_util value tells us nothing about how much the CPU is going to
>> be idle this time and it also tells us nothing about the
>> latency-sensitivity of the workload.
>>
>> Yes, it tells us how much idle time there was on the given CPU in the
>> past, on the average, but there is zero information about the
>> distribution of that idle time in it.
>>
>> So in the first place please tell me why it fundamentally makes sense
>> to use avg_util in CPU idle time management at all.
> 
> I have an alternative suggestion that could be a reasonable way forward
> here. Instead of applying util-awareness on top of TEO where it would
> have to be reconciled with how TEO is currently expected to work, I just
> wrote a simple completely new governor which operates only on timer
> events alongside util values.

I second the idea. I took a long time to investigate how to improve the 
governor and reached the conclusion having a dedicated governor for 
mobile platform makes sense. Also the behavior is very platform dependent.

Regarding the utilization, one of the issue is the kernel threads 
preventing a task to wake up on the same CPU and forcing its migration 
at wake up time. So the prediction is screwed up at that time.

There is a paper talking this issue [1]

I've done a 'mobile' governor, including the next interrupt prediction 
[2]. It is very simple and almost has the same results as the teo on my 
platform (rock960).

I'm not planning to upstream it because I don't have spare time to 
improve the results and take care of the IPIs. part.

Also the paradigm is radically different and you may be interested in 
the approach.

So if you want to rework, improve, test, upstream it, feel free to reuse 
the code.

   -- Daniel

[1] Dynamic workload characterization for power efficient scheduling on 
CMP systems : https://cseweb.ucsd.edu//~tullsen/islped10.pdf

[2] 
https://git.linaro.org/people/daniel.lezcano/linux.git/commit/?h=cpuidle/mobile-governor-v5.1&id=de1edb05e3c342f0738b414aa84263d6555b7462


> The idea is this:
> 1. Find the deepest state based on residency and time until the next timer event
> 2. If sched_cpu_util() is above the threshold, select a shallower non-polling state
> 
> There's no other metrics or anything else under the current
> implementation. I can't say how it would work on Intel systems and in
> the presence of more idle states but having a completely separate
> governor would be very useful for us to tune it specifically for our use
> cases and types of systems (ie. ones with 2 idle states and no polling
> states).
> 
> As it stands it performs quite well and achieves better results
> (especially in terms of latency) than both menu & TEO but slightly worse
> than the previously suggested TEO + util. As far as we're concerned
> that's okay, we can work from there to try to find a way of doing
> metrics or improving the algorithm that would be more tailored to using
> the util approach. I think it's much cleaner than what we were
> discussing previously since that was effectively overriding most of what
> TEO was doing.
> 
> Here are some numbers to visualize the results. They were all obtained
> in the same way as the ones in the cover letter so you can refer to that
> in case something isn't clear.
> 
> 'teo_util' is of course TEO + util as in the patchset.
> 'idleutil' is this entirely new proposed minimal governor.
> 
> 1. Geekbench 5 (latency-sensitive, heavy load test)
> 
> +-----------------+----------+---------+-------------+
> | metric          | kernel   |   value | perc_diff   |
> |-----------------+----------+---------+-------------|
> | multicore_score | menu     |  2832.3 | 0.0%        |
> | multicore_score | teo      |  2815.3 | -0.6%       |
> | multicore_score | teo_util |  2880.6 | 1.7%        |
> | multicore_score | idleutil |  2859.3 | 0.95%       |
> +-----------------+----------+---------+-------------+
> 
> Percentages & types of idle misses
> 
> +-----------+-------------+--------------+
> | kernel    | type        |   percentage |
> |-----------+-------------+--------------|
> | menu      | too deep    |      15.613% |
> | teo       | too deep    |       9.376% |
> | teo_util  | too deep    |       4.581% |
> | idleutil  | too deep    |       5.464% |
> | menu      | too shallow |       2.611% |
> | teo       | too shallow |       6.099% |
> | teo_util  | too shallow |      14.141% |
> | idleutil  | too shallow |      13.282% |
> +-----------+-------------+--------------+
> 
> Power usage [mW]
> 
> +--------------+----------+----------+---------+-------------+
> | chan_name    | metric   | kernel   |   value | perc_diff   |
> |--------------+----------+----------+---------+-------------|
> | total_power  | gmean    | menu     |  2705.9 | 0.0%        |
> | total_power  | gmean    | teo      |  2668.2 | -1.39%      |
> | total_power  | gmean    | teo_util |  2710.2 | 0.16%       |
> | total_power  | gmean    | idleutil |  2657.9 | -1.78%      |
> +--------------+----------+----------+---------+-------------+
> 
> Wakeup latency
> 
> +-----------------+----------+----------+-------------+-------------+
> | comm            | metric   | kernel   |       value | perc_diff   |
> |-----------------+----------+----------+-------------+-------------|
> | AsyncTask #1    | gmean    | menu     | 66.85μs     | 0.0%        |
> | AsyncTask #1    | gmean    | teo      | 66.79μs     | -0.09%      |
> | AsyncTask #1    | gmean    | teo_util | 57.84μs     | -13.47%     |
> | AsyncTask #1    | gmean    | idleutil | 62.61μs     | -6.35%      |
> | labs.geekbench5 | gmean    | menu     | 80.62μs     | 0.0%        |
> | labs.geekbench5 | gmean    | teo      | 94.75μs     | 17.52%      |
> | labs.geekbench5 | gmean    | teo_util | 52.98μs     | -34.28%     |
> | labs.geekbench5 | gmean    | idleutil | 68.58μs     | -14.93%     |
> +-----------------+----------+----------+-------------+-------------+
> 
> 2. PCMark Web Browsing (non latency-sensitive, normal usage test)
> 
> +----------------+----------+---------+-------------+
> | metric         | kernel   |   value | perc_diff   |
> |----------------+----------+---------+-------------|
> | PcmaWebV2Score | menu     |  5232   | 0.0%        |
> | PcmaWebV2Score | teo      |  5219.8 | -0.23%      |
> | PcmaWebV2Score | teo_util |  5249.7 | 0.34%       |
> | PcmaWebV2Score | idleutil |  5215.7 | -0.31%      |
> +----------------+----------+---------+-------------+
> 
> Percentages & types of idle misses
> 
> +-----------+-------------+--------------+
> | kernel    | type        |   percentage |
> |-----------+-------------+--------------|
> | menu      | too deep    |      24.814% |
> | teo       | too deep    |       11.65% |
> | teo_util  | too deep    |       3.753% |
> | idleutil  | too deep    |       4.304% |
> | menu      | too shallow |       3.101% |
> | teo       | too shallow |       8.578% |
> | teo_util  | too shallow |      18.309% |
> | idleutil  | too shallow |      17.638% |
> +-----------+-------------+--------------+
> 
> Power usage [mW]
> 
> +--------------+----------+----------+---------+-------------+
> | chan_name    | metric   | kernel   |   value | perc_diff   |
> |--------------+----------+----------+---------+-------------|
> | total_power  | gmean    | menu     |   179.2 | 0.0%        |
> | total_power  | gmean    | teo      |   184.8 | 3.1%        |
> | total_power  | gmean    | teo_util |   180.5 | 0.71%       |
> | total_power  | gmean    | idleutil |   185   | 3.24%       |
> +--------------+----------+----------+---------+-------------+
> 
> Wakeup latency
> 
> +-----------------+----------+----------+-------------+-------------+
> | comm            | metric   | kernel   |       value | perc_diff   |
> |-----------------+----------+----------+-------------+-------------|
> | CrRendererMain  | gmean    | menu     | 236.63μs    | 0.0%        |
> | CrRendererMain  | gmean    | teo      | 201.85μs    | -14.7%      |
> | CrRendererMain  | gmean    | teo_util | 111.76μs    | -52.77%     |
> | CrRendererMain  | gmean    | idleutil | 105.55μs    | -55.39%     |
> | chmark:workload | gmean    | menu     | 100.30μs    | 0.0%        |
> | chmark:workload | gmean    | teo      | 80.20μs     | -20.04%     |
> | chmark:workload | gmean    | teo_util | 53.81μs     | -46.35%     |
> | chmark:workload | gmean    | idleutil | 71.29μs     | -28.92%     |
> | RenderThread    | gmean    | menu     | 37.97μs     | 0.0%        |
> | RenderThread    | gmean    | teo      | 31.69μs     | -16.54%     |
> | RenderThread    | gmean    | teo_util | 34.32μs     | -9.63%      |
> | RenderThread    | gmean    | idleutil | 35.78μs     | -5.77%      |
> | surfaceflinger  | gmean    | menu     | 97.57μs     | 0.0%        |
> | surfaceflinger  | gmean    | teo      | 98.86μs     | 1.31%       |
> | surfaceflinger  | gmean    | teo_util | 72.59μs     | -25.6%      |
> | surfaceflinger  | gmean    | idleutil | 56.23μs     | -42.37%     |
> +-----------------+----------+----------+-------------+-------------+
> 
> I also have similar data for Jankbench & Speedometer with right about
> the same results, I'll skip those for now for brevity.
> Would you like me to send a patch with this new governor instead? What
> would you think about this instead of the previously suggested approach?
> 
> Thanks,
> Kajetan


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
