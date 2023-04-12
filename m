Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B357F6DF879
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 16:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjDLO3R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 10:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDLO3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 10:29:14 -0400
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AF9A7EC9;
        Wed, 12 Apr 2023 07:29:05 -0700 (PDT)
Received: by mail-oo1-f54.google.com with SMTP id s19-20020a4adb93000000b00540fa505f2dso5152339oou.7;
        Wed, 12 Apr 2023 07:29:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681309745; x=1683901745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k176WWn9jx2u9/R85lUvqY1542CwXWfLfbsNq5SxUZA=;
        b=WAEoo10EWeC1aTXu+75mqlZHrXkBVH3Cdzpy7HQP8NjHc+4BmggcstgyFrJFXssniZ
         EFtMRmXE1Sxh4kVle0RkfWJdsNBNxJCSYzhr0CvzgotYS8d5FRoVBLIt9Br7pozWli+Y
         07Zr821IdPWJlN9q4hB3jAfOBEW0n1dIbPUcdWJQAi9OIC8VazYraon+vyMO+Xk+NZ0m
         gJVus5wcjadtrMaEJtSElHxge7IGk5CDQ6ls34wCeJ98j6KGf8o0294zhMuuW0KZQoGz
         UHeHUMfia4ncVQIMfED+SaW+PS+O+bipddDD+kGByKkS/afgthPWNJC3/XN8mtMX0DaH
         fyoQ==
X-Gm-Message-State: AAQBX9eyT1TzmjPMKzl4MGTfcthrZFeO5BDVKsE4tHOZFsfEoPyg+dJD
        KJJmadsQwk2q6aFfaPwEyA==
X-Google-Smtp-Source: AKy350aF8ET7xIUWcuvk3rOrrw4hKxuH7IjNvt/FtHfQ6zrFgjNr7B6n7Hn/lJZWMWfntV16LOmy/w==
X-Received: by 2002:a4a:8902:0:b0:541:f866:7548 with SMTP id f2-20020a4a8902000000b00541f8667548mr1040877ooi.1.1681309744774;
        Wed, 12 Apr 2023 07:29:04 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id j41-20020a4a88ac000000b0053b88b03e24sm7061927ooa.18.2023.04.12.07.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 07:29:04 -0700 (PDT)
Received: (nullmailer pid 2318194 invoked by uid 1000);
        Wed, 12 Apr 2023 14:29:03 -0000
Date:   Wed, 12 Apr 2023 09:29:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Dipen Patel <dipenp@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-gpio@vger.kernel.org, linus.walleij@linaro.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        timestamp@lists.linux.dev, krzysztof.kozlowski+dt@linaro.org,
        brgl@bgdev.pl, corbet@lwn.net, gregkh@linuxfoundation.org
Subject: Re: [V5 04/10] dt-bindings: timestamp: Add nvidia,gpio-controller
Message-ID: <20230412142903.GA2313008-robh@kernel.org>
References: <20230406171837.11206-1-dipenp@nvidia.com>
 <20230406171837.11206-5-dipenp@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230406171837.11206-5-dipenp@nvidia.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 06, 2023 at 10:18:31AM -0700, Dipen Patel wrote:
> The tegra always-on (AON) GPIO HTE/GTE provider depends on the AON
> GPIO controller where it needs to do namespace conversion between GPIO
> line number (belonging to AON GPIO controller instance) and the GTE
> slice bits. The patch introduces nvidia,gpio-controller property to
> represent that dependency.
> 
> Signed-off-by: Dipen Patel <dipenp@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  .../timestamp/nvidia,tegra194-hte.yaml        | 36 ++++++++++++++++---
>  1 file changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml b/Documentation/devicetree/bindings/timestamp/nvidia,tegra194-hte.yaml
> index 855dad3f2023..66eaa3fab8cc 100644
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
> +
>    '#timestamp-cells':
>      description:
>        This represents number of line id arguments as specified by the
> @@ -59,6 +65,12 @@ properties:
>        mentioned in the nvidia GPIO device tree binding document.
>      const: 1
>  
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - "#timestamp-cells"
> +
>  allOf:
>    - if:
>        properties:
> @@ -94,11 +106,15 @@ allOf:
>          nvidia,slices:
>            const: 17
>  
> -required:
> -  - compatible
> -  - reg
> -  - interrupts
> -  - "#timestamp-cells"
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - nvidia,tegra234-gte-aon
> +    then:
> +      required:
> +        - nvidia,gpio-controller

Adding a new required property is an ABI break. But you just added this 
in patch 2. If this is required as part of nvidia,tegra234-gte-aon 
support, then it should all be 1 patch.

>  
>  additionalProperties: false
>  
> @@ -112,6 +128,16 @@ examples:
>                #timestamp-cells = <1>;
>      };
>  
> +  - |
> +    tegra234_hte_aon: timestamp@c1e0000 {
> +              compatible = "nvidia,tegra234-gte-aon";
> +              reg = <0xc1e0000 0x10000>;
> +              interrupts = <0 13 0x4>;
> +              nvidia,int-threshold = <1>;
> +              nvidia,gpio-controller = <&gpio_aon>;
> +              #timestamp-cells = <1>;
> +    };
> +

Really need a whole other example for 1 property?

>    - |
>      tegra_hte_lic: timestamp@3aa0000 {
>                compatible = "nvidia,tegra194-gte-lic";
> -- 
> 2.17.1
> 
