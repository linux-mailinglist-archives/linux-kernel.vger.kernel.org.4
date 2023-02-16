Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55462698FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 10:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjBPJWK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 04:22:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjBPJWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 04:22:08 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF61C7E7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:22:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a3so3650939ejb.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 01:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=instFpBHV/JuNsnWbwYUXVPH2jqRlugl+D8EIlje5FQ=;
        b=GrUGTvJULPegvd61t+FvX4GJ1ZjZrTJ3eASv/bmwutJFj2QeHGRGB1FD/AGQ1XxuRE
         WOTMiUdZcblkLBuDPkmahhNkk4t+sdXMhO+S4hqew/OOQDbqX4hEXVDX0tfiatAoOUGK
         2jvogjL9yAVb2ql6c8Klqs2hAObfqG7b3/9Vwq3FZtZvy05MOyVWvc0r+6e/Tf9F5UzS
         GXm5UvijElk0MLM92Dzfh3Er0AZRUMGhho0lTIzgouVqzFu5f3LSfsWQQwDOQqqdTYfk
         8hnhYS1J6/YaDGebJEirp1RUBAVfegruIWEpxoxnzcxhTS+7EwkBjEj6TmXt2NQyridh
         Sv/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=instFpBHV/JuNsnWbwYUXVPH2jqRlugl+D8EIlje5FQ=;
        b=hg+eTisxq2h0B5Ftb5u+cPEo9dU3vFF+XCPN8TTmJl59xKVcGTDJzG8pzsX2q6zrbu
         JF6TCNkZzaCu+h4aenkjls2auWs5klxzEcmCDd5sagjXCEaan3Iy/nI9pVdIfKFxXSms
         khe1YoPr/fPyos/qO9GAqbrHNUCKHuiR784xM8UIejS+j/Hajq81jtHkik1MwiwoDeAQ
         CfAsTPV/PMMFKiM6y1aQvUSq66rmbEAtjgKfh8kGklZOOznKgG1sv2E0rEJI/Sv5gzL0
         mjpcB6L4d07hcOLZu2e85PPzMCaDFb7nBi+cgYo8NnsD/WKd2MCi3fJxGumr+5cPliyz
         4IFQ==
X-Gm-Message-State: AO0yUKU2OHZ/UJJvVq8wS/4j6PY20pM+6rKplbtsuJqY5HhDiy6wDzz9
        1qcrfpTfngnDEomL8OIMcodMcw==
X-Google-Smtp-Source: AK7set/G+wS4JosvTqvxTxSGbj6EYBrpnJuw4HyLgb4b6T7aodQrpX4RymIdMOUmmQGVjEpMesOwKA==
X-Received: by 2002:a17:906:f6d9:b0:884:4806:c39 with SMTP id jo25-20020a170906f6d900b0088448060c39mr4958957ejb.11.1676539323879;
        Thu, 16 Feb 2023 01:22:03 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id s9-20020a170906960900b0088091cca1besm548331ejx.134.2023.02.16.01.22.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 01:22:03 -0800 (PST)
Message-ID: <c5aa358d-6fb8-9d4d-eef7-d3a8268229e8@linaro.org>
Date:   Thu, 16 Feb 2023 10:22:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
Content-Language: en-US
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20230201103359.1742140-1-ryan_chen@aspeedtech.com>
 <20230201103359.1742140-3-ryan_chen@aspeedtech.com>
 <b0f55494-3a17-4d87-7b8f-5b078503cb53@linaro.org>
 <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
 <b58fad13-12d5-346b-9452-d345c7bf5327@linaro.org>
 <TYZPR06MB5274C8D759C5C762C12A1CE9F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB5274C8D759C5C762C12A1CE9F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 10:20, Ryan Chen wrote:
> Hello Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, February 16, 2023 4:18 AM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
>> i2C driver
>>
>> On 15/02/2023 06:43, Ryan Chen wrote:
>>>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>>>> +
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - aspeed,ast2600-i2c
>>>>
>>>> NAK. It's already there. Please do not waste our time in submitting
>>>> duplicated drivers.
>>>
>>> It is not duplicated, as my description in cover " This series add AST2600 i2c
>> new register set driver"
>>> So, this will be different driver compatible.
>>> The original compatible is
>>>       - aspeed,ast2400-i2c-bus
>>>       - aspeed,ast2500-i2c-bus
>>>       - aspeed,ast2600-i2c-bus
>>> So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".
>>
>> Bindings are documenting hardware, so I claim - we already have this
>> hardware described and this is duplicated. Otherwise - what are these two I2C
>> controllers and what are the differences? Why they do not have really different
>> name? Bus looks more like a mistake than a differentiating name.
> For misunderstanding, or mistaken. 
> I purpose to be aspeed,ast2600-i2cv2, will it more clear way ? 

I don't know. I still did not get answers. I asked here several questions.

Best regards,
Krzysztof

