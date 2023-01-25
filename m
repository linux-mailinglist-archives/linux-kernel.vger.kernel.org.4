Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB60067BDD8
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:13:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbjAYVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235602AbjAYVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:13:37 -0500
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9CC12F2A;
        Wed, 25 Jan 2023 13:13:31 -0800 (PST)
Received: by mail-oi1-f173.google.com with SMTP id r132so17419632oif.10;
        Wed, 25 Jan 2023 13:13:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxxLu5neQmd1wkijNxY+uQAZdlFfbPPJYNilQTfY588=;
        b=dia0HfuMAMd75vSEwVfY4fAzzyZA7lHYJxsX9dh5L9QEv3BkPbBKEwbMpfi32uGpke
         uzcXem4ikueBezF0ktjd+I0IaiFbsB8Q7oORlQTrMWvqBELqQb4A5muNUX/8ogLQBv7i
         ef69pD9sTrXzWOgNt1olsESXA1OBn/SuTvgWuklceBcgT1dLUxRWhFAwT5cSlfptZIvy
         z7AZv26IE6H+uAhAybYtsggXcV6V+PGv6BJDyNkQHlEH52l4TuSu4cL28Oz/4jCDQ0OX
         HposoCluAyQuqLZ7f7I1L1iqzarbYv9M9utc9U8v1arlbCP84+H1ob0yxuHeugySItFn
         poyA==
X-Gm-Message-State: AFqh2kpZrd8ZoGvBf1rVCaYiERYnjx4vJLn1QjwY4RtBXCkS2Vv+ONoj
        6rm6IxOAr0vz+4i8Tj9j6Hv2JoRnCQ==
X-Google-Smtp-Source: AMrXdXu/SugN1OZvYht+GqN+hP045IwbIzwV4tVY82cvphVKskkZ9RCsN4cRd8p4EMcNXA2Injxghg==
X-Received: by 2002:aca:1b0a:0:b0:364:ef1f:90e with SMTP id b10-20020aca1b0a000000b00364ef1f090emr14953639oib.28.1674681210360;
        Wed, 25 Jan 2023 13:13:30 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h22-20020a9d6016000000b00670461b8be4sm2607200otj.33.2023.01.25.13.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:13:30 -0800 (PST)
Received: (nullmailer pid 2902560 invoked by uid 1000);
        Wed, 25 Jan 2023 21:13:29 -0000
Date:   Wed, 25 Jan 2023 15:13:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: samsung,exynos-dwc3: allow unit
 address in DTS
Message-ID: <20230125211329.GA2899932-robh@kernel.org>
References: <20230125175943.675823-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125175943.675823-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 06:59:43PM +0100, Krzysztof Kozlowski wrote:
> The Samsung Exynos SoC USB 3.0 DWC3 Controller is a simple wrapper of
> actual DWC3 Controller device node.  It handles necessary Samsung
> Exynos-specific resources (regulators, clocks), but does not have its
> own MMIO address space.
> 
> However neither simple-bus bindings nor dtc W=1 accept device nodes in
> soc@ node which do not have unit address.  Therefore allow using
> the address space of child device (actual DWC3 Controller) as the
> wrapper's address.

The correct fix is 'ranges' should have a value. Though the whole 
wrapper thing when there are no registers I dislike...

> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> DTS fixes are here:
> https://lore.kernel.org/linux-samsung-soc/20230125175751.675090-1-krzysztof.kozlowski@linaro.org/T/#t
> ---
>  .../devicetree/bindings/usb/samsung,exynos-dwc3.yaml        | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> index 6b9a3bcb3926..a94b1926dda0 100644
> --- a/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> +++ b/Documentation/devicetree/bindings/usb/samsung,exynos-dwc3.yaml
> @@ -29,6 +29,9 @@ properties:
>  
>    ranges: true
>  
> +  reg:
> +    maxItems: 1
> +
>    '#size-cells':
>      const: 1
>  
> @@ -108,8 +111,9 @@ examples:
>      #include <dt-bindings/clock/exynos5420.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>  
> -    usb {
> +    usb-wrapper@12000000 {
>          compatible = "samsung,exynos5250-dwusb3";
> +        reg = <0x12000000 0x10000>;
>          #address-cells = <1>;
>          #size-cells = <1>;
>          ranges;
> -- 
> 2.34.1
> 
