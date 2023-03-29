Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 408EC6CF24D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 20:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjC2Sjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 14:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjC2Sje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 14:39:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24046A48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:39:07 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v6-20020a05600c470600b003f034269c96so87312wmo.4
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 11:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680115146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WA2pQzRexB+NdhaFhZCoXJHYtIecVE57hJThD6rVsq8=;
        b=GcvXpLwCqytSMpNrcqmtVPYlyeB1UI4oSqNdzMuhCJoT7Lvy7nwY6fQ7/YXlNMhnU3
         7pqaGFaDRN9Waq/WYRPYjttzTj6sjrHV4pzGOnXeOGU+51PFcMxzBL7J88Owhapud9cR
         sc2sn7yruygUUUfhHCU1yhiTjmcKAwU38maRkiouHrLi3Mu64vC1nvtc3f7+jaOVW7aC
         4gYGo4CaxdLvUwa96JiqQSXpkLzW26tomQ8WB1ET+m1X0LCPs9e80UoX8yBUC2oe/D7C
         Xn57OHP0ibyEEW3WpRJzi6+Rj3rE71RN+1/181YjgXBM+WjpWcZtBe7qw4saDHC9msRk
         1N4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680115146;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WA2pQzRexB+NdhaFhZCoXJHYtIecVE57hJThD6rVsq8=;
        b=zIr2aF0vKi0WnQZMsQhqVBMwd7K+dbJjbw/MaYLbV82iQcv/W/GXkKqlAjBphV1ew6
         MkcFMtFBTTAkoLf4WOMPPHm+2kTqmhAUDIUG9E7lXp+ixQMDTc7EE92MuqxnXJys5nYv
         cW/2IT17ELOsf6hT+sxRQ/C33M04l3SLb+LAcRs/vE+4bLI8Sdwz1E9WiR3o0CJyBKsX
         oQu4N3MwUKaFhK/ZKNbVRSH7EhRjB8ZkzI/SOnUATP1dR5O1gbSP+Yt5veZBOSnJDg8B
         Sakhra7Chx+7f+AGEdn89EB88y/nTPU+PU+A3vobYDbiE1OlcahHQ17GxtrrqxhACK4i
         Xo5Q==
X-Gm-Message-State: AO0yUKUykGB6zV1i7rmcxkBdHBt3c0YiToYvymi707Dl0kg/hxTnUJT6
        ri/EBQBof36oEXendW7QuBEv3w==
X-Google-Smtp-Source: AK7set8zSiwVmnjClr/oxIQhbXHpXZfMQz7VPKhlZXHN0Va/AdnFIBvIBZtQ5cpRJDqDrYrS0l/BnA==
X-Received: by 2002:a7b:c409:0:b0:3ed:2a91:3bc9 with SMTP id k9-20020a7bc409000000b003ed2a913bc9mr16493405wmi.15.1680115146156;
        Wed, 29 Mar 2023 11:39:06 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc? ([2a05:6e02:1041:c10:9ee7:40a0:eee0:62cc])
        by smtp.googlemail.com with ESMTPSA id h7-20020a05600c314700b003ef66c89af0sm8867643wmo.0.2023.03.29.11.39.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 11:39:05 -0700 (PDT)
Message-ID: <29ae56fe-11ab-cb5b-9da7-f00bf8607634@linaro.org>
Date:   Wed, 29 Mar 2023 20:39:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
References: <20230329090055.7537-1-rui.zhang@intel.com>
 <CAJZ5v0iMAT_1cQorTqK4xRTjD3a_s=Vf3OJYy3hi7=pAekLv+g@mail.gmail.com>
 <5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org>
 <12190090.O9o76ZdvQC@kreacher>
Content-Language: en-US
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <12190090.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 19:43, Rafael J. Wysocki wrote:

[ ... ]

>>> What about the message printed when temp is NULL.  Should the original
>>> form of it be restored too?
>>
>> Yes, you are right, for the sake of consistency we should restore also
>> this one.
> 
> So I'm going to apply the appended patch.
> 
> Please let me know if there are any concerns regarding it.
> 
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH] thermal: thermal_hwmon: Revert recent message adjustment
> 
> For the sake of consistency, revert the second part of the
> thermal_hwmon.c hunk from commit dec07d399cc8 ("thermal: Don't use
> 'device' internal thermal zone structure field") after the first
> part of it has been reverted.
> 
> Link: https://lore.kernel.org/linux-pm/5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


> ---
>   drivers/thermal/thermal_hwmon.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/thermal/thermal_hwmon.c
> ===================================================================
> --- linux-pm.orig/drivers/thermal/thermal_hwmon.c
> +++ linux-pm/drivers/thermal/thermal_hwmon.c
> @@ -236,7 +236,7 @@ void thermal_remove_hwmon_sysfs(struct t
>   	temp = thermal_hwmon_lookup_temp(hwmon, tz);
>   	if (unlikely(!temp)) {
>   		/* Should never happen... */
> -		dev_dbg(hwmon->device, "temperature input lookup failed!\n");
> +		dev_dbg(&tz->device, "temperature input lookup failed!\n");
>   		return;
>   	}


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

