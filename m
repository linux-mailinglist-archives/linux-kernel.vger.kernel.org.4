Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DCE624799
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 17:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbiKJQvO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 11:51:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiKJQup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 11:50:45 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289DF1DF3B;
        Thu, 10 Nov 2022 08:50:42 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ft34so6398121ejc.12;
        Thu, 10 Nov 2022 08:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZWV67B6alYbPDBfIDJzo+F5jWH3ktGf/svUGpkzU1o=;
        b=Xcdnjz6PpPgZNdEYI55R0lYRpIuuI93/wdvwEvUrYo8SxMXlTOORoPNAHo/r7i4kWk
         PgIHodj9S/Srlg/u4RaDxONlJVOjKmQADW5BYmRIKpBClBGNEHMOBSDwJCekZ1JIkP2f
         E0lgP4e5BGyXD4NgdIvk7hsz5Q/GslroolyKATNiQLHaxpfyCU0vBRvSR+cuI942ReNR
         I+KnaPJmLT4sas9rNXJ9E6DGoQzUUlUcQpcUUpyOZlynrTRFWZFRm/yiFU9ml5LDMZp3
         pdU5YJ2yyPBpff49yTHHhRJj45mYodB/su08FvA1+nl/ulPJNdyHqaKv6tPojBwyaA9S
         Qrxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZWV67B6alYbPDBfIDJzo+F5jWH3ktGf/svUGpkzU1o=;
        b=BTCTO+La1jvh87Mqq9T2e4s6HrhVJ8yjLG8XHFVi5dP1D+GkNVfA0Z/mI1t5qqObnX
         DElNIAYLLfRIegI8k1SJvmBskKUx6mMakBd+3lQRMAO+EOBZ2ZzlaIgA+cRtSNtQ95Wj
         alyR93GQko8+m7cGFbAFi94r9jlxKHjoA0eVG2S2fQA4AhONTGpxE8FGsy1vMUVzXXmp
         KVzi9jzZMFq1RJvi6op6EDeM0Lyse/XUQeFh3lo6V3ZmpUe//UxB1wi8t/eveAUajKLY
         IQ9PhDEMaQu7UYC5INSSwgzwV563aQ1XkBrAjByRNwWi7OPW1SGcSnGf6gZ9nwn9nJ9Z
         hS/A==
X-Gm-Message-State: ACrzQf2t8mpsn7holMUPjR17u3oRNLFB/YBjbgZPHXKnuuaGzvJ+4FPO
        2o6KSwsMVxuyVLOUmXM2RXI=
X-Google-Smtp-Source: AMsMyM5KtzJITMZOcOZzYFimlX+ZjO+mMWu1jP3aNLreLlYYsOwW5Pvb+HaOO39BFhcRYka1iJhxmQ==
X-Received: by 2002:a17:906:2b55:b0:7ad:934f:abc2 with SMTP id b21-20020a1709062b5500b007ad934fabc2mr2926794ejg.690.1668099041009;
        Thu, 10 Nov 2022 08:50:41 -0800 (PST)
Received: from [192.168.1.10] ([46.249.74.23])
        by smtp.googlemail.com with ESMTPSA id 17-20020a170906219100b007add1c4dadbsm7463061eju.153.2022.11.10.08.50.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Nov 2022 08:50:40 -0800 (PST)
Subject: Re: [PATCH 2/3] power: supply: cpcap-battery: Fix battery
 identification
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        tony@atomide.com, philipp@uvos.xyz
References: <1667647544-12945-1-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <1667647544-12945-3-git-send-email-ivo.g.dimitrov.75@gmail.com>
 <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
From:   Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Message-ID: <715a60b5-2f3c-caf7-2b24-61ec92bda9be@gmail.com>
Date:   Thu, 10 Nov 2022 18:50:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20221110160559.bsvzr4txum5ed2qz@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10.11.22 г. 18:05 ч., Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Nov 05, 2022 at 01:25:43PM +0200, Ivaylo Dimitrov wrote:
>> Use the same logic to identify genuine batteries as Android does.
>>
>> Signed-off-by: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
>> ---
> 
> Why do we care?
> 

Because if we know the battery is genuine (or at least pretends to be :) 
), then we can read battery parameters from nvram, see patch 3/3. This 
will allow us to charge HV LiPo batteries to 4.35V, using the full capacity.

Not to say the code currently identifies a specific battery with id of 
"89-500029ba0f73" as genuine one, ignoring all others. So this patch is 
more or less a bugfix too.

Regards,
Ivo


> -- Sebastian
> 
>>   drivers/power/supply/cpcap-battery.c | 19 ++++++++++++++-----
>>   1 file changed, 14 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/power/supply/cpcap-battery.c b/drivers/power/supply/cpcap-battery.c
>> index 8869067..ca6ee2b 100644
>> --- a/drivers/power/supply/cpcap-battery.c
>> +++ b/drivers/power/supply/cpcap-battery.c
>> @@ -422,7 +422,7 @@ static int cpcap_battery_cc_to_ua(struct cpcap_battery_ddata *ddata,
>>   
>>   static int cpcap_battery_match_nvmem(struct device *dev, const void *data)
>>   {
>> -	if (strcmp(dev_name(dev), "89-500029ba0f73") == 0)
>> +	if (strncmp(dev_name(dev), "89-500", 6) == 0)
>>   		return 1;
>>   	else
>>   		return 0;
>> @@ -439,10 +439,19 @@ static void cpcap_battery_detect_battery_type(struct cpcap_battery_ddata *ddata)
>>   	if (IS_ERR_OR_NULL(nvmem)) {
>>   		ddata->check_nvmem = true;
>>   		dev_info_once(ddata->dev, "Can not find battery nvmem device. Assuming generic lipo battery\n");
>> -	} else if (nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
>> -		battery_id = 0;
>> -		ddata->check_nvmem = true;
>> -		dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
>> +	} else {
>> +		char buf[24];
>> +
>> +		if (nvmem_device_read(nvmem, 96, 4, buf) < 0 ||
>> +		    strncmp(buf, "COPR", 4) != 0 ||
>> +		    nvmem_device_read(nvmem, 104, 24, buf) < 0 ||
>> +		    strncmp(buf, "MOTOROLA E.P CHARGE ONLY", 24) != 0 ||
>> +		    nvmem_device_read(nvmem, 2, 1, &battery_id) < 0) {
>> +			battery_id = 0;
>> +			ddata->check_nvmem = true;
>> +			dev_warn(ddata->dev, "Can not read battery nvmem device. Assuming generic lipo battery\n");
>> +		}
>> +
>>   	}
>>   
>>   	switch (battery_id) {
>> -- 
>> 1.9.1
>>
