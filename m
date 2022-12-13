Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D71F64B2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 11:08:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235082AbiLMKIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 05:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiLMKIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 05:08:13 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3612BDEF;
        Tue, 13 Dec 2022 02:08:13 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE542F4;
        Tue, 13 Dec 2022 02:08:53 -0800 (PST)
Received: from [10.57.41.22] (unknown [10.57.41.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E64A73F5A1;
        Tue, 13 Dec 2022 02:08:10 -0800 (PST)
Message-ID: <9ea2a0d8-b025-bb56-3a04-1a88e340da2d@arm.com>
Date:   Tue, 13 Dec 2022 10:08:08 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH v6 11/14] kernel: events: Export
 perf_report_aux_output_id()
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mathieu.poirier@linaro.org, mingo@redhat.com, acme@kernel.org,
        linux-perf-users@vger.kernel.org, leo.yan@linaro.org,
        quic_jinlmao@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org,
        Mike Leach <mike.leach@linaro.org>
References: <20221123195010.6859-1-mike.leach@linaro.org>
 <20221123195010.6859-12-mike.leach@linaro.org>
 <e3afc4ad-8a95-7d0b-832b-7f7a8be0b647@arm.com>
In-Reply-To: <e3afc4ad-8a95-7d0b-832b-7f7a8be0b647@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 24/11/2022 11:04, Suzuki Kuruppassery Poulose wrote:
> Peter
> 
> 
> On 23/11/2022 19:50, Mike Leach wrote:
>> CoreSight trace being updated to use the perf_report_aux_output_id()
>> in a similar way to intel-pt.
>>
>> This function in needs export visibility to allow it to be called from
>> kernel loadable modules, which CoreSight may configured to be built as.
>>
>> Signed-off-by: Mike Leach <mike.leach@linaro.org>
>> Acked-by: Suzuki K Poulose <suzuki.poulose@arm.com>
>> ---
>>   kernel/events/core.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 4ec3717003d5..ad388552f1d5 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
>> @@ -9231,6 +9231,7 @@ void perf_report_aux_output_id(struct perf_event 
>> *event, u64 hw_id)
>>       perf_output_end(&handle);
>>   }
>> +EXPORT_SYMBOL_GPL(perf_report_aux_output_id);
> 
> Are you happy with me picking up this change through the coresight  tree ?
> 
> Suzuki
> 

Please could you let me know your thoughts on this ? Coresight PMU would
use this to inform the dynamically allocated trace id for a CPU to the
perf via this HWID packet.

If you are happy with the above change, I could pick it up via the
coresight tree with your Ack. Otherwise, please could you pick it
up ?

Suzuki

