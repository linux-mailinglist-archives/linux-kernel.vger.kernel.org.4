Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E936D6D7E3B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 15:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237597AbjDEN6O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 09:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237701AbjDEN6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 09:58:11 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67FC51706;
        Wed,  5 Apr 2023 06:58:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id y7so4976020ljp.2;
        Wed, 05 Apr 2023 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680703079;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEFqqxVAAD5ECRqK855/9kEcHl2reJ9ip0y7EsuPpA8=;
        b=Auvc+0GoDbscsJQKGTlvYzdocTvEiyQ4Nc5/Lz+2O/8ABZWxQeNp7pxs9qOzocAMX6
         ByPHFcxa+T6IQBMP/p4wtPZt/NNsYur/FZinFOd6wwNdQXcxzM1ae06JuMf4UW4uf98X
         qhVYwDItx5ZRkpzB5OS0PV9BUXUFCd63UxYjU33YCfsm3Qf6R5WiYXPPs3a5zWp+pa5D
         Jiy4AvIZ4IOkls1cvTACJSft8gUvdnkJdDQlB2VfYhBb/G8UcmV5Giii88c/H70sNb8+
         j1wTCZFKGh+l0DMwn2KeEn0jIY+GWUPqftp9w+Cz9ZOQaAeaaXQZm4M/inM+ru5ISRNS
         dMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680703079;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iEFqqxVAAD5ECRqK855/9kEcHl2reJ9ip0y7EsuPpA8=;
        b=67BTr2TNU0vnSD0Nqzcf3L5Zs69GA+3/qdcdk04/XFUtgHkcoh5we/7dON11GR2cfL
         zHQXR6ziUKT4Ls4ynA8UdjqZbuacEhxmrCcLqMd6T9JkCBBQtcaem9fItIT3w84U6vQw
         RVqGRh0wLnz1283WnuEDDxxG6lpCbzZ6NuSHO3ajxdK9F5P8nruADsqB362IT+vuWaAg
         f+w1U075PEnttZb2I2Nx2VowCxOWki8tp1TH+nz9nDpOP1t3cHw2Y/Qf7WjXNDYBzP8b
         TTw4DGoGq9wE52Smc371SvEnBCgOxvy1A5ZoM1TF5ypLV1iJi0f1IXAakgBO2dpQRiYm
         RjzQ==
X-Gm-Message-State: AAQBX9eHOgxRMvWdzPGx/hgpzW8/0uhSo1EuikYKqXAwbUsbZzojVAYx
        RbzyJ/h/xBjEVbN16E4sfIU3uJ7YILU=
X-Google-Smtp-Source: AKy350aXLsSRInavwAjV8fw93je4UeNkj6Li1FiI8Kc9UZHrES7/8Hb2CC0FIYCIiwvzKkQ4GFJ4lA==
X-Received: by 2002:a2e:720b:0:b0:2a6:183a:9a16 with SMTP id n11-20020a2e720b000000b002a6183a9a16mr1509722ljc.31.1680703079344;
        Wed, 05 Apr 2023 06:57:59 -0700 (PDT)
Received: from ?IPV6:2001:14ba:16f3:4a00::1? (dc75zzyyyyyyyyyyyyyyt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::1])
        by smtp.gmail.com with ESMTPSA id n17-20020ac24911000000b0048afb8b8e53sm2829930lfi.80.2023.04.05.06.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 06:57:58 -0700 (PDT)
Message-ID: <3be67394-6082-1aeb-8a8d-90149217bdc7@gmail.com>
Date:   Wed, 5 Apr 2023 16:57:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US, en-GB
To:     Guenter Roeck <linux@roeck-us.net>,
        Naresh Solanki <naresh.solanki@9elements.com>,
        linux-hwmon@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org, Sascha Hauer <sha@pengutronix.de>,
        jerome Neanne <jneanne@baylibre.com>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
