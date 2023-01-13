Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8536696CA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 13:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232678AbjAMMUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 07:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbjAMMTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 07:19:32 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591DE78179
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:12:50 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id g19-20020a05600c4ed300b003d9eb1dbc0aso14247736wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 04:12:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k2B0hsASFUkHWI+dtbJoqoXBrOmDXx4P5iE4tDoIv9Y=;
        b=r5LMJrP1xmHoLFxCeIJz1DlWNsBJgQSDhoBQsjNX1FZGWGcX5q6iezTlqp7iJ7dxsj
         2l30AzU3QT015HNw22K27UXC69kTC9Dx3zjaT4zaSywPtt2UmipEhx2YBtCQbTSGOpFa
         SVBhIPlb1y5YIsk0cxJGkLQuVIdSEnK9KyyCOIKergfjR9O/STPWjKP0B6cjspqe0DJ5
         ufpKjggsU9ht6XRWi5FqyRLTAF0q/6DILqpjRUnnENWhFyEL2Sn2COJYru4UULhFeCzs
         VKq9rKeYlp0KZ6KWzId19etifFPGkY4nLW/sjcNxqjKFA2MvjEAz/28i86FUaNO5dHtc
         TJLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=k2B0hsASFUkHWI+dtbJoqoXBrOmDXx4P5iE4tDoIv9Y=;
        b=oVi3IH+SvBW5eoLs0yBbYaW/PiOHX32IIodZ+QGMcoREJTCLCNKIqr6rjz+Kv5KXrO
         KubQWARqUOmqOB3MsK7vD7chK0sFJfGRXpJ7utPVm+3OuCUNJhS9tzF8C7A3Fiy++eyq
         Ud2lZn4Ak/VftijMQY1RsQwZbAP/dh7G18tBM35PO73knmx2qfQYcEIwDWnnzfENV+Zp
         Qybtw3IQQs1KbfzrMYHICPh0wiHCmnKbKAagUXFZlX9ahb0Gymwahc8pYz4sbZo5wr33
         8w53W0fUAWSHs603/FyO0PBHmmiGLOSH7XOM8XQ1o/jVHQGEeW06JAg6RiWj6Gbkh/cJ
         RPAw==
X-Gm-Message-State: AFqh2kovI+r/HZwCDA7vhuoeZGNdQ5XT4bXiOCmki1HsgAWAgVuNzHE7
        /FGCP91bJJ/SjIF2By9z+YOlEQ==
X-Google-Smtp-Source: AMrXdXu2ltpUhMmjl2uUB9itPccs5udi7WYLCpJAPI1VbQ0Ahcuu4yLeptqX5/gWOIqo97PCCNz40w==
X-Received: by 2002:a7b:c851:0:b0:3d9:f067:1c32 with SMTP id c17-20020a7bc851000000b003d9f0671c32mr13643754wml.29.1673611968714;
        Fri, 13 Jan 2023 04:12:48 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id t9-20020a05600c198900b003d9e74dd9b2sm22536878wmq.9.2023.01.13.04.12.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 04:12:48 -0800 (PST)
Message-ID: <ddcfbd2e-2ea0-9305-96c4-8127181cdd8c@linaro.org>
Date:   Fri, 13 Jan 2023 13:12:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points
 int340x
Content-Language: en-US
To:     "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "srinivas.pandruvada@linux.intel.com" 
        <srinivas.pandruvada@linux.intel.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
 <20230110151745.2546131-4-daniel.lezcano@linaro.org>
 <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rui;

thanks for testing and your comments


On 13/01/2023 12:41, Zhang, Rui wrote:
> On Tue, 2023-01-10 at 16:17 +0100, Daniel Lezcano wrote:
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops
>> are
>> needed and they can be removed.
>>
>> Convert the ops content logic into generic trip points and register
>> them with the thermal zone.
>>
>> In order to consolidate the code, use the ACPI thermal framework API
>> to fill the generic trip point from the ACPI tables.
>>
>> It has been tested on a Intel i7-8650U - x280 with the INT3400, the
>> PCH, ACPITZ, and x86_pkg_temp. No regression observed so far.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
>> ---
>>     V3:
>>        - The driver Kconfig option selects CONFIG_THERMAL_ACPI
>>        - Change the initialization to use GTSH for the hysteresis on
>>          all the trip points
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/thermal/intel/int340x_thermal/Kconfig |   1 +
>>   .../int340x_thermal/int340x_thermal_zone.c    | 177 ++++----------
>> ----

[ ... ]

>> -static int int340x_thermal_get_trip_hyst(struct thermal_zone_device
>> *zone,
>> -		int trip, int *temp)
>> -{
>> -	struct int34x_thermal_zone *d = zone->devdata;
>> -	acpi_status status;
>> -	unsigned long long hyst;
>> -
>> -	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL,
>> &hyst);
>> -	if (ACPI_FAILURE(status))
>> -		*temp = 0;
>> -	else
>> -		*temp = hyst * 100;
> 
> The previous code returns hyst * 100.
> But the new API retuurns hyst directly.
> 
> -/sys/class/thermal/thermal_zone2/trip_point_4_hyst:2000
> +/sys/class/the
> rmal/thermal_zone2/trip_point_4_hyst:20
> 
> Is this done on purpose?

No, it is an error. The function thermal_acpi_trip_gtsh() should do:

	return deci_kelvin_to_millicelsius(hyst);




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

