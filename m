Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 035FA69121D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 21:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbjBIUcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 15:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjBIUce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 15:32:34 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49662643ED
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 12:32:05 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso4791697wmp.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 12:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nB6jsWvI4KnWXooPA/ebEwHgK+FEpeXIiOzh7SZEL/A=;
        b=unwOQ+/JOMefRgHAoXq9SmW5mvkDC93/or2ZnttHNQJgABQm4A3IDpXS0e1+f4R4xX
         b0xddfWvU8XiZlSdi/wPe7qCM4Y+JAKHf2KenPjYQzcuIpxFK3ikAu5ws8ZwEWfW4FIb
         y8+Yw9Mc/oEg+4iFsXjMabYFv3gIvgl2uMSU8sQ3hTwnwpJ0R05mBT3CRPYR0fFmiJuc
         J0UPM/oO2qwIoko9LxExJvRnstRBPPOTJCNM/ltc9mBrEU4hSjTpsOJga4eJSB3xAUIy
         U6d3OI3v+WOQPSy6lLVAx0UtFLEVzN/cbTcgrO/c2QlRCz34+CvDZW1/IG21Eeflrwmi
         AGxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nB6jsWvI4KnWXooPA/ebEwHgK+FEpeXIiOzh7SZEL/A=;
        b=qyr7XvGxu67eh8fIVqUeDqJ95OKeYRGmsLX02epj+JhPtzBy2+gS1uR+83L/ceMQLm
         dwvN4IPB9G+3gJpwTaQ//LKKI8IQRnvZxlpg04G8eoaiopRzFKUXphalMZUnizNfYPEi
         53rVUvwm4Wb6fFlnE2V0is7h/w7qn8FZlNrvZeLvdS3KNHK9Qg1tAhsdFqSvm+6zSiqA
         0jbS1RyjbIonAays5TI2NEOTkDL8YrJPV4MCyGmViyL9jCI9gaZ6URfNOwUfYRtCEvO9
         6bp/OSqVaOprELwx1qHtDsrfAi/za7ii0rqKyZsXua5Zu1wh+pSlEKAun1+vsAHuBPMr
         YbbA==
X-Gm-Message-State: AO0yUKXTT0ZdaBpT+Rp8yAtleXRJ/KNjsz+UoLUZiLjW6D2sOXC96FV4
        e8Vbt9uChm+8DCfuXFuuxu6CZg==
X-Google-Smtp-Source: AK7set+gR2QsBMthdpITGxMwCpqAXfgFbkuskZKUUHe4jacMK7QzidYZYkqwNqYECS4pycwtqYPbCQ==
X-Received: by 2002:a05:600c:3b17:b0:3df:9858:c032 with SMTP id m23-20020a05600c3b1700b003df9858c032mr7481096wms.7.1675974723779;
        Thu, 09 Feb 2023 12:32:03 -0800 (PST)
Received: from ?IPV6:2a02:6b6a:b566:0:8009:2525:9580:8db2? ([2a02:6b6a:b566:0:8009:2525:9580:8db2])
        by smtp.gmail.com with ESMTPSA id q14-20020a05600c46ce00b003db12112fcfsm3212547wmo.4.2023.02.09.12.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 12:32:03 -0800 (PST)
Message-ID: <9b6bca9c-7189-a2d5-8c0a-f55c24f54b62@bytedance.com>
Date:   Thu, 9 Feb 2023 20:32:02 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [External] Re: [PATCH v8 8/9] x86/mtrr: Avoid repeated save of
 MTRRs on boot-time CPU bringup
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, dwmw2@infradead.org,
        kim.phillips@amd.com
Cc:     arjan@linux.intel.com, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        pbonzini@redhat.com, paulmck@kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        rcu@vger.kernel.org, mimoja@mimoja.de, hewenliang4@huawei.com,
        thomas.lendacky@amd.com, seanjc@google.com, pmenzel@molgen.mpg.de,
        fam.zheng@bytedance.com, punit.agrawal@bytedance.com,
        simon.evans@bytedance.com, liangma@liangbit.com,
        David Woodhouse <dwmw@amazon.co.uk>
References: <20230209154156.266385-1-usama.arif@bytedance.com>
 <20230209154156.266385-9-usama.arif@bytedance.com> <87mt5m1yiz.ffs@tglx>
From:   Usama Arif <usama.arif@bytedance.com>
In-Reply-To: <87mt5m1yiz.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/02/2023 18:31, Thomas Gleixner wrote:
> On Thu, Feb 09 2023 at 15:41, Usama Arif wrote:
>>   void mtrr_save_state(void)
>>   {
>> +	static bool mtrr_saved;
>>   	int first_cpu;
>>   
>>   	if (!mtrr_enabled())
>>   		return;
>>   
>> +	if (system_state < SYSTEM_RUNNING) {
>> +		if (!mtrr_saved) {
>> +			mtrr_save_fixed_ranges(NULL);
>> +			mtrr_saved = true;
>> +		}
>> +		return;
>> +	}
>> +
>>   	first_cpu = cpumask_first(cpu_online_mask);
>>   	smp_call_function_single(first_cpu, mtrr_save_fixed_ranges, NULL, 1);
> 
> So why is this relevant after the initial bringup? The BP MTRRs have
> been saved already above, no?
> 
> Thanks,
> 
>          tglx

I will let David confirm if this is correct and why he did it, but this 
is what I thought while reviewing before posting v4:

- At initial boot (system_state < SYSTEM_RUNNING), when mtrr_save_state 
is called in do_cpu_up at roughly the same time so MTRR is going to be 
the same, we can just save it once and then reuse for other secondary 
cores as it wouldn't have changed for the rest of the do_cpu_up calls.

- When the system is running and you offline and then online a CPU, you 
want to make sure that hotplugged CPU gets the current MTRR (which might 
have changed since boot?), incase the MTRR has changed after the system 
has been booted, you save the MTRR of the first online CPU. When the 
hotplugged CPU runs its initialisation code, its fixed-range MTRRs will 
be updated with the newly saved fixed-range MTRRs.

So mainly for hotplug, but will let David confirm.

Thanks,
Usama

