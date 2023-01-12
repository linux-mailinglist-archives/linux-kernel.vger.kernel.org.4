Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E6C066712F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 12:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbjALLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 06:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjALLq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 06:46:26 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7165C92C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:37:30 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id l22so14314698eja.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 03:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hXQ/SgOW9ZIz5YPVls2OSgh2a8mqb0cRkYRLLkLbVHI=;
        b=uX4CGHSmu8BJWn04RKsyh8DbfwXi9VpEohOvGmvvEE2DZjYm7gO3ehgZujRagi2N8T
         Fg+s2iMX/JLFPBnFtxDCUZQZlsrOc6+OvM8Y2vD60B4FfXZQTWcPKHNJEbUAb5d/oEDr
         2XgyxpDm5qb6z441NicpOHTr8KNOLBO5zwfCfANgmQN60KEknw4qzzN6SsfY15Mqwrw9
         6IyZJNSH4R2RSwjka4pIg/3sTBaoDcZ6M00tG44WtAO+nWSWunMKlgC5jxq10D+XuXxv
         3U5Cm3IH140QagEVhbtEIbnaYS/0ywNZ/ShGG47XQ5NnF+Dx31aMIpLREa9qr0UkwYj+
         3ldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hXQ/SgOW9ZIz5YPVls2OSgh2a8mqb0cRkYRLLkLbVHI=;
        b=ECfZacjirTYewHo8MwuF8E9ogpVPxKItuGVua88PFYbZ8rK5KtOMwURvLBVGbOdpRi
         grypekLJ7bc1O9oThMCVflbE6sCK5eMz+L4RVcNwNp9o8baSarOzaIHdGADNnv3UrNIc
         fGcxdYPg0mcnLrxNhhYGv5p6Zcqi73rL3oj8Yva7Pj9Jm32B7Sh6MckMY/YDkleYXElP
         duCbuV80LAt4UZcJSZIk34aIK6V5Q/fPwSZMgMNjzbLDDc34FfBXwJXGYoM0iPYJ0bqw
         lnAJj61iE3J79qaLWBagNWrR2SaRnidI7z0zSTMRMVLGFdwGySZAoQ4yYB/edSCtlF8b
         Yujw==
X-Gm-Message-State: AFqh2kq5UM1hBGYi+M2rPY7kxfqA66H7DlUEkIHwq4w5Hw3CrYvTuw0d
        Facf5cDF/bJvQobVDiTE0550Yw==
X-Google-Smtp-Source: AMrXdXtISiqCWRExHvPBfANuhyJGYIWCtdeYm0iF4V7TNOJs9R8iNDdaYn430QChTu9b2s5637tU/Q==
X-Received: by 2002:a17:907:c28f:b0:83f:5f77:8ff9 with SMTP id tk15-20020a170907c28f00b0083f5f778ff9mr65293259ejc.12.1673523449252;
        Thu, 12 Jan 2023 03:37:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id ku12-20020a170907788c00b0084d4564c65fsm5158059ejc.42.2023.01.12.03.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 03:37:28 -0800 (PST)
Message-ID: <4562c5c8-e2bd-4ade-55df-dab07540ce19@linaro.org>
Date:   Thu, 12 Jan 2023 12:37:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v2 5/5] PM: domains: Do not call
 device_pm_check_callbacks() when holding genpd_lock()
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
 <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
 <Y7/vdnD8qELX4A5m@linutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Y7/vdnD8qELX4A5m@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 12:31, Sebastian Andrzej Siewior wrote:
> On 2022-12-19 16:15:03 [+0100], Krzysztof Kozlowski wrote:
>> If PM domain on PREEMPT_RT is marked as GENPD_FLAG_RT_SAFE(), the
>> genpd_lock() will be a raw spin lock, thus device_pm_check_callbacks()
> 
> a raw_spinlock_t
> 
>> must be called outside of the domain lock.
> 
> Right. First the sleeping lock, followed by the spinning locks. This is
> covered in
> 	Documentation/locking/locktypes.rst
> 
> at the end. 

I don't understand your comment. Do you expect me to change something?

