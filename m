Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89867718A6B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjEaTrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEaTqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:46:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB822133
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:46:49 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-96ff9c0a103so886640866b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685562408; x=1688154408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1hKxjiaWU4gxzP5Yco0VtqcM7V2UjDrbLP5jSeYjmKA=;
        b=VxdE5sRK9HQnrjWoJI7FPbhFdQn0cY3wm30cE+MN4eF2PhDH24eLFhpCBtlGT6t9rS
         LbQ3sYusakJzSt47dmg1s7htuZlvLgUZEQC1pafIr4gudgmbZhZ/jk3h5+xkC4y/2ui1
         DnSQNsMJAY4ZkEU9mnAT0fRjXrqRi080ERJQAKTrtYA6A5RN3ZAL3MnWJ7oD7BEWcrYs
         /Igsuu3X+ob7SvjodFoVigrkIwaeT+GwbzngtSi0EIE01EtPCP+pib1dxWVCtLYNBu92
         M8tyGtdkoN1OHUYau04H3wDYvZLi1Df9nKLzIySsB7vY9zNwFHDTIVW9fQR1e2Gf//AD
         Q5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562408; x=1688154408;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1hKxjiaWU4gxzP5Yco0VtqcM7V2UjDrbLP5jSeYjmKA=;
        b=FUNP/RPm4OKdsKvuSZvzUm4k1+jjpfrkESCkDLrTxinzYHwi3Lb65lftGlr/Cal3Ea
         wNVaGAEOs4ar8IEBiy8dVDOQQM4bYWqPeQj1Y93TElwv5xLv1NDOx9yz0fQLm0beHmk5
         d6aWGY1jNvbW29FtE8495mJmu9AaOO07q083Bp1G7Mb9sBZHy2AofPg7t0Acf8qA4dDf
         H5oIc9XXwEy1PFKvResGg5HP1xsV41NXY6+CRX4Ts1CAMNp4kz+AvsCbURa0Rx2J6g5y
         LXJOlHCbt7s24A0MprGNILAcEo74VapH++Wi3fFu4H6l+LoJ+TMrdXVUJ9fLTzEOexN/
         v56w==
X-Gm-Message-State: AC+VfDzKeOtNFGjpMLlW9ZgztT279y1aIrxtOxS+peOF2PTweLYPePZy
        BKbB8CEx8pXPkPoAUfzKAyXUFA==
X-Google-Smtp-Source: ACHHUZ5nuz3D9s6a4n39/QN6AzlfU12FPYvQSz8eV/LpaQLXQwB9hM5KyxOa9hHlfc1Ujh5E84uUjg==
X-Received: by 2002:a17:907:86a4:b0:973:e4c2:2bcd with SMTP id qa36-20020a17090786a400b00973e4c22bcdmr6190242ejc.18.1685562408308;
        Wed, 31 May 2023 12:46:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f19-20020a170906139300b0095fd0462695sm9399751ejc.5.2023.05.31.12.46.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:46:47 -0700 (PDT)
Message-ID: <2196dd29-93ee-00f7-65b4-ede73aa8ba77@linaro.org>
Date:   Wed, 31 May 2023 21:46:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v11 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>,
        Conor Dooley <conor.dooley@microchip.com>
Cc:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230522071030.5193-1-zhuyinbo@loongson.cn>
 <20230522071030.5193-2-zhuyinbo@loongson.cn>
 <20230524-pouncing-variable-c520e85f8db8@wendy>
 <b1e3d199-de5a-f8d5-9159-4965e9e1f5ef@loongson.cn>
 <20230524-relative-trimmer-046fb26a7764@wendy>
 <99b362c2-640c-9150-26ee-e9add4483886@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <99b362c2-640c-9150-26ee-e9add4483886@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/05/2023 04:22, zhuyinbo wrote:
> 
> 
> 在 2023/5/24 下午6:29, Conor Dooley 写道:
>> On Wed, May 24, 2023 at 05:44:38PM +0800, zhuyinbo wrote:
>>>
>>>
>>> 在 2023/5/24 下午4:56, Conor Dooley 写道:
>>>> On Mon, May 22, 2023 at 03:10:29PM +0800, Yinbo Zhu wrote:
>>>>> Add the Loongson platform spi binding with DT schema format using
>>>>> json-schema.
>>>>>
>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>>    .../bindings/spi/loongson,ls2k-spi.yaml       | 41 +++++++++++++++++++
>>>>>    MAINTAINERS                                   |  6 +++
>>>>>    2 files changed, 47 insertions(+)
>>>>>    create mode 100644 Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>> new file mode 100644
>>>>> index 000000000000..d0be6e5378d7
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>> @@ -0,0 +1,41 @@
>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>> +%YAML 1.2
>>>>> +---
>>>>> +$id: http://devicetree.org/schemas/spi/loongson,ls2k-spi.yaml#
>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>> +
>>>>> +title: Loongson SPI controller
>>>>> +
>>>>> +maintainers:
>>>>> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>> +
>>>>> +allOf:
>>>>> +  - $ref: /schemas/spi/spi-controller.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - loongson,ls2k-spi
>>>>
>>>> I am sorry to jump in here at such a late stage with a (potentially)
>>>> trivial question. "ls2k" is the SoC family rather than a specific model
>>>> as far as I understand.
>>>> The answer is probably yes, but do all SoCs in the family have an
>>>> identical version of the IP?
>>>
>>>
>>> No, but the spi supported by this loongson spi driver are all the same
>>> identical version, and other type or verion spi will be supported as
>>> needed in the future.
>>
>> Does having a catch-all compatible make sense then when not all SoCs in
>> the ls2k family will actually be able to use this driver?
> 
> 
> Yes, it is make sense as it can reduce the workload of the community.
> For the Loongson platform, the versions of spi peripherals are almost
> the same, except for a few  or individual SoCs.  And we have also
> discussed compatible internally, and we tend to define it this way.

So you have chosen different path than what's clearly recommended by
community, existing experience and documentation:

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Family names are not accepted as specific compatibles. Whenever they
were accepted, it lead to problems. All the time.

https://lore.kernel.org/all/20220822181701.GA89665-robh@kernel.org/
https://lore.kernel.org/all/78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com/
https://lore.kernel.org/all/288f56ba9cfad46354203b7698babe91@walle.cc/
https://lore.kernel.org/all/106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org/
and many many more discussions.

You should choose carefully, because we will keep NAK-ing adding
properties to circumvent missing compatibles.
> 
>> Or am I misunderstanding and all ls2k SoCs do work with this driver and
>> you were talking about other, future products?
> 
> Actually, in 2k500 has one special type spi was only one cs and their's
> register definition was different from common type spi thus this driver
> doesn't support but this driver can support another common type spi in
> 2k500.  for this special type spi I will add support as needed in the
> future.

Bindings are for hardware, not driver. What does your driver support or
does not, matters less.

Best regards,
Krzysztof

