Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794586AB894
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 09:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbjCFIl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 03:41:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjCFIlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 03:41:55 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3D5F21290
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 00:41:53 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id i34so35172773eda.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678092112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vC2UMy/rdFsJj0D2BlHZptJUd1EfeaZsqvifezHhP80=;
        b=GlyLxJXQRtZVPo3XhuyN75NML1JaCyxuD2Mi4XOKvRip5DG/fEuki7mxlqpd9cpR1f
         rUtTWXVvab9MczuD0fo5h8EWCHN/gcPmnwsjc10LUtFbCSXv2fJgyKn45jCvrxzOkPYf
         E8hnWuwayUZcydUaXpXx16PT5hWrEjr3h6cyACAteAvczjOHzU4rv8MBYOuwBwAyCP8K
         N33X1gkbC+DYrhrqgKV89tOPjv0/Ec9q6neM/BDELQNNCq8iX6VK+BxcA2wfirzuLX+G
         4w3VUj+sLeR8jyCHqgWv6xzEYjO+8ZRoNfsrOrnS3MAxacWSZDVNm6vqVP02FwmxyFaB
         etuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678092112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vC2UMy/rdFsJj0D2BlHZptJUd1EfeaZsqvifezHhP80=;
        b=3heQF7asx8ajN/5gLBwLIGo1XuE242TwoxiXx8J0bjgSvp9UMZJtKpb4NXybVXzTgJ
         G6py4ttm0cNTd8XFHuCdK0OksMoxgKtF6c00pDR5MkSpSd16JQS2h2kro9UkgWnpsVTQ
         Fuk9z2vUKjtIAxMr1yyZoagfPt1JOd3aibEhSpnLBwRfUXOlCCaibad0blWNkjutfMdX
         M9UsKcO/HUINseL0cVhtemEkWO4TA8gPrUD8IXTbid9fNz8KUR8yuB2AURTQRuuXJAYm
         mHGGLx+PRdXKVwJsXvRShnX9Z6kqT59CElTd870/77d1vY+xoaaicDnZPcsRCiE+q91k
         VYkQ==
X-Gm-Message-State: AO0yUKVhJJt9mGdEcbVOyjUnHW65mOBv7Pnv1z86jY/KTwePTQKyRwSs
        VwhLFJuL1gfvOiwrrTo/egJ71g==
X-Google-Smtp-Source: AK7set/LZG0DGhn2WM9G7iZfaL/U03tBL9IUollWkti6wvZuDTVbK9E23k3Dq9iI1GyC/hL+s7VoOg==
X-Received: by 2002:a17:906:b14f:b0:8b1:7de9:b38c with SMTP id bt15-20020a170906b14f00b008b17de9b38cmr9381185ejb.52.1678092112251;
        Mon, 06 Mar 2023 00:41:52 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:d85d:5a4b:9830:fcfe? ([2a02:810d:15c0:828:d85d:5a4b:9830:fcfe])
        by smtp.gmail.com with ESMTPSA id c15-20020a170906170f00b008c6c47f59c1sm4208292eje.48.2023.03.06.00.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 00:41:51 -0800 (PST)
Message-ID: <95d5b97c-ccdc-cede-a6d7-8cc64086d62d@linaro.org>
Date:   Mon, 6 Mar 2023 09:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 1/2] dt-bindings: gpio: add fcs,fxl6408-gpio binding
 document
Content-Language: en-US
To:     Francesco Dolcini <francesco@dolcini.it>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
Cc:     Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org
References: <20230306083446.41082-1-francesco@dolcini.it>
 <20230306083446.41082-2-francesco@dolcini.it>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230306083446.41082-2-francesco@dolcini.it>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/03/2023 09:34, Francesco Dolcini wrote:
> From: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> 
> Add binding document for Fairchild FXL6408 GPIO expander.

Subject: drop second/last, redundant "binding document". The
"dt-bindings" prefix is already stating that these are bindings.

> 
> Signed-off-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

Missing SoB.

> ---
>  .../bindings/gpio/fcs,fxl6408-gpio.yaml       | 73 +++++++++++++++++++
>  1 file changed, 73 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> new file mode 100644
> index 000000000000..ccf946040d00
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/gpio/fcs,fxl6408-gpio.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/gpio/fcs,fxl6408-gpio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: FXL6408 GPIO driver

If "driver" means Linux driver, then drop.

Fairchild FXL6408 GPIO Expander

> +
> +maintainers:
> +  - Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
> +
> +description: |
> +  Driver for Fairchild FXL6408 GPIO expander

This is not a driver. Drop entire description as it is duplicating title
or add here something useful.


> +
> +properties:
> +  compatible:
> +    enum:
> +      - fcs,fxl6408
> +
> +  reg:
> +    maxItems: 1
> +
> +  "#gpio-cells":
> +    const: 2
> +
> +  gpio-controller: true
> +
> +  gpio-line-names:
> +    minItems: 1
> +    maxItems: 8
> +
> +patternProperties:
> +  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":

From here....

> +    type: object
> +    properties:
> +      gpio-hog: true
> +      gpios: true
> +      input: true
> +      output-high: true
> +      output-low: true
> +      line-name: true
> +
> +    required:
> +      - gpio-hog
> +      - gpios
> +
> +    additionalProperties: false

To here, all this can be simpler:

  "^(hog-[0-9]+|.+-hog(-[0-9]+)?)$":
    required:
      - gpio-hog

which selects gpio hog schema.

> +
> +required:
> +  - compatible
> +  - reg
> +  - gpio-controller
> +  - "#gpio-cells"
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        gpio_expander_43: gpio-expander@43 {
> +            compatible = "fcs,fxl6408";
> +            gpio-controller;
> +            #gpio-cells = <2>;
> +            reg = <0x43>;
> +            gpio-line-names = "Wi-Fi_W_DISABLE", "Wi-Fi_WKUP_WLAN",
> +              "PWR_EN_+V3.3_WiFi_N", "PCIe_REF_CLK_EN",

Align with previous line/entries.

> +              "USB_RESET_N", "USB_BYPASS_N", "Wi-Fi_PDn",
> +              "Wi-Fi_WKUP_BT";
> +        };
> +    };

Best regards,
Krzysztof

