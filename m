Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27C66CFDB1
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:05:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229640AbjC3IFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbjC3IFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:05:05 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF9AD659E
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:04:56 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id k37so23500854lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AlXibMxlWDb3fE7PPlx7SqRIaOU+iY/my4CtWS+AFz0=;
        b=gOm82s6MR20hI+r3IB7/L5e+uq1Zz3OLh840E7iYyoP2gDecLH48lajqbgYV8NVJvN
         xPEboB8255TuCoxzCDS2+FESyUM8H0DhzpSgt6mSkF1+zD57sDtkfqqKjdz5imIVuC6f
         7Du2uERLeJwYowtYMBIhB9Hcua+RgXPLS7WipJy2D7Lb3gVmOeNQ4r5787/YFt6FiewJ
         0x1mjZQeTGeal2MrM9jN8pYGDKU7wrfJZNIizTJnKnAa3SNiPQ5NSgA+SkXVNpxh8rn+
         jCOjqHT2gK8MX4yF5DZaiUk4FAGkQARmVJdKtMKnj2vzq9ClK5XtNHyzUvItu1Lj3z2o
         3AyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163495;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AlXibMxlWDb3fE7PPlx7SqRIaOU+iY/my4CtWS+AFz0=;
        b=aFUcn3TPCAqc8ZxAWvzZ/JnRoyXmBym7VVAu/f4Otbyyw9HxG+WyHh1Cw9+FNmytD2
         bNlny8sdX53QKQJ0wjgw0eb+mYCXGEFDfN7WTeGRhArmUQ4ONsikxMW9Jwnl7NyGUR0C
         EnLrfBC+mT3A/vBoirFH3BdcxoZ9Uv810puBfQDCKsf9gxHHq7g8MYouknQ907W9Zgr9
         UKy7xBJI+KEnDw3e4hg+WU7xNetLQ2seQTAvrYjO88Bpf8woE4dWDyQGkHjvfpSLYibZ
         0jB8eCSjKfrQTlaHHmQyo3t+OJ5D+dWh7KB87aJja7smodns2CUCBSertHPt6P6lx0PI
         Pvgg==
X-Gm-Message-State: AAQBX9dJZWudxHrepiuo6ODjJR7TO8yfTJHfNFVXmB5bTm7IoLrVj7ac
        Ddu1FZ3myWQgagkpxkMSEkQ+4Q==
X-Google-Smtp-Source: AKy350Zv08/gNl3jEoV0yNCaazw9HNMb60MNBg0qFkoa7eUW7f3+7ydFURsCh+73MMnQG62wHJ3aMA==
X-Received: by 2002:ac2:4db7:0:b0:4e8:3d0:84b4 with SMTP id h23-20020ac24db7000000b004e803d084b4mr1673498lfe.24.1680163495153;
        Thu, 30 Mar 2023 01:04:55 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id q17-20020ac25151000000b004d5a6dcb94fsm5810324lfd.33.2023.03.30.01.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:04:54 -0700 (PDT)
Message-ID: <f4692540-4be0-4140-0a9c-e38f2e9515ba@linaro.org>
Date:   Thu, 30 Mar 2023 10:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Content-Language: en-US
To:     Lee Jones <lee@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Sahin, Okan" <Okan.Sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        "Bolboaca, Ramona" <Ramona.Bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        "Tilki, Ibrahim" <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20230307112835.81886-1-okan.sahin@analog.com>
 <20230307112835.81886-6-okan.sahin@analog.com>
 <20230315175223.GI9667@google.com> <20230315175257.GJ9667@google.com>
 <MN2PR03MB5168249900206433A082875EE7889@MN2PR03MB5168.namprd03.prod.outlook.com>
 <20230329143615.GS2673958@google.com> <ZCROpw0il1VQCLPu@smile.fi.intel.com>
 <20230329145636.GV2673958@google.com> <20230329150605.GW2673958@google.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230329150605.GW2673958@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/03/2023 17:06, Lee Jones wrote:
> On Wed, 29 Mar 2023, Lee Jones wrote:
> 
>> On Wed, 29 Mar 2023, Andy Shevchenko wrote:
>>
>>> On Wed, Mar 29, 2023 at 03:36:15PM +0100, Lee Jones wrote:
>>>> On Tue, 28 Mar 2023, Sahin, Okan wrote:
>>>>>> On Wed, 15 Mar 2023, Lee Jones wrote:
>>>>>>> On Tue, 07 Mar 2023, Okan Sahin wrote:
>>>
>>> ...
>>>
>>>>> +static const struct i2c_device_id max77541_i2c_id[] = {
>>>>> +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
>>>>> +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
>>>>
>>>> Just 'MAX77540' is fine.
>>>
>>> I tend to disagree.
>>>
>>> There is an error prone approach esp. when we talk with some functions
>>> that unifies OF/ACPI driver data retrieval with legacy ID tables.
>>> In such a case the 0 from enum is hard to distinguish from NULL when
>>> the driver data is not set or not found. On top of that the simple integer
>>> in the legacy driver data will require additional code to be added in
>>> the ->probe().
>>
>> Use a !0 enum?
>>
>> The extra handling is expected and normal.
> 
> I've always disliked mixing platform initialisation strategies.  Passing
> pointers to MFD structs through I2C/Device Tree registration opens the
> doors to all sorts of funky interlaced nonsense.
> 
> Pass the device ID and then match in C-code please.

I agree. Especially that casting through ulong_t drops the const, so the
cast back needs const which can be forgotten. The patch already makes
here mistake!

Best regards,
Krzysztof

