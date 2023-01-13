Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4A3668F5F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 08:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239005AbjAMHmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 02:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235371AbjAMHl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 02:41:58 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7606085D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:41:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id mp20so3724614ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 23:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jZVPkMKH4dg9LBMPAxa9vHTcN8f+QCAxm1Sdx9qwJU=;
        b=J3aaWsdWmJTehzMVhoxONIh9ExogjBLIzEuEIE3yW7JL3XtFYWNVDekd1+bBX5A4Og
         pCo7uFCd10bjUtrzNej37f+xKmypWmiow14s5Gb7NcWfW1dA+zIUw2twoRiQKVMbMhW3
         eRMBcemDO8IoRsKkRnmccerajwNuBFb4xibsqig8UaEAlBj4G11Pqm1HzJYxxU7tWP4t
         5Xo5Z3L+/bnpDb2blNP6X2ZIHAuxumGO0XwsO5z1T6uZks4nGG3KeHsq+LBKheCuSIgC
         GC+fYX+wj4eeP0kHCeDuUlRM7bAyV2lsVtJBNIxdS2jyBEepDmoBgBhu5vANKa5eNG3Z
         hoBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jZVPkMKH4dg9LBMPAxa9vHTcN8f+QCAxm1Sdx9qwJU=;
        b=Gx3pxc21onGUewmqxxCIJTlP8xXIktcXuT6e/oupmFBX4uxiWUfeJNg+2G5a5XYmo/
         exfmHz/59Iirk7Ztjn+zBHKZLdgXCWNWOIBOEjyspkO6yxSRTkxuMYNTJTUqy2Td1nRe
         4xex1O5PuAH8d1w8Q86ryNGQ/HMDR3YMV63lxST/yZz4jsouEJi1V6ZFYhLKaeYENFEG
         68vAbl/6CoBhS2hZKz/glUlYwDGO9W/VKS/tUABmTfvdRdFKHgkH4BfuLAmc8+gjJz0+
         59pFTwpNR3TtTNkcVtl0KcBgRpEtPLDX1J2XLhLwAgUmC5BBv7ajLo9gzJX9qa3iF2dT
         hNRw==
X-Gm-Message-State: AFqh2kpfgegEuhMpQ2o2HoIW2G1fMwSNL0vnqC/cgAdUCMg9Io8luYVq
        thesOcMuSyxh4twh38uKFXgN5A==
X-Google-Smtp-Source: AMrXdXuQPiGyD2HBuR8sg3rcbklpELPTDaituTJoWc3bimEkPQJMxFjPT8IVOo9o7LHXkoI573hwSg==
X-Received: by 2002:a17:906:468d:b0:7c0:a5c8:d14f with SMTP id a13-20020a170906468d00b007c0a5c8d14fmr66826201ejr.77.1673595716005;
        Thu, 12 Jan 2023 23:41:56 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id 18-20020a170906311200b0084b89c66eb5sm8202096ejx.4.2023.01.12.23.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 23:41:55 -0800 (PST)
Message-ID: <f4356898-de35-9728-5395-baecb07c843f@linaro.org>
Date:   Fri, 13 Jan 2023 08:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
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
 <f0a50234-bc8c-09c4-e2c1-22cbeaba5c15@linaro.org>
 <e99a71b2-0b05-1a53-1c29-3778b49a3b86@broadcom.com>
 <0cc43891-405e-418f-01ee-845d680b3a24@linaro.org>
 <14a48b44-962e-1839-4fbb-1739ba8dbc35@broadcom.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <14a48b44-962e-1839-4fbb-1739ba8dbc35@broadcom.com>
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

On 12/01/2023 20:50, William Zhang wrote:
>>> No as we are adding chip model specific info here.  The existing driver
>>> spi-bcm63xx-hsspi.c only binds to brcm,bcm6328-hsspi. This driver
>>> supports all the chips with rev1.0 controller so I am using this 6328
>>> string for other chips with v1.0 in the dts patch, which is not ideal.
>>
>> Why? This is perfectly ideal and usual case. Why changing it?
>>
>>> Now I have to add more compatible to this driver and for each new chip
>>> with 1.0 in the future if any.
>>
>> Why you cannot use compatibility with older chipset?
>>
> IMHO it is really confusing that we have all the SoCs but have to bind 
> to an antique SoC's spi controller compatible and people may think it is 
> a mistake or typo when they don't know they are actually the same.

I am sorry, this is ridiculous argument. It's like saying - people
cannot understand what they are reading, therefore we need to present
them obfuscated information so they will think something else than their
minds created...

> I 
> know there are usage like that but when we have clear knowledge of the 
> IP block with rev info, I think it is much better to have a precise SoC 

No, it's not particularly better and you were questioning it just before...

> model number and a general revision info in the compatible. As you know 
> they are many usage of IP rev info in the compatible too. 
> brcm,bcm6328-hsspi will stay so it does not break any existing dts 
> reference to that.

Anyway your ship sailed - you already have bindings using SoC  versions...

> 
> Anyway if you still does not like this idea, I will drop the rev info 
> and you have it your way.

Best regards,
Krzysztof

