Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E986735D87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 20:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjFSSkv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 14:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjFSSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 14:40:49 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6259A18C;
        Mon, 19 Jun 2023 11:40:48 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b5422163f4so22693925ad.2;
        Mon, 19 Jun 2023 11:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687200048; x=1689792048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5ZgkawgcpNKfDimADbfMrf4fLDUhrxI/ZCrEvpkQwog=;
        b=qt204KFijdMQILdU/na9toTnE6G/SqHDazWMqgZP5zuHq87dvUKh9pTIF1WngvsQld
         7YBBr/Ckqrjhn5fg7FEPFmiRN0CEugazjpz5zE2wE1Zz3VJFxkOcX9/d8lSRSQZvAJY3
         cx6YvtoKRu0ysR/m7FDCp43AYuziwk51IRVfgPswmRTnuJA8a+cqIhmz2PvLjo6/hD4f
         k8SAMpgEL0dBCUjlv4gUn1Uy4YBrnomChIpqcIKM40Gn7iOXUwLgnamjUSoOxPdJyKTJ
         HqARmqSiRVITyBL6MWBkIkwvxk44lEFYGgo4u9Il+QPWFfQkLFxIjZRXrQJmM6Dfv6QO
         mRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687200048; x=1689792048;
        h=content-transfer-encoding:in-reply-to:subject:from:references:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5ZgkawgcpNKfDimADbfMrf4fLDUhrxI/ZCrEvpkQwog=;
        b=kox8jO1/3BxP+2o1a6kxk87nKhjRx+OVdmZAksTyRh/pXFFpjlTEbcATfaHNKAbQ/E
         rMVGaYjVfXGuLtHTJao2k2mI2xgAkT/GDZw9u1HtM0r0cLERgU6A+qGWiltvnwafyGO8
         xmScjnWTiLPcE6tji68/NWMPOYckpXwX0MVaOB3uOqLL0GKlmCviW+c1oo3cv++pMqhq
         G7s/Q0ONsCwHws7Di1p++FCW9waVHrg13SpnVIwlHnzuLdNviv7qXMWFtEYAdfiDHD46
         Wy9TEYiqSe74GsP0qF5Gy7lEF3wGhtwT6ZuhoQxMtaDS+Lh1bM9fjKaGPs7imoqRGBBn
         zeAQ==
X-Gm-Message-State: AC+VfDzSUXBVFprAjaCRitURE4xRTmSlaWxduC3YMkO8bhLBq5WiKm+Z
        utN8EGTAG4Aimw9wu739OgF8JScYDcM=
X-Google-Smtp-Source: ACHHUZ7ImFqqYJ9etidekSI7vzGm4O7RZaoJwcEi155Zgh9sJFBVSD0oz0qHjbsPgb44jXoA/A3h5Q==
X-Received: by 2002:a17:903:2307:b0:1b3:e31e:abaa with SMTP id d7-20020a170903230700b001b3e31eabaamr11911728plh.0.1687200047757;
        Mon, 19 Jun 2023 11:40:47 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902989100b001b546440893sm146327plp.235.2023.06.19.11.40.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 11:40:46 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <598247ee-3ff8-8413-274a-7d313c2af324@roeck-us.net>
Date:   Mon, 19 Jun 2023 11:40:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To:     "Limonciello, Mario" <mario.limonciello@amd.com>,
        Baskaran Kannan <Baski.Kannan@amd.com>, babu.moger@amd.com,
        clemens@ladisch.de, jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619165413.806450-1-Baski.Kannan@amd.com>
 <4585ec62-b7bb-9f2a-eee0-07032648e55a@roeck-us.net>
 <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v3] hwmon: (k10temp) Enable AMD3255 Proc to show negative
 temperature
