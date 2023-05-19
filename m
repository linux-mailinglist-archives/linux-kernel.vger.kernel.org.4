Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42E34709080
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbjESHlF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 03:41:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjESHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 03:41:03 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E18186;
        Fri, 19 May 2023 00:41:02 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-64d1a0d640cso1188589b3a.1;
        Fri, 19 May 2023 00:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684482062; x=1687074062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JRJ3fn1HtdgZlOZej3gETBmVJ+xLrS5nzxVcVkHU8nI=;
        b=U66IIAM5LTp9hYcjFHNgLO+QkZaVEkt1hK9eiOSoXoAKBVk50/PU4bwua5ibSP8O5l
         BJCI2l47VkV1ygBvCVOU5iy2wpuUoALxiTf/VTDxwI/ZltdrqEhZc3WS+N2Mgm4ipIrO
         IJ2JDVk1pWEPrThg72x2ljXCQk71smSQZS4cU8pwBsbTK3Zn7Kuyh8QkspP7SfxFmwTr
         66bdDIgKKsMgqU2H+dzYhN3hymo1ln5sa64Hpn7+fYn64R9gpVS/oYEMwpamwvGRMr8d
         HqBOS2XXS9bOH8fxicF9NV1Kl6Ii3bSctgbku2JHKzN/TE4T9qDMV7thXnRUNVu0agcB
         Jfdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684482062; x=1687074062;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JRJ3fn1HtdgZlOZej3gETBmVJ+xLrS5nzxVcVkHU8nI=;
        b=bPG1i9lpoHJqfrcSFYQ0+m+iy/UFGJfUOCMcoWIo4tTcQHvc7ScVeBRiwfd3CSRRRj
         tBndVRV5Vr7udLzitmk1DixJCaihS2GH6Pw9E/pEvOzJ/DnrQShnHUU+UEhLZkIjps86
         aGfAxE/vFqHvsNi8fyYVeZniWyDjKw5jdE6ZuLks2KmVpqv6MXpV+0XDJKhxNDj0ZBda
         C6H9T9+krYE0XqB1TxK8G2JCQRsp/1/LFcsiwEWR0I+fkJj08vrTIjiqBkVOWtK4B+Dl
         Ta9Y2vvauzEPBvvpQp2YEon2xLnlasKefulL1K4o+wc9+94+Pr8b/nJkrdvnCLn3xR9f
         5dEg==
X-Gm-Message-State: AC+VfDxby6Br8zZqdpAmiNCX+uOj80aaIc04WYrSFRhiUDJFfUEBpV5l
        lmrHiS6dcDF8odO7PBzBW9Zaiqct7O3Cn/n5Fp4=
X-Google-Smtp-Source: ACHHUZ6Pdkuo63Ae65R/z90mCGtob/7eXWm7iQA9+766zyYgJ8NZIcslRv8GAMgUfjL4aYNFKmWEUA==
X-Received: by 2002:a05:6a20:6a1e:b0:103:b448:ddd8 with SMTP id p30-20020a056a206a1e00b00103b448ddd8mr1458982pzk.58.1684482061893;
        Fri, 19 May 2023 00:41:01 -0700 (PDT)
Received: from [192.168.255.10] ([103.7.29.32])
        by smtp.gmail.com with ESMTPSA id q2-20020a632a02000000b0050bc4ca9024sm2422098pgq.65.2023.05.19.00.41.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 00:41:01 -0700 (PDT)
Message-ID: <70c86b5e-a8c8-fb6a-d4cf-0580a527ee5a@gmail.com>
Date:   Fri, 19 May 2023 15:40:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] perf/x86/intel: Save/restore cpuc->active_pebs_data_cfg
 when using guest PEBS
Content-Language: en-US
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230517133808.67885-1-likexu@tencent.com>
 <3dca8ccf-081a-0765-b5e3-9584f9128137@linux.intel.com>
From:   Like Xu <like.xu.linux@gmail.com>
In-Reply-To: <3dca8ccf-081a-0765-b5e3-9584f9128137@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/5/2023 12:31 am, Liang, Kan wrote:
> 
> 
> On 2023-05-17 9:38 a.m., Like Xu wrote:
>> From: Like Xu <likexu@tencent.com>
>>
>> After commit b752ea0c28e3 ("perf/x86/intel/ds: Flush PEBS DS when changing
>> PEBS_DATA_CFG"), the cpuc->pebs_data_cfg may save some bits that are not
>> supported by real hardware, such as PEBS_UPDATE_DS_SW. This would cause
>> the VMX hardware MSR switching mechanism to save/restore invalid values
>> for PEBS_DATA_CFG MSR, thus crashing the host when PEBS is used for guest.
> 
> I believe we clear the SW bit when it takes effect.
> 
> +	if (cpuc->pebs_data_cfg & PEBS_UPDATE_DS_SW) {
> +		cpuc->pebs_data_cfg = pebs_data_cfg;
> +		pebs_update_threshold(cpuc);
> +	}
> 
> I think the SW bit can only be seen in a shot period between add() and
> enable(). Is it caused by a VM enter which just happens on the period?

What happens here is that when *intel_pmu_pebs_del()* is called,
the pebs_update_state() also triggers:
	cpuc->pebs_data_cfg |= PEBS_UPDATE_DS_SW;
and the new value will then be used for the next kvm_entry.

The KVM created pebs perf_event is not added/enabled at this point
and the cpuc->pebs_data_cfg strangely holds a non-zero value.

Perhaps there is more room for perf fixes here, but for guest pebs usages,
using active_pebs_data_cfg in intel_guest_get_msrs() is part of what is needed.

> 
>> Fix it by using the active host value from cpuc->active_pebs_data_cfg.
> 
> I don't see a problem of using active_pebs_data_cfg, since it reflects
> the current MSR setting. Just curious about how it's triggered.
> 
>>
>> Cc: Kan Liang <kan.liang@linux.intel.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Signed-off-by: Like Xu <likexu@tencent.com>
>> ---
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Thanks,
> Kan
> 
>>   arch/x86/events/intel/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
>> index 070cc4ef2672..89b9c1cebb61 100644
>> --- a/arch/x86/events/intel/core.c
>> +++ b/arch/x86/events/intel/core.c
>> @@ -4074,7 +4074,7 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>>   	if (x86_pmu.intel_cap.pebs_baseline) {
>>   		arr[(*nr)++] = (struct perf_guest_switch_msr){
>>   			.msr = MSR_PEBS_DATA_CFG,
>> -			.host = cpuc->pebs_data_cfg,
>> +			.host = cpuc->active_pebs_data_cfg,
>>   			.guest = kvm_pmu->pebs_data_cfg,
>>   		};
>>   	}
