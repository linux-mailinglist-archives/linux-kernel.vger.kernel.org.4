Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6A567AAF7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 08:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234930AbjAYHf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 02:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235066AbjAYHfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 02:35:52 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 739FC4997B
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:35:49 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso2178981wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 23:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JilbJ+cblhy+PqQNTAQwMy6f3HzCZej4Wl4GSB5gwcc=;
        b=VVmrmbCy6V9T0j/KC6r6+8tu6zyHlUJ9XOm+8gHqiWcd28d3q97+VzXJcsG1G0/Omu
         5TQXADLFI/q6u/wcESMo+NHO/NNOXOJZI26aEJDwmFTv2y51nRJ6MSDEYYLXO7J72vYu
         QCvaoUay96G1jiR3ZOcnU1V0+66QctlIpoxwDthS++OtyuOTp4KoMftigAheeHFw3Yum
         YPR08jCfVkDJGf4vauUs6xVNzWu/kJq0eKWxPy4aXljln3lxH/sUoRvW6YffSI8pOAjB
         nloE0gk+ODDO0LkHLjwiBgue3ZWoTqNBxlXRI6Q7ipv2Z4cJOjvTe7hSEWtXEm95wb2C
         8WDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JilbJ+cblhy+PqQNTAQwMy6f3HzCZej4Wl4GSB5gwcc=;
        b=EtC39yuCvaOapUUhjXoD7EFXd8nWZH3uhOUNJn7gn1kaUkkJx3phvKpYPo3JnASEur
         y4eHLKbrzwXdOYvk2cVm36NG8djcGm+ZHXB1LqoS3qHWrNjsHKxhLbQF+hJLud5+GPUl
         b3RS7NY8QZIGsVvxZMi7dQTfI39qb38PfxaET0Kxu3UJWsOOuLl9x7EBsi7WlCh7zC19
         aPd3GM22GDgqOc8e66N5lL+sKLtdXyuJwuN4Q3I/KWQodeVoALsq9kmHWXJQp6HVZsM6
         Hpt10yGxkcQaUt4qRrs7TRjUEJVkZvMJ7YGB9oh/IfJuX1wQQYpRfu51XBGdZVEqZmnJ
         5spw==
X-Gm-Message-State: AFqh2krwoM8pRZlNLYbHZv4DkLuPLf4ZIJr0636N3J6ZVf1hibv0mcx7
        zu6aSMJv8I/RMITxp963cSbOvw==
X-Google-Smtp-Source: AMrXdXvwcRoKfOpVUsX76d9kLJ2jphtZE/GVoBczc3bhEDJX5/yaBT4a/4HtazmNo6bGDPmIcxvSdg==
X-Received: by 2002:a05:600c:4687:b0:3db:2e06:4091 with SMTP id p7-20020a05600c468700b003db2e064091mr20541619wmo.37.1674632147867;
        Tue, 24 Jan 2023 23:35:47 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id r1-20020a05600c424100b003d9a86a13bfsm971111wmm.28.2023.01.24.23.35.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 23:35:47 -0800 (PST)
Message-ID: <abedd2e8-3c7e-f347-06af-99f2e5a2412b@linaro.org>
Date:   Wed, 25 Jan 2023 08:35:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 02/14] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     tomer.yacoby@broadcom.com, kursad.oney@broadcom.com,
        dregan@mail.com, f.fainelli@gmail.com, anand.gore@broadcom.com,
        jonas.gorski@gmail.com, dan.beygelman@broadcom.com,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230124221218.341511-1-william.zhang@broadcom.com>
 <20230124221218.341511-3-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230124221218.341511-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2023 23:12, William Zhang wrote:
> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
> controller. Add new compatible strings to differentiate the old and new
> controller while keeping MIPS based chip with the old compatible. Update
> property requirements for these two revisions of the controller.  Also
> add myself and Kursad as the maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> ---
> 
> Changes in v2:
> - Update new compatible string to follow Broadcom convention <chip
> specific compatible>, <version of the IP>, <fallback>
> - Add reg-names min/maxItem constraints to be consistent with reg
> property
> - Make interrupts required property
> - Remove double quote from spi-controller.yaml reference
> - Remove brcm,use-cs-workaround flag
> - Update the example with new compatile and interrupts property
> - Update commit message
> 
>  .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 106 +++++++++++++++++-
>  1 file changed, 101 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> index d1a0c9adee7a..d39604654c9e 100644
> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> @@ -4,20 +4,73 @@
>  $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Broadcom BCM6328 High Speed SPI controller
> +title: Broadcom Broadband SoC High Speed SPI controller
>  
>  maintainers:
> +

This is a friendly reminder during the review process.

