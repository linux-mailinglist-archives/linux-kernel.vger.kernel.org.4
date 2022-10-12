Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7EA5FC693
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Oct 2022 15:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbiJLNgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 09:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJLNf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 09:35:59 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51CAC3B7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:35:56 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id h15so6013841qtu.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 06:35:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p9wv8237wgiOHnZzBeahRRwwZUTEpSK22YpW0WQ8ENQ=;
        b=CjpoFkyKt2Uj/f6Lutf+q+eujpjTXoQucjGCs5xN1wirDfpq/0VvBPWcYKcLddDJXy
         djpKrpZvTmv3ZoHid7/65Bnf/1/dOnIcA5QYJ156coiid0vDg+n0PMHRSSGQcxwTxuNU
         NyWVYMO9YA+CLepPyiIQi3efN6EZpZxCkC8M7MROypc7fzVg+XJo/mxouo3fBC1NEq4j
         SqVrnI8AflI1sBsvVftUCjYx7d4qk1fuHfM4I+fnkPZ6HtusEJ16xDYm8Jq/hSLyBeZK
         WIKAs2sSxNdCBQ03vVFfFeezd/VBd1nLR3vZWiszCzozsTpFLjRf2EwYSdZCJSMNzDGy
         eX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p9wv8237wgiOHnZzBeahRRwwZUTEpSK22YpW0WQ8ENQ=;
        b=yE8f9pB+QaQQMhBE2QB+T2IoQf8W0dVYPXH68cjdLEG39S6Mi140ZeJahEbK/7xtTn
         CyBNjktOkSfKOXQrQaufw81pd1NBfpE87U7U0+5te9wdTnTQp5Qogb8gyodOblEmlqeI
         u7CLjmCtUn30KrgCzjd1tc6L2OFPHAAyToDjbO62Cc0vl2VaHcAkm0Q2Hr0wthg39eVH
         gicGd1Xd5Y3qIAflUwfC7Fj8kIwIvKgRbz+jb9u3wtYe1m0oh57KlXDHL/SYwNnODoC2
         gBObPrSc1foP9jmIHp1QXxoH79gUTopD/x7WcM7HpPOnWoHI0zwvD8PGufumJI0sMLqT
         4/LA==
X-Gm-Message-State: ACrzQf1dnZ2DdntUOcDVaMMgx562luMEX/DM2G8RQGPVdLCqDMGG657u
        TE+KKeWPmCVE8Cn91bsu9O8v6A==
X-Google-Smtp-Source: AMsMyM7q7HOB8fihkeRyzWXkhwIJbD9lX9nJvsCeMqMfFiR6wEnE4o8DM3wgIHiz9qtWeHFh2y6ftw==
X-Received: by 2002:a05:622a:60b:b0:399:69c8:9b54 with SMTP id z11-20020a05622a060b00b0039969c89b54mr14464320qta.180.1665581755389;
        Wed, 12 Oct 2022 06:35:55 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id p16-20020a05620a057000b006bb29d932e1sm5669503qkp.105.2022.10.12.06.35.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Oct 2022 06:35:54 -0700 (PDT)
Message-ID: <9f04267d-2592-b303-9b79-9cef672c970a@linaro.org>
Date:   Wed, 12 Oct 2022 09:33:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v1 12/30] dt-bindings: reset: Add starfive,jh7110-reset
 bindings
Content-Language: en-US
To:     Hal Feng <hal.feng@linux.starfivetech.com>
Cc:     Rob Herring <robh@kernel.org>, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        linux-kernel@vger.kernel.org
References: <20220929143225.17907-1-hal.feng@linux.starfivetech.com>
 <20220929175147.19749-1-hal.feng@linux.starfivetech.com>
 <20220929184349.GA2551443-robh@kernel.org>
 <8BEAFAD2C4CE6E4A+0a00376c-1e3e-f597-bcf6-106ff294859a@linux.starfivetech.com>
 <2f1d1afd-3c97-6ce0-8247-6e1c4a24e548@linaro.org>
 <4769BE3503398017+b1699221-ccc9-a0c1-0b11-141ce9644d74@linux.starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <4769BE3503398017+b1699221-ccc9-a0c1-0b11-141ce9644d74@linux.starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/10/2022 09:16, Hal Feng wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    enum:
