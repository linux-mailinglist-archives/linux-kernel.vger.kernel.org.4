Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE696947C8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 15:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbjBMOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 09:16:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjBMOQ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 09:16:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD741449A;
        Mon, 13 Feb 2023 06:16:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e17so4776647plg.12;
        Mon, 13 Feb 2023 06:16:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=2epQmv2RAYoa7ftdeHQyIuTMBtxWyA80kI4YZESFMUY=;
        b=JpuHfqr0h+k0uFEZDFc54bvHtosHHgMJleYNeYIqas01BA6BSpV1l1cXjeBCb4zm3m
         +M8cP7cjxphNoeSpS3+yW3bwiXk5PpoMsGdq+Jt75+viX7ujsBAmzn5I3MTcpptDCTfF
         G9FaRA7cQmKLJ91uqImbQiinCGjMH0Pfiixk7FET5Oy5CppKA1qYtsMDf5UIJ6Exua5k
         vdFpuGzvQ4gDwGfxknUOVTXNWvj+prbqti6+GZpYGPje60uxaerUOZjcH4EDrWpCEgAR
         dSEgpBO3NlkGx9CNy9nwiPKTZKLZLsa+L0xSeGHNaIcYzti2j5RE5ttHYsOZY0chZ3zA
         P1eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2epQmv2RAYoa7ftdeHQyIuTMBtxWyA80kI4YZESFMUY=;
        b=Y1Fr7+6BxApXfdGXwKXXxk9WTj2QhIVZUzCDrs6q6N9voPB06TVE/GZoP3Id1u4jwD
         tVEV0EYRFowb1FIHlNVD5sqKBilti/NYf+Hm92o+wrruMnD506uaLnAlYfrspuWjzhBI
         ZTH56CH0h2isxAgX4XXCEM214ODnIcmILlrZqPmTOoewbcRPdXKjfAWqTJekIUb69VOJ
         aUqxfzd0nFjBIfcqRkyzYEUfgOhQc5fSH7JJc5WuNc1jfnaa2mrGVCqAgj77/6YjFH8o
         9jeBNOwu38g2aNKWNihmrlTH95DR7BWluHV770mchoCVhWDkJh6lFrvicRj26UtHuU44
         nRtQ==
X-Gm-Message-State: AO0yUKXKGaL5BPzWEbY0RV7vevOKB3Ris4HxbMubegu1qbmQweAPBCxq
        3K3cD3EbSBJJ7EGalyrC2as=
X-Google-Smtp-Source: AK7set+R8SlYq1CkTebLvtJHs+QFHykfPjX6kMzUEQhXB0/X+f60clsx1XhD2yLMkimmLUqJa/Ue1Q==
X-Received: by 2002:a17:903:2407:b0:198:adc4:229d with SMTP id e7-20020a170903240700b00198adc4229dmr16149726plo.24.1676297787631;
        Mon, 13 Feb 2023 06:16:27 -0800 (PST)
Received: from [192.168.0.133] ([106.51.67.219])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902b58a00b001991e4e0bdcsm8239884pls.233.2023.02.13.06.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Feb 2023 06:16:27 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <b11185d3-fbf3-a461-39bc-67bee4739e40@gmail.com>
Date:   Mon, 13 Feb 2023 19:46:23 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        Rishit Bansal <rishitbansal0@gmail.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Mark Gross <markgross@kernel.org>, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
 <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
 <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
 <ec5bc4a6-dc9f-90dd-0cf6-5fab47bb5fa6@redhat.com>
