Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACF156B058D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbjCHLN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:13:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjCHLNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:13:24 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAC332200F;
        Wed,  8 Mar 2023 03:13:22 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id q11-20020a056830440b00b00693c1a62101so8792636otv.0;
        Wed, 08 Mar 2023 03:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678274002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=S/SG6WOmPhOG71pPi5Yr9q4aa/gX/p7YkTAPW6zFDIc=;
        b=X5VImF6iyuON7wQbt/hgP5hAcIrRHVHyWGIQN47mTDS3wJE+geuIIQWk0Bb29Fo0js
         1DaHsOUOJnkddj3+4HGYKBcoMKVwr/dyfa6zYYTadHEaw/I1dTS2rJr0cMl5YuqS6VlS
         wZetyyqJujU9l5yByig8Dk6FnibDmK6G/tm4Daf5mlM7MZzMrOmolksypaVCOuKSPhKa
         FkvfB3rsIPeLOhJnvUba3Ff1r8Zp2g9b6BwuYKKNi2Ajdg17Ja7bEFlSxDGbN0U0Y1nX
         Oz5GHmoBgGXadpi9ACdqGJpkJIUvm6w5IHO3AJGgBlltvrdJuyKn6fcPPdeaXhlLe5Rz
         XiDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678274002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S/SG6WOmPhOG71pPi5Yr9q4aa/gX/p7YkTAPW6zFDIc=;
        b=trpCuv+U+BtNagdE+xX3JITJFDeCyXGpQYm3HVLIhqNloGc7UqucAbg0LMrmeNzaHA
         ps/p4EP6KPIkxINRVGKyNgmJAYabrO4X7HKzsoBUX+aTKmGiuy7mVX7NL+WfoMCMVvMI
         OUO/z8qj7UBfKlSzqKxBSocRApQwHeG9akCeO2Ra7TtOsOpSPr7XF16lymIpEocDHh/v
         dqvNWm8cLbl08TJknCPiqkFDxD5ot6bngerWk7bP+qxvpIsGQA4/R30t9by560kaIEXx
         Jylq1U/t1+oXU46fRQkkMKWxM7MJtHqN9cK+8ABVtyZHJBgvCT9v9KcyT3GWStj7PkyI
         2jIA==
X-Gm-Message-State: AO0yUKW9V9Txof0ejFGSGl/McPtJrU1H4KK6hvMLzirmar7D3I5S1wYq
        23kJKZUBwVcb4bwJxLEW+j0=
X-Google-Smtp-Source: AK7set9VrBcrbK9lcrHwfsTbcu29MFWbWFH4ZXvocllXC900l1IaHbqInI9Xg/9Y1VIfXDaKOOuS7Q==
X-Received: by 2002:a9d:7105:0:b0:684:c3ad:962f with SMTP id n5-20020a9d7105000000b00684c3ad962fmr7793475otj.7.1678274001991;
        Wed, 08 Mar 2023 03:13:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k3-20020a9d4b83000000b00690e6d56670sm6428791otf.25.2023.03.08.03.13.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 03:13:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a1187c2e-122e-36d1-dddd-c7beba282800@roeck-us.net>
Date:   Wed, 8 Mar 2023 03:13:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jean Delvare <jdelvare@suse.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-3-clamor95@gmail.com>
 <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org>
 <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/8/23 02:35, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 12:25 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>> Some devices may need a specific supply provided
>>> for this sensor to work properly, like p895 does.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>   drivers/hwmon/ina2xx.c | 12 ++++++++++++
>>>   1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>>> index 00fc70305a89..4a3e2b1bbe8b 100644
>>> --- a/drivers/hwmon/ina2xx.c
>>> +++ b/drivers/hwmon/ina2xx.c
>>> @@ -119,6 +119,7 @@ struct ina2xx_data {
>>>        long power_lsb_uW;
>>>        struct mutex config_lock;
>>>        struct regmap *regmap;
>>> +     struct regulator *vdd_supply;
>>>
>>>        const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>>>   };
>>> @@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *client)
>>>                return PTR_ERR(data->regmap);
>>>        }
>>>
>>> +     data->vdd_supply = devm_regulator_get_optional(dev, "vdd");
>>> +     if (IS_ERR(data->vdd_supply))
>>> +             return dev_err_probe(dev, PTR_ERR(data->vdd_supply),
>>> +                                  "failed to get vdd regulator\n");
>>> +
>>> +     ret = regulator_enable(data->vdd_supply);
>>> +     if (ret < 0) {
>>> +             dev_err(dev, "failed to enable vdd power supply\n");
>>> +             return ret;
>>
>> And where is disable? On each error path, removal etc.
>>
> 
> error path ok, should I create a remove function just to disable the regulator?
> 
Use devm_add_action_or_reset().

Guenter

>> Best regards,
>> Krzysztof
>>

