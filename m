Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535F5638A53
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 13:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbiKYMlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 07:41:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiKYMkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 07:40:41 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF466401
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:40:12 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id x5so6596412wrt.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 04:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=msWrrKQCqw0BYu4YAgOQYq+Ad0KCUwCY+JcS8it2gqA=;
        b=JecijIkyNmwA4BnrdxMbg4rKUhOJGdz4NIPDdbm13gQEMUUXybXa9Lbt9qmNWX7e1O
         zIYkJN5M3MBpaPU8TyTsWjgPn/hvwlGW2VdPkrsTQ5gJvLZEsZjSiZ0kseOw2q+x5Wh8
         bKuMrPgCAleS83Xl5SGDO5FyjucfcywIYo0UvAw0cRvEZla2pZv7oUFGL6PU342F5Lif
         udGhRLf9oF8EETcW5CR8TEcPmQwaH9kKl8OiEtjKmcx/R1UaAlEEpnmViC4BByXhdKx3
         HZytGnLCi0iS5FnAzMcfTQlShWI6sNJt/UY4xZOdd/gPSzyBatIQ8pi4llGAraHdN9LJ
         WWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=msWrrKQCqw0BYu4YAgOQYq+Ad0KCUwCY+JcS8it2gqA=;
        b=4fDO/7WurJXjsC4dAO5lBnBhyac/KS+kEKXNJjcAa8cyq+B0/T96Up4Aj1xva1io/O
         jNA9GqfoEUjfPQDCVAtqRoVvc8fVwFxvm56uOUYud/1iLdpPV4p6OXFkYKXwqfxO2e9V
         O8JD2g0UCo19K+27q1w2d+wVEplaNVbvZfLJTZW0oiKS49M4arsyBydnTW91q/G74gsg
         N4EzeDQtJSY6SwHjpwfpNNQAIVYUSZmzT7s7XmGdPvJLwWk6U/oZ+ZhV+gdiPQIX5PTo
         Rdx1K68QLsziMe2LddgsTc2/fS2LDZp+CzJo1nV+OXETig0H/cMCfu6BdaT8NXsmvbcp
         Bp5g==
X-Gm-Message-State: ANoB5pnGrbO7ZE0kTlLB+SB/cpbFbMuldyAJRfZdasPJtuUkRd+GA4Sq
        MrymtQbOfWenwZxAx4Z+NDSkXg==
X-Google-Smtp-Source: AA0mqf7SU4JG52DSfbxYGLy0nDnf2sWj1aJ3f88ziA6uYVgDNYSKYTbg15BOYRm/8bzeQIYnE7iPPQ==
X-Received: by 2002:a05:6000:783:b0:241:bc34:3149 with SMTP id bu3-20020a056000078300b00241bc343149mr17608825wrb.351.1669380010680;
        Fri, 25 Nov 2022 04:40:10 -0800 (PST)
Received: from ?IPV6:2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe? ([2a01:e0a:982:cbb0:84a5:7e09:b15:f1fe])
        by smtp.gmail.com with ESMTPSA id m16-20020a05600c3b1000b003cfd0bd8c0asm5798032wms.30.2022.11.25.04.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Nov 2022 04:40:10 -0800 (PST)
Message-ID: <8602cacd-f552-e843-5c17-681b099069a3@linaro.org>
Date:   Fri, 25 Nov 2022 13:40:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
From:   neil.armstrong@linaro.org
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH v2 2/4] dt-bindings: pinctrl: qcom,tlmm-common: document
 i2c pull property
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <20221123152001.694546-1-abel.vesa@linaro.org>
 <20221123152001.694546-3-abel.vesa@linaro.org>
 <CACRpkdZtkHCkfUAcezSJvmei=HOezK6oyx+4C5kBrEtU+vAB-g@mail.gmail.com>
 <fecb2dd6-9be2-78dc-4598-cc338fbdc2a2@linaro.org>
 <CACRpkdZJaz9BEorQa7dTNkgTkwZjJNB-MWrpKFxHRgdsf3xJww@mail.gmail.com>
Organization: Linaro Developer Services
In-Reply-To: <CACRpkdZJaz9BEorQa7dTNkgTkwZjJNB-MWrpKFxHRgdsf3xJww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2022 10:47, Linus Walleij wrote:
> On Thu, Nov 24, 2022 at 2:24 PM Neil Armstrong
> <neil.armstrong@linaro.org> wrote:
>> On 24/11/2022 14:11, Linus Walleij wrote:
>>> On Wed, Nov 23, 2022 at 4:20 PM Abel Vesa <abel.vesa@linaro.org> wrote:
>>>
>>>> From: Neil Armstrong <neil.armstrong@linaro.org>
>>>>
>>>> Document the new i2c_pull property introduced for SM8550 setting
>>>> an I2C specific pull mode on I2C able pins.
>>>>
>>>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> (...)
>>>> +      qcom,i2c-pull:
>>>> +        type: boolean
>>>> +        description: enable bias pull feature designed for I2C on pin
>>>
>>> But what is this?
>>>
>>> I2C buses are usually just plain old bias-high-impedance, high-z
>>> or open drain, wire-or or whatever you want to call it.
>>>
>>> But now there is some special i2c mode, huh?
>>>
>>> The description is pretty much "it is what it is"... can we have
>>> some explanation about what this means electrically speaking
>>> and why you cannot use bias-high-impedance?
>>
>> I'll try to get some more info, but so far I only found what I wrote in the bindings.
> 
> Björn: can you see if you can get some clarity about the i2c
> bias thing?

As I understood, it enables an "I2C resistor" on the pin, removing the need
of an external pull-up resistor on the line.

I assume the classical pull-up bias is not strong enough to replace an actual
resistor on the PCB.

Neil

> 
> Yours,
> Linus Walleij

