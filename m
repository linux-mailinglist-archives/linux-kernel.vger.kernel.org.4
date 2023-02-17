Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003E169A92B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 11:40:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbjBQKkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 05:40:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjBQKkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 05:40:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28F36447
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:40:13 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id j6so1064766plh.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 02:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/OY6h867Uho2x4Y7A6BkSlLeS+Imv69/x5y04MvIjZA=;
        b=7twP6FE29tHHNOOekUmGGxoSCG9xUhcjl7bGLCisIU4ZpqXnJRRvS394kK0dSwPSG4
         YL6P7hlb+3db+3stPhIpH59m1yPduIurgcbru62ROTiVQ4qyyKLc/X2/tz1bsVq1D2gQ
         Y3d5hR94I/cQpZgnWsgWd5TXbF3ExENhVw1XVLWjWoF81rglqUtqJG39JMYRt1kkSakL
         56dbElQde09COs8I5+SGSOnLw8k7wPV1N5NVyxVYCRRA3LAVfM5kTQre8ffNIaQs0Jf+
         UGoo0cZ0/vbDoDf7myFbdYE2CzkT38s5jFQm/DNWVroYsvwdCEsSLdb9haMhKNUK/Nsc
         pBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/OY6h867Uho2x4Y7A6BkSlLeS+Imv69/x5y04MvIjZA=;
        b=lTJxbZn0dW3/AkobebiKBK6jO9UANLFm5JyAdM1BLjTiC1YQd9/UfdYBIszPS5EuwQ
         Hfou9jG65aJhVLvStTdeeZFxwGEyNbFSaQO0TF8hq/a5gchD6P3ppxnA+ykO9NJaRYbu
         Zvqrv/dSTPb2+eiJDSOPFR8Ram4zGYZlD0HqGFmGICijuJRUM+hK96+DnHf7J1Cyj/ok
         ua6RhLk6BeFK2JvXOmIat8wnd2eZ8nN/8wTzFgxQGnAKBB4zDaOBjWaJjE5LNu4zzcfj
         RS/2H8ITXVZn/Q600zNU1vg89fbbKrDxUKYh6rNGUidiSa+c5Vvh+6x449ukIDEu6dth
         eKog==
X-Gm-Message-State: AO0yUKVVT/E9oZD0d8vueha+u+7CcJKx7L9DU+Es2Y1DdzI/WyyNmVhd
        VjiVEO/edkmO81ppsNt9Y+yQWQ==
X-Google-Smtp-Source: AK7set/62nTDQFm0tWcbPnYkRph/yTLjlHrjxuPfkCtYpaZzV1Y13uW1qLTkFcpT3Zv7q6BW1HdXSw==
X-Received: by 2002:a17:902:ecc6:b0:19a:9984:5588 with SMTP id a6-20020a170902ecc600b0019a99845588mr11972185plh.26.1676630413102;
        Fri, 17 Feb 2023 02:40:13 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id 13-20020a170902ee4d00b0019a88c1cf63sm2836753plo.180.2023.02.17.02.40.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 02:40:12 -0800 (PST)
Message-ID: <979da62f-3103-346a-c1f0-2ea4f0ba37bd@bytedance.com>
Date:   Fri, 17 Feb 2023 18:40:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Content-Language: en-US
To:     Honglei Wang <wanghonglei@didichuxing.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <f88838ff-2024-ca32-069e-f7a4c0465961@didichuxing.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <f88838ff-2024-ca32-069e-f7a4c0465961@didichuxing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Honglei,

On 2/17/23 4:35 PM, Honglei Wang wrote:
>> The following change greatly reduced the p99lat of Redis service
>> from 150ms to 0.9ms, at exactly the same throughput (QPS).
>>
>> @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, 
>> struct task_struct *p,
>>      s64 this_eff_load, prev_eff_load;
>>      unsigned long task_load;
>>
>> +    if (is_short_task(p))
>> +        return nr_cpumask_bits;
>> +
>>      this_eff_load = cpu_load(cpu_rq(this_cpu));
>>
>>      if (sync) {
>>
>> I know that 'short' tasks are not necessarily 'small' tasks, e.g.
>> sleeping duration is small or have large weights, but this works
>> really well for this case. This is partly because delivering data
>> is memory bandwidth intensive hence prefer cache hot cpus. And I
>> think this is also applicable to the general purposes: do NOT let
>> the short running tasks suffering from cache misses caused by
>> migration.
>>
> 
> Redis is a bit special. It runs quick and really sensitive on schedule 
> latency. The purpose of this 'short task' feature from Yu is to mitigate 
> the migration and tend to place the waking task on local cpu, this is 
> somehow on the opposite side of workload such as Redis. The changes you 
> did remind me of the latency-prio stuff. Maybe we can do something base 
> on both the 'short task' and 'latency-prio' to make your changes more 
> general. thoughts?

I think it is more like an enhance rather than conflict. Chen Yu's patch
treats the cpus with only one short task as idle, to make idle cpu scan
more efficient. So if this cpu is such 'idle' cpu, just choose it. While
what I suggested is to ignore this cpu if it is not idle.

But as you pointed out that Redis is a bit special in the manner of
sensitive on scheduling latency, the change in wake_affine_weight() may
be inappropriate as 'weight' implies more on throughput than latency.

Best Regards,
	Abel
