Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FD6E663B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 15:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbjDRNpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 09:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232311AbjDRNo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 09:44:58 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E42C167F2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:44:49 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id d8-20020a05600c3ac800b003ee6e324b19so14857300wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 06:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681825488; x=1684417488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1+A8ldOBJb4TTardky3TqCF0C5aJypjFs7swksN1BA=;
        b=w45twfQ+bDR3nz+o5rBp1mQk0L8s966VTCGqMxqLDM/OdAw2xh4v0Qq0tgMRBzOZjE
         u2Jf0b4K5n8t2Vp7zec8TiR7JAtN8csrbI4IzSdR+zmJidLFwyJ5k65s2ZIrUOvY4AJw
         G+9npREHUc/NzidRoRZgV4POQZUPrU6w5qSW8YdzEGzCOniz743yGcTjTQrVvvTpzp24
         oTMFTRYD2WkkUmmxDbycH3FFARrmTfVQzzCkQLAdOET67wx0MuIvXlq7ZhBmM/FyWaiL
         PX9+Q7yEb1oLL7/dreWfFb4lHbae/wrTt03FR8ySawIbx4ZrdJjZmI2PJW67l/XGBHuO
         TkAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681825488; x=1684417488;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1+A8ldOBJb4TTardky3TqCF0C5aJypjFs7swksN1BA=;
        b=b8NEbRA8AdEUIQkR4jwFycjDMJczhYd0QfUkKI2nVQQH65ZiM9ixUx92boxDKhE2dc
         banuLIKsdK9xNDn+arLS41HHVz1u+C8nfhH3INBx96jHSMFTD8XbY6f0kbI8IHtaYAyw
         O3tyaWSq3TFxm9pIfBiqa29/xumRdC+4d96Cu3UrmEBjGMyGanReKqEyZKwI1Vt+LL0N
         LpoMaMn7ekPLka3T6E1Gis/H1nsNsEV6N5nJU31/7SrUXJN4GKZGkjiUPZyZWbFxViP3
         dVZhqe268ySvAto9I0QLbYBnDHMe/7gCJuhmbcAmBJ0fARRVNZATKOyK9WmqVpJWPcS0
         4KZw==
X-Gm-Message-State: AAQBX9fE74T0WEp/L6402FCvvyKISnhksTdl3Hb0Zu5y8UHGgy8/fF5B
        6EKv0oqTi1ixVGS1Nz0WWMucCQ==
X-Google-Smtp-Source: AKy350Z6FDH9meTA9AHlCprgtvsjSA1VzU+V8x8PTEJPF++yK20HjWZBTHjXYF2sS40B4B15wZEknA==
X-Received: by 2002:a05:600c:20c:b0:3f1:75d0:614d with SMTP id 12-20020a05600c020c00b003f175d0614dmr3897400wmi.38.1681825487084;
        Tue, 18 Apr 2023 06:44:47 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id e2-20020a5d65c2000000b002ceacff44c7sm13105157wrw.83.2023.04.18.06.44.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 06:44:46 -0700 (PDT)
Message-ID: <7fd7df2d-f473-c0fd-5c3c-40d0fb697db7@linaro.org>
Date:   Tue, 18 Apr 2023 15:44:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 5/6] thermal/drivers/acpi: Make cross dev link optional
 by configuration
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>,
        "open list:ACPI" <linux-acpi@vger.kernel.org>
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
 <20230413114647.3878792-6-daniel.lezcano@linaro.org>
 <CAJZ5v0jqB18c1u-eqcEiXW+fOH=nX=Uu3xi5sp2F9udsFUrYew@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0jqB18c1u-eqcEiXW+fOH=nX=Uu3xi5sp2F9udsFUrYew@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 15:38, Rafael J. Wysocki wrote:
> On Thu, Apr 13, 2023 at 1:47 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The ACPI thermal driver creates a link in the thermal zone device
>> sysfs directory pointing to the device sysfs directory. At the same
>> time, it creates a back pointer link from the device to the thermal
>> zone device sysfs directory.
>>
>>  From a generic perspective, having a device pointer in the sysfs
>> thermal zone directory may make sense. But the opposite is not true as
>> the same driver can be related to multiple thermal zones.
>>
>> The usage of these information is very specific to ACPI and it is
>> questionable if they are really needed.
>>
>> Let's make the code optional and disable it by default. If it hurts,
>> we will revert this change.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/acpi/Kconfig   | 13 +++++++++
>>   drivers/acpi/thermal.c | 62 ++++++++++++++++++++++++++++--------------
>>   2 files changed, 55 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
>> index ccbeab9500ec..7df4e18f06ef 100644
>> --- a/drivers/acpi/Kconfig
>> +++ b/drivers/acpi/Kconfig
>> @@ -336,6 +336,19 @@ config ACPI_THERMAL
>>            To compile this driver as a module, choose M here:
>>            the module will be called thermal.
>>
>> +config ACPI_THERMAL_SYSFS_ADDON
>> +       bool "Enable thermal sysfs addon"
>> +       depends on ACPI_THERMAL
>> +       def_bool n
>> +       help
>> +        Enable sysfs extra information added in the thermal zone and
>> +        the driver specific sysfs directories. That could be a link
>> +        to the associated thermal zone as well as a link pointing to
>> +        the device from the thermal zone. By default those are
>> +        disabled and are candidate for removal, if you need these
>> +        information anyway, enable the option or upgrade the
>> +        userspace program using them.
>> +
> 
> I don't think that the Kconfig option is appropriate and the help text
> above isn't really helpful.

I'm sorry, I'm missing something. Don't we want to make these sysfs 
extra information optional and disable them by default ?

>>   config ACPI_PLATFORM_PROFILE
>>          tristate
>>
>> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
>> index 5763db4528b8..30fe189d04f8 100644
>> --- a/drivers/acpi/thermal.c
>> +++ b/drivers/acpi/thermal.c
>> @@ -787,9 +787,44 @@ static struct thermal_zone_device_ops acpi_thermal_zone_ops = {
>>          .critical = acpi_thermal_zone_device_critical,
>>   };
>>
>> +#ifdef CONFIG_ACPI_THERMAL_SYSFS_ADDON
> 
> I agree with moving the code in question to separate functions, but I
> don't agree with putting it under the Kconfig option.

Do you mean use IS_ENABLED check like what is done with Menlow patch 6 ?

[ ... ]


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

