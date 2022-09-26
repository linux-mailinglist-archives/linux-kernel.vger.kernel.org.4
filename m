Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854815EB461
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 00:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiIZWOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 18:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbiIZWN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 18:13:59 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2FE95ACE
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:11:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id t14so12259031wrx.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 15:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=OVsxSLNmaJcqcwbpm1oGmfhwAHf39kZvm2oJ0u13iLM=;
        b=efvWO/lJ34nWle9/vF5eb4/g3qsGvhPS032pxcYwnDOz9CLcOVhDT7REyGD+cqJPQ0
         50brlHV192H1I+fTNnW02YbS9+KgUb7/MS93EHBlIreKFVkveJmaKueHFgD77auWSs6e
         Rx7Jj3IjWKKC8r3pwZWp13+rtJV7sD61Or4YUdHijutx2R5QkgmDYHcDgyYC3YNGhpJd
         5m7bQ2Ujh/14bv6wVbbGq4l8znxyuwPLosTedPVhxnttEARTHRA6vIh4GiVQ3eJehtV7
         zxQkyGj4aBE/FDeOCudie6nY53bFHubRm7FOOB0SfKF2d6Ja9Gy8SJr8vrOY3nAQyyEF
         MFZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=OVsxSLNmaJcqcwbpm1oGmfhwAHf39kZvm2oJ0u13iLM=;
        b=7d3hTtA734+TwVW0CQUQIzI4r+IBywOuuHppUXsi/5WHBvlnPivoqVNtSl6H2gswXY
         AUBkjLA11G2iheZSXGX/R23BclPGF9s+UB2l5qSRjtubB9UQ8Op0IeHzTBJlb0nZjysJ
         O5EXJs7f1aU4KSyz/Fc5+xybbwmQdf29mYm+p7Tqky/DlnQYfR4o/s+mUupEg1aLSfKj
         B7bptM9+KHtDkYLR6BCgpuyoEIqyfPG29YYkjEeLaa1LuUSVlXK7DPSgrV0JZBcpaaAc
         wbfUnufRZNiH8EsaEzYwxd+gpQbjVjPIqnjdN6oOZ9rlZ42bpdfD2/rHbTXrO45VQHGH
         m4+Q==
X-Gm-Message-State: ACrzQf0GBpmkh67WUa55KSCAz/7Zk+fxSl9A/i2CmtDe4yTSuR24hBAa
        Tmojycw3Zxw3+r7LXOr+SkROAg==
X-Google-Smtp-Source: AMsMyM4zS/M33x512erp2HqmKikydZoQsvricFmFzprpDv2OzKMq+shyLBVwaM1Cw0mKRCm8tBnOUw==
X-Received: by 2002:adf:fb0a:0:b0:225:265d:493 with SMTP id c10-20020adffb0a000000b00225265d0493mr14790401wrr.394.1664230311378;
        Mon, 26 Sep 2022 15:11:51 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id v8-20020adfa1c8000000b0022865038308sm15730369wrv.93.2022.09.26.15.11.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Sep 2022 15:11:50 -0700 (PDT)
Message-ID: <ee9ea160-ae77-112b-5302-74179e372387@linaro.org>
Date:   Tue, 27 Sep 2022 00:11:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5 03/30] thermal/core: Add a generic
 thermal_zone_set_trip() function
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>
References: <20220926140604.4173723-1-daniel.lezcano@linaro.org>
 <20220926140604.4173723-4-daniel.lezcano@linaro.org>
 <CAJZ5v0hJ7Tq1pU1hSqswPF_+KZOt1jNKvmqTeF5=1npReqmA3A@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0hJ7Tq1pU1hSqswPF_+KZOt1jNKvmqTeF5=1npReqmA3A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/09/2022 21:25, Rafael J. Wysocki wrote:

[ ... ]

>> +       if ((t.temperature != trip->temperature) && tz->ops->set_trip_temp) {
> 
> The inner parens are not needed here and below.
> 
>> +
> 
> And the extra empty line is not needed here (and below) too IMO.
> 
>> +               ret = tz->ops->set_trip_temp(tz, trip_id, trip->temperature);
>> +               if (ret)
>> +                       goto out;
>> +       }
>

Without the parens, the following happens:


warning: this ‘if’ clause does not guard... [-Wmisleading-indentation]
  1229 |         if ((t.temperature != trip->temperature) && 
tz->ops->set_trip_temp)
       |         ^~
note: ...this statement, but the latter is misleadingly indented as if 
it were guarded by the ‘if’
  1231 |                 if (ret)
       |                 ^~


>> +       if ((t.hysteresis != trip->hysteresis) && tz->ops->set_trip_hyst) {
>> +
>> +               ret = tz->ops->set_trip_hyst(tz, trip_id, trip->hysteresis);
>> +               if (ret)
>> +                       goto out;
>> +       }
>> +
>> +       if (((t.temperature != trip->temperature) ||
>> +            (t.hysteresis != trip->hysteresis)) && tz->trips)
>> +               tz->trips[trip_id] = *trip;
> 
> I would write this as
> 
> if (tz->trips && (t.temperature != trip->temperature || t.hysteresis
> != trip->hysteresis))
>          tz->trips[trip_id] = *trip;

Ok, sure

> But
> 
> 1. Do we want to copy the trip type here too?

The function thermal_zone_set_trip() is called from thermal_sysfs.c, it 
is the unique call site. However, I think it is a good idea to check the 
type of the trip point is not changed, even if it is not possible with 
the actual code.

> 2. If tz->trips is set, do we still want to invoke ->set_trip_temp()
> or ->set_trip_hyst() if they are present?

No but there are bogus drivers setting the interrupt with these ops 
instead of using the set_trips ops (eg. [1][2][3]). So in order to keep 
those working ATM, I'm keeping them and when all the drivers will be 
changed, I'll wipe out the set_trip_* ops from everywhere.

[1] drivers/thermal/samsung/exynos_tmu.c
[2] drivers/thermal/qcom/qcom-spmi-temp-alarm.c
[3] drivers/thermal/imx_thermal.c


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
