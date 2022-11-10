Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C2C624A4C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:07:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiKJTHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKJTGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:06:10 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176E45A3C;
        Thu, 10 Nov 2022 11:05:48 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a27so1500012qtw.10;
        Thu, 10 Nov 2022 11:05:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rokvtl75XxkOCdp16d0xR65MKlSaNsdfqv2851bbu3Q=;
        b=NK4WtyUnA4cU9/Na3TW3AQ2+nwvFNrcLPvxRKE/NyAe9a0PSP/2jlAiAI64WJrDJwE
         hYGHJ7vhrgiT96sX9LTyfpsGocf/aD3/tBq8+/Xg3+gePpAPsVmB1ci21XkuGtpCCXb5
         y9qhhtC+pNic3NOzemZbHh2pEAAi/yKfNz6UVHuPPkv1HSnnS2h8SUmvy82sDYpY2HPG
         el9f1Rij9Zrcy06YpV3h+7H/R+3/py31sxyFYaGwlx7p4vTXv7SUoZn9gC8mA4CYhZG6
         +2XlPiLOUE7e5K8jeGok6SCDMhsWKcxLdWBozxd1Xvru3jk/8O9zV5yWm2Y6ht/BibXj
         zYTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rokvtl75XxkOCdp16d0xR65MKlSaNsdfqv2851bbu3Q=;
        b=e7GN3QZpqgD3QZWJeDa0lQ6fptnZw9v1fnaxaNMVySVtLF38KyWWHsjBv1ypI3GILg
         ddJTVyItBa/oS+oA32PfXl0aZqUjSoOE29+zJsMn20fIyn4XXIx3HMVjm+p7D1yMAaIS
         xIj1hG6uWEP0NjNfFwVpHOOIo/mc/CN7XOBK5K+/7NiDuT6cA9Q66prCwjWKIc4izqEK
         1kHqebsG7Khfo/3iRojOooRCcT24sS5xJweAbOdfBcycQ1I/CZp5ntB+Z4I2NYRt2QOs
         fgRngdV31dUK2EYIRJHPjPaR3/0f+ykLr65J1NliFMGInbbmAg5WhONYsXoQqt7HWaS2
         BW3A==
X-Gm-Message-State: ACrzQf36YfKTOCg+zZiiNOkC5+UXmYTnclIMUD5uCUZpSxL8mYesG7Yh
        n7kE9pD1a5yrD5Ftqf7RN/w=
X-Google-Smtp-Source: AMsMyM5C+OzzE0m0MheuUF6pkJIuPd88S44wge8lT+izBl325Rfy03ls5do3rjxIpgQlO1jkcatpfA==
X-Received: by 2002:ac8:5494:0:b0:3a5:6854:32fe with SMTP id h20-20020ac85494000000b003a5685432femr1466889qtq.655.1668107146861;
        Thu, 10 Nov 2022 11:05:46 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id x11-20020a05620a258b00b006e42a8e9f9bsm35258qko.121.2022.11.10.11.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Nov 2022 11:05:46 -0800 (PST)
Message-ID: <4193aa1b-6836-08c0-58fd-5f53c66682da@gmail.com>
Date:   Thu, 10 Nov 2022 11:05:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] perf: Fix perf_event_{init,exit}_cpu stubs
Content-Language: en-US
From:   Florian Fainelli <f.fainelli@gmail.com>
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
 <c6852cb4-a929-2f42-bfcd-04c4aa99b4a5@gmail.com>
In-Reply-To: <c6852cb4-a929-2f42-bfcd-04c4aa99b4a5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/4/22 10:38, Florian Fainelli wrote:
> 
> 
> On 11/4/2022 6:06 AM, Peter Zijlstra wrote:
>> On Thu, Nov 03, 2022 at 03:43:03PM -0700, Florian Fainelli wrote:
>>> The original commit that introduced those stubs was already at fault,
>>> but in the absence of a caller of perf_event_{init,exit}_cpu outside of
>>> code that is compiled regardless of CONFIG_PERF_EVENTS, the build
>>> failure cannot be observed. This was observed with the Android kernel to
>>> produce a build failure similar to this:
>>>
>>>      In file included from ./include/uapi/linux/posix_types.h:5,
>>>                       from ./include/uapi/linux/types.h:14,
>>>                       from ./include/linux/types.h:6,
>>>                       from ./include/linux/limits.h:6,
>>>                       from ./include/linux/kernel.h:7,
>>>                       from ./include/linux/sched/mm.h:5,
>>>                       from kernel/cpu.c:6:
>>>      kernel/cpu.c: In function 'random_and_perf_prepare_fusion':
>>>      ./include/linux/stddef.h:8:14: error: called object is not a 
>>> function or function pointer
>>>       #define NULL ((void *)0)
>>>                    ^
>>>      ./include/linux/perf_event.h:1607:29: note: in expansion of 
>>> macro 'NULL'
>>>       #define perf_event_init_cpu NULL
>>>                                   ^~~~
>>>      kernel/cpu.c:1686:2: note: in expansion of macro 
>>> 'perf_event_init_cpu'
>>>        perf_event_init_cpu(cpu);
>>>        ^~~~~~~~~~~~~~~~~~~
>>
>> What is the actual problem reported here? Did you see all the other NULL
>> assignments in cpuhp_hp_states ?
> 
> Anand reported to me that the following downstream commit in the Android 
> common kernel repository:
> 
> https://android.googlesource.com/kernel/common/+/ca927bd22ad8bd26fd8dcebf3c7f2a093385d8ea
> 
> was resulting in the build failure above.
> 
> While this is an Android inflicted change and I still intend to get a 
> fix there, upon closer look, the build failure could be experienced 
> upstream as well with any code calling perf_event_{init,exit}_cpu() as a 
> regular function call as opposed to being used as a function pointer.
> 
> This felt worthy of fixing in the upstream kernel, hence this patch.

No response meaning it's a don't care because upstream is not (yet?) 
impacted?
-- 
Florian

