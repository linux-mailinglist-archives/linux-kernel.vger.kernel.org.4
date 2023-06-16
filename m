Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104717333D8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 16:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345673AbjFPOni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 10:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343842AbjFPOng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 10:43:36 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F29A02D73;
        Fri, 16 Jun 2023 07:43:33 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b50e309602so6618185ad.0;
        Fri, 16 Jun 2023 07:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686926613; x=1689518613;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=C+b8RUpIqjclzanuv+av1IQ7y2237VUOqucew1Sql9M=;
        b=HeWcWfchMWmx+Fb1eaEly1a9IG2ZR/lE+xeJfwntoHjOizO5Txvmnzi5k9ldgXGteq
         roPvfA4ynrrD5Z0ZRrAzAbre9DFTZY6ck6NxoFFeqjnW64ZAnShrx9JOoL2GLmgCWyMA
         h2R8xR0txtC/WtRZQM3OPSrx5ePwpk+xz03ynriUFJE/Rc05BQ9fFpyLouhsQewW7pzH
         H+L61FGEoCn9+h8xNddhX/WMHvevSAih9DCFidX7Z0kCD0LpaYoJQuGvRXhpn1ZXtSRK
         2X55+9fy+hbOdL0CPOUMEHypMxHuQNlh/hwubrUDXY1EaPiHXCx0NcMg212SarI4Yq3/
         YzpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686926613; x=1689518613;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C+b8RUpIqjclzanuv+av1IQ7y2237VUOqucew1Sql9M=;
        b=Oep1zlvwRiBxKbVRGD1EccYY809s4HV0jTQVK1adRdP+A3a0GjSU5oqTEjzqPlOpOR
         mqs6QUjelyST0hy8ATLiZ8J+iVGlwHN4vyyl+mWuqmqe0tq02qU58vxKa3C3cXLvs5D8
         ToaTuxraw0na/Iq9GbgtE7385HC9rBb3Z2bc1XCiNSns0s0yGhFMrtMlRMPIQqbHTQFh
         n5PEkIDtwg1oJGj7WQqm0AVqpRce5Zn4CirAscqMxctXK52A0VKXx/riZj3beMZFxgA1
         PISD+AzKEw/rI6fJiXf/snvl1sDnV8YZ/yqBiMrj14h2F0lMWHgeYj78+RYp5BprgQeZ
         YUHg==
X-Gm-Message-State: AC+VfDx5oppfL+En76wVd7xFTIUvs3o5NpJlOU3Mky6Lp5hXqqWoWZpi
        HZ9Yt/nbJsTTjqukRkKviw==
X-Google-Smtp-Source: ACHHUZ6bELa7BBi/TrYsjfwMKZ7u3gaEL4iD72aUEqK9dq4numOlB1orQadQgbzs3bnhq9vsi42J+Q==
X-Received: by 2002:a17:903:188:b0:1b2:4b28:793c with SMTP id z8-20020a170903018800b001b24b28793cmr2531219plg.29.1686926613350;
        Fri, 16 Jun 2023 07:43:33 -0700 (PDT)
Received: from [192.168.0.206] ([45.64.236.92])
        by smtp.gmail.com with ESMTPSA id c18-20020a170902b69200b001ae59169f05sm15956311pls.182.2023.06.16.07.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 07:43:32 -0700 (PDT)
From:   "Sandipan Das (AMD)" <sandipandas1990@gmail.com>
X-Google-Original-From: "Sandipan Das (AMD)" <sandipan.osd@gmail.com>
Message-ID: <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
Date:   Fri, 16 Jun 2023 20:13:22 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.12.0
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com>
In-Reply-To: <ZIxrxpYtffT0FtEx@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/06/23 7:33 pm, Breno Leitao wrote:
> On Fri, Jun 16, 2023 at 03:29:54PM +0200, Peter Zijlstra wrote:
>> On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
>>> On some systems, the Performance Counter Global Status Register is
>>> coming with reserved bits set, which causes the system to be unusable
>>> if a simple `perf top` runs. The system hits the WARN() thousands times
>>> while perf runs.
>>>
>>> WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu_v2_handle_irq+0x1be/0x2b0
>>>
>>> This happens because the "Performance Counter Global Status Register"
>>> (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved according
>>> to the documentation (Figure 13-12 from "AMD64 Architecture Programmer’s
>>> Manual, Volume 2: System Programming, 24593"[1]
>>
>> Would it then not make more sense to mask out bit7 before:
> 
> It is more than bit 7. This is the register structure according to the document
> above:
> 
> Bits 		Mnemonic		Description		 		Access type
> 63:60	        Reserved RO
> 59 		PMCF			Performance Counter Freeze		RO
> 58 		LBRSF			Last Branch Record Stack Freeze 	RO
> 57:6 		Reserved				 			RO
> 5:0 		CNT_OF 			Counter overflow for PerfCnt[5:0] 	RO
> 
> In the code, bit GLOBAL_STATUS_LBRS_FROZEN is handled and cleared before
> we reach my changes
> 
> That said, your approach is almost similar to what I did, and I will be happy
> to change in order to make the code clearer.
> 
>> +	status &= ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
>> 	if (!status)
>> 		goto done;
>>
>> ?
>>
>> Aside from being reserved, why are these bits magically set all of a
>> sudden?
> 
> That is probably a question to AMD.
> 

The reserved bits should never be set. The purpose of the WARN_ON() is to catch such anomalies.
I am working out the details with Breno and will report back with a resolution.

- Sandipan

[sending from my personal email as I currently don't have access to my work laptop]
