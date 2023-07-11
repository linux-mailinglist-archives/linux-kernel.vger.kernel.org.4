Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45F9F74E8F3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjGKIXk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbjGKIXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:23:39 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDCBE9C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:23:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbd33a57dcso59517795e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 01:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689063816; x=1691655816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qInhMV9Locu6xtAhuRgmTKHwzbA+LW4kMcmNGenGo1Y=;
        b=P9CmDR2UuUXITyHXpHjEzaUcGtNzqfEzbp7afhD7xInFWb+O6brslPNHZOxG57f3C7
         +MR05inIFpu5TYwInWbzIbwWGbc/m1qR+clzxvLnv3CSQYprPdeAvMFOi4lm91U1lZba
         W9O+VgdzhZERezpxb4c8xRCMpLYW+oLNfkjxLIzuKZzuFurTxTn1YEXx2LRFc0jvJTCV
         JWnjb1UfyiWlMSCXK0tSWnOQuk3bZXNccO4/KJk3kubXc2NKjSHYqvCJ7dRJDk0g6dY7
         LP2CKrVANQs2cG2dgMvcqcP4pU9gh6GrsVYJ2j/RPyogwj/KytLmc2lbftkXZx+wAXY1
         0Vhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689063816; x=1691655816;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qInhMV9Locu6xtAhuRgmTKHwzbA+LW4kMcmNGenGo1Y=;
        b=Ju7vxJRutmrx3bbbSHR9bDu7Nbbe0aAqjZP1QCFxW3w7TsKkxK6gpsH+qgqTbG94D3
         NJDh2vmqKVlN+7aABy8+KFnnMRVJAn8fP/FZj20jqkLC472MRoeKuOmlW6IIEo33pbla
         k5dAsyqSgBT46dlpAEKofgRW5nlBb/SABoAeIALCJ04jwEu234xXtZzNiv1ZJNdIRIq6
         5XG0sk10kjwKFarSk+PsDtHyqyKtQ1zb944gsxa45PxCKLq1ODvZIvqoUZyNi1muMB1T
         3ZVfaeBJ09zaXENSWeTu+rsmZBKi3sKzEtDnISZ8p0GXNW/UWE2vySmCvaRTsEYnL4gU
         SxCQ==
X-Gm-Message-State: ABy/qLbYZ26ZqPCaKUfR8ibnrc27MLzENWvX8S337eFFKZtH5RHwPGRf
        ZkIASuto0Zfqdm4fU9lcL4KbTw==
X-Google-Smtp-Source: APBJJlE6z4Lh9osQA5l1Hg344WxWb8AYZAaMO+/+0s36+ogVudjeakoxSUPSXEw20hdPB90QPBZF4g==
X-Received: by 2002:a7b:c850:0:b0:3fb:dd9c:72c8 with SMTP id c16-20020a7bc850000000b003fbdd9c72c8mr13981377wml.22.1689063816128;
        Tue, 11 Jul 2023 01:23:36 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id q20-20020a7bce94000000b003fa96620b23sm12250012wmj.12.2023.07.11.01.23.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 01:23:35 -0700 (PDT)
Message-ID: <33508f0e-414f-a990-29ad-58e43d20374b@linaro.org>
Date:   Tue, 11 Jul 2023 10:23:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V5] thermal/core/power_allocator: reset thermal governor
 when trip point is changed
Content-Language: en-US
To:     Di Shen <cindygm567@gmail.com>, lukasz.luba@arm.com
Cc:     Di Shen <di.shen@unisoc.com>, rafael@kernel.org, amitk@kernel.org,
        rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, xuewen.yan@unisoc.com,
        jeson.gao@unisoc.com, orsonzhai@gmail.com, zhanglyra@gmail.com
References: <20230710033234.28641-1-di.shen@unisoc.com>
 <6d3f24a4-ae70-49eb-6e41-86baa1db6bed@linaro.org>
 <CAHYJL4og14kQ4ev6QtDQeknJELME7URTN_HmR01P5+2RhpthzQ@mail.gmail.com>
 <f7cf2153-aa22-d376-f776-54ea940a5e35@linaro.org>
 <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAHYJL4p7FEjLTZURA6fvVPCmwKodmxWS7fNpi_c0ZFBX7yjDZQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Di,

On 11/07/2023 05:40, Di Shen wrote:

[ ... ]

>>>>> +static void power_allocator_reset(struct thermal_zone_device *tz)
>>>>> +{
>>>>> +     struct power_allocator_params *params = tz->governor_data;
>>>>> +
>>>>> +     reset_pid_controller(params);
>>>>> +     allow_maximum_power(tz, true);
>>>>
>>>> Do you really want to allow the maximum power? What about if the trip
>>>> temperature is decreased ?
>>>>
>>> If the trip temperature is decreased, allow_maximum_power will only
>>> be executed once, and then the ipa governor will adapt to the lower trip
>>> temperature and calculate the allocated power for cooling actors again.
>>> Right?
>>
>> Sorry for jumping in this fifth version but I'm not sure about resetting
>> the change is the right way (and probably, changing a trip point with
>> the power allocator is not a good idea)
>>
>> The platforms where the IPA is planned to be used are creating a dummy
>> trip point where the IPA begins the acquisition without cooling devices
>> in order to have the math building the PID schema (eg. hi3660.dtsi).
>>
>> What about the sustainable power vs the trip point temperature? I mean
>> we can change the trip temperature but not the sustainable power which
>> is directly related to the target temperature. So the resulting power
>> computation will be wrong.
>>
> I totally agree, thanks for reminding me. Sustainable power is the maximum
> power available at the target temperature, so it must be updated when the trip
> point is changed. Sorry for missing this point. How about calling
> get_sustainable_power() to update the sustainable_power? Furthermore, when
> the sustainble_power() is changed, the pid constants tzp->k_* must be estimated
> again. In get_sustainble_power, it checks that the sustainable_power is updated,
> it will call the estimate_pid_constants() to renew the tzp->k_*.

Yes and the sustainable power can be set from userspace too.

So here we have to distinguish what is related to the thermal setup and 
the thermal usage.

Actually the thermal framework should protect the information from the 
firmware. It is not acceptable to have an user being able to change the 
trip points provided by the firmware.

The writable trip point should allow only temperature changes below the 
ones given in the firmware.

>> The more I think about that, the more I do believe writable trip point
>> and IPA are incompatible.
>>
>> What about forbid that?
>>
>> For instance, add a set_trip callback instead of resetting in the
>> governor and return -EPERM from the IPA?
>>
> I've seen that you have sent a patch recently which adds the callback
> thermal_zone_trips_update(), is that what you said set_trip callback?

Not exactly.

Instead of adding a 'reset' callback, add a 'trip_update' (or whatever 
the name) callback.

Then pass the trip point to the callback along with the thermal zone.

int ipa_trip_update(struct thermal_zone_device *tz,
			struct thermal_trip *trip)
{
	// Do more IPA crazy stuff or return -EPERM
}


>> Lukasz ?

Lukasz? what do you think?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

