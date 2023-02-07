Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69F568D829
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 14:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbjBGNHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 08:07:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjBGNHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 08:07:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FB63A59F;
        Tue,  7 Feb 2023 05:06:31 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id d6-20020a17090ae28600b00230aa72904fso6596535pjz.5;
        Tue, 07 Feb 2023 05:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=CjpRuK8k8RRKLaDbGjDWUWOftV+VwVWVrEyk065W4Ds=;
        b=kwCuuMxftyZesEoaINln53P4sGlTVNgzyGaOmHZ9Csy9IymIwfc8lsyGgVdyldDghR
         ECGZ+sGmWtoTqNIVtVQm5SWwbz3AqixjwQrhEki9lRUv8xrerLb2sV4xws8B6S02kwlP
         YnKUywqLbvIOxDD1nb5iRhNXUNHLfumm56xGA+IAmuHatGPTjMALVPdBB3S5dIIukNro
         JK0XYLnu5tXOpE4XbXoXKROt0wfZHNbq52qUAOVyioBjivulXtcGL+M/ffVRqzA2B5b8
         5mGS6UNKHsDFunUjTfvdqY/TBLzx5Ow52pXN7zaVM7VGvuqlNQvAxAb168cGSveV9e9g
         T4hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CjpRuK8k8RRKLaDbGjDWUWOftV+VwVWVrEyk065W4Ds=;
        b=uuq6KBc0SAK1NpFPFbOsWQipOulYvM8IjWh7O2eEMMIRe2aHPwNNgJJ7iOtRJzfAeE
         K8GhWvEg69jnW7EcmGr8CQfJT7vn9V+csdP0gFWCR9LZ3680RcxjAOQ5xomLu/7ge6fQ
         fgzjGi31Z9tlIsyBL9+03aW37MwzRxk1AwNERfRvcNE8U8Jil4GhoRomlJvK3vG1ZQqe
         IFFj0MeBhY6P27ZN8coS2Qv9thfpYb0IqmF+OsBOp5l0vhWmE/7x9Npm8cJm297XnaJc
         auR4QHPQOehOGHcnpS3ggLdVXeCspKUNp9G4uInVAXH4IYPVdcv7orHqnh7QIZHUnAnD
         T/gQ==
X-Gm-Message-State: AO0yUKW6EpNhOxV4pl1MlWwzz60NC/rkV3phdflQ9Lu93miPF/jSVIH5
        OgpRuRaafVSfiU0r47w4FFk=
X-Google-Smtp-Source: AK7set89srq29r9rfQ4XZUvcx6WMTD2YZtjenSjPvYYKvzWB2nFOpbnKWK/gN5Daxc8FwwsImy3pRg==
X-Received: by 2002:a17:90b:1d12:b0:22c:6c0c:3e3b with SMTP id on18-20020a17090b1d1200b0022c6c0c3e3bmr4051522pjb.7.1675775157135;
        Tue, 07 Feb 2023 05:05:57 -0800 (PST)
Received: from [192.168.0.133] ([106.51.67.219])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090a400500b00230b8431323sm3777969pjc.30.2023.02.07.05.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 05:05:56 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <3c48e204-780c-f78c-8219-267e297dc1e3@gmail.com>
Date:   Tue, 7 Feb 2023 18:35:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>
Cc:     Rishit Bansal <rishitbansal0@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Dan Murphy <dmurphy@ti.com>
References: <20230131235027.36304-1-rishitbansal0@gmail.com>
 <9b761996-d522-b0f8-6472-10e40e09e036@redhat.com>
 <65a11a89-e780-6d60-a40e-cd3245780762@gmail.com>
 <b83ad6ba-7d55-f309-5d7b-4a5ff77ff5a3@redhat.com>
 <02c96cfe-ab10-513f-fc36-f474dd227656@gmail.com>
 <544484b9-c0ac-2fd0-1f41-8fa94cb94d4b@redhat.com>
 <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
In-Reply-To: <Y+I7xNqkq/X6Lag+@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 07/02/23 17:23, Pavel Machek wrote:
> Hi!
> 
>>>> 2. Create 4 separate multi-color LED sysfs devices for each zone:
>>>>
>>>> /sys/class/leds/hp_omen::kbd_backlight-zone1/
>>>> /sys/class/leds/hp_omen::kbd_backlight-zone2/
>>>> /sys/class/leds/hp_omen::kbd_backlight-zone3/
>>>> /sys/class/leds/hp_omen::kbd_backlight-zone4/
> 
> 4 separate devices, please. And the naming should be consistent with
> the rest, so
> 
> :rbg:kbd_backlight-zone1

