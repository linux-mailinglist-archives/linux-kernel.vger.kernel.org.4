Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0026EB1B3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233265AbjDUSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbjDUSeX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:34:23 -0400
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AFF19A6;
        Fri, 21 Apr 2023 11:34:22 -0700 (PDT)
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6a5e7482961so980126a34.3;
        Fri, 21 Apr 2023 11:34:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682102061; x=1684694061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ID3kVQt0kCgXXTGhZuez5oXsX9DE3xrlIlynGumYz5M=;
        b=RqJtwdRhx3Yg3fw50FV+QbzXLBRjnynKGuy0eYTJqIYAsu8qtXwx0ZHEVrDDCMI8uS
         p7QVjOgg1tU3iTSbDM8Qd4sxj7NJ1cQrpmjfPzGUl7bfHPbgN6eivhOpygEJyu7Ejlcn
         HPScQ50Ms/HpR9DwhKId9MRKfgoGkVM7VE04MXJXB+zffKHxamwq7A3fYsN5BNHBjAGb
         ri8epihfWI7S6/R7VX86yIp2zAXT2oDdEHJNulsd+8ZALgxi2fRoMEO2y3jPJhxM+hiC
         pxNf/AIgZLdCy1yluNbt6pIWZBxPdzrnTKcCFssmwJQPc52EX6VLPEzxoW4qSoBlpDVU
         rSYg==
X-Gm-Message-State: AAQBX9c6IZgfLfZJIBYa0WNavDj1mMSmVNnQ/FIoPbTzgxD9fY88wTRW
        utzT+x4WxPERZSK3Y12omJcRI7zTGg==
X-Google-Smtp-Source: AKy350bnQ8TBm1Z2MTM/VcinczvRkfy2ATEJUujmFRE/TCNgBVAGbz9BTyigffwKTK5iZqjrp4L/XA==
X-Received: by 2002:a9d:7e82:0:b0:6a5:fbc1:8f46 with SMTP id m2-20020a9d7e82000000b006a5fbc18f46mr3045077otp.16.1682102061163;
        Fri, 21 Apr 2023 11:34:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m22-20020a9d7ad6000000b0069436b64bb1sm1976968otn.79.2023.04.21.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:34:20 -0700 (PDT)
Received: (nullmailer pid 1590289 invoked by uid 1000);
        Fri, 21 Apr 2023 18:34:20 -0000
Date:   Fri, 21 Apr 2023 13:34:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     Nikita Bondarenko <n2h9z4@gmail.com>
Cc:     wim@linux-watchdog.org, linux@roeck-us.net,
        krzysztof.kozlowski+dt@linaro.org, f.fainelli@gmail.com,
        rjui@broadcom.com, sbranden@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: watchdog: brcm,kona-wdt: convert txt
 file to yaml
Message-ID: <20230421183420.GA1568047-robh@kernel.org>
References: <20230418170341.28805-1-n2h9z4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418170341.28805-1-n2h9z4@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 07:03:41PM +0200, Nikita Bondarenko wrote:
> Converted txt file to yaml. No additional changes.
> 
> Signed-off-by: Nikita Bondarenko <n2h9z4@gmail.com>
> ---
> 
> Changes in v3:
> - updated commit message
> - updated the compatible definition to probably fix "compatible is too long" warning
> - updated example to how it was in the txt file
> 
> 
> I do not have this warning when I am running  
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
> maybe I run it without some additional variable?
> 
> But I checked arch/arm/boot/dts/bcm28155-ap.dts, it includes bcm11351.dtsiv which contains 
> compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> which probably causes a warning
> This is exact how it was in txt file example.
> 
> If I put it in an example in a yaml file, dt_binding_check does not pass.
> Looks like the issue is in the enum type of compatible. It does not allow multiple strings.  
> Updated to not to use enum. The example with two strings in compatible passes the checks.
> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dt_binding_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json
>   DTEX    Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dts
>   DTC_CHK Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.example.dtb
> 
> make  DT_SCHEMA_FILES=Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml ARCH=arm dtbs_check
>   LINT    Documentation/devicetree/bindings
>   CHKDT   Documentation/devicetree/bindings/processed-schema.json
>   SCHEMA  Documentation/devicetree/bindings/processed-schema.json

And that's it? You need to remove all the .dtb files if you don't see 
any DTB lines. But this runs it for you:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230418170341.28805-1-n2h9z4@gmail.com/

It all looks fine, so not sure what your question/issue is?

> 
> 
> v2 patch is here: https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230402135555.62507-1-n2h9z4@gmail.com/
> 
>  .../bindings/watchdog/brcm,kona-wdt.txt       | 15 -------
>  .../bindings/watchdog/brcm,kona-wdt.yaml      | 41 +++++++++++++++++++
>  2 files changed, 41 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
>  create mode 100644 Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> deleted file mode 100644
> index 2b86a00e351d..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.txt
> +++ /dev/null
> @@ -1,15 +0,0 @@
> -Broadcom Kona Family Watchdog Timer
> ------------------------------------
> -
> -This watchdog timer is used in the following Broadcom SoCs:
> -  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> -
> -Required properties:
> -  - compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> -  - reg: memory address & range
> -
> -Example:
> -	watchdog@35002f40 {
> -		compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> -		reg = <0x35002f40 0x6c>;
> -	};
> diff --git a/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> new file mode 100644
> index 000000000000..3d4403b41cbe
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/brcm,kona-wdt.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/brcm,kona-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Broadcom Kona Family Watchdog Timer
> +
> +description: |
> +  This watchdog timer is used in the following Broadcom SoCs:
> +  BCM11130, BCM11140, BCM11351, BCM28145, BCM28155
> +
> +maintainers:
> +  - Florian Fainelli <f.fainelli@gmail.com>
> +  - Ray Jui <rjui@broadcom.com>
> +  - Scott Branden <sbranden@broadcom.com>
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: brcm,bcm11351-wdt
> +      - const: brcm,kona-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    watchdog@35002f40 {
> +        compatible = "brcm,bcm11351-wdt", "brcm,kona-wdt";
> +        reg = <0x35002f40 0x6c>;
> +    };
> -- 
> 2.34.1
> 
