Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 048CD747724
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:44:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjGDQoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:44:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbjGDQoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:44:11 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C8B19B0;
        Tue,  4 Jul 2023 09:43:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1b8ad356fe4so444175ad.2;
        Tue, 04 Jul 2023 09:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688489021; x=1691081021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QL2M3Cz818dqNrKSbTrYj6OW1NR2RpmjCHPMkuvFkQo=;
        b=i/gVflRd97a00KEqaLzysrTszK4h5XmJLwrdCSoj2wmmDaMz2EGVzcKKFO+BwRxNAY
         004uTe3XYEZvQEgvBwnek52d5H7ki8wY+iKCYR2MeD+8rRXUJg6VnnwmTiEcoUe4UIAd
         Kq4/fJPy/9fjMfCCthMMqzo24rgL4Tu6o+SxswqqNMxyzUkYk4Jshpr1n7B998NOQnXk
         YlxoWaJAVPgrCaAWUGqdU/kEnkOUJSvzK/DkvMWdgvVqKyjsBLdq3htHrPpCINJEO+12
         LhO0ZrXn/zn7/VrKwZTHEWt3SsD39QyGUWet47cVKhWxdw1e2263V4whHazjvJDvk90a
         d27Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688489021; x=1691081021;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QL2M3Cz818dqNrKSbTrYj6OW1NR2RpmjCHPMkuvFkQo=;
        b=akKt9BCGHJ8kDMqID1u3M1eKzskU260WAtmQ4WitP0HsIElZUsSnNdauhOoZla79ng
         iHGfR6gbjE0DQJJeof8qWhTYiYiNMwNQQxfTAPMWCw4K6Y2ds+rEXtJcUJ1q90rHVRJG
         600cgbFVgb3UpFBoEyr2jbvzkBeZcbl9EIN9lAmd8muKeffRm8nI8M3dvBeADEzuGFqs
         bmCf3cajRJBbOaTn6q8YX07ocHvo8gFDDtqY1GXWD1ExlJkVRHnjTiEBHoPGwVTC6XE6
         rL0GrNwk7MDy29qpSRSEdfU9L2UVsi3cfgQj18GIHjlrKrmJ3BK+IUWZlimZjkySICqu
         Vjeg==
X-Gm-Message-State: AC+VfDzfMP5gwcdSgfeZ+dvMf2RbANeWP+4ELt+i6Tfq7i7WhyAIn3wa
        e6sH4pd6LRKO7K2Lm9J8Jck=
X-Google-Smtp-Source: ACHHUZ45susAI6nzgRNIJcCOAcFTWE+YzKwOTgOMbgBT/p7uSL3ZwOsL8tgU+6D+hTZ80UJ3FXCmog==
X-Received: by 2002:a05:6a20:101a:b0:126:eed0:f55e with SMTP id gs26-20020a056a20101a00b00126eed0f55emr11516223pzc.11.1688489021396;
        Tue, 04 Jul 2023 09:43:41 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001b8a4a9622dsm1806611plb.113.2023.07.04.09.43.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 09:43:40 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <fd1cab46-0a51-6aab-8fda-f603fd4e0058@roeck-us.net>
Date:   Tue, 4 Jul 2023 09:43:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] hwmon: (oxp-sensors): remove static board variable
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-hwmon@vger.kernel.org, samsagax@gmail.com,
        linux-kernel@vger.kernel.org
References: <20230704131715.44454-5-gregkh@linuxfoundation.org>
 <20230704131715.44454-6-gregkh@linuxfoundation.org>
 <a9c6c44c-21fb-9d42-9a6d-6685e110015d@roeck-us.net>
 <2023070402-festive-rind-9274@gregkh>
 <cb71b00e-0225-ea24-b30e-4d615af026f0@roeck-us.net>
 <2023070425-jujitsu-ladder-195e@gregkh>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <2023070425-jujitsu-ladder-195e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 09:14, Greg Kroah-Hartman wrote:
> On Tue, Jul 04, 2023 at 07:14:54AM -0700, Guenter Roeck wrote:
>> On 7/4/23 06:44, Greg Kroah-Hartman wrote:
>>> On Tue, Jul 04, 2023 at 06:39:07AM -0700, Guenter Roeck wrote:
>>>> On 7/4/23 06:17, Greg Kroah-Hartman wrote:
>>>>> Drivers should not have a single static variable for the type of device
>>>>> they are bound to.  While this driver is really going to only have one
>>>>> device at a time in the system, remove the static variable and instead,
>>>>> look up the device type when needed.
>>>>>
>>>>
>>>> This is expensive. I think it would be much better to just move
>>>> the board type detection into the init code and not instantiate
>>>> the driver in the fist place if the board type is unknown.
>>>
>>> The board type detection is all over the place in the driver, it's not
>>> just for "unknown" types, so how about just saving the board type at
>>> probe time and using it then for all other places?
>>>
>>
>> I must be missing something. The current code detects the board type
>> only once, in the probe function. Otherwise the static variable is used.
>> You are replacing it with repeated calls to get_board_type().
>> The whole point of the static variable is to avoid the cost of repeated
>> calls to dmi_first_match().
> 
> Ah, ok, yes, I was refering to the fact that the driver relies on the
> detection of the device type in lots of different places (and doesn't
> ever error out from the detection call.)
> 

I am lost again. Current code:

         dmi_entry = dmi_first_match(dmi_table);
         if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
                 return -ENODEV;



>>>> We can handle the static variable separately if it really bothers
>>>> you that much.
>>>
>>> I did this change to make patch 2/3 more "obvious" what is happening
>>> when the in_visible() callback happens, so that you don't have to worry
>>> about the saved value or not.  But this whole patch isn't really needed
>>> if you don't mind the lookup just happening in the in_visible() callback
>>> for the first time.
>>>
>>
>> That would at least be a minimal change, and just add one extra lookup
>> which is only called once (or zero, if it is used to save the board type).
> 
> Ok, I'll switch it up, but really, it's just a simple table lookup loop,
> and none of the detection calls are on a "hot path" that I can
> determine.  Or am I missing something?
> 
>> As I said, my solution would be to move the board type detection
>> into the init function and not instantiate the driver in the first
>> place if the probe function would bail out anyway.
> 
> That's not the case today, the only way the probe function would fail
> today is if the registering of the sysfs files fail.  It does not matter
> if the board detection call passes or not.
> 

Again,
         dmi_entry = dmi_first_match(dmi_table);
         if (!dmi_entry || boot_cpu_data.x86_vendor != X86_VENDOR_AMD)
                 return -ENODEV;
                 ^^^^^^^^^^^^^^^

What am I missing ?

Guenter

