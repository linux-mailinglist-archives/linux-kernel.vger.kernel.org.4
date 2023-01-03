Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A5B65BE58
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237383AbjACKof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbjACKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:44:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DB23A187
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 02:44:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id az7so4597538wrb.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 02:44:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wRoXjucpyLnrH29TmQH3kHfWwQiVFXi4441mn81bzmo=;
        b=bI2vh4rxKWeKspU9/ZPqPG3vPgaWqLwxtO0SJ1dRGwpE+7+Cis5H771DOGU1PPuQn2
         hIbb5746ZX5nA3/J6Ggh7IWv0v8BgF1VQQKiBmjGgUrHRofisEUfijOPaqUJ42m8SVBo
         L6ocjjAF9jiM+FchSniD+aaHLwJMuqcx177gP/6p5vrCIQqDQ00CGyMyH7xixe9MxwXn
         dwwm+WT0UaGkm2tdGOphjfMkPNuAgzvc5bRKylgoa5m6vZoQ3BJ9HG9JT5dPVrFyzJdt
         Dejp+ZuFNM9yAnIFicyjqKnv+EOfSTtgddlYfDbuJW9Yie6O2fsNlSDF/x4it893Rs75
         gK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wRoXjucpyLnrH29TmQH3kHfWwQiVFXi4441mn81bzmo=;
        b=qwXXhwbsEA7Z7bUj1R/zExvFR+dVZJUYe4isuiA1atA2tWMnV2rXwFZVefoQOHxipA
         gQINAdvEI0ZJ/frDpCExttpQmgC0lpdAh8ZjKiwQm/o16J/i1dAgv6cIZJPNgivDk96x
         C0GuNJMDApnTrxDsJT+IFOa+NDMueUzkoXbztyqE+JvduTB6BMHHaS/7MZ8iu7w7zJIq
         Vo5/h9AOHyg9I1bmsdEU4GwtfDRWszSw49WTo2R+YwddK3GtUH+8kGEjkZnBvYE01bd1
         FAS0pWQMCXbz/bFIEMwwpe8agOk+X7OVZ8fMwsQg3LfaZT3NBXNonUlrm6qUjqeAF9C0
         rQWg==
X-Gm-Message-State: AFqh2kqbP0/keJsXr2yrkKgQ0M3pnuIuh5H/qovLtnkiGrEbUQkaSP5s
        4UA0SC/7KKADi5M3R2dd3NDo1g==
X-Google-Smtp-Source: AMrXdXtFSmoF42unxb1LeYspKdW6lxrRsmyrUcAh2YIgs98/DEKrf/yuN2BfXO8BdljgfVlP5eDseQ==
X-Received: by 2002:adf:f54a:0:b0:236:611b:e8eb with SMTP id j10-20020adff54a000000b00236611be8ebmr28438067wrp.37.1672742669404;
        Tue, 03 Jan 2023 02:44:29 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id k1-20020a5d5181000000b0024207478de3sm30751719wrv.93.2023.01.03.02.44.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 02:44:29 -0800 (PST)
Message-ID: <6eac88de-637d-468e-2119-d9cab4f8b7dc@linaro.org>
Date:   Tue, 3 Jan 2023 11:44:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/3] thermal/acpi: Add ACPI trip point routines
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rui.zhang@intel.com, Amit Kucheria <amitk@kernel.org>
References: <20230102180112.1954082-1-daniel.lezcano@kernel.org>
 <20230102180112.1954082-2-daniel.lezcano@kernel.org>
 <CAJZ5v0hBtjkZxSN+B9WEwe4WR6+zwzY5QAPCE5Cq7ONB7x80YA@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hBtjkZxSN+B9WEwe4WR6+zwzY5QAPCE5Cq7ONB7x80YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/01/2023 19:22, Rafael J. Wysocki wrote:
