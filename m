Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957D561E156
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 10:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiKFJix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 04:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiKFJiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 04:38:50 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625DDB86F
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 01:38:49 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id r12so13058964lfp.1
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 01:38:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kNcPbiTtKpD6IeXGZRhKfWEIaqsnPCpZykUhNtEV+kw=;
        b=a7rblEkvWgEaV3jJzr6jXbk88yee6wwiTxq57880FWvqNyS4evbW4uWNVV8Y8jETDQ
         TIyIs9rWrESjVi3RMp7Ru5gQJle8041LBqjw6orQlbjXglYb5Z744TZN3aM2QBHlKkcn
         vdSOPGWHZuOnPqQdkownF6E/D7N12W0ztU1FRAhcia85nsDoUKUkqXarFunFeOIoPOpJ
         NEyTb8mGgRODA4dpgTBji0tnlxedxecHQor3o/rvC3boHUaXFh3iG3+I0SZZ1qGT4svI
         k0uoF6tVmhBlYiyk8ILxYcaEW471p2r/Wp/9+10Uoa2vKbTX+PCvV9l4NMDy07cgdWQs
         QOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kNcPbiTtKpD6IeXGZRhKfWEIaqsnPCpZykUhNtEV+kw=;
        b=lw+lfrA6cW2ccEvUlFYYPWOhiSpodmKApMx7Ohz3kz9wOgBewdfz9pvnqYcM2WlzJV
         CEnF9QgI5SilRCgYTA/ndnSyYGBmfrPSzWzqpoVBG+M6/UeiT+9isrNwhZxll6ZbUy2v
         BDBA5QWeYID9Dg4g7Y4tsywBfgO+sy+MP5Sv6OPx2AzXIK+p9ntVy/yOIGYct9jQzzda
         bTKkFPvGZRvAc7jm5fyBvA7RfdFTz5yRT52Sj3vbkujMldvWcMBS9y2bjPW02ZzNP5Gj
         ZkCJhPQkOSBUhXTj1g1BbCH/91NlLbOpdYwiT17TjxtS5ZjK83qaEs0t9SiXMLnJ6flY
         P2Zg==
X-Gm-Message-State: ANoB5pmOU+vLr1d9kBqE5vDPUr/+Lmfuckn8RAS5M0zVm5ei5uwBHvII
        UgXMZNZU+EJ5pOF3BcmSEzwiqA==
X-Google-Smtp-Source: AA0mqf4M4XA4jHXwLz76P2AsPepgvgge9/+uH+I9DqRHDvW3zhRaEVNNM/WAz1ZafRXNOtPRccmYMA==
X-Received: by 2002:ac2:414a:0:b0:4b3:61f8:8f8a with SMTP id c10-20020ac2414a000000b004b361f88f8amr1912254lfi.482.1667727527671;
        Sun, 06 Nov 2022 01:38:47 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id u8-20020a05651c130800b0026e02eb613csm615610lja.18.2022.11.06.01.38.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Nov 2022 01:38:47 -0800 (PST)
Message-ID: <066919b1-c43d-f8ed-0191-cce8c575ee37@linaro.org>
Date:   Sun, 6 Nov 2022 10:38:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 3/8] dt-bindings: spi: Add Nuvoton WPCM450 Flash Interface
 Unit (FIU)
Content-Language: en-US
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        linux-spi@vger.kernel.org, openbmc@lists.ozlabs.org
Cc:     Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
References: <20221105185911.1547847-1-j.neuschaefer@gmx.net>
 <20221105185911.1547847-4-j.neuschaefer@gmx.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221105185911.1547847-4-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2022 19:59, Jonathan Neuschäfer wrote:
> The Flash Interface Unit (FIU) is the SPI flash controller in the
> Nuvoton WPCM450 BMC SoC. It supports four chip selects, and direct
> (memory-mapped) access to 16 MiB per chip. Larger flash chips can be
> accessed by software-defined SPI transfers.
> 
> The FIU in newer NPCM7xx SoCs is not compatible with the WPCM450 FIU.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/spi/nuvoton,wpcm450-fiu.yaml     | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
> 
> diff --git a/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
> new file mode 100644
> index 0000000000000..dc0ea2184f8d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/spi/nuvoton,wpcm450-fiu.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/spi/nuvoton,wpcm450-fiu.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Nuvoton WPCM450 Flash Interface Unit (FIU)
> +
> +maintainers:
> +  - Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> +
> +allOf:
> +  - $ref: "/schemas/spi/spi-controller.yaml#"

Drop the quotes.

> +
> +properties:
> +  compatible:
> +    const: nuvoton,wpcm450-fiu
> +
> +  reg:
> +    items:
> +      - description: FIU registers
> +      - description: Memory-mapped flash contents
> +
> +  reg-names:
> +    items:
> +      - const: control
> +      - const: memory
> +    minItems: 1

This does not match your 'reg'. Two items are required there.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  nuvoton,shm:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: a phandle to the SHM block (see ../arm/nuvoton,shm.yaml)
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> +    spi@c8000000 {
> +      compatible = "nuvoton,wpcm450-fiu";
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      reg = <0xc8000000 0x1000>, <0xc0000000 0x4000000>;

reg is the second property.

> +      reg-names = "control", "memory";
> +      clocks = <&clk WPCM450_CLK_FIU>;
> +      nuvoton,shm = <&shm>;
> +
> +      flash@0 {
> +        compatible = "jedec,spi-nor";
> +      };
> +    };
> +
> +    shm: syscon@c8001000 {
> +      compatible = "nuvoton,wpcm450-shm", "syscon";
> +      reg = <0xc8001000 0x1000>;
> +    };
> +
> +  - |
> +    #include <dt-bindings/clock/nuvoton,wpcm450-clk.h>
> +    spi@c8000000 {
> +      compatible = "nuvoton,wpcm450-fiu";
> +      // the "memory" resource may be omitted

This is rather obvious, so what you should comment is WHY or WHEN second
resource can be omitted.

Not every instance on the hardware has it?

Just to remind - this is the description of hardware, not Linux behavior.

> +      reg = <0xc8000000 0x1000>;
> +      reg-names = "control";
> +    };
> --
> 2.35.1
> 

Best regards,
Krzysztof

