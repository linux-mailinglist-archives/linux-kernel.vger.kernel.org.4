Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C630164B8B0
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 16:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiLMPky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 10:40:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbiLMPkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 10:40:52 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6156635E;
        Tue, 13 Dec 2022 07:40:51 -0800 (PST)
Received: by mail-oi1-f170.google.com with SMTP id r130so138848oih.2;
        Tue, 13 Dec 2022 07:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bjG59bmhQu/+STmt0KXnh69qXoRzwuR4Txvh999wJ34=;
        b=Vv2O3+KBE7SbXTnpAiYXxr1SO2yjLHCRWbZdMnRzs3a5AcnV7BLVRPMLHxU1z5iiwM
         FzbxuaKp/KAtV0Dye+iVDCpQGlp9E9MVJXmAF4k4d9hip50LdO3i12Hkc6tli/NLgI16
         blSYaBchEGIQkVETiH4EOEVmqkGcY/n9g5uaxaWbRwa4oXrDPUPZn6YJHROKDX+p0hFd
         XHMlzBWcoDHEwkM4dYxoYhqa4EqMo/OCWggr+YLhaFdeRnOS8Maa3rv7+Vb1y5VUsKhW
         VWCdmNZ7kLXHVzS6p3dwBzClItTMSIMrKmVFRP6St6YI3obvRMiz7f6MhZVZzPoPUcIU
         FspA==
X-Gm-Message-State: ANoB5pnusauX02zoldDvBD0RckCJmq67xOR9fnwMgpqntZK+MsAcmu45
        Ih1+bppxfeskIwT/dfM/sg==
X-Google-Smtp-Source: AA0mqf72M8eSkNaPG65e/s6kbNgNgJC0EGqkK5ROexTW8KUCln/+8A9rd91RwD3jyu9INPwEc6ngrg==
X-Received: by 2002:a05:6808:1926:b0:35e:47a5:d591 with SMTP id bf38-20020a056808192600b0035e47a5d591mr14742314oib.22.1670946050855;
        Tue, 13 Dec 2022 07:40:50 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id i15-20020a056808054f00b0035468f2d410sm4656516oig.55.2022.12.13.07.40.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 07:40:50 -0800 (PST)
Received: (nullmailer pid 1471363 invoked by uid 1000);
        Tue, 13 Dec 2022 15:40:49 -0000
Date:   Tue, 13 Dec 2022 09:40:49 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 06/12] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Message-ID: <20221213154049.GA1426116-robh@kernel.org>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022 at 05:35:26PM +0100, Krzysztof Kozlowski wrote:
> Merge Qualcomm MSM timer bindings into watchdog, because the timer
> compatibles are already included here and the hardware is quite similar.
> 
> While converting the MSM timer bindings, adjust clock-frequency
> property to take only one frequency, instead of two, because:
> 1. DT schema does not allow to frequencies,
> 2. The Linux timer driver reads only first frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../bindings/timer/qcom,msm-timer.txt         | 47 ------------------
>  .../bindings/watchdog/qcom-wdt.yaml           | 49 +++++++++++++++++++
>  2 files changed, 49 insertions(+), 47 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> 
> diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> deleted file mode 100644
> index 5e10c345548f..000000000000
> --- a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
> +++ /dev/null
> @@ -1,47 +0,0 @@
> -* MSM Timer
> -
> -Properties:
> -
> -- compatible : Should at least contain "qcom,msm-timer". More specific
> -               properties specify which subsystem the timers are paired with.
> -
> -               "qcom,kpss-timer" - krait subsystem
> -               "qcom,scss-timer" - scorpion subsystem
> -
> -- interrupts : Interrupts for the debug timer, the first general purpose
> -               timer, and optionally a second general purpose timer, and
> -               optionally as well, 2 watchdog interrupts, in that order.
> -
> -- reg : Specifies the base address of the timer registers.
> -
> -- clocks: Reference to the parent clocks, one per output clock. The parents
> -          must appear in the same order as the clock names.
> -
> -- clock-names: The name of the clocks as free-form strings. They should be in
> -               the same order as the clocks.
> -
> -- clock-frequency : The frequency of the debug timer and the general purpose
> -                    timer(s) in Hz in that order.
> -
> -Optional:
> -
> -- cpu-offset : per-cpu offset used when the timer is accessed without the
> -               CPU remapping facilities. The offset is
> -               cpu-offset + (0x10000 * cpu-nr).
> -
> -Example:
> -
> -       timer@200a000 {
> -               compatible = "qcom,scss-timer", "qcom,msm-timer";
> -               interrupts = <1 1 0x301>,
> -                            <1 2 0x301>,
> -                            <1 3 0x301>,
> -                            <1 4 0x301>,
> -                            <1 5 0x301>;
> -               reg = <0x0200a000 0x100>;
> -               clock-frequency = <19200000>,
> -                                 <32768>;
> -               clocks = <&sleep_clk>;
> -               clock-names = "sleep";
> -               cpu-offset = <0x40000>;
> -       };
> diff --git a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> index b7fc57f4800e..697caf1937cc 100644
> --- a/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/qcom-wdt.yaml
> @@ -10,6 +10,9 @@ maintainers:
>    - Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>  
>  properties:
> +  $nodename:
> +    pattern: "^(watchdog|timer)@[0-9a-f]+$"
> +
>    compatible:
>      oneOf:
>        - items:
> @@ -48,6 +51,20 @@ properties:
>    clocks:
>      maxItems: 1
>  
> +  clock-names:
> +    items:
> +      - const: sleep
> +
> +  clock-frequency:
> +    description:
> +      The frequency of the general purpose timer in Hz in that order.

'in that order'?

> +
> +  cpu-offset:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Per-CPU offset used when the timer is accessed without the CPU remapping
> +      facilities. The offset is cpu-offset + (0x10000 * cpu-nr).
> +
>    interrupts:
>      minItems: 1
>      maxItems: 5
> @@ -67,12 +84,27 @@ allOf:
>              const: qcom,kpss-wdt
>      then:
>        properties:
> +        clock-frequency: false
> +        cpu-offset: false
>          interrupts:
>            minItems: 1
>            items:
>              - description: Bark
>              - description: Bite
>  
> +    else:
> +      properties:
> +        interrupts:
> +          minItems: 3
> +          items:
> +            - description: Debug
> +            - description: First general purpose timer
> +            - description: Second general purpose timer
> +            - description: First watchdog
> +            - description: Second watchdog

Okay, here they are. No need to set it to 2 then change to 5 in the 
series.

> +      required:
> +        - clock-frequency
> +
>  unevaluatedProperties: false
>  
>  examples:
> @@ -86,3 +118,20 @@ examples:
>        interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
>        timeout-sec = <10>;
>      };
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +
> +    watchdog@200a000 {
> +      compatible = "qcom,kpss-wdt-ipq8064", "qcom,kpss-timer", "qcom,msm-timer";
> +      interrupts = <GIC_PPI 1 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 2 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 3 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 4 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>,
> +                   <GIC_PPI 5 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_EDGE_RISING)>;
> +      reg = <0x0200a000 0x100>;
> +      clock-frequency = <25000000>;
> +      clocks = <&sleep_clk>;
> +      clock-names = "sleep";
> +      cpu-offset = <0x80000>;
> +    };
> -- 
> 2.34.1
> 
> 
