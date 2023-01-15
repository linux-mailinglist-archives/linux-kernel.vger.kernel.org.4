Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B976A66B294
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231372AbjAOQ3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:29:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbjAOQ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:29:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971CF4C13;
        Sun, 15 Jan 2023 08:29:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4EBCCB80B44;
        Sun, 15 Jan 2023 16:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57535C433D2;
        Sun, 15 Jan 2023 16:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673800189;
        bh=x59QNQkzRFydhNJ0KSrECEek2bWlpqijMNmdomWH5Rs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=IomDEpPNMCAxftMpTd92Rs6tZCiEu3jA9RDI7u/zrqXoDld/uGJ4vUDKTOtw9q2mX
         r8vlHR6FlbtnqrdPP/F+lRvAxK+1WUtoFDOwf1sPl/7OGG85ZF5hrSvpMtfFmHFFZT
         8pEV0xnIA1IMkC0OLI5bDwFkihDKWvHBIBIaBDIHSLT8F4T+IOGcUoAC7KsPyUIhEy
         EbBJkIhrXYYMqjMpvpr+yxT9jZ0Q6U6XxcNcjbw+70qP9xoUtCV+CAFEzwKTTa6lMh
         OgRihrzCJhfOlh41s53Lu7g/1jwEFh/RxazdXJG7o0cB1cRT41e3WhAp0bgnezQ44H
         9Ac0hwZtNq9XA==
Date:   Sun, 15 Jan 2023 16:43:26 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
Message-ID: <20230115164326.7f03f6d9@jic23-huawei>
In-Reply-To: <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-3-hugo@hugovil.com>
        <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
        <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Sun, 15 Jan 2023 11:22:05 -0500
Hugo Villeneuve <hugo@hugovil.com> wrote:

> On Sun, 15 Jan 2023 15:57:21 +0100
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 13/01/2023 20:49, Hugo Villeneuve wrote:  
> > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > 
> > > Add device tree bindings document for the Texas Instruments ADS7924
> > > ADC.
> > > 
> > > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > ---
> > >  .../bindings/iio/adc/ti,ads7924.yaml          | 112 ++++++++++++++++++
> > >  1 file changed, 112 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > > new file mode 100644
> > > index 000000000000..24bbf95383b4
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > > @@ -0,0 +1,112 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> > > +
> > > +maintainers:
> > > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > +
> > > +description: |
> > > +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> > > +
> > > +  Specifications:
> > > +    https://www.ti.com/lit/gpn/ads7924
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: ti,ads7924
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  vref-supply:
> > > +    description:
> > > +      The regulator supply for the ADC reference voltage (AVDD)
> > > +
> > > +  reset-gpios:
> > > +    maxItems: 1
> > > +
> > > +  interrupts:
> > > +    maxItems: 1
> > > +
> > > +  "#address-cells":
> > > +    const: 1
> > > +
> > > +  "#size-cells":
> > > +    const: 0
> > > +
> > > +  "#io-channel-cells":
> > > +    const: 1
> > > +
> > > +patternProperties:
> > > +  "^channel@[0-3]+$":
> > > +    $ref: adc.yaml
> > > +
> > > +    description: |
> > > +      Represents the external channels which are connected to the ADC.
> > > +
> > > +    properties:
> > > +      reg:
> > > +        description: |
> > > +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> > > +        items:
> > > +          - minimum: 0
> > > +            maximum: 3
> > > +
> > > +      label:
> > > +        description: |
> > > +          Unique name to identify the channel.  
> > 
> > Drop description, it's coming from adc.yaml. Just "label: true"  
> 
> Done.
> 
> > > +
> > > +    required:
> > > +      - reg
> > > +
> > > +    additionalProperties: false  
> > 
> > You are not allowing anything else from adc.yaml. Is it on purpose?  
> 
> I am really not an expert with this Yaml stuff, and reading the documentation makes me probably more confused than before reading it :)
> 
> But one thing that is for sure is that these other properties in adc.yaml are not used in my driver:
> 
>   bipolar
>   diff-channels
>   settling-time-us
>   oversampling-ratio
> 
> So is it Ok then to use "additionalProperties: false"? I think so, but what is your recommandation?

Makes sense to me.  Whilst there are lots of things a channel can support, most
of them are hardware related and not universal.

Jonathan

> 
> Thank you,
> Hugo.
> 
> 
> > > +
> > > +additionalProperties: false
> > > +
> > > +required:
> > > +  - compatible
> > > +  - reg
> > > +  - vref-supply
> > > +  - "#address-cells"
> > > +  - "#size-cells"
> > > +  
> > 
> > Best regards,
> > Krzysztof
> > 
> >   
> 
> 

