Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C96615E8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 15:51:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233196AbjAHOvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 09:51:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbjAHOvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 09:51:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42B5B2717
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 06:51:47 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j16-20020a05600c1c1000b003d9ef8c274bso307986wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Jan 2023 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IkIBDVTRvMke9qsSJ1CLH9k2Xrh9aWdh554iPOcNh7Y=;
        b=q2nrBow8scyz8Yj5rHu1QVjHBsvtu/iHoBmgLE6yFdBxeoqA/Mcn0jfdEaN2m/CJRy
         DTmdV8UR7SunZNqm6/mDtwSxCFGup57Uco2jO7kXiJYT8tKhvOoLhEzyAurfo1gtiaal
         yQKSbNPwQFDseSDFq8UI75g4hcDGsVQdzUXJZwtgIHrDiWAQSBXEUuv70UIcxPc6LfeT
         FmIIAYOaNXgr6LViFMzVNxiIJbcclPSaYuE8whf+m1N3awCtpLDWhL8PalaeSO1T9lFa
         vW9ezrQJUh/ZORIeJoRnEX/82VPJ4Aouy++Wm7GekfKPkcU7R06WWcP3pp5L5i9RX0rk
         /KwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IkIBDVTRvMke9qsSJ1CLH9k2Xrh9aWdh554iPOcNh7Y=;
        b=RvUQiOZnhQo9FRQu5lAFrPm85l/68ZAgrKyPXIBvqtrIqaNppU2j6ZoOU3c4Xt7nrb
         lJQSWk0XGKCu3g70uBifkehmiFXfhFbfDt8g/ET1Fbsh6Fmin8Abjws4/TkhwI54F2YP
         3u/xH/vI0wbPTmsLOVYdLBOQ4TS46k/g6aceDtQpAp6ly2Hb7c28zpS7MtfLWDtakkcv
         lLcWoZwFg1edZhaP3V6ktNSgk/dPnEYxlDRGqSQy42zzMynkVZ2Tk8dd0NGFIOYdiURG
         IRDo3dYZhauf7gVdo4Ui1wrk2gqlExf8Wg1/s0PQepiVzoVlZGNFkoe3Ji0JPjKEgunD
         Kd+w==
X-Gm-Message-State: AFqh2kp8EPrUwQgzOg+dV9pX293Z2Vjvkc0eh+/bGvi5Zr1XZT85M1pp
        jjnpvFA3FOlUNKbwsVGxEUoFe23UbAzguA0E
X-Google-Smtp-Source: AMrXdXvxmDvbSvmzG54h4nrZxiwKyDsvND2S0V1/kw7DThoAH36DvrrhXBLjF6J3ypixiEV838eogQ==
X-Received: by 2002:a05:600c:4995:b0:3d3:4f43:fbc2 with SMTP id h21-20020a05600c499500b003d34f43fbc2mr44392373wmp.41.1673189505732;
        Sun, 08 Jan 2023 06:51:45 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id bp28-20020a5d5a9c000000b00273cd321a1bsm6306116wrb.107.2023.01.08.06.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 06:51:45 -0800 (PST)
Message-ID: <b529a53b-d00c-063d-a58d-e64b0300605d@linaro.org>
Date:   Sun, 8 Jan 2023 15:51:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 02/16] dt-bindings: spi: Add bcmbca-hsspi controller
 support
Content-Language: en-US
To:     William Zhang <william.zhang@broadcom.com>,
        Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106200809.330769-1-william.zhang@broadcom.com>
 <20230106200809.330769-3-william.zhang@broadcom.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230106200809.330769-3-william.zhang@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/01/2023 21:07, William Zhang wrote:
> The new Broadcom Broadband BCMBCA SoCs includes a updated HSSPI
> controller. Add a new compatible string and required fields for the new
> driver.  Also add myself and Kursad as the maintainers.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---
> 
>  .../bindings/spi/brcm,bcm63xx-hsspi.yaml      | 84 +++++++++++++++++--
>  1 file changed, 78 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> index 45f1417b1213..56e69d4a1faf 100644
> --- a/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> +++ b/Documentation/devicetree/bindings/spi/brcm,bcm63xx-hsspi.yaml
> @@ -4,22 +4,51 @@
>  $id: http://devicetree.org/schemas/spi/brcm,bcm63xx-hsspi.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
> -title: Broadcom BCM6328 High Speed SPI controller
> +title: Broadcom Broadband SoC High Speed SPI controller
>  
>  maintainers:
> +

Drop blank line.

> +  - William Zhang <william.zhang@broadcom.com>
> +  - Kursad Oney <kursad.oney@broadcom.com>
>    - Jonas Gorski <jonas.gorski@gmail.com>

>  
> +description: |
> +  Broadcom Broadband SoC supports High Speed SPI master controller since the
> +  early MIPS based chips such as BCM6328 and BCM63268.  This controller was
> +  carried over to recent ARM based chips, such as BCM63138, BCM4908 and BCM6858.
> +
> +  It has a limitation that can not keep the chip select line active between
> +  the SPI transfers within the same SPI message. This can terminate the
> +  transaction to some SPI devices prematurely. The issue can be worked around by
> +  either the controller's prepend mode or using the dummy chip select
> +  workaround. This controller uses the compatible string brcm,bcm6328-hsspi.
> +
> +  The newer SoCs such as BCM6756, BCM4912 and BCM6855 include an updated SPI
> +  controller that add the capability to allow the driver to control chip select
> +  explicitly. This solves the issue in the old controller. This new controller
> +  uses the compatible string brcm,bcmbca-hsspi.
> +
>  properties:
>    compatible:
> -    const: brcm,bcm6328-hsspi
> +    enum:
> +      - brcm,bcm6328-hsspi
> +      - brcm,bcmbca-hsspi

bca seems quite unspecific. Your description above mentions several
model numbers and "bca" is not listed as model. Compatibles cannot be
generic.

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

This does not match reg

>  
>    clocks:
>      items:
> -      - description: spi master reference clock
> -      - description: spi master pll clock
> +      - description: SPI master reference clock
> +      - description: SPI master pll clock

Really? You just added it in previous patch, didn't you?

>  
>    clock-names:
>      items:
> @@ -29,12 +58,43 @@ properties:
>    interrupts:
>      maxItems: 1
>  
> +  brcm,use-cs-workaround:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Enable dummy chip select workaround for SPI transfers that can not be
> +      supported by the default controller's prepend mode, i.e. delay or cs
> +      change needed between SPI transfers.

You need to describe what is the workaround.

> +
>  required:
>    - compatible
>    - reg
>    - clocks
>    - clock-names
> -  - interrupts
> +
> +allOf:
> +  - $ref: "spi-controller.yaml#"

No quotes. How this is related to this patch?

> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - brcm,bcm6328-hsspi
> +    then:
> +      properties:
> +        reg:
> +          minItems: 1

Drop.

reg-names now do not match.

> +          maxItems: 1
> +    else:
> +      properties:
> +        reg:
> +          minItems: 2
> +          maxItems: 2
> +        reg-names:
> +          minItems: 2
> +          maxItems: 2
> +        brcm,use-cs-workaround: false
> +      required:
> +        - reg-names
Best regards,
Krzysztof

