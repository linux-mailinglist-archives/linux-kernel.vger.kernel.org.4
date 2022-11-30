Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C341E63DCF9
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiK3SSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:18:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiK3SS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:18:28 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E79E48B18D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:15:46 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id p24so13760547plw.1
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 10:15:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b8+YUW8IoQswmuMtdhdkn+d1eF5AcajDOuojCzbgsEU=;
        b=G0j6AHMPujpDINPRxOUW9PTmd2uWuBAU22bXh38+amwbsgPA+NYSlTus8ZthZiQaM2
         19AlGyLHN/JdYzafNIZ0LaAzgslQA4Dr41+oNXqaELVmz9YlYJ6Jgl0X+vrr8FlNCx6a
         QOhr+kHg/duBzAxXOtks3nhwmSYn222ZvBdpgyfRYp19Y9DdScn7EsmNxOLVbMeRnkkO
         Goi4ngxrd1dZaKh7zA4WgpviUL73qpFZgGdKgSCpSQC12mXuAGgCs+HFXLKFUpc4j/HK
         F8xyNwwtFCP7VtwEI7fphg0Dunvca+w3f43avdP8MNl/BKX1x3ea5/yAQBuEWyf/lMUg
         q20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b8+YUW8IoQswmuMtdhdkn+d1eF5AcajDOuojCzbgsEU=;
        b=F8qH0Kit+3GQ4Ko8m44pGqRGqB7U6HYXQQMgE5VsbdMcbwJRr0pzWEAOP92LDdb5Xz
         mwFSZTE1NzAZw3UTxlbcdXZi5XIRD7Ar51XHy6RK9keytPV0WB9ZbiDHW0LlI1W83Dma
         MPACXgsg0nbea+OKEB+xxPviDn71UL19Kl1hy/ZzBexALWE6M5nEhoPHMEhiXqlugbFO
         frgdRADe8mkvIJOt8WOdlaFo7HrRqB54jHzpoqnK3Lgl5rqCx1X5S6R32+GFethhLv5c
         7hTN6b7VFuA7y/Ke27FqP4KQrKRixc/szoPrJqBFfxvtJYt2+3gv2FIjjDk17jZgod9v
         CL1Q==
X-Gm-Message-State: ANoB5pmuo7bdfzgzd2g5Bww8DmP4ybhNf8nK+kO4krfLHfwT+iZjw5e+
        jxyU9h5xqKNNm2P9hSERgYJZgg==
X-Google-Smtp-Source: AA0mqf48TjmAXu+jpc3e/rI7CPXhjzNwcdUtxnM6qB/duICSa9sL2vxBQH126jRYczO2eK2oQNKu/g==
X-Received: by 2002:a17:902:e0cd:b0:189:b0a3:cf49 with SMTP id e13-20020a170902e0cd00b00189b0a3cf49mr410437pla.77.1669832146091;
        Wed, 30 Nov 2022 10:15:46 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id d8-20020a170902cec800b001867fb4056asm1791268plg.32.2022.11.30.10.15.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 10:15:45 -0800 (PST)
Message-ID: <e05aec1c-d305-1281-91c2-1d3e1f3ae912@9elements.com>
Date:   Wed, 30 Nov 2022 23:45:42 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 1/4] hwmon: (pmbus/core): Update regulator flag map
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
References: <20221130165833.3478555-1-Naresh.Solanki@9elements.com>
 <20221130165833.3478555-2-Naresh.Solanki@9elements.com>
 <20221130180910.GB2656856@roeck-us.net>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <20221130180910.GB2656856@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30-11-2022 11:39 pm, Guenter Roeck wrote:
