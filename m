Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35AE6698567
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 21:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjBOUSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 15:18:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjBOUSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 15:18:02 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710F52942B
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:18:01 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r2so20382740wrv.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 12:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eWNTWWkTsrwbHiQ47mdX5pMgCivT3DFoqhaaJ7ihy2A=;
        b=CMTgnuiGwiQsea1Sd6odLVgvg1S5toQiP/KqfHF/kU8U1BTmaxTmcUgEBDrA935SDO
         Gcs11rVgm9HQugH5nzsUDZ79NUA31L0DyszfiRHxmSiOWOAPFbLz0u6nwX3MzvhC3y8I
         MArr8om3fCcsiDqpjR212tBg+Rrykid834KBSPQF+9hrybHxHe+ylKeTAGdsuMPalPs1
         MhtmUTQb0LOAiVF5KiZf5Y+YtA+tu/MSIQYhRGZhpzSw3ao0aDlO47Uc0QDoCWcFJZsI
         My7H1D9xXjz5ByD4/CZnUP3LLLXc8zQRci9we7+rXZbLhfNNQVqFSLnofy0yiXqB5mxs
         bPwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eWNTWWkTsrwbHiQ47mdX5pMgCivT3DFoqhaaJ7ihy2A=;
        b=C/5Xs119ashr2/ywPBWk1FCyfLD9cJQAoQQZOGlRcwRTCxUJNdW8Nf7bYLX+8gGbiH
         ZlaZ4FEClxs/aVZ/e1JPyeXWbxRO1UIKuRPe3ynQXu3OeW/N1w2g4j9476Npxr1Ijdnc
         I/SM3Pl9ySITMIci8MYd0fJlmzj6rSzOuQSTSLmoGUDtmUxObphsEIavTHBPKtQxDkPM
         JW7dIG2nRPohWPUOLkoMiDSyQTbETzRDv/HGmf3s3UUtdGRsqE5pN+dzaoz4vKXkBgmB
         JOmZTLWS0N1RaqHCNjZalEUVXwTHP68Yr/hYR8ymh9VY93MV2YsfAhoa7HIbhp/jEMqZ
         yjIQ==
X-Gm-Message-State: AO0yUKU1oXqEISThtWC6phKnqfI8EILeQa/HmnK0QyIeebtIf/k/kRw/
        CuKzLa8y7GZT95RFjOsmAr+vAQ==
X-Google-Smtp-Source: AK7set8VH1qhZGFMpjgR8/ShMCOufa8CJRWa7LAZIqOnVqbqOnGICuSJcLOwC28dLybZKi72vOFs4w==
X-Received: by 2002:adf:f40f:0:b0:2c5:512b:afc1 with SMTP id g15-20020adff40f000000b002c5512bafc1mr2641381wro.47.1676492279913;
        Wed, 15 Feb 2023 12:17:59 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id f6-20020a5d58e6000000b002c54c7153f0sm13479318wrd.1.2023.02.15.12.17.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 12:17:59 -0800 (PST)
Message-ID: <b58fad13-12d5-346b-9452-d345c7bf5327@linaro.org>
Date:   Wed, 15 Feb 2023 21:17:56 +0100
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
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <SEZPR06MB52690A1D06F3CFEAAF1FDBDEF2A39@SEZPR06MB5269.apcprd06.prod.outlook.com>
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

On 15/02/2023 06:43, Ryan Chen wrote:
>>> +  - $ref: /schemas/i2c/i2c-controller.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - aspeed,ast2600-i2c
>>
>> NAK. It's already there. Please do not waste our time in submitting duplicated
>> drivers.
> 
> It is not duplicated, as my description in cover " This series add AST2600 i2c new register set driver"
> So, this will be different driver compatible. 
> The original compatible is 
>       - aspeed,ast2400-i2c-bus
>       - aspeed,ast2500-i2c-bus
>       - aspeed,ast2600-i2c-bus
> So the new register set compatible is "- aspeed,ast2600-i2c", remove "bus".

Bindings are documenting hardware, so I claim - we already have this
hardware described and this is duplicated. Otherwise - what are these
two I2C controllers and what are the differences? Why they do not have
really different name? Bus looks more like a mistake than a
differentiating name.

Best regards,
Krzysztof

