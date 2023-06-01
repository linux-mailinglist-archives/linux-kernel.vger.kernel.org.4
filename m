Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E78371A2C1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbjFAPbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234915AbjFAPat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:30:49 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D9EE45
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:30:29 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-973bf581759so141683666b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685633426; x=1688225426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0RKWAWxwUQS0njV+ALKABSSpPIY8XnKRGM2dVeuKYE=;
        b=OHrOQLzvB/BGyMn7OZJnDoroAwTDdoB7T099vvVDfXz4IPX9iuevZem6ECGA0RHrcl
         NPm2L/+Xa6Lgs0/dcgQYKlOs4Hacn78ktFhJrAnRMjhEyrXYhsXxN7PS0MG2oddc+N0+
         xSVgflbjWdrqK7r7Os0FwVr8+2o/k6Jwrt9VdlLnTxKzV6Vif+w04+5kABEO2umJwwlG
         NvdDcaxtIXl/UFYCImVJGNJvUFcS5lUGuHfchZQksxuqixAsypachCtDncYDHbFQrW2b
         hoUM2sl7KVBfm9DT5mOqPLUEjQYEp1U2j1ChaAMHFW9XIZ+dgwN2Cxu2fMP6BiGQfGhf
         YQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685633426; x=1688225426;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0RKWAWxwUQS0njV+ALKABSSpPIY8XnKRGM2dVeuKYE=;
        b=FKjhm1ODVX383GZoEO9zCC/2Se9M0ftuytIhfMdMCNNDPaqbki2kg7uHMjVAzGrWFe
         x7HUCL/Qv4i7kd4rQoEesxgaf9y466Tic0ujKl/xTs515jmpm+7+HYbW86kpVni9Mjoq
         7eX6IofFRBSZLsl0yRAeAto4yen6hqMLcnXmKDBljJTuGqwdoDZC6CgjkgBe1EfcvgCH
         CEGNRocSrc9VyB3tG29X7V+nHH0EfFHjU1/nfD7+HpF/NUp/eryEPouqAF15htwFa+CA
         VdV2bspBrrZNf3VuuKCFNY8+IsvK/nAHpbCkg958yyQHrW8n0G8BhPthkd5NL3nUI1fk
         WAHA==
X-Gm-Message-State: AC+VfDzteqceRtO8TOBq/+iBUgH+y9y2tqXjNwVxEBGvZfBRB0Ljk2Mv
        bmSQVFaY5fi0OKgcKQ+MLZPYDA==
X-Google-Smtp-Source: ACHHUZ5oxQb75rdiZQ5dyM6H9Gb3YjpwUqyEzQQqXD9woiNfnlULUcZCVmMFF8hOoopHO9xklMvx8Q==
X-Received: by 2002:a17:906:da8e:b0:966:5035:6973 with SMTP id xh14-20020a170906da8e00b0096650356973mr8590202ejb.50.1685633426478;
        Thu, 01 Jun 2023 08:30:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id va15-20020a17090711cf00b0094ee99eeb01sm10696291ejb.150.2023.06.01.08.30.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:30:25 -0700 (PDT)
Message-ID: <25c30964-6bd3-c7eb-640a-ba1f513b7675@linaro.org>
Date:   Thu, 1 Jun 2023 17:30:23 +0200
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
 <2196dd29-93ee-00f7-65b4-ede73aa8ba77@linaro.org>
 <1b141df2-3e31-089e-1e05-0e268b60d074@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b141df2-3e31-089e-1e05-0e268b60d074@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 11:51, zhuyinbo wrote:
>>> Yes, it is make sense as it can reduce the workload of the community.
>>> For the Loongson platform, the versions of spi peripherals are almost
>>> the same, except for a few  or individual SoCs.  And we have also
>>> discussed compatible internally, and we tend to define it this way.
>>
>> So you have chosen different path than what's clearly recommended by
>> community, existing experience and documentation:
>>
>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>
>> Family names are not accepted as specific compatibles. Whenever they
>> were accepted, it lead to problems. All the time.
> 
> 
> Thank you for your documentation and advice and the Loongson platform
> have loongson-2h (ls2h), loongson-2k (ls2k), loongson-2p (ls2p) or other
> series SoC, which loongson-2 seems to be the family name you mentioned
> and the "loongson,ls2k-spi" should be a speific compatible name.
> 
>>
>> https://lore.kernel.org/all/20220822181701.GA89665-robh@kernel.org/
>> https://lore.kernel.org/all/78651e07-6b3e-4243-8e1f-fcd1dfb3ffe1@www.fastmail.com/
>> https://lore.kernel.org/all/288f56ba9cfad46354203b7698babe91@walle.cc/
>> https://lore.kernel.org/all/106e443a-e765-51fe-b556-e4e7e2aa771c@linaro.org/
>> and many many more discussions.
>>
>> You should choose carefully, because we will keep NAK-ing adding
>> properties to circumvent missing compatibles.
> 
> 
> I have read the documention and patch link that you mentioned and it
> seems to advice that We don't have wildcard names in the compatible
> string and use wildcard names that will cause issue. and the compatible
> "loongson,ls2k-spi" that wasn't a wildcard names, and if the loongson-2k
> spi controller hardware upgraded or changed the I will use
> "loongson,ls2k-spi-version" as a compatible, such as,
> "loongson,ls2k-spi-v1.1", "loongson,ls2k-spi-v1.1a" or other.

Versions? Why? They received a lot of comments in the past, let me just
paste to avoid repeating the same:

https://lore.kernel.org/all/20220926231238.GA3132756-robh@kernel.org/

(and many more discussions on devicetree mailing list)

> 
>>>
>>>> Or am I misunderstanding and all ls2k SoCs do work with this driver and
>>>> you were talking about other, future products?
>>>
>>> Actually, in 2k500 has one special type spi was only one cs and their's
>>> register definition was different from common type spi thus this driver
>>> doesn't support but this driver can support another common type spi in
>>> 2k500.  for this special type spi I will add support as needed in the
>>> future.
>>
>> Bindings are for hardware, not driver. What does your driver support or
>> does not, matters less.
> 
> 
> okay, I got it, and the loongson spi bindings was for loongson spi
> controller hardware. if the spi controller hardware not changed in
> different ls2k SoC and the spi compatible should be same thus loongson
> spi compatible seems to be adhere to the bindings aggrement.

Specific compatible - yes. Unspecific - not, because you disregard the
clear message in the guideline.

Best regards,
Krzysztof

