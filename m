Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 060E45B34E5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 12:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbiIIKNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiIIKNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 06:13:46 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AAB108736
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 03:13:44 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id i15-20020a17090a4b8f00b0020073b4ac27so1087954pjh.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 03:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=MP9fwFFpA3obSSZJRSWtbr4ZfazZloZSKNRa2aB0hMk=;
        b=IlrexnHcyZx86Ll1A95URwkmxZfZwXPafWjTEmx+y+KwxfleTEfiUD3iYoscq+3Ofb
         osndeSMJj10m533/bS+UsLl3AlLuSTzGfKnYhGmzWrYR3yQJvRTIuODTB96Az8Ea+Pzl
         MBk2cDq8xJwNCspoGUohHPFV9378kVmNdGhGcXLStJs1gmxPJs3E3wVfuDQRtz1xM8cv
         vAaKnPJYzZaH3k88u/AQLxEAMgMh94zCS7H5pCq91qeSTN5a0hTkGUNAz9tBAf6cND4I
         L6+xXP/wELvJ9oVSGEPp22DDtLX5OtGP8rHW4eYEGfdHa2zVn2+MrzQ65WWKjU14qvH1
         KdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MP9fwFFpA3obSSZJRSWtbr4ZfazZloZSKNRa2aB0hMk=;
        b=SdSRIZR3GcsZ3xovCDEuSvChOK0CzA2wbRKnG8c8THrT7jfYi9WSPUIWfy/wpgOIlv
         hhJta0nAwDf3JmDvc5PIESpf0r6S46ULxa0TtTeyZ3uFiW7SvLYdoYGcpVo5/5uvv107
         zipCdXU3zmgcBpXK9W7GF+/GRXWr7xAVR1enNVCk369k/ffcc0iWLKboOnWa75Z6UZ21
         8t2/Z8KQuuktZkn+9qY6U65xhbNwr7yNb8ur/JDitbnkRVXcF9MMfpTRljySS6YChOSV
         thimJ40jiDaP2xdFZ92iccigMvIoDRIeySKRbI501rpxWRLQpelzBifk3C5fy7oM2qSn
         LzGw==
X-Gm-Message-State: ACgBeo1uKvnhiWUG2d4Z0g1OY6mmzsOJY/lGhByLOiQ6GpUOVdHoFlXz
        rH4wbeh6O0y/zxXPaH3JTqbadQ==
X-Google-Smtp-Source: AA6agR4pyc6hhibt9Hdpv6iGsYJuzTq5CEQe02nAsedC3eRnSeJOAfd/iUbtM9AYW2T2xsp58JVHlA==
X-Received: by 2002:a17:902:e5cc:b0:16f:1153:c519 with SMTP id u12-20020a170902e5cc00b0016f1153c519mr13210192plf.151.1662718424136;
        Fri, 09 Sep 2022 03:13:44 -0700 (PDT)
Received: from [10.255.170.59] ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id d194-20020a621dcb000000b0052d4cb47339sm116234pfd.151.2022.09.09.03.13.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Sep 2022 03:13:43 -0700 (PDT)
Message-ID: <430e6ac7-145c-2b74-93a9-c77338e488b1@bytedance.com>
Date:   Fri, 9 Sep 2022 18:13:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.2.1
Subject: Re: [PATCH v5 3/5] sched/fair: Skip core update if task pending
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220909055304.25171-1-wuyun.abel@bytedance.com>
 <20220909055304.25171-4-wuyun.abel@bytedance.com>
 <YxsLXunUjY2vBeDX@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YxsLXunUjY2vBeDX@chenyu5-mobl1>
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

On 9/9/22 6:09 PM, Chen Yu wrote:
> On 2022-09-09 at 13:53:02 +0800, Abel Wu wrote:
>> The function __update_idle_core() considers this cpu is idle so
>> only checks its siblings to decide whether the resident core is
>> idle or not and update has_idle_cores hint if necessary. But the
>> problem is that this cpu might not be idle at that moment any
>> more, resulting in the hint being misleading.
>>
>> It's not proper to make this check everywhere in the idle path,
>> but checking just before core updating can make the has_idle_core
>> hint more reliable with negligible cost.
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   kernel/sched/fair.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 7abe188a1533..fad289530e07 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6294,6 +6294,9 @@ void __update_idle_core(struct rq *rq)
>>   	int core = cpu_of(rq);
>>   	int cpu;
>>   
>> +	if (rq->ttwu_pending)
>> +		return;
>> +
> Is it to deal with the race condition? I'm thinking of the
> following scenario: task p1 on rq1 is about to switch to idle.
> However when p1 reaches __update_idle_core(), someone on other
> CPU tries to wake up p2, and leverages rq1 to queue p2
> thus set the ttwu_pending flag on rq1. It is likely that
> rq1 becomes idle but soon finds that TF_NEED_RESCHED is set, thus
> quits the idle loop. As a result rq will not be idle and we will
> get false positive here.

Yes, exactly as you said.
