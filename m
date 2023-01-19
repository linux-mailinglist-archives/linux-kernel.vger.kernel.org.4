Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B02673F80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 18:06:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230469AbjASRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 12:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjASRGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 12:06:14 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9390C4DBFD
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:06:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id o17-20020a05600c511100b003db021ef437so1749376wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 09:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F9F2+kem/Aol8OKIhzJOZk9K6JUDOkZxO5i8jszSiM4=;
        b=MCNAfQYZB2wEVUkb4hbkSQJZXhJE0XmeFncjH4Q8H8cDml2FrE1cPod/xuOreWCzVs
         NuCPNihpGhbncqMC/k4lHK/hvow54BDqkAQtRtdQOhqTC7CiQMF86ULShGzMHSmyQv4r
         COt181ZayO4TGS1cYNtqZEoJF3ljBYPhE3zMi8GrgvQyGmb+dhFqHeGR/7iYDL8u0y7i
         0UdWbA7sG+IPh76UlOVT0VBJU4N9PL6wUV85hzVe+L3zyunQcksgLO3+7dKQEKPYinQh
         90lSudIfv2SAQtVPYaPkVdgyd/WpKYl6MivR+bvjz1VD9eFUIE8qPWhlaOVMz+sfVa0V
         uMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F9F2+kem/Aol8OKIhzJOZk9K6JUDOkZxO5i8jszSiM4=;
        b=WetImjUjaYfvQyODsfXL573/ByuG3xUR3b4lNNiSWFRiMfHB1hLMfbxXw01OKUrB6z
         EHGQgMNxenrABPU+X2WPU1c6nN80cRmaTO2sQ4x3uAFdxWcVqcGQsvrT1d3GcmvjKF+W
         RqRgKWifvxq9SxvZo5rREr3XNT9aLsYUEY0G/8ZcEjzxvNZSge0gOeIPvS0lDupTEuFD
         EC45W7/14whKjoP7jyHg3Yth82AbpWBh9mGE9TktFxcUdLd4nW3XD47IjMaiYIBaVhOO
         CdFI3DV8ZD+7Mz93F6WROC2LtgUktJhAn75dv0q56rdw6QQan7m+OF6eheikI6c+NTqQ
         hEDg==
X-Gm-Message-State: AFqh2kpys2p5q2qM4snmRp6Km9oSc9ITCp8qkDoWAhB1pkHuOanQM73f
        yoq6dJMh/OXkDNd5gAvATkuG/A==
X-Google-Smtp-Source: AMrXdXtXRI6A4TNlWSdtGXMNKtXaOx+xvopqc946bLCtJouV8zIk+8cpXiW2moR5mnYS/MffCis/gA==
X-Received: by 2002:a05:600c:4f82:b0:3db:25a0:ca5b with SMTP id n2-20020a05600c4f8200b003db25a0ca5bmr2317662wmq.37.1674147971210;
        Thu, 19 Jan 2023 09:06:11 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f24-20020a05600c491800b003d9e74dd9b2sm5110372wmp.9.2023.01.19.09.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 09:06:10 -0800 (PST)
Message-ID: <5d3059e5-168d-a039-5ea1-a7b787dadc97@linaro.org>
Date:   Thu, 19 Jan 2023 18:06:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/5] cpuidle: psci: Mark as PREEMPT_RT safe
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Adrien Thierry <athierry@redhat.com>,
        Brian Masney <bmasney@redhat.com>,
        linux-rt-users@vger.kernel.org
References: <20221219151503.385816-1-krzysztof.kozlowski@linaro.org>
 <20221219151503.385816-3-krzysztof.kozlowski@linaro.org>
 <CAPDyKFr=-Mts4QtdizW5-D5qO3aP=9ODMhgST4Nx74n5xXxi5A@mail.gmail.com>
 <26e431a5-9666-0c72-7b0b-1a6c1bfaec22@linaro.org>