> On Mon, Jan 2, 2023 at 7:01 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> From: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> The ACPI specification describes the trip points, the device tree
>> bindings as well.
>>
>> The OF code uses the generic trip point structures.
>>
>> The ACPI has their own trip points structure and uses the get_trip_*
>> ops to retrieve them.
>>
>> We can do the same as the OF code and create a set of ACPI functions
>> to retrieve a trip point description. Having a common code for ACPI
>> will help to cleanup the remaining Intel drivers and get rid of the
>> get_trip_* functions.
>>
>> These changes add the ACPI thermal calls to retrieve the basic
>> information we need to be reused in the thermal ACPI and Intel
>> drivers.
>>
>> The different ACPI functions have the generic trip point structure
>> passed as parameter where it is filled.
>>
>> This structure aims to be the one used by all the thermal drivers and
>> the thermal framework.
>>
>> After this series, a couple of Intel drivers and the ACPI thermal
>> driver will still have their own trip points definition but a new
>> series on top of this one will finish the conversion to the generic
>> trip point handling.
>>
>> This series depends on the generic trip point added to the thermal
>> framework and available in the thermal/linux-next branch.
>>
>>   https://lkml.org/lkml/2022/10/3/456
>>
>> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
>> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
>> ---
>>   drivers/thermal/Kconfig        |  13 ++
>>   drivers/thermal/Makefile       |   1 +
>>   drivers/thermal/thermal_acpi.c | 279 +++++++++++++++++++++++++++++++++
>>   include/linux/thermal.h        |  16 ++
>>   4 files changed, 309 insertions(+)
>>   create mode 100644 drivers/thermal/thermal_acpi.c
>>
>> diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
>> index e052dae614eb..2c19bccd1223 100644
>> --- a/drivers/thermal/Kconfig
>> +++ b/drivers/thermal/Kconfig
>> @@ -76,6 +76,19 @@ config THERMAL_OF
>>            Say 'Y' here if you need to build thermal infrastructure
>>            based on device tree.
>>
>> +config THERMAL_ACPI
> 
> Not needed.
> 
> Or if you want it to be built only if there are any users, call it
> ACPI_THERMAL_LIB and do
> 
> config ACPI_THERMAL_LIB
>      depends on ACPI_THERMAL
>      bool
> 
> and let the users select it.

Yes, I think it makes more sense to not provide any option and just 
compile the wrappers when ACPI_THERMAL is set.


>> diff --git a/drivers/thermal/Makefile b/drivers/thermal/Makefile
>> index 2506c6c8ca83..60f0dfa9aae2 100644
>> --- a/drivers/thermal/Makefile
>> +++ b/drivers/thermal/Makefile
>> @@ -13,6 +13,7 @@ thermal_sys-$(CONFIG_THERMAL_NETLINK)         += thermal_netlink.o
>>   # interface to/from other layers providing sensors
>>   thermal_sys-$(CONFIG_THERMAL_HWMON)            += thermal_hwmon.o
>>   thermal_sys-$(CONFIG_THERMAL_OF)               += thermal_of.o
>> +thermal_sys-$(CONFIG_THERMAL_ACPI)             += thermal_acpi.o
>>
>>   # governors
>>   thermal_sys-$(CONFIG_THERMAL_GOV_FAIR_SHARE)   += gov_fair_share.o
>> diff --git a/drivers/thermal/thermal_acpi.c b/drivers/thermal/thermal_acpi.c
>> new file mode 100644
>> index 000000000000..28c629b4d814
>> --- /dev/null
>> +++ b/drivers/thermal/thermal_acpi.c
>> @@ -0,0 +1,279 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Copyright 2022 Linaro Limited
>> + *
>> + * Author: Daniel Lezcano <daniel.lezcano@linaro.org>
>> + *
>> + * ACPI thermal configuration
>> + */
>> +#include <linux/acpi.h>
>> +#include <linux/module.h>
>> +#include <linux/kernel.h>
>> +#include <linux/units.h>
>> +#include <uapi/linux/thermal.h>
>> +
>> +#include "thermal_core.h"
>> +
>> +int thermal_acpi_trip_gtsh(struct acpi_device *adev)
>> +{
>> +       unsigned long long hyst;
>> +       acpi_status status;
>> +
>> +       status = acpi_evaluate_integer(adev->handle, "GTSH", NULL, &hyst);
>> +       if (ACPI_FAILURE(status))
>> +               return 0;
>> +
>> +       return (int)(hyst * 100);
> 
> What if the result is larger than INT_MAX?

That would mean ACPI is returning more than 4 billions degree hysteresis 
value.

What strategy should we use in these functions? Trust the values 
returned by ACPI or double check if they are consistent ?


>> +}
>> +EXPORT_SYMBOL_GPL(thermal_acpi_trip_gtsh);
>> +
>> +int thermal_acpi_get_tzd(struct acpi_device *adev, struct acpi_handle_list *devices)
>> +{
>> +       acpi_status status;
>> +
>> +       /*
>> +        * _TZD (Thermal zone device): This optional object evaluates
>> +        * to a package of device names. Each name corresponds to a
>> +        * device in the ACPI namespace that is associated with the
>> +        * thermal zone. The temperature reported by the thermal zone
>> +        * is roughly correspondent to that of each of the devices.
>> +        */
> 
> I don't think that the comment is necessary.
> 
> The spec already contains a definition of this object.

Yes, this comment is the description from the spec. I put them there to 
save time for those who are reading the code so they don't have to go 
back and forth between the documentation and the code.

Do you really want me to remove all of them ?

[ ... ]


> Overall, I'm not sure about simple wrappers around
> acpi_evaluate_integer/reference() that effectively discard the return
> value and don't even bother to sanitize the return value before
> returning it to the caller.

Ok, so we don't want to trust the values returned by ACPI.

If all the sanity checks are done in the functions, would it make more 
sense then ?


> The ones that initialize a trip point make more sense IMO.


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

