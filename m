Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB7C66676F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:12:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbjALAME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:12:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232976AbjALAMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:12:02 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5FECE5;
        Wed, 11 Jan 2023 16:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IiccliQ9sg52wgIYwzh81XmHZehDOJW3bQRXQyUG31c=; b=QodVhJ2nMZ/ug7UFYKDhWNlwk5
        GolN++Au4FJnc4qv6O4+05m4PQpwUNA3yPCA8DJvLZZZ9vtEAOt9hPrrg6iaXEckx/k8Jpx8k8VhV
        +BJAWNtQBxYiOx3/EJe5s1ZGTs1XC+d8HwQov4qtJBtnT7+XmViuhcmQdfw3b1btbGvQ=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41172 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pFlCC-0001QI-3M; Wed, 11 Jan 2023 19:11:52 -0500
Date:   Wed, 11 Jan 2023 19:11:52 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230111191152.fd5e46921b45f966bc5b5ffa@hugovil.com>
In-Reply-To: <714ec9f7-486b-b06f-f070-27c6db19ba3e@linaro.org>
References: <20230110160124.3853593-1-hugo@hugovil.com>
        <20230110160124.3853593-3-hugo@hugovil.com>
        <714ec9f7-486b-b06f-f070-27c6db19ba3e@linaro.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v2 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2023 10:23:20 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 10/01/2023 17:01, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add device tree bindings document for the Texas Instruments ADS7924
> > ADC.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Please test the bindings before sending. It's better to use tools for
> review than humans... we are all quite busy.

Hi,
will do from now on.

> > ---
> >  .../bindings/iio/adc/ti,ads7924.yaml          | 104 ++++++++++++++++++
> >  1 file changed, 104 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > new file mode 100644
> > index 000000000000..a9d3e8778d11
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > @@ -0,0 +1,104 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/ti,ads7924.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: TI ADS7924 4 channels 12 bits I2C analog to digital converter
> > +
> > +maintainers:
> > +  - Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > +
> > +description: |
> > +  Texas Instruments ADS7924 4 channels 12 bits I2C analog to digital converter
> > +
> > +  Specifications:
> > +    https://www.ti.com/lit/gpn/ads7924
> > +
> > +properties:
> > +  compatible:
> > +    const: ti,ads7924
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  vref-supply:
> > +    description:
> > +      The regulator supply for the ADC reference voltage (AVDD)
> > +
> > +  reset-gpios:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  "#io-channel-cells":
> > +    const: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> > +patternProperties:
> 
> Put it before "required:" block.

Done.

> 
> > +  "^channel@[0-3]+$":
> > +    $ref: "adc.yaml"
> 
> Drop quotes.

Done.

> 
> > +    type: object
> > +    description: |
> > +      Represents the external channels which are connected to the ADC.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          The channel number. It can have up to 4 channels numbered from 0 to 3.
> > +        items:
> > +          - minimum: 0
> > +            maximum: 3
> 
> Test your bindings, so you will see error here of missing label: true.

Added label.

> 
> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> > +
> 
> Missing additionalProperties: false.

Added.

> 
> > +examples:
> > +  - |
> > +    i2c {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        adc@48 {
> > +            compatible = "ti,ads7924";
> > +            reg = <0x48>;
> > +            vref-supply = <&ads7924_reg>;
> > +            reset-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
> > +            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
> > +            interrupt-parent = <&gpio>;
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            channel@0 {
> > +                reg = <0>;
> > +                label = "CH0";
> > +            };
> > +            channel@1 {
> > +                reg = <1>;
> > +                label = "CH1";
> > +            };
> > +            channel@2 {
> > +                reg = <2>;
> > +                label = "CH2";
> > +            };
> > +            channel@3 {
> > +                reg = <3>;
> > +                label = "CH3";
> > +            };
> > +        };
> > +    };
> > +...
> 
> Best regards,
> Krzysztof


-- 
Hugo Villeneuve <hugo@hugovil.com>
