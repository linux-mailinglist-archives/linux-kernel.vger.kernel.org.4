Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9F60D144
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 18:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232730AbiJYQGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 12:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232161AbiJYQG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 12:06:29 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11895182C5E
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:06:29 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id bb5so7807104qtb.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 09:06:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdYRsJGfP0o692+sENJJoDb7VImvlyzZSXWPyoNbrBE=;
        b=E5dsJHEWS0QV/kLIRQIT/MTMWU34Rbba8D+H3idaiQhx1qjgKSP2GsQOVpgp3Xq6A9
         2Qzzf5/vgfDEfv3LSDtU5B/hCM4p0ge2B3h1C3GeQZEhywLr78cgiPIIgQY4xPfTbWOH
         ceSuvKVUxtN4EbfQQiXk6npaq61LIVNwO6V9+IlUC4IooD7Z3/Goe7Y/7tTtMUd4z1FH
         QkV6xRLU3ChNnye5LzU14ot5Kf3cqzEus8ux+oTFDFesZIdX8QrfZD6Yxf8AsR++rtuL
         Nb120S4I2OdJeEYa1suup6xMua9BsUx0lOG1T1+2r5QFpmjf57O7hBfQf2i0Ok5t07CM
         V4rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdYRsJGfP0o692+sENJJoDb7VImvlyzZSXWPyoNbrBE=;
        b=zKPr5hdyepFTRaTfpG0UN7AOSEHM4vzQI9bzkY7j7YqVVeyplG8e4/CJ3oI5liLQyt
         KDLAoRzBEoD2HvJ1BEhztoT3wNKT+Z8RUuedNILQc50nFk4BTzT3m/m+iZtKLmgeNLix
         vPa+kmAtLQuCZOwHn21JwtRaXlHEMLorTji5p6ct2GrbNm6PtEPB4dhJ6q7oPyHa08nv
         cw5Z//IGjsb5jfBNu9qxS/AgZt+s1cNQwaz9zr+xHD/8e/Sd18gzUEwXq/k2uEYy6bFH
         4KCcPKWjYfeKWecRptah/TZADRM5x9zvZYKn5dS65az2C88TshBmyqyZWuLyuC4R9Ckm
         DyTw==
X-Gm-Message-State: ACrzQf1jFxRa7EcSqx4fRSkiO0CJ6B5Rvn+mITSYNT8CD8JWoksqQMR5
        jJPdWugXpk7psThozpoeIivzqw==
X-Google-Smtp-Source: AMsMyM6ZGC4n3kePbJpSDHf8KfIYUGV5TulBZH5aW+O9SAvn5G03fp+CFlFKq01U8uo63pNSOGO3cA==
X-Received: by 2002:ac8:5e13:0:b0:39d:c27b:b6a7 with SMTP id h19-20020ac85e13000000b0039dc27bb6a7mr19234333qtx.183.1666713988186;
        Tue, 25 Oct 2022 09:06:28 -0700 (PDT)
Received: from [192.168.1.11] ([64.57.193.93])
        by smtp.gmail.com with ESMTPSA id f12-20020a05620a280c00b006ec51f95e97sm2260454qkp.67.2022.10.25.09.06.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Oct 2022 09:06:27 -0700 (PDT)
Message-ID: <18e982cd-6dd9-71e9-331d-6f4078235c8f@linaro.org>
Date:   Tue, 25 Oct 2022 12:06:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v3 2/2] dt-bindings: pinctrl: add loongson2 pinctrl
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221024014209.5327-1-zhuyinbo@loongson.cn>
 <20221024014209.5327-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221024014209.5327-2-zhuyinbo@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/10/2022 21:42, Yinbo Zhu wrote:
> Add the loongson2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
> Change in v3:
> 		1. Drop the quotes in "pinctrl.yaml#".
> 		2. Remove the items in function node.
> 		3. Add requird node for "group" and "function" in properties.
> 
>  .../pinctrl/loongson,ls2k-pinctrl.yaml        | 129 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 130 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> new file mode 100644
> index 000000000000..6284359986de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> @@ -0,0 +1,129 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/loongson,ls2k-pinctrl.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Loongson2 SoC Pinctrl Controller
> +
> +maintainers:
> +  - zhanghongchen <zhanghongchen@loongson.cn>
> +  - Yinbo Zhu <zhuyinbo@loongson.cn>
> +
> +allOf:
> +  - $ref: pinctrl.yaml#
> +
> +properties:
> +  compatible:
> +    const: loongson,ls2k-pinctrl
> +
> +  reg:
> +    maxItems: 1
> +
> +patternProperties:
> +  '-pins$':
> +    type: object
> +
> +    additionalProperties: false
> +
> +    patternProperties:
> +      'pinmux$':
> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#
> +
> +        unevaluatedProperties: false
> +
> +        properties:
> +          groups:
> +            description:
> +              One or more groups of pins to mux to a certain function
> +            items:
> +              enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                     nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
> +                     dvo0]
> +          function:
> +            description:
> +              The function that a group of pins is muxed to
> +            enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                   nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
> +                   dvo0]
> +
> +        dependencies:
> +          groups: [function]
> +          function: [groups]

Since you added them as required, drop dependencies.
> +
> +        required:
> +          - groups
> +          - function
> +
> +required:
> +  - compatible
> +  - reg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pctrl: pinctrl@1fe00420 {
> +        compatible = "loongson,ls2k-pinctrl";
> +        reg = <0x1fe00420 0x18>;
> +        sdio_pins_default: sdio-pins {
> +            sdio-pinmux {
> +                groups ="sdio";
> +                function ="sdio";

Missing spaces after '='. Applies in other places as well.


Best regards,
Krzysztof

