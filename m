Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126AC6404F0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 11:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232971AbiLBKnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 05:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiLBKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 05:43:06 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76AB1183AB
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 02:43:01 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id c1so6787953lfi.7
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 02:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FOsmaL4anJC2+9DXpJewYEXrleBsDHtL92Z/rXNrpKo=;
        b=eAJDJN0qMViRxh4ns/kXNjw3fCtoTmUzOhKbXZdJvcQZbau/z2W5Qc6/daAooUOecV
         uyUKNXPmweLEKWUTHQZCxwzcqMwACGyy6FmbUhXldMkW/gSleQF1bLL3NOPV4aFwlwpH
         n+GY/namLNOMdT2DS4dUYsedkTRkW6TgMEgD2ezt9ZBUmBXUCdoWjjUHVH9ePr50Ckr8
         iQWtNbUMDPmoqC9osJ/+PemjROT/CUXFTBhJf1bYD3kL6MtqPhi+NqEcb1D5+u62HcJL
         9vbkRqQs9V2qXMoPjzKw0xUFDk6DqqHoC0ikgIZZ32bn0po80tojrIP94rDaItgmwNK2
         eH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FOsmaL4anJC2+9DXpJewYEXrleBsDHtL92Z/rXNrpKo=;
        b=pe+UGlOtQV2rirPteANMxCbd17FRmE7yV7q+WdZdPaOYkysjUBBlrNxIWybFNBsfMp
         XDQgkwmqNT4HAddT4YiKSqgiHjyrfKBuUVFx52OlQw5ZONfzE+JVo2mXRChpb2mbQ+3J
         iH+hWgdkMG196kJSp06ZbiG2I8R2HsvZJDFBi3AwdQ4OlUGe0D/ycz2Nw0NaGxvVcM/U
         xa9k6oXtmgEcSH4KrKqSLLby6Xr7L9/Epv2AxkL5boF15yE/WbnTvSKoZ6JDwoSUy6R8
         0PI2j9btoAIbWPJHzyf6kAjzcLqCIfPshuIGX0ZesMzdq3jqr1No/8DrgK+ceQ4/wro9
         mrIA==
X-Gm-Message-State: ANoB5pn/AGVx/Luisfl6vbHqfWaQPqNUoAMyrFi63CUA6OB2h/8QNt+v
        rDOHeQlM9kK6nvyg1Hu3PeZ+UQ==
X-Google-Smtp-Source: AA0mqf5UBOg0i6Xr6M6KKYFT9OI7GF9i21kFLBRMat9GNrL6pNiojrS10vzl1eD/ZKgZfWiEKVBctA==
X-Received: by 2002:a19:7111:0:b0:499:b4b3:2f68 with SMTP id m17-20020a197111000000b00499b4b32f68mr16889454lfc.203.1669977779852;
        Fri, 02 Dec 2022 02:42:59 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id c10-20020a056512074a00b00499f9aaa9desm972863lfs.179.2022.12.02.02.42.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 02:42:58 -0800 (PST)
Message-ID: <38fda078-e4d4-5172-25c7-b126282f9f88@linaro.org>
Date:   Fri, 2 Dec 2022 11:42:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v8 01/11] dt-bindings: clock: meson: add A1 PLL clock
 controller bindings
Content-Language: en-US
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        martin.blumenstingl@googlemail.com
Cc:     jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20221201225703.6507-1-ddrokosov@sberdevices.ru>
 <20221201225703.6507-2-ddrokosov@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221201225703.6507-2-ddrokosov@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/2022 23:56, Dmitry Rokosov wrote:
> From: Jian Hu <jian.hu@amlogic.com>
> 
> Add the documentation to support Amlogic A1 PLL clock driver,
> and add A1 PLL clock controller bindings.
> 
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> ---
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   | 52 +++++++++++++++++++
>  include/dt-bindings/clock/a1-pll-clkc.h       | 16 ++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
>  create mode 100644 include/dt-bindings/clock/a1-pll-clkc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> new file mode 100644
> index 000000000000..d67250fbeece
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/amlogic,a1-pll-clkc.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/amlogic,a1-pll-clkc.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"

Drop quotes from both.

> +
> +title: Amlogic Meson A/C serials PLL Clock Control Unit Device Tree Bindings

Drop "Device Tree Bindings"

> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>

Not correct email address.

> +  - Jerome Brunet <jbrunet@baylibre.com>
> +  - Jian Hu <jian.hu@jian.hu.com>
> +
> +properties:
> +  compatible:
> +    const: amlogic,a1-pll-clkc
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +     - description: input xtal_fixpll
> +     - description: input xtal_hifipll

As pointed already - this patch cannot work and must not be merged.

> +
> +  clock-names:
> +    items:
> +      - const: xtal_fixpll
> +      - const: xtal_hifipll
> +
> +required:
> +  - compatible
> +  - "#clock-cells"
> +  - reg
> +  - clocks
> +  - clock-names
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    clkc_pll: pll-clock-controller@7c80 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +                compatible = "amlogic,a1-pll-clkc";

Use 4 spaces for example indentation.

> +                reg = <0 0x7c80 0 0x18c>;
> +                #clock-cells = <1>;
> +                clocks = <&clkc_periphs 1>,
> +                         <&clkc_periphs 4>;
> +                clock-names = "xtal_fixpll", "xtal_hifipll";
> +    };
> diff --git a/include/dt-bindings/clock/a1-pll-clkc.h b/include/dt-bindings/clock/a1-pll-clkc.h
> new file mode 100644
> index 000000000000..58eae237e503
> --- /dev/null
> +++ b/include/dt-bindings/clock/a1-pll-clkc.h 

Filename matching compatible / bindings file.

> @@ -0,0 +1,16 @@

Best regards,
Krzysztof

