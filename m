Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50A19606EE7
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 06:31:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJUEbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 00:31:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiJUEbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 00:31:07 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2C2FE930
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:31:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id l6so1494739pgu.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 21:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Aiaq2XXhqSug2oabs8xD6Cj6jtpafQvARSUtLlaA63k=;
        b=DXZbVsDSiu53QBMA7EYpVxIWuu2X9B/gvg7TwbMsNDP7IAc5SQlYsB3dCqgfy/OaF8
         Uk/h1hoY2LHTrHVLmEwh2T03uc2OSzzJ0GAwYoOyfqXGhNtkqiDp9e21rReZE3EETt4f
         VzmMJywFxK5Elp0VgiIqy3Vzd7X9BWzU6nxL02Qncmfy1BA7dVAa1O3pzxAYGTeULm+p
         VVC3Mjf/rg7BRvytfx1HioYm6UA8uaYqdJc4CDLd2sy1yKg3eH0p1YRBWxzO9ymYw0Wm
         a/kxhzdE34QFxtLLoLvOWuztbZ/aS6+bdhvVCod7mIaDTdpgUnL8yInY3Dv1ZrtpjUoC
         k/gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aiaq2XXhqSug2oabs8xD6Cj6jtpafQvARSUtLlaA63k=;
        b=ZZBc+SXPy6yLkiGsVLdqTEi/pxnPTeobD198xQTK94iAeIPSd5OQQYIOyzkcJYcmyk
         MeZDCYSgPtItQoMy2JSEta46JbkB1KGJDXyZpi1SLkQl54TB3Uup6VdGFtKBChIceIZe
         tTgS9sutq5gzg1ul1g8JmT4ATYP1bkEMgImcJFQao0i4KbGmvUwHdwVUfgCpIIf3EVoR
         ckitfF4r82T5L+kJYw8Exnk8y3VOYiDPDYRdsX96Nx4Pl7BITaGkP3wS+KCO8vXLXvag
         tSEoTZLn3v4A8kqVJ5VN/KHLN+mwvE+w4e1vd8w5BtBhBJZdihrS849mZFw+RBtOsPeK
         owhw==
X-Gm-Message-State: ACrzQf3PDxFIMjTltTlgvnXjjYa/olYBexmY9qkMwmOYS6TQoArla2/s
        fpAuIde4hVlH/wc2P3CmYENGKQ==
X-Google-Smtp-Source: AMsMyM4FlMUOQLNJ9rJKoiveNlqOsck8mJKl4xKwAWXfjKaD6qtddeJVGmxYsUyCfJsQvkJP2FA/tw==
X-Received: by 2002:a63:f305:0:b0:43f:6af:7553 with SMTP id l5-20020a63f305000000b0043f06af7553mr14787614pgh.570.1666326665065;
        Thu, 20 Oct 2022 21:31:05 -0700 (PDT)
Received: from [10.255.20.103] ([139.177.225.253])
        by smtp.gmail.com with ESMTPSA id n17-20020a170902e55100b00174c1855cd9sm13954056plf.267.2022.10.20.21.30.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 21:31:04 -0700 (PDT)
Message-ID: <9ec8a474-d923-953c-0b73-02ba2fd6ea82@bytedance.com>
Date:   Fri, 21 Oct 2022 12:30:56 +0800
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
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <Y1IZ/DZ1SWMn0QDs@chenyu5-mobl1>
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

Hi Chen, thanks for your reviewing!

On 10/21/22 12:03 PM, Chen Yu wrote:
> On 2022-10-19 at 20:28:58 +0800, Abel Wu wrote:
> [cut]
>> A major concern is the accuracy of the idle cpumask. A cpu present
>> in the mask might not be idle any more, which is called the false
>> positive cpu. Such cpus will negate lots of benefit this feature
>> brings. The strategy against the false positives will be introduced
>> in next patch.
>>
> I was thinking that, if patch[3/4] needs [4/4] to fix the false positives,
> maybe SIS_CORE could be disabled by default in 3/4 but enabled
> in 4/4? So this might facilicate git bisect in case of any regression
> check?

Agreed. Will fix in next version.

> [cut]
>> + * To honor the rule of CORE granule update, set this cpu to the LLC idle
>> + * cpumask only if there is no cpu of this core showed up in the cpumask.
>> + */
>> +static void update_idle_cpu(int cpu)
>> +{
>> +	struct sched_domain_shared *sds;
>> +
>> +	if (!sched_feat(SIS_CORE))
>> +		return;
>> +
>> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>> +	if (sds) {
>> +		struct cpumask *icpus = to_cpumask(sds->icpus);
>> +
>> +		/*
>> +		 * This is racy against clearing in select_idle_cpu(),
>> +		 * and can lead to idle cpus miss the chance to be set to
>> +		 * the idle cpumask, thus the idle cpus are temporarily
>> +		 * out of reach in SIS domain scan. But it should be rare
>> +		 * and we still have ILB to kick them working.
>> +		 */
>> +		if (!cpumask_intersects(cpu_smt_mask(cpu), icpus))
>> +			cpumask_set_cpu(cpu, icpus);
> Maybe I miss something, here we only set one CPU in the icpus, but
> when we reach update_idle_cpu(), all SMT siblings of 'cpu' are idle,
> is this intended for 'CORE granule update'?

The __update_idle_core() is called by all the cpus that need to go idle
to update has_idle_core if necessary, and update_idle_cpu() is called
before that check.

Thanks,
Abel

