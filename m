Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0CE6D39C8
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 20:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjDBSWl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 14:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjDBSWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 14:22:39 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B007D8A71
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 11:22:38 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id i5-20020a05600c354500b003edd24054e0so18439460wmq.4
        for <linux-kernel@vger.kernel.org>; Sun, 02 Apr 2023 11:22:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680459757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qQ7cV2QrQ0t06/mixdh3yXEE4i1+hMwYh5eUdnobqIY=;
        b=SnqroAysuuy6fCAhOqM/pte7g0pC57vqLd9iMHOo+QmBJPZP+vSIO8n/7zpnrpkiHd
         Xx5EOZpzD4o2kYL+pIIT5o6KqSjrqpjI0cOMy+8mvnnU3/CgdwPGOdcmlD5tfrROu73U
         V9y/A7xxeWl+uB35So+Sbnqc93imltGIIhhZ1/tyWDsXyT96fBVVcw+xsA/lmA8K9kG0
         l8Y4K0sgbF/AyAc/+1DmdxLVWLjw8PeBOB+6rTdWr3z9EiWv9Vs7jdnksFXVhya71sPJ
         htPabrudLs0S4DJDFgLK3DD/0yAred5HK+QbbszXlGlrqOyNDtDASOpnrvxSO2Vm/3DB
         gDOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680459757;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qQ7cV2QrQ0t06/mixdh3yXEE4i1+hMwYh5eUdnobqIY=;
        b=j+tBVdbZkwqwFPdefZhV+cxsimybWOT2eSAdbQfQAcEXYDWIiNgyhslQObAM8E0VhJ
         LIcJq4HXJkQ6DffqY9GTdkPwmFq2o3zXAzFyLLkqopSsr3ar+58TwDH7fn95dfLg8xk8
         qXEesAZBiWRzmqdaJiUrxS2OWCZQXOn976/GOrfTwpq93OnbCWj5w3CfTfSK6t4r2x8P
         2Ib7+0p2QZt6eCMgOh0qK7BtzsSzer/1IMCfygwZmW5APIOdCxvYV2DYSkER7c9w2nfY
         moSI9DtGKyEoyjsyM3ngXSMoa8Qn79U6s36v4fh4a8g2a/WAI4eKxjrMeUGOwSfqujkb
         7Kfw==
X-Gm-Message-State: AO0yUKVUfjbAhJd5mTo3N2P+VG+2mQg/GkDM7irSNuY9EY35NtKwTOez
        M7xmQ7o9sBxt3uVhR3u0zZBLFmY1kMKmHQ==
X-Google-Smtp-Source: AK7set+XRX11PiiYSdo892GnW8rwV0ktJWvZ8PvO8hWxBuyWKFXwQRLG7CCMvUCZBO4lOuifVNtIVA==
X-Received: by 2002:a05:600c:2157:b0:3ed:cf2a:3fe8 with SMTP id v23-20020a05600c215700b003edcf2a3fe8mr26406192wml.8.1680459756820;
        Sun, 02 Apr 2023 11:22:36 -0700 (PDT)
Received: from ?IPV6:2a0c:5a82:e704:7800:4aa3:3ca0:c843:43e3? ([2a0c:5a82:e704:7800:4aa3:3ca0:c843:43e3])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bcb89000000b003ed4f6c6234sm9743571wmi.23.2023.04.02.11.22.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Apr 2023 11:22:36 -0700 (PDT)
Message-ID: <0af15115-9641-a1c8-f398-c4e8e77379a3@gmail.com>
Date:   Sun, 2 Apr 2023 20:22:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] staging: greybus: loopback: fix up checkpath macro do
 while error.
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bryan O'Donoghue <pure.logic@nexus-software.ie>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230402122550.70682-1-angelalbertoc.r@gmail.com>
 <2023040252-racoon-daintily-3589@gregkh>
From:   =?UTF-8?Q?=c3=81ngel_Alberto_Carretero?= 
        <angelalbertoc.r@gmail.com>
In-Reply-To: <2023040252-racoon-daintily-3589@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/04/2023 15:16, Greg Kroah-Hartman wrote:
> On Sun, Apr 02, 2023 at 02:25:51PM +0200, Angel Alberto Carretero wrote:
>> Wrap macro in a do-while statement.
>>
>> Signed-off-by: Angel Alberto Carretero <angelalbertoc.r@gmail.com>
>> ---
>>   drivers/staging/greybus/loopback.c | 8 +++++---
>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
>> index d7b39f3bb652..371809770ed0 100644
>> --- a/drivers/staging/greybus/loopback.c
>> +++ b/drivers/staging/greybus/loopback.c
>> @@ -162,9 +162,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
>>   static DEVICE_ATTR_RO(name##_avg)
>>   
>>   #define gb_loopback_stats_attrs(field)				\
>> -	gb_loopback_ro_stats_attr(field, min, u);		\
>> -	gb_loopback_ro_stats_attr(field, max, u);		\
>> -	gb_loopback_ro_avg_attr(field)
>> +	do {		\
>> +		gb_loopback_ro_stats_attr(field, min, u);		\
>> +		gb_loopback_ro_stats_attr(field, max, u);		\
>> +		gb_loopback_ro_avg_attr(field);		\
>> +	} while (0)
>>   
>>   #define gb_loopback_attr(field, type)					\
>>   static ssize_t field##_show(struct device *dev,				\
>> -- 
>> 2.40.0
>>
>>
> 
> Any specific reason why you did not test build your change before
> submitting it?
> 
> thanks,
> 
> greg k-h

Apologies, we can drop the patch. I was trying to find an error as part
of the eudyptula challenge and thought I was compiling the driver
correctly. Upon further examination, the macro cannot be written with a
do-while because it is defining functions.
