Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F276366A439
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 21:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbjAMUmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 15:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjAMUmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 15:42:33 -0500
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1108587921;
        Fri, 13 Jan 2023 12:42:33 -0800 (PST)
Received: by mail-ot1-f46.google.com with SMTP id d2-20020a056830044200b00684cc404c8aso2328690otc.0;
        Fri, 13 Jan 2023 12:42:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmvQnuv1fXumUPiHaWF/NrHLmipdDuyfTZdsKOQOgKY=;
        b=EZMF4T0BTZgM/fUGioAJXR7dpqJVrKRaeHZa0A/ubVy/9/4T6fU0iOX9tUkyTcfRms
         e7ioVN4WU7wFgNWCcf7tFbU89OqwxW9NyukuAjb6aZjssdzpjBsRvfrlp8tsCJUUbKZ0
         kc8LBhb2dqnzu5DzDkjpzMmSecN2qmvfQIlfqJhBZB+BYH+NdO/hFvBfXhdhUdi56OmL
         1IwvuQfrn1YQ20l3gCz1BKrpvPqWl2CDrTUi/d5C3+O11ctOw75hdnQgveqSRVKO04/3
         wOzYP+tNjr4nf052bjWlbr0mUIVqJRSRJi5pugPRo7E1FbTvtSF+ULcdLRFR38U28223
         uvFA==
X-Gm-Message-State: AFqh2kqGXHSCQ22Sukcm0JhlIn+vnyxFHjvl86gXITa764BxNeAB0MK/
        43XOFi0QuuxLwY9El2GvOivWO5BWFA==
X-Google-Smtp-Source: AMrXdXtsPMkTlNYDgR0d4inu8VinibhZFbz2bg//MXzm1dZymwYMTp1mb7YwjZHEHaEGE+rh+kb3nQ==
X-Received: by 2002:a05:6830:368b:b0:670:7a2b:f52f with SMTP id bk11-20020a056830368b00b006707a2bf52fmr42687541otb.8.1673642552296;
        Fri, 13 Jan 2023 12:42:32 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bt25-20020a05683039d900b0066e80774203sm11196309otb.43.2023.01.13.12.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 12:42:31 -0800 (PST)
Received: (nullmailer pid 2888595 invoked by uid 1000);
        Fri, 13 Jan 2023 20:42:31 -0000
Date:   Fri, 13 Jan 2023 14:42:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        op-tee@lists.trustedfirmware.org, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 2/3] dt-bindings: arm: optee: add interrupt controller
 properties
Message-ID: <20230113204231.GA2873887-robh@kernel.org>
References: <20230112145424.3791276-1-etienne.carriere@linaro.org>
 <20230112145424.3791276-3-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230112145424.3791276-3-etienne.carriere@linaro.org>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 03:54:23PM +0100, Etienne Carriere wrote:
> Adds optional interrupt controller properties used when OP-TEE generates
> interrupt events optee driver shall notified to its registered
> interrupt consumer. The example shows how OP-TEE can trigger a wakeup
> interrupt event consumed by a gpio-keys compatible device.

Why do we need this in DT? It's not a GPIO key, but an abuse of the 
binding. It looks like unnecessary abstraction to me.


> 
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  .../arm/firmware/linaro,optee-tz.yaml         | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> index d4dc0749f9fd..42874ca21b7e 100644
> --- a/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> +++ b/Documentation/devicetree/bindings/arm/firmware/linaro,optee-tz.yaml
> @@ -40,6 +40,11 @@ properties:
>        HVC #0, register assignments
>        register assignments are specified in drivers/tee/optee/optee_smc.h
>  
> +  interrupt-controller: true
> +
> +  "#interrupt-cells":
> +    const: 1
> +
>  required:
>    - compatible
>    - method
> @@ -48,12 +53,24 @@ additionalProperties: false
>  
>  examples:
>    - |
> +    #include <dt-bindings/input/input.h>
>      #include <dt-bindings/interrupt-controller/arm-gic.h>
>      firmware  {
> -        optee  {
> +        optee: optee {
>              compatible = "linaro,optee-tz";
>              method = "smc";
>              interrupts = <GIC_SPI 187 IRQ_TYPE_EDGE_RISING>;
> +            interrupt-controller;
> +            #interrupt-cells = <1>;
> +        };
> +    };
> +
> +    wake_up {
> +        compatible = "gpio-keys";
> +
> +        button {
> +            linux,code = <KEY_WAKEUP>;
> +            interrupts-extended = <&optee 0>;

In the end, you just need optee IRQ #0 to generate KEY_WAKEUP. Does 
either the optee interrupt number or the key code need to be 
configurable? If so, why? Why isn't #0 just wakeup and the driver can 
send KEY_WAKEUP?

DT is for non-discoverable hardware that we can't fix. Why repeat that 
for software interfaces to firmware?

Rob
