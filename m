Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 626A073D9B6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjFZI3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbjFZI32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:29:28 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D4CE4C
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:29:26 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-98934f000a5so359030566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687768165; x=1690360165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2tsOG+nFR2GTTBc7CbDQFVvL4dzoth9iqIWwzfRS+A8=;
        b=xEYr+NKaL1PDtn/k+qrg/HeUDCVALR8yL0jCtp0RqWdlCGUAMBxuD2yBaGSzIE/PEr
         XL2/Ur6iJZBpZU1J8i5l2H34+5zm/CAL+Pa+KUd+iPG6x/3UlljUOtSDiKuI0Zv9P862
         KoyT9x4JX9T9jyMS/mecUHnGSPEWLaRNK0B/bAfcADvM3iNpkwtaQYRhvjjDFmg2milq
         K9wLlU+ZKCbuybSmvoKGl3ukZxcMvlfu1OnCH/7JZN/rrSWCm+HyprG7qYYSTqZeu90A
         n7mJFeJr7QJzFusN8Cyd9ecvYW7yM2EBb4jvJQHW9/FERq7Ts8eJmqIKJ1biZZByapA3
         7OTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687768165; x=1690360165;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2tsOG+nFR2GTTBc7CbDQFVvL4dzoth9iqIWwzfRS+A8=;
        b=Vz937kD9ZCMkIj6TpXdzxNu4aUpi4vmUZx6RK5iO5WXldx2lYg4BSsIhqEs85Cgbpt
         LKgi+Hu5Yghh0n+PuQSrTLOULRl7/sKXrWs84KOt3ahoVqySlS7AkqKt7b83DVf497Xo
         thx0vETbB69z2/Icxkj11sYOYleH97I4dlWHFXoYvt5f1dtrcXJIDG4seBba3jJsd6t0
         z6wSFjHB+sIgC3xnDf7QHaHxEza6G7h7e5KynNQ1CWzGsas4rus+2Z90lvpiZevFk6Vw
         c3z0PCqppyXFTZ3rl/yEa98nvJsB8ylXg/msRMVHBJm2WxlgREGDf6rcoQPsJBb8I08i
         pg7A==
X-Gm-Message-State: AC+VfDzdd0b7M8yvjZH7PXZEc0jB3uFn0XuPRvaqBYlsJnCFn92ne0qi
        6QzPQ9HhbuY2QzVlwE+oimHTeQ==
X-Google-Smtp-Source: ACHHUZ4f6Zrvi3qOoV7NxupQNc5bFb/EuzGTSv79Os8497nPLMdIEfuSC2wmzdkpoAR9pkd2zt+iJg==
X-Received: by 2002:a17:907:da2:b0:988:e8e1:6360 with SMTP id go34-20020a1709070da200b00988e8e16360mr17223589ejc.8.1687768164783;
        Mon, 26 Jun 2023 01:29:24 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id lr9-20020a170906fb8900b00969f44bbef3sm3044396ejb.11.2023.06.26.01.29.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:29:24 -0700 (PDT)
Message-ID: <075c8d01-5788-a3c4-44e0-36cb9318fc6a@linaro.org>
Date:   Mon, 26 Jun 2023 10:29:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: ad74413r: add binding for digital
 input threshold
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc:     Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230623113327.1062170-1-linux@rasmusvillemoes.dk>
 <20230623113327.1062170-2-linux@rasmusvillemoes.dk>
 <20230623-casket-outer-2c9d2a0c4795@spud>
 <20230623215731.GB1216324-robh@kernel.org>
 <8176d552-9829-5442-3ce9-805744b8389e@rasmusvillemoes.dk>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <8176d552-9829-5442-3ce9-805744b8389e@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/06/2023 10:15, Rasmus Villemoes wrote:
> On 23/06/2023 23.57, Rob Herring wrote:
>> On Fri, Jun 23, 2023 at 05:44:50PM +0100, Conor Dooley wrote:
>>> On Fri, Jun 23, 2023 at 01:33:25PM +0200, Rasmus Villemoes wrote:
>>>> diff --git a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>>> index 590ea7936ad7..1f90ce3c7932 100644
>>>> --- a/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>>> +++ b/Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
>>>> @@ -51,6 +51,14 @@ properties:
>>>>        Shunt (sense) resistor value in micro-Ohms.
>>>>      default: 100000000
>>>>  
>>>> +  digital-input-threshold-microvolt:
>>>
>>> Should this not have an adi vendor prefix, similar to
>>> "adi,digital-input-threshold-mode-fixed"?
>>
>> Yes.
> 
> OK. But I'm not really sure what the rules are for when such a prefix
> must be added, so some guidance would be appreciated. There's
> 
> - DO use a vendor prefix on device specific property names. Consider if
>   properties could be common among devices of the same class.
> 
> And my thinking was that a threshold for when a digital input should
> count as high/low would be a rather generic thing, so not particularly
> device specific.

Then find some more users of it.

> 
> Also, this very binding has a shunt-resistor-micro-ohms, and the
> individual channels have a drive-strength-microamp (granted, that latter
> one is a recent one of mine and may have slipped through review?). I can
> certainly understand that when a property specifies a raw value to put
> into some register (or field), that's very specific to that chip (or
> small family of chips) - the adi,ch-func properties fall into that category.

Best regards,
Krzysztof

