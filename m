Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DA06C8311
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 18:14:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbjCXRON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 13:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbjCXROJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 13:14:09 -0400
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4826E30CA;
        Fri, 24 Mar 2023 10:13:45 -0700 (PDT)
Received: by mail-ot1-f50.google.com with SMTP id 14-20020a9d010e000000b0069f1287f557so1253656otu.0;
        Fri, 24 Mar 2023 10:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679678011;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kXC/ehgAlDQxlar8G+0cOCIylNpUxRXIsV141jWIs+8=;
        b=d8w6/kgIy4OWy6tIGXp/lwc2cnIC8HQujHDyKpv0ZS0D6gk7/KmhUkSJb4t1DWqQ2x
         zAB/PZCPvMIPgAuvKylj2w/GBWA+1Vsi7mZVVvE0959YptHo8OmTCDapSMvualyEDw7y
         vBLLd6RM6Pu75qnwhd5HKZ4t/cBFgt7VNlabUHGb5rNOCPQnkL03MMulZYPs8gmjShWD
         YnPSaA7CFIYnm2ATm+zUVwAqIrPg4k8Cwdx0n9wgKML3VtemW2GMAPGnkX+4ivGUD9kc
         lGK+oHDImQ6JJZxujGm5a4CpKfc7LfP7aHzL0JpIrS9UeHfPPgblvtWZYl9KvP0W389A
         vwDQ==
X-Gm-Message-State: AO0yUKV/AwS11f7cFuf74RTZh/tQiCxhzxs4cpOESHr5G2z0MaW2Nnzu
        zesXd9vgx+KW8oGMUy0VSA==
X-Google-Smtp-Source: AK7set+5p7gPylRYq/K6l1RQHd22yIy2rXmsFpG3s5vAqu3sGEjDS54c2caeW0q1rpz0pGfTGa7MZg==
X-Received: by 2002:a05:6830:14d0:b0:69f:9140:2dde with SMTP id t16-20020a05683014d000b0069f91402ddemr1970115otq.37.1679678010821;
        Fri, 24 Mar 2023 10:13:30 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d74d4000000b006a11998d20esm459350otl.45.2023.03.24.10.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:13:30 -0700 (PDT)
Received: (nullmailer pid 2073665 invoked by uid 1000);
        Fri, 24 Mar 2023 17:13:29 -0000
Date:   Fri, 24 Mar 2023 12:13:29 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [PATCH V4 04/10] dt-bindings: timestamp: Add
 nvidia,gpio-controller
Message-ID: <20230324171329.GA2062332-robh@kernel.org>
References: <20230323012929.10815-1-dipenp@nvidia.com>
 <20230323012929.10815-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230323012929.10815-5-dipenp@nvidia.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 06:29:23PM -0700, Dipen Patel wrote:
> Introducing nvidia,gpio-controller property from Tegra234 SoCs onwards.
> This is done to help below case.
> 
> Without this property code would look like:
> if (of_device_is_compatible(dev->of_node, "nvidia,tegra194-gte-aon"))
> 	hte_dev->c = gpiochip_find("tegra194-gpio-aon",
> 				   tegra_get_gpiochip_from_name);
> else if (of_device_is_compatible(dev->of_node, "nvidia,tegra234-gte-aon"))
> 	hte_dev->c = gpiochip_find("tegra234-gpio-aon",
> 				   tegra_get_gpiochip_from_name);
> else
> 	return -ENODEV;

Or you just put the name in match data.

> 
> This means for every future addition of the compatible string, if else
> condition statements have to be expanded.
> 
> With the property:
> gpio_ctrl = of_parse_phandle(dev->of_node, "nvidia,gpio-controller", 0);
> ....
> hte_dev->c = gpiochip_find(gpio_ctrl, tegra_get_gpiochip_from_of_node);
> 
> This simplifies the code significantly. The introdunction of this

typo 

> property/binding does not break existing Tegra194 provider driver.

Making a new property required is an ABI break.

> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> ---
>  .../timestamp/nvidia,tegra194-hte.yaml        | 31 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index eafc33e9ae2e..841273a3d8ae 100644
> --- a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> +++ b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> @@ -51,6 +51,12 @@ properties:
>        LIC instance has 11 slices and Tegra234 LIC has 17 slices.
>      enum: [3, 11, 17]
>  
> +  nvidia,gpio-controller:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description:
> +      The phandle to AON gpio controller instance. This is required to handle
> +      namespace conversion between GPIO and GTE.

Explain what the GPIO controller is needed for rather than how this 
changes the driver.

> +
>    '#timestamp-cells':
>      description:
>        This represents number of line id arguments as specified by the
> @@ -65,22 +71,43 @@ required:
>    - interrupts
>    - "#timestamp-cells"
>  
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-gte-aon
> +    then:
> +      required:
> +        - nvidia,gpio-controller

> +
>  additionalProperties: false
>  
>  examples:
>    - |
>      tegra_hte_aon: timestamp@c1e0000 {
>                compatible = "nvidia,tegra194-gte-aon";
> -              reg = <0xc1e0000 0x10000>;
> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
> +              interrupts = <0 13 0x4>;
> +              nvidia,int-threshold = <1>;
> +              #timestamp-cells = <1>;
> +    };
> +
> +  - |
> +    tegra234_hte_aon: timestamp@c1e0000 {
> +              compatible = "nvidia,tegra234-gte-aon";
> +              reg = <0x0 0xc1e0000 0x0 0x10000>;
>                interrupts = <0 13 0x4>;
>                nvidia,int-threshold = <1>;
> +              nvidia,gpio-controller = <&gpio_aon>;
>                #timestamp-cells = <1>;
>      };
>  
>    - |
>      tegra_hte_lic: timestamp@3aa0000 {
>                compatible = "nvidia,tegra194-gte-lic";
> -              reg = <0x3aa0000 0x10000>;
> +              reg = <0x0 0x3aa0000 0x0 0x10000>;
>                interrupts = <0 11 0x4>;
>                nvidia,int-threshold = <1>;
>                #timestamp-cells = <1>;
> -- 
> 2.17.1
> 
