Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5627737B15
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 08:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbjFUGDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 02:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjFUGDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 02:03:03 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF27199E
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:02:50 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9741caaf9d4so668182066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 23:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687327369; x=1689919369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oAEk81ZICVDtnc+wdWoBCpFc/VJWJ2dNtRwNJtzQAy8=;
        b=XiHH6lZdLXfcINNXyv9xpRvQR+NiN9dmTyUgmZ9J/P4nmSLifi+ZWb0O0CgM/9sQ4W
         a8eCK6gdjNGPqGDMeUVWvx8j++7TTFosFUmXpebaqEFKV10706tRCIZ/ONvgkVlnYJa5
         TS4mrZOQnGbyERQkCU5MM+AJMsz7ToARh7Gq1STPrYrKHKmujcJtI1eE5RASXsLI0vCs
         Tz2tvnCmRPZjnwqX7WW64WUwSSzFFiq9DW11fJ0V4ZoGLdhBkzvgqlnofq14xI5l8qyk
         FZ+u5MXAOETFVgBroBKqkOvIiv6layV72H7COcwB5k6fB8PhW12fk66ENKIQM7hIbYNs
         uHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687327369; x=1689919369;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oAEk81ZICVDtnc+wdWoBCpFc/VJWJ2dNtRwNJtzQAy8=;
        b=jXeY+OyMg/AvSEiCCs4AQ75LUfj59IbXF0rCR4aWSdEuIHNktpu72OHMzBb99yThdz
         0kumikgQzwsLskRmaK1v9QoQb1NpfriHUGYqXXHefosMVJ+PT+bmvxObxEdaWNUlo9G2
         hygEfBni4sAOzvXmpzvT5+Y7livP8VTMsOCxRCrzP104nv84yd8Y5Bm60iDh0AOtXT4N
         k0ucgw1n5dREgxjfpH46nRHOUIwkwX2s2OpMeQuReqFnG0SCnjmyOI/TpzO7961iI67v
         fUnmd8qhGP4vGrJcgdOnfwzF6oPh654zV7hYXMPPOM0paX18IsghgnMu31TuFy81mnbh
         v0Eg==
X-Gm-Message-State: AC+VfDxsKGLNWqmWi8qYVJK5gKtcitoD4XU0rY0UhToUHpgILtKFEygK
        N/8R+iE7JyBaghZdYjLestYVqA==
X-Google-Smtp-Source: ACHHUZ50b++2H7B0kJgKPXmL93Wl0xN8LfsMHkJef4xYJOLT4e6HR5bCEBNeFopNSOQDsDVkODhzxw==
X-Received: by 2002:a17:907:a412:b0:989:d9d:d911 with SMTP id sg18-20020a170907a41200b009890d9dd911mr4343002ejc.69.1687327369331;
        Tue, 20 Jun 2023 23:02:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id p10-20020a170906a00a00b00987bc81506dsm2482314ejy.202.2023.06.20.23.02.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 23:02:48 -0700 (PDT)
Message-ID: <76a7f819-f3d2-d39d-1bc9-f1e7f837fd22@linaro.org>
Date:   Wed, 21 Jun 2023 08:02:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 2/2] arm64: dts: meson-t7-a311d2-khadas-vim4: add
 initial device-tree
To:     Yixun Lan <dlan@gentoo.org>, Lucas Tanure <tanure@linux.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Nick <nick@khadas.com>,
        Artem <art@khadas.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
References: <20230620134857.238941-1-tanure@linux.com>
 <20230620134857.238941-3-tanure@linux.com> <ZJIjtphyKdC48JrN@ofant>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ZJIjtphyKdC48JrN@ofant>
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

On 21/06/2023 00:09, Yixun Lan wrote:
>> +		apb4: bus@fe000000 {
>> +			compatible = "simple-bus";
>> +			reg = <0x0 0xfe000000 0x0 0x480000>;
>> +			#address-cells = <2>;
>> +			#size-cells = <2>;
>> +			ranges = <0x0 0x0 0x0 0xfe000000 0x0 0x480000>;
>> +
>> +			uart_A: serial@78000 {
>> +				compatible = "amlogic,meson-t7-uart",
>                                               ~~~~~~~~~~~~~~~~~
> if you introduce new compatible string, then at least you need to document it
> so Documentation/devicetree/bindings/serial/amlogic,meson-uart.yaml need to be updated
> 
> but my qeustion here, why bother introducing new compatible string if nothing
> changed with the compatible data? given the uart is same IP with g12a, can't we just
> use "amlogic,meson-g12-uart" for this? no only it will reduce the structure length of
> meson_uart_dt_match[], but also relieve maintainer's review burden?

https://elixir.bootlin.com/linux/v6.1-rc1/source/Documentation/devicetree/bindings/writing-bindings.rst#L42

Best regards,
Krzysztof

