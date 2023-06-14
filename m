Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9F72FBCA
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 12:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjFNK7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 06:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234209AbjFNK7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 06:59:12 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92FA19BC
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:59:10 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-30c4c1fd511so6129610f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686740349; x=1689332349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X76GkVQmm233Ef9CD45/5gbsHuJzJYm1L85f82G9R4o=;
        b=YC6D/9YorHI2DGemUAj/35LGIrIk1d7W7kFw5L0NFtynGJLSkwhdHBHTSkjoAWF6Hw
         pId1fTQQnxrw3IOIqwOPq4EYitLlCm4eclIXFwsCwdUT42yWTcdUPCNPSqVSLogvk1iU
         xduZ2AUrOfBKMsWgPwR20HTGWegtCwfw5LRXu0ASMVU6Gl/0ltjm7D9BezzW72ukdkUj
         vMiMK+9R2Qry+vuJ+0zUaYnKowG7HXx3jvRvpsXxISRg5C6jmrZ+zK0qBpdjVpM33kY0
         fqFpfi058mntucNZ7KuAVG+aRmJWOKJxK2XdB2gecXB08r68rF+/Y/Rfxr6iVsBI6grQ
         zhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686740349; x=1689332349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X76GkVQmm233Ef9CD45/5gbsHuJzJYm1L85f82G9R4o=;
        b=PKHQuznzW29NEpWiBuIRhXbESLymAEM3i74+R2jy67FS4tNm9M+RYFk4zcerYt+Q2Z
         YcevIyNaNFQ0iW1KjI6sL9Po2AM+aEzazzZrdHf7ES/ROPX/pduiCY1v0Pov4XACsR0C
         yrxgBlksqAmgtzJ8iqoei3S0cwe/5m3VYmaN11BEqb2bcRDt24zTPB5nnvbu3Y61lks/
         GW98qUb54C0FYY93nHZVtupiaDIAhEtnOXlB7050T4J1eilRtw87jSoPbnpaY7w+6Tzx
         TR5etmc2ocdYg/l7jEdXyCEXpXud3leeMt9i4p0egZlULpAdBoLKLxXmuJKDFqi0gmrZ
         5j5A==
X-Gm-Message-State: AC+VfDw1Y77XQ06ULnDvvLVE7/AIZD+sqG1EhRB0FQRN/SqgY3LFmFt7
        NOsZ6+WVH4J0GiJV3BMZKoOMSA==
X-Google-Smtp-Source: ACHHUZ4osks2idP8nFHnF77UpFY2nhvaTzkrwZUVtXTupb7ex/nT+3I5JfmY4knyoi0MhzfpCxOZhg==
X-Received: by 2002:adf:e4c8:0:b0:30f:c9bf:de69 with SMTP id v8-20020adfe4c8000000b0030fc9bfde69mr4851063wrm.46.1686740349081;
        Wed, 14 Jun 2023 03:59:09 -0700 (PDT)
Received: from ?IPV6:2a05:6e02:1041:c10:d8c4:17ec:c49d:215e? ([2a05:6e02:1041:c10:d8c4:17ec:c49d:215e])
        by smtp.googlemail.com with ESMTPSA id n7-20020adff087000000b0030ae5a0516csm17816540wro.17.2023.06.14.03.59.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 03:59:08 -0700 (PDT)
Message-ID: <d652acef-ab25-7d5e-6af0-584dacfbbd8d@linaro.org>
Date:   Wed, 14 Jun 2023 12:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] thermal: loongson-2: add thermal management
 support
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20230426062018.19755-1-zhuyinbo@loongson.cn>
 <af4d1e00-76d6-b71a-2ed1-562e6405306b@linaro.org>
 <ac5b3982-a658-e05b-1b5c-3aeeda1585ed@loongson.cn>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <ac5b3982-a658-e05b-1b5c-3aeeda1585ed@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Yinbo,


On 14/06/2023 10:03, zhuyinbo wrote:
> 
> Hi Daniel,
> 
> Thank you very much for your feedback and suggestions. Below, I have
> some comments, please review.

[ ... ]

>>> +
>>> +    low += 100;
>>> +    high += 100;

Literals -> macros

>>> +    reg_ctrl = low;
>>> +    reg_ctrl |= enable ? 0x100 : 0;
>>> +    writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_LO + reg_off);
>>> +
>>> +    reg_ctrl = high;
>>> +    reg_ctrl |= enable ? 0x100 : 0;
>>> +    writew(reg_ctrl, data->regs + LOONGSON2_TSENSOR_CTRL_HI + reg_off);
>>
>> Is the 'enable' boolean really useful?
> 
> 
> Yes, this 'enable' was to enable thermal irq.
> 
>>
>> Wouldn't be the sensor trip points disabled by default at reset time?
>>
> 
> 
> Only here will thermal irq be enabled throughout the entire driver, and
> actual testing has shown that interrupts are valid, so this is
> meaningful.

Ok.

>> If it is the case then we can get ride of this variable and make the 
>> routine simpler
>>
>>> +    return 0;
>>> +}
>>> +
>>> +static int loongson2_thermal_get_temp(struct thermal_zone_device 
>>> *tz, int *temp)
>>> +{
>>> +    u32 reg_val;
>>> +    struct loongson2_thermal_data *data = tz->devdata;
>>> +
>>> +    reg_val = readl(data->regs + LOONGSON2_TSENSOR_OUT);
>>
>> Seems like there is no offset for the sensor id here ?
> 
> 
> There is no need for a sensor ID here.
> 
> There are some things that I didn't describe clearly, which made you
> misunderstand. Actually, the temperature sensor of 2K1000 is like this:
> 
> There are 4 sets of temperature interrupt controllers, only one set of
> temperature sampling registers. a sets of temperature interrupt
> controllers was considered a sensor, which sensor include 3 register as
> follows, where "SEL" represents which sensor is referenced, In 2k1000
> datasheet, which "SEL" must be 0.

I'm not sure to understand. Let me rephrase it and know what is wrong.

1. The thermal controller has 4 sensors. The interrupt can be set for 
these 4 sensors.

2. When reading a temperature, we have to select the sensor via the 
'SEL' register.

3. The 2k1000 has one sensor with an id = 0.

4. In the future, more Loongson platform can be submitted with more than 
one sensor

If this is correct, then my comments are about the inconsistency of the 
proposed changes. Guessing in the future Loongson board there will be 
more than one sensor, the existing code mixes support for one and 
multiple sensors as well as assuming id is 0.

So if you add in the of_loongson2_thermal_match table a new platform 
with several sensors, the current code will be broken because:

  - the initialization loop does exit when the first thermal zone 
registration succeed

  - the interrupt handler does not figure out which sensor crossed the 
low/high limit

  - the get_temp is not selecting the right sensor


That is my point:

  - write the code to support one sensor with id=0 only

    *or*

  - write the code to support multiple sensors

If I'm not wrong the code is closer to support multiple sensors ;)

Let me know if these deductions are correct

   -- Daniel

ps : is there an English translation for the 2k1000 datasheet ?





-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