In-Reply-To: <26e431a5-9666-0c72-7b0b-1a6c1bfaec22@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/2023 16:40, Krzysztof Kozlowski wrote:
> On 17/01/2023 16:27, Ulf Hansson wrote:
>> On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> The PSCI cpuidle power domain in power_off callback uses
>>> __this_cpu_write() so it is PREEMPT_RT safe.  This allows to use it in
>>> Realtime kernels and solves errors like:
>>>
>>>   BUG: scheduling while atomic: swapper/2/0/0x00000002
>>>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>>>   Call trace:
>>>    dump_backtrace.part.0+0xe0/0xf0
>>>    show_stack+0x18/0x40
>>>    dump_stack_lvl+0x68/0x84
>>>    dump_stack+0x18/0x34
>>>    __schedule_bug+0x60/0x80
>>>    __schedule+0x628/0x800
>>>    schedule_rtlock+0x28/0x5c
>>>    rtlock_slowlock_locked+0x360/0xd30
>>>    rt_spin_lock+0x88/0xb0
>>>    genpd_lock_nested_spin+0x1c/0x30
>>>    genpd_power_off.part.0.isra.0+0x20c/0x2a0
>>>    genpd_runtime_suspend+0x150/0x2bc
>>>    __rpm_callback+0x48/0x170
>>>    rpm_callback+0x6c/0x7c
>>>    rpm_suspend+0x108/0x660
>>>    __pm_runtime_suspend+0x4c/0x8c
>>>    __psci_enter_domain_idle_state.constprop.0+0x54/0xe0
>>>    psci_enter_domain_idle_state+0x18/0x2c
>>>    cpuidle_enter_state+0x8c/0x4e0
>>>    cpuidle_enter+0x38/0x50
>>>    do_idle+0x248/0x2f0
>>>    cpu_startup_entry+0x24/0x30
>>>    secondary_start_kernel+0x130/0x154
>>>    __secondary_switched+0xb0/0xb4
>>>
>>> Cc: Adrien Thierry <athierry@redhat.com>
>>> Cc: Brian Masney <bmasney@redhat.com>
>>> Cc: linux-rt-users@vger.kernel.org
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>> ---
>>>  drivers/cpuidle/cpuidle-psci-domain.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpuidle/cpuidle-psci-domain.c b/drivers/cpuidle/cpuidle-psci-domain.c
>>> index c80cf9ddabd8..d15a91fb7048 100644
>>> --- a/drivers/cpuidle/cpuidle-psci-domain.c
>>> +++ b/drivers/cpuidle/cpuidle-psci-domain.c
>>> @@ -62,7 +62,8 @@ static int psci_pd_init(struct device_node *np, bool use_osi)
>>>         if (!pd_provider)
>>>                 goto free_pd;
>>>
>>> -       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_CPU_DOMAIN;
>>> +       pd->flags |= GENPD_FLAG_IRQ_SAFE | GENPD_FLAG_RT_SAFE | \
>>> +                    GENPD_FLAG_CPU_DOMAIN;
>>
>> My main concern with this, is that it will affect the parent domains
>> too. Whether those would be able to use the GENPD_FLAG_RT_SAFE or not,
>> is a different story.
>>
>> In one way or the other, I think it would be better to limit the
>> GENPD_FLAG_RT_SAFE to be used only for PREEMPT_RT kernels.
> 
> I can do it... or maybe we should just drop the flags (RT and IRQ safe)
> when parent domain does not have it?

Actually, with next patch, I can skip this one entirely. This is needed
if PSCI cpuidle driver invokes runtime PM functions which eventually
puts PSCI cpuidle power domain into suspend/resume. If the former does
not happen, the domain driver won't be even called so my problem disappears.

Since I need patch 3/5 - effectively disabling PSCI cpuidle runtime PM -
we can drop this one, till we find a real user needing it.

Best regards,
Krzysztof