It seems my previous comments were not fully addressed. Maybe my
feedback got lost between the quotes, maybe you just forgot to apply it.
Please go back to the previous discussion and either implement all
requested changes or keep discussing them.

Thank you.

> +  - William Zhang <william.zhang@broadcom.com>
> +  - Kursad Oney <kursad.oney@broadcom.com>
>    - Jonas Gorski <jonas.gorski@gmail.com>
>  
> -allOf:
> -  - $ref: spi-controller.yaml#

In your previous patch, put it already in desired place (after
"required:"), so you will not have to shuffle it.

> +description: |
> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
> +  early MIPS based chips such as BCM6328 and BCM63268.  This initial rev 1.0
> +  controller was carried over to recent ARM based chips, such as BCM63138,
> +  BCM4908 and BCM6858. The old MIPS based chip should continue to use the
> +  brcm,bcm6328-hsspi compatible string. The recent ARM based chip is required to
> +  use the brcm,bcmbca-hsspi-v1.0 as part of its compatible string list as
> +  defined below to match the specific chip along with ip revision info.
> +
> +  This rev 1.0 controller has a limitation that can not keep the chip select line
> +  active between the SPI transfers within the same SPI message. This can
> +  terminate the transaction to some SPI devices prematurely. The issue can be
> +  worked around by either the controller's prepend mode or using the dummy chip
> +  select workaround. Driver automatically picks the suitable mode based on
> +  transfer type so it is transparent to the user.
> +
> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
> +  controller rev 1.1 that add the capability to allow the driver to control chip
> +  select explicitly. This solves the issue in the old controller.
>  
>  properties:
>    compatible:
> -    const: brcm,bcm6328-hsspi
> +    oneOf:
> +      - const: brcm,bcm6328-hsspi
> +      - items:
> +          - enum:
> +              - brcm,bcm47622-hsspi
> +              - brcm,bcm4908-hsspi
> +              - brcm,bcm63138-hsspi
> +              - brcm,bcm63146-hsspi
> +              - brcm,bcm63148-hsspi
> +              - brcm,bcm63158-hsspi
> +              - brcm,bcm63178-hsspi
> +              - brcm,bcm6846-hsspi
> +              - brcm,bcm6856-hsspi
> +              - brcm,bcm6858-hsspi
> +              - brcm,bcm6878-hsspi
> +          - const: brcm,bcmbca-hsspi-v1.0
> +          - const: brcm,bcmbca-hsspi

Why do you need "brcm,bcmbca-hsspi"? Nothing binds to it, so it's
useless and very generic.

> +      - items:
> +          - enum:
> +              - brcm,bcm4912-hsspi
> +              - brcm,bcm6756-hsspi
> +              - brcm,bcm6813-hsspi
> +              - brcm,bcm6855-hsspi
> +          - const: brcm,bcmbca-hsspi-v1.1
> +          - const: brcm,bcmbca-hsspi

Same here.

>  
>    reg:
> -    maxItems: 1
> +    items:
> +      - description: main registers
> +      - description: miscellaneous control registers
> +    minItems: 1
> +
> +  reg-names:
> +    items:
> +      - const: hsspi
> +      - const: spim-ctrl
> +    minItems: 1
>  
>    clocks:
>      items:
> @@ -39,10 +92,39 @@ required:
>    - clock-names
>    - interrupts
>  
> +allOf:
> +  - $ref: spi-controller.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm6328-hsspi
> +              - brcm,bcmbca-hsspi-v1.0
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1

drop minItems

> +          maxItems: 1
> +        reg-names:
> +          minItems: 1

drop minItems

> +          maxItems: 1
> +    else:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +        reg-names:
> +          minItems: 2
> +          maxItems: 2
> +      required:
> +        - reg-names
> +
>  unevaluatedProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>      spi@10001000 {
>          compatible = "brcm,bcm6328-hsspi";
>          reg = <0x10001000 0x600>;
> @@ -53,3 +135,17 @@ examples:
>          #address-cells = <1>;
>          #size-cells = <0>;
>      };
> +  - |
> +    spi@ff801000 {
> +        compatible = "brcm,bcm6756-hsspi", "brcm,bcmbca-hsspi-v1.1",
> +                     "brcm,bcmbca-hsspi";
> +        reg = <0xff801000 0x1000>,
> +              <0xff802610 0x4>;
> +        reg-names = "hsspi", "spim-ctrl";
> +        interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>;
> +        clocks = <&hsspi>, <&hsspi_pll>;
> +        clock-names = "hsspi", "pll";
> +        num-cs = <8>;
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +    };

Drop new example - the difference is only in reg. Or change old example
to have only one (newer, more complex).

Best regards,
Krzysztof

