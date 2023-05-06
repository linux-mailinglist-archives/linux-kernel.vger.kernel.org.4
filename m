Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D4C6F8E98
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 06:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjEFEnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 May 2023 00:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbjEFEnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 May 2023 00:43:50 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1745A7DA7;
        Fri,  5 May 2023 21:43:48 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1ab01bf474aso18923755ad.1;
        Fri, 05 May 2023 21:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683348227; x=1685940227;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QLFj+Rqu5xZsAW8YHESfBkUXV4V21xk8dfAw+uAOJpQ=;
        b=Fx4DLwtUTCthG8rNM12V0N3dNiZjrP+yO8BfSPkoDGBdvFNMUsyMY/UoVvncU+H7oW
         XCIphik346VXuLMtYuY7n8cHOXPT3oNdx/5P2m+FuANPqXUuWYVv6i9aSj9iE2hXSOmm
         SCyDQmVo9TMAtOxrxxS5qc7BUuzZpulQRLs/MsITAZDiza/CxCjCfueO5BToaQMPQ3rQ
         AgQK8of4xQ6ogldWUAZro8XiAQt7MTAI83rDdf2K+sdo7UR5OO8oLk321GRbynbhPPrG
         B7MIbzZylilTNTrqZ6SZemQFlwrJpTLkOJq904j9Vu595WbyaBpLdz7T9vjLWxiDCq+r
         fiNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683348227; x=1685940227;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QLFj+Rqu5xZsAW8YHESfBkUXV4V21xk8dfAw+uAOJpQ=;
        b=YBctSDWHjSGnvu8f3jjsbOwDyvtiX09k3FNG4+1/09Pn7gpEtxBHaph89J7dCbRiOT
         X1Hkd8PL0v2NqzOBtSLvMCKXc/2LaHVISVPLRt/t65EixpR8rO/3QQxHRFoRvoJmPNpp
         VFT25YlUgYk9X3pIkx5mYcyiUyQnqNW92ce2frCbOqzTtvY1ulbLOOpDtCxX3K/MvZTR
         XcRgIWa8d3EF4lCzEX5WfTcKzT0IMYcY0Ho7P2gP9VOb3lAKz/6+YVfSVJrwk/OpuQWP
         E8/m1rqXpZ2stRGhM/GZ8I5DaOnBorf8Z+BLcbPu7MnUwXsAk9l+LlT1h73FUfr89/di
         8EJQ==
X-Gm-Message-State: AC+VfDxFIbmaM/DAt1xGLT+/ttj+kTfxfiFNCTXAs5DgMAjESEsA9xgp
        hssCR3+z1/ceOi9v0dkbDcI=
X-Google-Smtp-Source: ACHHUZ7+6kHnfhJnhP6dBiE8cadcyhTH58bD77rKsZXjeN4YrycRUdV51IdO1n56B05aLdp0+aWQEw==
X-Received: by 2002:a17:903:1110:b0:1ab:74c:bdf2 with SMTP id n16-20020a170903111000b001ab074cbdf2mr4840636plh.28.1683348227336;
        Fri, 05 May 2023 21:43:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902dad000b001ac381f1ce9sm2581998plx.185.2023.05.05.21.43.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 21:43:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <17fb02ff-e2d8-9c0b-3de6-670c82fee997@roeck-us.net>
Date:   Fri, 5 May 2023 21:43:44 -0700
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
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] platform/x86: asus-wmi: add support for ASUS
 screenpad
In-Reply-To: <M8X7UR.MPEZYPQ0PU4F1@ljones.dev>
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