> On Wed, Nov 30, 2022 at 05:58:29PM +0100, Naresh Solanki wrote:
>> Add regulator flag map for PMBUS status byte & status input.
>>
> 
> Now you lost me. Two 1/4 patches with overlapping and different
> content ???
> 
This patch wasn't suppose to be. will check what went wrong & avoid 
these overlap in future.
> Guenter
> 
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
>>   drivers/hwmon/pmbus/pmbus_core.c | 30 ++++++++++++++++++++++--------
>>   1 file changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
>> index 95e95783972a..f5caceaaef2a 100644
>> --- a/drivers/hwmon/pmbus/pmbus_core.c
>> +++ b/drivers/hwmon/pmbus/pmbus_core.c
>> @@ -2752,6 +2752,15 @@ struct pmbus_regulator_status_category {
>>   
>>   static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] = {
>>   	{
>> +		.func = -1,
>> +		.reg = PMBUS_STATUS_BYTE,
>> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
>> +			{ PB_STATUS_IOUT_OC,   REGULATOR_ERROR_OVER_CURRENT },
>> +			{ PB_STATUS_VOUT_OV,   REGULATOR_ERROR_REGULATION_OUT },
>> +			{ PB_STATUS_VIN_UV,    REGULATOR_ERROR_UNDER_VOLTAGE },
>> +			{ },
>> +		},
>> +	}, {
>>   		.func = PMBUS_HAVE_STATUS_VOUT,
>>   		.reg = PMBUS_STATUS_VOUT,
>>   		.bits = (const struct pmbus_regulator_status_assoc[]) {
>> @@ -2768,6 +2777,7 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>   			{ PB_IOUT_OC_WARNING,    REGULATOR_ERROR_OVER_CURRENT_WARN },
>>   			{ PB_IOUT_OC_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>   			{ PB_IOUT_OC_LV_FAULT,   REGULATOR_ERROR_OVER_CURRENT },
>> +			{ PB_POUT_OP_FAULT,      REGULATOR_ERROR_OVER_CURRENT },
>>   			{ },
>>   		},
>>   	}, {
>> @@ -2778,6 +2788,18 @@ static const struct pmbus_regulator_status_category pmbus_regulator_flag_map[] =
>>   			{ PB_TEMP_OT_FAULT,      REGULATOR_ERROR_OVER_TEMP },
>>   			{ },
>>   		},
>> +	}, {
>> +		.func = PMBUS_HAVE_STATUS_INPUT,
>> +		.reg = PMBUS_STATUS_INPUT,
>> +		.bits = (const struct pmbus_regulator_status_assoc[]) {
>> +			{ PB_IIN_OC_FAULT,       REGULATOR_ERROR_OVER_CURRENT },
>> +			{ PB_IIN_OC_WARNING,     REGULATOR_ERROR_OVER_CURRENT_WARN },
>> +			{ PB_VOLTAGE_UV_FAULT,   REGULATOR_ERROR_UNDER_VOLTAGE },
>> +			{ PB_VOLTAGE_UV_WARNING, REGULATOR_ERROR_UNDER_VOLTAGE_WARN },
>> +			{ PB_VOLTAGE_OV_WARNING, REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>> +			{ PB_VOLTAGE_OV_FAULT,   REGULATOR_ERROR_OVER_VOLTAGE_WARN },
>> +			{ },
>> +		},
>>   	},
>>   };
>>   
>> @@ -2834,14 +2856,6 @@ static int pmbus_regulator_get_error_flags(struct regulator_dev *rdev, unsigned
>>   		if (status & PB_STATUS_POWER_GOOD_N)
>>   			*flags |= REGULATOR_ERROR_REGULATION_OUT;
>>   	}
>> -	/*
>> -	 * Unlike most other status bits, PB_STATUS_{IOUT_OC,VOUT_OV} are
>> -	 * defined strictly as fault indicators (not warnings).
>> -	 */
>> -	if (status & PB_STATUS_IOUT_OC)
>> -		*flags |= REGULATOR_ERROR_OVER_CURRENT;
>> -	if (status & PB_STATUS_VOUT_OV)
>> -		*flags |= REGULATOR_ERROR_REGULATION_OUT;
>>   
>>   	/*
>>   	 * If we haven't discovered any thermal faults or warnings via
>>
>> base-commit: 9494c53e1389b120ba461899207ac8a3aab2632c
>> -- 
>> 2.37.3
>>

Regards,
Naresh
