Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345296E758C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 10:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjDSInC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 04:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjDSInA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 04:43:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED727EE2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:42:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dm2so79733547ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 01:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681893777; x=1684485777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lutJ4X10eErUILwsgkdH5WmRxdvwhCW95FNaPAQ5mOk=;
        b=XbNu4/AzTzgi+SMPQbP1NKUwDL7qbs11pGCy3FlTuVDrB/tkONF99YDMYrFTgCJZay
         nm5867HkR9801Y9X4hWeCqe5CmHroUf2Kod7fd6qsN23Y3EvR3dPJTyVNo5HqhYYBcVR
         ow/fFAOkxWUXfF5523e1xd0js0doDLYk5AsAAauarp+XpDTLOL7ddupMCOJDOLcKyyJW
         VKN/GmVEio11aMHMf6KZHD+hTmMh/J/l9EklGPyax9AsgN+DieOlu7SErLZf7z91Abtp
         i6BtWpdkeIzo2AI05bfzBuwZM621bN+jpV6+sdeQv6nfbvQDKk25ymPadmRcAShLFdJt
         pi5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681893777; x=1684485777;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lutJ4X10eErUILwsgkdH5WmRxdvwhCW95FNaPAQ5mOk=;
        b=P0in3/s+W0xfGWzbLh2DQkg2oRHfPECEfqLeXTDmCs1DkUbfiWcR7LCLu7etqCNm7z
         7gctQXq2VzfT3T1lEpwimnta15K8MPVGdKQlV7vSrjw6+pW4F7648Npi8l6Siz5LsesO
         QnpimymwBEADZ/6EiAHZZWrw11r0aD1/WMv1dG4qTIqbsWUQiRkAOfwFNsBBhz8abvo/
         DcdlEylLAyFiwCkP2TzyIc7fxnbA4vkO8tzxzHO1icSFmNXwslAn9T2SMMUbY2IHXW+w
         1x3dV9NmzLkKyA5gJOddPBITNBrrvlmFD1QOOE6skEVUNpUmFnNQQAztaa7KqHmt9dnP
         5dkg==
X-Gm-Message-State: AAQBX9eOtzoc/5CrruvPMzOTczK0Q0yKUbyZrrx6OkvgsU88fyrNjR6G
        vxMKnPe6HwhQ/LPcAMUROyq8Qg==
X-Google-Smtp-Source: AKy350YJCPwQqKeOuuIlGNWHxL0ygBdn8cM/uUi2NRApm7KlPPSaGoSd3IH6gCkL818yCt8UV4dZCw==
X-Received: by 2002:a17:906:70d1:b0:94e:e859:8721 with SMTP id g17-20020a17090670d100b0094ee8598721mr17212622ejk.22.1681893777250;
        Wed, 19 Apr 2023 01:42:57 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:62f5:eb43:f726:5fee? ([2a02:810d:15c0:828:62f5:eb43:f726:5fee])
        by smtp.gmail.com with ESMTPSA id ww1-20020a170907084100b0094f2a03486esm5871556ejb.224.2023.04.19.01.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 01:42:56 -0700 (PDT)
Message-ID: <a638055a-97c2-49ce-f301-45d0ce897df4@linaro.org>
Date:   Wed, 19 Apr 2023 10:42:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 9/9] dt-bindings: Add documentation for rt5033 mfd,
 regulator and charger
Content-Language: en-US
To:     Jakob Hauser <jahau@rocketmail.com>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <9275af790e6e21b5cf661a2444effe4caf2be02e.1681646904.git.jahau@rocketmail.com>
 <5b41b54c-88d0-3666-9db2-9cbb90ba8183@linaro.org>
 <acb209ce-7cb6-9a07-c913-9931b980c8c7@rocketmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <acb209ce-7cb6-9a07-c913-9931b980c8c7@rocketmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/04/2023 23:37, Jakob Hauser wrote:

>>> +properties:
>>> +  compatible:
>>> +    const: richtek,rt5033-charger
>>> +
>>> +  richtek,pre-microamp:
>>> +    description:
>>> +      Current of pre-charge mode. The pre-charge current levels are 350 mA to
>>> +      650 mA programmed by I2C per 100 mA.
>>
>> minimum:
>> maximum:
>> multipleOf: 100
>>
>> Same for other cases.
> 
> The "multipleOf: 100" doesn't seen appropriate to me when the choice is 
> 350, 450, 550, 650. Those are not multiples of 100. It's more of a step 
> size. I didn't find a general property for step size. Listing them as 
> "enum" would be another possibility, I guess, but not an elegant one. 
> Especially for property "richtek,const-microvolt" there are 30 
> possibilities.

Ahh, right. You can use enum here and min/max for other cases, where
multipleOf cannot be used.

>>> +  richtek,eoc-microamp:
>>> +    description:
>>> +      This property is end of charge current. Its level ranges from 150 mA to
>>> +      600 mA. Between 150 mA and 300 mA in 50 mA steps, between 300 mA and 600 mA
>>> +      in 100 mA steps.
>>> +    maxItems: 1
> 
> Here are two different step sizes. The first few are 50 mA steps (150, 
> 200, 250, 300 mA) and then it changes to 100 mA steps (300, 400, 500, 
> 600 mA). How to deal with that? Again I guess "enum" would be a 
> possibility, but again not a nice one.

enum

Best regards,
Krzysztof

