Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353DE73833A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbjFULnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 07:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjFULnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 07:43:31 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340DD10CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:43:29 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f9c0abc8b1so4645725e9.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 04:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687347807; x=1689939807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iO6yLGSyijmEB7YoBsweik9EmxS1TQNCrMT7Ucp9Vf4=;
        b=MIr9C/0Tdk8hznm8BIRQSQz40ZnXYhoCNFW+zfb1kiOmTYRNtKC05elD1/75Nn2jXj
         833AgB3usGydP8TLzmcJ621CFopNCeW8LEFkOX4WrOfQ/nmHKOjTi08Mp6r56QpkVONv
         z560Ayx0FWkR8LIxBqol6B62K2oBnknTi7AOd88+u3iIpvs8W6rue3c41a5vyzXdEe6M
         4tJ0fy1Z0ZU+Ja5lZ/E+NxRdsqa1PWTfN25UpLxwmmn4yZLB7L6TZ9W/nUby0E6L+aU4
         MzhV0m8eCJxGqsp4e/zJrcnlqWmI0QglcIrAWIvRqSLp1WNa0AshkaLq9CDGdTvr3/2K
         hskg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687347807; x=1689939807;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iO6yLGSyijmEB7YoBsweik9EmxS1TQNCrMT7Ucp9Vf4=;
        b=Pu1R4uoqMPmsFmh8uM070VRkFAX7Y2jcXMjFsfYcvkXkBOv5Hq0Am1yZS908NhFnZC
         839b0eT+Jp0pVYsw9dmz3FwQpBjXFLOEslIYcpszkeoWOLufh+eXeNsug9u3z++KJr7Y
         DP3WqpQvjpatdOmADfJmr3QFt0R+qoCcT+0u6F/TkAyNbSQ/nUSfo9wrm8PkHLM/K84Q
         CGmXYPTYjPjF//MSl/lYv74VbhDkW1OROn7z9eV65oPF1tFgr11VqOnUvSUifb2IaYZI
         Kg3+V170DLf4gPjmnFBtk0j5EecIJr0sTO7DhhMj9DEfN0U3psu96GFr8LH00zhx8JMv
         a6ZA==
X-Gm-Message-State: AC+VfDxt/Tscxl0KjI/DBp5aSjcTDq73tjpIfDg2dsnrjhv8tg7hytQb
        k0gSmwTzo4E5V+RJYligzu7oDg==
X-Google-Smtp-Source: ACHHUZ6mWppSn8fq2hUlGb2r58v1BLPzML7wyZ5tmdqhpbAWrhV5a8Xgu7wl1bxw1J3V/gKGAylKdg==
X-Received: by 2002:a05:600c:2051:b0:3f7:3545:4630 with SMTP id p17-20020a05600c205100b003f735454630mr15470858wmg.20.1687347807610;
        Wed, 21 Jun 2023 04:43:27 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:9f9:9e46:82f3:81e7? ([2a05:6e02:1041:c10:9f9:9e46:82f3:81e7])
        by smtp.googlemail.com with ESMTPSA id m7-20020a7bce07000000b003f9b155b148sm7669056wmc.34.2023.06.21.04.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 04:43:27 -0700 (PDT)
Message-ID: <75eba2da-593f-f3bd-4eac-5155fcf5aee8@linaro.org>
Date:   Wed, 21 Jun 2023 13:43:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/1] thermal: sysfs: avoid actual readings from sysfs
Content-Language: en-US
To:     Eduardo Valentin <evalenti@kernel.org>
Cc:     eduval@amazon.com, rafael@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
References: <20230607003721.834038-1-evalenti@kernel.org>
 <f26ac9a9-60af-a0fe-fccc-25bcd306f5a1@linaro.org>
 <ZICybSuZELhR1Ni5@uf8f119305bce5e.ant.amazon.com>
 <b2e93db5-e6f8-a9d8-53de-af5ea750f0f0@linaro.org>
 <ZIITZINvtPfjuhS6@uf8f119305bce5e.ant.amazon.com>
 <7616fd9d-aa0d-2ecd-8751-894b1c9073c0@linaro.org>
 <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ZJKFar/U75+PGCRt@uf8f119305bce5e.ant.amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 07:06, Eduardo Valentin wrote:
