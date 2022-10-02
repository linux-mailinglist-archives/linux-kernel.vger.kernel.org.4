Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B2D5F2348
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 15:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbiJBNGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 09:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJBNGl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 09:06:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08440BEB;
        Sun,  2 Oct 2022 06:06:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04D56B80113;
        Sun,  2 Oct 2022 13:06:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB26C433C1;
        Sun,  2 Oct 2022 13:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664715997;
        bh=MSWAo/N6NpSywv+a8FzF1/ozUpCIoiEiuZ35DlUAvZk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XIX9/hzHJ8Bw7pskYpDnJn5un08QyZt81y7k1j3c8wyLDZBLEeHqelQLfeugxjntW
         WqfEpLFlux001md0TroFqbYXyutZPOWJKZgaAKrrYkOJsPoyViorTnsEMDsKvBU55B
         HBXnocRlL+FhJin9u/zB8uwlb88M7p2EYHyCu757KgdKrVKQG/b8yYIgMhxLxyoWXE
         Z8sb96+BqEWz2uM2HXjtDTUtapR8c1cjay4ZvYmwvAmQ5xVJEJHbvaJL+vvA6D6MAA
         fDkQ26eF65usJjxGfNmkZsNzpt3BDri7Ay2gwh0DqzbUGZhWi+w4aMvvqV6hEvkbOk
         lQePbsZFGqYUA==
Date:   Sun, 2 Oct 2022 14:06:52 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org
Cc:     Ibrahim Tilki <Ibrahim.Tilki@analog.com>, Nuno.Sa@analog.com,
        Nurettin.Bolucu@analog.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/3] dt-bindings: iio: adc: add adi,max11410.yaml
Message-ID: <20221002140652.1d51109a@jic23-huawei>
In-Reply-To: <a382fdee-3672-50b8-cd58-85563b9d9079@linaro.org>
References: <20220927141851.279-1-Ibrahim.Tilki@analog.com>
        <20220927141851.279-3-Ibrahim.Tilki@analog.com>
        <a382fdee-3672-50b8-cd58-85563b9d9079@linaro.org>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Thu, 29 Sep 2022 11:35:10 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 27/09/2022 16:18, Ibrahim Tilki wrote:
> > Adding devicetree binding documentation for max11410 adc.
> > 
> > Signed-off-by: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > ---
> >  .../bindings/iio/adc/adi,max11410.yaml        | 176 ++++++++++++++++
> >  .../devicetree/bindings/rtc/adi,max313xx.yaml | 195 ++++++++++++++++++
> >  2 files changed, 371 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> >  create mode 100644 Documentation/devicetree/bindings/rtc/adi,max313xx.yaml
> >   
> 
> So it is a v6 and it is the first version you send to proper maintainers
> using get_maintainers.pl... sigh...

I only noticed the missing cc on v5 - wasn't paying attention to the binding
as lots of stuff in the driver...

However, how did this pick up an rtc binding for a totally different part?


> 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > new file mode 100644
> > index 0000000000..46a37303da
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/adi,max11410.yaml
> > @@ -0,0 +1,176 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright 2022 Analog Devices Inc.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/adi,max11410.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Analog Devices MAX11410 ADC device driver
> > +
> > +maintainers:
> > +  - Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> > +
> > +description: |
> > +  Bindings for the Analog Devices MAX11410 ADC device. Datasheet can be
> > +  found here:
> > +    https://datasheets.maximintegrated.com/en/ds/MAX11410.pdf
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - adi,max11410
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    minItems: 1
> > +    maxItems: 2
> > +
> > +  interrupt-names:
> > +    description: Name of the gpio pin of max11410 used for IRQ
> > +    items:
> > +      - enum:
> > +          - gpio0
> > +          - gpio1  
> 
> This is wrong. You said in interrupts you can have two items, but here
> you list only one. I don't know what do you want to achieve here.

