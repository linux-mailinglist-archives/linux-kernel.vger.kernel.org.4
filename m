Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC816D5B81
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbjDDJHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234246AbjDDJHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:07:16 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0E10FC
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:06:49 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id ml21so7897741pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 02:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680599209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kCXTYyynqDP3DE5jcLAydWVVdXMRBxCfnQwvE/4Jovw=;
        b=A63oqDTQinRH4XqOmyuy3HtdhwfMYnHTfw7iMf5ptcMKxzVa1rgQusunxjKQhAE+0r
         FGBPI1I1vE4IOvjHHJO0EXLL5ofI60QkFs+NflecALE1Mgt1m7H5ftllqB3XmuVy9Vah
         QsxuWrWUYAst3GHyGcy72Dcj+FnHK8H+zav87bO9kbYKcT1IbxTegEChrOYPjFfDBsgU
         sJN40exyuHvI8oTHqDueTLbezDwzxuswmxaOoAGL+hvExY6vKHRZw6TtHNiLHzI9lyuP
         kNGinmQFKUXMJ8NIdjv7juD3up0kNpDx+bC2KLE477wpd8uw4ATXMW3zqLp2JSjG8JEp
         kfdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680599209;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kCXTYyynqDP3DE5jcLAydWVVdXMRBxCfnQwvE/4Jovw=;
        b=1tYO/SOLUcPdy8LUHy3UtiH1cX6CR1jvd6jZi+HG1RiWaLM+OpCsWg8fTI3UsLv5v9
         M6o5WeKumYq6EgiSEr1eSYiod+41CMSaAYx5CudnSE+cxJ7HmU48XGOABOJLCQioNFrY
         1BCKwc9j79Grx/8s7ufbBg7MUR0D6+uHwX2gtoFInVfHk4L943HHswjds6ZOwqC2MKM6
         SpvVX27ZEAJoLUWKw32s1j2hC/CT+yMT7QtN9tjCHyWGP8fNLhBs4IQt/0G2qknkEHgJ
         cDSBtLSd5YjzkUrdvzTKecZ9y3ltf56BCH/3Efgnpj4w6NF4hsrjOuCDW0P1YIy/ZDjW
         wM2A==
X-Gm-Message-State: AAQBX9f6azEv8VKILcm0q8mJnBph3tNz9msKbSdCKDn8eTTLUYuXwyUQ
        riFXgmLs6yB4slgrViEJoto1Yg==
X-Google-Smtp-Source: AKy350YJcuOSa6GEnSTf9wNf+x5lpT+hKHyLDRtuJ72t3p44YMUSU9+iPg9zv9UVBFm8Gdvw8gec5A==
X-Received: by 2002:a17:90b:1803:b0:237:c209:5b14 with SMTP id lw3-20020a17090b180300b00237c2095b14mr2066771pjb.22.1680599209226;
        Tue, 04 Apr 2023 02:06:49 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id m1-20020a17090a858100b0023af8a3cf6esm10825571pjn.48.2023.04.04.02.06.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Apr 2023 02:06:48 -0700 (PDT)
Message-ID: <612c77f3-2983-b010-a4ef-4fbaf57064b5@bytedance.com>
Date:   Tue, 4 Apr 2023 17:06:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [External] Re: [PATCH v3] sched/core: Adapt WARN_DOUBLE_CLOCK
 machinery for core-sched
To:     Phil Auld <pauld@redhat.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
References: <20230330035827.16937-1-jiahao.os@bytedance.com>
 <20230331125813.GA782283@lorien.usersys.redhat.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <20230331125813.GA782283@lorien.usersys.redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/3/31 Phil Auld wrote:
> Hi,
> 
> On Thu, Mar 30, 2023 at 11:58:27AM +0800 Hao Jia wrote:
>> When sched_core_enabled(), we sometimes need to call update_rq_clock()
>> to update the rq clock of sibling CPUs on the same core, before that we
>> need to clear RQCF_UPDATED of rq->clock_update_flags to avoid the
>> WARN_DOUBLE_CLOCK warning. Because at this time the rq->clock_update_flags
>> of sibling CPUs may be RQCF_UPDATED. If sched_core_enabled(), we will get
>> a core wide rq->lock, so at this point we can safely clear RQCF_UPDATED of
>> rq->clock_update_flags of all CPUs on this core to avoid the
>> WARN_DOUBLE_CLOCK warning.
>>
>> We sometimes use rq_pin_lock() and raw_spin_rq_lock() separately,
>> For example newidle_balance() and _double_lock_balance(). We will
>> temporarily give up core wide rq->lock, and then use raw_spin_rq_lock()
>> to reacquire core wide rq->lock without rq_pin_lock(), so We can not
>> clear RQCF_UPDATED of rq->clock_update_flags of other cpus on the
>> same core in rq_pin_lock().
>>
>> Steps to reproduce:
>> 1. Enable CONFIG_SCHED_DEBUG and CONFIG_SCHED_CORE when compiling
>>     the kernel
>> 2. echo 1 > /sys/kernel/debug/clear_warn_once
>>     echo "WARN_DOUBLE_CLOCK" > /sys/kernel/debug/sched/features
>> 3. Run the linux/tools/testing/selftests/sched/cs_prctl_test test
>>
>> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>
> 
> I think this looks good. One small nit is that I think you might
> replace "core wide" with "core-wide" everywhere.
> 
> 
> Reviewed-by: Phil Auld <pauld@redhat.com>
> 

Thank you for your review, I will do it in the next version.

Thanks,
Hao