As covered above previously, we cannot have kbd_backlight in the name as 
Upower and several other userspace software which depend on it assume 
that /sys/class/leds has just a single file name with the string 
"kbd_backlight" in it:

> For example, Ubuntu (and most gnome based distros) by default ships with gnome-settings-daemon, which by default attempts to dim the keyboard backlight after a short duration when on the "Low Power" ACPI platform profile. (https://gitlab.gnome.org/GNOME/gnome-settings-daemon/-/blob/master/plugins/power/gsd-power-manager.c#L1671). This was currently working as intended with the v2 patch, but if we introduce 4 different files for each zone, this may start dimming only one keyboard zone on low power instead of all 4 of them, which is certainly not intended. There are also multiple projects (mostly gnome extensions) that interact with UPower which might also function incorrectly in other ways. I don't think we should release a feature in the driver which caused unintended consequences like the ones mentioned, especially if the software is popular. What is your opinion on this?


However, as Hans mentioned above, its possible to keep 4 seperate files 
and use a name other than kbd_backlight, so that we don't break existing 
stuff until the issue is fixed on upower:

> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/



> 
> would be closer to something consistent. Should be documented in
> 
> Documentation/leds/well-known-leds.txt
> 
> . And if you take a look there, you'll notice we already have N900
> that has 6 zones with white backlight.
> 

This is interesting as well, it appears the N900 also doesn't have 
"kbd_backlight" in the name at all. It instead uses a format like the 
following:

/sys/class/leds/lp5523:kb1/
/sys/class/leds/lp5523:kb2/
...


I'm not sure if this is because the N900 driver was made long before we 
had the concept of "kbd_backlight" in the name, or because of some other 
reason. There are about 9-10 drivers on the kernel which are sticking 
with using the "kbd_backlight" convention, so N900 seems to be an 
outlier here.


> But I'd really like to see plan to go forward. AFAICT there are
> keyboards with per-key backlight, and those start to look less like a
> set of LEDs and more like a display..


> 
> Best regards,
> 								Pavel


Something else I would like to add. I had a look at 
include/dt-bindings/leds/common.h, and it defines the following:

/* Standard LED colors */
#define LED_COLOR_ID_WHITE	0
#define LED_COLOR_ID_RED	1
#define LED_COLOR_ID_GREEN	2
#define LED_COLOR_ID_BLUE	3
#define LED_COLOR_ID_AMBER	4
#define LED_COLOR_ID_VIOLET	5
#define LED_COLOR_ID_YELLOW	6
#define LED_COLOR_ID_IR		7
#define LED_COLOR_ID_MULTI	8	/* For multicolor LEDs */
#define LED_COLOR_ID_RGB	9	/* For multicolor LEDs that can do arbitrary 
color,
					   so this would include RGBW and similar */
#define LED_COLOR_ID_PURPLE	10
#define LED_COLOR_ID_ORANGE	11
#define LED_COLOR_ID_PINK	12
#define LED_COLOR_ID_CYAN	13
#define LED_COLOR_ID_LIME	14
#define LED_COLOR_ID_MAX	15

This means that the proposal I had made for supporting intensities such 
as zone_1_red zone_1_green zone_1_blue zone_2_red zone_2_green 
zone_2_blue ... would be invalid as well, and inconsistent with these 
definitions. The limit of "15" would also prohibit us from supporting 
keyboards in the future which support lighting for every single key, as 
we would need way more than 15 indexes to accommodate all of these.

So we are at sort of a conflicted state where none of the standards seem 
to correctly "completely" accomodate every single case/scenario of 
keyboard backlighting and zones.


Here is yet another approach to handle this, which I feel we should 
consider:

We can keep the kbd_backlight file, and additionally have the 4 zones as 
separate files, (a total of 5 files) like the following:


1. /sys/class/leds/hp_omen::kbd_backlight

This file controls the global backlight brightness for all 4 zones. It 
will have no control for RGB control at this level, this is just sort of 
a global switch for the entire backlight. Setting the brightness on this 
level will update the brightness for every zone. This file will also 
help us maintain support with Upower.

2.
/sys/class/leds/hp_omen::kbd_zoned_backlight-1/
/sys/class/leds/hp_omen::kbd_zoned_backlight-2/
/sys/class/leds/hp_omen::kbd_zoned_backlight-3/
/sys/class/leds/hp_omen::kbd_zoned_backlight-4/

These will be multi intensity RGBs, each supporting "red green blue" 
intensities, and can be used to individually control the brightness of 
each zone. Note that these files don't have "kbd_backlight" in the name 
for us to not mess with Upower's logic of only having a single keyboard 
backlight. This can be documented in 
Documentation/leds/well-known-leds.txt for future drivers which plan to 
support something similar.


Please let me know if you have any suggestions/comments around this new 
way of handling this.



