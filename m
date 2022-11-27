Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71F0639C00
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 18:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiK0R3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 12:29:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiK0R3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 12:29:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A1A64E4;
        Sun, 27 Nov 2022 09:29:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB1E660DEC;
        Sun, 27 Nov 2022 17:29:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC0ADC433D6;
        Sun, 27 Nov 2022 17:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669570182;
        bh=1lnyMvrmbejuHK3k8rTbRFgf4LT4gk93GyeS33pk2Os=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nKAVZNkv1s2lQmBocf9e3J1zNamW+5vHQDr9kmxigTWdvjuMqa+9Niv1e69RHv6A5
         bxf6HZfiA1fqvUFugo7hOmGtlHpqKbKLHJds5Jve8RQ3TUMzY7NF77220y6xkeNzwi
         x+1jejPh5o2YkjXrZ2LYmcjD8fp0aOWRenUjovdCwujqLN3VDSU7Kx4gDxrgd5BWTe
         vZ36wXKmALTJF0xY0P3f+q4iMrweqq62Rfg+o4XIsRqOW71XArAOooIW2CCIxD+7zg
         MT9C/T9m7Sr7EPPeX6ItQWPvleMTQ2g8dpDBsrZqRC11syThnD9ErS9wu7BqcxmFoz
         1kias5efhGb4Q==
Date:   Sun, 27 Nov 2022 17:42:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: adc: ti,adc081c: Document the binding
Message-ID: <20221127174219.34d0406c@jic23-huawei>
In-Reply-To: <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
References: <20221125220903.8632-1-samuel@sholland.org>
        <e4be94a3-cdfc-cdf8-5d69-0eef480033f9@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Nov 2022 13:51:19 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 25/11/2022 23:09, Samuel Holland wrote:
> > Linux has a driver for these ADCs at drivers/iio/adc/ti-adc081c.c, but
> > the compatible strings were undocumented. Add a binding for them. The
> > hardware has an alert interrupt output, but existing ti,adc081c users
> > do not provide the 'interrupts' property, so leave it as optional.
> > 
> > Signed-off-by: Samuel Holland <samuel@sholland.org>
> > ---
> > 
> >  .../bindings/iio/adc/ti,adc081c.yaml          | 55 +++++++++++++++++++
> >  1 file changed, 55 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> > new file mode 100644
> > index 000000000000..caaad777580c
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,adc081c.yaml
> > @@ -0,0 +1,55 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,adc081c.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI Single-channel I2C ADCs
> > +
> > +maintainers:
> > +  - Jonathan Cameron <jic23@kernel.org>
> > +  - Lars-Peter Clausen <lars@metafoo.de>
> > +
> > +description: |
> > +  Single-channel ADC supporting 8, 10, or 12-bit samples and high/low alerts.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - ti,adc081c
> > +      - ti,adc101c
> > +      - ti,adc121c
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      Regulator for the combined power supply and voltage reference
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg  
> 
> Why not requiring io-channel-cells? If it is an IIO ADC provider, you
> need the cells, right?

Only if anyone is using it as a provider.  If it's purely being used via
IIO then there are no consumers registered.

So historically I've left it up to those defining the binding to decide if
they think #io-channel-cells should be required or optional.

It gets a bit non obvious with some of the more complex special ADCs on whether
they will ever be consumed.  This one is generic, so quite likely it will be.

Jonathan

> 
> Best regards,
> Krzysztof
> 