Aim is 0, 1 or 2 interrupts + knowing which ones they are.
Device has two pins that have very similar functionality and board
designers are likely to pick one or the two more or less at random depending
on which trace is easier to route.

So my guess is this needs minItems, maxItems.


> 
> > +
> > +  '#address-cells':
> > +    const: 1
> > +
> > +  '#size-cells':
> > +    const: 0
> > +
> > +  avdd-supply:
> > +    description: Optional avdd supply. Used as reference when no explicit reference supplied.
> > +
> > +  vref0p-supply:
> > +    description: vref0p supply can be used as reference for conversion.
> > +
> > +  vref1p-supply:
> > +    description: vref1p supply can be used as reference for conversion.
> > +
> > +  vref2p-supply:
> > +    description: vref2p supply can be used as reference for conversion.
> > +
> > +  vref0n-supply:
> > +    description: vref0n supply can be used as reference for conversion.
> > +
> > +  vref1n-supply:
> > +    description: vref1n supply can be used as reference for conversion.
> > +
> > +  vref2n-supply:
> > +    description: vref2n supply can be used as reference for conversion.
> > +
> > +  spi-max-frequency:
> > +    maximum: 8000000
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +patternProperties:  
> 
> This goes before required block
> 
> > +  "^channel(@[0-9])?$":
> > +    $ref: "adc.yaml"
> > +    type: object
> > +    description: Represents the external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: The channel number in single-ended mode.
> > +        minimum: 0
> > +        maximum: 9
> > +
> > +      adi,reference:
> > +        description: |
> > +          Select the reference source to use when converting on
> > +          the specific channel. Valid values are:
> > +          0: VREF0P/VREF0N
> > +          1: VREF1P/VREF1N
> > +          2: VREF2P/VREF2N
> > +          3: AVDD/AGND
> > +          4: VREF0P/AGND
> > +          5: VREF1P/AGND
> > +          6: VREF2P/AGND
> > +          If this field is left empty, AVDD/AGND is selected.
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2, 3, 4, 5, 6]
> > +        default: 3
> > +
> > +      adi,input-mode:
> > +        description: |
> > +          Select signal path of input channels. Valid values are:
> > +          0: Buffered, low-power, unity-gain path (default)
> > +          1: Bypass path
> > +          2: PGA path
> > +        $ref: /schemas/types.yaml#/definitions/uint32
> > +        enum: [0, 1, 2]
> > +        default: 0
> > +
> > +      diff-channels: true
> > +
> > +      bipolar: true
> > +
> > +      settling-time-us: true
> > +
> > +      adi,buffered-vrefp:
> > +        description: Enable buffered mode for positive reference.
> > +        type: boolean
> > +
> > +      adi,buffered-vrefn:
> > +        description: Enable buffered mode for negative reference.
> > +        type: boolean
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> > +allOf:
> > +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> > +
> > +unevaluatedProperties: false
> > +
> > +examples:
> > +  - |
> > +    spi {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@0 {
> > +            reg = <0>;
> > +            compatible = "adi,max11410";
> > +            spi-max-frequency = <8000000>;
> > +
> > +            interrupt-parent = <&gpio>;
> > +            interrupts = <25 2>;
> > +            interrupt-names = "gpio1";
> > +
> > +            avdd-supply = <&adc_avdd>;
> > +
> > +            vref1p-supply = <&adc_vref1p>;
> > +            vref1n-supply = <&adc_vref1n>;
> > +
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            channel@0 {
> > +                reg = <0>;
> > +            };
> > +
> > +            channel@1 {
> > +                reg = <1>;
> > +                diff-channels = <2 3>;
> > +                adi,reference = <1>;
> > +                bipolar;
> > +                settling-time-us = <100000>;
> > +            };
> > +
> > +            channel@2 {
> > +                reg = <2>;
> > +                diff-channels = <7 9>;
> > +                adi,reference = <5>;
> > +                adi,input-mode = <2>;
> > +                settling-time-us = <50000>;
> > +            };
> > +        };
> > +    };
