Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E122737CF0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 10:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjFUIEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjFUIEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:04:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3401BFE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:04:32 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-311167ba376so5526235f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687334670; x=1689926670;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CPBuD0hfcllQGTh5WqNHVA5zv/gzXAnk+NTTWVeHYTc=;
        b=zd0rlMjAtccV9iqyp/+iVgmNk8Vgd2/STCy1hZANr4Y60EQxIEiynGuJ4NYDYScQsd
         5J9wwPBTR45dJEFUaxEjaRkhbFq1X9rchqdktXcCehCzdQPZcnEVRwABcqS1SSoxnDCm
         2V4y2zkSt8OWlzixFBdlZeCae05aFQH3hHP0cJuri8AyHinZY0p+qXR0in4eXJoiqhuT
         XQugxK51RR3AcuKsZHziV/aB1stniM59iyiBgZAl8MIabaKHYLT2GORaGgNOXp1QbJfK
         1Ke1B8sENPNrmlR+ZYjf0a6lqbDDRvz1O+7S6rhUBtEcsThppRwJx1pPxkQWzDNlo2YA
         SI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687334670; x=1689926670;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CPBuD0hfcllQGTh5WqNHVA5zv/gzXAnk+NTTWVeHYTc=;
        b=M17q3/i8O52utYvV//3ksfK8KyEx9I3A8xK5gCl06w9ttv1i/NRe5/+I+nWW41BzE8
         yU3ytsXFjvJlQ+s0oQjbnvJRs95ad4QiGLCcLzKVvPt8gH9W+tUUQEyiE6/hi6/3LV3S
         Ni9ckbLt5HQK6PDhg8RSUBxt3bymKmGQMTmWCquHQEJnK1HnjID5Z8weUEY+TmnSruhj
         6hjQ4X5IxvY9Tg8uNyzjWqYmXjPiwuBDWRCZiSl5TdsxrcYtfOV53u0FNL5T54na+9Yl
         XIpM2lVL8YYLiMGASN9vNUq+vb70ZI4OTL8wjfxlL8hz68+XW2JkWiw65A6n4aJx/VPl
         8h0w==
X-Gm-Message-State: AC+VfDxp3yjR1eYU+QnWTpHcPcjY6718Q6dWoVO9IqCZlnxVhHYmmsZA
        TOo7quT/44bE8fJWMJERSK7PkA==
X-Google-Smtp-Source: ACHHUZ5M6VpCzKTbpZqsnQKndJo876Awl5O2+ZBZTlAVumRVz63cwUZ7Br2daEGLUzxtiRofknQp5Q==
X-Received: by 2002:a5d:440c:0:b0:30a:e511:e65c with SMTP id z12-20020a5d440c000000b0030ae511e65cmr10286387wrq.37.1687334670468;
        Wed, 21 Jun 2023 01:04:30 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:b158:3e69:8736:455d? ([2a01:e0a:982:cbb0:b158:3e69:8736:455d])
        by smtp.gmail.com with ESMTPSA id y9-20020adfdf09000000b0031122bd3c82sm3785271wrl.17.2023.06.21.01.04.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:04:30 -0700 (PDT)
Message-ID: <6fe5dfb6-5f18-feca-a2e7-8cfb78627e01@linaro.org>
Date:   Wed, 21 Jun 2023 10:04:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
Content-Language: en-US
To:     Conor Dooley <conor.dooley@microchip.com>,
        Lucas Tanure <tanure@linux.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yixun Lan <dlan@gentoo.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230620134857.238941-1-tanure@linux.com>
 <20230620134857.238941-3-tanure@linux.com> <ZJIjtphyKdC48JrN@ofant>
 <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
 <CAJX_Q+3im20qphOXzn-=58Kx4--ajbaF4P8BVvRcDcPXn1Qheg@mail.gmail.com>
 <20230621-barber-enjoyably-04806271daea@wendy>
Organization: Linaro Developer Services
In-Reply-To: <20230621-barber-enjoyably-04806271daea@wendy>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/06/2023 10:01, Conor Dooley wrote:
> On Wed, Jun 21, 2023 at 08:37:02AM +0100, Lucas Tanure wrote:
>> On Wed, Jun 21, 2023 at 7:02 AM Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 21/06/2023 00:09, Yixun Lan wrote:
>>>>> +            apb4: bus@fe000000 {
>>>>> +                    compatible = "simple-bus";
>>>>> +                    reg = <0x0 0xfe000000 0x0 0x480000>;
>>>>> +                    #address-cells = <2>;
>>>>> +                    #size-cells = <2>;
>>>>> +                    ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>>>>> +
>>>>> +                    uart_A: serial@78000 {
>>>>> +                            compatible = "amlogic,meson-t7-uart",
>>>>                                                ~~~~~~~~~~~~~~~~~
>>>> if you introduce new compatible string, then at least you need to document it
>>>> so Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml need to be updated
>>>>
>>>> but my qeustion here, why bother introducing new compatible string if nothing
>>>> changed with the compatible data? given the uart is same IP with g12a, can't we just
>>>> use "amlogic,meson-g12-uart" for this? no only it will reduce the structure length of
>>>> meson_uart_dt_match[], but also relieve maintainer's review burden?
>>>
>>> https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42
>>>
>>> Best regards,
>>> Krzysztof
>>>
>> Hi, I did not understand the recommendation here.
>> Can I add "amlogic,meson-t7-uart" without Documentation changes?
> 
> No, you can't.
> 
>> I think Yes, as I can see a few compatible strings in dts that don't
>> exist anywhere else.
> 
> Aye, but we do not want to propagate that. New stuff should not be
> adding undocumented compatibles, and those that are undocumented should
> be documented.

Documentation is ongoing, it takes time !

Neil

> 
>> My idea here is to add "amlogic,meson-t7-uart" for future use if ever
>> created, like if we find a bug in the future that is only relevant to
>> T7 soc.
>> But for now, fallback to s4 uart, as it seems to be the same controller.
>>
>> >From Krzysztof said in the writing-bindings.rst, I am following the rules.
>>
>> So, what's the path forward here?
> 
> You are following the rules from the dts point of view, you just need a
> 3rd patch in which you document the pattern you have added here in
> amlogic,meson-uart.yaml. It is probably something like:
> +      - items:
> +          - const: amlogic,meson-t7-uart
> +          - const: amlogic,meson-s4-uart
> But I have not tested that, I just wrote that in my mail client.
> 
> Cheers,
> Conor.

