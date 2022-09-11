Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BACC5B4EEF
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 15:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiIKNCr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 09:02:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIKNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 09:02:44 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC93912762;
        Sun, 11 Sep 2022 06:02:43 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id t5so9096902edc.11;
        Sun, 11 Sep 2022 06:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zdb0MTNtGm0xZLh9SbokItH96dd8V5P8fT9Gy26cDD4=;
        b=TRA7JnnAMAV8SYpd8F2DSJun/AAvcKcE8U4qmSZnO+rWkIzjxkNkAIe5JCxJqp14m0
         yjcTh932NJF/n2qhK7/qqoqgf1x9ygoVltZT5V8maPG4P5CeAsM6V3OmC3Mfmppu91po
         5V0ZVTbB+QEUH1bMc2IkedzM/NfmF8ogZ9nGvx8GM3syoSx8uSRwgGBK/hW89ADut+zC
         inyX6mg+emngx3gL2mh+YfOuQWdK7+VxMpjMPe+1S5Ff/VnqJtPA51YIxz1g3K6XBgiN
         JYqsiNcl7FjCk+ogFy78KSFRvTAbdxp8j3nH3JIIn3mK1yV1I7qMoRjFE+sM9IY+wfwC
         oqnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zdb0MTNtGm0xZLh9SbokItH96dd8V5P8fT9Gy26cDD4=;
        b=RK+eToLJZRO79rMDUNnD8BG5wv8JemytB29uYMWNJ3HPegA2PH+H1NoG/oiMTWuT0y
         4K4IFT24uuZKiATDn+VnC+lQdhSJR1aVMBUiktB1/2Aaf6LO9/cKH+nZbaRwhcqXQeZl
         sZpNrOCtEI2DhXjdedKohatod/EGutWVRDHRhvGDFybhoMhBvUcl+gXAkDJCw+o8mPi4
         7ZfhasHVhjJXKc5bqCG0H5GUMc1J9NFSxMVE80g0rHbz8Gk8PQdth9hXtuJWl8t/tgZK
         ViiyUd1d+fAKHSRP0WLAfbxurqTquXDe9qGNJTQIz7g7YGFaFR0NMkKJ0ox5fx8oZ3tR
         m9Pw==
X-Gm-Message-State: ACgBeo10/6Eo8ZTiNCXkjj6X164GTd/E9RrioX5Lo6k9xc6BbIhXWLeW
        W9/Vd6vDhmYfxJr/ZXErZUE=
X-Google-Smtp-Source: AA6agR5wE4j7JrkugE0OyutnLPGcBty73YKXYYl9Iugn1cuPh9pwXkLuvHTQlSGRrRjSmI3oEAHmog==
X-Received: by 2002:a05:6402:5179:b0:44e:d177:3a21 with SMTP id d25-20020a056402517900b0044ed1773a21mr19217875ede.20.1662901362343;
        Sun, 11 Sep 2022 06:02:42 -0700 (PDT)
Received: from [192.168.74.101] ([77.78.20.135])
        by smtp.gmail.com with ESMTPSA id j1-20020a170906094100b0076f1d939128sm487706ejd.54.2022.09.11.06.02.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 06:02:41 -0700 (PDT)
Message-ID: <e6f7a913-f434-9ea4-30f5-56b6990cc8bf@gmail.com>
Date:   Sun, 11 Sep 2022 16:02:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 03/40] dt-bindings: pinctrl: qcom,sm6115-pinctrl: fix
 indentation in example
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Martin Botka <martin.botka@somainline.org>,
        Vinod Koul <vkoul@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220911111200.199182-1-krzysztof.kozlowski@linaro.org>
 <20220911111200.199182-4-krzysztof.kozlowski@linaro.org>
From:   Iskren Chernev <iskren.chernev@gmail.com>
In-Reply-To: <20220911111200.199182-4-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/22 14:11, Krzysztof Kozlowski wrote:
> Bindings example should be indented with 4-spaces.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Iskren Chernev <iskren.chernev@gmail.com>

> ---
>  .../bindings/pinctrl/qcom,sm6115-pinctrl.yaml | 80 +++++++++----------
>  1 file changed, 40 insertions(+), 40 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> index 28b29bf714b4..e39fbb36d8c1 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sm6115-pinctrl.yaml
> @@ -150,44 +150,44 @@ additionalProperties: false
>
>  examples:
>    - |
> -        #include <dt-bindings/interrupt-controller/arm-gic.h>
> -        tlmm: pinctrl@500000 {
> -                compatible = "qcom,sm6115-tlmm";
> -                reg = <0x500000 0x400000>,
> -                        <0x900000 0x400000>,
> -                        <0xd00000 0x400000>;
> -                reg-names = "west", "south", "east";
> -                interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> -                gpio-controller;
> -                #gpio-cells = <2>;
> -                interrupt-controller;
> -                #interrupt-cells = <2>;
> -                gpio-ranges = <&tlmm 0 0 114>;
> -
> -                sdc2_on_state: sdc2-on-state {
> -                        clk-pins {
> -                                pins = "sdc2_clk";
> -                                bias-disable;
> -                                drive-strength = <16>;
> -                        };
> -
> -                        cmd-pins {
> -                                pins = "sdc2_cmd";
> -                                bias-pull-up;
> -                                drive-strength = <10>;
> -                        };
> -
> -                        data-pins {
> -                                pins = "sdc2_data";
> -                                bias-pull-up;
> -                                drive-strength = <10>;
> -                        };
> -
> -                        sd-cd-pins {
> -                                pins = "gpio88";
> -                                function = "gpio";
> -                                bias-pull-up;
> -                                drive-strength = <2>;
> -                        };
> -                };
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    tlmm: pinctrl@500000 {
> +        compatible = "qcom,sm6115-tlmm";
> +        reg = <0x500000 0x400000>,
> +              <0x900000 0x400000>,
> +              <0xd00000 0x400000>;
> +        reg-names = "west", "south", "east";
> +        interrupts = <GIC_SPI 227 IRQ_TYPE_LEVEL_HIGH>;
> +        gpio-controller;
> +        #gpio-cells = <2>;
> +        interrupt-controller;
> +        #interrupt-cells = <2>;
> +        gpio-ranges = <&tlmm 0 0 114>;
> +
> +        sdc2_on_state: sdc2-on-state {
> +            clk-pins {
> +                pins = "sdc2_clk";
> +                bias-disable;
> +                drive-strength = <16>;
> +            };
> +
> +            cmd-pins {
> +                pins = "sdc2_cmd";
> +                bias-pull-up;
> +                drive-strength = <10>;
> +            };
> +
> +            data-pins {
> +                pins = "sdc2_data";
> +                bias-pull-up;
> +                drive-strength = <10>;
> +            };
> +
> +            sd-cd-pins {
> +                pins = "gpio88";
> +                function = "gpio";
> +                bias-pull-up;
> +                drive-strength = <2>;
> +            };
>          };
> +    };
