Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBE825BCCC3
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 15:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiISNRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 09:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiISNRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 09:17:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8424322296;
        Mon, 19 Sep 2022 06:17:00 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8C31C9BA;
        Mon, 19 Sep 2022 15:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663593418;
        bh=71F5KpgKduHF4LiWxCxD2paonkF4Ns+cMuHk7M7pdVU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AgfeBRhHiNP0CXcuzerKIcvFEOvNaiDSVPpnziwJb1mqSYrxqx7HHdviMdXFY4oqn
         kXWtItrJ6JjCYGoTGQWWm2vu8WrVqLl77eF45qenwK8WRye8rpRVRl/CQVgLq8XRzV
         /iP3lDgofg1yKTyPQZsxRGPSLpajpKlyRPjKuNTc=
Date:   Mon, 19 Sep 2022 16:16:45 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Mikhail Rudenko <mike.rudenko@gmail.com>
Cc:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Arec Kao <arec.kao@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Daniel Scally <djrscally@gmail.com>,
        Jimmy Su <jimmy.su@intel.com>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 1/2] media: dt-bindings: media: i2c: document OV4689
 DT bindings
Message-ID: <Yyhrva5VH3ERgI8L@pendragon.ideasonboard.com>
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-2-mike.rudenko@gmail.com>
 <20220913140553.GA2735@tom-ThinkPad-T14s-Gen-2i>
 <87sfkspa6b.fsf@gmail.com>
 <20220916131544.GA2701@tom-ThinkPad-T14s-Gen-2i>
 <871qsbph75.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <871qsbph75.fsf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CC'ing Liam and Mark.

On Fri, Sep 16, 2022 at 04:42:25PM +0300, Mikhail Rudenko wrote:
> On 2022-09-16 at 15:15 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> > On Thu, Sep 15, 2022 at 11:11:57PM +0300, Mikhail Rudenko wrote:
> >> On 2022-09-13 at 16:05 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> >> > On Sun, Sep 11, 2022 at 11:01:34PM +0300, Mikhail Rudenko wrote:
> >> >> Add device-tree binding documentation for OV4689 image sensor driver,
> >> >> and the relevant MAINTAINERS entries.
> >> >>
> >> >> Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
> >> >> ---
> >> >>  .../bindings/media/i2c/ovti,ov4689.yaml       | 141 ++++++++++++++++++
> >> >>  MAINTAINERS                                   |   7 +
> >> >>  2 files changed, 148 insertions(+)
> >> >>  create mode 100644 Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >> >>
> >> >> diff --git a/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >> >> new file mode 100644
> >> >> index 000000000000..376330b5572a
> >> >> --- /dev/null
> >> >> +++ b/Documentation/devicetree/bindings/media/i2c/ovti,ov4689.yaml
> >> >> @@ -0,0 +1,141 @@
> >> >> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> >> >> +%YAML 1.2
> >> >> +---
> >> >> +$id: http://devicetree.org/schemas/media/i2c/ovti,ov4689.yaml#
> >> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> >> +
> >> >> +title: Omnivision OV4689 CMOS
> >> >> +
> >> >> +maintainers:
> >> >> +  - Mikhail Rudenko <mike.rudenko@gmail.com>
> >> >> +
> >> >> +description: |
> >> >> +  The Omnivision OV4689 is a high performance, 1/3-inch, 4 megapixel
> >> >> +  image sensor. Ihis chip supports high frame rate speeds up to 90 fps
> >> >> +  at 2688x1520 resolution. It is programmable through an I2C
> >> >> +  interface, and sensor output is sent via 1/2/4 lane MIPI CSI-2
> >> >> +  connection.
> >> >> +
> >> >> +allOf:
> >> >> +  - $ref: /schemas/media/video-interface-devices.yaml#
> >> >> +
> >> >> +properties:
> >> >> +  compatible:
> >> >> +    const: ovti,ov4689
> >> >> +
> >> >> +  reg:
> >> >> +    maxItems: 1
> >> >> +
> >> >> +  clocks:
> >> >> +    description:
> >> >> +      External clock (XVCLK) for the sensor, 6-64 MHz
> >> >> +    maxItems: 1
> >> >> +
> >> >> +  clock-names: true
> >> >> +
> >> >> +  dovdd-supply:
> >> >> +    description:
> >> >> +      Digital I/O voltage supply, 1.7-3.0 V
> >> >> +
> >> >> +  avdd-supply:
> >> >> +    description:
> >> >> +      Analog voltage supply, 2.6-3.0 V
> >> >> +
> >> >> +  dvdd-supply:
> >> >> +    description:
> >> >> +      Digital core voltage supply, 1.1-1.3 V
> >> >> +
> >> >> +  powerdown-gpios:
> >> >> +    maxItems: 1
> >> >> +    description:
> >> >> +      GPIO connected to the powerdown pin (active low)
> >> >> +
> >> >> +  reset-gpios:
> >> >> +    maxItems: 1
> >> >> +    description:
> >> >> +      GPIO connected to the reset pin (active low)
> >> >> +
> >> >> +  orientation: true
> >> >> +
> >> >> +  rotation: true
> >> >> +
> >> >> +  port:
> >> >> +    $ref: /schemas/graph.yaml#/$defs/port-base
> >> >> +    additionalProperties: false
> >> >> +    description:
> >> >> +      Output port node, single endpoint describing the CSI-2 transmitter
> >> >> +
> >> >> +    properties:
> >> >> +      endpoint:
> >> >> +        $ref: /schemas/media/video-interfaces.yaml#
> >> >> +        unevaluatedProperties: false
> >> >> +
> >> >> +        properties:
> >> >> +          data-lanes:
> >> >> +            oneOf:
> >> >> +              - items:
> >> >> +                  - const: 1
> >> >> +                  - const: 2
> >> >> +                  - const: 3
> >> >> +                  - const: 4
> >> >> +              - items:
> >> >> +                  - const: 1
> >> >> +                  - const: 2
> >> >> +              - items:
> >> >> +                  - const: 1
> >> >> +          link-frequencies: true
> >> >> +
> >> >> +        required:
> >> >> +          - data-lanes
> >> >> +          - link-frequencies
> >> >> +
> >> >> +required:
> >> >> +  - compatible
> >> >> +  - reg
> >> >> +  - clocks
> >> >> +  - clock-names
> >> >> +  - dovdd-supply
> >> >> +  - avdd-supply
> >> >> +  - dvdd-supply
> >> >> +  - powerdown-gpios
> >> >> +  - reset-gpios
> >> >> +  - port
> >> >
> >> > I think we don't need all of these entries as required.
> >> > The only let me say "really" required are:
> >> >
> >> > - compatible
> >> > - reg
> >> > - clocks
> >> > - port
> >>
> >> Thanks for the review! I agree that the driver may be modified to work
> >> without powerdown and reset gpios and they are not required for sensor
> >> operation. On contrary, supplies are obviously required. Of course, linux
> >> provides dummy regulators if supplies are missing from device tree, but
> >> I though the intention was to document hardware, not implementation
> >> details. What do think of this?
> >
> > We have already discuss on this on the following thread sometimes ago :)
> >
> > https://www.patchwork.linux-fancy.com/project/linux-fancy/patch/20220630134835.592521-6-tommaso.merciai@amarulasolutions.com/
> >
> > Take a look and let me know.
> 
> Okay, if there already is a consensus regarding this matter, I'll make
> the regulators optional in v3.

I always request the opposite during reviews :-)

Could we get an authoritative answer from the maintainers of the
regulator framework on this question, and document it somewhere ?

-- 
Regards,

Laurent Pinchart
