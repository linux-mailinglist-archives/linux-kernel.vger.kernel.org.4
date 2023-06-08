Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5033E727929
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbjFHHtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFHHtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:49:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA59210C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:49:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51480d3e161so399398a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210545; x=1688802545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKXuqqogfGtV6X2iudgEbDe3qPnP59JxR6B3QZM/6Dc=;
        b=bhf+RuA4cxddlwxZKvK2wGkOnl/9IsTFmePcG64J8c5+dhVU8H5Ar6PU7SXUoD134P
         X94MJk/g8AZRGzJdI3PPL2V1bHwEfi5J7Qg825NZjE8x82rCjKx1cQS/z6JUXTXDApM+
         PBucjFaVmiMgyg3Vp9mAk8oy9p+Q+rUsKwjnWIPQms3F9ZxG9ZVPU5a/ru/vldHfmfSn
         +sMw8fBv1FELUTlQcjlkKmHwwski8uJk6bBsfw7qrBeHrOYiaOlqpSyxWqTy3bYMn+Jb
         0njLxhFKb4sFdZLjlURFzZcQ+OPrQSLBjV4dErXv1gcMV54WuJzf9HVlv/4Q8wMzsIM1
         9gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210545; x=1688802545;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKXuqqogfGtV6X2iudgEbDe3qPnP59JxR6B3QZM/6Dc=;
        b=IibFDBMq+OKjtbrCIJqz5+SPhnNPhA9E5tBw3Q7IqszAS0cviy8IWNrGf6qM8robED
         osJyicO7Cijo8pxFB1xxz/NiroSVjs5iCoA1mceU1WsviSAdwZnc+31/KOO6248QT2ms
         /C8wNjwuHyFIZUbmzGk0arEghodgzmE5Eny3KvK+8CNrYz6fr1nVzR23hXUyMvnV9AMV
         DZ3B9OS+yEowzfT+TB2kB0YAIORD1auqtLCow6AJtIlgi87S1Cmz/gZG4yHEZlqpLSB2
         no/SwiKZz1cRFesVRNsPqtTsw0HIfkqwuyRF9CUTsHKYih7VJQ96wdQ6ZiDuln4zW7qS
         5Vsg==
X-Gm-Message-State: AC+VfDwHY2gKoHIvqu4alkAO36NPOOHxOdGF/4DFXg0VgqYz5oMFO8Y5
        KZ6aMeHo6+uN2mFJba+w2ZkyUg==
X-Google-Smtp-Source: ACHHUZ6yjUk/Bupi3XuBm3zPQr5L3cn8gW6giSpWJdT5x1Wi4H/8UZ3u8kE/ol+rO20wF6MKqMUrxA==
X-Received: by 2002:a05:6402:6c6:b0:50b:d75d:3155 with SMTP id n6-20020a05640206c600b0050bd75d3155mr7195595edy.37.1686210544721;
        Thu, 08 Jun 2023 00:49:04 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id u11-20020aa7db8b000000b00514b3a2008esm238999edt.2.2023.06.08.00.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:49:04 -0700 (PDT)
Message-ID: <7df8ffb6-a544-d10e-5273-fd6c4b368b20@linaro.org>
Date:   Thu, 8 Jun 2023 09:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v3 4/5] dt-bindings: phy: realtek: Add the doc about the
 Realtek SoC USB 2.0 PHY
Content-Language: en-US
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8a88cbee5c6245f2941c700b2bb30697@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 09:24, Stanley Chang[昌育德] wrote:
>>> +  realtek,usb-ctrl:
>>> +    description: The phandle of syscon used to control USB PHY power
>> domain.
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>
>> No, we have power-domains for this.
> 
> Maybe I use the word "control power domain" is not well, I just want to control the ldo of usb phy.
> Revised:
> The phandle of syscon used to control the ldo of USB PHY.

Isn't this still a power domain?

> 
>>> +
>>> +patternProperties:
>>> +  "^phy@[0-3]+$":
>>> +    type: object
>>> +    description:
>>> +      Each sub-node is a PHY device for one XHCI controller.
>>
>> I don't think it is true. You claim above that you have 0 as phy-cells, means you
>> have one phy. Here you say you can have up to 4 phys.
> 
> I mean the driver can support up to 4 phys.

What driver can or cannot do, does not matter. This is about hardware.

> For RTD1295 has only one phy.
> For RTD1395 has two phys.

Two phys? So how do you reference them when cells=0?

> 
>>> +      For most Relatek SoCs, one XHCI controller only support one the USB
>> 2.0
>>> +      phy. For RTD1395 SoC, the one XHCI controller has two USB 2.0
>> PHYs.
>>> +    properties:
>>> +      realtek,page0-param:
>>> +        description: PHY parameter at page 0. The data are the pair of
>> the
>>> +          offset and value.
>>
>> This needs to be specific. What the heck is "PHY parameter"?
>>
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>
>> Array? Then maxItems.
> I have found other document.
> It should be a uint32-matrix.
> I will add the maxItems.

Entire property should be dropped.

> 
>>> +
>>> +      realtek,page1-param:
>>> +        description: PHY parameter at page 1. The data are the pair of
>> the
>>> +          offset and value.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +
>>> +      realtek,page2-param:
>>> +        description: PHY parameter at page 2. The data are the pair of
>> the
>>> +          offset and value. If the PHY support the page 2 parameter.
>>> +        $ref: /schemas/types.yaml#/definitions/uint32-array
>>> +
>>> +      realtek,support-page2-param:
>>> +        description: Set this flag if PHY support page 2 parameter.
>>
>> Why this cannot be deducted from compatible?
> It can identify by compatible.

So drop it.

> 
>>
>>> +        type: boolean
>>> +
>>> +      realtek,do-toggle:
>>> +        description: Set this flag to enable PHY parameter toggle when
>> port
>>> +          status change.
>>
>> Do not instruct OS what to do. Explain why this is a hardware characteristic.
> 
> In my original intention, we hope that this property can be used to control the phy driver do parameter toggle.
> Is it a hardware characteristic? I don't think it's exactly a hardware feature.
> Maybe it can be specified by the compatible.

Drop it.

> 
>>> +        type: boolean
>>> +
>>> +      realtek,do-toggle-driving:
>>> +        description: Set this flag to enable PHY parameter toggle for
>> adjust
>>> +          the driving when port status change.
>>
>> Do not instruct OS what to do. Explain why this is a hardware characteristic.
>>
>>
>>> +        type: boolean
>>> +
>>> +      realtek,check-efuse:
>>> +        description: Enable to update PHY parameter from reading otp
>> table.
>>
>> Do not instruct OS what to do. Explain why this is a hardware characteristic.
> 
> Same above.

So drop all of these.


Best regards,
Krzysztof

