Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553FA673E12
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231526AbjASP62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbjASP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:58:15 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6AE872BC
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:58:07 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1602518wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gQh0d2d3M7BVSCcyQZ/JkIHHtILkCJvFyXalBfM8ct4=;
        b=owdCTvk7akDhOaCdo2MzLWpG+rB7UdvjKBN9kyrv/NKsI0sN5r7dGwHsss2DpgsUf8
         zm1q+2pvBKVNdcxLejLl/Dht6JFny5uOFk8vRCZwbh/sa7RaC/GLXRGs6cYFcdrx3Scn
         xT6PgvAyoaHDTT6GWGvB98ZIvgKGy0jZIMfXCu64QF6RbRxQ9++12lf9fm5sZyYUMs20
         Mc5Z/LJ5Znf8YFbZCwj2WjsLrY32U4TlDrdTgrDwMlpMwPO8UjrFcfAPsu9hjRVO+/8N
         CIRsE9+1yYet7g5gLgNs2YFAECRQPJ7AzauQDKNXaYKPAfwSLmCwybBukJy3DIbg3OOz
         +IgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gQh0d2d3M7BVSCcyQZ/JkIHHtILkCJvFyXalBfM8ct4=;
        b=Znua3qW/9pE1+uxN5KYCxMYTJXg6ndPWhRcQe6zBDp21+jYqae8S81+6VQ0wQ86MeI
         WOmOYk9n7h8uhFZc8ydGMYDfHkQQMaNXYEBACdpHOL6lemSnla8yHjhksaPs6yhEke3y
         sTgq9HcIqLMShX9T38hb8MhrUE49C5CX4wAX9eSsU99zFKVjtXQcCWqucZBodfiNbpKz
         F+Yh/ftxnGb4QR/7H6vsAXdGMHR5deN121HkwzV1yt2MTUGHz0+hs/AIQrb26zojcjlI
         5dYXXIvu96DMB14r8yjkDYx3WbUGdw+emQ7EuUytmZ4tzt4NbET70pehzLlEU4taooXB
         7MqQ==
X-Gm-Message-State: AFqh2kpZ15pK6cd/plxIztHBPRZW15EItMlNSF10Z3L3VVZh0A6kO8r5
        IAZTZwhvnovIy4Vy9OV6MrqrDQ==
X-Google-Smtp-Source: AMrXdXtMKAou2/XvWDBzPQR6Vseue9tpoqCal8oksDpCwyXgPLdJ2U5VT7/tCX6HQX0llVCa6nZGsw==
X-Received: by 2002:a05:600c:1c83:b0:3db:27b3:a654 with SMTP id k3-20020a05600c1c8300b003db27b3a654mr1576213wms.26.1674143886226;
        Thu, 19 Jan 2023 07:58:06 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n21-20020a05600c4f9500b003db0cab0844sm2153116wmq.40.2023.01.19.07.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 07:58:05 -0800 (PST)
Message-ID: <18793e0c-0563-05a4-2e38-f919641a3bd4@linaro.org>
Date:   Thu, 19 Jan 2023 16:58:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 5/5] PM: domains: Do not call
 device_pm_check_callbacks() when holding genpd_lock()
Content-Language: en-US
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
 <20221219151503.385816-6-krzysztof.kozlowski@linaro.org>
 <CAPDyKFoHx+cr-kO-E8mH2UMbs-sH4LY78+1VzJrkS+kGVKvYeQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPDyKFoHx+cr-kO-E8mH2UMbs-sH4LY78+1VzJrkS+kGVKvYeQ@mail.gmail.com>
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

On 17/01/2023 16:11, Ulf Hansson wrote:
> On Mon, 19 Dec 2022 at 16:15, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> If PM domain on PREEMPT_RT is marked as GENPD_FLAG_RT_SAFE(), the
>> genpd_lock() will be a raw spin lock, thus device_pm_check_callbacks()
>> must be called outside of the domain lock.
>>
>> This solves on PREEMPT_RT:
>>
>>   [ BUG: Invalid wait context ]
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
>>
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
>>         if (ret)
>>                 goto out;
>>
>> +
>> +       /* PREEMPT_RT: Must be outside of genpd_lock */
>> +       device_pm_check_callbacks(dev);
>> +
>>         genpd_lock(genpd);
>>
>>         genpd_set_cpumask(genpd, gpd_data->cpu);
>> -       dev_pm_domain_set(dev, &genpd->domain);
>> +       dev_pm_domain_set_no_cb(dev, &genpd->domain);
>>
>>         genpd->device_count++;
>>         if (gd)
> 
> Rather than splitting up the assignment in two steps, I think it
> should be perfectly fine to move the call to dev_pm_domain_set()
> outside the genpd lock.
> 
> Note that, genpd_add_device() is always being called with
> gpd_list_lock mutex being held. This prevents the genpd from being
> removed, while we use it here.

Hm, indeed, should be fine.

> 
> Moreover, we need a similar change for the call to dev_pm_domain_set()
> in genpd_remove_device().

Right.

Best regards,
Krzysztof