References: <20230328150335.90238-1-Naresh.Solanki@9elements.com>
 <20230328150335.90238-2-Naresh.Solanki@9elements.com>
 <c88d3cdd-fb2f-c3ac-a9e8-e49f8e98b811@gmail.com>
 <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
From:   Matti Vaittinen <mazziesaccount@gmail.com>
Subject: Re: [PATCH v2 2/3] hwmon: (pmbus/core): Add regulator event support
In-Reply-To: <17934bff-f728-d57a-c3c8-956634bd48c8@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 4/5/23 16:15, Guenter Roeck wrote:
> On 3/28/23 23:48, Matti Vaittinen wrote:
>> Hi Naresh, all
>>
>> This mail is maybe more of a question so that I can get on the same 
>> page with the rest of the world than anything else. I just have to ask 
>> this as I am trying to figure out what kind of handling there could be 
>> for regulator errors. I added Mark and couple of others to the CC as I 
>> am under the impression they have done some work with the regulator 
>> error handling lately :)
>>
>> On 3/28/23 18:03, Naresh Solanki wrote:
>>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>>
>>> Add regulator events corresponding to regulator error in regulator flag
>>> map.
>>> Also capture the same in pmbus_regulator_get_flags.
>>>
>>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>>> ---
>>>   drivers/hwmon/pmbus/pmbus_core.c | 74 +++++++++++++++++++++-----------
>>>   1 file changed, 49 insertions(+), 25 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c 
>>> b/drivers/hwmon/pmbus/pmbus_core.c
>>> index d93405f1a495..509bc0ef1706 100644
>>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>>> @@ -2693,9 +2693,9 @@ static int pmbus_init_common(struct i2c_client 
>>> *client, struct pmbus_data *data,
>>>       return 0;
>>>   }
>>> -/* A PMBus status flag and the corresponding REGULATOR_ERROR_* flag */
>>> +/* A PMBus status flag and the corresponding REGULATOR_ERROR_* and 
>>> REGULATOR_EVENTS_* flag */
>>>   struct pmbus_status_assoc {
>>> -    int pflag, rflag;
>>> +    int pflag, rflag, eflag;
>>>   };
>>>   /* PMBus->regulator bit mappings for a PMBus status register */
>>> @@ -2710,27 +2710,36 @@ static const struct pmbus_status_category 
>>> __maybe_unused pmbus_status_flag_map[]
>>>           .func = PMBUS_HAVE_STATUS_VOUT,
>>>           .reg = PMBUS_STATUS_VOUT,
>>>           .bits = (const struct pmbus_status_assoc[]) {
>>> -            { PB_VOLTAGE_UV_WARNING, 
>>> REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>>> -            { PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>>> -            { PB_VOLTAGE_OV_WARNING, 
>>> REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>>> -            { PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT },
>>> +            { PB_VOLTAGE_UV_WARNING, 
>>> REGULATOR_ERROR_UNDER_VOLTAGE_WARN,
>>> +            REGULATOR_EVENT_UNDER_VOLTAGE_WARN },
>>> +            { PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE,
>>> +            REGULATOR_EVENT_UNDER_VOLTAGE },
>>> +            { PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN,
>>> +            REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>>> +            { PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_REGULATION_OUT,
>>> +            REGULATOR_EVENT_OVER_VOLTAGE_WARN },
>>
>> The question I have is: Are these mappings to regulator 
>> errors/notifications always correct?
>>
> 
> No, they are not always "correct", and can not be, because each chip 
> implements
> the PMBus standard as they see fit.
> 
>> (I don't know the PMBUS specification in details - and thus I am 
>> _asking_ this here, not telling that the mapping is incorrect).
>>
>> Let me explain why I am asking this.
>>
>> What I have gathered is that at least some ICs allow setting for 
>> example 'voltage limits' for different PMBUS over-voltage 
>> WARNs/FAULTs. I however don't know if for example the "fatality" of 
>> errors indicated by FAULTS vs WARNs is mandated by any specification - 
>> or if a hw designers have free hands to decide what these events 
>> indicate on their board - or what type of action should be taken when 
>> certain ERROR/WARN is emitted.
>>
> 
> PMBus actually specifies which action can and should be taken on faults,
> and that action is configurable. That - again - does not mean, however,
> that each chip implements this the same way, only that they should.
> 
> Possible (standard) actions for voltages are:
> 
> - continue operating without interruption
> - continue operating for a specified amount of time,
>    then shut down if fault still exists and optionally
>    retry
> - shut down and optionally retry for a configurable
>    number of times
> - disable output while fault condition is present
>    (e.g. for temperature faults) and re-enable after
>    fault condition no longer exists
> 
> Similar configuration settings are defined for current faults,
> with additional support for current limiting.
> 
>> Then to the handling of regulator errors:
>>
>> In order to be able to create any handling for the regulator 
>> errors/notifications, we should be able to classify the 
>> errors/notifications at least by the severity. The very fundamental 
>> decision is whether to turn-off the regulator - or even the whole 
>> system - in order to protect the hardware from damage.
>>
>> There are few other questions related to error handling as well - for 
>> example questions like:
>> Who should handle error? (we may have many consumers?)
>> When should consumer use for example forced regulator-off without 
>> knowing the other consumers?
>> When should we have in-kernel handling for errors?
>> When should the errors be sent to user-space trusting someone there is 
>> taking care of the situation?
>>
>> Following is largely my own pondering - and I would like to gain 
>> better understanding while also avoid sending wrong events/errors for 
>> detected HW issues so that we could actually implement recovery 
>> actions based on regulator errors / notifications.
>>
>> I have been trying to understand how error handling with regulator 
>> events should / could work. In my head (and in the regulator fault 
>> detection limit setting) we have 3 severity categories:
>>
>> 1. PROTECTION:
>> The most 'severe' type of issue. This is reserved for cases where the 
>> hardware shuts down the regulator(s) without any SW interaction. In 
>> most cases there is no need for notification or error status because 
>> soc is likely to go down when the power is cut off. Border case is 
>> when HW autonomously shuts down a regulator which does not deliver 
>> power to any critical component. I am unsure if such situation should 
>> be indicated by ERROR level notification.
>>
>> 2. ERROR:
>> Situation where system is no longer usable but the hardware does not 
>> do error handling. I would like to suggest that the proper handling 
>> for this type of events is regulator or system shutdown. I think the 
>> errors/notifications:
>>
>> #define REGULATOR_ERROR_UNDER_VOLTAGE           BIT(1)
>> #define REGULATOR_ERROR_OVER_CURRENT            BIT(2)
>> #define REGULATOR_ERROR_REGULATION_OUT          BIT(3)
>> #define REGULATOR_ERROR_FAIL                    BIT(4)
>> #define REGULATOR_ERROR_OVER_TEMP               BIT(5)
>>
>> #define REGULATOR_EVENT_UNDER_VOLTAGE           0x01
>> #define REGULATOR_EVENT_OVER_CURRENT            0x02
>> #define REGULATOR_EVENT_REGULATION_OUT          0x04
>> #define REGULATOR_EVENT_FAIL                    0x08
>> #define REGULATOR_EVENT_OVER_TEMP               0x10
>>
>> should only be used to indicate errors with this severity. That would 
>> allow actually implementing the handling for these errors. If these 
>> errors are sent for "less severe" issues, then we will not be able to 
>> do any generic error handling.
>>
>> 3. WARNING:
>> Situation where something is off-the-spec, but system is still thought 
>> to be usable. Here some - probably board/system (use-case?) specific - 
>> handling may be taking place to prevent things getting worse. I added 
>> following flags for this purpose:
>>
>> #define REGULATOR_EVENT_UNDER_VOLTAGE_WARN      0x2000
>> #define REGULATOR_EVENT_OVER_CURRENT_WARN       0x4000
>> #define REGULATOR_EVENT_OVER_VOLTAGE_WARN       0x8000
>> #define REGULATOR_EVENT_OVER_TEMP_WARN          0x10000
>> #define REGULATOR_EVENT_WARN_MASK               0x1E000
>>
>> #define REGULATOR_ERROR_UNDER_VOLTAGE_WARN      BIT(6)
>> #define REGULATOR_ERROR_OVER_CURRENT_WARN       BIT(7)
>> #define REGULATOR_ERROR_OVER_VOLTAGE_WARN       BIT(8)
>> #define REGULATOR_ERROR_OVER_TEMP_WARN          BIT(9)
>>
>>
>> So, my question(s) are:
>>
>> 1) Is this "classification" sensible and is it still possible?
>> 2) does PMBUS *_WARNING status bits always indicate error which maps 
>> to severity WARNING above? And more importantly
>> 3) does PMBUS *_FAULT status bits always indicate error which maps to 
>> severity ERROR above? Eg, can we assume correct handling for _FAULT is 
>> shutting down the regulator/system?
>>
> 
> No, as per above, since PMBus chips implement (or are supposed to 
> implement)
> their own fault handling.
> 
>> We have something similar in a few (non PMBUS compatible) PMICs. For 
>> example the ROHM BD9576 has a PROTECTION level error detection 
>> (automatic shutdown by HW) and then another error detection which just 
>> generates an IRQ and allows software to decide what should be done.
>>
>> While writing the driver for that PMIC my thinking was that the 
>> decision whether IRQ is indicating a fatal error or a warning should 
>> be on the board-designer's table. Thus I implemented it so that the 
>> severity and limit configuration for this error is given via 
>> device-tree - and it is up to board designer to decide whether the 
>> fault is ERROR or WARN - and notification sent by the driver for this 
>> IRQ will reflect the given severity.
>>
>> I wonder if something like this is needed for PMBUS - or if we can 
>> always say the *_FAULT maps to regulator ERROR and _WARNING maps to 
>> regulator WARNING no matter how board using the IC is designed?
>>
> 
> In summary, I must admit that I don't entirely understand your questions
> or why they are tied to PMBus regulator implementations, except that you
> seem to be saying that because reporting faults to the regulator 
> subsystem as
> errors may result in shutdowns requested by the regulator subsystem,

At the moment, no. I don't think the regulator subsystem itself requests 
shut-down for the system.

As far as I know, the handling of regulator errors is currently done by 
regulator consumers. If the only consumers for PMBus regulators are 
PMBus specific drivers - then the in-kernel error handling is in the 
hands of PMBus specific drivers.

Furthermore, I don't think we have in-tree handling for the regulator 
events. Hence, even if there were 'non PMBus specific' consumers for 
these regulators - there will probably be no catastrophic things 
happening as of now - but if these notifications can leak to non PMBus 
regulator consumers, then we place a restriction on handling of these 
errors. (Eg, other but PMBus specific regulator consumers must not 
handle these).

The one thing to consider is that (as far as I understand) some work has 
been done to get these events visible to user-space. I am unsure how the 
user-space should know what to do upon these events if these may be 
generated for 'different severity' issues.

> PMBus
> chips must not report such faults to the regulator subsystem as errors
> because that would interfer with fault handling implemented by PMBus chips.

I am sorry for making the noise here. As I said above, if the only 
consumers for these regulators are PMBus devices - then I guess this 
does not cause problems. Yet, I wonder if this means that not all of the 
regulator notifications should be sent to user-land.

> I am not sure if PMBus is made an example of here, but it seems to me
> that I don't have a choice. I'll hold up this series until I have a better
> understanding of the implications.

Please, don't block the series if no-one else but me is concerned. It is 
highly possible it is me who does not understand the purpose of these 
notifications or how they are thought to be handled.

Yours,
	-- Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

