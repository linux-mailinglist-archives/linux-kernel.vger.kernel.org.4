Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED0A5BC9AA
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiISKnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiISKnO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:43:14 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4454D33E00;
        Mon, 19 Sep 2022 03:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663583131; x=1695119131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Q3k5NxbdpA9DLEGbySGsywAVLtIr0421Jxutctvx2NE=;
  b=AwkIXiU/4V0FClIQ7SFK42LAli8Du1LNfCfUXAFDO5MoS7Z8ZVkjrH0r
   X6x5ebJVg1FLw2zNtsmwhG0NttSATaRs2B8N5MRxrm71bGdSrRS0gGIHD
   tEkpVE6+6We0MO6mxI5VR1UwH0tW5+Rpfvu1tB+XTIwmL5QirCDA8RY0t
   6pNrLzp/VOhTnFTXXkVIbIYBe9Bptn8LYMmxPH3hh45Exy8UhPTXjWcZ7
   hoJq21OQvUx2q25B+vcOPVdaWjjPrb53JPBQ/QJj7i/z03sCbBmrgZ+qH
   7d7V3Cp/n7VqX5IpAA4uPgmihxhIdhbT56R9hI5Ua/Yg428iZo0VTJVaN
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10474"; a="282388556"
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="282388556"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 03:24:01 -0700
X-IronPort-AV: E=Sophos;i="5.93,327,1654585200"; 
   d="scan'208";a="618436710"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2022 03:23:57 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with ESMTP id 94F3B202D2;
        Mon, 19 Sep 2022 13:23:55 +0300 (EEST)
Date:   Mon, 19 Sep 2022 10:23:55 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, kishon@ti.com, vkoul@kernel.org,
        hverkuil@xs4all.nl, jacopo@jmondi.org,
        kieran.bingham+renesas@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        kernel@pengutronix.de
Subject: Re: [PATCH v2 3/4] media: dt-bindings: add bindings for Toshiba
 TC358746
Message-ID: <YyhDO4ohv47uIij2@paasikivi.fi.intel.com>
References: <20220916134535.128131-1-m.felsch@pengutronix.de>
 <20220916134535.128131-4-m.felsch@pengutronix.de>
 <YyZTCsflWtUbo2ld@pendragon.ideasonboard.com>
 <20220919100844.bb7tzbql2vpk76xz@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220919100844.bb7tzbql2vpk76xz@pengutronix.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Mon, Sep 19, 2022 at 12:08:44PM +0200, Marco Felsch wrote:
> Hi Laurent,
> 
> On 22-09-18, Laurent Pinchart wrote:
> > Hi Marco,
> > 
> > Thank you for the patch.
> > 
> > On Fri, Sep 16, 2022 at 03:45:34PM +0200, Marco Felsch wrote:
> > > Add the bindings for the Toshiba TC358746 Parallel <-> MIPI-CSI bridge
> > > driver.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > > Changelog:
> > > 
> > > v2:
> > > - addded Robs r-b
> > > - s/than/then/
> > > - added hsync/vsync/bus-type, make hsync/vsync required
> > > - fix example indent
> > > 
> > >  .../bindings/media/i2c/toshiba,tc358746.yaml  | 179 ++++++++++++++++++
> > >  1 file changed, 179 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > new file mode 100644
> > > index 000000000000..1fa574400bc2
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/media/i2c/toshiba,tc358746.yaml
> > > @@ -0,0 +1,179 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/media/i2c/toshiba,tc358746.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Toshiba TC358746 Parallel to MIPI CSI2 Bridge
> > > +
> > > +maintainers:
> > > +  - Marco Felsch <kernel@pengutronix.de>
> > > +
> > > +description: |-
> > > +  The Toshiba TC358746 converts a parallel video stream into a MIPI CSI-2
> > > +  stream. The direction can be either parallel-in -> csi-out or csi-in ->
> > > +  parallel-out The chip is programmable trough I2C and SPI but the SPI
> > > +  interface is only supported in parallel-in -> csi-out mode.
> > > +
> > > +  Note that the current device tree bindings only support the
> > > +  parallel-in -> csi-out path.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    const: toshiba,tc358746
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  clocks:
> > > +    description:
> > > +      The phandle to the reference clock source. This corresponds to the
> > > +      hardware pin REFCLK.
> > > +    maxItems: 1
> > > +
> > > +  clock-names:
> > > +    const: refclk
> > > +
> > > +# The bridge can act as clock provider for the sensor. To enable this support
> > > +# #clock-cells must be specified. Attention if this feature is used then the
> > > +# mclk rate must be at least: (2 * link-frequency) / 8
> > > +#                             `------------------´   ^
> > > +#                             internal PLL rate   smallest possible mclk-div
> > > +  "#clock-cells":
> > > +    const: 0
> > > +
> > > +  clock-output-names:
> > > +    description:
> > > +      The clock name of the MCLK output, the default name is tc358746-mclk.
> > > +    maxItems: 1
> > > +
> > > +  vddc-supply:
> > > +    description: Digital core voltage supply, 1.2 volts
> > > +
> > > +  vddio-supply:
> > > +    description: Digital I/O voltage supply, 1.8 volts
> > > +
> > > +  vddmipi-supply:
> > > +    description: MIPI CSI phy voltage supply, 1.2 volts
> > > +
> > > +  reset-gpios:
> > > +    description:
> > > +      The phandle and specifier for the GPIO that controls the chip reset.
> > > +      This corresponds to the hardware pin RESX which is physically active low.
> > > +    maxItems: 1
> > > +
> > > +  ports:
> > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > +    properties:
> > > +      port@0:
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        description: Input port
> > > +
> > > +        properties:
> > > +          endpoint:
> > > +            $ref: /schemas/media/video-interfaces.yaml#
> > > +            unevaluatedProperties: false
> > > +
> > > +            properties:
> > > +              hsync-active:
> > > +                enum:
> > > +                  - 0 # Hvalid active high
> > > +              vsync-active:
> > > +                enum:
> > > +                  - 0 # Vvalid active high
> > > +              bus-type:
> > > +                enum:
> > > +                  - 5 # Parallel
> > > +
> > > +            required:
> > > +              - hsync-active
> > > +              - vsync-active
> > 
> > Let's make bus-type required too, to prepare for BT.656 support.
> 
> I would have done it when the BT.656 support is added. Since the BT.656
> don't require the sync signals I would have made a descision:
>  - either: hsync/vsync present -> parallel with external syncs, or
>  - bus-type present -> parallel bus with embedded syncs.
> 
> So we don't bother the system-integrator with specifying unnecessary
> properties. Also having v/hsync required in place with the bus-type (set
> to bt.656) can cause confusion about the final used mode.

The V4L2 fwnode framework can guess the type of the bus but it's not
recommended to use the feature.

Why do you have hsync-active and vsync-active if both are always zero? Can
the hardware not support other configuration?

-- 
Sakari Ailus
