Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39009713C0F
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjE1S75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 14:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjE1S74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 14:59:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71ADDF;
        Sun, 28 May 2023 11:59:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AD09612F5;
        Sun, 28 May 2023 18:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9FCC433D2;
        Sun, 28 May 2023 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685300392;
        bh=uVZnFIlAYbGCiv6kDm5XyBN6w8irA/5nE5JqHTvr2VQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BecB0FQoemfMTi1jCf8w2crbxUrEi+1YFEESgnbcJ1FIeTTvU3eqot1w5Nd2peP3a
         GqWcREK9W1Dm+3mJ25KwjOa1HVql/7yvRJTA4wRA7yE0zLqoJDXp2BquuKzmpTYxiD
         9dmicrtfEmDlfkIKjJ2H22SNc8E2LfsKQisPH9KMUm1XVdqj1SweDaLsiVzfVkPPvg
         qcVdLV3GjEMLiXQR26ePMsO+mlspmmVjlXk5VvvEkaIuvj26iZL/bniUFiJd2Lyjt0
         FzDKGUK8t7fCodYgssLDzPRUCqgMrfWknveobDrIHaKrt7i/A9fSF1I/wWSggM9wp7
         4t4mkuzHL6v6w==
Date:   Sun, 28 May 2023 20:16:11 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Mike Looijmans <mike.looijmans@topic.nl>
Cc:     marius.cristea@microchip.com, lars@metafoo.de, robh+dt@kernel.org,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: adding MCP3564 ADC
Message-ID: <20230528201611.6abec817@jic23-huawei>
In-Reply-To: <3aa1b03c-2b1f-998c-3cbd-4fabfb436dda@topic.nl>
References: <20230519160145.44208-1-marius.cristea@microchip.com>
        <20230519160145.44208-2-marius.cristea@microchip.com>
        <3aa1b03c-2b1f-998c-3cbd-4fabfb436dda@topic.nl>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 May 2023 12:37:43 +0200
Mike Looijmans <mike.looijmans@topic.nl> wrote:

> On 19-05-2023 18:01, marius.cristea@microchip.com wrote:
> > From: Marius Cristea <marius.cristea@microchip.com>
> > 
> > This is the device tree schema for iio driver for
> > Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > Delta-Sigma ADCs with an SPI interface.
> > 
> > Signed-off-by: Marius Cristea <marius.cristea@microchip.com>
> > ---
> >   .../bindings/iio/adc/microchip,mcp3564.yaml   | 88 +++++++++++++++++++
> >   1 file changed, 88 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > new file mode 100644
> > index 000000000000..407a125e3776
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/iio/adc/microchip,mcp3564.yaml
> > @@ -0,0 +1,88 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/iio/adc/microchip,mcp3564.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Microchip MCP346X and MCP356X ADC Family
> > +
> > +maintainers:
> > +  - Marius Cristea <marius.cristea@microchip.com>
> > +
> > +description: |
> > +   Bindings for the Microchip family of 153.6 ksps, Low-Noise 16/24-Bit
> > +   Delta-Sigma ADCs with an SPI interface.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - microchip,mcp3461
> > +      - microchip,mcp3462
> > +      - microchip,mcp3464
> > +      - microchip,mcp3461r
> > +      - microchip,mcp3462r
> > +      - microchip,mcp3464r
> > +      - microchip,mcp3561
> > +      - microchip,mcp3562
> > +      - microchip,mcp3564
> > +      - microchip,mcp3561r
> > +      - microchip,mcp3562r
> > +      - microchip,mcp3564r
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  spi-max-frequency: true
> > +
> > +  spi-cpha: true
> > +
> > +  spi-cpol: true
> > +
> > +  vref-supply:
> > +    description:
> > +      Some devices have a specific reference voltage supplied on a different
> > +      pin to the other supplies. Needed to be able to establish channel scaling
> > +      unless there is also an internal reference available (e.g. mcp3564r)
> > +
> > +  microchip,hw-device-address:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    minimum: 0
> > +    maximum: 3
> > +    description:
> > +      The address is set on a per-device basis by fuses in the factory,
> > +      configured on request. If not requested, the fuses are set for 0x1.
> > +      The device address is part of the device markings to avoid
> > +      potential confusion. This address is coded on two bits, so four possible
> > +      addresses are available when multiple devices are present on the same
> > +      SPI bus with only one Chip Select line for all devices.
> > +
> > +  "#io-channel-cells":  
> 
> That's a typo, "io" should be "iio", right?

Nope.  I honestly can't remember the history behind that, but it's
just io. Probably to do with IIO being Linux specific and this needing
to be generic, but its just an educated guess.

Jonathan



