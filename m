Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14316B04AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 11:37:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230207AbjCHKhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 05:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbjCHKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 05:37:42 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C018483A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 02:37:22 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id o12so63732914edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 02:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678271839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/YxkiJgIqDs4FoJNeb8r9nayENjgC7+1nLVXbDR/9jw=;
        b=ArS2ETg3/DHSdZfZirdIqULP4GiCof2f2PihzXjMJ9qtkLIl5CbAQl32NoYQU3r8ym
         QF+MeZP8zdsP1futgEK/c2UZLYAWerF5aNiUXk9dCmpISDnIPURPA/3s6S64GZm//YQA
         spY+s5JzFc7JpdAWm7J+wjJqi6iH8FySH3Djss/qs+GXDDzXrwRwgim/FuNQVTVYPf9T
         ptmYj4+A1BZMe4UI0tTEYCQ4SOahvUU8wPVsP3O3REpIxmouLjLrO1WSW5FxEiwPFw3Q
         LgowwojzxiD2tERh0OohtPgRZkNrpL/yIWRHyMrkRUoqTq1AQ0ljEcbnN4kzBBONVNV1
         DUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678271839;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/YxkiJgIqDs4FoJNeb8r9nayENjgC7+1nLVXbDR/9jw=;
        b=kfaumRl4RQUF53jYK0VkGKUO6sgdBzGdk3lHObOwlBrESUbrevdV6wal3slGgf6nh6
         2kr8GyEAvNjWQcRA8Daj7t+Yyt8PlQC1ZM/r8Rr+0i4yk7lbu9koKkIXRwLhWb6GuR0t
         cvn7d6IClCAntcotG0XhRke58TiaLAYCaa617Fa0QYvQu0/vC+7ack9Wxk7cm9pilc/g
         rFD/ijOmpWyAiW7kaPMhAU5JVCzJuLqvmjxtpStVH2mBpB132Mh5vOvSvH6JdbCvT9cI
         84ZVNinsDDEZ8sfYEezQ0ShlXVdjhg/hKrypwJmNFxvgCOdxln5ocPEw4ZuNgzTeyCUH
         o6FQ==
X-Gm-Message-State: AO0yUKXAkEFjZ0PNt6Bv/D6TdkYuti0n0m2wx80vz8dvSrAzukPK4rxF
        AYPR7F1FmQNtTpArGb4z1AbaV6cwVvNYc4t8NHU=
X-Google-Smtp-Source: AK7set/bXULAuhDKMM2IkJJmrz70ST5kC43j61Qe3Cz9ngy1EYU53dR/xd55pcCLVqv9EhXO21gpiA==
X-Received: by 2002:a17:906:2111:b0:8af:3fef:52c9 with SMTP id 17-20020a170906211100b008af3fef52c9mr18479656ejt.22.1678271839181;
        Wed, 08 Mar 2023 02:37:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:ff33:9b14:bdd2:a3da? ([2a02:810d:15c0:828:ff33:9b14:bdd2:a3da])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b008ef42f9cf48sm7257860ejd.82.2023.03.08.02.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Mar 2023 02:37:18 -0800 (PST)
Message-ID: <2e1159d3-f4a6-22ec-ccb5-96f6c07a4e7f@linaro.org>
Date:   Wed, 8 Mar 2023 11:37:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 2/2] hwmon: ina2xx: add optional regulator support
Content-Language: en-US
To:     Svyatoslav Ryhel <clamor95@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230308094024.14115-1-clamor95@gmail.com>
 <20230308094024.14115-3-clamor95@gmail.com>
 <378db0d7-4d5a-a445-3e1a-ee6d8da5a9e2@linaro.org>
 <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPVz0n2KgUKi-m+kjvbxq8fA_G0+KNHtkNe4T0UGpmasMjWK2A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/2023 11:35, Svyatoslav Ryhel wrote:
> ср, 8 бер. 2023 р. о 12:25 Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> пише:
>>
>> On 08/03/2023 10:40, Svyatoslav Ryhel wrote:
>>> Some devices may need a specific supply provided
>>> for this sensor to work properly, like p895 does.
>>>
>>> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
>>> ---
>>>  drivers/hwmon/ina2xx.c | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/drivers/hwmon/ina2xx.c b/drivers/hwmon/ina2xx.c
>>> index 00fc70305a89..4a3e2b1bbe8b 100644
>>> --- a/drivers/hwmon/ina2xx.c
>>> +++ b/drivers/hwmon/ina2xx.c
>>> @@ -119,6 +119,7 @@ struct ina2xx_data {
>>>       long power_lsb_uW;
>>>       struct mutex config_lock;
>>>       struct regmap *regmap;
>>> +     struct regulator *vdd_supply;
>>>
>>>       const struct attribute_group *groups[INA2XX_MAX_ATTRIBUTE_GROUPS];
>>>  };
>>> @@ -656,6 +657,17 @@ static int ina2xx_probe(struct i2c_client *client)
>>>               return PTR_ERR(data->regmap);
>>>       }
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

Unbind device. Then bind. Then unbind. Then check regulator status
(/sys/kernel/debug). Do you have the answer now?

Best regards,
Krzysztof

