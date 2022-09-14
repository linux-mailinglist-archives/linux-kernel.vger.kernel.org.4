Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2D0C5B8CA9
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiINQPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiINQPa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 12:15:30 -0400
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659E074BB5;
        Wed, 14 Sep 2022 09:15:29 -0700 (PDT)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-1225219ee46so42339891fac.2;
        Wed, 14 Sep 2022 09:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=6ZS3O41WakCAg7A83Ssmx3qQNeeXktonoJ6955W0xIg=;
        b=Bh4uswPLtwcocHxMDOQGiZ9+I7j3Iq4S4QzmK+K2bpvX+ChLKWNCkOmj9TZd1coFoP
         suOrEXOGil6V5mdqAug/rXR9LuLxHrUCBU+RzwEua1Y1xR/RVEM4tHcP8+kIapZQY56n
         OIQVkX8hj4DDvpc7mrFioStXOV0aK5NdmCDrA+XAZQkuY9HMOtcCgqwxZtTPAGvL77OR
         VVOAN3rWXfvfi0Jr06rvLJzN5z101DwWKVV4yAU1yzyVI9d2hlL85Tx2CN1VuObK9Y1F
         v//RG0Af+wlR2LXzwNSKDsqaBsin7SssYndzUoULnZXrseoHM0Oon4wMYTAzPRXpl/Co
         iu8w==
X-Gm-Message-State: ACgBeo3VJ4OZKHwUQj0Xf55/ZTCES2wdGJQQiw8QlJselDR9aJmyIXcE
        oB9ExU5zmEKW9s/Jx/+OHSjgt9/FnQ==
X-Google-Smtp-Source: AA6agR7eE4RGdOkzrwE3tE0oSwAJSDx7z/Kjsb8i8BiUwnqTltFKiXCpj47h0kL8M/lJlOw9Az9wSA==
X-Received: by 2002:a05:6808:d50:b0:344:f3b4:2a3d with SMTP id w16-20020a0568080d5000b00344f3b42a3dmr2369699oik.76.1663172128320;
        Wed, 14 Sep 2022 09:15:28 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id n9-20020a056870970900b00127a91041a9sm8804959oaq.38.2022.09.14.09.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 09:15:28 -0700 (PDT)
Received: (nullmailer pid 2432288 invoked by uid 1000);
        Wed, 14 Sep 2022 16:15:27 -0000
Date:   Wed, 14 Sep 2022 11:15:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     lee.jones@linaro.org, krzysztof.kozlowski@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        dan.carpenter@oracle.com, grygorii.strashko@ti.com,
        rogerq@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, sjakhade@cadence.com
Subject: Re: [PATCH 1/6] dt-bindings: phy: ti: phy-gmii-sel: Add bindings for
 J721e
Message-ID: <20220914161527.GA2269201-robh@kernel.org>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
 <20220914093911.187764-2-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914093911.187764-2-s-vadapalli@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 03:09:06PM +0530, Siddharth Vadapalli wrote:
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

Two different forms for the same property name is not great. Just make a 
new property if you need something different.

Rob
