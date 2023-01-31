Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A496832E8
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 17:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjAaQlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 11:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjAaQlP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 11:41:15 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717918A9F
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:41:13 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t7so6427455wrp.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 08:41:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YhWVpau0dXVwuELHoiPSUTlj3PZlVLW33aApp56jjJQ=;
        b=XKthMvlgA/Bv+b9UI+yMfqrwXyTzSuIBhWFrW0Aycn8TriVqabWKz/VgmFvGrh+YYW
         EryzlHCVV4FnyV0qqUvcLN6wdIM9Y99EIJMnKE84BkIuEuWc2yS/6HHbWXq9mckuTvXQ
         GahdU2iufjpVawa08dYd+kht1Nl4kMHmHRf3Nh3oUkyvSlTyF/eEwfQeikkXlAmx4uJp
         7qzkPjBIuyrd7qtMq5ojgdj0GMYD5fsHDxKLjRZiSlWQCE3cFpxWTBKxsXw8xvsJdnhR
         6cqZfQhzmAWV+EFajkUuz0utSoWTETBCKuazudXKwk/nIBNHAL16QHF5GkR41kNLXyXT
         Au+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YhWVpau0dXVwuELHoiPSUTlj3PZlVLW33aApp56jjJQ=;
        b=nL6xS3SOl1MP2KQiTUi+KuS0Y1FnWEVX5VadiXvi3RKKiAM2ydsXZzTpdOHl2c54kN
         trl8N36KnTpqYJ8dlO3Bo3NuWYVbm97LLSbb1QCWu035Me5fRWvzrhS0YUXBKpJmFLQM
         lX7DP7jjQBm6tPHo0IiA62TXwLiwSZNpQqWht10afmzJRyG0sGKkYVLNDe7rz5f1Nifi
         m5sJTz8Bjb7Oy3LEoU/h8n7UMyi/71Dkrk/XLM1zVBbNIRlNxWGHhH+1LtLnxY3jSyup
         fKUvzrulR4PjTgdySgUWSTz/duucYoyKKtwcwhI26d4R/FL5oVGO1Rwrk9fZHZf1sjl7
         y1RQ==
X-Gm-Message-State: AO0yUKW6qyvA2Ab4PQLUJaBvs7+QHW+42xZKbgmND4FeA7VBzog1rmEd
        v6nBrrsKAVHwe9rl14HQmcXQaQ==
X-Google-Smtp-Source: AK7set8jSCvPamJdPNrdVYHcStifk4Yp2eqGvyzpIZ28Z24OGqEkWQ0/RrhD1sNzkk6J8odImxuxVw==
X-Received: by 2002:adf:e90f:0:b0:2bf:ee0f:9f04 with SMTP id f15-20020adfe90f000000b002bfee0f9f04mr7421527wrm.45.1675183271438;
        Tue, 31 Jan 2023 08:41:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b14-20020adff90e000000b002be34f87a34sm15369083wrr.1.2023.01.31.08.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 08:41:11 -0800 (PST)
Message-ID: <621aca19-6a44-9d42-6fde-1835035c28b4@linaro.org>
Date:   Tue, 31 Jan 2023 17:41:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] thermal/drivers/intel: Use generic trip points for
 quark_dts
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     srinivas.pandruvada@linux.intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, rui.zhang@intel.com,
        Amit Kucheria <amitk@kernel.org>
References: <20230118181622.33335-1-daniel.lezcano@linaro.org>
 <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0icjsLBNkDqm49az=GixfEoLHAtCm7H13uOUv7Hr6yO2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 15:15, Rafael J. Wysocki wrote:
> On Wed, Jan 18, 2023 at 7:16 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> The thermal framework gives the possibility to register the trip
>> points with the thermal zone. When that is done, no get_trip_* ops are
>> needed and they can be removed.
>>
>> Convert ops content logic into generic trip points and register them with the
>> thermal zone.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> -       aux_entry->tzone = thermal_zone_device_register("quark_dts",
>> -                       QRK_MAX_DTS_TRIPS,
>> -                       wr_mask,
>> -                       aux_entry, &tzone_ops, NULL, 0, polling_delay);
>> +       err = get_trip_temp(QRK_DTS_ID_TP_CRITICAL, &temperature);
>> +       if (err)
>> +               goto err_ret;
>> +
>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].temperature = temperature;
>> +       aux_entry->trips[QRK_DTS_ID_TP_CRITICAL].type = THERMAL_TRIP_CRITICAL;
>> +
>> +       err = get_trip_temp(QRK_DTS_ID_TP_HOT, &temperature);
>> +       if (err)
>> +               goto err_ret;
> 
> If I'm not mistaken, this won't even try to register the thermal zone
> if at least one trip cannot be initialized, but previously it was
> registered in that case, but the trips that failed to respond were
> disabled.
> 
> This is a change in behavior that would at least need to be documented
> in the changelog, but it isn't.
> 
> I'm not sure if it is safe to make even, however.

Thanks for catching this.

Two solutions:

1. Set the temperature to THERMAL_TEMP_INVALID and change 
get_thermal_trip() to return -EINVAL or -ERANGE if the temperature is 
THERMAL_TEMP_INVALID

2. Register only the valid trip points.

What would be the preferable way ?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

