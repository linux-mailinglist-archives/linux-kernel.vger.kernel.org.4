Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA4B728812
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 21:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjFHTSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 15:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbjFHTSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 15:18:42 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF9730FD;
        Thu,  8 Jun 2023 12:18:02 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-517ab9a4a13so46098a12.1;
        Thu, 08 Jun 2023 12:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686251880; x=1688843880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Zdtq3aechG9dWaWO6P+uzqtp9QxJlC9wiqaNRVmaUg=;
        b=FveTNjkQlBUCVuzZ64Qc21p/NHhCXTszPNygCXI2yd7utlbXxWQqmtqHDjXbn8S1Ae
         aEGM9Dk1WOgTdYWXKpAG/7Z5XuSZKRz3dUfOVx20DFmoxrBnKndoKljJ5VIVArr3TYyL
         GoHOe7+O9tfQe7z28smkvl1AVXM5vtrfGI1l19o7oM7Se3RZcZcu3Vy9r1iRCvNgcPRL
         gYRaW0VLl4grfGGVOfWUV9cDw9tbVLNryyakhiW9L2eBd1XGjNZ70TB4Y8Jd5hiAtvgF
         dqAjBIo5JBOZxzf9/5ExLkWBCt8gc9ZkolUPnrC5lWExJY7O/G/mzLnq9y9F+jjBzman
         kSqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686251880; x=1688843880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Zdtq3aechG9dWaWO6P+uzqtp9QxJlC9wiqaNRVmaUg=;
        b=ecApMxflQsuUyJVsemtyxoU+9Bax4XXBnRLT+Hq4mR+8KfUpfr//ThXxtsfRd4bxmd
         hYzOdG8nzuxdBbgagbP0WC9i/TX8orPa8Qpo67e4evKRt+f/5Rq3jWM8TTeazoUcFdQL
         afJQ1kb0ClHrm2PgOsVO7fnAY4d/ApI1Sa5Zy1nno958Skjm+qt322TKelJDJcamaXs5
         PKi4G7X3ib+wY1kub/4j88o+KCJAFuQlPNvpR7Nprgqv9+f/XHR2hoEv3WOJwwtBmh1P
         GzBGt1BfAnIs5JKddhviuLzyaeoTQLJPtHyhogsMX/gep7wmSy/d8qu07zQmaxut5KT4
         0W0w==
X-Gm-Message-State: AC+VfDxChDjKTXyLGDf2AeVxIp/agfDUQ+Rbl0Mcfzp19qWJ5b/9CUMq
        CEd7C/nLpAmwaoV74HUB9mVYk56U+kU=
X-Google-Smtp-Source: ACHHUZ7gEhJ6hXamB11rpXUigFXAHcI7UOZo3lopmVVFwyYsvG8shxCV1Ur1cL0JFwtbsXmv0+EXnQ==
X-Received: by 2002:a17:902:db0f:b0:1b0:4bc7:31ee with SMTP id m15-20020a170902db0f00b001b04bc731eemr9740751plx.32.1686251880078;
        Thu, 08 Jun 2023 12:18:00 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c11500b001ae365072ccsm1771361pli.122.2023.06.08.12.17.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 12:17:59 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <581d8c60-e3f8-ac3d-55d2-93bb42c34aa1@roeck-us.net>
Date:   Thu, 8 Jun 2023 12:17:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures
To:     "Kannan, Baski" <Baski.Kannan@amd.com>
Cc:     "Moger, Babu" <Babu.Moger@amd.com>,
        "clemens@ladisch.de" <clemens@ladisch.de>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Ramayanam, Pavan" <Pavan.Ramayanam@amd.com>
References: <20230523204932.2679-1-Baski.Kannan@amd.com>
 <68c53a76-efd5-42da-af98-442bd80c7300@roeck-us.net>
 <64e6164a-c874-403e-b899-45f741db2130@roeck-us.net>
 <CY5PR12MB64326FB8A8E84A2698FEBB4D8450A@CY5PR12MB6432.namprd12.prod.outlook.com>
 <866a6d6b-c75e-26d7-a323-f8840c1228c3@roeck-us.net>
 <CY5PR12MB6432845EE4F8019062837FB88450A@CY5PR12MB6432.namprd12.prod.outlook.com>
Content-Language: en-US
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CY5PR12MB6432845EE4F8019062837FB88450A@CY5PR12MB6432.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/8/23 11:25, Kannan, Baski wrote:
> [AMD Official Use Only - General]
> 
> To not spawn any new problems, we can go ahead with option 2.  i.e., "do not apply it to processors which are known to _not_ be affected by the problem."
> 

Sounds good to me.

Guenter

