Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2F666294
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 19:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbjAKSNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 13:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235644AbjAKSNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:13:14 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D58F37523
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:12:56 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id m26-20020a05600c3b1a00b003d9811fcaafso13358037wms.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 10:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jgU48L7QcU60FOWGaPRhnxY2hkRU0gQ83LzvkNzDZlI=;
        b=eBtCnRqiaCviFjQSXzigKCV18OEyaN7SPUaZMyo5ABDVDcNsrE8xUe7ybl+GZQAw58
         ed+61NQMRxLfTjXL+c0znGQ39zzj7XQrKrFq6nQeTo/ofcCaJz8cmW3HcDpr055WXve7
         qD9VCQgEo1t/HwN6YiNQX6s0XtJNyiZcU7I4PVsxHl+A/BT3Qllelc7dyFWxAxrFlFlD
         /kKh11L/HTmg8XMx+57J455J3UPQEvvst9pQTUNpl+bfOwXC+nnRa0zY3pEIMct/ladV
         mLFigmxIDArqZxcRd3CPtkYnasnyHMV4OVSd+bshyNQBzPzbhaxtyFnl10nkfcEdFvBp
         Axhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jgU48L7QcU60FOWGaPRhnxY2hkRU0gQ83LzvkNzDZlI=;
        b=x9aSwzweD8tC/hpmjjK9Eb+7cQHV28Eq03Efk/nffX/oc/Y0xHmCQuptHIokqLaBta
         /yiCjrSQFfDzP4zLkabmOx1PMOiKgPHUrjlUxhkyQfuNCUOXYOOKsFqXFHdT4J9u1HUq
         7IDQFdGin5XY2E0TvQcCWk5WTcrdro2asbxCmE+yub+VRNiR38tXBXyGy9NnReNrnLHR
         Al0x2tKRsLl4E3AsyfyImZqruJs5xc2UjOJ80x7Tmz9xkvY73zL9KH65hHaK7KVYatWp
         ez7zG9U29tsYsHF0Y6+trRs5Q8NucDN8ZpEJaHL/eZP15qQWFOubAsC+sYw7UE6sqGLu
         7J+Q==
X-Gm-Message-State: AFqh2koqVxnVyri6MFYKUUD2kTFUk29Ap7XhkjybSnWHy3EYUf2nZJoT
        4SUYG/CUlpUJG89E+pt6IZcU/w==
X-Google-Smtp-Source: AMrXdXtTXdWfx04S0c5JPQS/5PFz740EqgtORn2SjwdLrrYbvVgQ7bkTBST0TFGnxuCnaI1+TDbTlw==
X-Received: by 2002:a05:600c:5121:b0:3d9:d1bc:310 with SMTP id o33-20020a05600c512100b003d9d1bc0310mr21356168wms.25.1673460774921;
        Wed, 11 Jan 2023 10:12:54 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p21-20020a7bcc95000000b003c65c9a36dfsm18607821wma.48.2023.01.11.10.12.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 10:12:54 -0800 (PST)
Message-ID: <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
Date:   Wed, 11 Jan 2023 19:12:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        jonas.gorski@gmail.com, kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
 <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
 <5dfac2d7-3b4b-9ded-0dde-26b289c604d0@broadcom.com>
 <99b01e96-3b96-6692-c5e1-87db49295e6d@linaro.org>
 <49925933-aacc-4f0d-a1ca-e1bd45b05eee@broadcom.com>
 <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
 <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
 <71c2e796-f0fb-90cd-4599-13c9718f41d5@linaro.org>
 <31644849-dc69-ddfc-a6b6-6ffd37d64d2b@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <31644849-dc69-ddfc-a6b6-6ffd37d64d2b@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2023 19:04, William Zhang wrote:
> 
> 
> On 01/11/2023 01:02 AM, Krzysztof Kozlowski wrote:
>> On 10/01/2023 23:18, Florian Fainelli wrote:
>>> On 1/10/23 00:40, Krzysztof Kozlowski wrote:
>>>>>> No, it is discouraged in such forms. Family or IP block compatibles
>>>>>> should be prepended with a specific compatible. There were many issues
>>>>>> when people insisted on generic or family compatibles...
>>>>>>
>>>>>>> Otherwise we will have to have a compatible string with chip model for
>>>>>>> each SoC even they share the same IP. We already have more than ten of
>>>>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>>>>
>>>>>> You will have to do it anyway even with generic fallback, so I don't get
>>>>>> what is here to gain... I also don't get why Broadcom should be here
>>>>>> special, different than others. Why it is not a good solution for
>>>>>> Broadcom SoCs but it is for others?
>>>>>>
>>>>> I saw a few other vendors like these qcom ones:
>>>>>     qcom,spi-qup.yaml
>>>>>         - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>>>>         - qcom,spi-qup-v2.1.1 # for 8974 and later
>>>>>         - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>>>>     qcom,spi-qup.yaml
>>>>>         const: qcom,geni-spi
>>>>
>>>> IP block version numbers are allowed when there is clear mapping between
>>>> version and SoCs using it. This is the case for Qualcomm because there
>>>> is such clear mapping documented and available for Qualcomm engineers
>>>> and also some of us (although not public).
>>>>
>>>>> I guess when individual who only has one particular board/chip and is
>>>>> not aware of the IP family,  it is understandable to use the chip
>>>>> specific compatible string.
>>>>
>>>> Family of devices is not a versioned IP block.
>>>
>>> Would it be acceptable to define for instance:
>>>
>>> - compatible = "brcm,bcm6868-hsspi", "brcm,bcmbca-hsspi";
>>
>> Yes, this is perfectly valid. Although it does not solve William
>> concerns because it requires defining specific compatibles for all of
>> the SoCs.
>>
>> Best regards,
>> Krzysztof
>>
> As I mentioned in another email,  I would be okay to use these 
> compatibles to differentiate by ip rev and to conforms to brcm convention:
> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.0", "brcm,bcmbca-hsspi";
> "brcm,bcmXYZ-hsspi", "brcm,bcmbca-hsspi-v1.1", "brcm,bcmbca-hsspi";


Drop the version in such case, no benefits. I assume XYZ is the SoC
model, so for example 6868.

> 
> In the two drivers I included in this series, it will be bound to 
> brcm,bcmbca-hsspi-v1.0 (in additional to brcm,bcm6328-hsspi) and 
> brcm,bcmbca-hsspi-v1.1 respectively.  This way we don't need to update 
> the driver with a new soc specific compatible whenever a new chips comes 
> out.

I don't understand why do you bring it now as an argument. You defined
before that your driver will bind to the generic bcmbca compatible, so
now it is not enough?

Best regards,
Krzysztof