> On Mon, Jun 12, 2023 at 10:17:51AM +0200, Daniel Lezcano wrote:
>>
>>
>>
>> Hi Eduardo,
>>
>> On 08/06/2023 19:44, Eduardo Valentin wrote:
>>
>> [ ... ]
>>
>>>> Do you have a use case with some measurements to spot an issue or is it
>>>> a potential issue you identified ?
>>>
>>>
>>> yes, a governor that is using I2C device as input, behind I2C fast mode (100KHz)
>>> and needs to update the zone every 100ms. Each read in this bus, if done alone
>>> would be around 500us, takes 10bytes to read the device, it is 10 clocks per byte,
>>> well technically 9, but rounding for the sake of the example, which gets you
>>> 50 / 100KHz = 500 us. That is for a single read. You add one single extra
>>> userspace read triggering an unused device update, that is already a 1ms drift.
>>> Basically you looking at 0.5% for each extra userspace read competing in this
>>> sysfs node. You add extra devices in the same I2C bus, your governor is looking
>>> at more than 1% overhead. And I am talking also about a main CPU of ~800MHz.
>>> I did not even include the lock overhead considered for this CPU ;-)
>>>
>>> Again, this is not about controlling the DIE temperature of the CPU you
>>> are running the thermal subsystem. This is about controlling
>>> a target device.
>>
>> Ok. The target device is on a bus which is slow and prone to contention.
>>
>> This hardware is not designed to be monitored with a high precision, so
>> reading the temperature at a high rate does not really make sense.
> 
> On the contrary, it needs even more precision and any extra delay adds to
> loss on accuracy :-)

What I meant is if the hardware designer thought there could be a 
problem with the thermal zone they would have put another kind of 
sensor, not one with a i2c based communication.


>> Moreover (putting apart a potential contention), the delayed read does
>> not change the time interval, which remains the same from the governor
>> point of view.
> 
> It does not change the governor update interval and that is a property of
> the thermal zone. Correct. And that is the intention of the change.
> The actual temperature updates driven by the governor will always
> result in a driver call. While a userspace call will not be in the way
> of the governor update.
> 
> Sysfs reads, However, with the current code as is, it may cause
> jittering on the actual execution of the governor throttle function.
>   causing the computation of the desired outcome cooling device being skewed.
> 
>>
>> In addition, i2c sensors are usually handled in the hwmon subsystem
>> which are registered in the thermal framework from there. Those have
>> most of their 'read' callback with a cached value in a jiffies based way
>> eg. [1].
> 
> I guess what you are really saying is: go read the hwmon sysfs node,
> or, hwmon solves this for us, which unfortunately is not true for all devices.

I meant the i2c sensors are under the hwmon subsystem. This subsystem is 
connected with the thermal framework, so when a hwmon sensor is created, 
it register this sensor as a thermal zone.


>> So the feature already exists for slow devices and are handled in the
>> drivers directly via the hwmon subsystem.
>>
>>  From my POV, the feature is not needed in the thermal framework.
> 
> The fact that hwmon does it in some way is another evidence of the
> actual problem.

Not really, it shows the i2c sensors are in the hwmon subsystems.


> Telling that this has to be solved by another subsystem
> for a sysfs node that is part of thermal subsystem does not really solve
> the problem. Also as I mentioned, this is not common on all hwmon
> devices, and not all I2C devices are hwmon devices. In fact, I2C
> was just one example of a slow device. There are more I can quote
> that are not necessarily under the hwmon case.

Yes, please. Can you give examples with existing drivers in the thermal 
framework and observed issues on specific platforms ? Numbers would help.

> Not sure if you missed, but an alternative for the difference of
> opinion on how this should behave is to have caching for response
> of sysfs read of tz/temp  as an option/configuration. Then we let
> userspace to choose which behavior it wants.

Before that, you have to prove the feature is really needed and show how 
the patches solves an issue. At this point, this is not demonstrated.




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