> 
>> This solves on PREEMPT_RT:
> Yes but
>>   [ BUG: Invalid wait context ]
> 
> This "Invalid wait context" should also trigger on !PREEMPT_RT with
> CONFIG_PROVE_RAW_LOCK_NESTING.

Could be, I just did not hit it.

> 
>>   6.1.0-rt5-00325-g8a5f56bcfcca #8 Tainted: G        W
>>   -----------------------------
>>   swapper/0/1 is trying to lock:
>>   ffff76e045dec9a0 (&dev->power.lock){+.+.}-{3:3}, at: device_pm_check_callbacks+0x20/0xf0
>>   other info that might help us debug this:
>>   context-{5:5}
>>   3 locks held by swapper/0/1:
>>    #0: ffff76e045deb8e8 (&dev->mutex){....}-{4:4}, at: __device_attach+0x38/0x1c0
>>    #1: ffffa92b81f825e0 (gpd_list_lock){+.+.}-{4:4}, at: __genpd_dev_pm_attach+0x7c/0x250
>>    #2: ffff76e04105c7a0 (&genpd->rslock){....}-{2:2}, at: genpd_lock_rawspin+0x1c/0x30
>>   stack backtrace:
>>   CPU: 5 PID: 1 Comm: swapper/0 Tainted: G        W          6.1.0-rt5-00325-g8a5f56bcfcca #8
>>   Hardware name: Qualcomm Technologies, Inc. Robotics RB5 (DT)
>>   Call trace:
>>    dump_backtrace.part.0+0xe0/0xf0
>>    show_stack+0x18/0x40
>>    dump_stack_lvl+0x8c/0xb8
>>    dump_stack+0x18/0x34
>>    __lock_acquire+0x938/0x2100
>>    lock_acquire.part.0+0x104/0x28c
>>    lock_acquire+0x68/0x84
>>    rt_spin_lock+0x40/0x100
>>    device_pm_check_callbacks+0x20/0xf0
>>    dev_pm_domain_set+0x54/0x64
>>    genpd_add_device+0x258/0x340
>>    __genpd_dev_pm_attach+0xa8/0x250
>>    genpd_dev_pm_attach_by_id+0xc4/0x190
>>    genpd_dev_pm_attach_by_name+0x3c/0x60
>>    dev_pm_domain_attach_by_name+0x20/0x30
>>    dt_idle_attach_cpu+0x24/0x90
>>    psci_cpuidle_probe+0x300/0x4b0
>>    platform_probe+0x68/0xe0
>>    really_probe+0xbc/0x2dc
>>    __driver_probe_device+0x78/0xe0
>>    driver_probe_device+0x3c/0x160
>>    __device_attach_driver+0xb8/0x140
>>    bus_for_each_drv+0x78/0xd0
>>    __device_attach+0xa8/0x1c0
>>    device_initial_probe+0x14/0x20
>>    bus_probe_device+0x9c/0xa4
>>    device_add+0x3b4/0x8dc
>>    platform_device_add+0x114/0x234
>>    platform_device_register_full+0x108/0x1a4
>>    psci_idle_init+0x6c/0xb0
>>    do_one_initcall+0x74/0x450
>>    kernel_init_freeable+0x2e0/0x350
>>    kernel_init+0x24/0x130
>>    ret_from_fork+0x10/0x20
> 
> I would prefer a description of the issue instead hacing this
> backtrace.

I'll extend the commit msg.

> 
>> Cc: Adrien Thierry <athierry@redhat.com>
>> Cc: Brian Masney <bmasney@redhat.com>
>> Cc: linux-rt-users@vger.kernel.org
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/base/power/domain.c | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
>> index 4dfce1d476f4..db499ba40497 100644
>> --- a/drivers/base/power/domain.c
>> +++ b/drivers/base/power/domain.c
>> @@ -1666,10 +1666,14 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
>>  	if (ret)
>>  		goto out;
>>  
>> +
>> +	/* PREEMPT_RT: Must be outside of genpd_lock */
> 
> Could this comment be rewritten if needed?
> The callback, which acquires sleeping locks on PREEMPT_RT, can be moved
> before genpd_lock() because it does not rely on this lock. It must be
> moved because the latter may acquire spinning locks.

Sure

Best regards,
Krzysztof

