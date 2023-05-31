Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB0471898C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 20:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjEaSrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjEaSrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 14:47:47 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21E132
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:47:45 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-51458187be1so124475a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 11:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685558864; x=1688150864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=57q4TdWvHlrEcIXeoi1W6gK5/9KE0SGJz/XNivOKPnk=;
        b=oilRIHPnW2cKnSn+LS9AcMaGyPgbofIVDMmLVDknuvY7DrITlUY34BXtCpgQgCYiIM
         /J1nY4WezjqAjMPOwSeq9pSDIVCD80AhJL4dlDFKI5RNcnWIn24TDlN8K6LASJ4ntUba
         YjprkdTZEpRW0STsJhGyBCIbRvIgHKOyuBP5wWhym2AH+s7KAQrJjxHQau+fywgxIvk0
         XCI7em/WbhCSiqLL0ffAIn8Rw2GnCj3L3wjUsL1xbnxZrINd8bMcxDSDB6kImuHe3hon
         +qbotEqVxhHKsc20Ey/mIt3hsAi1U6F4owY3hNPpoQEMRFLq701/C8+TvNepKEmWFTsx
         oexg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685558864; x=1688150864;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=57q4TdWvHlrEcIXeoi1W6gK5/9KE0SGJz/XNivOKPnk=;
        b=E5iSrdw+XXE0KLK5pMMfUjyrJBcSuX4IP4Ss2uIoGGA/jWiuSvz09vEwLAWhaflIQl
         O50vDiPJgt6aWul0H4F4em3yHwnWKUTHc5PgulN/0+jUHbVMgvMYna6EbXJdpZ+tmblN
         moscZoE13xAk6KKSxETQ8Fop9lU9RVgsA0T5TH3XCf+hJq6p3mFb50sLv5qd3NdULKIH
         Fly9/1WX5YkmAFFod8mRBkpC7Au4sKd7RlGQg2l8oYPQtHG0k7ceQDV8aagAja6i3Nu0
         0rnVJu+qUPNNKXJiSEgvA5QvAU2SQsMRhEmBQEb5VeGrznVihlkgrMpvdCEnl8crsM+n
         lmBA==
X-Gm-Message-State: AC+VfDz9lU0MLQBdhS72Bng4Im57v6Vw7R/7ylZUVE0x91fSZnqmc0A/
        Ygoug2286zW9B5DL66pkFC88xQ==
X-Google-Smtp-Source: ACHHUZ5OHEWC/l7SwXXG0Ex4UcYj5G95i7V5T07Yf+NXLS4ZzBYzSv6/qXcHJtcqP3+UJEQM/h4YDQ==
X-Received: by 2002:a17:907:7dab:b0:970:1bc9:2eeb with SMTP id oz43-20020a1709077dab00b009701bc92eebmr6064275ejc.30.1685558863716;
        Wed, 31 May 2023 11:47:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id lv17-20020a170906bc9100b0095707b7dd04sm9258501ejb.42.2023.05.31.11.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 11:47:43 -0700 (PDT)
Message-ID: <25d61668-0b79-8565-0de8-dad7e80e3798@linaro.org>
Date:   Wed, 31 May 2023 20:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 04/11] dt-bindings: stm32: add st,stm32mp25 compatibles to
 the stm32 family
Content-Language: en-US
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Conor Dooley <conor@kernel.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
References: <20230529162034.20481-1-alexandre.torgue@foss.st.com>
 <20230529162034.20481-5-alexandre.torgue@foss.st.com>
 <20230529-backlit-dealing-b099e4eb5210@spud>
 <c805cd5f-92b1-eb56-d9bc-66814705e848@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c805cd5f-92b1-eb56-d9bc-66814705e848@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 10:39, Alexandre TORGUE wrote:
> Hi Conor
> 
> On 5/29/23 20:05, Conor Dooley wrote:
>> On Mon, May 29, 2023 at 06:20:27PM +0200, Alexandre Torgue wrote:
>>> STM32 family is extended by the addition of the STM32MP25 SoCs. It is composed
>>> of 4 SoCs: STM32MP251, STM32MP253, STM32MP255 and STM32MP257.
>>>
>>> Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> index 4af5b8f4f803..7d7ca33d2e61 100644
>>> --- a/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> +++ b/Documentation/devicetree/bindings/arm/stm32/stm32.yaml
>>> @@ -161,6 +161,15 @@ properties:
>>>             - const: phytec,phycore-stm32mp157c-som
>>>             - const: st,stm32mp157
>>>   
>>> +      - items:
>>> +          - const: st,stm32mp251
>>> +      - items:
>>> +          - const: st,stm32mp253
>>> +      - items:
>>> +          - const: st,stm32mp255
>>> +      - items:
>>> +          - const: st,stm32mp257
>>
>> I assume the slightly odd format is just to avoid churn when adding
>> the board compatibles.
> 
> Yes, exactly.
> 

I don't get it. How are you going to extend it? Or rather - what are you
documenting here? If these are SoCs, then this is not valid. We do not
allow these alone.

No, please drop it.

Best regards,
Krzysztof

