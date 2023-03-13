Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3EC6B6F91
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjCMGnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCMGm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:42:59 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA152D71
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:42:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id k10so44216750edk.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:42:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678689774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ct3fbY7RVEKB9YRXgDHYdKGpI1hyfFOcZ+mEvPScFNw=;
        b=CSHSDudwYP7AsHbyClAvWnm3t5hhLx9PcYp7yd1rS6Y4FNABLARXs8qtx42oUW3czp
         7yuootjZD8mNkRSc6zZuExApEMA8t2bJR5yQmpeWC5Pq52xCb7lMvVVr1FXf16K/loj8
         3ZeUCapZT6oZCumAmO5/NPdBOcSw4UIINH/iL9BGSB6LjC2DSTnf8LHIhr/ybYLoLP5G
         xMPE1zysB/et9Uz46sdllTWVyOIOOEHToK+CQjWVBfI7MQmBdelk2158YhqzIdyd0hSZ
         j5sp5yHTDPE1QHVFQQJ5nitlaPSXaXyQb+UOiuK24r4vtsrg3e7YmR8Z+xXNiK8SX6Zu
         C0+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678689774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ct3fbY7RVEKB9YRXgDHYdKGpI1hyfFOcZ+mEvPScFNw=;
        b=viETYPU2pJgz1FpBHbxztPUEZs6BmBfixIdCbPG5quRDb6sfjhG5h7NTc+ChMWNH93
         pPhf6QuLKOSFObH3RitO0rJ9yBCUCq6qbBuMjkSZFWavRvBiy5mMQ820SqEJ7P2DIhuF
         RaGZbulwt7pANxoYfsjbVbFNPx4AsWdKJ5vBI6RptI4Y6pcOSEjH6QpC7nIxR+6/ubMy
         zd2ZqE452Ww03Zux20GLczzQUMOYy5sL33nZAiizAbbXUWvJBL646xfd65W5ciSlSfWD
         1pCRtcl0fVSgjQSaDCELtq2ojl3PinaeGFvPnbj5HUM43xhgflmD1vOaZA2hrepff7/7
         B2dQ==
X-Gm-Message-State: AO0yUKVOmu5BVKijQeVK52FiBWYcKiWGJUs8H8NSz/wibZ8+R3kW/xn0
        waa9IsXZsXXhRbyKmMGuMqzH/g==
X-Google-Smtp-Source: AK7set8BOVZLBV0Vjn5uzvQJAYs2AWPASTtYs1zyPvWJ/7yY4iX5x4DALEaseEbwtC+lNjy6+Gx6PA==
X-Received: by 2002:a17:906:5387:b0:8b1:7857:2331 with SMTP id g7-20020a170906538700b008b178572331mr29766278ejo.65.1678689773789;
        Sun, 12 Mar 2023 23:42:53 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:f052:f15:3f90:fcb3? ([2a02:810d:15c0:828:f052:f15:3f90:fcb3])
        by smtp.gmail.com with ESMTPSA id s3-20020a170906bc4300b008c1952b63d8sm3054372ejv.137.2023.03.12.23.42.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Mar 2023 23:42:53 -0700 (PDT)
Message-ID: <b43463d7-032a-93be-889f-4bb6a2a7377a@linaro.org>
Date:   Mon, 13 Mar 2023 07:42:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: spi: add loongson spi
Content-Language: en-US
To:     zhuyinbo <zhuyinbo@loongson.cn>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
References: <20230308025908.21491-1-zhuyinbo@loongson.cn>
 <20230308025908.21491-2-zhuyinbo@loongson.cn>
 <8d20dcfb-480b-3f1a-02b0-294a05a566f7@linaro.org>
 <dd2e6c68-7460-caa1-0d54-53aeb5619a18@loongson.cn>
 <ecd867a1-207d-774f-882b-22f0973286ae@linaro.org>
 <9bfeef4b-f498-12d1-6f21-97289a3127bd@loongson.cn>
 <29b2a024-8b5a-70ff-17b6-0fb46d871925@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <29b2a024-8b5a-70ff-17b6-0fb46d871925@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/03/2023 03:09, zhuyinbo wrote:
> 
> 在 2023/3/9 下午3:22, zhuyinbo 写道:
>>
>> 在 2023/3/9 下午2:23, Krzysztof Kozlowski 写道:
>>> On 09/03/2023 03:08, zhuyinbo wrote:
>>>> 在 2023/3/8 下午7:30, Krzysztof Kozlowski 写道:
>>>>> On 08/03/2023 03:59, Yinbo Zhu wrote:
>>>>>> Add the Loongson platform spi binding with DT schema format using
>>>>>> json-schema.
>>>>>>
>>>>>> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
>>>>>> ---
>>>>>>    .../bindings/spi/loongson,ls-spi.yaml         | 47 
>>>>>> +++++++++++++++++++
>>>>>>    MAINTAINERS                                   |  6 +++
>>>>>>    2 files changed, 53 insertions(+)
>>>>>>    create mode 100644 
>>>>>> Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>> Filename matching the compatible.
>>>> loongson,ls-spi.yaml is for ls2k-spi and ls7a-spi, I will add following
>>>> desription:
>>>>
>>>>
>>>> properties:
>>>>     compatible:
>>>>       enum:
>>>>         - loongson,ls2k-spi
>>>>         - loongson,ls7a-spi
>>> OK then.
>>
>> I was to explain why that yaml was name as "loongson,ls-spi.yaml" 
>> rather than "loongson,ls2k-spi.yaml"
>>
>> because that need consider about  yaml filename to match 
>> "loongson,ls2k-spi" and "loongson,ls7a-spi".
>>
>>>
>>>>>> diff --git 
>>>>>> a/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml 
>>>>>> b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>>> new file mode 100644
>>>>>> index 000000000000..8a13a96b3818
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
>>>>>> @@ -0,0 +1,47 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>>>>> +
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: "http://devicetree.org/schemas/spi/loongson,ls-spi.yaml#"
>>>>>> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
>>>>> Drop the quotes. What was the base of your code here?
>>>> okay, I will drop the quotes.    and I don't got it  about the code 
>>>> base
>>>> that you said.
>>>>
>>>> you meaning is advice me add a line  as follows ?
>>> I meant, from which other file did you copy it?
>> okay,  but I maybe forgot it,  I should be refer other spi yaml file.
>>>
>>>>>> +
>>>>>> +  clock-names:
>>>>>> +    const: boot
>>>>> Drop clock-names, not needed for single entry.
>>>> if drop the clock-names entry, the yaml file will compile fail.
>>> Obviously you have to also drop it from DTS and driver...
>>
>> drop clock-names should be not  affect my driver,  but I notice other 
>> lots of arm64 platform dts
>>
>> was keep clock-names and clock in dts when use grep search "clock-names".
>>
>> [zhuyinbo@localhost www.kernel.org]$ grep -rns "clock-names" arch/arm64/
>>
>> arch/arm64/boot/dts/sprd/sc9863a.dtsi:280:            clock-names = 
>> "apb_pclk";
>> arch/arm64/boot/dts/sprd/sc9863a.dtsi:305:            clock-names = 
>> "apb_pclk";
>> arch/arm64/boot/dts/sprd/sc9863a.dtsi:330:            clock-names = 
>> "apb_pclk";
>> arch/arm64/boot/dts/sprd/sc9863a.dtsi:367:            clock-names = 
>> "apb_pclk";
> 
> so , if you think it is okay I will keep clock-names and clock in yaml 
> file like other platform.

No, it's not ok.

Best regards,
Krzysztof

