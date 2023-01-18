Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8453672002
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 15:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjAROpq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 09:45:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjAROpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 09:45:31 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E1555AA6F
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:37:33 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r9so11362793wrw.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 06:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BerAg7MaTiqh8AGRs2l1bVSpcU/dcHYC1GMmqI8bSIE=;
        b=P0A3t9d7EFYTQFvCohOEXhUrBZgzCWZlctxwJ2+fKkqwLIIy8i2LgbA0KNE5ybPVK0
         1PE/je1saa8Qo0dJxmVb/VdY8TkfH8+jl3kaaXUoVw9GuOGzSIoqn/aKxbDUtm9FIcxL
         eToo3p+qYadSRDaUlZruoFDzNpHUyVzeJtePxMBvp6kTq9j+kaFO+HVV/OKdnQ1iGdwq
         /2F2oebDM7DbP/XI0hgibVtE8ml4VjKTbl9A+lsty5Bc1w5uTXH0X7K0YrkxchUA4HBT
         9k2XJLgAa7XjwY1pL5kWPtQGsUOmX5F+XC9FFFjsBNXwlMYupiKcH7fwxoYavEjQDx9x
         pxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BerAg7MaTiqh8AGRs2l1bVSpcU/dcHYC1GMmqI8bSIE=;
        b=HsSWngE4W1dX3/Izk+EBRGjC3nC6uqvnH3K5xgFGhIXhxHtJ2UgfM8L6WchuSpN89u
         W975o7II5vQ04vdfMfXZFHxkRKxBpUiNrRZpJlO+1BJxtiUtV2qnENod91t5SwX/Fbyr
         9NbIERRyKsZZvt+pGDYcd1M/5jRwTaUG37KXgvFWiGyacKljlK9QwQfnaAmEyXNREgM3
         aCFZrMlYhKnujFC1b7PoiNcDxA1aO9Uq7w33jDbO/2ZWhNjCSnOzS0789m9N1ZAUHXgj
         cSwjPy7OcASsQflpniq5pE6BrNLYbGbuic4bsTS1pZlxSUYqEoTSxvD5DSuHLtyQnxng
         Ij+Q==
X-Gm-Message-State: AFqh2krKEop8UErQmzZ7uYF684T0BNQP+LVXMdqDWVJ9OKGuvuw3D3GK
        wfUP/EKbFLYLZxnz2Debo7pEFw==
X-Google-Smtp-Source: AMrXdXs2yrAPAcyrY27r/gzfcjpjvvGd7OkYOEn/4I6hRGm6z8/ULmc9XPTmWiJRIrKxS5VGlT+7Fw==
X-Received: by 2002:a5d:58f2:0:b0:2bd:fcd8:c778 with SMTP id f18-20020a5d58f2000000b002bdfcd8c778mr5570929wrd.31.1674052651820;
        Wed, 18 Jan 2023 06:37:31 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f2-20020adff982000000b002bde537721dsm13537089wrr.20.2023.01.18.06.37.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 06:37:31 -0800 (PST)
Message-ID: <83939b6b-0188-9cb7-c4fc-624f13437a48@linaro.org>
Date:   Wed, 18 Jan 2023 15:37:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v4 16/17] arm64: dts: freescale: apalis-imx8: fix
 reserved-memory node names
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc:     "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
References: <20230118072656.18845-1-marcel@ziswiler.com>
 <20230118072656.18845-17-marcel@ziswiler.com>
 <b5a60852-f8f5-f3c4-fb75-bb5f00823c82@linaro.org>
 <1d4dc13ce1ffae4885bceb439d5d259f3567e6c4.camel@toradex.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1d4dc13ce1ffae4885bceb439d5d259f3567e6c4.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/01/2023 15:36, Marcel Ziswiler wrote:
> On Wed, 2023-01-18 at 15:02 +0100, Krzysztof Kozlowski wrote:
>> On 18/01/2023 08:26, Marcel Ziswiler wrote:
>>> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> Fix reserved-memory node names using dashes rather than underscores.
>>>
>>> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
>>>
>>> ---
>>>
>>> Changes in v4:
>>> - New patch fixing reserved-memory node names.
>>>
>>>  arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi | 12 ++++++------
>>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi b/arch/arm64/boot/dts/freescale/imx8-
>>> apalis-v1.1.dtsi
>>> index 70c00b92cb05..6217e0a48f96 100644
>>> --- a/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
>>> +++ b/arch/arm64/boot/dts/freescale/imx8-apalis-v1.1.dtsi
>>> @@ -133,17 +133,17 @@ reserved-memory {
>>>                 #size-cells = <2>;
>>>                 ranges;
>>>  
>>> -               decoder_boot: decoder_boot@84000000 {
>>> +               decoder_boot: decoder-boot@84000000 {
>>
>> This is ridiculous. You just added it! If we consider original code as
>> wrong, then you intentionally added wrong code just to fix it.
>>
>> No, that's not the way how it should be developed.
> 
> Shawn asked me to ease the review process which is exactly what I did.

Any reason why b4 diff cannot be used? If your patchset fails b4
auto-detection of version, this should be fixed instead of fake split.

Best regards,
Krzysztof

