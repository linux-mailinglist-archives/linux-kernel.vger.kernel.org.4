Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56DD6B9F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 19:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231207AbjCNSuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 14:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjCNSuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 14:50:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36F287D87
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:49:50 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id eh3so10131845edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 11:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678819785;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gBqiK1fdiFoyIe6lFlpNE74OL7vWLnZXHV8Umjh/RwI=;
        b=u3c2wd57cK4063pHJt0R2Yaki9WqT5225lQ1H3T9wOvlA6LS31Qcp8or6MsK7KTDW6
         9x4HZFSgSIy1hynhnjE2xvZmC6GEpzh7Vgg5ipjxp0WAHqtR+VCpK/rWpi39Y1qR46KW
         GgZCHpNu6zD6EBNZWjfVkz62fJCbXKpMoRl2p7btdjUxHNq2RSovEOwZG6Zbv3JLhZJE
         VxFbW1DvawNQttmI5x5S7KksSSwVK+pAW6iadntCVLaIC1xnT8tnWUGZn7m28EJ7YMY2
         Itj0aKXiHsfo9yEjZlaaqjJ2lUaN0Ygw+2fsKGVQwWQvvcDJiuERacS5AjlQhV/bxi0P
         yrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678819785;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gBqiK1fdiFoyIe6lFlpNE74OL7vWLnZXHV8Umjh/RwI=;
        b=7DKNjdSw+TvOsBoncGCkGy4N58feusy7qxFuuUvTLZ/NDec71+g9KbEwyFJY2bRU8Z
         WGdr53d2jHaAHBLuJikPI7Lsk1v9S9wI8YxnpCjvNAD9AuUUbpddOdsvuAOHObFzDXNi
         VVnMuCaPZOUR9xTRMxSX3xa1EAR92csex6WibaiK+J4NOVGmZi06Be8aZsuMTp4B8v1Y
         MEbBpYc+rxvmugLs6qMFZIMX3fOSGG9M2dMRiH+zOekTCBXQQURoW8hxgfpgCw8wfNA7
         kHTNcB0Ds7KzGEoGkoWVtpNFe829gsX7HDZOtZpriyE4O9fMvIdngJ8ZvhcABf929GiB
         FifQ==
X-Gm-Message-State: AO0yUKWzKhKD+qmVDK1hfC3MZQmKpESpvqS5X3LodRwURET1mDdRswSK
        ujPj6zsMyWIZNAaaOfIuNgfIig==
X-Google-Smtp-Source: AK7set9ZDuvkK4/qn7ZMxcqNEOy3LLVe0sAT16GfKhVSVwJkeqBrHWEzjDn2v7RTuOZOuylmf3DpIg==
X-Received: by 2002:a17:906:9f0a:b0:8a5:8620:575 with SMTP id fy10-20020a1709069f0a00b008a586200575mr3423467ejc.3.1678819785002;
        Tue, 14 Mar 2023 11:49:45 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:59be:4b3f:994b:e78c? ([2a02:810d:15c0:828:59be:4b3f:994b:e78c])
        by smtp.gmail.com with ESMTPSA id r23-20020a50aad7000000b004f9e6495f94sm1441787edc.50.2023.03.14.11.49.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 11:49:44 -0700 (PDT)
Message-ID: <c45406e4-51e5-0df6-4b53-6355a56a0a34@linaro.org>
Date:   Tue, 14 Mar 2023 19:49:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 2/3] arm: dts: nuvoton: npcm: Add sgpio feature
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230314092311.8924-1-jim.t90615@gmail.com>
 <20230314092311.8924-3-jim.t90615@gmail.com>
 <5c38d97d-af2a-51b5-7b4d-bac69321e5ad@linaro.org>
In-Reply-To: <5c38d97d-af2a-51b5-7b4d-bac69321e5ad@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 19:47, Krzysztof Kozlowski wrote:
> On 14/03/2023 10:23, Jim Liu wrote:
>> Add the SGPIO controller to the NPCM7xx devicetree
>>
>> Signed-off-by: Jim Liu <jim.t90615@gmail.com>
>> ---
>> Changes for v5:
>>    - remove npcm8xx node
>> Changes for v4:
>>    - add npcm8xx gpio node
>> Changes for v3:
>>    - modify node name
>>    - modify in/out property name
>> Changes for v2:
>>    - modify dts node
>> ---
>>  arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi | 30 +++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
>> index c7b5ef15b716..7f53774a01ec 100644
>> --- a/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
>> +++ b/arch/arm/boot/dts/nuvoton-common-npcm7xx.dtsi
>> @@ -330,6 +330,36 @@
>>  				status = "disabled";
>>  			};
>>  
>> +			gpio8: gpio@101000 {
>> +				compatible = "nuvoton,npcm750-sgpio";
>> +				reg = <0x101000 0x200>;
>> +				clocks = <&clk NPCM7XX_CLK_APB3>;
>> +				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>> +				bus-frequency = <8000000>;
> 
> Does not look like you tested the bindings. Please run `make
> dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).

Eh, wrong key shortcut. Should be:

Does not look like you tested the DTS against bindings. Please run `make
dtbs_check` (see Documentation/devicetree/bindings/writing-schema.rst
for instructions).

Best regards,
Krzysztof