In-Reply-To: <012ea369-52ec-4a7a-ec66-812690d430ad@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 6/19/23 11:02, Limonciello, Mario wrote:
> 
> On 6/19/2023 12:07 PM, Guenter Roeck wrote:
>> On 6/19/23 09:54, Baskaran Kannan wrote:
>>> Industrial processor i3255 supports temperatures -40 deg celcius
>>> to 105 deg Celcius. The current implementation of k10temp_read_temp
>>> rounds off any negative
>>> temperatures to '0'. To fix this, the following changes have been made.
>>> Added a flag 'disp_negative' to struct k10temp_data to support
>>> AMD i3255 processors. Flag 'disp_negative' is set if 3255 processor
>>> is found during k10temp_probe.  Flag 'disp_negative' is used to determine
>>> whether to round off negative temperatures to '0' in k10temp_read_temp.
>>>
>>> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
>>
>> Now you have made changes you were not asked to make, extended the flag
>> to cover a range of processors instead of just i3255, and did not provide
>> a change log nor a comment in the code describing why processors with
>> certain model numbers should display negative temperatures.
>>
> i3255 happens to be one of the industrial processors in family 17h models
> 01h through 08h.  These are potentially used at subzero temperatures and
> so displaying negative numbers makes a lot sense.
> 
> So I think the commit message needs to be be amended to better explain that.
> 
> I guided Kannan against leaving a comment in the code with specific models
> because it either won't age well as other industrial processors are
> introduced or may need to be ping-ponged each time.
> 
That only applies if there is a guarantee that the check does not
inadvertently ends up displaying negative temperatures for other CPUs
which are misconfigured. After all, the current code is just a hack
working around some problem with bad temperatures reported on other CPUs.
Personally I'd rather have a clean fix for that. If/since that is not
available, whatever is done subsequently (including the code suggested here)
is just a hack.

... and if a hack on top of a hack is introduced, we need to make sure that
it does not undo the previous hack.

> But perhaps it should be more generic like:
> 
> /* Industrial processors may be used at sub zero temperatures */
> 

You can not just display negative temperatures for family 0x17h models
0x00..0x07 without explanation. The above needs to be documented.
I fail to understand why a variant of

"i3255 happens to be one of the industrial processors in family 17h models
  01h through 08h.  These are potentially used at subzero temperatures and
  so displaying negative numbers makes a lot sense."

can not be added as comment and description if that is exactly what the code
checks for. Something like

"Family 17h models 01h through 08h are industrial processors with an operational
  temperature of -40°C - 105°C and may be used at subzero temperatures.
  Display negative temperatures for those processors."

makes perfect sense to me. Only of course it is incorrect ...

Model 0x1 was used for the original Zen, and 0x8 is Zen+. 1950X is family 0x17 model
0x01 per cpuinfo, meaning your hack undoes the original hack, and the bad
temperatures would again be displayed for the affected systems. That is simply
unacceptable.

Yes, it may be a pain to find an acceptable hack to solve the problem,
but after all this is a self-inflicted problem, so it can't be helped.
The alternative would always be to find a better means to identify CPUs
affected by the original problem. If that is not possible, explicitly listing CPUs
which are _not_ affected is the only possible alternative.

Note that the code sets disp_negative for model numbers < 0x8, meaning it
does not include model 0x8. It also sets disp_negative for model 0x00 which is
specifically excluded above.

All that is no excuse for not providing change logs.

Guenter

>> Guenter
>>
>>> ---
>>>   drivers/hwmon/k10temp.c | 8 ++++++--
>>>   1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
>>> index 7b177b9fbb09..2613420d43ff 100644
>>> --- a/drivers/hwmon/k10temp.c
>>> +++ b/drivers/hwmon/k10temp.c
>>> @@ -86,6 +86,7 @@ struct k10temp_data {
>>>       u32 show_temp;
>>>       bool is_zen;
>>>       u32 ccd_offset;
>>> +    bool disp_negative;
>>>   };
>>>     #define TCTL_BIT    0
>>> @@ -204,12 +205,12 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>>           switch (channel) {
>>>           case 0:        /* Tctl */
>>>               *val = get_raw_temp(data);
>>> -            if (*val < 0)
>>> +            if (*val < 0 && !data->disp_negative)
>>>                   *val = 0;
>>>               break;
>>>           case 1:        /* Tdie */
>>>               *val = get_raw_temp(data) - data->temp_offset;
>>> -            if (*val < 0)
>>> +            if (*val < 0 && !data->disp_negative)
>>>                   *val = 0;
>>>               break;
>>>           case 2 ... 13:        /* Tccd{1-12} */
>>> @@ -405,6 +406,9 @@ static int k10temp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>>>       data->pdev = pdev;
>>>       data->show_temp |= BIT(TCTL_BIT);    /* Always show Tctl */
>>>   +    if (boot_cpu_data.x86 == 0x17 && boot_cpu_data.x86_model < 0x8)
>>> +        data->disp_negative = true;
>>> +
>>>       if (boot_cpu_data.x86 == 0x15 &&
>>>           ((boot_cpu_data.x86_model & 0xf0) == 0x60 ||
>>>            (boot_cpu_data.x86_model & 0xf0) == 0x70)) {
>>

