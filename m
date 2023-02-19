Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4011A69C1FA
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Feb 2023 19:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBSSqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Feb 2023 13:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBSSqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 13:46:11 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B261422F;
        Sun, 19 Feb 2023 10:46:10 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id w12-20020a17090a4f4c00b00236a0d55d3aso1368952pjl.3;
        Sun, 19 Feb 2023 10:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Semri/BccCq2FUJbIEhcGLx1SAMh1cOFC4BEvKoANZU=;
        b=GzAF8wpb/DH3jbovxy866CHccI9ywc69mipvEU0wAGyTNpqgisbRzT3WV0LAuIkblE
         RlKXEcgQJ2HK9ehCFAHqQpLb8W5ftVP4SnX++ulYmxSmp6jFHpwSsTUtl5aXxo4F3Stn
         x576L0jJ1BU9XEsEBpwuk2D+kriA2g02AdiEs5BCp5SQlk8foq9ZkddkqdVr6PIcnsji
         p69cx6vDuyl+UiK70vVhGQKShneTlRyAPMxEFiuWRzD5ntRv/LGL1QzoigvY4ht9xZU7
         aona6dbhIGswYeXAzJW5GorMbX94BSHTvsrcyTJ2dKEdcOW3iaNehbq8MxKJQod2tQmx
         TR3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Semri/BccCq2FUJbIEhcGLx1SAMh1cOFC4BEvKoANZU=;
        b=iYZeL8850LHdF5QDMXrsoA0hy2KXa5im3Ksvvljr4sAusQkqCiu2Q6nbWr/Os4Vxki
         YFXjipejU71Y76dSjGw1XCNNlkdAUds/LHhoDOMn6p2m1qZbJvCIe0dE2SbHt2qkuBFV
         RXMA+vMqEuChC3E+1uYjb+hs/tWT2QE0sb9c1tjNyXdUe4SRZqK6ngyz0uxPYURPGUQS
         fxsHxZF838ySKhXOvc5PhHQNcSvW9vvJZkucMUAdfKUKo83BiGw5feh3Dwy1C4GhrTn0
         /IBYlib6OmT9m6dBjP09slyk0ZPRJXmifnRLfnhcPsWnRMac02CMffP5Aw7wRnC2c9cc
         caSA==
X-Gm-Message-State: AO0yUKUtztPYSyE6i+mUKUba8dxH5yXfqOQwF9H8YcSxvxT4v4FGYmT4
        5c7J+GZKSNYvGClX/FtK4zQ=
X-Google-Smtp-Source: AK7set/xhzrwirO+ezkjjIkLvlBOYHCfPP7w1ZcEKcJyRrg1q2mKcXYTCHw8lOmK92Tz5Z+DzYc9dg==
X-Received: by 2002:a17:903:27ce:b0:19a:c65d:f98 with SMTP id km14-20020a17090327ce00b0019ac65d0f98mr803223plb.40.1676832369899;
        Sun, 19 Feb 2023 10:46:09 -0800 (PST)
Received: from [192.168.1.73] ([171.76.81.196])
        by smtp.gmail.com with ESMTPSA id v3-20020a170902d68300b0019ad6451a67sm6292243ply.24.2023.02.19.10.46.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Feb 2023 10:46:09 -0800 (PST)
From:   Rishit Bansal <rishitbansal0@gmail.com>
X-Google-Original-From: Rishit Bansal <rishit.bansal0@gmail.com>
Message-ID: <a11fd918-d1bc-8a1f-c123-bcb0b4fa38a5@gmail.com>
Date:   Mon, 20 Feb 2023 00:16:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: API for setting colors of RGB backlit keyboard zones (was [PATCH
 V3] platform/x86: hp-wmi: Support omen backlight control wmi-acpi methods)
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Rishit Bansal <rishitbansal0@gmail.com>
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
 <b11185d3-fbf3-a461-39bc-67bee4739e40@gmail.com>
 <Y/C7A9eCjpdbzYbz@duo.ucw.cz>
 <bd2ae598-3f13-f465-4bde-6ab364b79db3@redhat.com>
In-Reply-To: <bd2ae598-3f13-f465-4bde-6ab364b79db3@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/23 18:50, Hans de Goede wrote:
> Hi,
> 
> On 2/18/23 12:48, Pavel Machek wrote:
>> Hi!
>>
>>
>>>> I do agree with you that we need to avoid kbd_backlight in the name to avoid causing existing upower code to have weird interactions with this (it supports / assumes there is only 1 kbd_backlight LED class device).
>>>>
>>>> So lets go with just these 4:
>>>>
>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-1/
>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-2/
>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-3/
>>>> /sys/class/leds/hp_omen::kbd_zoned_backlight-4/
>>>>
>>>> Using the _zoned_ between kbd and baclight to avoid confusing the existing upower code. Then once this has landed we can look into extending upower support for this.
>>>>
>>>> Note the requested documentation patch should probably also explain that the _zoned_ was done deliberately to make current upower code ignore the devices.
>>>>
>>
>>>
>>> This makes sense, I agree that the global LED file will cause more confusion
>>> and hacks in the code. I'll start working on the  _zoned_ naming scheme with
>>> 4 files + documentation changes and make a patch for this soon!
>>>
>>
>> /sys/class/leds/:rgb:kbd_zoned_backlight-4/ is better than what was
>> suggested above.
> 
> Ah yes using rgb for the color part of the name makes sense.
> 
>> But we already use _1 suffix to deduplicate the, so
>> I'm not sure this is best naming.
> 
> 
> 
> I guess we could try to actually name the zones, something like
> (no idea if this are indeed the 4 zones):
> 
> :rgb:kbd_zoned_backlight-main
> :rgb:kbd_zoned_backlight-wasd
> :rgb:kbd_zoned_backlight-cursor
> :rgb:kbd_zoned_backlight-numpad
> 
> Rishit any comments on this or improvements to it.

Here is an image of how the 4 zones on the keyboard look like 
(https://imgur.com/a/iQdRWCM). I think we can call them "left", 
"middle", "right", and "wasd":

:rgb:kbd_zoned_backlight-left
:rgb:kbd_zoned_backlight-middle
:rgb:kbd_zoned_backlight-right
:rgb:kbd_zoned_backlight-wasd


> 
>> There are keyboards with per-key backlight. How do you suggest to
>> solve those?
> 
> I really think those fall into a separate category, currently AFAIK
> all support for those use /dev/hidraw directly from userspace.
> 
> And any kernel API would need to likely be ioctl based, allowing
> setting all the LEDs in a single syscall otherwise setting the
> LEDs becomes to expensive / introduces to much latency when
> doing software driven animations. So I think the best thing to
> do there is to declare these out-of-scope for the classic
> sysfs based LED class API.

I agree with this as well, a separate API will be required for more 
complex use cases with per-key color control. For most  future cases 
with a limited number of zones, our current approach with multi LED 
"kbd_zoned" files should work out.

> 
> Regards,
> 
> Hans
> 
> 
> 
