Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A4F0619EEF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbiKDRiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbiKDRiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:38:13 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1627645EEF;
        Fri,  4 Nov 2022 10:38:09 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id mi9so3663548qvb.8;
        Fri, 04 Nov 2022 10:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1xqFT1BPG8FOzQWQlEWabgc/qypLmKyViciJsyKXXqA=;
        b=FVTfhE4E7I8hJxdMXrETfiSnPsDDfKpuggLSa40CXM7uVh9khU0FLkFEPZpsIetXuo
         8NOBnp/EceXHgV09v9kQmWZ5remhjEJk/4Ao5l4PFtJtRJpCGxIb4NH+3+qLMvs8WGMw
         snx7nhvopjUE1UN0xBAIDeNP7T0xf+uGgQQz/FoQgB1zyOcdbhDIBmqgsq6gA4vtU2R/
         O9DxqQWwA5ucQCEFD4WzbEr/8lrx0nXPDpUNPOgjFkDLRJuMH6F4UCa0poF8iK3+R3Z3
         wI84+NkmKuKEYVvrh7kJF/45Zv9J9eHDU9yCD2kMqzJJ5y3iSyvYpxV4KiS0nB4omANR
         RTcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1xqFT1BPG8FOzQWQlEWabgc/qypLmKyViciJsyKXXqA=;
        b=Y1idXqBWUqMsagipUMkgkckTNbHROMZ+9k3M/K6A5CQ4N2Xvxo2dbCR1wHKPZbbdX1
         EPGi6yGJJ87zzuAlBrnSWbsnCqNDDKZjHeF97H3m6QiDamL5DGhNLNL7CyMXMW9lvNMq
         SU+mHszlT1ifiZFH4qvZV+ITQxdTTMDOahKzoo/kKnk4NALmlj33vyHuyz5MMQo98K3l
         6YX2y/9ZgZ3Sh4Ew13/e1NN2SgbllbjH5+CXtf1Z7JeY7Vzst6ClHXLU+Pq1/0y868BX
         6+7C8YYvqNh2vu10sWUkp3ftPoYob67ZyXOvzMcEtEeoLmVQR2BjXbNIKzF4Khlch7hN
         t3/A==
X-Gm-Message-State: ACrzQf12A0HiDpZEpRXwQKzcY0ymHroS/oAe9P/IGk0OL3UkSkzoWhK0
        Vb4h1saVlqEOjJN2heaNvHHjvXsiL5w+hw==
X-Google-Smtp-Source: AMsMyM6TO/xTEJzgy0dKYvbrxZtw0tQ7BJDFffkEhHJbQc/DwCBLNcAtZRTsXfUEldjyWmTCKITPKQ==
X-Received: by 2002:a05:6214:d0c:b0:4bc:1388:8d80 with SMTP id 12-20020a0562140d0c00b004bc13888d80mr19243190qvh.68.1667583488083;
        Fri, 04 Nov 2022 10:38:08 -0700 (PDT)
Received: from [10.69.64.228] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a450a00b006cbc6e1478csm3550114qkp.57.2022.11.04.10.38.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 10:38:07 -0700 (PDT)
Message-ID: <c6852cb4-a929-2f42-bfcd-04c4aa99b4a5@gmail.com>
Date:   Fri, 4 Nov 2022 10:38:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] perf: Fix perf_event_{init,exit}_cpu stubs
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, anand.gore@broadcom.com,
        william.zhang@broadcom.com, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>
References: <20221103224303.3910486-1-f.fainelli@gmail.com>
 <Y2UOQpniaV12E0P9@hirez.programming.kicks-ass.net>
Content-Language: en-US
In-Reply-To: <Y2UOQpniaV12E0P9@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/4/2022 6:06 AM, Peter Zijlstra wrote:
> On Thu, Nov 03, 2022 at 03:43:03PM -0700, Florian Fainelli wrote:
>> The original commit that introduced those stubs was already at fault,
>> but in the absence of a caller of perf_event_{init,exit}_cpu outside of
>> code that is compiled regardless of CONFIG_PERF_EVENTS, the build
>> failure cannot be observed. This was observed with the Android kernel to
>> produce a build failure similar to this:
>>
>>      In file included from ./include/uapi/linux/posix_types.h:5,
>>                       from ./include/uapi/linux/types.h:14,
>>                       from ./include/linux/types.h:6,
>>                       from ./include/linux/limits.h:6,
>>                       from ./include/linux/kernel.h:7,
>>                       from ./include/linux/sched/mm.h:5,
>>                       from kernel/cpu.c:6:
>>      kernel/cpu.c: In function 'random_and_perf_prepare_fusion':
>>      ./include/linux/stddef.h:8:14: error: called object is not a function or function pointer
>>       #define NULL ((void *)0)
>>                    ^
>>      ./include/linux/perf_event.h:1607:29: note: in expansion of macro 'NULL'
>>       #define perf_event_init_cpu NULL
>>                                   ^~~~
>>      kernel/cpu.c:1686:2: note: in expansion of macro 'perf_event_init_cpu'
>>        perf_event_init_cpu(cpu);
>>        ^~~~~~~~~~~~~~~~~~~
> 
> What is the actual problem reported here? Did you see all the other NULL
> assignments in cpuhp_hp_states ?

Anand reported to me that the following downstream commit in the Android 
common kernel repository:

https://android.googlesource.com/kernel/common/+/ca927bd22ad8bd26fd8dcebf3c7f2a093385d8ea

was resulting in the build failure above.

While this is an Android inflicted change and I still intend to get a 
fix there, upon closer look, the build failure could be experienced 
upstream as well with any code calling perf_event_{init,exit}_cpu() as a 
regular function call as opposed to being used as a function pointer.

This felt worthy of fixing in the upstream kernel, hence this patch.
-- 
Florian

