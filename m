Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCAE664E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjAJWSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 17:18:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbjAJWSg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 17:18:36 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694095B4B4;
        Tue, 10 Jan 2023 14:18:34 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id n190so9957433vsc.11;
        Tue, 10 Jan 2023 14:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CvfiNm0WJyHyuoYnmqirwokdxtOSW51hrMXv9a0fkss=;
        b=eNh17eckrg8U0lBfR4ylmbQPn+TgH5QkCYJJzOyh9UDqKpVJaqGL/9VixR6PRGNyTe
         n5VTHe80nju1fw0npVfZ+EcE4LG29xShsmqbtiNMS35kSiTBeQQdituarS7FpHJ6jSkO
         zJddLrAWBdQM1+puLF/EvZSmLoNNy/jTU+aXaucf9WuHC/Dc6FZnJmN18NCR84YSTVfV
         tknLRY++sO1xNS8JS/8l/wCCUTwyS2FqoIN978dxyNgqmzd1f2nISJoGzo/JZUnUKnPf
         WXk7wdfbkhbF6tmQ1F7UwhhF/prYosuEw/NS6Ep4aEv7xY7Q8noIsA8tP/hxgr0MsEPU
         QbbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CvfiNm0WJyHyuoYnmqirwokdxtOSW51hrMXv9a0fkss=;
        b=gLEZ2FGPCCw2B8FIvToBgpDneptwu2ipncNj/BR37e4diSopCu8Wx6rqRH3jhCj1CZ
         Fsj90d1IHzIM2MAZSfbZlO4hMoN5ErpReFtQDBAwcPSW4wcuDf3p/WfJTFSlCnLdMI+w
         /GrOEOu8B1wFkA7G9QrOFWX1LYzsK4Tb/lAT7QuK9tNyOARJorlehOXr9RBaiJ3AILrB
         VnjcQwn07ZPJaf937f1bRgRWnofljGZM6WRVl3AmCG4XrmHVL0ilzTmaIri6jGXPs74c
         dqIbNCgwY/alpCHoQjRfGw6J3w3eyhki1gSDwguSlfC1K7BeeA6Gm4ww387RHMLnhF3H
         AXEA==
X-Gm-Message-State: AFqh2krFOP1S0xnBOBeMPOa/D5mQQrmQyCFKRHd5m6KwGi7CBgfKpyWb
        QorR8wOK+M79D93AfyQaytM=
X-Google-Smtp-Source: AMrXdXt941idrP7caAjFbSXAN9KlUWV6nFXpFD8Lxpyfp3VNjrj2xrDsBwGzqCt5ABQsxiwv1bGJWw==
X-Received: by 2002:a05:6102:244c:b0:3c5:ec9a:9347 with SMTP id g12-20020a056102244c00b003c5ec9a9347mr377567vss.5.1673389113334;
        Tue, 10 Jan 2023 14:18:33 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id l16-20020a37f910000000b00704df12317esm7916500qkj.24.2023.01.10.14.18.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Jan 2023 14:18:32 -0800 (PST)
Message-ID: <32a464f8-6a4b-6777-9775-f17e990e0c6a@gmail.com>
Date:   Tue, 10 Jan 2023 14:18:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <b246a81f-e465-5e52-f0ce-65e0a82fc3e1@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 00:40, Krzysztof Kozlowski wrote:
>>> No, it is discouraged in such forms. Family or IP block compatibles
>>> should be prepended with a specific compatible. There were many issues
>>> when people insisted on generic or family compatibles...
>>>
>>>> Otherwise we will have to have a compatible string with chip model for
>>>> each SoC even they share the same IP. We already have more than ten of
>>>> SoCs and the list will increase.  I don't see this is a good solution too.
>>>
>>> You will have to do it anyway even with generic fallback, so I don't get
>>> what is here to gain... I also don't get why Broadcom should be here
>>> special, different than others. Why it is not a good solution for
>>> Broadcom SoCs but it is for others?
>>>
>> I saw a few other vendors like these qcom ones:
>>    qcom,spi-qup.yaml
>>        - qcom,spi-qup-v1.1.1 # for 8660, 8960 and 8064
>>        - qcom,spi-qup-v2.1.1 # for 8974 and later
>>        - qcom,spi-qup-v2.2.1 # for 8974 v2 and later
>>    qcom,spi-qup.yaml
>>        const: qcom,geni-spi
> 
> IP block version numbers are allowed when there is clear mapping between
> version and SoCs using it. This is the case for Qualcomm because there
> is such clear mapping documented and available for Qualcomm engineers
> and also some of us (although not public).
> 
>> I guess when individual who only has one particular board/chip and is
>> not aware of the IP family,  it is understandable to use the chip
>> specific compatible string.
> 
> Family of devices is not a versioned IP block.

Would it be acceptable to define for instance:

- compatible = "brcm,bcm6868-hsspi", "brcm,bcmbca-hsspi";

in which case, having a fallback compatible on the SoC family that sees 
this IP being deployed is very useful for client programs of the DT 
(u-boot or kernel). As long as the fallback works, we use it, the day it 
stops and a quirk needs to be applied because SoC XYZ has a bug, match 
the SoC XYZ compatible string.

FWIW, and feel free to rant at me, we have adopted this convention a 
while ago for STB chips whereby we want bindings to be defined with:

<chip specific compatible>, <version of the IP>, <fallback>

and the fallback may, or may not be matched, but defining in does not 
hurt at all, in fact it dramatically helps with the boot loader looking 
for specific nodes because it can search for the fallback.

If the version specific compatible is not available, it does not get used.
-- 
Florian

