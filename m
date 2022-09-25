Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBA1B5E93FF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 17:36:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiIYPge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 11:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiIYPgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 11:36:32 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE312B276;
        Sun, 25 Sep 2022 08:36:31 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d82so4463854pfd.10;
        Sun, 25 Sep 2022 08:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=Ry/ssh0vW8vuh7cvMGNAMpbJvtcRZH44TkCdLm7fbVE=;
        b=dtFhKROgMI2edtiudR/oHv+J8M0vywZfu9jDgGoCiooXmUe0DX7MnkJjyHDO++K7ph
         lLngI10RexF/WnfPWEosuafGlRGWmSbJ3c37xYKyPnGq44WGUNtJaolPyQ1hOxsW4sgJ
         X/e+XREtPD5fq+6YsxPl8LIWfcGslBqym0Tf1kyJ3aRV7BmRxmQERK/etacQwpBXMUwN
         dSEMDrwbkzUAFRD2S+KRbCnrX0bQ4EwbGfiigLldMw1GhbWTSVHhUMeUE/aQVTfMG1fe
         I/dDRaa5Ktkx10hOG4LL9mTugBLDuz6iQJsB1u+wr1kzDH85EuSKf+zJS4W5GD42MmoA
         lfKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Ry/ssh0vW8vuh7cvMGNAMpbJvtcRZH44TkCdLm7fbVE=;
        b=rbP5f8F/anEqaD3cPrLqCX3hMRbdPV3hacamOqNp5m8pBoZwcm5HdpvRI6oJ2xKNKm
         XfFcBGrwJHzjONB6l9wCFiPGN01MDsLlZTmN2WodOA2omKy1ogWixeHxbNHyNng1QNW+
         pzU1Ro3aZ+aI2avoEHNJj0tdVa3UrEZH8QQC6OHW+D2Nbk29U5GCaMaRVnPch9MlxqWT
         0PrejMNXM1hQ737zQkU3nBCxvcFT/9DfSmMak5B+9W1dbhZpTxF0BwPc2Iq4XpPCkRi5
         53m8YL/s7xdIX0nlu0EHh7Ll5aBwacBqXgtXOeVMv0GJ1p1VUzs5jqWfTvfxb/3frM3d
         HJrg==
X-Gm-Message-State: ACrzQf0QodtrAcA+QkTOt0IrWUmjGw1Wd0s/N2UNZ0O+IIiz3l0q+Sjy
        Iw9wRTYhELVlsRQaZMi6l94=
X-Google-Smtp-Source: AMsMyM4V/fI2F3gnXbTtKKwx5U4LqgUI+DXOMJXT68QfhXO0cZKZyQD9QOX8wRT6v6J+ZB31zwl7tQ==
X-Received: by 2002:a63:4e47:0:b0:43a:9d5:d1ef with SMTP id o7-20020a634e47000000b0043a09d5d1efmr16203110pgl.400.1664120190630;
        Sun, 25 Sep 2022 08:36:30 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id h23-20020a631217000000b0043be67b6304sm8810857pgl.0.2022.09.25.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 08:36:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 08:36:28 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Sergiu Moga <sergiu.moga@microchip.com>
Cc:     wim@linux-watchdog.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        eugen.hristev@microchip.com, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] watchdog: dt-bindings: atmel,at91sam9-wdt: convert to
 json-schema
