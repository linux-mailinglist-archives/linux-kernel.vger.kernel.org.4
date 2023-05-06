Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 837596F923B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbjEFNYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 09:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjEFNYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 09:24:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64AA71F4A0;
        Sat,  6 May 2023 06:24:48 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64115eef620so25220327b3a.1;
        Sat, 06 May 2023 06:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683379488; x=1685971488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzQea2xgn/v16lMnD0LvD9GpMFuQwgvd8JYDxvdrbZo=;
        b=Pja+trRgveMSupDRVFdCElqZZcNkrLTb3BCk8zfB92mApSQg3DSgM7kXZJAyEbOExr
         THSUzFWjATswFxOiOhlfl60L3dkWhmmeXgSJ9kWMJUjTQl7BScPfryKqq4zzsQHsYTOo
         TScspa0N5KriVHQ1ye/N+BTk5+TO5CnkT3cAAYCupqR+ySwDIFyMynZZ+JtyYjWMuw1k
         Y1gRXGUmue3I2oS87sHyLUggLCCmFC9b3mm7hAC5vBJIOeKJNQ+O8zd0YG0BHZAtSMR5
         fTcxeFYk9BGqxvY3ui2TYmKDIgdGmeP/YD/QrgonTcQd9MO0u8diDbYA5SQFTNVfCS0g
         S9Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683379488; x=1685971488;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzQea2xgn/v16lMnD0LvD9GpMFuQwgvd8JYDxvdrbZo=;
        b=Mkka2oCoe2Hc8ZPRwyQdG50htU5Bgm3gYt+imA1ilowJf75YKH7nFbmj0W1yBgNGM/
         /GQ/LXQTqFHbPXcjovK78a1qwj0Sh9GqGqB8zlf1PU7Qxo/pKXjm2ZnyFJKZWSNPOKwJ
         6NUuhaO4xd0p8EdDUW8lcPi3CIGqIAxBItu52E9Vhc8Rw5XKzfZ32IyfSAlF7WAPt8oD
         NDmj2NQ51lOkE23ESWRQX/n79Mu9FGPWVCM/NlIPhjg5phcBQT4FFUOMkB2Rad5xvfGq
         AfTA7+IQNusUIRL+aR2pwIm4Nio8maEY+RO4/w77YJqik6yxtbfmSpqUBaoDMEAUAeFd
         SJsQ==
X-Gm-Message-State: AC+VfDyryGxAYwiWts4PQyyZi9qV5pyo4PAUkxx1Mb+HRzpakfgoJuZy
        lSc2n1t4RgmxIog5Qk9tAq0=
X-Google-Smtp-Source: ACHHUZ6EaRUMazeeuyPN5gtYU0mooud7SfaREq1rV4u5qDvcZffAtJdxlaRZtD1Tn5I6hiQAexP3wA==
X-Received: by 2002:a17:902:f804:b0:1a6:d9a6:a9b4 with SMTP id ix4-20020a170902f80400b001a6d9a6a9b4mr5224307plb.3.1683379487593;
        Sat, 06 May 2023 06:24:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v10-20020a170902b7ca00b001a674fb0dd8sm3551298plz.247.2023.05.06.06.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 May 2023 06:24:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ac31cb07-22c3-7461-b1d0-670f15355e20@roeck-us.net>
Date:   Sat, 6 May 2023 06:24:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Luke Jones <luke@ljones.dev>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        acpi4asus-user@lists.sourceforge.net, hdegoede@redhat.com,
        corentin.chary@gmail.com, markgross@kernel.org, jdelvare@suse.com
References: <20230505043013.2622603-1-luke@ljones.dev>
 <20230505043013.2622603-2-luke@ljones.dev>
 <9f77e8fd-38fe-818f-2fee-ca3bf4243576@linux.intel.com>
 <TWL7UR.KE812U8BYMG8@ljones.dev>
 <f1f8ff7a-6f23-e284-b494-7df2f0dce1a4@roeck-us.net>
 <M8X7UR.MPEZYPQ0PU4F1@ljones.dev>
 <17fb02ff-e2d8-9c0b-3de6-670c82fee997@roeck-us.net>
 <QB98UR.2KNZGZXO8NF12@ljones.dev>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
