Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5C869A71B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBQIhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:37:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjBQIhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:37:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C68135FBC2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:37:23 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id m17so1958613edc.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:37:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rX+L+RQNvSmvl3vXjy6ejfPbMjDPoWjZZGv/1GsmR20=;
        b=Ls1Fayg63aBxblW6mHpeLVmXVbOasWCiICroEXVqnP5iZHKcq6ElDZ3ETAR60+Ep7m
         y33QuXhBCXzd8H1UAvoFVCb78iZpmUcHNTBgakDoCxEt9LWaSZCe+98JTYjQZ4OOlCDS
         Qm7P6yK/5PT3CwEIDxqzlItpjBCWr0R8jn9BMAxfWNIwmx7qfO1wgXD++qhq5RbyIvXf
         fxwXe0AzmtPBdAFjB7T4xTw9415OfcMhLuGHbX1Qad7qY5w89YUCBk7kAevg+mvcLtuw
         8MaUGG7UsPrgGU9tKCceGKwo4q8AzYD1oXBfLGjS9Y4cY3Y4S5cp0PHC0Ob2DajkmLKS
         qytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rX+L+RQNvSmvl3vXjy6ejfPbMjDPoWjZZGv/1GsmR20=;
        b=OWGklfCgeyV5YqVnJ3+yMd/hwd3M+Lz52QcNd/P3wAtsXBPaZ0bz6jga5y/xHXgQ9k
         MqQKfGmWOUvdfc5c7MlztaRY1ArFPi+6MEdGitAnIyOVoHqMIpyo+fmi57vCqZjJc6xz
         3HFwkiFRcbh+UBcCEqG8kgPZvAx5gHCJfxh7GxMatOL7ybRzhEYXhEE/takrlZMqd6OK
         HqmsLkrlT5HphkjM0FVugMMoLVlnG63zgwiYgmC5p/0ka0neZUoBg/wgwIBlkUyFZznu
         1cXxsQHRd+sTEp2wPEZMP+GST3Ujz0+5mYnXFqTgjQT//E2J4dLjcVG71XVzEDzlsVte
         4mcg==
X-Gm-Message-State: AO0yUKW4wfgiqH9TXOBG6UCvJ4haDuHJqohh8wYi0ke2xot1KgZkXJec
        oen+d/t6mmC5N0ZjZ7Z2gPTD2w==
X-Google-Smtp-Source: AK7set/Y69SId1gyB/TFH7/ENtT0fJggoSlC+ReCLuRDgDfgQBRqc3eqQ+xubhnrYJ7kz3dsmzGGHw==
X-Received: by 2002:a05:6402:18:b0:4ab:4011:ff3d with SMTP id d24-20020a056402001800b004ab4011ff3dmr61844edu.0.1676623042189;
        Fri, 17 Feb 2023 00:37:22 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id v30-20020a50d09e000000b004acdef7baaesm1921274edd.96.2023.02.17.00.37.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Feb 2023 00:37:21 -0800 (PST)
Message-ID: <bb73393c-d642-0128-9e63-1a751f090a85@linaro.org>
Date:   Fri, 17 Feb 2023 09:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
 i2C driver
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
 <c5aa358d-6fb8-9d4d-eef7-d3a8268229e8@linaro.org>
 <TYZPR06MB5274B15C35A6030CB49BFD23F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <TYZPR06MB5274B15C35A6030CB49BFD23F2A09@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/02/2023 10:26, Ryan Chen wrote:
> Hello Krzysztof
> 
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Thursday, February 16, 2023 5:22 PM
>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>; Andrew
>> Jeffery <andrew@aj.id.au>; Philipp Zabel <p.zabel@pengutronix.de>;
>> openbmc@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for AST2600
>> i2C driver
>>
>> On 16/02/2023 10:20, Ryan Chen wrote:
>>> Hello Krzysztof
>>>
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Thursday, February 16, 2023 4:18 AM
>>>> To: Ryan Chen <ryan_chen@aspeedtech.com>; Rob Herring
>>>> <robh+dt@kernel.org>; Krzysztof Kozlowski
>>>> <krzysztof.kozlowski+dt@linaro.org>; Joel Stanley <joel@jms.id.au>;
>>>> Andrew Jeffery <andrew@aj.id.au>; Philipp Zabel
>>>> <p.zabel@pengutronix.de>; openbmc@lists.ozlabs.org;
>>>> linux-arm-kernel@lists.infradead.org;
>>>> linux-aspeed@lists.ozlabs.org; linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH v4 2/3] dt-bindings: i2c-ast2600: Add support for
>>>> AST2600 i2C driver
>>>>
>>>> On 15/02/2023 06:43, Ryan Chen wrote:
>>>>>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>>>>>> +
>>>>>>> +properties:
>>>>>>> +  compatible:
>>>>>>> +    enum:
>>>>>>> +      - aspeed,ast2600-i2c
>>>>>>
>>>>>> NAK. It's already there. Please do not waste our time in submitting
>>>>>> duplicated drivers.
>>>>>
>>>>> It is not duplicated, as my description in cover " This series add
>>>>> AST2600 i2c
>>>> new register set driver"
>>>>> So, this will be different driver compatible.
>>>>> The original compatible is
>>>>>       - aspeed,ast2400-i2c-bus
>>>>>       - aspeed,ast2500-i2c-bus
>>>>>       - aspeed,ast2600-i2c-bus
>>>>> So the new register set compatible is "- aspeed,ast2600-i2c", remove
>> "bus".
>>>>
>>>> Bindings are documenting hardware, so I claim - we already have this
>>>> hardware described and this is duplicated. Otherwise - what are these
>>>> two I2C controllers and what are the differences? Why they do not
>>>> have really different name? Bus looks more like a mistake than a
>> differentiating name.
>>> For misunderstanding, or mistaken.
>>> I purpose to be aspeed,ast2600-i2cv2, will it more clear way ?
>>
>> I don't know. I still did not get answers. I asked here several questions.
> Those are different i2c controller, as I description in cover letter.

The cover letter does not explain here anything. It barely mentions "new
register set" and "separate register set". This is really short, so
without proper explanations you will get all these questions. Are they
compatible? Do they overlap? Are they completely different? If so, why
datasheet uses same name for them? So many questions but cover letter is
basically two sentences and here:

> The i2c new register mode, there have two separate slave/master register.
> And different register with old register.

you repeat the same.

> So now, avoid misunderstanding, or mistaken.
> I purpose to be aspeed,ast2600-i2cv2.


Best regards,
Krzysztof

