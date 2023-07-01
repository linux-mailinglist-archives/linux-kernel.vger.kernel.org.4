Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33CC1744807
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 10:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjGAIWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 04:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGAIWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 04:22:30 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89001B9
        for <linux-kernel@vger.kernel.org>; Sat,  1 Jul 2023 01:22:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-98e39784a85so473412766b.1
        for <linux-kernel@vger.kernel.org>; Sat, 01 Jul 2023 01:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688199747; x=1690791747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gMzN5ldrDLudsFTYrIWTDNOwJnSoomZPJebktTnoU4I=;
        b=z0vr7th4jrnuqwOOGzCSY6B5JNYPSI9Q1lAB5/LAiCsFLpgAeHlZ9AP0z3cjr2grLr
         10l6wNeJX6XhSKFFjLl9yqKhmuQMZ5///4QLfTrb9Ctwa7DjXs75TxJFGTpwuGR9fggH
         egDYhRbJuK7VooVdV+BHbDNF8uRt8h+WIp4+2eI9R4NNO9EvdJQLu5FFk7agf80rdsvw
         6PFEGk8iC/GhsdXH93Z+EKtepKkCgj26eQevb3URGojIfPgReTD1tcZ0zpa0Gh2TPopR
         pZDCSaMSd2VhCWVQV4USmsOmFUib+gIvSyi7cZf07sxN37OQdqQwARTdFK+1JBPSBcXL
         F3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688199747; x=1690791747;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gMzN5ldrDLudsFTYrIWTDNOwJnSoomZPJebktTnoU4I=;
        b=WJeqYHg152GbUPL+mgRRxkwB0znS4Aeqe3g0ff2m1c7+ER3crj2o/ew2g//fEPIXEb
         RmDtne/EBOBGgX7DsirriSYd1E1pMHZCR+IvldehV9NJL43W+9rdTna79MlKAzpih06P
         Nlb8UStAWsXsad62++dl/N6vNIYdiqw2nImNozWSIejNs4IdK8olHpagrjS+JYtlnPtd
         TqjwuzoN4QfwFEIc1JFW0TiAjAxz5+gU05hQWaZy/vC3FOUpUo9ALcojmWftPw74zN9t
         816TBZwE+rwjlrqhYKmtJhP9c3icTZOUERcEevDVxNPqB2cx6d/LQuhKYgd39QtG0JQ/
         AXEQ==
X-Gm-Message-State: ABy/qLbFiF65Y87NmOo+F3xF7U3BQqOxJ/4pVtpjJRuaRkGjfdR752sI
        MkKDetLzn5UrxSMficwZWqT2QS+Om17g0B5tUyvTajJr
X-Google-Smtp-Source: APBJJlHQQAoTBEsW/Bor8efMuJEWqdkdKXwXOik6r7upNjbyBabBfFtmqbgej0SUq+B2EXp04+tBXg==
X-Received: by 2002:a17:907:212a:b0:992:6d73:5696 with SMTP id qo10-20020a170907212a00b009926d735696mr4386219ejb.5.1688199747015;
        Sat, 01 Jul 2023 01:22:27 -0700 (PDT)
Received: from [192.168.10.214] ([217.169.179.6])
        by smtp.gmail.com with ESMTPSA id b27-20020a170906195b00b00991e2b5a27dsm6356217eje.37.2023.07.01.01.22.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Jul 2023 01:22:26 -0700 (PDT)
Message-ID: <f5275617-d68c-c76b-d799-106f67cc2071@linaro.org>
Date:   Sat, 1 Jul 2023 10:22:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] dt-bindings: riscv: sifive: Add SiFive Private L2
 cache controller
Content-Language: en-US
To:     Eric Lin <eric.lin@sifive.com>
Cc:     conor@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dslin1010@gmail.com,
        Zong Li <zong.li@sifive.com>, Nick Hu <nick.hu@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
References: <20230616063210.19063-1-eric.lin@sifive.com>
 <20230616063210.19063-4-eric.lin@sifive.com>
 <2437bda9-bbdb-ad80-7201-1e16e1388890@linaro.org>
 <CAPqJEFoTsmVZ4kvsSB0RkQZaQGyXC96KV6RvdpeC5XxURCOZ0w@mail.gmail.com>
 <8c9ed2d4-83ab-ecc0-a300-e6bc8e2047b6@linaro.org>
 <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAPqJEFqhmxksvEgvC61cJcRGR0DrSWDZxJC3J7tdgcG8UY+sFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/06/2023 18:31, Eric Lin wrote:

>>>>
>>>>> +      - enum:
>>>>> +          - sifive,pL2Cache0
>>>>> +          - sifive,pL2Cache1
>>>>
>>>> What is "0" and "1" here? What do these compatibles represent? Why they
>>>> do not have any SoC related part?
>>>
>>> The pL2Cache1 has minor changes in hardware, but it can use the same
>>> pl2 cache driver.
>>
>> Then why aren't they compatible?
>>
> 
> The pL2Cache1 has removed some unused bits in the register compared to
> pl2Cache0.
> From the hardware perspective, they are not compatible but they can
> share the same pl2 cache driver in software.

So they are compatible... If they were not compatible, you wouldn't be
able to use the same match in the driver.

> Thus, we would like to keep both. It would be great if you can provide
> some suggestions. Thanks.

I propose to make them compatible, like every other piece of SoC. I
don't see any benefit of having them separate.

Best regards,
Krzysztof

