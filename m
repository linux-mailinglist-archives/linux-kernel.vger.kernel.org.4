Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD9E63BC4E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:58:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbiK2I6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbiK2I6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:58:03 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDF4F4A59D
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:57:59 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j4so21464685lfk.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 00:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3Xm8CTKI5pFBGHRduIfFpNiMz/YnZAtfkESDIfrZHU=;
        b=yAEQ0f7iiBFFT3zCiQNjmihHx5xLZxE6k/IeeXvqExp+xO+DPBKaqaxdKRPjwqjvfm
         LGiE/88+2dA8GBPDfU5fAaQ3Z/xIyM/1Q2wHRirgQvn4TyBIra65cSP5Se2/qbjCoKGc
         1Hq557jg8voTc6j/UzZluOPwaXmy4GBopEX26WAIH5FqPhTqu9nz80AjXLac3MJp2C5g
         10UfdNS/tnkujmQa2TuxvMMrc4swPsf08zlfgj/5oJCSrM8Yrtf/hnZWZFPGy9NRTOg/
         5H+ub/cqzstKJ9vwyX2QUwyFk6bzIK3YPyrSpYuCCEjZonNp91Y4cV2sIkrx4I/gpKTj
         /OMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y3Xm8CTKI5pFBGHRduIfFpNiMz/YnZAtfkESDIfrZHU=;
        b=UA7+FZT/ZSoi/EXiOTZ+hyxMZ02ztpPt7VNumbReKJOaRfHbItrQED5uJG9OaelNXP
         AmcdPFO1UiRXuctV8Zx5CkXE6xyDg8WRdOyL/h+7dIx1/MN98ln4jiAGXBBnqWbdBPq0
         fxGNfuDKIPyKcRfvrK3j82hnxxP6xl+i3dJna8rKuq/AgH1xB7LMdAZpT+ij9nl71yQT
         7I7Mhs+ivIKB3niy4MIXdb98XqGNemYbMaKBk0Fv8GKdKAv4iCvJgZI8FM+licScnqAx
         qsEaHyxAa5+RAJDbOPnHh727DhnhZ5yJZf2ZqxH12u7pruy3PAXolTzROHlfAcWg1mGs
         f2BQ==
X-Gm-Message-State: ANoB5pkJQ2sTkqUObHg9c5E6MtbKo9RiWuKN7o7M7Fq5sg5dgMslI4Si
        zoz4VnKkwhL3tq9X+Be3N9WP5w==
X-Google-Smtp-Source: AA0mqf4sCi5zsBb8QGQDZbosFwGoYJsQ5RMSlu7aY+oTQbrbtNWy43Z7xsQZ8C1sktxc1yAoujDyww==
X-Received: by 2002:ac2:4919:0:b0:4b5:33d:1215 with SMTP id n25-20020ac24919000000b004b5033d1215mr6449072lfi.419.1669712278173;
        Tue, 29 Nov 2022 00:57:58 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c13-20020a056512238d00b0049ebc44994fsm2140144lfv.128.2022.11.29.00.57.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 00:57:57 -0800 (PST)
Message-ID: <79651cf2-7efd-b54c-65a0-8986cea071d5@linaro.org>
Date:   Tue, 29 Nov 2022 09:57:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 05/10] dt-bindings: soc: mediatek: convert pwrap
 documentation
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
 <20221005-mt6357-support-v6-5-4f589756befa@baylibre.com>
 <a9a47e08-1a08-abe5-1dbe-1537d3414af6@linaro.org>
 <c94d15bf-c5ed-b400-abdf-8cca4102b078@linaro.org>
 <CAFGrd9pueans7Z_GHassY7ouGOwDmj4oJHAXS4ZtbYK4KH58Bw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAFGrd9pueans7Z_GHassY7ouGOwDmj4oJHAXS4ZtbYK4KH58Bw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 15:03, Alexandre Mergnat wrote:
> 
>>>> +allOf:
>>>> +  - if:
>>>> +      properties:
>>>> +        compatible:
>>>> +          contains:
>>>> +            const: mediatek,mt8365-pwrap
>>>> +    then:
>>>> +      properties:
>>>> +        clocks:
>>>> +          minItems: 4
>>>> +
>>>> +        clock-names:
>>>> +          minItems: 4
>>>
>>> else:
>>> ???
>>
>> Actually this looks less complete than your previous patch.
>>
>> else:
>>   clocks:
>>     maxItems: 2
>> same for clock-names
>>
> 
> I think I’ve followed the feedback done here [1]
> I’ve declared `minItems: 2` globally and override it to 4 if
> mediatek,mt8365-pwrap is used. Isn’t it the right way to implement it
> ?

Yes, just the other part of comment is missing:
"If you really want to force a validation error when using
mediatek,mt8365-pwrap
and not providing `sys` and `tmr` clocks, you can just override minItems."

but that's fine if this was your intention.

> 
>>>> +            compatible = "mediatek,mt8135-pwrap";
>>>> +            reg = <0 0x1000f000 0 0x1000>,
>>>
>>> This does not match your unit address. No warnings when compile testing?
>>>
> 
> There are no warnings when compile testing. I will fix the unit
> address anyway, sorry.
> 
>>>> +                  <0 0x11017000 0 0x1000>;
>>>> +            reg-names = "pwrap", "pwrap-bridge";
>>>> +            interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>;
>>>> +            clocks = <&clk26m>, <&clk26m>;
>>>> +            clock-names = "spi", "wrap";
>>>> +            resets = <&infracfg MT8135_INFRA_PMIC_WRAP_RST>,
>>>> +                     <&pericfg MT8135_PERI_PWRAP_BRIDGE_SW_RST>;
>>>> +            reset-names = "pwrap", "pwrap-bridge";
>>>
>>> Missing pmic. Make your example complete.
>>
>> Probably pmic should be skipped, I understand it is described in MFD
>> binding.
>>
> 
> Put the pmic in the example have 2 constraints:
> - The original pmic "mediatek,mt6397" isn’t supported by a yaml
> schema, so I’ve a dt_binding_check fail: `failed to match any schema
> with compatible: ['mediatek,mt6397']`
> - If I put another pmic that supports a yaml schema, I need to put all
> required properties for the pmic, which I thought was unnecessary
> since it’s already done in its own schema and can change for another
> pmic, so less consistent.
> 
> Then yes, IMHO, PMIC should be skipped in the example.


Yes, you're right.

Best regards,
Krzysztof

