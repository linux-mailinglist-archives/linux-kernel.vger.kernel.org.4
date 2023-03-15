Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5208B6BB920
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 17:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbjCOQIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 12:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjCOQIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:08:19 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FC9CFFC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:07:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id eg48so18317644edb.13
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 09:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678896467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aqONjTIvP+09QATy3Q2cw95EblEgzACspeULoqIwV9Y=;
        b=lIMiWV12PehHR4iYXCo/jDBJIM8iQ6sQlPaNKH7s+WMyCt4ZZLUFY7lFuqV343vIln
         uDCIipG8HMkzP5WRTTs6kl/Sk3QgeeWeWM4gNX1aO+OzeMA1NUv7YOSf/NKheL1f+NSn
         xPAySfY7tXsw4giQ9LUofs+AMrKx0ez6U0tZFD1930ytPKwH2NxNe/DRIYjkUzRjJ+BH
         XjoObNaLwVniKtZV/nkxVfxMnYn+K6bAQdyw3ID8yqk1fWlpdU2KSHKRLHSA1+K2W2y0
         zTMO1IHFuD45roeCdYA+nT5c2WOEIXVlnltB5Q4V2KNIVuIEaDCbhd2ua4W2Ygbbcyxw
         vIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678896467;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aqONjTIvP+09QATy3Q2cw95EblEgzACspeULoqIwV9Y=;
        b=w13vJwfplXnBONNze8n4R2bzzca6HDHGmCxY3Pf3lH9qQNXcE+Ys2HbY3Z2xIj3CPp
         aQ1I8IE7+4pldEZJy5yzCgC8LPFW75EChpW82AxelCzfVaWTX/QncTH8SB/IQmIZ+Z/V
         Vlt/wKPvHmK9fzr1GXyWG9xKksA55HWpaNuTQ9RsdTGclCRR4BAxJtT6DBmZpdcj90An
         JyPCkb94uMxP3YQxNb6bTahHioxiTyPtqj9Q/HbqQclyBJPBjKHtB+2gt95GTOd3P3tn
         LnL6EhsM2iwsdrrlShceigd02Z+36d+V0qjQeJcETkpr5wZt05FsTjm9VTKJuZjsodcS
         Y8Qw==
X-Gm-Message-State: AO0yUKUT77U39m88VbNuyEGqs8X6Rx6kEELLGR0AJoDIcJ/eN3BXzoLq
        knqQol38yEAwImZ2kvaj7iHo5A==
X-Google-Smtp-Source: AK7set/V5QhWp204qp4YKQAWWSWsqvv9kVX1BvemQkrh+PYjnSB+cybioLWeTxDRDvN5lesy2ZIUqw==
X-Received: by 2002:a17:906:a843:b0:928:3d04:c7e6 with SMTP id dx3-20020a170906a84300b009283d04c7e6mr6422908ejb.26.1678896467510;
        Wed, 15 Mar 2023 09:07:47 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id u11-20020a1709060b0b00b008e22978b98bsm2706446ejg.61.2023.03.15.09.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 09:07:47 -0700 (PDT)
Message-ID: <5f9fe7fb-9483-7dee-82c8-bd6564abcaab@linaro.org>
Date:   Wed, 15 Mar 2023 17:07:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553
 variants
Content-Language: en-US
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Marc Kleine-Budde <mkl@pengutronix.de>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Vincent MAILHOL <mailhol.vincent@wanadoo.fr>,
        Simon Horman <simon.horman@corigine.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230314151201.2317134-1-msp@baylibre.com>
 <20230314151201.2317134-2-msp@baylibre.com>
 <680053bc-66fb-729f-ecdc-2f5fe511cecd@linaro.org>
 <20230315112508.6q52rekhmk66uiwj@pengutronix.de>
 <54aae3b8-ee85-c7eb-ecda-f574cb140675@linaro.org>
 <20230315155833.qsb5t367on5hl5li@blmsp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315155833.qsb5t367on5hl5li@blmsp>
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

On 15/03/2023 16:58, Markus Schneider-Pargmann wrote:
> On Wed, Mar 15, 2023 at 02:14:27PM +0100, Krzysztof Kozlowski wrote:
>> On 15/03/2023 12:25, Marc Kleine-Budde wrote:
>>> On 14.03.2023 21:01:10, Krzysztof Kozlowski wrote:
>>>> On 14/03/2023 16:11, Markus Schneider-Pargmann wrote:
>>>>> These two new chips do not have state or wake pins.
>>>>>
>>>>> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
>>>>> ---
>>>>>  .../devicetree/bindings/net/can/tcan4x5x.txt          | 11 ++++++++---
>>>>>  1 file changed, 8 insertions(+), 3 deletions(-)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>>> index e3501bfa22e9..38a2b5369b44 100644
>>>>> --- a/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>>> +++ b/Documentation/devicetree/bindings/net/can/tcan4x5x.txt
>>>>> @@ -4,7 +4,10 @@ Texas Instruments TCAN4x5x CAN Controller
>>>>>  This file provides device node information for the TCAN4x5x interface contains.
>>>>>  
>>>>>  Required properties:
>>>>> -	- compatible: "ti,tcan4x5x"
>>>>> +	- compatible:
>>>>> +		"ti,tcan4x5x" or
>>>>> +		"ti,tcan4552" or
>>>>> +		"ti,tcan4553"
>>>>
>>>> Awesome, they nicely fit into wildcard... Would be useful to deprecate
>>>> the wildcard at some point and switch to proper compatibles in such
>>>> case, because now they became confusing.
>>>
>>> I plead for DT stability!
>>>
>>> As I understand correctly, the exact version of the chip (4550, 4552, or
>>> 4553) can be detected via the ID2 register.
>>
>> So maybe there is no need for this patch at all? Or the new compatibles
>> should be made compatible with generic fallback?
> 
> I can use the value being read from the ID2 register to get the version.
> This at least holds the correct value for tcan4550, 4552 and 4553. But
> the state and wake gpios can't be used in case of a 4552 or 4553.
> 
> So yes, it is possible to do it without the new compatibles but the
> changes for state and wake gpios need to stay.
> 
> What do you two prefer?

Then specific with generic fallback compatibles, although for driver it
still won't matter as you need to customize driver_data anyway.

Best regards,
Krzysztof

