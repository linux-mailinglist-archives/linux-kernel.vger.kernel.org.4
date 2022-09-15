Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0EE5B92E5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 05:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiIODI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 23:08:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIODIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 23:08:54 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9D390C68
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:08:49 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id s14-20020a17090a6e4e00b0020057c70943so21015788pjm.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 20:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=yNqTPu5tyt/IDxsQy9Ylu0kF3/Li1V4X3SZtw4qAVdo=;
        b=d/mZ8e/UFrgxmosOgJpU51sWQsxEP//kCY/I8mDUY5AImYk6MJIJbwvej6mEZB1Vf2
         3GCLq1SlJIYZb402rSYCQBqBaXyjwt2xewki8HKHeQM/6+8VgRkweXr/R3MFaGSN7+8y
         7io6jJ2k8a8AecWNe/4xz8faiUdVLETKLm7cvC+sbeR/f67jhCeHDHChV/pKbi4MYlgE
         pHlX9GhoOQ0FsiYkfOzOMmvLZ2vHk7CNInqRyQ0UGeL2mRJEEsPAxQpeYnPOqx4UYzE7
         plp0IqFux4Oi9BfCs/sPGd6k3RpnE8gdiPZ4s19QOCU/XxCefE4KZvNJvqgFi4JzkuqQ
         Ypog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=yNqTPu5tyt/IDxsQy9Ylu0kF3/Li1V4X3SZtw4qAVdo=;
        b=TkY/ZW2WeU/f6fui1iWClkD6nh9LX7pJQBVckzOSEBUm8G8pc5vdO9hpUG7ZR2dYdW
         C6Eg1cBYuspVs7/boeqt/CH9bZKJMKnD46Y6iu2m/h1+vMnOWJJ/qLROlMX7oaH7BfkT
         3fEdpH74N1QR7fpGSVtNmQM6KjZyEzhlz1kOVf4Ga/ZsMnxpHf1CTk9WWhocFahcd/KH
         20o7QeUykfuiyNxTeXT557oiqpEoBKZse8297wVFVJkdowSr0TERHyawuBQ5TgxVUiM2
         2rEZFFQal1YJJdNTO5BjVi29c2KobbLESEkBVPl3CUz5SDvwZAjvlb6xCyLCEEjqfANN
         v05g==
X-Gm-Message-State: ACrzQf36x08CpKTYa2Dhpsgyka4EQLhtB18N6zYt2CVihKrajsqLWTNF
        Tiai+Fi9FzCjQSogseru2IPu9A==
X-Google-Smtp-Source: AMsMyM7C/1CgN7amIiOZK0sy5xCCSlKYe92/Yp7nEFSZwTpjUIQKyhMRvBDYw+nw+t2xDP9BsEIVDg==
X-Received: by 2002:a17:90b:3883:b0:203:214d:4272 with SMTP id mu3-20020a17090b388300b00203214d4272mr5205840pjb.101.1663211328487;
        Wed, 14 Sep 2022 20:08:48 -0700 (PDT)
Received: from [10.255.16.83] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id p129-20020a625b87000000b0053e0d6f353esm10958261pfb.27.2022.09.14.20.08.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Sep 2022 20:08:48 -0700 (PDT)
Message-ID: <055b833b-df0f-057e-9a1b-c70af094cf32@bytedance.com>
Date:   Thu, 15 Sep 2022 11:08:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.2
Subject: Re: [PATCH v5 2/5] sched/fair: Limited scan for idle cores when
 overloaded
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-3-wuyun.abel@bytedance.com>
 <199f559267169850f2bcbca9a5df89df30aa168e.camel@linux.intel.com>
Content-Language: en-US
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <199f559267169850f2bcbca9a5df89df30aa168e.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tim, thanks for your reviewing!

On 9/15/22 6:25 AM, Tim Chen wrote:
> On Fri, 2022-09-09 at 13:53 +0800, Abel Wu wrote:
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
>>   		sd_share = rcu_dereference(per_cpu(sd_llc_shared, target));
>>   		if (sd_share) {
>>   			/* because !--nr is the condition to stop scan */
>>   			nr = READ_ONCE(sd_share->nr_idle_scan) + 1;
>> -			/* overloaded LLC is unlikely to have idle cpu/core */
>> -			if (nr == 1)
>> +
>> +			/*
>> +			 * Overloaded LLC is unlikely to have idle cpus.
>> +			 * But if has_idle_core hint is true, a limited
>> +			 * speculative scan might help without incurring
>> +			 * much overhead.
>> +			 */
>> +			if (has_idle_core)
>> +				nr = nr > 1 ? INT_MAX : 3;
> 
> The choice of nr is a very abrupt function of utilization when has_idle_core==true,
> it is either feast or famine.  Why is such choice better than a smoother
> reduction of nr vs utilization?  I agree that we want to scan more aggressively than
> !has_idle_core, but it is not obvious why the above work better, versus something
> like nr = nr*2+1.
This has been discussed with Mel, and he suggested do simple things
first before scaling the depth.

https://lore.kernel.org/all/20220906095717.maao4qtel4fhbmfq@techsingularity.net/

Thanks and BR,
Abel
