Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3130731083
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 09:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbjFOHZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 03:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243228AbjFOHZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 03:25:54 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF594DF;
        Thu, 15 Jun 2023 00:25:52 -0700 (PDT)
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
X-GND-Sasl: alex@ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id BEB99E0004;
        Thu, 15 Jun 2023 07:25:45 +0000 (UTC)
Message-ID: <6d9fefd9-472c-b8d3-d871-b81bfdbe4f6d@ghiti.fr>
Date:   Thu, 15 Jun 2023 09:25:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 04/10] drivers: perf: Rename riscv pmu driver
Content-Language: en-US
To:     Andrew Jones <ajones@ventanamicro.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230512085321.13259-1-alexghiti@rivosinc.com>
 <20230512085321.13259-5-alexghiti@rivosinc.com>
 <20230531-49ed4c2054db0abbacd03632@orel>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230531-49ed4c2054db0abbacd03632@orel>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 31/05/2023 16:09, Andrew Jones wrote:
> On Fri, May 12, 2023 at 10:53:15AM +0200, Alexandre Ghiti wrote:
>> In addition to being more pretty, it will be useful in upcoming commits
>> to distinguish those pmu drivers from the other pmu drivers.
>>
>> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
>> ---
>>   drivers/perf/riscv_pmu_legacy.c | 2 +-
>>   drivers/perf/riscv_pmu_sbi.c    | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
>> index 0d8c9d8849ee..ffe09d857366 100644
>> --- a/drivers/perf/riscv_pmu_legacy.c
>> +++ b/drivers/perf/riscv_pmu_legacy.c
>> @@ -95,7 +95,7 @@ static void pmu_legacy_init(struct riscv_pmu *pmu)
>>   	pmu->ctr_clear_idx = NULL;
>>   	pmu->ctr_read = pmu_legacy_read_ctr;
>>   
>> -	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>> +	perf_pmu_register(&pmu->pmu, RISCV_PMU_LEGACY_PDEV_NAME, PERF_TYPE_RAW);
>>   }
>>   
>>   static int pmu_legacy_device_probe(struct platform_device *pdev)
>> diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
>> index 70cb50fd41c2..3b0ee2148054 100644
>> --- a/drivers/perf/riscv_pmu_sbi.c
>> +++ b/drivers/perf/riscv_pmu_sbi.c
>> @@ -897,7 +897,7 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		goto out_unregister;
>>   
>> -	ret = perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
>> +	ret = perf_pmu_register(&pmu->pmu, RISCV_PMU_PDEV_NAME, PERF_TYPE_RAW);
> Should we include "sbi" in this name?


I'd say that it is safe to do so and I understand your point, @Atish WDYT?


>
>>   	if (ret)
>>   		goto out_unregister;
>>   
>> -- 
>> 2.37.2
>>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
