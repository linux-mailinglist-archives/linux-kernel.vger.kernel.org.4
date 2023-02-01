Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D099B686C50
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 17:59:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjBAQ74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 11:59:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjBAQ7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 11:59:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EEC24C83;
        Wed,  1 Feb 2023 08:59:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id z11so18374977ede.1;
        Wed, 01 Feb 2023 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vw3JMc60QFgf7Q8TTyiPs3L7+sJqYoWAEt2y6Foay18=;
        b=NOxxBcabypwDw5ZsGpi0n57XKkq3s7dl1TJhJ1YbZuSXySUAeUNN3HkpUWxDfQAwWP
         Pw11X6bZJfcZDEfg16jDhfot5imVcYeZTEmsAkz6hCo/6xNPicEwtgGIJOQJWKv9nrme
         weu0cPYCeiN9Iy+dIHXphSUSaWwTfqzzdr1D37eTxqL2sYnbfmya/pLgZ33ninNGfzAh
         RuPGwa84Y121hqN51U5wWpKqB5jaULV8zy0RQxHgNMWHeUFPmkDVZF6RMEjRg1Gf2Udw
         VVJogT/Z+Watc02fy0qqYgFYouSroZed9xG8dddUa9xOkolXuWLh25DefyIW+sUlv1vy
         qufQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vw3JMc60QFgf7Q8TTyiPs3L7+sJqYoWAEt2y6Foay18=;
        b=aT9v7IgJYxOS6NJ6bwDNSMdNJHMKX63eLzOXCIyGYvZcEvrs6qKhtMjhSU6lYFK2RF
         2uWJOtqb7WrFic6c4EFPz0+eWlsF4QQyIK/neZqaedksNOhjLnswASPPv9tdwBIUFs69
         pFfudZhf+IgcTxUSLxIrhOGTCXhPTH2WE1RoEqJx0uaXOesIjeh+hkHmTarE/CFYQhik
         cGUmL9rlpH0PTP2iBxn/xuGKkKtQAobIA2cdrIzP4IwktZdXPju7wbZGIi6qTEd4jXaT
         R3kbi3/l04DZanKHL194ROjuX+s8EDg0oF1GHZqjpkXEMEgQJjiDgtzgSlU2lee6BHc7
         q/Ew==
X-Gm-Message-State: AO0yUKUl8WgNa+phrMOWiWX41lnCepuP4SXKhW/W86f0gZDFyhi1VeLq
        azwPj1Qdy+VWJrwWCV4yHBQ=
X-Google-Smtp-Source: AK7set9j544AAoQ+SvnPoWkjwfiPgAPXI/nWj+bLA78vW8zR9X8/TrGGt5wvGremyy49kaBIO5GPrw==
X-Received: by 2002:a05:6402:22a3:b0:4a2:662a:841a with SMTP id cx3-20020a05640222a300b004a2662a841amr2675594edb.29.1675270792145;
        Wed, 01 Feb 2023 08:59:52 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id h1-20020a1709062dc100b0087bd2924e74sm8853959eji.205.2023.02.01.08.59.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 08:59:51 -0800 (PST)
Message-ID: <68466850-ddb0-119a-ea82-636ec2c5368e@gmail.com>
Date:   Wed, 1 Feb 2023 17:59:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     daniel.lezcano@linaro.org, angelogioacchino.delregno@collabora.com,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-5-bchihi@baylibre.com>
 <20230131153816.21709-1-bchihi@baylibre.com>
 <ab1e4822-d5f4-79f6-ea38-47e2342ebe49@linaro.org>
 <CAGuA+oqLiCxb1g7pwf+RwUTWHV37pXdAWUXHV51TnUy1-xUOXQ@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v12] thermal: drivers: mediatek: Add the Low Voltage
 Thermal Sensor driver
In-Reply-To: <CAGuA+oqLiCxb1g7pwf+RwUTWHV37pXdAWUXHV51TnUy1-xUOXQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/02/2023 17:46, Balsam CHIHI wrote:
> Hi Krzysztof,
> 
> Thank you very much for the review!
> 
> On Wed, Feb 1, 2023 at 8:55 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 31/01/2023 16:38, bchihi@baylibre.com wrote:
>>> From: Balsam CHIHI <bchihi@baylibre.com>
>>>

[...]

>>> +
>>> +static irqreturn_t lvts_ctrl_irq_handler(struct lvts_ctrl *lvts_ctrl)
>>> +{
>>> +     irqreturn_t iret = IRQ_NONE;
>>> +     u32 value, masks[] = {
>>
>> Don't mix different types in one declaration. u32 and a pointer are
>> quite different types.
> 
> I'm not sure to understand.
> LVTS_INT_SENSORx are not pointers but register values.
> 

u32 mask[] is a pointer to a array of u32 values of undefined length.

[...]

>>> +static int __init lvts_golden_temp_init(struct device *dev, u32 *value)
>>
>> You did not test it, right? Build with section mismatch analysis...
> 
> I'm not sure to fully understand this comment.
> Would you explain, please?
> 

AFAIU:

lvts_golden_temp_init() and lvts_ctrl_init() are called from a function that is 
not in __init section:
lvts_domain_init()

So if you free up the first to functions after init but not the callers, things 
can explote.

[...]

>>> +
>>> +static int lvts_probe(struct platform_device *pdev)
>>> +{
>>> +     struct lvts_data *lvts_data;
>>> +     struct lvts_domain *lvts_td;
>>> +     struct device *dev = &pdev->dev;
>>> +     struct resource *res;
>>> +     int irq, ret;
>>> +
>>> +     lvts_td = devm_kzalloc(dev, sizeof(*lvts_td), GFP_KERNEL);
>>> +     if (!lvts_td)
>>> +             return -ENOMEM;
>>> +
>>> +     lvts_data = (struct lvts_data *)of_device_get_match_data(dev);
>>
>> Why do you need case?
> 
> Would you explain, please?
> 

Typo by Krysztof, he meant the cast.
lvts_data = of_device_get_match_data(dev);
should be good enough.

Regards,
Matthias
