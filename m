Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC12266B284
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Jan 2023 17:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbjAOQWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Jan 2023 11:22:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjAOQWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jan 2023 11:22:16 -0500
Received: from mail.hugovil.com (mail.hugovil.com [162.243.120.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC861CC16;
        Sun, 15 Jan 2023 08:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hugovil.com
        ; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:Mime-Version:
        References:In-Reply-To:Message-Id:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8Fdnn7sKGqcviCF0H7RfsyM2qTzk8owu5NRuBUVHcw0=; b=PoLjoNpv4avvW0vvtCL7SdGJpP
        IXC2RWLhQEarrUzCb8dQjR9ZO+8LmywQ6yOSaX3oxTwrP2b5cZKsycTrru6vFGQawdwcGlldE4PcQ
        v4qwWfMEzvBgGZ8vMCrvcfecIoLWer9svYiGpK8T3x8QeaJQfm0fQPXvaNF3dK9F4AVM=;
Received: from modemcable168.174-80-70.mc.videotron.ca ([70.80.174.168]:41194 helo=pettiford)
        by mail.hugovil.com with esmtpa (Exim 4.92)
        (envelope-from <hugo@hugovil.com>)
        id 1pH5lm-0007oU-2e; Sun, 15 Jan 2023 11:22:07 -0500
Date:   Sun, 15 Jan 2023 11:22:05 -0500
From:   Hugo Villeneuve <hugo@hugovil.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     hvilleneuve@dimonoff.com, jic23@kernel.org, lars@metafoo.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-Id: <20230115112205.e46ab8d017b99dd987d003e4@hugovil.com>
In-Reply-To: <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
References: <20230113194959.3276433-1-hugo@hugovil.com>
        <20230113194959.3276433-3-hugo@hugovil.com>
        <dee8fbdc-5399-d5ce-8d01-2c48e85e2919@linaro.org>
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
Subject: Re: [PATCH v3 2/2] dt-bindings: iio: adc: add Texas Instruments
 ADS7924
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.hugovil.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Jan 2023 15:57:21 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 13/01/2023 20:49, Hugo Villeneuve wrote:
> > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > 
> > Add device tree bindings document for the Texas Instruments ADS7924
> > ADC.
> > 
> > Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > ---
> >  .../bindings/iio/adc/ti,ads7924.yaml          | 112 ++++++++++++++++++
> >  1 file changed, 112 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > new file mode 100644
> > index 000000000000..24bbf95383b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/ti,ads7924.yaml
> > @@ -0,0 +1,112 @@
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
> > +patternProperties:
> > +  "^channel@[0-3]+$":
> > +    $ref: adc.yaml
> > +
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
> > +
> > +      label:
> > +        description: |
> > +          Unique name to identify the channel.
> 
> Drop description, it's coming from adc.yaml. Just "label: true"

Done.

> > +
> > +    required:
> > +      - reg
> > +
> > +    additionalProperties: false
> 
> You are not allowing anything else from adc.yaml. Is it on purpose?

I am really not an expert with this Yaml stuff, and reading the documentation makes me probably more confused than before reading it :)

But one thing that is for sure is that these other properties in adc.yaml are not used in my driver:

  bipolar
  diff-channels
  settling-time-us
  oversampling-ratio

So is it Ok then to use "additionalProperties: false"? I think so, but what is your recommandation?

Thank you,
Hugo.


> > +
> > +additionalProperties: false
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +  - vref-supply
> > +  - "#address-cells"
> > +  - "#size-cells"
> > +
> 
> Best regards,
> Krzysztof
> 
> 


-- 
Hugo Villeneuve <hugo@hugovil.com>
