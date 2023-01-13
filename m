Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7E669990
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 15:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241310AbjAMOHK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241586AbjAMOGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:06:19 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCCC56CFE5;
        Fri, 13 Jan 2023 06:03:25 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id r132so7194531oif.10;
        Fri, 13 Jan 2023 06:03:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zOpB9jc9mWfLU0ZWgyT65GNsRS3+yjZhf8XxiS47TKk=;
        b=fBnYORKr1ZhfcREXdzeYN2rCIidWZrTDVGdBoyGnIraghQDzvGSSp2Dzbuj+LusvYM
         qVWOMsOOXsaYWX+/Pk+0NDe/wXA+e6lNQYHLw9JfVbfT+RGH7JAgPEuwcdKSbn7Lsggp
         utWs+8UMk6MgygOsi7u15f0QRLK4cA8YMGxIacZJ7m4zhOReC0xTOPgREiy8tdIiXtKc
         lS1cNTuIipwCScTd6lg1C9528fFIvz4rM4C4M4ETvZ+salsBbsjP/ncJ+OPjJtk8Njyt
         fOJiQi+vwB1qYd+CjujMQh41zl2ZqxNRczeKCIryaQ6UyV+xqpKw8sRn34MN8ttQT+bB
         Y0Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zOpB9jc9mWfLU0ZWgyT65GNsRS3+yjZhf8XxiS47TKk=;
        b=pGPnnsuBd5StspsK8eDqEc9hANXnj5Xq4sB3xNabm6Il7Q7dJ0NEVADWyrF/0MUmpb
         c50qQjC4kfDinK/bxf/49pxY6/u384N4Y7KxA84tcu6SJhu7qSomuHKpET7qhDLTEdR+
         osqhkua05J1emWQUA/7qlOrFTb5e2qJh/F2sIiMrqEHrdLLPM1B/2/PBRfLZrKDupSGB
         uQU2YEOEqesyl7nS2i9FXZVwt+MGMvVsoV0a1As/g8WL8vnc394WZCno/B66qFlVlS8b
         pJjgGP7ZG23QoS8aWriDJV7PgkGPPnhr9Yaf835ocTzJrUbe8sHMtbNcbSkffMnx1dT+
         aosw==
X-Gm-Message-State: AFqh2kq6GihX2g/iUAxtWdVlMu1sVR/m2JtTzB6BlCsOhqePSNn411as
        /1Flx8PDa+/vaaaqDKXY0RI=
X-Google-Smtp-Source: AMrXdXv4SxbVkYkY75wFTcHi9Xu48M6nzaZSp0cVERxQDBASselTYdWlEI9Rt+xp0gihDB31JRRx5A==
X-Received: by 2002:a05:6808:7dd:b0:35e:d286:2327 with SMTP id f29-20020a05680807dd00b0035ed2862327mr36118704oij.36.1673618605153;
        Fri, 13 Jan 2023 06:03:25 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ez12-20020a0568082a0c00b0035a64076e0bsm9259019oib.37.2023.01.13.06.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 06:03:24 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 13 Jan 2023 06:03:23 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 6/7] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Message-ID: <20230113140323.GF1606649@roeck-us.net>
References: <20230113103346.29381-1-krzysztof.kozlowski@linaro.org>
 <20230113103346.29381-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230113103346.29381-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2023 at 11:33:45AM +0100, Krzysztof Kozlowski wrote:
> Merge Qualcomm MSM timer bindings into watchdog, because the timer
> compatibles are already included here and the hardware is quite similar.
> 
> While converting the MSM timer bindings, adjust clock-frequency
> property to take only one frequency, instead of two, because:
> 1. DT schema does not allow to frequencies,
> 2. The Linux timer driver reads only first frequency.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> 

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes since v1:
> 1. Add tag.
> 2. Correct clock-frequency description (Rob).
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
> index b7fc57f4800e..837ce9112071 100644
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
> +      The frequency of the general purpose timer in Hz.
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
