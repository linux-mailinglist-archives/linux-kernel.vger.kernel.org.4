Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB6A714DDD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 18:07:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjE2QHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 12:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjE2QHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 12:07:13 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4C36E4;
        Mon, 29 May 2023 09:07:09 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-30aebe2602fso664548f8f.3;
        Mon, 29 May 2023 09:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685376428; x=1687968428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G0Rq7Kdt+FXMB2JN2FXvVxRrTv3nqYTFy/3wNrpRfJs=;
        b=YxuHKkvBdLGTLf3EO/LC+KYTauVGEsOAQ+PYdCWH6ZWv08mjoQDAitkZOivGOYR7kI
         fJsZt7OQEzN5Gk7Fte8yBy5VMClPkL3e5QGobEkM17KSpO3W7BdbREgYbcNnVAUbaxsu
         hVn4/TnuIcaFUXNedBCBABV5wEEURxRaLWOL5X1V+0/Dr5jiUpTc8+7+PMBCqluX6yOc
         a0o4nns376cJMATR40eqOmc/ScjUCsfDmr7IQYuERbvdseQdoeUlQpqEl2JIXq8vBTj5
         mrHNJwnAAqbg7C6XP83NOLinltqXxoXS63xODhZ0JTDqDAYuA+pQau4MmNgyIjQLThFf
         NrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685376428; x=1687968428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G0Rq7Kdt+FXMB2JN2FXvVxRrTv3nqYTFy/3wNrpRfJs=;
        b=JswOi/DsxMNdquGM+TXRGn8M1Wc2nNAML7uURGamDboTI90eEtd0pZ9dQz0Ld+k/wO
         mapPfL0XrcKpVGs4cWfNY2kjYXJHBb5g3JdZj9MP5WzQ9UTQDM+ADtJA5PIc6rSwomSV
         nmUDCZRbx2kWDMjTOoyMzFbh2Z6vh5+tht3yKSS71w7vBYJpRtQH22fy2BaLDnC6vTZW
         BHgqAXqTlEtYKUWQ6l4ELGJNrvPWElNTDvmunjC4mzJlBwlpaAqVoAen4SJ8j7/855Zn
         vmTY7/YmRfiKdPLzDFa3hGm7ooMwQB+6g4TX4LmAnuXeNvSG+ooKU2TUJay5xAZbyjc8
         YCQA==
X-Gm-Message-State: AC+VfDxxFWE75qUu0vRp28pz0czQhbynIKUC8duuPa+4oTfqVjUp2nok
        Cn4VmvFZY48FAg4afd9cjmE=
X-Google-Smtp-Source: ACHHUZ6Sf1QKdF5Zj9s2dDaTja5Wwp1KRz+78nxr/peoDGaDbgftVGZpAFwrZtWWnB0F2hcoA7k2vw==
X-Received: by 2002:adf:f045:0:b0:30a:de1b:93e5 with SMTP id t5-20020adff045000000b0030ade1b93e5mr7871567wro.52.1685376428032;
        Mon, 29 May 2023 09:07:08 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id x11-20020a5d490b000000b003063a92bbf5sm374441wrq.70.2023.05.29.09.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 May 2023 09:07:06 -0700 (PDT)
Message-ID: <09f04ff7-50ae-6e36-2b41-21dae04415ad@gmail.com>
Date:   Mon, 29 May 2023 18:07:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Aw: Re: [PATCH] arm64: dts: mt7986: set Wifi Leds low-active for
 BPI-R3
Content-Language: en-US, ca-ES, es-ES
To:     Frank Wunderlich <frank-w@public-files.de>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
References: <20230205174833.107050-1-linux@fw-web.de>
 <8f04f2b5-320e-50d4-9517-6dac989f63b3@gmail.com>
 <3a43ce55-ff6a-0cd2-b020-d5fefe8aca0a@collabora.com>
 <trinity-8c109262-658a-4a4e-a807-1cd8f640fdc4-1684743994291@3c-app-gmx-bs66>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <trinity-8c109262-658a-4a4e-a807-1cd8f640fdc4-1684743994291@3c-app-gmx-bs66>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/05/2023 10:26, Frank Wunderlich wrote:
>> Gesendet: Dienstag, 07. Februar 2023 um 17:17 Uhr
>> Von: "AngeloGioacchino Del Regno" <angelogioacchino.delregno@collabora.com>
>> Il 06/02/23 21:20, Matthias Brugger ha scritto:
>>>
>>>
>>> On 05/02/2023 18:48, Frank Wunderlich wrote:
>>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>>
>>>> Leds for Wifi are low-active, so add property to devicetree.
>>>>
>>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>>> ---
>>>>    arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>>>> b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>>>> index 33bd6febc160..2b028141f1f7 100644
>>>> --- a/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>>>> +++ b/arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dts
>>>> @@ -446,5 +446,9 @@ &wifi {
>>>>        pinctrl-names = "default", "dbdc";
>>>>        pinctrl-0 = <&wf_2g_5g_pins>, <&wf_led_pins>;
>>>>        pinctrl-1 = <&wf_dbdc_pins>, <&wf_led_pins>;
>>>> +
>>>> +    led {
>>>> +        led-active-low;
>>>> +    };
>>>
>>> The binding is missing this property also the driver implements it. Could you
>>> please update the bindind description properly?
>>> Thanks
>>> Matthias
>>
>>
>> After and only after [1] is picked,
>>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>>
>> [1]:
>> https://patchwork.kernel.org/project/linux-mediatek/patch/20230207133504.21826-1-linux@fw-web.de/
> 
> Hi Matthias,
> 
> Can you take this patch into your tree? binding is already merged
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml#n114
> 

Applied now :)

Regards,
Matthias
