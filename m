Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3E76C616F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230374AbjCWIQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjCWIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:16:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D443028D
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:16:31 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w9so83046945edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679559390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AqP+ZP8sH6vMG+bn3ACKrPM9D21kWUUhEZmJlPJtpmY=;
        b=FdNJgshxeGZT5pwBN/Co+A+q/UQ468gKHVTlrYyytUQmjKBZ+cuWFQXf0lwi0n8A7U
         skuylVDirnBnQ5WkEK0xwRPPmONDYGXrDg3LtzFitCmSWh5Evy9T02iAZLOC59SBytBf
         tGyZ8ofs6+gZXFoht+ncc7RNl31yMDVqEoKQ+itB6wj1AwNXMyCNypEoBQzbI30hwfNP
         SQ+kk6N5ots/Xa0qzfAhEkrRqOaioqWGwQ9+yi8ahXkNVSe6gkoXXzE4pjJfSxCFOX+5
         STP50gtubDfTyNSHnyDHl8BvEiHIuTMouNMsNVc56SR01g38H6KrtGs42t46x5oTE6KZ
         /5Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559390;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AqP+ZP8sH6vMG+bn3ACKrPM9D21kWUUhEZmJlPJtpmY=;
        b=jLm357k5+cjNwFbtAF0d9BE43o77+S/uVYO6oBwtB46HRsYdbG5dPTpcv+4xvmveA9
         G10NdcfU+7Zp3gf37sqhqf2cY/FKuSC2eReFwOCKlQkAJxQLq4N+fdeSqqsYk4mjJ14x
         9FkJKYdViQEALyrqITU24Yl8PQ2GdnhG1WKgcMlyBB+/9lgYvElawzrLrQ/Iis0Y1GzN
         4o56FDha6+FwWoGzmhldsN92OivU5wARp1rAl4E5WdY2qGEqOZ7Wy9q490w4nqiKsj2G
         uXCpcaaH6h1wlajL+U75Uo/EBEM9bUCm2jykrPKCZ2at4HVyi6ke6+ZaV62HM7qD6RVr
         /87w==
X-Gm-Message-State: AO0yUKXmuU4ALUAmgsh630yhniqksGZ8tnY7hQYi3M0zdi1y83XQK4hI
        k9wtITEeoejaFDFHIoEVHXkLEQ==
X-Google-Smtp-Source: AK7set+JP9ir3V7fgGfUv1Je6oAcXJaO5jckAE1d7CoD7z376FD7oyJOURnrCV/q/ZX3UiCxFeEqZw==
X-Received: by 2002:aa7:c947:0:b0:500:4c0e:cb8d with SMTP id h7-20020aa7c947000000b005004c0ecb8dmr9127551edt.5.1679559390163;
        Thu, 23 Mar 2023 01:16:30 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:a665:ed1e:3966:c991? ([2a02:810d:15c0:828:a665:ed1e:3966:c991])
        by smtp.gmail.com with ESMTPSA id y2-20020a50ce02000000b004c0057b478bsm8838242edi.34.2023.03.23.01.16.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:16:28 -0700 (PDT)
Message-ID: <386e5c1b-cf64-8047-97e5-2cbbe3dc415b@linaro.org>
Date:   Thu, 23 Mar 2023 09:16:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [RFC PATCH] cpufreq: qcom-cpufreq-hw: allow work to be done on
 other CPU for PREEMPT_RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
References: <20230315164910.302265-1-krzysztof.kozlowski@linaro.org>
 <20230321100456.0_DhhkZJ@linutronix.de>
 <ba547675-59f2-84a9-82f3-93f6cb131799@linaro.org>
 <20230321105734.Z7F3Uvf1@linutronix.de>
 <3e227a63-a45f-8c20-f697-b263121ec173@linaro.org>
 <20230321133922.ontdC41h@linutronix.de>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230321133922.ontdC41h@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2023 14:39, Sebastian Andrzej Siewior wrote:
> On 2023-03-21 12:27:42 [+0100], Krzysztof Kozlowski wrote:
>>> I still fail to understand why this is PREEMPT_RT specific and not a
>>> problem in general when it comes not NO_HZ_FULL and/ or CPU isolation.
>>
>> Hm, good point, I actually don't know what is the workqueue
>> recommendation for NO_HZ_FULL CPUs - is still locality of the workqueue
>> preferred?
> 
> If you isolate a CPU you want the kernel to stay away from it. The idea
> is that something is done on that CPU and the kernel should leave it
> alone. That is why the HZ tick avoided. That is why timers migrate to
> the "housekeeping" CPU and do not fire on the CPU that it was programmed
> on (unless the timer has to fire on this CPU).
> 
>> And how such code would look like?
>> if (tick_nohz_tick_stopped())?
> 
> Yeah closer :) The CPU-mask for workqueues can still be different on
> non-NOHZ-full CPUs. Still you interrupt the CPU doing in-userland work
> and this is not desired.

Probably this should be done by workqueue core code.  Individual drivers
should not need to investigate which CPUs are isolated.


> You have a threaded-IRQ which does nothing but schedules a worker. Why?
> Why not sleep and remain in that threaded IRQ until the work is done?
> You _can_ sleep in the threaded IRQ if you have to. Force-threaded is
> different but this is one is explicit threaded so you could do it.

If I get your point correctly, you want the IRQ handler thread to do the
actual work instead of scheduling work? The answer to this is probably here:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e0e27c3d4e20dab861566f1c348ae44e4b498630

> 	
>>> However the thermal notifications have nothing to do with cpufreq.
>>
>> They have. The FW notifies that thermal mitigation is happening and
>> maximum allowed frequency is now XYZ. The cpufreq receives this and sets
>> maximum allowed scaling frequency for governor.
> 
> I see. So the driver is doing something in worst case. This interrupt,
> you have per-CPU and you need to do this CPU? I mean could you change
> the affinity of the interrupt to another CPU?

I don't know. The commit introducing it:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3ed6dfbd3bb987b3d2de86304ae45972ebff5870
claimed it helps to reduce number of interrupts hitting CPU 10x-100x
times... I don't see it - neither in tests nor in the code, so I am just
thinking to revert that one.

Best regards,
Krzysztof

