Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 055DC66D873
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:43:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbjAQInq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:43:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236199AbjAQIni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:43:38 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE0629E37
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:43:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r2so29776656wrv.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 00:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WWm/D5U36CBBZnisDCQc8jy48M3+XXeWpLI/3U6tBZA=;
        b=TupwNN700Dfm2HUutSMwjPlmPKv1qxM6rYQyMm0mpHkjqxUP6/0EINC3oD3RQ0ssr9
         ZzPtSYa/mGq4cHtJcahITvOZmStCZdZWU1jfRSTQRltvQy18nreIqtAjQBDUJ5qUqWPj
         Vmigbtmqu/qh3Crc2SEdV8EfGgnlOdVOyKxP8c2Fl4gjbBFiArELiXSHSbu9YA15LyiR
         YFwyzD8iLVSiyiiQ62RpEg3nb5p1ifgQxrmUkaEAewQmadv8mXnL7W9/QY9FGQsohvEg
         WVZAiCvLCyWsyG2KrU8FpyT04KS1EJ5k+p4CSGwyZJbNMrSOVPp4L6n3+x6r1ynkMaFR
         vzfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WWm/D5U36CBBZnisDCQc8jy48M3+XXeWpLI/3U6tBZA=;
        b=B2UzNvkyC0OgWGhL6lVbnm+y+P5DAQcBk8ddkUTmf8u+gljiv37/Wa8y+fZyEyjq+R
         8+eMpdbz/cmJLEJH0k+MqgDQk4n/HYrOQGdS1vRsytYIsgwdwOW4VRBDam8l/i1eM2Vq
         D3sCQrplvnhEeKtL3FD34MsQF5lTDXWcPh0ezjhwo1HLNivtsZ3MkWkXwXsmk3jcmFWP
         LthNLMISI0Av/Dyf9FeUSXL+Ds5050ZIjl5Ak/DG5qZN9m+BNsCMwueTttWzNkkY2pUp
         FyuQngrmF3QEbS/MAbXDYGye3wZQZNoamlgWSMxxEwjSKKE398ic35wtOuCKlw+ToXQ/
         H42w==
X-Gm-Message-State: AFqh2kq5Do/LzAzoBJzgxivkxi2A0hN7vfAyIFHLzVKPpgyDMVJt6gBB
        aARupEIb60tI/r8RWKALunK6ZoLuZNwLr9ve
X-Google-Smtp-Source: AMrXdXtxE8deHQ9xEqdyikgOrukHsDlEQ6sxKfSMn8K6gVKnLxFmtiGijYttJ+TeIIPxhisAU9lAVw==
X-Received: by 2002:adf:e195:0:b0:2bd:d26c:ccc4 with SMTP id az21-20020adfe195000000b002bdd26cccc4mr2366095wrb.42.1673945015641;
        Tue, 17 Jan 2023 00:43:35 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bu3-20020a056000078300b002bbe7efd88csm23519456wrb.41.2023.01.17.00.43.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Jan 2023 00:43:35 -0800 (PST)
Message-ID: <17f910a8-186f-48a3-8817-6a2fa4fe06ec@linaro.org>
Date:   Tue, 17 Jan 2023 09:43:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 2/7] dt-bindings: net: snps,dwmac: Update the maxitems
 number of resets and reset-names
Content-Language: en-US
To:     yanhong wang <yanhong.wang@starfivetech.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>
References: <20230106030001.1952-1-yanhong.wang@starfivetech.com>
 <20230106030001.1952-3-yanhong.wang@starfivetech.com>
 <2328562d-59a2-f60e-b17b-6cf16392e01f@linaro.org>
 <84e783a6-0aea-a6ba-13a0-fb29c66cc81a@starfivetech.com>
 <8ee5f6ef-80cb-2e0f-6681-598ccc697291@linaro.org>
 <bb1f3c71-e1a7-cd2d-b728-6e9027dae150@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <bb1f3c71-e1a7-cd2d-b728-6e9027dae150@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/01/2023 09:14, yanhong wang wrote:
>>> Thanks, refer to the definition of clocks. If it is defined as follows, is it OK?
>>>
>>> properties:
>>>   resets:
>>>     minItems: 1
>>>     maxItems: 3
>>>     additionalItems: true
>>
>> Drop
>>
>>>     items:
>>>       - description: MAC Reset signal.
>>
>> Drop both
>>
>>>
>>>   reset-names:
>>>     minItems: 1
>>>     maxItems: 3
>>>     additionalItems: true
>>
>> Drop
>>
>>>     contains:
>>>       enum:
>>>         - stmmaceth
>>
>> Drop all
>>
>>>
>>>
>>> allOf:
>>>   - if:
>>>       properties:
>>>         compatible:
>>>           contains:
>>>             const: starfive,jh7110-dwmac
>>>     then:
>>>       properties:
>>>         resets:
>>>           minItems: 2
>>>           maxItems: 2
>>>         reset-names:
>>>           items:
>>>             - const: stmmaceth
>>>             - const: ahb
>>>       required:
>>>         - resets
>>>         - reset-names  
>>>     else:
>>>       properties:
>>>         resets:
>>>           maxItems: 1
>>>           description:
>>>             MAC Reset signal.
>>>
>>>         reset-names:
>>>           const: stmmaceth
>>>
>>> Do you have any other better suggestions?
>>
>> More or less like this but the allOf should not be in snps,dwmac schema
>> but in individual schemas. The snps,dwmac is growing unmaintainable...
>>
> 
> Thanks, it is defined as follows, is it right?
> 
> properties:
>   resets:
>     minItems: 1
>     maxItems: 3
>     additionalItems: true
> 

Read my comments above. Drop.

Best regards,
Krzysztof

