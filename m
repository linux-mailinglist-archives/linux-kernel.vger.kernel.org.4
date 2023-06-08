Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 221BC727C20
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 12:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjFHKDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 06:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233943AbjFHKDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 06:03:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A357D26BB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 03:03:01 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-977c72b116fso68039366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686218580; x=1688810580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bmfylh5K7Rt8fwaEveI7BoiN+8WWrTg97yj2ME0kBOA=;
        b=HuHCeQujCHnipvUAT2lRl1oyB8ETir3dsAst+qalpan3hTm3dbcJYUw1fYJZPR7fhr
         JnTVtuP8MTgCoBW9pu2CuE5u2ACRp7A3/2SauSTBowDgUvUc1zyA7cECUHCBwzvdHWup
         Hbza4RhjuvENcGLmsfzui9Dx9g5vTTCpUqRXMToLCGqXO4Gziaa15VQIRbYsY0jHSENb
         jblfoDk1rGwGmnJsOy56b9N1WlyiFNP62Qxmqm4+o5dSY4kTazbK/xS3osT/pr6a4PSu
         l4EXdhywI1kBT2Hwq05MMTbj7QsC86Zz4McxozUGB3r08FA7bFCyyUnUmT5kRTkwhT7p
         AFqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686218580; x=1688810580;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bmfylh5K7Rt8fwaEveI7BoiN+8WWrTg97yj2ME0kBOA=;
        b=h+Yddzfht9aZx4WMlXCUbJ4d7I4DjR8PXdZj9qAeKYOoZcErEIF+fORsKAfaQPHByR
         opXPwweAkT2V2TY01g40/nkiaHALN4pJiT20laaxsgx0Gr9485igFpuE4UgebG3YAjXE
         EWVA10mbdw+1S/8MI8+4NdYJrcc+NvHgX4q3hizv6fF5UC4IQhNUT06uQk4lb0dTD86g
         rgMcW8Vw5HDfmN7ZCaFWFgs1Fp2Ghuu7VHK+CYNFPMnsghFDaQr/AP6QR+E5IQt5WkPd
         j5Zmrp4pyMWY0oexvz2qPZqe+hpz636CtM0rwdpREjmc7AGHP89v860YH5JjPaUJRKao
         /mwA==
X-Gm-Message-State: AC+VfDwzwPB8aWCOxiBuyywDs4fF2Yn2MEmbfyd34K2Pahv2j99BnUNu
        EJ+R126BmghAVTKIjAV//P/R+w==
X-Google-Smtp-Source: ACHHUZ6pBOMzByvbtvZPrdTxWmoF4m+8oSlWRMC84p9V8IFo1xhkQWFoGjxpwZnnyAcuoUy+PwJBLQ==
X-Received: by 2002:a17:907:94d6:b0:974:1c90:4c02 with SMTP id dn22-20020a17090794d600b009741c904c02mr9192948ejc.5.1686218580135;
        Thu, 08 Jun 2023 03:03:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090616cb00b009745b0cb326sm475258ejd.109.2023.06.08.03.02.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 03:02:59 -0700 (PDT)
Message-ID: <11ca2b90-544d-18c2-fb15-7909ca60507f@linaro.org>
Date:   Thu, 8 Jun 2023 12:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v12 1/2] spi: add loongson spi bindings
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230608072819.25930-1-zhuyinbo@loongson.cn>
 <20230608072819.25930-2-zhuyinbo@loongson.cn>
 <6ebed84c-2b42-c981-7b3f-e71cc88e4c2c@linaro.org>
 <4bf747c4-b767-b20c-e00f-724b50f44edb@loongson.cn>
 <6bfc2a22-6901-0858-7b90-bc4c52c66810@linaro.org>
 <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bd2d7830-3ab6-0906-b06a-83d3e0a96749@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 12:00, zhuyinbo wrote:
> 
> 
> 在 2023/6/8 下午4:53, Krzysztof Kozlowski 写道:
>> On 08/06/2023 10:39, zhuyinbo wrote:
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
>>>>> index 000000000000..423ee851edd5
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls2k-spi.yaml
>>>>
>>>> Filename based on compatible.
>>>
>>>
>>> There will be more ls2k series SoC spi device in the future thus I still
>>> use "loongson,ls2k-spi.yaml" for cover it.
>>
>> Add them now.
> 
> 
> The 2k0500 doesn't support CCF and not use CCF to gain clock and We
> internally tend to prioritize supporting 2k1000.

Don't you refer now to drivers? Because how hardware can not support
clocks if it has them? How CCF is anyhow related to hardware?

> 
>>
>>>
>>>>
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
>>>>> +      - loongson,ls2k1000-spi
>>>>
>>>> No compatibles for other devices? Didn't we have big discussion about this?
>>>>
>>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>>
>>>
>>> There are other ls2k SPI devices compatible, such as,
>>> "loongson,ls2k0500-spi", "loongson,ls2k2000-spi" but currently I plan to
>>> add ls2k1000 spi device first, Other ls2k SoC spi device adaptation may
>>> require some additional work and I will add it later.
>>
>> Previously you claimed this serves entire family, so I don't understand
>> why you need to fix something. Why previously it was working for entire
>> family but now it does not?
> 
> 
> It can work was for ls2k1000 and ls2k0500 and it specifically refers to
> spi driver. but 2k0500 doesn't implementing a clock driver and doesn't

We do not discuss here drivers, but bindings. Whatever your drivers are
not supporting, matters less.

> use CCF to gain clock but can use "clock-frequency".  Is it necessary to
> obtain a clock based on CCF? If it's necessary, then it seems that it
> can only added 2k1000 spi first.

Not related to bindings...

Best regards,
Krzysztof

