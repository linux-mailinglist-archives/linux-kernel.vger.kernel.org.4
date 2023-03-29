Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3B16CEF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjC2QTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjC2QTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:19:00 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2041A4233
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:18:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so11496906wmq.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 09:18:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680106713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U/3ZXVoIKxVs/p2ePsaiOudqZVjYFCyOHTolPsKeMIE=;
        b=zhBeRzLjXXN7jqHGC5Zw1MCquTnjs3lNKA492yHvqv0SUf7DJk+Tnys0BFYYF2YGAW
         yUw+JIaXTFsSCqebewTBv4ccDWzd+b8a1dy9I3wcnlN8oQx/7t1b//sWMXV5sR8l5LE+
         sLQiyvWhw8EwtSFoAR3IBGHWd5kSohsAKhLcknR4BTxhUGma3FVv6JpS/d0Rq6r4O63S
         L9viX+3tSrw71RNxR02c/BnChgQAJUCub/+VjrcwJcHYNRwF5GjJ82mTe5rdQkF7nGfN
         h/HOwKTCyGriCjbcC4cTSfpQB9olMxKXwNHZLZV8j3/k3gutSPSsI+XM34N0TbABzuYk
         gKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680106713;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U/3ZXVoIKxVs/p2ePsaiOudqZVjYFCyOHTolPsKeMIE=;
        b=iijK8zm6s/UK43HjXTCQqRTMFF0vpbODxUYaCGLtMwlbwXzNTG2Hufd011AgPuAqqU
         We54cNJaNCDcb4oMMSJHQjEwE6txrMwKBQOJnoRHc/HUW0DkNUuFFDerkyNw9lzYVV6l
         4Y0OerM+lt9d5GovCKrbM50ehBbjHUFsowkZWAh3oaLzl46ymO3rroY523BxBeup4kG0
         0sPlHgYJZ0/rZ5lKjrVX6LWFyBROiOsRhkLv3z3q8YUWY7UfoyDMck6Nkw6PEI0svhlR
         QnhQDOi+Ja5b3wZEvuzm9zH/RKYIm0TZz9HKgpEgfOHS3GNb+cpc3orurSXojQZqL9/n
         vfHw==
X-Gm-Message-State: AO0yUKWMH9iZfHHLcT02Of8JPg4qxXzI6pnPilY51VZByue2fPj5rj94
        6Mw/l2K5tbZRbxw2Arc1/sagIQ==
X-Google-Smtp-Source: AK7set+VydZ65WUhInUNI7FznI50frXNOSsSP5cK3NBVorxmB4VPsyYYoMa3LmNx8MnkEX15ayGKLA==
X-Received: by 2002:a7b:c8c4:0:b0:3ed:ce6f:e86e with SMTP id f4-20020a7bc8c4000000b003edce6fe86emr15341004wml.23.1680106713524;
        Wed, 29 Mar 2023 09:18:33 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:7c0e:2838:74e9:d05? ([2a05:6e02:1041:c10:7c0e:2838:74e9:d05])
        by smtp.googlemail.com with ESMTPSA id fc11-20020a05600c524b00b003ebff290a52sm2956826wmb.28.2023.03.29.09.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 09:18:32 -0700 (PDT)
Message-ID: <5b084360-898b-aad0-0b8e-33acc585d71d@linaro.org>
Date:   Wed, 29 Mar 2023 18:18:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH -next] thermal/drivers/thermal_hwmon: Fix a kernel NULL
 pointer dereference
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org,
        rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org
References: <20230329090055.7537-1-rui.zhang@intel.com>
 <08aee7fe-eddc-7841-2539-16ae43fd8d66@linaro.org>
 <CAJZ5v0hGnoEhYadoK-KPTvMtvviOrGqbY9jrmOUzTjOGe_rB_A@mail.gmail.com>
 <016dc073-c9a3-4b96-6c58-7b21e0f998a5@linaro.org>
 <CAJZ5v0jmo_bj4iMVe9ARei4-oyP3TdD+FXiiu+-g55FqJxLJsg@mail.gmail.com>
 <c1c0945b-4772-e6b1-e662-d9901d224f6a@linaro.org>
 <CAJZ5v0iMAT_1cQorTqK4xRTjD3a_s=Vf3OJYy3hi7=pAekLv+g@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAJZ5v0iMAT_1cQorTqK4xRTjD3a_s=Vf3OJYy3hi7=pAekLv+g@mail.gmail.com>
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

On 29/03/2023 18:03, Rafael J. Wysocki wrote:
> On Wed, Mar 29, 2023 at 5:59 PM Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>>
>> On 29/03/2023 16:38, Rafael J. Wysocki wrote:
>>> On Wed, Mar 29, 2023 at 4:16 PM Daniel Lezcano
>>> <daniel.lezcano@linaro.org> wrote:
>>>>
>>>> On 29/03/2023 14:06, Rafael J. Wysocki wrote:
>>>>> On Wed, Mar 29, 2023 at 11:57 AM Daniel Lezcano
>>>>> <daniel.lezcano@linaro.org> wrote:
>>>>>>
>>>>>> On 29/03/2023 11:00, Zhang Rui wrote:
>>>>>>> When the hwmon device node of a thermal zone device is not found,
>>>>>>> using hwmon->device causes a kernel NULL pointer dereference.
>>>>>>>
>>>>>>> Reported-by: Preble Adam C <adam.c.preble@intel.com>
>>>>>>> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
>>>>>>> ---
>>>>>>> Fixes: dec07d399cc8 ("thermal: Don't use 'device' internal thermal zone structure field")
>>>>>>> dec07d399cc8 is a commit in the linux-next branch of linux-pm repo.
>>>>>>> I'm not sure if the Fix tag applies to such commit or not.
>>>>>>
>>>>>> Actually it reverts the work done to encapsulate the thermal zone device
>>>>>> structure.
>>>>>
>>>>> So maybe instead of the wholesale switch to using "driver-specific"
>>>>> device pointers for printing messages, something like
>>>>> thermal_zone_debug/info/warn/error() taking a thermal zone pointer as
>>>>> the first argument can be defined?
>>>>>
>>>>> At least this particular bug could be avoided this way.
>>>>
>>>> Actually we previously said the thermal_hwmon can be considered as part
>>>> of the thermal core code, so we can keep using tz->device.
>>>>
>>>> I'll drop this change from the series.
>>>
>>> But it's there in my thermal branch already.
>>>
>>> Do you want to revert the thermal_hwmon.c part of commit dec07d399cc8?
>>
>> Oh, right. Fair enough.
>>
>> I think Rui's patch is fine then.
> 
> I guess you mean the $subject one, that is:
> 
> https://patchwork.kernel.org/project/linux-pm/patch/20230329090055.7537-1-rui.zhang@intel.com

Correct

> What about the message printed when temp is NULL.  Should the original
> form of it be restored too?

Yes, you are right, for the sake of consistency we should restore also 
this one.



-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