In-Reply-To: <QB98UR.2KNZGZXO8NF12@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/6/23 01:09, Luke Jones wrote:
> 
> 
> On Fri, May 5 2023 at 21:43:44 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/5/23 20:48, Luke Jones wrote:
>>>
>>>
>>> On Fri, May 5 2023 at 18:30:36 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>>>> On 5/5/23 16:43, Luke Jones wrote:
>>>>>
>>>>>
>>>>> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
>>>>>> On Fri, 5 May 2023, Luke D. Jones wrote:
>>>>>>
>>>>>>>  Add support for the WMI methods used to turn off and adjust the
>>>>>>>  brightness of the secondary "screenpad" device found on some high-end
>>>>>>>  ASUS laptops like the GX650P series and others.
>>>>>>>
>>>>>>>  These methods are utilised in a new backlight device named:
>>>>>>>  - asus_screenpad
>>>>>>>
>>>>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>>>  ---
>>>>>>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>>>>>>   drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
>>>>>>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>>>>>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>>>>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>  index a77a004a1baa..df9817c6233a 100644
>>>>>>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>>>  @@ -97,4 +97,4 @@ Contact:    "Luke Jones" <luke@ljones.dev>
>>>>>>>   Description:
>>>>>>>           Enable an LCD response-time boost to reduce or remove ghosting:
>>>>>>>               * 0 - Disable,
>>>>>>>  -            * 1 - Enable
>>>>>>>  +            * 1 - Enable
>>>>>>>  \ No newline at end of file
>>>>>>
>>>>>> Spurious change?
>>>>>
>>>>> Indeed it is. Not sure how that occurred.
>>>>>
>>>>>>
>>>>>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>>>  index 1038dfdcdd32..0528eef02ef7 100644
>>>>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>>>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>>>>>>
>>>>>>>       struct input_dev *inputdev;
>>>>>>>       struct backlight_device *backlight_device;
>>>>>>>  +    struct backlight_device *screenpad_backlight_device;
>>>>>>>       struct platform_device *platform_device;
>>>>>>>
>>>>>>>       struct led_classdev wlan_led;
>>>>>>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>>>>>>       return 0;
>>>>>>>   }
>>>>>>>
>>>>>>>  +/* Screenpad backlight */
>>>>>>>  +
>>>>>>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>>>>>>  +{
>>>>>>>  +    int ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>>>
>>>>>> Please move this to own line because now you have the extra newline
>>>>>> in between the call and error handling.
>>>>>
>>>>> I don't understand what you mean sorry. Remove the new line or:
>>>>> int ret;
>>>>> ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>>
>>>>>>
>>>>>>>  +
>>>>>>>  +    if (ret < 0)
>>>>>>>  +        return ret;
>>>>>>>  +    /* 1 == powered */
>>>>>>>  +    return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>>>>>  +}
>>>>>>>  +
>>>>>>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>>>>>>  +{
>>>>>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>>>>>  +    u32 retval;
>>>>>>>  +    int err;
>>>>>>>  +
>>>>>>>  +    err = read_screenpad_backlight_power(asus);
>>>>>>>  +    if (err < 0)
>>>>>>>  +        return err;
>>>>>>>  +    /* The device brightness can only be read if powered, so return stored */
>>>>>>>  +    if (err == FB_BLANK_POWERDOWN)
>>>>>>>  +        return asus->driver->screenpad_brightness;
>>>>>>>  +
>>>>>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>>>>>  +    if (err < 0)
>>>>>>>  +        return err;
>>>>>>>  +
>>>>>>>  +    return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>>>>>  +}
>>>>>>>  +
>>>>>>>  +static int update_screenpad_bl_status(struct backlight_device *bd)
>>>>>>>  +{
>>>>>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>>>>>  +    int power, err = 0;
>>>>>>>  +    u32 ctrl_param;
>>>>>>>  +
>>>>>>>  +    power = read_screenpad_backlight_power(asus);
>>>>>>>  +    if (power == -ENODEV)
>>>>>>>  +        return err;
>>>>>>
>>>>>> Just return 0. Or is there perhaps something wrong/missing here?
>>>>>
>>>>> I thought the correct thing was to return any possible error state (here, anything less than 0 would be an error, right?)
>>>>>
>>>>
>>>> Well, yes, but you are not returning an error. You are returning 'err'
>>>> which is 0 at this point. So, at the very least, this code is (very)
>>>> misleading since it suggests that it would return some error
>>>> (as saved in the 'err' variable) when it doesn't.
>>>>
>>>> Guenter
>>>>
>>>
>>> Oh! Right I see it now, I'm sorry, I just kept skipping over it somehow.
>>>
>>> So I should change to:
>>>      power = read_screenpad_backlight_power(asus);
>>>      if (power < 0)
>>>          return power;
>>>
>>> Is that acceptable?
>>>
>>
>> That depends on what the code is supposed to do. Right now it is
>> "If read_screenpad_backlight_power() returns -ENODEV, stop and return
>> no error (let the rest of the code continue). If it returns another error,
>> return it".
>> Changing the code as suggested above changes the semantics to
>> "If read_screenpad_backlight_power() returns an error, always return it".
>>
>> Looking at the patch, I don't have a definite answer.
>> asus_screenpad_init() happily registers the backlight if
>> read_screenpad_backlight_power() returns -ENODEV. One could argue that
>> the other functions should thus handle that situation gracefully as well,
>> but read_screenpad_brightness() does return -ENODEV in that situation.
>> I think you should decide how you want to handle that case and handle
>> it consistently across all functions.
>>
>> Either case, there is another problem in asus_screenpad_init():
>> If read_screenpad_brightness() fails, the function returns an error,
>> but does not unregister the backlight device.
>>
>> Guenter
>>
> 
> 
> Thanks mate. I was working on this between my workload and getting a few users to test. My first priority was to get the thing working for them and as such I didn't put much thought in to errors and consistency.
> 
> I think since `asus_screenpad_init()` is not called unless the brightness WMI method exists, then it and the other functions should return all errors if the power WMI method fails at all since the device functionality is compromised. If there is a hardware change in this aspect we could revisit it then.
> 
That would suggest that asus_screenpad_init() should also abort on all errors
and not assign a power of 'FB_BLANK_UNBLANK' if it is unreadable.

>  > Either case, there is another problem in asus_screenpad_init():
>  > If read_screenpad_brightness() fails, the function returns an error,
>  > but does not unregister the backlight device.
> 
> I wasn't entirely sure how to handle this. Mostly I followed what the existing backlight code was doing, I've now added a `goto fail_screenpad;` with:
> fail_screenpad:
>      if (asus->screenpad_backlight_device)
>          asus_screenpad_exit(asus);
> 
> really I'm relying on others to guide me with this - I know I've got a fair few patches in these days but they've been mostly simple things except for TUF RGB, and I've had to learn a bunch of stuff as I go.
> 
> I'll await your response before I send in a V3.
> 

Personally I'd first try to use devm_backlight_device_register().
As for error handling, the code would normally be something like

fail_screenpad:
	backlight_device_unregister(asus->screenpad_backlight_device);

or better

fail_screenpad:
	backlight_device_unregister(bd);

I don't know why you would want to check if asus->screenpad_backlight
is NULL because the code would never be called with it being NULL.

Note that I don't see why
	asus->screenpad_backlight_device = NULL;
in asus_screenpad_exit() would be necessary.

Guenter

