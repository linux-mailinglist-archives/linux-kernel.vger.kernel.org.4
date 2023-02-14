Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE31696632
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjBNOMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjBNOM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 09:12:26 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80F298C7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:11:55 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id o18so15811381wrj.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 06:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sajY9FZqzLSzPCMgEW1O4rOAxb6+m9fSt/2pxwQfCgA=;
        b=KYN2KNBt/LUIs+pRXfiBIhd/D5Y0d6QQMZapeeEZxBTtLLDQB8eHH6gjL7OMbcpjJ0
         af8h8yk+z5i0VAC4tH0sZO3KZp3pzU3XgdWHomenan+1KMCxTZ3slNKl/boEsZ3PM48v
         Uyg754ozbjXseD4iExTg9NwaYGhgZ21LCl/UZLsmRsg6guWmmrN2YlD5HJOkqvCHO1id
         dKDBGxVQFkhnfA35f57rvQ/o786k5mUaRfOu9jDdYRnjPIHgfDK1qLc534OD/m4eXzyb
         OZZ3naeTcjxCuyoRP1cOle3uF2eWFxHTKi1pCtITbzFQjxcuJoD2vQDsitBYmK0Lesjg
         bswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sajY9FZqzLSzPCMgEW1O4rOAxb6+m9fSt/2pxwQfCgA=;
        b=DYM/8CEOLUcBqPrvxilj2Xtm1hKCo9CrBqppgEqSCufvbfYPDp1Rsn2adouFGxI2GZ
         QvXCrQaNRC4g2G4UZm/CwecydLpQUj3hO7SF26r4b8Qsoni65UVGjjIMjPKeY5Y8johu
         vHzHcRJYgoiquAMiSntiEEBhkikJL/s5ilYfH8vxJI5OfeTOfWXeeaK4zoYUS8r+027R
         ZarE0GPCA1rxtzXeWlsPF/jQpAPJtyPHyj6hLI5LRJwkiqVxmS9Tb9XiS84a0CUD5Ph8
         Wb2LPZzv5mwyYHvdfhOHWjIGjzBh7Ke3XmAVIBMC/HHnHI49GvYr2cDE3j02cLcTLLxE
         theg==
X-Gm-Message-State: AO0yUKX4X0vqisBLNmYjaw9jgGsZtwrYZrL1dxRmk5Lo/8nNHrv7Hcg0
        nRSed7ChVO/npsXF944m/wYpmg==
X-Google-Smtp-Source: AK7set+VunAbU+8jTt1a3+RSvSh5K+lG8vL3bzD2/u6nRlzbf02orxzROeLQG7OY/r3nSu2beWuaAA==
X-Received: by 2002:a05:6000:1244:b0:2c5:4cd0:4b86 with SMTP id j4-20020a056000124400b002c54cd04b86mr2277820wrx.68.1676383885424;
        Tue, 14 Feb 2023 06:11:25 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id p11-20020a5d4e0b000000b002c56179d39esm2587308wrt.44.2023.02.14.06.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 06:11:24 -0800 (PST)
Message-ID: <c4f5f733-ce22-2dfa-30f7-cde309eadaf9@linaro.org>
Date:   Tue, 14 Feb 2023 15:11:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] dt-bindings: sound: ep93xx: Add I2S and AC'97
 descriptions
Content-Language: en-US
To:     Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        devicetree@vger.kernel.org
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230212232137.299005-1-alexander.sverdlin@gmail.com>
 <46d5b6af-23e1-4178-83bc-b4a435b1426e@linaro.org>
 <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <109868b9492aecaca0a7170cba9fb51e62de7116.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 14:02, Alexander Sverdlin wrote:
> Hello Krzysztof,
> 
> thank you for the quick review!
> 
> On Tue, 2023-02-14 at 11:58 +0100, Krzysztof Kozlowski wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: cirrus,ep9301-i2s
>>> +
>>> +  '#sound-dai-cells':
>>> +    const: 0
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    minItems: 3
>>
>> maxItems instead
> 
> reg and clocks are required, I suppose I should include both minItems
> and maxItems for both of them?

No. minItems is implied.

> 
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: mclk
>>> +      - const: sclk
>>> +      - const: lrclk
>>
>>
>> The clk suffixes are quite redundant. Don't these inputs have some
>> meaningful name?
> 
> They are actually meaningful, as they are usually named in I2S, please
> refer to the EP93xx User's Guide:
> https://cdn.embeddedts.com/resource-attachments/ts-7000_ep9301-ug.pdf
> page 71, for instance.

OK, but then I like the example - if datasheet would use name
"clk_clk_this_is_clk" would you still find it meaningful?

Every clock input in clocks is a clock. There is usually no need to say
that a clock is a clock...

> 

Best regards,
Krzysztof

