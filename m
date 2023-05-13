Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E5A7701956
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 20:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjEMSns (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 14:43:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjEMSnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 14:43:46 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9ED8213B
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:43:44 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50b383222f7so16580946a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 11:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684003423; x=1686595423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SIKmkC8PkYUMuXvhvScc2QiWAE9GV9r1KXIulcRXAH8=;
        b=UzK297MAlDrAcB5KvseNrkyjkh7qqtX5yb3NexbK00a66SN4yP3gJMSx9gHbpDhObZ
         IELyhkZtWoyNtFNx3l5KzNkig/efTqW2t23NfsSfaRv3lSFO7wc4m6tWTWhdnZP3PmhB
         IrRaeYMNg0TaK3aR4cqt2nippuAi5ctxrjXWUoZVjGJ7B9DpCqCdzv1UC2JCtthPciYB
         GnmIqXPaNfMI4kc6jeyD4ykGL2rWCdiYFQiuTxokpoOopxh0I4OXjH2xfuHXM60DlFw6
         sZdZZPFYipAcP1pNKjtCLhOzUTkyLyUhXXt8BGApxN1TxEzA8NU4L+ebs7RGaljhRiwb
         p1lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684003423; x=1686595423;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SIKmkC8PkYUMuXvhvScc2QiWAE9GV9r1KXIulcRXAH8=;
        b=Nk2lIN+nPqUnmqeHxPT/vC79U1Xbh5KJ2bBcHzSFTIgu1ZpimfAH4ovpGDJ6aeiivm
         Rb8zK4VB2xlIIF8dyjxvB6F2EbPT05efkqEyDqOtEVxLsBH1TVu03qxsq6V3UQqwY3EF
         FBTNFwTPjY5x0dxW+2wO3xMZcO3LPJYc6CpLIY17XsCLpDS4K/A+3wN74fTIGAwfCYot
         AsSJnMXOofULtRjc1Ebmk4NWYRmXX5yGLoH//ci2dpC/doltT/rMu0TboACKj8YdnYrq
         GNYsC437wxKco936oPEShr0W26zJuByA/uo7grWeTaoYYje0DDgxqACwxETKymbVuiYc
         C/CA==
X-Gm-Message-State: AC+VfDyMOGQgbD56s8MULwOibzyrwtFx9VhcrYkFx4mUHl+rXXDKGZtL
        fvC2Nnt6nERUG31jtrpfR7a7IQ==
X-Google-Smtp-Source: ACHHUZ5jqpHFV2p7aot+5EbJgXSqMf9auQVtjC5iHSUu1sc0uk/8irH6QB1cdep0CArMgZMauALo7A==
X-Received: by 2002:a05:6402:51:b0:50d:bd2e:6dfa with SMTP id f17-20020a056402005100b0050dbd2e6dfamr10633472edu.17.1684003423301;
        Sat, 13 May 2023 11:43:43 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ba68:e5c9:694e:c6e4? ([2a02:810d:15c0:828:ba68:e5c9:694e:c6e4])
        by smtp.gmail.com with ESMTPSA id m26-20020a50ef1a000000b0050690bc07a3sm5294907eds.18.2023.05.13.11.43.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 May 2023 11:43:42 -0700 (PDT)
Message-ID: <c028e0b1-2eff-a6f4-c4c1-83b1a77bd6ba@linaro.org>
Date:   Sat, 13 May 2023 20:43:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 1/2] dt-bindings: cdns,usb3: Add clock and reset
Content-Language: en-US
To:     Roger Quadros <rogerq@kernel.org>,
        Minda Chen <minda.chen@starfivetech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pawel Laszczak <pawell@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Chen <peter.chen@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
References: <20230510132816.108820-1-minda.chen@starfivetech.com>
 <20230510132816.108820-2-minda.chen@starfivetech.com>
 <9cf5965a-8290-dfff-9f92-07ed2df66650@linaro.org>
 <05057f6d-cb38-8e4a-5d30-82863e0cda44@kernel.org>
 <028fb8ac-d6cc-6fee-f50b-b965e69e7d0c@linaro.org>
 <40592737-4330-101b-5425-091572e61c6f@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <40592737-4330-101b-5425-091572e61c6f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/05/2023 13:08, Roger Quadros wrote:
> 
> 
> On 11/05/2023 17:49, Krzysztof Kozlowski wrote:
>> On 11/05/2023 14:16, Roger Quadros wrote:
>>>
>>>
>>> On 11/05/2023 12:26, Krzysztof Kozlowski wrote:
>>>> On 10/05/2023 15:28, Minda Chen wrote:
>>>>> To support generic clock and reset init in Cadence USBSS
>>>>> controller, add clock and reset dts configuration.
>>>>>
>>>>> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
>>>>> ---
>>>>>  .../devicetree/bindings/usb/cdns,usb3.yaml         | 14 ++++++++++++++
>>>>>  1 file changed, 14 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> index cae46c4982ad..623c6b34dee3 100644
>>>>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>>>>> @@ -42,6 +42,18 @@ properties:
>>>>>        - const: otg
>>>>>        - const: wakeup
>>>>>  
>>>>> +  clocks:
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>> +    description:
>>>>> +      USB controller clocks.
>>>>
>>>> You need to list the items. And why is it variable? Your clock choice in
>>>> the example is poor, I doubt it is real.
>>>>
>>>>> +
>>>>> +  resets:
>>>>> +    minItems: 1
>>>>> +    maxItems: 8
>>>>> +    description:
>>>>> +      USB controller generic resets.
>>>>
>>>> Here as well.
>>>>
>>>> You had one clock last time, thus the review was - drop the names. Now
>>>> you changed it to 8 clocks... I don't understand.
>>>>
>>>
>>> Different platforms may have different number of clocks/resets or none.
>>> So I don't think minItems/maxItems should be specified.
>>
>> Yeah, but we want the clocks to be specific per platform. Not anything
>> anywhere.
>>
> 
> Agreed. So we don't specify min/maxItems at top level but use conditional
> constraints per platform?
> Which means we will need to add platform specific compatibles as well.

Yes, exactly. This can be done here in this binding or through some
re-usable common part and then multiple bindings using it and customizing.

Best regards,
Krzysztof