> Thanks
> - Baski
> 
> -----Original Message-----
> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
> Sent: Thursday, June 8, 2023 1:03 PM
> To: Kannan, Baski <Baski.Kannan@amd.com>
> Cc: Moger, Babu <Babu.Moger@amd.com>; clemens@ladisch.de; jdelvare@suse.com; linux-hwmon@vger.kernel.org; linux-kernel@vger.kernel.org; Ramayanam, Pavan <Pavan.Ramayanam@amd.com>
> Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures
> 
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> On 6/8/23 10:09, Kannan, Baski wrote:
>> [AMD Official Use Only - General]
>>
>> The patch you have mentioned, aef17ca12719, sounds like a work-around for a problem found in some Ryzen Threadripper processors.
>> If I understand correctly, this work-around (aef17ca12719) has been provided as a blanket fix for all the processors.
>>
> 
> Due to lack of better knowledge and understanding, yes. See https://github.com/lm-sensors/lm-sensors/issues/70. That doesn't mean that a blanket revert would be appropriate.
> 
>> The Industrial Processor in question is the Epyc3k i3255.
>> AMD Family 17h (boot_cpu_data.x86)
>> AMD model 00h - 0fh (boot_cpu_data.x86_model) Model Name - contains
>> string "3255"
>>
>> It supports temperature ranging from -40 degree Celsius to 105 deg Celsius.
>> We have customers' machines running at -20 deg Celsius. They require that the correct temperature be passed to their tools.
>>
> 
> We have two options: Either limit the workaround to the list of processors which may be affected by the original problem, or do not apply it to processors which are known to _not_ be affected by the problem. Either can easily be implemented by adding a flag to struct k10temp_data and setting it in the probe function.
> 
> No one outside AMD knows which processors may or may not be affected by the original problem. It was reported on 1950X at the time, but it may exist on all processors with the ability to set Sense MI Skew (and possibly Sense MI Offset), whatever that is. With that in mind, the fix will have to be provided by AMD.
> 
> Guenter
> 
>> -----Original Message-----
>> From: Guenter Roeck <groeck7@gmail.com> On Behalf Of Guenter Roeck
>> Sent: Thursday, June 8, 2023 8:52 AM
>> To: Kannan, Baski <Baski.Kannan@amd.com>
>> Cc: Moger, Babu <Babu.Moger@amd.com>; clemens@ladisch.de;
>> jdelvare@suse.com; linux-hwmon@vger.kernel.org;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] hwmon: (k10temp) Report negative temperatures
>>
>> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>>
>>
>> On Tue, May 23, 2023 at 02:46:46PM -0700, Guenter Roeck wrote:
>>> On Tue, May 23, 2023 at 03:49:32PM -0500, Baskaran Kannan wrote:
>>>> Currently, the tctl and die temperatures are rounded off to zero if
>>>> they are less than 0. There are industrial processors which work
>>>> below zero.
>>>
>>> This was introduced with commit aef17ca12719 ("hwmon: (k10temp) Only
>>> apply temperature offset if result is positive"). This patch would
>>> effecively revert that change. Given the reason for introducing it I
>>> am not convinced that it is a good idea to unconditionally revert it.
>>>
>>
>> Any comments ? I am not inclined to accept this patch as-is. What are the industrial processors ? Is there a means to detect them ?
>>
>> Guenter
>>
>>> Guenter
>>>
>>>>
>>>> To display the correct temperature remove the rounding off.
>>>>
>>>> Signed-off-by: Baskaran Kannan <Baski.Kannan@amd.com>
>>>> ---
>>>>    drivers/hwmon/k10temp.c | 4 ----
>>>>    1 file changed, 4 deletions(-)
>>>>
>>>> diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c index
>>>> 7b177b9fbb09..489ad0b1bc74 100644
>>>> --- a/drivers/hwmon/k10temp.c
>>>> +++ b/drivers/hwmon/k10temp.c
>>>> @@ -204,13 +204,9 @@ static int k10temp_read_temp(struct device *dev, u32 attr, int channel,
>>>>               switch (channel) {
>>>>               case 0:         /* Tctl */
>>>>                       *val = get_raw_temp(data);
>>>> -                   if (*val < 0)
>>>> -                           *val = 0;
>>>>                       break;
>>>>               case 1:         /* Tdie */
>>>>                       *val = get_raw_temp(data) - data->temp_offset;
>>>> -                   if (*val < 0)
>>>> -                           *val = 0;
>>>>                       break;
>>>>               case 2 ... 13:          /* Tccd{1-12} */
>>>>
>>>> amd_smn_read(amd_pci_dev_to_node_id(data->pdev),
>>>> --
>>>> 2.25.1
>>>>
> 

