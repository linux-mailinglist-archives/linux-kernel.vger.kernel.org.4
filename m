Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BBE6FBF36
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 08:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234880AbjEIGZR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 02:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjEIGZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 02:25:16 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554FA5FA
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 23:25:13 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50db7f0a1b4so678125a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 08 May 2023 23:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683613511; x=1686205511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TfYutvSnmG0xToTn7QuW3dip61h04rlgqKGBarW0D6c=;
        b=FFt4aoW2plUl9LBzp86tsiKAP2L9t6isoWwmEom+HSgYeKssPi9XIK42kNricy7P+d
         MenvmyDOSxmQfo42+yeLTxiENNbV6LdR5IBOq+d0oFgBQ8iiXrhxJoI+NtIjnN73LVoQ
         FpjsGop5ymBBpkI+eedhjaFngehkvES2xMjyEr+aBnsUB596DBooBZCAlP8OL3jGuSsP
         Jg1wn+ipDeALdiXOUFNo2YoekShzOd17yOfh/SsV3Ce96nNDkwDw3ZYcOTVNj4X2S6kb
         cY/p0/U/JF2g1dKzbKQ9HkMC0+VHSd48LurAB2fDzEf6hZ/Gf5/SRU3cIX2aPfqEZXSs
         CqhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683613511; x=1686205511;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TfYutvSnmG0xToTn7QuW3dip61h04rlgqKGBarW0D6c=;
        b=PTpFkWkO5WCUEWw36hr6oA5QqXCGAgjBXMZt33/GZSlJd5Hul/fsJ3YqE+vEilVihA
         vN08TARw3YFoQOGRUKNSu6M7FjqONuEdaSIBUQnDALDxiUwiFqz0EVcKSyENa2w6gMa4
         frjiIZtrSKb9MGAl6exkpYO8Nv62ccH1oCvQOvB3wSVpGWd4fKKY7dWycF9LoNQfZZWM
         btjXRDcr+WmIxpnocLi/LEJdsc+X10OkFJGHFkMX2Nm584AZYt4Yy2rX5zfI5hLlOXtr
         l+RPIbD3Opde7hfMZ3EexOw0fHPReWpivNf7GlN1Z0+BlMpnI6SagLyXiZ6i99LFnMom
         MsSQ==
X-Gm-Message-State: AC+VfDwCEaiOGVUpgfQfHeXBAEkn8vWHmz3lpwKyqD7M12A5ZPwNs/G4
        D61Gk8pnRLeZ9M2QRHjPMKNXHA==
X-Google-Smtp-Source: ACHHUZ4c7ZhS+2SHxTATjrVi07zz9QxVLQYPzgHka/2yGmY9HGKxWiS52td6vghMy16CRpuFKbm8AA==
X-Received: by 2002:a50:fe8c:0:b0:506:ba8d:c317 with SMTP id d12-20020a50fe8c000000b00506ba8dc317mr9294753edt.40.1683613511519;
        Mon, 08 May 2023 23:25:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:d0d5:7818:2f46:5e76? ([2a02:810d:15c0:828:d0d5:7818:2f46:5e76])
        by smtp.gmail.com with ESMTPSA id j10-20020aa7ca4a000000b005066cadcc54sm360829edt.43.2023.05.08.23.25.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 May 2023 23:25:11 -0700 (PDT)
Message-ID: <e463eb68-3ea0-5230-76fd-4a2ee66bf397@linaro.org>
Date:   Tue, 9 May 2023 08:25:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 2/5] dt-bindings: clocks: atmel,at91rm9200-pmc: convert
 to yaml
Content-Language: en-US
To:     Claudiu Beznea <claudiu.beznea@microchip.com>,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230509052757.539274-1-claudiu.beznea@microchip.com>
 <20230509052757.539274-3-claudiu.beznea@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509052757.539274-3-claudiu.beznea@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 07:27, Claudiu Beznea wrote:
> Convert Atmel PMC documentation to yaml. Along with it clock names
> were adapted according to the current available device trees as
> different controller versions accept different clocks (some of them
> have 3 clocks as input, some has 2 clocks as inputs and some with 2
> input clocks uses different clock names).
> 

Thank you for your patch. There is something to discuss/improve.

> +title: Atmel Power Management Controller (PMC)
> +
> +maintainers:
> +  - Claudiu Beznea <claudiu.beznea@microchip.com>
> +
> +description:
> +  The power management controller optimizes power consumption by controlling all
> +  system and user peripheral clocks. The PMC enables/disables the clock inputs
> +  to many of the peripherals and to the processor.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - items:
> +          - enum:
> +              - atmel,at91sam9g15-pmc
> +              - atmel,at91sam9g20-pmc
> +              - atmel,at91sam9g25-pmc
> +              - atmel,at91sam9g35-pmc
> +              - atmel,at91sam9x25-pmc
> +              - atmel,at91sam9x35-pmc
> +          - enum:
> +              - atmel,at91sam9260-pmc
> +              - atmel,at91sam9x5-pmc

I missed it last time - why you have two enums? We never talked about
this. It's usually wrong... are you sure this is real hardware:
atmel,at91sam9g20-pmc, atmel,at91sam9260-pmc
?


> +          - const: syscon
> +      - items:
> +          - enum:
> +              - atmel,at91rm9200-pmc
> +              - atmel,at91sam9260-pmc
> +              - atmel,at91sam9g45-pmc
> +              - atmel,at91sam9n12-pmc
> +              - atmel,at91sam9rl-pmc
> +              - atmel,sama5d2-pmc
> +              - atmel,sama5d3-pmc
> +              - atmel,sama5d4-pmc
> +              - microchip,sam9x60-pmc
> +              - microchip,sama7g5-pmc
> +          - const: syscon
> +


Best regards,
Krzysztof

