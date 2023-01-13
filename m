Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5A766A0C5
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 18:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjAMRca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 12:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjAMRcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 12:32:09 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6919422A
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:21:13 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z5so20640563wrt.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jan 2023 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N5FMUTSD2Bb9aPiO6k1P71VjRgpz4XMtlw/+XVppoH8=;
        b=qBGrHm1GUCs7QwaYgM8fM+fBP7eHT3+DjFMWceuiU2j5KXaqvISdygjzc2dEThs3WT
         cf3IuDzZSJup0BBAKBy3/xXs6v2lYAGMWEXrvr+by0okQvrJ9ohY3CGdqDs/Tlp3FLM+
         OmUeVhHSkkZe4Q3b4lqGNm+6kDhQq0q6wJ/1BADBDTdi46qfxQCfOEPwCwoBql1erxu8
         8ixCgXcew6NxO/AJGDGoHKYHcbwNHoAYoOvMCo4//1o4siyFAxY7MmcQH/JMVyCX60Qd
         YCe12UXvAOQduuv2PM8yaNP7hFsPKa86r2D+5W5NnKe/ATzU7ynGkt9cSk3pFOrS0Yt8
         vnwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N5FMUTSD2Bb9aPiO6k1P71VjRgpz4XMtlw/+XVppoH8=;
        b=TF0hgNo86Z9or4ILjexk4dtsYhsJ5qciwALo+FmC/W3zvp3UXoK5OvRGAHx4zh91Wz
         psjfkHM028BFbBE529q4TV1Gxa5ZNs1D8lhhqzplWrCzNvvT6jlMdzjO/Nl0y3M+MDsI
         UEd5MO7vhQT+FN251VJyRsashdZNkj3hOK0IxiGquxVsEbjtL+rblQrnQuo80kONZH4c
         KTIuF/9aph2avgr2rtaeD9x0leHKSQH/94CLHEpJhAHzyZ2NESs1TDWX41un2C+ZQ63a
         Gx5EsMA0gN+mXaRQmcJWJs0ICzTb2bb96UOMPXHjoogjicLTAaL4//XLFeRhBltfaIKs
         E+BQ==
X-Gm-Message-State: AFqh2kolabH0lRPd8ZKmltegkJT/0fIueZ0SPAhHt8xr4qHFy4xsF6W+
        Lg5H5aelQ9qA1WTzxSRvLhPqvg==
X-Google-Smtp-Source: AMrXdXtwaKDSiEHVFEYfqtAfdAIdk8ByuhNPLiXqpTPJ9VnvjbQcquOGq8mTQdbEUNw8CTD43MQp0w==
X-Received: by 2002:adf:d0c8:0:b0:2bd:bae0:8de5 with SMTP id z8-20020adfd0c8000000b002bdbae08de5mr9364481wrh.58.1673630471594;
        Fri, 13 Jan 2023 09:21:11 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id j11-20020adfd20b000000b0024207478de3sm19610837wrh.93.2023.01.13.09.21.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Jan 2023 09:21:10 -0800 (PST)
Message-ID: <35b6549e-a722-4667-c471-907d91d424ce@linaro.org>
Date:   Fri, 13 Jan 2023 18:21:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/3] thermal/drivers/intel: Use generic trip points
 int340x
Content-Language: en-US
To:     srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>
Cc:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "daniel.lezcano@kernel.org" <daniel.lezcano@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "christophe.jaillet@wanadoo.fr" <christophe.jaillet@wanadoo.fr>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amitk@kernel.org" <amitk@kernel.org>
References: <20230110151745.2546131-1-daniel.lezcano@linaro.org>
 <20230110151745.2546131-4-daniel.lezcano@linaro.org>
 <4f461027be209156d6d9f26870748f204ff4184b.camel@intel.com>
 <ddcfbd2e-2ea0-9305-96c4-8127181cdd8c@linaro.org>
 <34f9fc91c398f85c0bedaff89adbb33897cb1f62.camel@linux.intel.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <34f9fc91c398f85c0bedaff89adbb33897cb1f62.camel@linux.intel.com>
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


Hi Srinivas,

On 13/01/2023 16:48, srinivas pandruvada wrote:
> Hi Daniel,
> 
>>>>
> 
> [...]
> 
>>>> -       status = acpi_evaluate_integer(d->adev->handle, "GTSH",
>>>> NULL,
>>>> &hyst);
>>>> -       if (ACPI_FAILURE(status))
>>>> -               *temp = 0;
>>>> -       else
>>>> -               *temp = hyst * 100;
>>>
>>> The previous code returns hyst * 100.
>>> But the new API retuurns hyst directly.
>>>
>>> -/sys/class/thermal/thermal_zone2/trip_point_4_hyst:2000
>>> +/sys/class/the
>>> rmal/thermal_zone2/trip_point_4_hyst:20
>>>
>>> Is this done on purpose?
>>
>> No, it is an error. The function thermal_acpi_trip_gtsh() should do:
>>
>>          return deci_kelvin_to_millicelsius(hyst);
>>
>>
> 
> GTSH returns here in tenths of degree Kelvin. For example 15 means 1.5
> degree K.

Yes, so the above conversion is correct, right ?

> I would like to test your next series with thermald. If there is a
> problem, it will break every distro.

Great, thanks!


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

