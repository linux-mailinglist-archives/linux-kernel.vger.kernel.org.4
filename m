Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BA8742BAC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjF2R7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231933AbjF2R7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:59:43 -0400
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFD18E49;
        Thu, 29 Jun 2023 10:59:42 -0700 (PDT)
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-345a4efb66dso4157185ab.3;
        Thu, 29 Jun 2023 10:59:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061582; x=1690653582;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ltsj44Ysm9Ir8gMsSRtpiAJhqVybd6I1k73Eyk2Y9bo=;
        b=I5SXYCSC86iwt1piBpyaxfkw3bk8qDP8pjvZ1Tv3tsBNmYnkQecQsS/N5n0IJKDwuJ
         GBe9qdkESGt2RK1APvYDYxBAUm4rx4Pn6XT58Q6Tm58oVxdcUO/DGvgM3M40l9Gaozs0
         k/b0K/erbMeObHizbq4PRpJkwQfkgHukHi1KQCIDFL9QTYpdbbLaUHg9VqUvWAbUn7oY
         /x+1n5pwH19kRf41AUhomXkEybso3Jz3HxK4bcprKswaep25xQzaik/EgNXQTMCRx810
         kxbLYb04IpX6EaU+bAmOnFyv6op2+1NwASKGxinZ5Fx0q2ZWzE3FlB3dLOFq7w/iUTU8
         SoPw==
X-Gm-Message-State: AC+VfDyAF+O5Lkb4zq/9SHKTdS1lj52ApNT5ShMZCDE6QoBbOzQoKIM8
        SEohjpwsIL7a4CNTJ5bGYA==
X-Google-Smtp-Source: ACHHUZ54eMsTJJWCtPoEJIejljl2L1fgaKzjT7pk8sgNMmOGvqHqFhQZWVJA6mYIXW00z9Mh2DfH2g==
X-Received: by 2002:a92:c742:0:b0:345:b35e:38ce with SMTP id y2-20020a92c742000000b00345b35e38cemr10456290ilp.31.1688061581994;
        Thu, 29 Jun 2023 10:59:41 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id o5-20020a92c685000000b00342612c48f6sm4187871ilg.53.2023.06.29.10.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:59:41 -0700 (PDT)
Received: (nullmailer pid 3269993 invoked by uid 1000);
        Thu, 29 Jun 2023 17:59:39 -0000
Date:   Thu, 29 Jun 2023 11:59:39 -0600
From:   Rob Herring <robh@kernel.org>
To:     Astrid Rost <astrid.rost@axis.com>
Cc:     Dan Murphy <dmurphy@ti.com>, Andrew Davis <afd@ti.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, kernel@axis.com,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] dt: bindings: lp50xx: Add max-brightness as in
 leds-pwm
Message-ID: <20230629175939.GA3260807-robh@kernel.org>
References: <20230629134722.3908637-1-astrid.rost@axis.com>
 <20230629134722.3908637-3-astrid.rost@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629134722.3908637-3-astrid.rost@axis.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 29, 2023 at 03:47:22PM +0200, Astrid Rost wrote:
> Add max-brightness in order to reduce the current on the connected LEDs.
> Normally, the maximum brightness is determined by the hardware, and this
> property is not required. This property is used to set a software limit.
> It could happen that an LED is made so bright that it gets damaged or
> causes damage due to restrictions in a specific system, such as mounting
> conditions.
> 
> Signed-off-by: Astrid Rost <astrid.rost@axis.com>
> ---
>  Documentation/devicetree/bindings/leds/leds-lp50xx.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> index 402c25424525..6a1425969cb4 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp50xx.yaml
> @@ -73,6 +73,15 @@ patternProperties:
>        '#size-cells':
>          const: 0
>  
> +      max-brightness:
> +        description:
> +          Normally, the maximum brightness is determined by the hardware, and
> +          this property is not required. This property is used to set a software
> +          limit. It could happen that an LED is made so bright that it gets
> +          damaged or causes damage due to restrictions in a specific system,
> +          such as mounting conditions.
> +        $ref: /schemas/types.yaml#definitions/uint32

We already have led-max-microamp. If this h/w works by controlling the 
current, then that is what you should use. "max-brightness" makes more 
sense for PWM based control.

If you do end up keeping this, it belongs in the 'led' nodes not the 
controller as brightness is a property of the LED, not the LED 
driver(controller). And it should be in common schema rather than 
defining the type yet again.

Rob