Message-ID: <20220925153628.GA1758026@roeck-us.net>
References: <20220714125122.144377-1-sergiu.moga@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220714125122.144377-1-sergiu.moga@microchip.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 03:51:24PM +0300, Sergiu Moga wrote:
> Convert at91sam9 WDT binding for Atmel/Microchip SoCs to json-schema
> format.
> 
> Signed-off-by: Sergiu Moga <sergiu.moga@microchip.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> v1 -> v2:
> - move "allOf" under "required"
> 
>  .../bindings/watchdog/atmel,at91sam9-wdt.yaml | 127 ++++++++++++++++++
>  .../bindings/watchdog/atmel-wdt.txt           |  51 -------
>  2 files changed, 127 insertions(+), 51 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
>  delete mode 100644 Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
> new file mode 100644
> index 000000000000..ad27bc518670
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/watchdog/atmel,at91sam9-wdt.yaml
> @@ -0,0 +1,127 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +# Copyright (C) 2022 Microchip Technology, Inc. and its subsidiaries
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/watchdog/atmel,at91sam9-wdt.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atmel Watchdog Timers
> +
> +maintainers:
> +  - Eugen Hristev <eugen.hristev@microchip.com>
> +
> +properties:
> +  compatible:
> +    const: atmel,at91sam9260-wdt
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  atmel,max-heartbeat-sec:
> +    description:
> +      Should contain the maximum heartbeat value in seconds. This value
> +      should be less or equal to 16. It is used to compute the WDV field.
> +    maximum: 16
> +
> +  atmel,min-heartbeat-sec:
> +    description:
> +      Should contain the minimum heartbeat value in seconds. This value
> +      must be smaller than the max-heartbeat-sec value. It is used to
> +      compute the WDD field.
> +    maximum: 16
> +
> +  atmel,watchdog-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should be hardware or software.
> +    oneOf:
> +      - description:
> +          Hardware watchdog uses the at91 watchdog reset.
> +        const: hardware
> +      - description: |
> +          Software watchdog uses the watchdog interrupt
> +          to trigger a software reset.
> +        const: software
> +    default: hardware
> +
> +  atmel,reset-type:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: |
> +      Should be proc or all. This is valid only when using hardware watchdog.
> +    oneOf:
> +      - description:
> +          Assert peripherals and processor reset signals.
> +        const: all
> +      - description:
> +          Assert the processor reset signal.
> +        const: proc
> +    default: all
> +
> +  atmel,disable:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Should be present if you want to stop the watchdog.
> +
> +  atmel,idle-halt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Should be present if you want to stop the watchdog when
> +      entering idle state.
> +      CAUTION: This property should be used with care, it actually makes the
> +      watchdog not counting when the CPU is in idle state, therefore the
> +      watchdog reset time depends on mean CPU usage and will not reset at all
> +      if the CPU stops working while it is in idle state, which is probably
> +      not what you want.
> +
> +  atmel,dbg-halt:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description: |
> +      Should be present if you want to stop the watchdog when
> +      entering debug state.
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +
> +allOf:
> +  - $ref: watchdog.yaml#
> +  - if:
> +      properties:
> +        atmel,reset-type:
> +          enum:
> +            - all
> +            - proc
> +    then:
> +      properties:
> +        atmel,watchdog-type:
> +          const: hardware
> +
> +dependencies:
> +  atmel,reset-type: ['atmel,watchdog-type']
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    watchdog@fffffd40 {
> +        compatible = "atmel,at91sam9260-wdt";
> +        reg = <0xfffffd40 0x10>;
> +        interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> +        clocks = <&clk32k>;
> +        timeout-sec = <15>;
> +        atmel,watchdog-type = "hardware";
> +        atmel,reset-type = "all";
> +        atmel,dbg-halt;
> +        atmel,idle-halt;
> +        atmel,max-heartbeat-sec = <16>;
> +        atmel,min-heartbeat-sec = <0>;
> +    };
> diff --git a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt b/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> deleted file mode 100644
> index 711a880b3d3b..000000000000
> --- a/Documentation/devicetree/bindings/watchdog/atmel-wdt.txt
> +++ /dev/null
> @@ -1,51 +0,0 @@
> -* Atmel Watchdog Timers
> -
> -** at91sam9-wdt
> -
> -Required properties:
> -- compatible: must be "atmel,at91sam9260-wdt".
> -- reg: physical base address of the controller and length of memory mapped
> -  region.
> -- clocks: phandle to input clock.
> -
> -Optional properties:
> -- timeout-sec: contains the watchdog timeout in seconds.
> -- interrupts : Should contain WDT interrupt.
> -- atmel,max-heartbeat-sec : Should contain the maximum heartbeat value in
> -	seconds. This value should be less or equal to 16. It is used to
> -	compute the WDV field.
> -- atmel,min-heartbeat-sec : Should contain the minimum heartbeat value in
> -	seconds. This value must be smaller than the max-heartbeat-sec value.
> -	It is used to compute the WDD field.
> -- atmel,watchdog-type : Should be "hardware" or "software". Hardware watchdog
> -	use the at91 watchdog reset. Software watchdog use the watchdog
> -	interrupt to trigger a software reset.
> -- atmel,reset-type : Should be "proc" or "all".
> -	"all" : assert peripherals and processor reset signals
> -	"proc" : assert the processor reset signal
> -	This is valid only when using "hardware" watchdog.
> -- atmel,disable : Should be present if you want to disable the watchdog.
> -- atmel,idle-halt : Should be present if you want to stop the watchdog when
> -	entering idle state.
> -	CAUTION: This property should be used with care, it actually makes the
> -	watchdog not counting when the CPU is in idle state, therefore the
> -	watchdog reset time depends on mean CPU usage and will not reset at all
> -	if the CPU stop working while it is in idle state, which is probably
> -	not what you want.
> -- atmel,dbg-halt : Should be present if you want to stop the watchdog when
> -	entering debug state.
> -
> -Example:
> -	watchdog@fffffd40 {
> -		compatible = "atmel,at91sam9260-wdt";
> -		reg = <0xfffffd40 0x10>;
> -		interrupts = <1 IRQ_TYPE_LEVEL_HIGH 7>;
> -		clocks = <&clk32k>;
> -		timeout-sec = <15>;
> -		atmel,watchdog-type = "hardware";
> -		atmel,reset-type = "all";
> -		atmel,dbg-halt;
> -		atmel,idle-halt;
> -		atmel,max-heartbeat-sec = <16>;
> -		atmel,min-heartbeat-sec = <0>;
> -	};
