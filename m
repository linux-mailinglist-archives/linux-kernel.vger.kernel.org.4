Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D75704799
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 10:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231620AbjEPITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230397AbjEPITh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 04:19:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1722E132
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:19:36 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50b8d2eed3dso20808401a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684225174; x=1686817174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Oo2JdNQw3nm+s9q94jQpygK5WxCllVHRWTv0wG+9HNU=;
        b=zVOfdIZi3XFfZsF3vzE5YO3ZRsDRLoy4SJL4De394IWu1au1l4EzI6afeXmA3DOYDr
         IqHp09c7Ynlt1syBWJ1txySJSXHjOTxm1kkVEVl4LotyIWTBh2h9MEhGQIHK7+mApU1c
         uJHW5tsOQUDVsholUr7YsE8H0AsF6qdIroo1trBf2OQumg9CZ4YUwS9OQp6L6L7eeaRR
         6Rt3ZFN3ISjI82DYdCMcDPAUw9+CMqnWsW+RaDkMGzBSQ0PxZohlyqv4zctNgbg9XeF5
         dEV8ueZdKbcAa2CV1qLr74i06vQ9YqwwQPZ6QlE4cbHV+kInvJFiToaXM7XhooRCUu2t
         54Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684225174; x=1686817174;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oo2JdNQw3nm+s9q94jQpygK5WxCllVHRWTv0wG+9HNU=;
        b=V0v1ugHfhDvKgryMwOr/wzyh4LmQ19DJi2IvvtCypx0kVrIXJlMWhc/q1vAR2JM82X
         lDIzgT2hrM6+PL9PhuVz1oshOVALmOpIwVq4TwjPSgwFL1H2rpCO/ICpSVKX1fXux1AB
         CuGT+DtUVkqPtzKFqy57sIg1kIqZ7oKX94MFrn/+95agLhUHDVQzKmhxZqlq48w/OvNs
         PFZUca62h9IrTMLMRzcuNWlCuUI83uHu/GP58pxzapQ3OaUW66GeuklKsxU6kTycy+xN
         r1vfh++q6xjp06hZ8vQBwG+KPvMqM4gryIQ4qZUKJpWnE7vo1JS6PSnr/B69G9bHJj1T
         5G5g==
X-Gm-Message-State: AC+VfDw1KKPECIzkeiybaPZysMefugjtLo1NOb16/kCBsDpcXjKFoCZU
        Th4YXD8Ja7QO6payyW426zRQ+A==
X-Google-Smtp-Source: ACHHUZ5AU+l82Di42SmLWfIn7OnO3QXcKCr0DjoxwFXvbsfkrsG7YYNjWP8pCWbkUFnNKq1qWj1Yzw==
X-Received: by 2002:a05:6402:160e:b0:50b:ca4a:8451 with SMTP id f14-20020a056402160e00b0050bca4a8451mr28528576edv.14.1684225174563;
        Tue, 16 May 2023 01:19:34 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:4d4a:9b97:62e:1439? ([2a02:810d:15c0:828:4d4a:9b97:62e:1439])
        by smtp.gmail.com with ESMTPSA id d5-20020a50fe85000000b004fbf6b35a56sm8254853edt.76.2023.05.16.01.19.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 May 2023 01:19:34 -0700 (PDT)
Message-ID: <9ae25267-c4de-8f14-df62-d9d0d1f1420c@linaro.org>
Date:   Tue, 16 May 2023 10:19:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] dt-bindings: usb: usb251xb: correct swap-dx-lanes type to
 uint32
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, mike.looijmans@topic.nl,
        Richard Leitner <richard.leitner@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230515103337.130607-1-krzysztof.kozlowski@linaro.org>
 <9b62a0db-1374-2c89-5ea3-286467bd1e4e@denx.de>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.ed9c8f5a-900b-42eb-a8c2-543ccf3145e3@emailsignatures365.codetwo.com>
 <da66656e-ddd6-99cf-41ee-d6b2d318bdff@topic.nl>
 <601bd136-ddae-2889-0e63-5f62484ec849@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <601bd136-ddae-2889-0e63-5f62484ec849@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/05/2023 15:47, Marek Vasut wrote:
>> Please consider the environment before printing this e-mail
>> On 15-05-2023 14:55, Marek Vasut wrote:
>>> On 5/15/23 12:33, Krzysztof Kozlowski wrote: diff --git 
>>> a/Documentation/devicetree/bindings/usb/usb251xb.yaml 
>>> b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>> index 4d1530816817..ac5b99710332 100644
>>>> --- a/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>> +++ b/Documentation/devicetree/bindings/usb/usb251xb.yaml
>>>> @@ -231,7 +231,7 @@ properties:
>>>>         power-on sequence to a port until the port has adequate power.
>>>>       swap-dx-lanes:
>>>> -    $ref: /schemas/types.yaml#/definitions/uint8-array
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>       description: |
>>>>         Specifies the ports which will swap the differential-pair 
>>>> (D+/D-),
>>>>         default is not-swapped.
>>>
>>> Would it make more sense to update the driver instead ? I doubt you 
>>> could have more than 256 ports on this device after all.
>>
>>
>> I guess there's a bunch of devicetrees already out there using the 
>> (misdocumented) 32-bit array binding, they'd break in a bad way...
> 
> I think it is the other way around -- if the binding was documented as 
> u8, then the existing DTs should use the u8 type if they are compliant 
> to the binding document.
> 
> I see one board in next which uses this property and sets it to 0 , so 
> this one is not affected either way:
> arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-rmb3.dts: 
> swap-dx-lanes = <0>;


First of all, the original binding did not define it as u8. It actually
skipped the type entirely but:
 - Example shown u32,
 - Driver used u32,
 - In-tree user uses u32 (although as pointed - as 0 so not really
relevant).

Thus the ABI is rather defined by not-breaking users here, so I would
stick to fixing it to u32.

Best regards,
Krzysztof

