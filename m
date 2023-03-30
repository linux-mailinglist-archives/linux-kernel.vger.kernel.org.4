Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81246CFDBE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 10:07:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjC3IHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbjC3IHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 04:07:08 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B01A7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:07:06 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id z42so18709097ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 01:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680163625;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wP52M2xnlem1ysVvkycZnKW6GmRMB71AsDVKGOMpBk=;
        b=tOosVUxXWsUiu1apm/6HlpSjhtiaXJHDAF1Em1UsTGAimLisFooCIZcn6niHf5rg1V
         WfldBse/bniQEVZVKIpTQLsmo10P1IeZQxHoo90wIbxAeAJujXRBehWI+/NeRYpoSCls
         x8Hi+SqWAp3wLgfu6wgFTxwjgry8OwpCiHH6r0vzzXzgS2nDKq8NzeKhKn2lU561EFTk
         VDYdcQNO3zofOMoTcyvXHWAgU5ER+Ym6tXMCZUlIUtOw2dDJ4WfyB1fV9AvxnN2MFols
         dheeamVynlKhB6zNgSfynIPp8jFvw6BYjzs/JiyAqmW/hZH3iKGxEN/89piZO2/RGjbJ
         VrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680163625;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wP52M2xnlem1ysVvkycZnKW6GmRMB71AsDVKGOMpBk=;
        b=71N+iA4vT2k54R75kRapBMouTGcVaTy9V0STz8oiyy8IrQx9ax6mrOce6+/ntgFpZ3
         I1boPcOoO9V2tvWNrkGlGECX8awxIZMLb2TvhZLueqIKToOFa66QH+rjG7BmGmINe4X6
         pKwx1bR6kIvPv5mLveFp/9QCk7Y+DKZYrduuWDQ8nDmt9fp8QspBaTOpj7+3l8fRxAsP
         GOLwCPqwLBxC5DEx+GBh5zQnnyD3DunR0lK684/xIkKUTP6e3rrXTtPi8Br9gjToZGJV
         6OQhMpHUHYa6Bswt+yDv2qR5JAEEx5R+2jQ72T4J3TVyQhYmvm6b9u5KNJbwROCa69wI
         xidw==
X-Gm-Message-State: AAQBX9frJWVcocdyCzkOfSZRDIZ0FzQsCatM1Bnf10XeCdMJTMNjcXGh
        wGFFof+1XC471l+DahwXNQNLCg==
X-Google-Smtp-Source: AKy350YV9pRleUwP3lY5sESfJRaKTCXO/kVILqADm1QzHo7Y6RtlUOsxaPvVX8uPexJdtm/0QkhS5w==
X-Received: by 2002:a05:651c:83:b0:298:b161:feb0 with SMTP id 3-20020a05651c008300b00298b161feb0mr6245507ljq.49.1680163625221;
        Thu, 30 Mar 2023 01:07:05 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id s26-20020a2e9c1a000000b00298dc945e9bsm5778851lji.125.2023.03.30.01.07.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Mar 2023 01:07:04 -0700 (PDT)
Message-ID: <c2dd982e-b6ee-089f-dd4f-30280a396f4b@linaro.org>
Date:   Thu, 30 Mar 2023 10:07:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v6 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
 <f4692540-4be0-4140-0a9c-e38f2e9515ba@linaro.org>
In-Reply-To: <f4692540-4be0-4140-0a9c-e38f2e9515ba@linaro.org>
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

On 30/03/2023 10:04, Krzysztof Kozlowski wrote:
> On 29/03/2023 17:06, Lee Jones wrote:
>> On Wed, 29 Mar 2023, Lee Jones wrote:
>>
>>> On Wed, 29 Mar 2023, Andy Shevchenko wrote:
>>>
>>>> On Wed, Mar 29, 2023 at 03:36:15PM +0100, Lee Jones wrote:
>>>>> On Tue, 28 Mar 2023, Sahin, Okan wrote:
>>>>>>> On Wed, 15 Mar 2023, Lee Jones wrote:
>>>>>>>> On Tue, 07 Mar 2023, Okan Sahin wrote:
>>>>
>>>> ...
>>>>
>>>>>> +static const struct i2c_device_id max77541_i2c_id[] = {
>>>>>> +	{ "max77540", (kernel_ulong_t)&chip[MAX77540] },
>>>>>> +	{ "max77541", (kernel_ulong_t)&chip[MAX77541] },
>>>>>
>>>>> Just 'MAX77540' is fine.
>>>>
>>>> I tend to disagree.
>>>>
>>>> There is an error prone approach esp. when we talk with some functions
>>>> that unifies OF/ACPI driver data retrieval with legacy ID tables.
>>>> In such a case the 0 from enum is hard to distinguish from NULL when
>>>> the driver data is not set or not found. On top of that the simple integer
>>>> in the legacy driver data will require additional code to be added in
>>>> the ->probe().
>>>
>>> Use a !0 enum?
>>>
>>> The extra handling is expected and normal.
>>
>> I've always disliked mixing platform initialisation strategies.  Passing
>> pointers to MFD structs through I2C/Device Tree registration opens the
>> doors to all sorts of funky interlaced nonsense.
>>
>> Pass the device ID and then match in C-code please.
> 
> I agree. Especially that casting through ulong_t drops the const, so the
> cast back needs const which can be forgotten. The patch already makes
> here mistake!

Uh, no, the code is correct - chip_info member is const. Yet it is a
mistake easy to make for the device ID tables using void * or ulong.

Best regards,
Krzysztof

