Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E26A6BAA1E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 08:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231631AbjCOHzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 03:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbjCOHyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 03:54:50 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A922C1ACF0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:54:47 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id o12so71944917edb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 00:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678866886;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CGokAd+Dr918esPUzr/DO2T6cLuzXjG29Q1I7nlcsV4=;
        b=Aq3pUPe+Yq9odw4NiSk5BikfXNxFmlbS2PeDaEbS9kMtEK6DjQJJ0a050lQd2priML
         Q+vIec6EmfSDB3ORVgN6E5YiCGXK5Mbv11KpwR5+5m0Pe88oZKDIrJByCiWZ5b/4wpCh
         qiWdq6LSw6IgYNHy/wfIhLhhL5awFZiQvYBTdEvZ74km59oa0XCtRae1Qw4wDvXcH/t4
         YzVFwKUM/e1EsqzgYhzNfYeP+K3/+wWAweyQlM6Qkz6GH/veZNtm2cMAFWqV2C1VGw5X
         Bly1QRNALqa0biIBqSarZxtcPdFCtwTyMw9kA/ITmhVlE27zt0OrzWH8WgbbRlJnLH5t
         4nqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678866886;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CGokAd+Dr918esPUzr/DO2T6cLuzXjG29Q1I7nlcsV4=;
        b=gU12367cfEunCclfnxah4M73xf6yWN8ez2ajiv+0Gghs+OW+0AQpwdDtCZ6i0zGIk1
         TaIEf46+9rzEDlCYhxe/qnkZoYdOvHfnDXEPx9A/u04fprmvqWVAJBWotmDJKy9XsFrC
         zkO65QtNfKE5JvTZoHVlGH4UV5Hl47gbB81wgjZLUnfFLxVeG6Pgt5+aUzo5SrmJ51u8
         Dhp9EvYfUJMyGeaazwktTgVqHdDOmFTdZgD2vkwht/Cmdi1YlWuD6lNLTjXwdJZWRwXe
         D/iRArFiaKxQwd7b3b4wT/vycIPFKtkuZERGzYebBGyhSoGU2nKeoVI9ydcs2X2UovZ/
         1Fsw==
X-Gm-Message-State: AO0yUKUVuR37NMsdCA5d0rlKvKLhKsS1CNjyRy8pSe12xSTebRIWv7Ly
        C2EbXgX4/9xC8iYURWh+g5S0Vw==
X-Google-Smtp-Source: AK7set9rj23a2BjdFJHQhkbMlpCGEw31BGoFvqoNcch9d2eIw6+5ljDRSISrD9pb1w3muiNZB3U70g==
X-Received: by 2002:aa7:cd15:0:b0:4ad:f811:e267 with SMTP id b21-20020aa7cd15000000b004adf811e267mr1371897edw.12.1678866886093;
        Wed, 15 Mar 2023 00:54:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:940e:8615:37dc:c2bd? ([2a02:810d:15c0:828:940e:8615:37dc:c2bd])
        by smtp.gmail.com with ESMTPSA id k5-20020a50ce45000000b004bf76fdfdb3sm1981430edj.26.2023.03.15.00.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 00:54:45 -0700 (PDT)
Message-ID: <064b170a-c26e-f9a6-9d17-01edeeec55a8@linaro.org>
Date:   Wed, 15 Mar 2023 08:54:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v5 3/3] dt-bindings: gpio: add NPCM sgpio driver bindings
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Jim Liu <jim.t90615@gmail.com>, JJLIU0@nuvoton.com,
        KWLIU@nuvoton.com, linus.walleij@linaro.org, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org
References: <20230314092311.8924-1-jim.t90615@gmail.com>
 <20230314092311.8924-4-jim.t90615@gmail.com>
 <bfb04dde-8429-215f-3aae-7e3823ee154c@linaro.org>
In-Reply-To: <bfb04dde-8429-215f-3aae-7e3823ee154c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/03/2023 19:45, Krzysztof Kozlowski wrote:
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/nuvoton,npcm7xx-clock.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    gpio8: gpio@101000 {
>> +        compatible = "nuvoton,npcm750-sgpio";
>> +        reg = <0x101000 0x200>;
>> +        clocks = <&clk NPCM7XX_CLK_APB3>;
>> +        interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>> +        gpio-controller;
>> +        #gpio-cells = <2>;
>> +        nuvoton,input-ngpios = <64>;
>> +        nuvoton,output-ngpios = <64>;
>> +        status = "disabled";
> 
> So this is fifth reminder...
> 
> https://lore.kernel.org/all/d56c24c2-a017-8468-0b3a-bd93d6024c69@linaro.org/
> 
> https://lore.kernel.org/all/39efdb85-f881-12ab-e258-61175f209b4c@linaro.org/
> 
> https://lore.kernel.org/all/9fc4d874-a0d0-6c5c-aeee-61ab817fdd9f@linaro.org/
> 
> This is a not-that-friendly-anymore reminder during the review process.
> 
> It seems my previous comments were not fully addressed. Maybe my
> feedback got lost between the quotes, maybe you just forgot to apply it.
> Please go back to the previous discussion and either implement all
> requested changes or keep discussing them.

BTW, you never responded that my comment is unclear, but I can imagine
that this was the cause of some misunderstanding. Therefore just in case
let's be clear: drop the "status line". Entire line.

Best regards,
Krzysztof

