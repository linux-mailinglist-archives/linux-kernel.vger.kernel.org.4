Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96214679D1C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbjAXPOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:14:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjAXPOX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:14:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00B794709B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:14:21 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id y3-20020a17090a390300b00229add7bb36so14296409pjb.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 07:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsn51J1gH9Yb3IRURvfNBn4uVGd6ILE70cJUebMVeQQ=;
        b=Q8gDf18QgDXYYaQZSvENZiy1uTsmmQMMMQPraGxPJ8qjrBswhk+XuGvVZIezTYGKPU
         B26iJxcYUkLhBW185Nh5nQJaEHQqNkIYZQEpi+uSK/ZmCKosfopKrvsYZm3zLG3Sjttn
         QLO6+IdhFMM/PLaxKSUFKxdcHnLsyzIIYsrhVzc6/jQ6tK50ra2DIoq5k5goyCEnepF4
         GS8y4jsdpE7Xy3VERy2apYd0Pi8fU05z8u9OA8IStcIE+C91PbBL1ApiUPIhjwv1SZD2
         /CRigIiIYRuNt2AV6D+XsTfGxK0sJpAS4sZtwKX1qJH/ush/LMT9FdYIyILsGEG3hVFl
         D+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nsn51J1gH9Yb3IRURvfNBn4uVGd6ILE70cJUebMVeQQ=;
        b=pbU0il/aVgWJWH280evJ5FCxGkjEHEnXkrArLlQbvBumvtyaf7Yiev/F7LSYlewITD
         dA7++Kfceqar/kzvy7YP6Y9rGrMJxL33zpAwfr3jgt+TE92TPXIri0QQs9PoA/AqVo4c
         ZN5fH2E9c0YGHhgVG5UID47FEqEVjBk4/qquTR7o1bZur+7wuTmwTm0jwlgDQOPOgcHx
         wSmy7lHZfetGd2C9R8OLC4KlDlLOICExteVi5t8YSs97rAxSWrjn3Bp7hm5pLrdXB57i
         yaftdgm7mFrXiE51FVtjbjC3ShtNrucWyvoLZE/ibjYYBIJao31af/FvQl3XO3fYSdih
         QN5Q==
X-Gm-Message-State: AFqh2kqbXeJ9E1GaDqn760RFmRpBqwSgnIoeftfMIiGEr6KVFRuvVXFH
        enhhxLE7e6tgYuZ36IPMqSu5TKODnooys/SE9ZGJsw==
X-Google-Smtp-Source: AMrXdXuEW9/o8vSQGT0BvtzSvjWO/BoUrlnvSIRTGHBeH6wdgO9oTlWGGwC7ImfJ3Hj3Xs48+LcV1A==
X-Received: by 2002:a17:90b:3cb:b0:229:2441:53e3 with SMTP id go11-20020a17090b03cb00b00229244153e3mr29157705pjb.39.1674573261368;
        Tue, 24 Jan 2023 07:14:21 -0800 (PST)
Received: from ?IPV6:2405:201:d02f:d899:2028:7962:400:43b6? ([2405:201:d02f:d899:2028:7962:400:43b6])
        by smtp.gmail.com with ESMTPSA id l2-20020a17090ad10200b00218daa55e5fsm1676422pju.12.2023.01.24.07.14.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 07:14:20 -0800 (PST)
Message-ID: <7de492aa-8622-b0d3-f932-2e8d7dcb8704@9elements.com>
Date:   Tue, 24 Jan 2023 20:44:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/2] hwmon: (pmbus/tda38640) Add driver for Infineon
 TDA38640 Voltage Regulator
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        linux-kernel@vger.kernel.org
References: <20230124144847.423129-1-Naresh.Solanki@9elements.com>
 <20230124144847.423129-2-Naresh.Solanki@9elements.com>
 <94176a1b-f9ad-b096-fc39-5e333f4eb09f@linaro.org>
From:   Naresh Solanki <naresh.solanki@9elements.com>
In-Reply-To: <94176a1b-f9ad-b096-fc39-5e333f4eb09f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24-01-2023 08:39 pm, Krzysztof Kozlowski wrote:
> On 24/01/2023 15:48, Naresh Solanki wrote:
>> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>>
>> Add the pmbus driver for the Infineon TDA38640 voltage regulator.
>>
>> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
>> Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
>> ---
> 
> (...)
> 
>> +
>> +#include <linux/err.h>
>> +#include <linux/i2c.h>
>> +#include <linux/init.h>
>> +#include <linux/kernel.h>
>> +#include <linux/module.h>
>> +#include <linux/regulator/driver.h>
>> +#include "pmbus.h"
>> +
>> +static const struct regulator_desc __maybe_unused tda38640_reg_desc[] = {
>> +	PMBUS_REGULATOR("vout", 0),
>> +};
>> +
>> +static struct pmbus_driver_info tda38640_info = {
>> +	.pages = 1,
>> +	.format[PSC_VOLTAGE_IN] = linear,
>> +	.format[PSC_VOLTAGE_OUT] = linear,
>> +	.format[PSC_CURRENT_OUT] = linear,
>> +	.format[PSC_CURRENT_IN] = linear,
>> +	.format[PSC_POWER] = linear,
>> +	.format[PSC_TEMPERATURE] = linear,
>> +
>> +	.func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT
>> +	    | PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP
>> +	    | PMBUS_HAVE_IIN
>> +	    | PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
>> +	    | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT
>> +	    | PMBUS_HAVE_POUT | PMBUS_HAVE_PIN,
>> +#if IS_ENABLED(CONFIG_SENSORS_TDA38640_REGULATOR)
>> +	.num_regulators = 1,
>> +	.reg_desc = tda38640_reg_desc,
>> +#endif
>> +};
>> +
>> +static int tda38640_probe(struct i2c_client *client)
>> +{
>> +	return pmbus_do_probe(client, &tda38640_info);
>> +}
>> +
>> +static const struct i2c_device_id tda38640_id[] = {
>> +	{"tda38640", 0},
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(i2c, tda38640_id);
>> +
>> +static const struct of_device_id __maybe_unused tda38640_of_match[] = {
>> +	{ .compatible = "infineon,tda38640"},
>> +	{ },
>> +};
>> +MODULE_DEVICE_TABLE(of, tda38640_of_match);
> 
> No improvements here. Do not send new version without solving the
> feedback (or finishing the discussion). Its usage is still missing in
> your i2c_driver.
I realized I missed reference to tda38640_of_match below.

static struct i2c_driver tda38640_driver = {
         .driver = {
                    .name = "tda38640",
                    .of_match_table = of_match_ptr(tda38640_of_match),
                    },
         .probe_new = tda38640_probe,
         .id_table = tda38640_id,
};

Will fix that.
> 
> Best regards,
> Krzysztof
> 
Thanks,
Naresh
