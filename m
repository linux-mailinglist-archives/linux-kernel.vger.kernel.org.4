Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E9F7279F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233114AbjFHI2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbjFHI2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:28:51 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C802707
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 01:28:49 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9745c5fed21so53157866b.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 01:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686212928; x=1688804928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mecQ34dk2V9y6dj5rR+/RnPx6Aef7iQYAh5UFotv1xo=;
        b=YOuXdQwTL0HiqsuDJ2OMmCSusM9E5OEW/ovbK+fy8/Ndz8cb5RyF1n1QlhilBzqeuW
         3gh1zTvG7WUB5wCr1NkVXEkhHxJz0Trn77gbdHJJognIYkXNmesScC2h0fmtNIqjfXbx
         x49RK2FCpm0zpnOYjCZCX+484Cl6Pci7GslevrHsQaDcqjg1AlluAsffRhUhYsAlPvKx
         bDSg5N7ErAgUIy61k/pu9d1PUZmuyRcsvKmYRiTlCcht9U3ykifmVK67IUhQx8dMq/uC
         fhw8bo73cYfBu2SDg/LVekXM9dRtn6e+a2whScQPYNpfoMrma0HY+C21DJONkNdMlhb1
         iy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686212928; x=1688804928;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mecQ34dk2V9y6dj5rR+/RnPx6Aef7iQYAh5UFotv1xo=;
        b=i9sxPBp59wiSMeCYA96xqDNJbgSTrV7MaJttXrQGsoERFIoRlQ9MctosqaixcN3+C+
         jz3qYd7BW4T3x911OIIke/85mM8c5wHqDaqLb59fyjJqew+E9+Md6iaAZobnHtePduCe
         08iV7YCcPDm9V8tmnwfaoDSd+yXkVbtpmzPsoiLPluQauN0hds2IF2j8XBVu6N6yTR4B
         iLc3h9diDVEfPVgI2ZklZSLgtul2h+yCsk3SP4HYE7pLsUaXX0BR5u7G73W7mYWJtOba
         95X1cUjemVRh8o6gcPK4HBtQHOyTHK55XMknAHXsGo5oCRWvHpRbfQhD8ImJZAl0iPSP
         b9Xw==
X-Gm-Message-State: AC+VfDxsFQHrkaxBRHOrueKyXtziEs50NrO1qAmI6I4lik4K6km5e+rs
        I5BpztmAwDuindaTj2K3mII1iA==
X-Google-Smtp-Source: ACHHUZ5QenQx/QeD/48u6FI2zqKtnWEaRxUQn7l0QY2Xhr1/LIy4nn8DwP/ooeoVFbjEmpIbtoTK5Q==
X-Received: by 2002:a17:907:3f9a:b0:96f:8666:5fc4 with SMTP id hr26-20020a1709073f9a00b0096f86665fc4mr10730952ejc.50.1686212928223;
        Thu, 08 Jun 2023 01:28:48 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id h20-20020a170906855400b009787062d21csm386574ejy.77.2023.06.08.01.28.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 01:28:47 -0700 (PDT)
Message-ID: <b941c06f-7f7d-1364-a7f5-be5905112cac@linaro.org>
Date:   Thu, 8 Jun 2023 10:28:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
To:     =?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= 
        <stanley_chang@realtek.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Flavio Suligoi <f.suligoi@asem.it>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
 <20230607062500.24669-4-stanley_chang@realtek.com>
 <7cce1d72-6b4d-9fff-32bc-942193388134@linaro.org>
 <8a88cbee5c6245f2941c700b2bb30697@realtek.com>
 <7df8ffb6-a544-d10e-5273-fd6c4b368b20@linaro.org>
 <7d503e3028a7487a9a087cfa061fff9d@realtek.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7d503e3028a7487a9a087cfa061fff9d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 10:21, Stanley Chang[昌育德] wrote:
> 
>>> Maybe I use the word "control power domain" is not well, I just want to
>> control the ldo of usb phy.
>>> Revised:
>>> The phandle of syscon used to control the ldo of USB PHY.
>>
>> Isn't this still a power domain?
> 
> I only control a register, it is not needed a driver of power domain.

Aren't many power domains just a registers? What about other drivers?
Don't you want in other driver control LDO of something else? And in
other something else?

> 
> 
>>>
>>>>> +
>>>>> +patternProperties:
>>>>> +  "^phy@[0-3]+$":
>>>>> +    type: object
>>>>> +    description:
>>>>> +      Each sub-node is a PHY device for one XHCI controller.
>>>>
>>>> I don't think it is true. You claim above that you have 0 as
>>>> phy-cells, means you have one phy. Here you say you can have up to 4 phys.
>>>
>>> I mean the driver can support up to 4 phys.
>>
>> What driver can or cannot do, does not matter. This is about hardware.
>>
>>> For RTD1295 has only one phy.
>>> For RTD1395 has two phys.
>>
>> Two phys? So how do you reference them when cells=0?
> 
> 
> About RTD1395 SoCs USB
>   XHCI controller#1 -- usb2phy -- phy#0
>                           |- phy#1
> One xhci controller map to one phy driver.
> And one phy driver have two phys (phy@0 and phy@1).
> 
> Maybe the "phy" name is confusing.
> This "phy" not mean a phy driver.

We do not talk about drivers, but DTS and hardware.

> Would "port" be more appropriate? 
> 
> For example,
> Using phy@0 and phy@1:
>     usb_port1_usb2phy: usb-phy@13c14 {
>         compatible = "realtek,rtd1395-usb2phy", "realtek,usb2phy";
>         reg = <0x132c4 0x4>, <0x31280 0x8>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         #phy-cells = <0>;
>         realtek,usb-ctrl = <&usb_ctrl>;
> 
>         phy@0 {
>             reg = <0>;

So such child is a NAK... you have nothing here. But it's unrelated topic.

>         };
>         phy@1 {
>             reg = <1>;
>         };
>     };
> 
> Change: port@0 and port@1
>     usb_port1_usb2phy: usb-phy@13c14 {
>         compatible = "realtek,rtd1395-usb2phy", "realtek,usb2phy";
>         reg = <0x132c4 0x4>, <0x31280 0x8>;
>         #address-cells = <1>;
>         #size-cells = <0>;
>         #phy-cells = <0>;
>         realtek,usb-ctrl = <&usb_ctrl>;
> 
>         prot@0 {
>             reg = <0>;
>         };
>         port@1 {
>             reg = <1>;
>         };
>     };

This is not the answer. This is the provider. How do you reference it
from the consumer.

Upstream your entire DTS. It's frustrating to try to understand your DTS
from pieces of information you are sharing. Also very time consuming and
you are not the only one sending patches for review...

Best regards,
Krzysztof

