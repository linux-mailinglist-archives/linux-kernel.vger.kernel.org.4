Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9EF1606D31
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 03:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJUBtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 21:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiJUBth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 21:49:37 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77365286C0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:49:34 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c23so809490qtw.8
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 18:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bhTPHw6m01ivIl5RP7SgmYgR4aeFNKpBx1oq6+x6jqI=;
        b=PH94WdZcySmAk0x5o+sfHL31KorX2Vj6nQa1iUqG29/oqIAPsPF5ozDI40W+ta1R7O
         iW4Cyrx3Sk04pTC13fql/o2ZFSBLuWhzyrHNtSeP01XRIQnp4mRHeuplNtJ/5LS1ShW/
         LxA8obB+aGdM7niZe48QRKmAtqOrki24GmUessv9Cr+O3zXqfqBpnOgqthKHH4U18R+B
         HsoDqg20r5ooFHn/xsKF5IxngjuALUpsKKO9SmTwe3I97gsVLO7ROJP9SjhIC96yCTwX
         hKVf6hB8syJsM33hZ+HkS0dDOWE7OCxZMClPWdP9E9ogGG5k3wI9BES2R35Nt4walgG1
         LH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bhTPHw6m01ivIl5RP7SgmYgR4aeFNKpBx1oq6+x6jqI=;
        b=dUzqU93sYtemIcrnPZMeK60x7CW7oRo/NbL46gN2y+eKnVZ4iEvzRhz8B61qJjkw7q
         yr6nKoLyXCc/D4msThgC1zvZbUyc7ZrTNB9WXEQt50EBJ3OzmWRK1QkNsqrP6DA6p5rM
         +hpxS3W5d6DNco03DM6kfg2paBbKh3qx0xGGwPW4ZF4gKsmJnq5RXdw91mOzAXEBH63N
         CB6/Xsbo4KyDhrU1qQT6dZqyOAOXaf2m8iGp3Evo5M/VbmJHpQtOK0coqpgzUDcSuUtG
         vUmzzRa5t9tVQV2p6/8uHR5mE2dawElH1KUpAf3zFwFzZ+BCVK2Anb196KqbW+Z11Ryg
         nhYA==
X-Gm-Message-State: ACrzQf00YcWWLPE6f+1FZT76+g/QeY+AGOuLfKsddHGovo7VRmfdpXtL
        jQSj+Q6GqIK7qWrPWeRhYCDSjA==
X-Google-Smtp-Source: AMsMyM6iSKSGcrQTOth/ykMt2G2vxCwAkUH2+KwmrRBiaoyOTlc7iMdLDEhnuBe6EdCCRW/Pxc0Gsw==
X-Received: by 2002:a05:622a:11cc:b0:39c:d274:6a25 with SMTP id n12-20020a05622a11cc00b0039cd2746a25mr13775368qtk.686.1666316973580;
        Thu, 20 Oct 2022 18:49:33 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id m15-20020a05620a13af00b006ee949b8051sm8450377qki.51.2022.10.20.18.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Oct 2022 18:49:32 -0700 (PDT)
Message-ID: <86b4da48-bc69-65cb-1e1d-4b9efaadf732@linaro.org>
Date:   Thu, 20 Oct 2022 21:49:31 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v1 2/2] dt-bindings: pinctrl: add loongson2 pinctrl
Content-Language: en-US
To:     Yinbo Zhu <zhuyinbo@loongson.cn>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        zhanghongchen <zhanghongchen@loongson.cn>
References: <20221021012728.22373-1-zhuyinbo@loongson.cn>
 <20221021012728.22373-2-zhuyinbo@loongson.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221021012728.22373-2-zhuyinbo@loongson.cn>
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

On 20/10/2022 21:27, Yinbo Zhu wrote:
> Add the loongson2 pinctrl binding with DT schema format using
> json-schema.
> 
> Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
> ---
>  .../pinctrl/loongson,ls2k-pinctrl.yaml        | 118 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 119 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> new file mode 100644
> index 000000000000..038d38ad1785
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/loongson,ls2k-pinctrl.yaml
> @@ -0,0 +1,118 @@
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

Missing $ref to pinctrl.yaml

> +properties:
> +  compatible:
> +    const: loongson,ls2k-pinctrl
> +
> +  reg:
> +    maxItems: 1

> +
> +required:
> +  - compatible
> +  - reg

Put required after patternProperties.

> +
> +patternProperties:
> +  '-pins$':
> +    type: object

    additionalProperties: false

and blank line

> +    patternProperties:
> +      'pinmux$':
> +        type: object
> +        description: node for pinctrl.
> +        $ref: pinmux-node.yaml#

        unevaluatedProperties: false

But actually you have here totally broken indentation and this simply
does not work. I doubt you really tested it.

> +
> +    properties:
> +      groups:
> +        description:
> +          One or more groups of pins to mux to a certain function
> +        items:
> +          enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                 nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
> +                 dvo0]
> +      function:
> +        description:
> +          The function that a group of pins is muxed to
> +        items:
> +          enum: [gpio, sdio, can1, can0, pwm3, pwm2, pwm1, pwm0, i2c1, i2c0,
> +                 nand, sata_led, lio, i2s, hda, uart2, uart1, camera, dv01,
> +                 dvo0]
> +
> +    dependencies:
> +      groups: [function]
> +      function: [groups]
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    pctrl: pinctrl@1fe00420 {
> +           compatible = "loongson,ls2k-pinctrl";
> +           reg = <0x1fe00420 0x18>;

Use 4 spaces for example indentation.

> +           sdio_pins_default: sdio-pins {
> +                sdio-pinmux {
> +                        groups ="sdio";
> +                        function ="sdio";
> +                };
> +
> +                sdio-det-pinmux {
> +                        groups ="pwm2";
> +                        function ="gpio";
> +                };


Best regards,
Krzysztof

