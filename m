Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9EC8620B4C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbiKHIgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:36:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbiKHIgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:36:00 -0500
X-Greylist: delayed 1070 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Nov 2022 00:35:59 PST
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316B79595
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 00:35:59 -0800 (PST)
X-ASG-Debug-ID: 1667895486-1eb14e7e6373080001-xx1T2L
Received: from ZXSHMBX3.zhaoxin.com (ZXSHMBX3.zhaoxin.com [10.28.252.165]) by mx2.zhaoxin.com with ESMTP id 6ZgbfOXCQ0FcdbrC (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 08 Nov 2022 16:18:06 +0800 (CST)
X-Barracuda-Envelope-From: SilviaZhao-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Received: from ZXBJMBX02.zhaoxin.com (10.29.252.6) by ZXSHMBX3.zhaoxin.com
 (10.28.252.165) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 8 Nov
 2022 16:18:06 +0800
Received: from [10.29.8.47] (10.29.8.47) by ZXBJMBX02.zhaoxin.com
 (10.29.252.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12; Tue, 8 Nov
 2022 16:18:04 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.165
Message-ID: <3c7da7fd-402f-c74f-c96c-0e88828eab58@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.8.47
Date:   Tue, 8 Nov 2022 16:18:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
From:   silviazhaooc <silviazhao-oc@zhaoxin.com>
Subject: Fwd: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
To:     Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Fwd: [PATCH] x86/perf: Fixed kernel panic during boot on Nano
 processor.
CC:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <mark.rutland@arm.com>, <alexander.shishkin@linux.intel.com>,
        <jolsa@kernel.org>, <namhyung@kernel.org>, <tglx@linutronix.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <linux-perf-users@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Cobe Chen(BJ-RD)" <CobeChen@zhaoxin.com>,
        "Louis Qi(BJ-RD)" <LouisQi@zhaoxin.com>,
        "Silvia Zhao(BJ-RD)" <SilviaZhao@zhaoxin.com>,
        <8vvbbqzo567a@nospam.xutrox.com>
References: <3a7a5935-05ed-3054-b3fc-292202eef845@zhaoxin.com>
Content-Language: en-US
In-Reply-To: <3a7a5935-05ed-3054-b3fc-292202eef845@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.29.8.47]
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX02.zhaoxin.com (10.29.252.6)
X-Barracuda-Connect: ZXSHMBX3.zhaoxin.com[10.28.252.165]
X-Barracuda-Start-Time: 1667895486
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2404
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.4987 1.0000 0.0000
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.101989
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/11/3 18:07, Borislav Petkov wrote:
> 
> On Thu, Nov 03, 2022 at 11:23:04AM +0800, silviazhao-oc wrote:
>> Nano processor may not fully support rdpmc instruction,
> 
> What does that even mean? Not fully support?

rdpmc instruction on Nano processor has a limitation that it cannot 
access fixed performance counter, while it can read general pmc counter 
successfully.

> 
>> it works well for reading general pmc counter, but will lead
>> GP(general protection) when accessing fixed pmc counter.
> 
> RDPMC will #GP when the perf counter specified cannot be read.
> 
> AFAICT, that is RCX: 0000000040000001 which looks like perf counter index 1 with INTEL_PMC_FIXED_RDPMC_BASE ORed in.

Yes, RCX: 0000000040000001 indicates we are accessing fixed performance 
counters with index 1.

> 
>> Furthermore, family/mode information is same between Nano processor
>> and ZX-C processor, it leads to zhaoxin pmu driver is wrongly loaded
>> for Nano processor, which resulting boot kernal fail.
> 
> So *that* is the real problem - it tries to access perf counters thinking it is running on architectural perf counters implementation but nano doesn't have that.

Actually Nano do support architectural perf counters. But due to rdpmc 
instruction issue, accessing fixed counters via rdpmc will cause GP.

> 
>> To solve this problem, stepping information will be checked to
>> distinguish between Nano processor and ZX-C processor.
> 
> Why doesn't that ZXC thing doesn't have a CPUID flag to check instead of looking at models and steppings and thus confusing it with a nano CPU?

Nano and ZXC both support architectural perf counters, and they both 
have a CPUID flag to check that. The difference is Nano has rdpmc issue 
while ZXC does not, which cannot be checked through CPUID.

> 
>> [https://bugzilla.kernel.org/show_bug.cgi?id=212389]
>>
>> Reported-by: Arjan <8vvbbqzo567a@nospam.xutrox.com>
> 
> Does Arjan have a last name?

Sorry, I don't know Arjan either.

> 
>> Signed-off-by: silviazhao-oc <silviazhao-oc@zhaoxin.com>
> 
> I'm assuming your name is properly spelled "Silvia Zhao" and not in a single word with a "-oc" string appended at the end, yes?

Yes, Silvia Zhao is my name.
Thx for your kindly reply.

> 
> Thx.
> 
> --
> Regards/Gruss,
>      Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
