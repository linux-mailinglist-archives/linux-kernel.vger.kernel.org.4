Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75DB667123
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236603AbjALLmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:42:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235059AbjALLlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:41:35 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8801432255
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:32:23 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id u19so43953994ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:32:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x0gSaQMG1ZEFcejTq7nLHyz4oYLVH4s87HrXZ9feFZw=;
        b=MxATrjpAReX++o2TYHHWOfICbw35vKWQ+92xVH35B4uAi4k3xpysWiDmXJEqF8hNYP
         K98P+1UPTVgUwELW/eHrcWQvuK5PopluglhhrXaGpKhlfOg5BTT7FMX9kkfzrSzMnPiV
         qJcHkM/NU+syr++OnBpDhLWYIcAP3+OBFa6DaAcmmuBDAOGLzdpIpi3BivMqtxc6yyac
         tzpUKrOAgff7npw/YqJ5823aPvKMC8ZPZfYmTzjBd/jI9V1zSn9QVGP524sNDJMH1gC9
         PLJqLz2SyVGQo0CUnke6+hAFlz6fVai2u5qVdiC/njfVCBmc01WrKvZLZvvpG0kjeE4Y
         AK8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x0gSaQMG1ZEFcejTq7nLHyz4oYLVH4s87HrXZ9feFZw=;
        b=pHgEAgzPVJJ7AVS5XdLLDslLnQXQFBEsZby5wTN+f1AhUVqAo3/7PJDQYhA318sEaR
         H1HL5m3l2csZ/tZuWurT0ElCteojWBwWL2/E1hKlK8l0Qir1dIpdQ6+EwdHqpvtjog3c
         y/Hq+p7WPnAeOvXfVUfyukjuoZS8sqleSsBvZ26hMpYvMmCreMACwmUpNxPrBm2T+3wB
         rePAjmSVRDHLv69QNh3kPkCxsBLs37NVap305pH8bmAHIJi98wcihme9FwPKp20TCRrz
         uhAc8UZsSKPACXI0xTDtYBNpWjo5ZcXKbnDMFFqXBiAEW4yQUpy3UI6x5lKkIhdKDspk
         OWzA==
X-Gm-Message-State: AFqh2kpP0dS2T4ViJl7hNL8zTTconv22puU5Xtui6i3Ozkp9HskGNmpY
        5Q8IZZwhWDk5jZAUkQPb8qb4BmIbGMUNmWYp
X-Google-Smtp-Source: AMrXdXt4Icsn6J2EIf5YR6zEEyxeLvlN8muBgDY7KHjKOXpXigEIGra9aZ16EDLnGrrB0D7ip4IWfg==
X-Received: by 2002:a17:907:7f04:b0:7c0:a4e9:615b with SMTP id qf4-20020a1709077f0400b007c0a4e9615bmr81407577ejc.61.1673523142029;
        Thu, 12 Jan 2023 03:32:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b0084d4564c65fsm5153826ejc.42.2023.01.12.03.32.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:32:21 -0800 (PST)
Message-ID: <428c9a9e-f5f3-661f-d3d1-19ca38a75336@linaro.org>
Date:   Thu, 12 Jan 2023 12:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
 <Y7/oO8s26SKU8eOz@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7/oO8s26SKU8eOz@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 12:00, Sebastian Andrzej Siewior wrote:
> On 2022-12-19 16:15:00 [+0100], Krzysztof Kozlowski wrote:
>> The PSCI cpuidle power domain in power_off callback uses
>> __this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
> 
> Why does __this_cpu_write() matter here?

I'll reword to "not using sleeping primitives nor spinlock_t"

> 
>> Realtime kernels and solves errors like:
>>
>>   BUG: scheduling while atomic: swapper/2/0/0x00000002
>>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>>   Call trace:
>>    dump_backtrace.part.0+0xe0/0xf0
>>    show_stack+0x18/0x40
>>    dump_stack_lvl+0x68/0x84
>>    dump_stack+0x18/0x34
>>    __schedule_bug+0x60/0x80
>>    __schedule+0x628/0x800
>>    schedule_rtlock+0x28/0x5c
>>    rtlock_slowlock_locked+0x360/0xd30
>>    rt_spin_lock+0x88/0xb0
>>    genpd_lock_nested_spin+0x1c/0x30
>>    genpd_power_off.part.0.isra.0+0x20c/0x2a0
>>    genpd_runtime_suspend+0x150/0x2bc
>>    __rpm_callback+0x48/0x170
>>    rpm_callback+0x6c/0x7c
>>    rpm_suspend+0x108/0x660
>>    __pm_runtime_suspend+0x4c/0x8c
>>    __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
>>    psci_enter_domain_idle_state+0x18/0x2c
>>    cpuidle_enter_state+0x8c/0x4e0
>>    cpuidle_enter+0x38/0x50
>>    do_idle+0x248/0x2f0
>>    cpu_startup_entry+0x24/0x30
>>    secondary_start_kernel+0x130/0x154
>>    __secondary_switched+0xb0/0xb4
> 
> This is to a sleeping lock (spinlock_t) in an IRQ-off region which
> starts in do_idle(). You could describe the problem and to solution you
> aim for instead pasting a backtrace into the commit description and
> adding a flow in the code.

I'll extend the description.

> 
> I don't see how your commit description matches your change in code. One
> might think "Oh. If I see this pattern, I need an irqsafe lock to fix
> it".


Best regards,
Krzysztof

