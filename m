Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61E76833FA
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 18:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbjAaReV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 12:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230268AbjAaRdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 12:33:51 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1140552B6;
        Tue, 31 Jan 2023 09:33:49 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id r205so13447795oib.9;
        Tue, 31 Jan 2023 09:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tel9l3MqKSV+aHD5I20WPC4DEySjXkhtFSfkOZC950I=;
        b=mqmjXoHX6h/nXEWr8TFTcJ42H88rrs4ovDdpMyOo5Rmuwa4xbntHShmtY697Fyd13E
         HWlNKouMwPRWaZbXBe/uNYq7UAV3fQdmHVZ8YLhgi0A+y6tHJwO4T32jjkmDI2NzxPVV
         i0jjPGX/A7n2mMmcZrTKVCF6fsNHE0eTmBSDviDzQc7qNzOEvC7GJ1TNhLL4qIfBZypq
         R4ZFyomzOayX7t4rzoIX1Q/Ez8ne2S38byPocNGi7o0tcoZrI9RRXH3NdWcZ2rKXJDmp
         xRnazVseDJcy7r8CYRaWJsTTJCfEgnWxQlgdxjfRx4aPPHkbg5XRfwJUTDSGrmShIDWU
         0y/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tel9l3MqKSV+aHD5I20WPC4DEySjXkhtFSfkOZC950I=;
        b=i6YM+b/ekmzuIM4UUlMMk1RpZJsfc1kxK+GuWAL+WEOS9QC5lXNi3eyZIKI6SA01tk
         mWpskxac1A4Td8wBW3535EXdLIvsvww2OzGRnyU1PSUwYmJ3TfIVnKHK62klZpLHFJtr
         tntsh/dKZ6Lu0Y2zHyQQ7MzRoUg5f/Ab75fYK0Va+GBNuIMQgAr2jx1BCHjldFezqMjU
         fHpcA/L7dMEc4jbYAnG+/PJaRvwinQF4x7ShoMgcxG/E5DQMxwS0qZulj1ddeQz5QqLU
         XLSm7FRiSIrPtRTH6PX4LYVJfqEgCqo6bEPNph3cjTRPshlebDP1hzdxqrJkwi59XZIs
         bcyw==
X-Gm-Message-State: AO0yUKUfPymN+TfwL9tPkEXjNMUaH7tFBYNWIk9F7pwDtDRGklY8Kju/
        w75TzNkLhayPeqVhwlqY62UZDl5YV5A=
X-Google-Smtp-Source: AK7set9djGTrwahZbXc5MZcj5yKkpn/FNseEiBmhvoyebK4qZqEFbWqJ7j6lLeimoFHEzbnokBH94A==
X-Received: by 2002:a05:6808:3dc:b0:378:81c1:c615 with SMTP id o28-20020a05680803dc00b0037881c1c615mr1576268oie.27.1675186429175;
        Tue, 31 Jan 2023 09:33:49 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u22-20020a056808115600b0036718f58b7esm5921114oiu.15.2023.01.31.09.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 09:33:48 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 31 Jan 2023 09:33:47 -0800
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
Subject: Re: [PATCH 06/12] dt-bindings: watchdog: qcom-wdt: merge MSM timer
Message-ID: <20230131173347.GA3602051@roeck-us.net>
References: <20221212163532.142533-1-krzysztof.kozlowski@linaro.org>
 <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212163532.142533-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

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
