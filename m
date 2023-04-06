Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53A66D9CF4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 18:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239813AbjDFQDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 12:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjDFQDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 12:03:14 -0400
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9B44C16;
        Thu,  6 Apr 2023 09:03:13 -0700 (PDT)
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-17aceccdcf6so42792712fac.9;
        Thu, 06 Apr 2023 09:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680796992; x=1683388992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lefJRHrqvcl4m8vvYyVqVDAjvfb85dfjLk6rh9rm9wc=;
        b=X3rZhLRRXDoaSfYUj3x3JecbkoTRlEdr3QpEwlxTuXEaQyfGKFOGZydnIo48mf8TmK
         VPBkmBLt1UFSsQqF9CT3I8qxdPBEh8wLeJp0YTuWl3KFhFvTQERgEYKOERh9S6b2jTOz
         SpWYhfokF0mgNPfK60wDo8HU9lsrXkaG0CSnFhiiRdyR9Xb8KxWJ8ozFXQi6mFF01Zbt
         ScxCd6kN1NIR8ZAI5dQwBgmA2OGTTje8r5xv1r47KqBds/xX0V4ZGQfGHGqawlAPoEn2
         6K44THa5wjfiP9FrnW6i6yC8pJpH5Bx8P7EWjsyOa62eohGY2J6BRR07zYptFdLY/o12
         bZBg==
X-Gm-Message-State: AAQBX9dNfAywfgg7yQH/umd4Ow4K+ND2ICHFwSBAlWkYBnbKjCfLOLfO
        pN3St7QeVtNre6MJaS+Kx68gc3KNRA==
X-Google-Smtp-Source: AKy350ZrZmUBZENCzrSlM1I16WFc/0oXgEc2lz1Ire2HnTTfoAQcnbdCuriXeqU8jaOxoHh8K0BruA==
X-Received: by 2002:a05:6870:2482:b0:16e:8ce5:b94 with SMTP id s2-20020a056870248200b0016e8ce50b94mr6187514oaq.43.1680796992219;
        Thu, 06 Apr 2023 09:03:12 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s190-20020acaa9c7000000b003896df086b0sm812415oie.15.2023.04.06.09.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 09:03:11 -0700 (PDT)
Received: (nullmailer pid 3170577 invoked by uid 1000);
        Thu, 06 Apr 2023 16:03:10 -0000
Date:   Thu, 6 Apr 2023 11:03:10 -0500
From:   Rob Herring <robh@kernel.org>
To:     Om Parikh <hack3r-0m@proton.me>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Olof Johansson <olof@lixom.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: watchdog: alphascale-asm9260: convert to DT
 schema
Message-ID: <20230406160310.GA3159522-robh@kernel.org>
References: <20230403004138.326482-1-hack3r-0m@proton.me>
 <20230404022015.754177-1-hack3r-0m@proton.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404022015.754177-1-hack3r-0m@proton.me>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 02:21:36AM +0000, Om Parikh wrote:
> Makes alphascale-asm9260 dt bindings adhere to the dt json-schema
> by replacing txt file with yaml file.
> 
> Signed-off-by: Om Parikh <hack3r-0m@proton.me>
> ---
>  .../watchdog/alphascale,asm9260-wdt.yaml      | 73 +++++++++++++++++++
>  .../bindings/watchdog/alphascale-asm9260.txt  | 35 ---------
>  2 files changed, 73 insertions(+), 35 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> new file mode 100644
> index 000000000000..ceee5f086e4a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/alphascale,asm9260-wdt.yaml
> @@ -0,0 +1,73 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/alphascale,asm9260-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Alphascale asm9260 Watchdog timer
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +
> +maintainers:
> +  - Oleksij Rempel <linux@rempel-privat.de>
> +  - Olof Johansson <olof@lixom.net>

I'm not sure how you came up with Olof for this, but you should drop 
him.

> +
> +properties:
> +  compatible:
> +    enum:
> +      - alphascale,asm9260-wdt

const: alphascale,asm9260-wdt

> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: source clock, used for tick counter
> +      - description: ahb gate
> +
> +  clock-names:
> +    items:
> +      - const: mod
> +      - const: ahb
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  resets:
> +    items:
> +      - description: phandle pointing to the system reset controller with line
> +                     index for the watchdog.

Not really a useful description. Just 'maxItems: 1' is fine.

> +
> +  reset-names:
> +    items:
> +      - const: wdt_rst
> +
> +  timeout-sec: true
> +
> +  alphascale,mode:
> +    description: to specify the reset mode of operation
> +    $ref: /schemas/types.yaml#/definitions/string
> +    enum: [hw, sw, debug]
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - interrupts
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/alphascale,asm9260.h>
> +    watchdog0: watchdog@80048000 {
> +      compatible = "alphascale,asm9260-wdt";
> +      reg = <0x80048000 0x10>;
> +      clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
> +      clock-names = "mod", "ahb";
> +      interrupts = <55>;
> +      timeout-sec = <30>;
> +      alphascale,mode = "hw";
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt b/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> deleted file mode 100644
> index 75b265a04047..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/alphascale-asm9260.txt
> +++ /dev/null
> @@ -1,35 +0,0 @@
> -Alphascale asm9260 Watchdog timer
> -
> -Required properties:
> -
> -- compatible : should be "alphascale,asm9260-wdt".
> -- reg : Specifies base physical address and size of the registers.
> -- clocks : the clocks feeding the watchdog timer. See clock-bindings.txt
> -- clock-names : should be set to
> -	"mod" - source for tick counter.
> -	"ahb" - ahb gate.
> -- resets : phandle pointing to the system reset controller with
> -	line index for the watchdog.
> -- reset-names : should be set to "wdt_rst".
> -
> -Optional properties:
> -- timeout-sec : shall contain the default watchdog timeout in seconds,
> -	if unset, the default timeout is 30 seconds.
> -- alphascale,mode : three modes are supported
> -	"hw" - hw reset (default).
> -	"sw" - sw reset.
> -	"debug" - no action is taken.
> -
> -Example:
> -
> -watchdog0: watchdog@80048000 {
> -	compatible = "alphascale,asm9260-wdt";
> -	reg = <0x80048000 0x10>;
> -	clocks = <&acc CLKID_SYS_WDT>, <&acc CLKID_AHB_WDT>;
> -	clock-names = "mod", "ahb";
> -	interrupts = <55>;
> -	resets = <&rst WDT_RESET>;
> -	reset-names = "wdt_rst";
> -	timeout-sec = <30>;
> -	alphascale,mode = "hw";
> -};
> -- 
> 2.40.0
> 
> 
