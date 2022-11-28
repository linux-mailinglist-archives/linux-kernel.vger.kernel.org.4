Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F0163A269
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbiK1IAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:00:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiK1IAI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:00:08 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A0711A3E;
        Mon, 28 Nov 2022 00:00:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B5EF61018;
        Mon, 28 Nov 2022 08:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BFB0C433C1;
        Mon, 28 Nov 2022 08:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669622402;
        bh=sSP+y58dUYdr/Ye6OLHQOoGvusu/KoVqOieYdy6sw9A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dU8AM9dy2tYGxHKw1fk6Zik0APTZu5x6iKL3BDP2vPnO+Xm9Rcr15Dp7HStEgXKPM
         4wKyn5Ghl+x4pCCmKt4BAT9RJmM2dszRnm8CkdtDf92CfPXjm5KtsSSKB2r1brXFGT
         PAeqqoZRT0AQ2TZbqM8HhRLK3mpX6lfhFjbaPbs+O57O2gfHmAqJ+HUoaPi+DcAGQd
         xBSnS0TABr23O549lTBGLHH4DabQkk9aFf5XX//X2D5Ze/Cj5RDlZxuD83Foitm0L7
         xA+TvvkzMTfYycZzFJ5TNeoP5TI8BvMMekUQV55fNJsKC5dS8WWY3DuDeLoHwe243x
         hRGKFhQ4fbxeg==
Received: by pali.im (Postfix)
        id 900AD87A; Mon, 28 Nov 2022 08:59:59 +0100 (CET)
Date:   Mon, 28 Nov 2022 08:59:59 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, brgl@bgdev.pl, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lee.jones@linaro.org,
        andrew@lunn.ch, thomas.petazzoni@free-electrons.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH v4 2/3] dt-bindings: gpio: gpio-mvebu: deprecate
 armadaxp-gpio
Message-ID: <20221128075959.3a3io5nhaizm7uxj@pali>
References: <20220526012946.3862776-1-chris.packham@alliedtelesis.co.nz>
 <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526012946.3862776-3-chris.packham@alliedtelesis.co.nz>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 May 2022 13:29:45 Chris Packham wrote:
> Commit 5f79c651e81e ("arm: mvebu: use global interrupts for GPIOs on
> Armada XP") the marvell,armadaxp-gpio compatible obsolete.

No, marvell,armadaxp-gpio is required for per-cpu interrupt support. I fixed it recently:
https://lore.kernel.org/linux-devicetree/20220714115515.5748-2-pali@kernel.org/
https://lore.kernel.org/linux-devicetree/20220714183328.4137-3-pali@kernel.org/

> The driver code still exists to handle the armadaxp behaviour but all
> the in-tree boards use the marvell,armada-370-gpio.  Document the
> marvell,armadaxp-gpio compatible as deprecated.

For per-cpu interrupt support is marvell,armadaxp-gpio needed and
therefore it cannot be deprecated.

What can be deprecated is marvell,armada-370-gpio and it can be replaced
by marvell,orion-gpio, which covers _all_ SoCs starting from the oldest
one = Orion. See discussion for more details:
https://lore.kernel.org/linux-devicetree/20220725200417.nwthxzvdv2bzd5ej@pengutronix.de/

> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
> 
> Notes:
>     This could potentially be squashed into the first commit but it seemed
>     more proper to do a straight 1:1 conversion of the old binding then
>     clean things up to match reality.
>     
>     Changes in v4:
>     - New
> 
>  .../devicetree/bindings/gpio/gpio-mvebu.yaml  | 24 +++++++------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> index d1695e7bd825..459ec35864fe 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-mvebu.yaml
> @@ -21,17 +21,21 @@ properties:
>            - enum:
>                - marvell,mv78200-gpio
>                - marvell,armada-370-gpio
> -              - marvell,armadaxp-gpio
>            - const: marvell,orion-gpio
>  
> +      - description: Deprecated binding
> +        items:
> +          - const: marvell,armadaxp-gpio
> +          - const: marvell,orion-gpio
> +        deprecated: true
> +
>    reg:
>      description: |
>        Address and length of the register set for the device. Not used for
>        marvell,armada-8k-gpio.
>  
> -      For the "marvell,armadaxp-gpio" variant a second entry is expected for
> -      the per-cpu registers. For other variants second entry can be provided,
> -      for the PWM function using the GPIO Blink Counter on/off registers.
> +      A second entry can be provided, for the PWM function using the GPIO Blink
> +      Counter on/off registers.
>      minItems: 1
>      maxItems: 2
>  
> @@ -103,18 +107,6 @@ allOf:
>        required:
>          - reg
>  
> -  - if:
> -      properties:
> -        compatible:
> -          contains:
> -            const: marvell,armadaxp-gpio
> -    then:
> -      properties:
> -        reg:
> -          minItems: 2
> -        reg-names:
> -          minItems: 2
> -
>  unevaluatedProperties: true
>  
>  examples:
> -- 
> 2.36.1
> 
