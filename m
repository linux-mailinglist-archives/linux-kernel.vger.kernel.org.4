Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED45F666F2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235861AbjALKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:12:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjALKL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:11:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A2A2E6;
        Thu, 12 Jan 2023 02:11:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 20D2161FCC;
        Thu, 12 Jan 2023 10:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFF3AC433D2;
        Thu, 12 Jan 2023 10:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673518259;
        bh=jHnN5TpjDsuEmpEXoiNJ8vZOnsWHRV/v7Jjf9zxez+c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=TGVnq9Iqk9wH7rfxSRBa4J2HpxstIG4Z5WKyITO+s65XJkUX/avf0hrFttJytcQON
         ZHhnQbJFrndso01+aTlXR4YwkIyCq9ld+l/ujWp5YpecmleYso4IHCoZ+r0182gAWZ
         ZlKPeren892boP6XKvRxWMt+5TpjaW/y4MYJKPk7EVWIXzaPGjg2BDW66qfLKBrwIC
         5zNO9PJ8laBGAWwAHUvx2uqu+EV0Qc2P4PiIEV+eYh9J9QRqzmD6rnZr0gOVsUOcR2
         DXZeyGRn11V4+P8Tmz8nS5HuqC6NNqKOqC5FoddN9ZPljiX7QSbKgVGOHlQx/KcFU+
         +myzC5Gn5/zTw==
Message-ID: <06144828-d1c4-7423-81e3-9c35df996da7@kernel.org>
Date:   Thu, 12 Jan 2023 11:10:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [LINUX PATCH 2/3] dt-bindings: timer: Update device tree bindings
 for cadence TTC PWM
To:     Mubin Sayyed <mubin.sayyed@amd.com>, robh+dt@kernel.org,
        treding@nvidia.com, u.kleine-koenig@pengutronix.de,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, git@amd.com, michal.simek@amd.com,
        siva.durga.prasad.paladugu@amd.com, mubin10@gmail.com
References: <20230112071526.3035949-1-mubin.sayyed@amd.com>
 <20230112071526.3035949-3-mubin.sayyed@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230112071526.3035949-3-mubin.sayyed@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2023 08:15, Mubin Sayyed wrote:
> Cadence TTC can act as PWM device, it is supported through

Subject: drop second/last, redundant "device tree bindings". The
"dt-bindings" prefix is already stating that these are bindings.

Anyway subject is poor - every commit is an "update", so basically you
said there nothing...

> separate PWM framework based driver. Decision to configure
> specific TTC device as PWM or clocksource/clockevent would
> be done based on presence of "#pwm-cells" property.
> 
> Also, interrupt property is not required for TTC PWM driver.
> Updated bindings to support TTC PWM configuration.

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> Signed-off-by: Mubin Sayyed <mubin.sayyed@amd.com>
> ---
>  .../devicetree/bindings/timer/cdns,ttc.yaml   | 25 ++++++++++++++++++-
>  1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
> index 7d821fd480f6..2855e92e02e3 100644
> --- a/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
> +++ b/Documentation/devicetree/bindings/timer/cdns,ttc.yaml
> @@ -32,12 +32,26 @@ properties:
>      description: |
>        Bit width of the timer, necessary if not 16.
>  
> +  "#pwm-cells":
> +    description: |
> +      Required to configure TTC as PWM device, supported cells are 0 to 3.
> +    minimum: 0
> +    maximum: 3

Better make it const. What's the benefit of flexible cells? You also
should describe the arguments.

> +
>  required:
>    - compatible
>    - reg
> -  - interrupts
>    - clocks
>  
> +allOf:
> +  - if:
> +      not:
> +        required:
> +          - "#pwm-cells"
> +    then:
> +      required:
> +        - interrupts
> +
>  additionalProperties: false
>  
>  examples:
> @@ -50,3 +64,12 @@ examples:
>          clocks = <&cpu_clk 3>;
>          timer-width = <32>;
>      };
> +
> +  - |
> +    ttc1: ttc1@f8002000 {

Node names should be generic.
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

> +        compatible = "cdns,ttc";
> +        reg = <0xF8002000 0x1000>;

lowercase hex

> +        clocks = <&cpu_clk 3>;
> +        timer-width = <32>;
> +        #pwm-cells = <3>;
> +    };

Best regards,
Krzysztof

