Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C80B681209
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237497AbjA3OSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:18:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237436AbjA3ORe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:17:34 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51D43E60D
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:17:05 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id 141so7746643pgc.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mRwdu/dL23sAX4GUbLudkiV8yolykSJAycZpmDdjnSs=;
        b=HqvfqH9bQzTp8HwQsEAvnNdSvs1y78eyVrB0kTZw6Vl9UD7EEDgvG9xM73S6GXdjW9
         VI/ZiLzWZ/7Q4hZKZWooQR02UCvBVC1NF5yJ0+cJPF1XgrdeoMitvUUYbquAddApZx4l
         TOf5k7cxxe1AqZcuDzrHvyPwY6tF6qFK+3D5xAJymR3xhZzgdsrRY1Q3ioTCqWEnAahC
         SA94rqZZVuSE/pYZHU0nITly+3CQSaljUyWYm5DDjwyXsUghLpv7hCa9UrfAhveYgxiJ
         2ulf+25vA3/uJEz2iU7mOpmOh6sSEnyFTj5Ej/R7tyeKtpUfHiUdT3CMWFUDtIDxnNZK
         HWmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mRwdu/dL23sAX4GUbLudkiV8yolykSJAycZpmDdjnSs=;
        b=kNTnD3Q087bZk6fzPTp20FEmQ1otpg/iOi8aqYBc/rcwB66wpwN5JaGuBh79dxH4Cx
         mnlZLQjPiE/k8BLRd6gcQxiu+5ugJG/MemFM4ao+8D2w67rIU5MU/ZRQevFxwZB63m9f
         JdxZ71zTVtRvLBQDYi3G8LVJXF3Dzf/6iAEQWBhCtuIZbo+wkhZRVz9tBl6oxPiq9s+g
         1GLpBkMLHJA7KAuxsO8/VR7pgApF+nRUNUrbsOnJ0TJ2gTZimdzBLC8FnPU1rGaIF5NG
         xTK+U0lTV048FRuFGAvn0ObJzOyYpdmf1cKOIPRofT6A2LtH7f3VOUki9HPoTaCT+TaV
         1xPg==
X-Gm-Message-State: AFqh2kr8wgIFhKPnI96gN4Ek2iurh2YGqsz87jCauOweOXv2677Jj6e0
        t6BJPkyobiT97XE47rMFA7Q=
X-Google-Smtp-Source: AMrXdXu0MJlQDCJ/dCJBjtavv4sf3AZYd3C1pvb0fPN5ftVGm1U9l483FcC/b32mt1cuB8r9zulu6A==
X-Received: by 2002:a05:6a00:f91:b0:583:319a:4413 with SMTP id ct17-20020a056a000f9100b00583319a4413mr49510062pfb.24.1675088224838;
        Mon, 30 Jan 2023 06:17:04 -0800 (PST)
Received: from [172.30.1.94] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id p25-20020aa78619000000b00592d16e9a12sm5931908pfn.135.2023.01.30.06.17.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Jan 2023 06:17:03 -0800 (PST)
Message-ID: <d2b63765-d497-8938-95f0-68d0cc4c2efd@gmail.com>
Date:   Mon, 30 Jan 2023 23:17:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
Content-Language: en-US
To:     Andrew Lien/WHQ/Wistron <Andrew_Lien@wistron.com>,
        "myungjoo.ham@samsung.com" <myungjoo.ham@samsung.com>
Cc:     "cw00.choi@samsung.com" <cw00.choi@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230110023656.1334114-1-andrew_lien@wistron.com>
 <dc62d036-dcab-532b-1c3c-fbebcd1705fa@gmail.com>
 <SEYPR02MB62308AE65824DC7F372EFCA585FC9@SEYPR02MB6230.apcprd02.prod.outlook.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <SEYPR02MB62308AE65824DC7F372EFCA585FC9@SEYPR02MB6230.apcprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
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

On 23. 1. 11. 18:00, Andrew Lien/WHQ/Wistron wrote:
> Sorry I didn't describe it in detail enough
> 
> we have a standalone driver to do battery detection, this driver is separate from power_supply device driver
> and not just report uevet to userspace, we also need a method to notify other kernel driver "battery removal event"

As I commented, it is not good to detect the battery status by extcon
which only handle the external connector.
It means that you just try to use extcon subsystem to support 'publisher - subscriber'.


> it will be better if using same battery detection driver to support different platform charger driver.
> 
> by the way, swappable battery usually have 4 pin connector (power / ground / ID / THERMAL)
> you can find some phone that support battery swap feature (like Samsung xcover 6 pro)
> 
> -----Original Message-----
> From: Chanwoo Choi <cwchoi00@gmail.com> 
> Sent: Tuesday, January 10, 2023 9:40 PM
> To: Andrew Lien/WHQ/Wistron <Andrew_Lien@wistron.com>; myungjoo.ham@samsung.com
> Cc: cw00.choi@samsung.com; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] extcon: Add EXTCON_BATTERY type for battery presence
> 
> On 23. 1. 10. 11:36, andrew lien/WHQ/Wistron wrote:
>> This information can be useful to device that support battery swap, 
>> for example allowing them to indicate that a battery is present or 
>> not, so provide a standard way to report it to userspace.
>>
>> Signed-off-by: andrew lien/WHQ/Wistron <andrew_lien@wistron.com>
>> ---
>>  drivers/extcon/extcon.c | 5 +++++
>>  include/linux/extcon.h  | 3 ++-
>>  2 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/extcon/extcon.c b/drivers/extcon/extcon.c index 
>> b4df4372f097..6c47d23244c3 100644
>> --- a/drivers/extcon/extcon.c
>> +++ b/drivers/extcon/extcon.c
>> @@ -184,6 +184,11 @@ static const struct __extcon_info {
>>  		.id = EXTCON_MECHANICAL,
>>  		.name = "MECHANICAL",
>>  	},
>> +	[EXTCON_BATTERY] = {
>> +		.type = EXTCON_TYPE_MISC,
>> +		.id = EXTCON_BATTERY,
>> +		.name = "BATTERY",
>> +	},
>>  
>>  	{ /* sentinel */ }
>>  };
>> diff --git a/include/linux/extcon.h b/include/linux/extcon.h index 
>> b0b4abb018ee..88210b481b6c 100644
>> --- a/include/linux/extcon.h
>> +++ b/include/linux/extcon.h
>> @@ -81,8 +81,9 @@
>>  #define EXTCON_DOCK		60
>>  #define EXTCON_JIG		61
>>  #define EXTCON_MECHANICAL	62
>> +#define EXTCON_BATTERY		63
>>  
>> -#define EXTCON_NUM		63
>> +#define EXTCON_NUM		64
>>  
>>  /*
>>   * Define the properties of supported external connectors.
> 
> Actually, battery is not external connector. The power_supply subsystem already provided the POWER_SUPPLY_PROP_PRESENT for the battery present. You have to develop the power_supply device driver and then use power_supply_changed() to send the uevent to user-space.
> 
> --
> Best Regards,
> Samsung Electronics
> Chanwoo Choi
> 
> 
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------
> This email contains confidential or legally privileged information and is for the sole use of its intended recipient.
> Any unauthorized review, use, copying or distribution of this email or the content of this email is strictly prohibited.
> If you are not the intended recipient, you may reply to the sender and should delete this e-mail immediately.
> ---------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

