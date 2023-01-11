Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6936656DF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 10:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbjAKJF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 04:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236588AbjAKJEc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 04:04:32 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C0A15819
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m3so10616668wmq.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 01:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jayg4ZreJdJdft84zMpQKgU5NC7skf1NU+gqLmjc7vs=;
        b=kKZYLptAWmtXDFshJo4N2fcCUdZ/owDOuJBXW1RYEKuO6De/8wUEJx6qZ4HS6Vj3lp
         GdWt+9lCKjqvuh9uSWx1A79yXiy/yutRGhwsiJ/5xKW6Q+XHs8KFDSmXXNu6jewavxmk
         1tXc+9Ek7w4/qDwJ/58/mAKdQjk0bZe5Lk3YFKdQiOQ7PfeHCa9v5F8sRBDVCPz/o4QW
         7piLErCOoqjKu104gaUjBXlcdKKrDBJNtdUAFWMQW+DHYIFeNuLLvy6a/vS1lqIsY/Kg
         wVBomDwxbsq8S/gnwsKSWbUVXQf1SKOrQubj00HTg6xeAOJXnycs6VSvQJ9vVHGSj+tt
         1dhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jayg4ZreJdJdft84zMpQKgU5NC7skf1NU+gqLmjc7vs=;
        b=C7I/8/Ta9jWumIR/GongjP9nq8Gm0DyGtMDDm98L7hOKA+CcQCCRwe24wILA8dDyVO
         cRADLt0Xvt0nX6nk2jQlVMi5BOkqy6zHBtf91yPngbpEAwoHWkIPlxOem/dix00Z2+SM
         zqMWqCFmpAtBJgnxCiraabXu6nstnA1o/bnfruwCtqJjAFjntn+gZyyqTmIcgpzCgKaR
         njRF3cZPc+5baYtQN7tjrKghDVprjVN3LWag445AA3VAqFBOIippkxwK8tpFJkvwEzJh
         ZEmHGm2Jw6N+pt7HR6pLQDTgTeC0BcbVBqS3zfkfRBHohQhB8uEsbCXsCuiIsguJTz/3
         gB+Q==
X-Gm-Message-State: AFqh2koTqwgA0MDv5qa+lPS5XMrlgJHciQ5fyAwiSVezrhNSVa+sJQxh
        cgyFGySdvVwsez7AbMNh9Uj72Q==
X-Google-Smtp-Source: AMrXdXuMLV5O/x02mc56Rcm657IsU6f4NJfYHOW4ZfdpJ0pELh2LuBYStHhDWcxIBUE03xHkzcj3EA==
X-Received: by 2002:a1c:4b04:0:b0:3c6:f0b8:74e6 with SMTP id y4-20020a1c4b04000000b003c6f0b874e6mr52794503wma.4.1673427773355;
        Wed, 11 Jan 2023 01:02:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003d9f15efcd5sm8772274wmc.6.2023.01.11.01.02.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 01:02:52 -0800 (PST)
Message-ID: <71c2e796-f0fb-90cd-4599-13c9718f41d5@linaro.org>
Date:   Wed, 11 Jan 2023 10:02:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        William Zhang <william.zhang@broadcom.com>,
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2023 23:18, Florian Fainelli wrote:
> On 1/10/23 00:40, Krzysztof Kozlowski wrote:
>>>> No, it is discouraged in such forms. Family or IP block compatibles
>>>> should be prepended with a specific compatible. There were many issues
>>>> when people insisted on generic or family compatibles...
>>>>
>>>>> Otherwise we will have to have a compatible string with chip model for
>>>>> each SoC even they share the same IP. We already have more than ten of
>>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>>
>>>> You will have to do it anyway even with generic fallback, so I don't get
>>>> what is here to gain... I also don't get why Broadcom should be here
>>>> special, different than others. Why it is not a good solution for
>>>> Broadcom SoCs but it is for others?
>>>>
>>> I saw a few other vendors like these qcom ones:
>>>    qcom,spi-qup.yaml
>>>        - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>>        - qcom,spi-qup-v2.1.1 # for 8974 and later
>>>        - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>>    qcom,spi-qup.yaml
>>>        const: qcom,geni-spi
>>
>> IP block version numbers are allowed when there is clear mapping between
>> version and SoCs using it. This is the case for Qualcomm because there
>> is such clear mapping documented and available for Qualcomm engineers
>> and also some of us (although not public).
>>
>>> I guess when individual who only has one particular board/chip and is
>>> not aware of the IP family,  it is understandable to use the chip
>>> specific compatible string.
>>
>> Family of devices is not a versioned IP block.
> 
> Would it be acceptable to define for instance:
> 
> - compatible = "brcm,bcm6868-hsspi", "brcm,bcmbca-hsspi";

Yes, this is perfectly valid. Although it does not solve William
concerns because it requires defining specific compatibles for all of
the SoCs.

Best regards,
Krzysztof

