Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90B146DB6CF
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:07:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjDGXHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjDGXHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:07:07 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88698E1A2;
        Fri,  7 Apr 2023 16:06:37 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso47051209fac.12;
        Fri, 07 Apr 2023 16:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680908791; x=1683500791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=IX63rEBC8yST4gwErZr+yYucTJmibL48v0X7LDgsSeI=;
        b=k/OjhypfQ8SVpBAlqt9pNtAyNUPLbSyLPiBTFTv8uzeYVarnyyQYc3vS396YJOyz/k
         w5pXWPKcaa/hDcjVlynRjZEujcmVfArwxlBrlvkctAX7OI53qTL44FoiqpLxLFaBiMjL
         pgb94hKz2gJOLmvvWR/w9/8lYDevHpFJo/f1Pievnkw+FYImwzMVusWKbfj7C6Pf6xWX
         GOJJgUhJdMbUeIvGeCBZ50MVXToe7W3Nujr10pBm6tYTSohmq3tnR//2inkBRpM28NVO
         YxlW97raG2g9raDCHn0T2y05KxtJ0odDh9xdJJIQaiUR8Q8Kb0/UGnGcpUGxcjUzPPWi
         5Jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680908791; x=1683500791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IX63rEBC8yST4gwErZr+yYucTJmibL48v0X7LDgsSeI=;
        b=se1zUwp31BakflexBW6heNysnr5rEa/7Dgeqtu26cWQhrd+ydnYwN6zBn9nHwpjzja
         UbcYVnWxPLJAP257azSZaNkJHZAQQE8Q0E7DLzkyp+Lrvm2WYtL4qHn9spn7BTJcH4oE
         yLrnUOL3G/3qLop+FfBjvmhlSy1pGg442gLRzVSbx6rsjht8upMgKRDXi1qS89qv/2Kq
         PlYvMrk3UBcVakfN3CTMEIX/J0oBX/F9h6XrrO5rtqHUTA+F/FLTEMfk31tsOI8sssXw
         o4R/RDqDgqNGnYV1IxD5MEiBJeMA+EOPIA41Qb5+FmvrRpIPjFfYwsuWIAC6FLLYP3zh
         P5Xw==
X-Gm-Message-State: AAQBX9fwx5WtWJ9K6d9vSMk+il1SOJbMqQLAuCicigghWsS374im74oc
        zAx2x01/pAuu6IgtG4JgMiqEW6hteDs=
X-Google-Smtp-Source: AKy350ZOJ2Vc6ZERDWBz4XYhpAziCXkGoVQVZfpeHosNQaPExTS0rpW4+JmPDsBMkPcJuwN4JtA7DQ==
X-Received: by 2002:a05:6870:f104:b0:180:3225:b33b with SMTP id k4-20020a056870f10400b001803225b33bmr2352149oac.34.1680908791249;
        Fri, 07 Apr 2023 16:06:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v5-20020a0568301bc500b006a2fd720f82sm2086120ota.7.2023.04.07.16.06.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 16:06:30 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <b88f2a0b-41fc-0cf7-5088-64edcd9dd927@roeck-us.net>
Date:   Fri, 7 Apr 2023 16:06:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] power: supply: hwmon: constify pointers to
 hwmon_channel_info
Content-Language: en-US
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org
References: <20230407150326.80183-1-krzysztof.kozlowski@linaro.org>
 <20230407221250.xt2e7yuj62rlotkd@mercury.elektranox.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230407221250.xt2e7yuj62rlotkd@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 15:12, Sebastian Reichel wrote:
> Hi,
> 
> On Fri, Apr 07, 2023 at 05:03:26PM +0200, Krzysztof Kozlowski wrote:
>> Statically allocated array of pointed to hwmon_channel_info can be
>> made const for safety.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>> This depends on hwmon core patch:
>> https://lore.kernel.org/all/20230406203103.3011503-2-krzysztof.kozlowski@linaro.org/
>>
>> Therefore I propose this should also go via hwmon tree.
>>

I am not going to apply patches for 10+ subsystems through the hwmon tree.
This can only result in chaos. The dependent patch is available at

git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-const

or wait until after the next commit window to apply this patch.

Thanks,
Guenter

>> Cc: Jean Delvare <jdelvare@suse.com>
>> Cc: Guenter Roeck <linux@roeck-us.net>
>> Cc: linux-hwmon@vger.kernel.org
>> ---
> 
> Acked-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> 
> -- Sebastian
> 
>>   drivers/power/supply/power_supply_hwmon.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/power/supply/power_supply_hwmon.c b/drivers/power/supply/power_supply_hwmon.c
>> index a48aa4afb828..c97893d4c25e 100644
>> --- a/drivers/power/supply/power_supply_hwmon.c
>> +++ b/drivers/power/supply/power_supply_hwmon.c
>> @@ -293,7 +293,7 @@ static const struct hwmon_ops power_supply_hwmon_ops = {
>>   	.read_string	= power_supply_hwmon_read_string,
>>   };
>>   
>> -static const struct hwmon_channel_info *power_supply_hwmon_info[] = {
>> +static const struct hwmon_channel_info * const power_supply_hwmon_info[] = {
>>   	HWMON_CHANNEL_INFO(temp,
>>   			   HWMON_T_LABEL     |
>>   			   HWMON_T_INPUT     |
>> -- 
>> 2.34.1
>>

