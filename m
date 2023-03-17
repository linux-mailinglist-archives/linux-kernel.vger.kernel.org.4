Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50D86BED9D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjCQQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjCQQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 12:03:38 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1772A6904F
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:03:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id er8so10579125edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 09:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679068994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f91aUWF3bfVcup+/r6HBb6TIwUZDRmvhzawedVd1n+4=;
        b=QZFmgKgKizW06OL/OcBs8EB3SNBeaHL+iQVhSlMP+M6wH32n6Oc1hIX4Rcs1e3YP8K
         0SOnb32xdYx1Je9wEdBtNAzsipXzauyGCLZg46AjgQ21+PG4k/vTmEVfFtNCZjTkVezx
         0sV54cR0qABx2ipD4z61+PykyDGDT5e8Sv7o6dM8X52OeuOdryvnLNGDjOJuv/jZvuAK
         vS1mzHf9lRJ0gFSKJiyiOgJCfpFIPpOFDgBGjTKS38fq2czOsRDKzrOukdVd5k2DYcgq
         vBgGNQapQDIUqw8iW6f7Hqg0pD6zGDRGsEN7VmB+iYxyZMF9yhxuqMyk6aazRCS/LB5y
         qubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679068994;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f91aUWF3bfVcup+/r6HBb6TIwUZDRmvhzawedVd1n+4=;
        b=kUHLHo8GEM1fIDvOVS+Ar8u+Iz9NtHK5RN4pW55jWWTo5w7ICK/20vIU3zRTpt91Bf
         t3pDl8Fx7XHrEkP6jVQv/10797U+EpaTttgA1j4qGFDGlYkdsx7AsR8w67UTS3W3qCXI
         78MUBNUZy0+NWGRtas4VXwpkwTUC7uz115Q9m6FeBJFVVKS3OKWCOGuu6n8G7lbuAkg0
         Z+TdaJCs3YsWt5ufa9//27SRjS9dhfBXlo78O02O1yoNsFsTPqpqrtzU2BLRV8OfSbiF
         lhXMNOIXOyjNI9tdel07lD1JfVENS7GSfJK+JtKWPYvoWGwkYpsbysTZSdt8NBE/9wZJ
         1myg==
X-Gm-Message-State: AO0yUKXMeLaZ7TnQQjac90GZCY/dGuF07hRe/YAvZytw94zZlTCfuC7Q
        H3uOlmX5xvCpnmlkVF/THnJ2+A==
X-Google-Smtp-Source: AK7set8y+JmSoAblxtlJHgL+/D77eZGhCYSsjE/9HekTLHS+R8PVlnHgsSGC0Nv0xoO1Q5SQPK/4Dg==
X-Received: by 2002:a17:907:212e:b0:92f:efdc:610e with SMTP id qo14-20020a170907212e00b0092fefdc610emr7722289ejb.66.1679068994051;
        Fri, 17 Mar 2023 09:03:14 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d013:3eeb:7658:cec? ([2a02:810d:15c0:828:d013:3eeb:7658:cec])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906348100b0090953b9da51sm1121500ejb.194.2023.03.17.09.03.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Mar 2023 09:03:13 -0700 (PDT)
Message-ID: <85d9b8c3-6ddf-9b4c-76a2-8e9761eacc96@linaro.org>
Date:   Fri, 17 Mar 2023 17:03:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 08/15] dt-bindings: clock: Document ma35d1 clock
 controller bindings
Content-Language: en-US
To:     Jacky Huang <ychuang570808@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        schung@nuvoton.com, Jacky Huang <ychuang3@nuvoton.com>
References: <20230315072902.9298-1-ychuang570808@gmail.com>
 <20230315072902.9298-9-ychuang570808@gmail.com>
 <0ad8521d-90b9-29c7-62e6-2d65aa2a7a27@linaro.org>
 <00423efa-d4ca-5d76-d0b2-11853a49c5e9@gmail.com>
 <b9753d54-6605-e3cb-2943-795b4d58cd83@linaro.org>
 <77b713f8-93bd-d0fa-d344-c8a4ec365c50@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <77b713f8-93bd-d0fa-d344-c8a4ec365c50@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/03/2023 10:52, Jacky Huang wrote:
> Dear Krzysztof,
> 
> Thanks for your advice.
> 
> On 2023/3/17 下午 05:13, Krzysztof Kozlowski wrote:
>> On 17/03/2023 04:47, Jacky Huang wrote:
>>>>> +
>>>>> +  nuvoton,pll-mode:
>>>>> +    description:
>>>>> +      A list of PLL operation mode corresponding to CAPLL, DDRPLL, APLL,
>>>>> +      EPLL, and VPLL in sequential. The operation mode value 0 is for
>>>>> +      integer mode, 1 is for fractional mode, and 2 is for spread
>>>>> +      spectrum mode.
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32-array
>>>>> +    maxItems: 5
>>>>> +    items:
>>>>> +      minimum: 0
>>>>> +      maximum: 2
>>>> Why exactly this is suitable for DT?
>>> I will use strings instead.
>> I have doubts why PLL mode is a property of DT. Is this a board-specific
>> property?
> 
> CA-PLL has mode 0 only.
> DDRPLL, APLL, EPLL, and VPLL have the same PLL design that supports
> integer mode, fractional mode, and spread spctrum mode. The PLL mode
> is controlled by clock controller register. I think it's not board-specific.

You described the feature but that does not answer why this is suitable
in DT. If this is not board-specific, then it is implied by compatible,
right? Or it does not have to be in DT at all.


Best regards,
Krzysztof

