Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52D8C734BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbjFSG7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 02:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSG66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 02:58:58 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0441A4
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:58:57 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51a2160a271so3973370a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Jun 2023 23:58:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687157935; x=1689749935;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4G6hf18TKdmfNtJ8UCEo6JcM7dVVDUhqliUhTUBuICc=;
        b=NWnPdS7D1gDt3/LuJFeLM1TendCaMiVqQJD+F4P1R56EoN7m1O5j/1TOTzV4tW5QnM
         z3qSJa66nU6AVAXlSKmyMw7NsegMUwKGXm8x+Z7H7uR5VQUe1RKiqUi/3YDf+ipvqVWJ
         hfMZnmJd+vci2rzqV5EBfQaAiBXcZjLfnXZc9zlHgInF+kOyELYsxw8dYpWfkQ1taYhE
         3MqxdfI1BC2AQ5/9xkXVCHr/7zXKiCA1ZPyerIm0vjCqUMKFyA3lc82/CBp5mhvAUe9s
         iKqPqUVZoTtA0nVNpbq/PpBEESHcAtBD3A+maZyrJ1LCYAoDzhcCKF7kY5L9z9XaFWGL
         jKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687157936; x=1689749936;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4G6hf18TKdmfNtJ8UCEo6JcM7dVVDUhqliUhTUBuICc=;
        b=Hyjap3M0cckVxG142IuLgbRouceewIWmWgwjpWdFv2lNy8VL4fTP2pz3/bRcRbNtlw
         Ddqgq8uAeLH9j52IaVPLO9QfpU4N7L9TeX4bYrix2TUiynsfrRPampTjckB52OrRHDLR
         xU+AYF0k482rNYJwbYyAzGbvOzNJVf1J7oBOmkjuCBmWFNB+cFrZzc1FzPCkEGSbnTMh
         UlMKejSH+WkOFgTrqXea4u5L5uT8FiRODKtxgiBfqVBBSnKmrJfSYilmEb7f6WS6u7u8
         K7c88HsHsSg2QS/zRleVqpW2xMhtr6LveuovQIMwDtLnybeATDrn+nhD3uRL9MFZowx2
         vgYQ==
X-Gm-Message-State: AC+VfDwC2vR8n9CVeKlEowEYOyOeCyT/Xhhj7XjMitXjR17mGMy9ADHm
        ePVbqXww8R3linqI48Jo1qdIhw==
X-Google-Smtp-Source: ACHHUZ7dJrESQHn9geXJxEPrr2M7TIYqbkSdh/fM8A4bQoGoLVTjbKoOXm0qEqvY2My4FfHw1MZbAQ==
X-Received: by 2002:a50:ef12:0:b0:51a:f6de:bb81 with SMTP id m18-20020a50ef12000000b0051af6debb81mr150817eds.28.1687157935727;
        Sun, 18 Jun 2023 23:58:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id ca15-20020aa7cd6f000000b00514a5f7a145sm12562486edb.37.2023.06.18.23.58.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 23:58:55 -0700 (PDT)
Message-ID: <f5e6a29f-6df7-b56c-c7b2-9914008eaa33@linaro.org>
Date:   Mon, 19 Jun 2023 08:58:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v5 2/2] ARM: dts: aspeed: Adding Inventec Starscream BMC
Content-Language: en-US
To:     PJ Chen <chen.pj@inventec.com>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>, soc@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-aspeed@lists.ozlabs.org
Cc:     ye.vic@inventec.com, Huang.Alang@inventec.com
References: <20230619064249.3623-1-chen.pj@inventec.com>
 <20230619064249.3623-2-chen.pj@inventec.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230619064249.3623-2-chen.pj@inventec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2023 08:42, PJ Chen wrote:
> From: Chen PJ <Chen.pj@inventec.com>
> 
> Initial introduction of Inventec Starscream x86 family
> equipped with AST2600 BMC SoC.
> 
> Signed-off-by: Chen PJ <Chen.pj@inventec.com>
> 

...

> +	reserved-memory {
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges;
> +
> +		video_engine_memory: video {
> +			size = <0x04000000>;
> +			alignment = <0x01000000>;
> +			compatible = "shared-dma-pool";
> +			reusable;
> +		};
> +	};
> +
> +

Drop stray blank lines. Only one blank line, not two. Comment applies to
multiple places.

> +	iio-hwmon {
> +		compatible = "iio-hwmon";
> +		io-channels =
> +		<&adc_u74 0>, // P0_VDD11
> +		<&adc_u74 1>, // P1_VDD11
> +		<&adc_u74 2>, // P0_3V3_S5
> +		<&adc_u74 3>, // P1_3V3_S5
> +		<&adc_u74 4>, // P3V3
> +		<&adc_u74 5>, // VBAT
> +		<&adc_u74 6>, // P3V3_STBY
> +		<&adc_u74 7>, // P5V_STBY
> +		<&adc_u74 8>, // P5V
> +		<&adc_u74 9>, // P12V
> +		<&adc_u74 10>, // P1_VDD18_S5
> +		<&adc_u74 11> // P0_VDD18_S5
> +		;
> +	};
> +
> +	leds {
> +		compatible = "gpio-leds";
> +
> +		uid {

No improvements. Still not fixed and not tested.

Best regards,
Krzysztof

