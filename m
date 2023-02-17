Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7FA369A403
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 03:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbjBQCpG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 21:45:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQCpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 21:45:04 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A067637B6A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:45:02 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id q15so589039plx.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 18:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lAMTlteP9vUskrakQQ8NSP9PZWNVptaG5Ebqx+/UTXg=;
        b=uTZomptXdDBj/muoyHzB8kG9M3+mvpuFx+gmHKyM/vuhNZb3WC56MgSbIUELhhSpmM
         ZVKWUA/0QtmY7LTbinqaNdRTYecipsaDwryKCO0BQ2QaSQkbXLP9fzccm1I1K6QKwlBp
         g4IpKekvV0hSJVRrUJYCrSKAO7X2ZuU/ixZfOqGraljmviC1U5va47DXDVmnKMRCGiYZ
         2a0HaqtRYoMOACfXbdp3or5mIcEm+hHKPZCyFGt9UCdVaZ8z1obLGiA2/GTC20OyI0zl
         0QCjJ+OvBeaU/uGVNCpe87aFFxsw0BuYG77xFNRyLN90SNPCokHF8QP+lNp5nfXBJdXB
         WkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lAMTlteP9vUskrakQQ8NSP9PZWNVptaG5Ebqx+/UTXg=;
        b=4j0PBWZWEzqoSO30idrv4IpN2LdOL/Jf3TdYoMJS2t6TQMAFXlbU40E9f2+Po2UQaj
         JMvJdKBUpK6Bz3DZfYEmz3f6gWjZem5ZK9upssVnI+XxyqaMAA3MawA/tUY5CLxzViL7
         3c8vUH4PDA3ByQwAai29IEHHOUs0RpEC42Ro2G8NxA9Rd/C0EYgz/Q2VKgs80QBnMEwG
         AE0CVjvQ5Q2h2bQssns1aZ+bnbV7Xht3v6gmpuqxY4pK64q2x4NgtpKB6gbbwKoTbPbF
         ex9pKQMTYHNhwZXCB4FLHSPY/RSkY6lD9e3OACNYjTw3ahVkYFDtAid/2NM1AbgZOenB
         KyLg==
X-Gm-Message-State: AO0yUKUU+UGg9FeJCy4Lhoq81qI2RmcT6gnYr86+37UpYmp2FoP3zDMz
        2puPEe5hDQQmH/OKN55XR7AfEA==
X-Google-Smtp-Source: AK7set8mEahv/LA4RtZ4fYZDh5XdGiSlNtAMJxdLCwxL77Wnmp0uz9q+GJWp+TW+hC3Si3eFmZdd4A==
X-Received: by 2002:a05:6a20:8406:b0:bc:63d0:d9d9 with SMTP id c6-20020a056a20840600b000bc63d0d9d9mr11083992pzd.47.1676601901962;
        Thu, 16 Feb 2023 18:45:01 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id x5-20020a654145000000b004a737a6e62fsm1768827pgp.14.2023.02.16.18.44.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 18:45:01 -0800 (PST)
Message-ID: <3a3220f7-e35b-ee77-649c-8c75dcb26b6c@bytedance.com>
Date:   Fri, 17 Feb 2023 10:44:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH v5 2/2] sched/fair: Introduce SIS_SHORT to wake up short
 task on current CPU
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tim Chen <tim.c.chen@intel.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Josh Don <joshdon@google.com>, Hillf Danton <hdanton@sina.com>,
        linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
References: <cover.1675361144.git.yu.c.chen@intel.com>
 <1b8af8d99da99a20449288ab4fbba64dc05057ce.1675361144.git.yu.c.chen@intel.com>
 <36ba3b68-5b73-9db0-2247-061627b0d95a@bytedance.com>
 <Y+5Kwxnrj16xRklf@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Y+5Kwxnrj16xRklf@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/23 11:24 PM, Chen Yu wrote:
>> The following change greatly reduced the p99lat of Redis service
>> from 150ms to 0.9ms, at exactly the same throughput (QPS).
>>
>> @@ -5763,6 +5787,9 @@ wake_affine_weight(struct sched_domain *sd, struct
>> task_struct *p,
>> 	s64 this_eff_load, prev_eff_load;
>> 	unsigned long task_load;
>>
>> +	if (is_short_task(p))
>> +		return nr_cpumask_bits;
>> +
> So above change wants to wake up the short task on its previous
> CPU if I understand correctly.

Yes.

>> 	this_eff_load = cpu_load(cpu_rq(this_cpu));
>>
>> 	if (sync) {
>>
>> I know that 'short' tasks are not necessarily 'small' tasks, e.g.
>> sleeping duration is small or have large weights, but this works
>> really well for this case. This is partly because delivering data
>> is memory bandwidth intensive hence prefer cache hot cpus. And I
>> think this is also applicable to the general purposes: do NOT let
>> the short running tasks suffering from cache misses caused by
>> migration.
>>
> I see. My original thought was to mitigate short task migration
> as much as possible. Either waking up the task on current CPU or previous
> CPU should both achieve the goal in theory. Could you please describe
> a little more about how Redis proxy server was tested? Was it tested
> locally or using multiple machines? I asked this because for network
> benchmarks, it might be better to wake the task close to the waker(maybe
> the NIC interrupt) due to hot network buffer. Anyway I will test
> your change slightly changed to see the impact, and also Redis. But it
> would be even better if you could provide some simple test steps I can
> try locally : )

Sorry for missing the info. The test was done in production environment,
and what I have done is only updating the kernel in several machines
which are highly loaded, that is over 85% cpu util observed by mpstat.
Please let me know if you want any specific info.

Best,
	Abel