In-Reply-To: <ec5bc4a6-dc9f-90dd-0cf6-5fab47bb5fa6@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 13/02/23 18:19, Hans de Goede wrote:
> Hi,
> 
> On 2/7/23 14:05, Rishit Bansal wrote:
>> Hi,
>>
>> On 07/02/23 17:23, Pavel Machek wrote:
>>> Hi!
>>>
>>>>>> 2. Create 4 separate multi-color LED sysfs devices for each zone:
>>>>>>
>>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone1/
>>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone2/
>>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone3/
>>>>>> /sys/class/leds/hp_omen::kbd_backlight-zone4/
>>>
>>> 4 separate devices, please. And the naming should be consistent with
>>> the rest, so
>>>
>>> :rbg:kbd_backlight-zone1
>>
>> As covered above previously, we cannot have kbd_backlight in the name as Upower and several other userspace software which depend on it assume that /sys/class/leds has just a single file name with the string "kbd_backlight" in it:
>>
>>> For example, Ubuntu (and most gnome based distros) by default ships with gnome-settings-daemon, which by default attempts to dim the keyboard backlight after a short duration when on the "Low Power" ACPI platform profile. (https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/plugins/power/gsd-power-manager.c#L1671). This was currently working as intended with the v2 patch, but if we introduce 4 different files for each zone, this may start dimming only one keyboard zone on low power instead of all 4 of them, which is certainly not intended. There are also multiple projects (mostly gnome extensions) that interact with UPower which might also function incorrectly in other ways. I don't think we should release a feature in the driver which caused unintended consequences like the ones mentioned, especially if the software is popular. What is your opinion on this?
>>
>>
>> However, as Hans mentioned above, its possible to keep 4 seperate files and use a name other than kbd_backlight, so that we don't break existing stuff until the issue is fixed on upower:
>>
>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
>>
>>
>>
>>>
>>> would be closer to something consistent. Should be documented in
>>>
>>> Documentation/leds/well-known-leds.txt
>>>
>>> . And if you take a look there, you'll notice we already have N900
>>> that has 6 zones with white backlight.
>>>
>>
>> This is interesting as well, it appears the N900 also doesn't have "kbd_backlight" in the name at all. It instead uses a format like the following:
>>
>> /sys/class/leds/lp5523:kb1/
>> /sys/class/leds/lp5523:kb2/
>> ...
>>
>>
>> I'm not sure if this is because the N900 driver was made long before we had the concept of "kbd_backlight" in the name, or because of some other reason. There are about 9-10 drivers on the kernel which are sticking with using the "kbd_backlight" convention, so N900 seems to be an outlier here.
>>
>>
>>> But I'd really like to see plan to go forward. AFAICT there are
>>> keyboards with per-key backlight, and those start to look less like a
>>> set of LEDs and more like a display..
>>
>>
>>>
>>> Best regards,
>>>                                  Pavel
>>
>>
>> Something else I would like to add. I had a look at include/dt-bindings/leds/common.h, and it defines the following:
>>
>> /* Standard LED colors */
>> #define LED_COLOR_ID_WHITE    0
>> #define LED_COLOR_ID_RED    1
>> #define LED_COLOR_ID_GREEN    2
>> #define LED_COLOR_ID_BLUE    3
>> #define LED_COLOR_ID_AMBER    4
>> #define LED_COLOR_ID_VIOLET    5
>> #define LED_COLOR_ID_YELLOW    6
>> #define LED_COLOR_ID_IR        7
>> #define LED_COLOR_ID_MULTI    8    /* For multicolor LEDs */
>> #define LED_COLOR_ID_RGB    9    /* For multicolor LEDs that can do arbitrary color,
>>                         so this would include RGBW and similar */
>> #define LED_COLOR_ID_PURPLE    10
>> #define LED_COLOR_ID_ORANGE    11
>> #define LED_COLOR_ID_PINK    12
>> #define LED_COLOR_ID_CYAN    13
>> #define LED_COLOR_ID_LIME    14
>> #define LED_COLOR_ID_MAX    15
>>
>> This means that the proposal I had made for supporting intensities such as zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green zone_2_blue ... would be invalid as well, and inconsistent with these definitions. The limit of "15" would also prohibit us from supporting keyboards in the future which support lighting for every single key, as we would need way more than 15 indexes to accommodate all of these.
>>
>> So we are at sort of a conflicted state where none of the standards seem to correctly "completely" accomodate every single case/scenario of keyboard backlighting and zones.
>>
>>
>> Here is yet another approach to handle this, which I feel we should consider:
>>
>> We can keep the kbd_backlight file, and additionally have the 4 zones as separate files, (a total of 5 files) like the following:
>>
>>
>> 1. /sys/class/leds/hp_omen::kbd_backlight
>>
>> This file controls the global backlight brightness for all 4 zones. It will have no control for RGB control at this level, this is just sort of a global switch for the entire backlight. Setting the brightness on this level will update the brightness for every zone. This file will also help us maintain support with Upower.
>>
>> 2.
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
>> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
>>
>> These will be multi intensity RGBs, each supporting "red green blue" intensities, and can be used to individually control the brightness of each zone. Note that these files don't have "kbd_backlight" in the name for us to not mess with Upower's logic of only having a single keyboard backlight. This can be documented in Documentation/leds/well-known-leds.txt for future drivers which plan to support something similar.
> 
> I am not really a fan of this. When the "global" LED then is turned off (brightness=0) then all the other LED devices all of a sudden do nothing and writing values > 0 to their brightness won't turn them on which is not how the LED class API is supposed to work. We can come up with various tricks to work around this, but the fact remains that if we go this route we end up with weird hard to define interaction between 2 LED devices while from an userspace API pov they really should be independent.
> 
> note that both Pavel and I suggested using 4 multi-color LED class devices (1 per zone) for this and I still/really believe that this is the best way to deal with this.
> 
> I do agree with you that we need to avoid kbd_backlight in the name to avoid causing existing upower code to have weird interactions with this (it supports / assumes there is only 1 kbd_backlight LED class device).
> 
> So lets go with just these 4:
> 
> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
> 
> Using the _zoned_ between kbd and baclight to avoid confusing the existing upower code. Then once this has landed we can look into extending upower support for this.
> 
> Note the requested documentation patch should probably also explain that the _zoned_ was done deliberately to make current upower code ignore the devices.
> 
> Regards,
> 
> hans
> 
> 

This makes sense, I agree that the global LED file will cause more 
confusion and hacks in the code. I'll start working on the  _zoned_ 
naming scheme with 4 files + documentation changes and make a patch for 
this soon!


