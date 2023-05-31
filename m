Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59688718AC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjEaUGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjEaUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 16:06:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EEEC0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:06:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-96f5685f902so937769166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 13:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685563573; x=1688155573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=88XdFTbrHk+zgo/9nKqPMnV1vAS6bpV3qe5bGBfKbI0=;
        b=PGoUcW6+SxAtu7vhFcbSBfivY0amCpnP460PJo6/2mY9RuUP2Iz14tObAADJwd2IDc
         lERlre9LpQDO9fA1jilp3iKM5WSG/S6+7ZjJ1DBsdB2x4VtnCxvezcWUDVAJ9jgsFO9Z
         H4+w1J2oJvWn1+9ZmTNTjPrUAUkmvi2+M9pQgPZOG4MHtkORe61ehz4EC4mTGbUPb1bH
         9QWa9gp7aHE3fT67NrkAE0xkPnSbnt9cOKVK5RZh2urel1SE6CbCiVJRxpAmvFoC+BGS
         se9rk0Ogl1IbAbRUnbg9hwaNfxaApsDh4Xpjbsxpf9Zim0yrrhaUiA1gzQF51F+PDN4f
         wciA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685563573; x=1688155573;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=88XdFTbrHk+zgo/9nKqPMnV1vAS6bpV3qe5bGBfKbI0=;
        b=jwZIiUkO9Tw70iWC0huy91JlxBK2s1zhT+w9p7h3lDUKEQ1Mx5WZ4y5GIGLFm15M6f
         REHXC/fdT/XYnd4YLYL/5LB9ocqSJTJiCSmuukF8fz0OBeOzzuqYheJ1bC4PdUMt33qD
         F3m4ztj5Mp/aBGZIiydRPV9Bod0TvGznWZLlSt4MnW+JIEtisl3h9hQHZAt+W+1RW1l0
         /b4AU1hTpr6Uhhb0Li5qTGEmrpOUVDN5VWEFW8CDyKSgewJ3nyz9251CBKEeEvcq3zOG
         GsxopsaJfkFaJxxOrlMpgPyztXFlyUCvRZfmv47z2nA06HrHPiri1eB1oUXfQCWvESoG
         24iQ==
X-Gm-Message-State: AC+VfDxlK5l/xWT6u9FSq9kSWZ/dMrJUrI9Hb20PAt1aCA3ZkytJi3I/
        puVVIOZO/MgovT6pCUSTDo+jaw==
X-Google-Smtp-Source: ACHHUZ6KmoP6bptP/pGz93SaUyQcaMlvHz5fi8XBllRNIeD0ckXbO8Owp+k5OlkT/pW2zThiFn0soQ==
X-Received: by 2002:a17:907:6d93:b0:959:5407:3e65 with SMTP id sb19-20020a1709076d9300b0095954073e65mr6877104ejc.55.1685563572858;
        Wed, 31 May 2023 13:06:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id f13-20020a170906560d00b009603d34cfecsm9463283ejq.164.2023.05.31.13.06.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 13:06:12 -0700 (PDT)
Message-ID: <69d355ff-90e1-09d2-d4ff-0d7dedc8addb@linaro.org>
Date:   Wed, 31 May 2023 22:06:10 +0200
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

I missed it - that's a great comment. Hm, I don't know... Reviewing
Loongson patches is quite a work, so I don't see here reduced workload.

Please read existing guidelines:
https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst

All of them.

Best regards,
Krzysztof

