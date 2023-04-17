Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27AA66E49BA
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 15:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbjDQNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbjDQNR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 09:17:58 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3B3124
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:17:55 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fy21so21062774ejb.9
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 06:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681737474; x=1684329474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1p6Wd3OtTb39EZ/VgEOJwXli/x4fybTyhed/6AFKfjw=;
        b=LtUu9v4os64UQt6hsuF/O5RF3nj2ckXJExiBqGWB7p3yUY24SDVk73mzbkp8eQLNGN
         Lrtol2kl4M+CDcsd7mHpsr/0DTrPZFq3jo1idYLl436ANsXrnOIRErLznBdZieCVPOpi
         WEoIFApgx8Oe1koFzTCpGLUKtvN+jOXxi7P6tREtD2zvz+jtPWQkcoR+1UdMf8IQHO9Y
         Y+kNPEjGVNUoEAWUF9GTIRmqV2IY33cE3xR65/B8/9etQmdBlpPwQj+7XS7jmLomjQHk
         FlYi4m4pFG5exZq0eb/wmAMg3g1+mqqCJHx+KI9yV7IZPrLcJBETE99SD9JpR7I4YvMk
         EGfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681737474; x=1684329474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1p6Wd3OtTb39EZ/VgEOJwXli/x4fybTyhed/6AFKfjw=;
        b=Dsp9iDNHl6meFrBT9Lh0tUbfbJDlOddgUF8lVo48r5g/bGi7NC9GgfgLk6SfTfca8y
         UXGx/uPE6deYIWb6q37PXWhwABmUWOA8gH8KpkaWr+jD6y39qkRXAmaogGzlwbTJsyIr
         H6nK0DMxMVI9ozioWNqusmzBtNXQkpLWkgUG4vQAVqULSE/00OWnzeMiFIVA5q+ufneN
         AUUKNa26jQ/hKSIRZ9yqxMMEx0lfy0w/hrBFi8/sC/ONge61mlZGaPGXjM12AyhzLBGw
         FOg21xoKVRqqtmTdCzEjWpXd4usdskiIrdEOLfRzeP013RZnTHTOGGy7enQWwIGNgKVN
         ae8Q==
X-Gm-Message-State: AAQBX9c7owTfAMFP1dHC+9iKSdMKZqFzbLwGWjcvHvkdPK94Q3CEOvLK
        dFsq9gOV6r9i4Qv+mZqxxpQRw3Ly+msYO/ktQvBbBEtE
X-Google-Smtp-Source: AKy350YOCgfeLR3XyUJHKCV7mX6kN/oFYItg9qSFTAdGHU4UW6fnrpmNywyvF3YxRYFzT4wFnwKVOg==
X-Received: by 2002:a17:906:114a:b0:933:be1:8f4f with SMTP id i10-20020a170906114a00b009330be18f4fmr7644115eja.9.1681737473747;
        Mon, 17 Apr 2023 06:17:53 -0700 (PDT)
Received: from [10.27.64.40] ([193.205.131.2])
        by smtp.googlemail.com with ESMTPSA id hu20-20020a170907a09400b0094f432f2429sm2617124ejc.109.2023.04.17.06.17.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Apr 2023 06:17:53 -0700 (PDT)
Message-ID: <b09deeb1-31c8-ba08-86ce-614349f33b92@linaro.org>
Date:   Mon, 17 Apr 2023 15:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 0/6] Thermal zone device structure encapsulation
Content-Language: en-US
To:     rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20230413114647.3878792-1-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Rafael,

I think I addressed your comments from V2.

Is it fine if I merge this series in the thermal/bleeding-branch ?


On 13/04/2023 13:46, Daniel Lezcano wrote:
> The thermal zone device structure is defined in the exported thermal
> header include/linux/thermal.h
> 
> Given the definition being public, the structure is exposed to the
> external components other than the thermal framework core code. It
> results the drivers are tampering the structure internals like taking
> the lock or changing the field values.
> 
> Obviously that is bad for several reasons as the drivers can hook the
> thermal framework behavior and makes very difficult the changes in the
> core code as external components depend on it directly.
> 
> Moreover, the thermal trip points being reworked, we don't want the
> drivers to access the trips array directly in the thermal zone
> structure and doing assumptions on how they are organized.
> 
> This series provides a second set of changes moving to the thermal
> zone device structure self-encapsulation.
> 
> The ACPI and the Menlon drivers are using the thermal zone's device
> fields to create symlinks and new attributes in the sysfs thermal zone
> directory. These changes provide a hopefully temporary wrapper to
> access it in order to allow moving forward in the thermal zone device
> self-encapsulation and a Kconfig option to disable by default such a
> extra sysfs information.
> 
> Changelog:
> 	v3:
> 	- Split the Kconfig option to be driver related when disabling
>            the specific attributes
> 	- Use the thermal zone's device wrapper to write a trace in
>            the pch intel driver
> 	v2:
> 	- Add the Kconfig option to remove specific attributes
> 	- Add a thermal_zone_device() wrapper to access tz->device
> 
> Daniel Lezcano (6):
>    thermal/core: Encapsulate tz->device field
>    thermal/drivers/intel_pch_thermal: Use thermal driver device to write
>      a trace
>    thermal/drivers/acpi: Use thermal_zone_device()
>    thermal/drivers/menlow: Use thermal_zone_device()
>    thermal/drivers/acpi: Make cross dev link optional by configuration
>    thermal/drivers/intel_menlow: Make additionnal sysfs information
>      optional
> 
>   drivers/acpi/Kconfig                      | 13 ++++++
>   drivers/acpi/thermal.c                    | 57 +++++++++++++++++------
>   drivers/thermal/intel/Kconfig             | 11 +++++
>   drivers/thermal/intel/intel_menlow.c      | 12 +++--
>   drivers/thermal/intel/intel_pch_thermal.c |  3 +-
>   drivers/thermal/thermal_core.c            |  6 +++
>   include/linux/thermal.h                   |  1 +
>   7 files changed, 84 insertions(+), 19 deletions(-)
> 

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

