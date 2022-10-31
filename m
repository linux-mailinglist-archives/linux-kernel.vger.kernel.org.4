Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BB1613E36
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 20:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbiJaT0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 15:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiJaT0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 15:26:18 -0400
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF46512A91;
        Mon, 31 Oct 2022 12:26:17 -0700 (PDT)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso14556060fac.4;
        Mon, 31 Oct 2022 12:26:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX/15SmgbKnoA8NYNgOkQd19uJzonc1V4d9NSIvOrJk=;
        b=L2g38cgG5FZvge1T1k3g7ShMh0EnQlZsCTzpSHN3U2l7sGTNeWAYMMCgxG3WEh2NkF
         XvWuXULWjQ9t4fnZfVO0cQe1VQNnViHyYbWM2nd2LH0/80lxrg+CS6Vk69ByrBpw7BIV
         cvxpKFvSEhLFWY1DmZWi6r0uxr1x54IqbhwuY/9FO0rRRb2wjdJg12UztcgwlHg5HbBX
         USl7d8JFqU3/7eQ/R/mDAnjgjZoE7utJ7S4DNA4ozB5l0u/mIa35KvuJB4IUNe8XeuF+
         XJTD+jQeyeorQUr8oFcFmphIBmq1ngSGQe22PJHUqKByWtr5vy5IBblTptLpx4Z/5K9N
         i/Bg==
X-Gm-Message-State: ACrzQf3Pl1V9TejxSERYGZ8KPLaIyUOx6ih1S1iqAG4AZsQBDNjHI7vh
        pFXolyhQytXmSgLKPteq+tTxHC/IOw==
X-Google-Smtp-Source: AMsMyM4H3LQsJ9yrNHPpm3zKxMXLFOih3/F+AfFY8mumnVW2PhpB3orBmrkEeU1emmG5vY/ByoSnsQ==
X-Received: by 2002:a05:6870:8317:b0:131:a61a:60fe with SMTP id p23-20020a056870831700b00131a61a60femr17861801oae.30.1667244376955;
        Mon, 31 Oct 2022 12:26:16 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id d7-20020a056870960700b00130e66a7644sm3454656oaq.25.2022.10.31.12.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 12:26:16 -0700 (PDT)
Received: (nullmailer pid 3286442 invoked by uid 1000);
        Mon, 31 Oct 2022 19:26:17 -0000
Date:   Mon, 31 Oct 2022 14:26:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Artur Rojek <contact@artur-rojek.eu>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Markus Laine <markus.laine@fi.rohmeurope.com>,
        Mikko Mutanen <mikko.mutanen@fi.rohmeurope.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: power: supply: expect specific type for
 monitored-battery
Message-ID: <20221031192617.GA3283833-robh@kernel.org>
References: <20221028231255.565363-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028231255.565363-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 07:12:55PM -0400, Krzysztof Kozlowski wrote:
> Core schema does not define type of monitored-battery, so the schemas
> are expected to reference proper type.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/supply/bq27xxx.yaml    | 2 +-
>  .../devicetree/bindings/power/supply/ingenic,battery.yaml      | 1 +
>  .../devicetree/bindings/power/supply/rohm,bd99954.yaml         | 1 +
>  .../devicetree/bindings/power/supply/sc2731-charger.yaml       | 2 +-
>  Documentation/devicetree/bindings/power/supply/sc27xx-fg.yaml  | 3 ++-
>  5 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> index 65fc6049efc1..b04c86ed0f58 100644
> --- a/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/bq27xxx.yaml
> @@ -59,6 +59,7 @@ properties:
>      description: integer, I2C address of the fuel gauge.
>  
>    monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle
>      description: |
>         phandle of battery characteristics node.
>         The fuel gauge uses the following battery properties:
> @@ -66,7 +67,6 @@ properties:
>         - charge-full-design-microamp-hours
>         - voltage-min-design-microvolt
>         Both or neither of the *-full-design-*-hours properties must be set.
> -       See Documentation/devicetree/bindings/power/supply/battery.yaml
>  
>    power-supplies: true
>  
> diff --git a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> index 46527038bf22..8bdacc30e9d8 100644
> --- a/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> +++ b/Documentation/devicetree/bindings/power/supply/ingenic,battery.yaml
> @@ -27,6 +27,7 @@ properties:
>      const: battery
>  
>    monitored-battery:
> +    $ref: /schemas/types.yaml#/definitions/phandle

We should not have a type definition multiple times for the same 
property. We need to add a common schema defining the type instead.

Rob