>>>>> +      - starfive,jh7110-reset
>>>>
>>>> 'reg' needed? Is this a sub-block of something else?
>>>
>>> Yes, the reset node is a child node of the syscon node, see patch 27 for detail.
>>> You might not see the complete patches at that time due to technical issue of
>>> our smtp email server. Again, I feel so sorry about that.
>>>
>>> 	syscrg: syscrg@13020000 {
>>> 		compatible = "syscon", "simple-mfd";
>>> 		reg = <0x0 0x13020000 0x0 0x10000>;
>>>
>>> 		syscrg_clk: clock-controller@13020000 {
>>> 			compatible = "starfive,jh7110-clkgen-sys";
>>> 			clocks = <&osc>, <&gmac1_rmii_refin>,
>>> 				 <&gmac1_rgmii_rxin>,
>>> 				 <&i2stx_bclk_ext>, <&i2stx_lrck_ext>,
>>> 				 <&i2srx_bclk_ext>, <&i2srx_lrck_ext>,
>>> 				 <&tdm_ext>, <&mclk_ext>;
>>> 			clock-names = "osc", "gmac1_rmii_refin",
>>> 				"gmac1_rgmii_rxin",
>>> 				"i2stx_bclk_ext", "i2stx_lrck_ext",
>>> 				"i2srx_bclk_ext", "i2srx_lrck_ext",
>>> 				"tdm_ext", "mclk_ext";
>>> 			#clock-cells = <1>;
>>> 		};
>>>
>>> 		syscrg_rst: reset-controller@13020000 {
>>> 			compatible = "starfive,jh7110-reset";
>>> 			#reset-cells = <1>;
>>
>> So the answer to the "reg needed?" is what? You have unit address but no
>> reg, so this is not correct.
> 
> Not needed in the reset-controller node, but needed in its parent node. 

We do not talk about parent node. Rob's question was in this bindings.
Is this document a binding for the parent node or for this node?

> I am sorry
> for missing description to point it out in the bindings. I will rewrite all bindings
> for the next version. Unit address here should be deleted.
> 
>>
>>> 			starfive,assert-offset = <0x2F8>;
>>> 			starfive,status-offset= <0x308>;
>>> 			starfive,nr-resets = <JH7110_SYSRST_END>;
>>> 		};
>>> 	};
>>>
>>> In this case, we get the memory mapped space through the parent node with syscon
>>> APIs. You can see patch 13 for detail.
>>>
>>> static int reset_starfive_register(struct platform_device *pdev, const u32 *asserted)
>>> {
>>
>>
>> (...)
>>
>>>
>>>>
>>>>> +
>>>>> +  "#reset-cells":
>>>>> +    const: 1
>>>>> +
>>>>> +  starfive,assert-offset:
>>>>> +    description: Offset of the first ASSERT register
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +
>>>>> +  starfive,status-offset:
>>>>> +    description: Offset of the first STATUS register
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>
>>>> These can't be implied from the compatible string?
> 
> Definitely can. We do this is for simplifying the reset driver.

The role of the bindings is not to simplify some specific driver in some
specific OS...

> Otherwise, we may need to define more compatibles because there
> are multiple reset blocks in JH7110. Another case can be found at
> https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/reset/altr,rst-mgr.yaml

And why is this a problem? You have different hardware, so should have
different compatibles. Otherwise we would have a compatible
"all,everything" and use it in all possible devices.

>>> These two properties are the key differences among different reset controllers.
>>
>> Different as in different compatibles? Please answer the questions..> 
>>> There are five memory regions for clock and reset in StarFive JH7110 SoC. They
>>> are "syscrg", "aoncrg", "stgcrg", "ispcrg" and "voutcrg". Each memory region
>>> has different reset ASSERT/STATUS register offset and different number of reset
>>> signals. 
>>
>> Then these are not exactly the same devices, so using one compatible for
>> them does not look correct.
> 
> One compatible can just be matched by one device? I think this is what
> confuses me.

I don't understand the question.

> 
> Best regards,
> Hal
> 

Trim the replies - no need to quote everything (entire message following
last reply/quote).

Best regards,
Krzysztof

