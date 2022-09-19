Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C7715BC628
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:16:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiISKQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiISKP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:15:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5660EE17
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:15:54 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id f14so45166270lfg.5
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 03:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=evzxOvmgH6UbQ3SrmcbZMdvnQKSuNK2KDdafv2/LKdM=;
        b=lEqZB6KB/zKuTfkk/UxqZXNOLkFMMiYQtM8DFTfIaV5bvdqgd5c6JGpq4tvujPhVLq
         oktRPeze/wuBCRi4GzBc40H9XP7DF3GQMcycEeGm+eelszMY+kvoQ1Nk9IsNaI722g5x
         SW2coy5Bitum5Ivz7EuAHTPGWcvP9aifvxSRbrMCPHzKMxDIPOKcVRJ7QWc+Y6BbkuGq
         EfSxQ6GoD/ojAdgoKSFoCD1RC/brn7fZTXz8GbutFbOXZE7a7zn+0WsXEEsuNhALDQPA
         6tesg69PFwolHyyoUTF9SVF/nBVTk+TQA9c2fgQX5wZqWpyr9K4k0G3gCF5g0/3vGzdb
         vWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=evzxOvmgH6UbQ3SrmcbZMdvnQKSuNK2KDdafv2/LKdM=;
        b=ESfeSpP3mNaE+T4MTnGkuGQAi7H16vtFeuk3vDKUr0U+FL2zAFeXmbrV0746dkd2pz
         ITYOSumNsxClhi9GXYstSk+nIwBahbdSn298CnHrZhkueTOuXIKQbonI/dG6mTfJirgH
         nTbFm9l95yDzduuKU/AmyP1tePWSTsRQJtoAo3lhND7VqR9HWS9EtTN2PM2RDFhmY2CF
         ir2WjMQB3fUnCyT/3oeX6ZYeYe0yi3WdMuoR/aCE5/CTCWYT2dyq/Rshc+7ev+HrTkGP
         KPqE7CD7Cw6PQbJ+6QcSlRW9exatFTKGa/GV4loPDyPIkML6k7tNn+dOULV76rCCub1T
         VcsQ==
X-Gm-Message-State: ACrzQf3QERiRP2JGLfK4JZaOVud0iDr5AFh3QGq9CGqvqZR2amktIch7
        8UrFCewJ8h3SQSXOhI0envHM7g==
X-Google-Smtp-Source: AMsMyM4a/SLS3T2VCUzOXDtEtxdoEXO8ti8FbVxNxmCgUL58+BE7cyiYw9w2ZdUxhfJYGWZvVabMvw==
X-Received: by 2002:a19:f515:0:b0:49e:da3d:1710 with SMTP id j21-20020a19f515000000b0049eda3d1710mr5787512lfb.600.1663582553286;
        Mon, 19 Sep 2022 03:15:53 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u15-20020ac258cf000000b00497a3e11608sm5120687lfo.303.2022.09.19.03.15.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:15:52 -0700 (PDT)
Message-ID: <2dfb57cd-d9d4-9a26-dd4c-f116894c9baf@linaro.org>
Date:   Mon, 19 Sep 2022 12:15:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, robh+dt@kernel.org,
        lee.jones@linaro.org, krzysztof.kozlowski+dt@linaro.org,
        kishon@ti.com, vkoul@kernel.org, dan.carpenter@oracle.com,
        grygorii.strashko@ti.com, rogerq@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sjakhade@cadence.com
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220914093911.187764-2-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/09/2022 11:39, Siddharth Vadapalli wrote:
> TI's J721e SoC supports additional PHY modes like QSGMII and SGMII
> that are not supported on earlier SoCs. Add a compatible for it.
> 
> Extend ti,qsgmii-main-ports property to support selection of upto
> two main ports at once across the two QSGMII interfaces.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  .../bindings/phy/ti,phy-gmii-sel.yaml         | 52 ++++++++++++++++---
>  1 file changed, 46 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> index da7cac537e15..1e19efab018b 100644
> --- a/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> +++ b/Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml
> @@ -54,6 +54,7 @@ properties:
>        - ti,dm814-phy-gmii-sel
>        - ti,am654-phy-gmii-sel
>        - ti,j7200-cpsw5g-phy-gmii-sel
> +      - ti,j721e-cpsw9g-phy-gmii-sel
>  
>    reg:
>      maxItems: 1
> @@ -65,12 +66,19 @@ properties:
>      description: |
>        Required only for QSGMII mode. Array to select the port for
>        QSGMII main mode. Rest of the ports are selected as QSGMII_SUB
> -      ports automatically. Any one of the 4 CPSW5G ports can act as the
> -      main port with the rest of them being the QSGMII_SUB ports.
> -    maxItems: 1
> -    items:
> -      minimum: 1
> -      maximum: 4

minItems: 1
maxItems: 2
  items:
    minimum: 1
    maximum: 8

> +      ports automatically. For J7200 CPSW5G with the compatible:
> +      ti,j7200-cpsw5g-phy-gmii-sel, ti,qsgmii-main-ports is an
> +      array of only one element, which is the port number ranging from
> +      1 to 4. For J721e CPSW9G with the compatible:
> +      ti,j721e-cpsw9g-phy-gmii-sel, ti,qsgmii-main-ports is an array
> +      of two elements, which corresponds to two potential QSGMII main
> +      ports. The first element and second element of the array can both
> +      range from 1 to 8 each, corresponding to two QSGMII main ports.
> +      For J721e CPSW9G, to configure port 2 as the first QSGMII main
> +      port and port 7 as the second QSGMII main port, we specify:
> +      ti,qsgmii-main-ports = <2>, <7>;
> +      If only one QSGMII main port is desired, mention the same main
> +      port twice.
>  
>  allOf:
>    - if:
> @@ -81,12 +89,43 @@ allOf:
>                - ti,dra7xx-phy-gmii-sel
>                - ti,dm814-phy-gmii-sel
>                - ti,am654-phy-gmii-sel
> +              - ti,j7200-cpsw5g-phy-gmii-sel
> +              - ti,j721e-cpsw9g-phy-gmii-sel
>      then:
>        properties:
>          '#phy-cells':
>            const: 1
>            description: CPSW port number (starting from 1)
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,j7200-cpsw5g-phy-gmii-sel
> +    then:
> +      properties:
> +        ti,qsgmii-main-ports:
> +          maxItems: 1
> +          items:
> +            minimum: 1
> +            maximum: 4
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - ti,j721e-cpsw9g-phy-gmii-sel
> +    then:
> +      properties:
> +        ti,qsgmii-main-ports:
> +          minItems: 2
> +          maxItems: 2
> +          items:
> +            minimum: 1
> +            maximum: 8
> +
>    - if:
>        not:
>          properties:
> @@ -94,6 +133,7 @@ allOf:
>              contains:
>                enum:
>                  - ti,j7200-cpsw5g-phy-gmii-sel
> +                - ti,j721e-cpsw9g-phy-gmii-sel
>      then:
>        properties:
>          ti,qsgmii-main-ports: false

This is interesting here... Did you test the bindings with your DTS?


Best regards,
Krzysztof
