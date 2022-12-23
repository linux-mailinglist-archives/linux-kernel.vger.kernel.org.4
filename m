Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8A86553D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 20:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232148AbiLWTYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 14:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232463AbiLWTYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 14:24:35 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBCB1FF9D;
        Fri, 23 Dec 2022 11:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=GpiRGOqycih7gHtk9sdXXKqEWZsp6P4vk6+7hqHyIGk=; b=nWYwtKMEonf0UMyQeaA604HFz8
        NXSb8jrbmEOZ5VBiidmNKOJ9/Let48SezDUcRaPvIRn1T9/ZeJd8uaFEuK2uxIpbL3S58wmpdUvGQ
        lMgRExNgXpIEl/T0Xs3cMW1q3EnPzuud1Aug6ArOc/a1pHyog2kYfkRB09Gnbln5ViwE=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:49008 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1p8nec-0004IE-L2; Fri, 23 Dec 2022 14:24:27 -0500
Date:   Fri, 23 Dec 2022 14:24:26 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     hvilleneuve@dimonoff.com, lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <20221223142426.fc43c5fe36d946e47c7bcfae@hugovil.com>
In-Reply-To: <20221223145013.68f7344a@jic23-huawei>
References: <20221222203610.2571287-1-hugo@hugovil.com>
        <20221222203610.2571287-4-hugo@hugovil.com>
        <20221223145013.68f7344a@jic23-huawei>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 70.80.174.168
X-SA-Exim-Mail-From: hugo@hugovil.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v1 3/3] dt-bindings: iio: adc: add ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Dec 2022 14:50:13 +0000
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu, 22 Dec 2022 15:36:10 -0500
> Hugo Villeneuve <hugo@hugovil.com> wrote:
> 
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add device tree bindings document for the Texas Instruments ADS7924
> > ADC.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> Hi Hugo,
> 
> Whilst you aren't using it yet, the binding should still attempt to be
> a full description of the hardware, so I'd expect the interrupt line to
> be part of it.
> 
> Otherwise, Krzysztof already covered this in detail.

Ok, makes sense. Added.

Hugo.

 > Jonathan
> 
> 
> > ---
> >  .../bindings/iio/adc/ti,ads7924.yaml          | 103 ++++++++++++++++++
> >  1 file changed, 103 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > new file mode 100644
> > index 000000000000..5408ec95e417
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > @@ -0,0 +1,103 @@
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
> > +  vref-supply:
> > +    description:
> > +      The regulator supply for the ADC reference voltage (AVDD)
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  reset-gpios:
> > +    description:
> > +      GPIO used for controlling the reset pin
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
> > +additionalProperties: false
> > +
> > +patternProperties:
> > +  "^channel@[0-3]+$":
> > +    type: object
> > +    description:
> > +      Child nodes needed for each channel that the platform uses.
> > +
> > +    properties:
> > +      reg:
> > +        description: |
> > +          0: Voltage over AIN0 and GND.
> > +          1: Voltage over AIN1 and GND.
> > +          2: Voltage over AIN2 and GND.
> > +          3: Voltage over AIN3 and GND.
> > +        items:
> > +          - minimum: 0
> > +            maximum: 3
> > +
> > +    required:
> > +      - reg
> > +
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
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +            channel@0 {
> > +              reg = <0>;
> > +              label = "CH0";
> > +            };
> > +            channel@1 {
> > +              reg = <1>;
> > +              label = "CH1";
> > +            };
> > +            channel@2 {
> > +              reg = <2>;
> > +              label = "CH2";
> > +            };
> > +            channel@3 {
> > +              reg = <3>;
> > +              label = "CH3";
> > +            };
> > +        };
> > +    };
> > +...
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