On 5/5/23 20:48, Luke Jones wrote:
> 
> 
> On Fri, May 5 2023 at 18:30:36 -0700, Guenter Roeck <linux@roeck-us.net> wrote:
>> On 5/5/23 16:43, Luke Jones wrote:
>>>
>>>
>>> On Fri, May 5 2023 at 16:08:16 +0300, Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:
>>>> On Fri, 5 May 2023, Luke D. Jones wrote:
>>>>
>>>>>  Add support for the WMI methods used to turn off and adjust the
>>>>>  brightness of the secondary "screenpad" device found on some high-end
>>>>>  ASUS laptops like the GX650P series and others.
>>>>>
>>>>>  These methods are utilised in a new backlight device named:
>>>>>  - asus_screenpad
>>>>>
>>>>>  Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>>>>  ---
>>>>>   .../ABI/testing/sysfs-platform-asus-wmi       |   2 +-
>>>>>   drivers/platform/x86/asus-wmi.c               | 132 ++++++++++++++++++
>>>>>   drivers/platform/x86/asus-wmi.h               |   1 +
>>>>>   include/linux/platform_data/x86/asus-wmi.h    |   4 +
>>>>>   4 files changed, 138 insertions(+), 1 deletion(-)
>>>>>
>>>>>  diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>  index a77a004a1baa..df9817c6233a 100644
>>>>>  --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>  +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
>>>>>  @@ -97,4 +97,4 @@ Contact:    "Luke Jones" <luke@ljones.dev>
>>>>>   Description:
>>>>>           Enable an LCD response-time boost to reduce or remove ghosting:
>>>>>               * 0 - Disable,
>>>>>  -            * 1 - Enable
>>>>>  +            * 1 - Enable
>>>>>  \ No newline at end of file
>>>>
>>>> Spurious change?
>>>
>>> Indeed it is. Not sure how that occurred.
>>>
>>>>
>>>>>  diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
>>>>>  index 1038dfdcdd32..0528eef02ef7 100644
>>>>>  --- a/drivers/platform/x86/asus-wmi.c
>>>>>  +++ b/drivers/platform/x86/asus-wmi.c
>>>>>  @@ -200,6 +200,7 @@ struct asus_wmi {
>>>>>
>>>>>       struct input_dev *inputdev;
>>>>>       struct backlight_device *backlight_device;
>>>>>  +    struct backlight_device *screenpad_backlight_device;
>>>>>       struct platform_device *platform_device;
>>>>>
>>>>>       struct led_classdev wlan_led;
>>>>>  @@ -3208,6 +3209,129 @@ static int is_display_toggle(int code)
>>>>>       return 0;
>>>>>   }
>>>>>
>>>>>  +/* Screenpad backlight */
>>>>>  +
>>>>>  +static int read_screenpad_backlight_power(struct asus_wmi *asus)
>>>>>  +{
>>>>>  +    int ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>>
>>>> Please move this to own line because now you have the extra newline
>>>> in between the call and error handling.
>>>
>>> I don't understand what you mean sorry. Remove the new line or:
>>> int ret;
>>> ret = asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_SCREENPAD_POWER);
>>>
>>>>
>>>>>  +
>>>>>  +    if (ret < 0)
>>>>>  +        return ret;
>>>>>  +    /* 1 == powered */
>>>>>  +    return ret ? FB_BLANK_UNBLANK : FB_BLANK_POWERDOWN;
>>>>>  +}
>>>>>  +
>>>>>  +static int read_screenpad_brightness(struct backlight_device *bd)
>>>>>  +{
>>>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>>>  +    u32 retval;
>>>>>  +    int err;
>>>>>  +
>>>>>  +    err = read_screenpad_backlight_power(asus);
>>>>>  +    if (err < 0)
>>>>>  +        return err;
>>>>>  +    /* The device brightness can only be read if powered, so return stored */
>>>>>  +    if (err == FB_BLANK_POWERDOWN)
>>>>>  +        return asus->driver->screenpad_brightness;
>>>>>  +
>>>>>  +    err = asus_wmi_get_devstate(asus, ASUS_WMI_DEVID_SCREENPAD_LIGHT, &retval);
>>>>>  +    if (err < 0)
>>>>>  +        return err;
>>>>>  +
>>>>>  +    return retval & ASUS_WMI_DSTS_BRIGHTNESS_MASK;
>>>>>  +}
>>>>>  +
>>>>>  +static int update_screenpad_bl_status(struct backlight_device *bd)
>>>>>  +{
>>>>>  +    struct asus_wmi *asus = bl_get_data(bd);
>>>>>  +    int power, err = 0;
>>>>>  +    u32 ctrl_param;
>>>>>  +
>>>>>  +    power = read_screenpad_backlight_power(asus);
>>>>>  +    if (power == -ENODEV)
>>>>>  +        return err;
>>>>
>>>> Just return 0. Or is there perhaps something wrong/missing here?
>>>
>>> I thought the correct thing was to return any possible error state (here, anything less than 0 would be an error, right?)
>>>
>>
>> Well, yes, but you are not returning an error. You are returning 'err'
>> which is 0 at this point. So, at the very least, this code is (very)
>> misleading since it suggests that it would return some error
>> (as saved in the 'err' variable) when it doesn't.
>>
>> Guenter
>>
> 
> Oh! Right I see it now, I'm sorry, I just kept skipping over it somehow.
> 
> So I should change to:
>      power = read_screenpad_backlight_power(asus);
>      if (power < 0)
>          return power;
> 
> Is that acceptable?
> 

That depends on what the code is supposed to do. Right now it is
"If read_screenpad_backlight_power() returns -ENODEV, stop and return
no error (let the rest of the code continue). If it returns another error,
return it".
Changing the code as suggested above changes the semantics to
"If read_screenpad_backlight_power() returns an error, always return it".

Looking at the patch, I don't have a definite answer.
asus_screenpad_init() happily registers the backlight if
read_screenpad_backlight_power() returns -ENODEV. One could argue that
the other functions should thus handle that situation gracefully as well,
but read_screenpad_brightness() does return -ENODEV in that situation.
I think you should decide how you want to handle that case and handle
it consistently across all functions.

Either case, there is another problem in asus_screenpad_init():
If read_screenpad_brightness() fails, the function returns an error,
but does not unregister the backlight device.

Guenter

