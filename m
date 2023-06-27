Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66D6373F48C
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 08:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjF0Gb5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 02:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbjF0Gbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 02:31:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D2710E7
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:31:52 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fa96fd7a01so22082945e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 23:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687847510; x=1690439510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2Si6Ds0vIKrIAT8qa+H99PovIF2KoNnQmkzHNG/XuQM=;
        b=eG5lY8yijNXzzf3FRRqqA8mkVVZD/ep6BhD3iqM++Qe5YM7Jw3V8PHtl+B79iaRgrq
         xuURBt6ROXEgdl871/hStZQAwLbpZ3p/VWFKxXwrN7Z/WHM4+yBr/qpGm/nargXSyzgz
         uH+yq4fyGkBZSDWqEsGNFtKbIrlWQnZ6wgnwKHZQQ1+/V5eOYlV0/fcc/saWotFFDjkz
         e3uwwnC8dRp8r745K1pPOuLXLAu9oH2ViJv1Q5ISsX9UP/mV6Fuj4w2TzkpEnrOBkgS3
         9sViazOiUny/Gz4XrvmOAKRx2k3heN+BlbowsWHasHTgO5SJnZKfAJuF8NwsXOIXXaUg
         CH4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687847510; x=1690439510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2Si6Ds0vIKrIAT8qa+H99PovIF2KoNnQmkzHNG/XuQM=;
        b=SdOL1zk2eMP+26Q/2KEeQUJG6xEWF/PH9srGX1FZCmTXjz2IS8iuLrp3YX13yGmg5o
         FE8FpIT0gMClnP4y5/5HYrjTsJc3Yf8RKpji+b9atOk+mCcJ1O/sm0sxJc+vxdl7ixQ+
         Tqu2Ap2I/wvjKwZhyGUa0DuFW1Uer9vR69vCCwt0u23a7bmG6Abvl44Olq8Oi9rRHH3R
         tSnL3HFcyJPka4gLF5coNhtbq22Ty29FmeAio+XLUMGzZXOIQxop63fAKTrLRFsclQ1c
         yqnlW947XSdSUHEq+4T9oX/SldvWKwyVrgr9MwJjPcfJDiOO/9GhpIaCHz8y4BpxEDvy
         bmBQ==
X-Gm-Message-State: AC+VfDwv40Dmn3FpkzT6M2FMpfenv5m0TRV+IPVL8eRC1LhLzCyPk5kH
        IlcaQ32YJEw3Rh7vMoOYeWPn1w==
X-Google-Smtp-Source: ACHHUZ53P6WSxwvCC9/82qPryhwIdfcc93magNjJodg3igFyBNXpveK+rrY1ms23FTFs/2K5WkZXzg==
X-Received: by 2002:a5d:5307:0:b0:313:f60d:4958 with SMTP id e7-20020a5d5307000000b00313f60d4958mr2687932wrv.53.1687847510435;
        Mon, 26 Jun 2023 23:31:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id j9-20020a5d4649000000b0030aefa3a957sm9349967wrs.28.2023.06.26.23.31.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 23:31:49 -0700 (PDT)
Message-ID: <1ed60d4d-8e94-78b1-17ad-4305cadf867c@linaro.org>
Date:   Tue, 27 Jun 2023 08:31:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] ASoC: dt-bindings: nau8821: Convert to dtschema
Content-Language: en-US
To:     Seven Lee <wtli@nuvoton.com>, broonie@kernel.org
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, YHCHuang@nuvoton.com,
        KCHSU0@nuvoton.com, CTLIN0@nuvoton.com, SJLIN0@nuvoton.com,
        scott6986@gmail.com, supercraig0719@gmail.com, dardar923@gmail.com
References: <20230626104619.1112588-1-wtli@nuvoton.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230626104619.1112588-1-wtli@nuvoton.com>
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

On 26/06/2023 12:46, Seven Lee wrote:
> Convert the NAU8821 audio CODEC bindings to DT schema.
> 
> Signed-off-by: Seven Lee <wtli@nuvoton.com>
> ---

Thank you for your patch. There is something to discuss/improve.

> +
> +  nuvoton,jkdet-pull-up:
> +    description: Pull-up JKDET pin. If set then JKDET pin is pull up,
> +      otherwise pull down.
> +    type: boolean
> +
> +  nuvoton,jkdet-polarity:
> +    description: JKDET pin polarity.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # active high
> +      - 1 # active low
> +    default: 1
> +
> +  nuvoton,micbias-voltage:
> +    description: MICBIAS output level select.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # VDDA
> +      - 1 # VDDA * 1
> +      - 2 # VDDA * 1.1
> +      - 3 # VDDA * 1.2
> +      - 4 # VDDA * 1.3
> +      - 5 # VDDA * 1.4
> +      - 6 # VDDA * 1.53
> +      - 7 # VDDA * 1.53
> +    default: 6
> +
> +  nuvoton,vref-impedance:
> +    description: VMID Tie-off impedance select.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum:
> +      - 0 # open(default)

Drop "(default)"

> +      - 1 # 25KOhms
> +      - 2 # 125KOhms
> +      - 3 # 2.5KOhms
> +    default: 2

You wrote that default is 0

> +
> +  nuvoton,jack-insert-debounce:
> +    description: number from 0 to 7 that sets debounce time to 2^(n+2)ms.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +    default: 7
> +
> +  nuvoton,jack-eject-debounce:
> +    description: number from 0 to 7 that sets debounce time to 2^(n+2)ms.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    maximum: 7
> +    default: 0
> +
> +  nuvoton,dmic-clk-threshold:
> +    description: DMIC clock speed expected value. Unit is Hz.
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    default: 3072000
> +

You miss nuvoton,key_enable. If this is intentional, mention and shortly
explain deviations from pure conversion in the commit msg.

> +  '#sound-dai-cells':
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        codec@1b {
> +            #sound-dai-cells = <0>;
> +            compatible = "nuvoton,nau8821";
> +            reg = <0x1b>;

compatible is first property, reg is second. Therefore put
sound-dai-cells somewhere further.



Best regards,
Krzysztof

