Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1D65FDA3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJMNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbiJMNSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:18:04 -0400
X-Greylist: delayed 601 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 13 Oct 2022 06:18:00 PDT
Received: from smtp-out-06.comm2000.it (smtp-out-06.comm2000.it [212.97.32.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210AF197F80;
        Thu, 13 Oct 2022 06:17:59 -0700 (PDT)
Received: from gaggiata.pivistrello.it (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-06.comm2000.it (Postfix) with ESMTPSA id 7572E5639DE;
        Thu, 13 Oct 2022 14:58:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1665665911;
        bh=VwMyq6K/Y20d9lPOV/FUqg1ALLGkcp+OHNu++vwyun4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To;
        b=QAqrBZjY6/M2FLKYEVmxD4MKm7EQg1D0jqIdhgEI1P8ccnfsqSqXeHM6WVovzq1yP
         KRtea5CqX4ChN/TgzTzuU9iRtVj8/HQO8teNsnQ1KV9sR8PFAMwH4vpq4Hb2Z3mC1O
         U5GhOXdkgvgGO6Qk3N8douYN7JKsqXJ3vCLIxogJM8FbRXq5KNYUMBurrcacwUTyRC
         vqDd6ylWojGksPmsNpmBqEqINd9fei3HTHHo09DvKfOv6kx/f/mDlYOyKh6wGlknVg
         5JmGazYqiepBMQLw60hiiDM6DaedyBt1Xi/erFxc0kAwPYtZv9lQVt3jOqqw5XvAf3
         QxsuuxG1N2a0g==
Received: by gaggiata.pivistrello.it (Postfix, from userid 1000)
        id CF3D87F83D; Thu, 13 Oct 2022 14:58:29 +0200 (CEST)
Date:   Thu, 13 Oct 2022 14:58:29 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Max Krummenacher <max.oss.09@gmail.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Marek Vasut <marex@denx.de>
Cc:     max.krummenacher@toradex.com,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/4] dt-bindings: display: add new bus-format property
 for panel-dpi
Message-ID: <Y0gLdQleE64FQgn9@gaggiata.pivistrello.it>
Reply-To: francesco.dolcini@toradex.com
References: <20220628181838.2031-1-max.oss.09@gmail.com>
 <20220628181838.2031-3-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628181838.2031-3-max.oss.09@gmail.com>
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Max, Marek, Dave et al.

On Tue, Jun 28, 2022 at 08:18:36PM +0200, Max Krummenacher wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The property is used to set the enum bus_format and infer the bpc
> for a panel defined by 'panel-dpi'.
> This specifies how the panel is connected to the display interface.
> 
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> 

<snip>

> diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> index dae0676b5c6e..52f5db03b6a8 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> +++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
> @@ -26,7 +26,28 @@ properties:
>    height-mm: true
>    label: true
>    panel-timing: true
> -  port: true
> +
> +  port:
> +    $ref: /schemas/graph.yaml#/$defs/port-base
> +    description:
> +      Input port node, receives the panel data.
> +
> +    properties:
> +      endpoint:
> +        $ref: /schemas/graph.yaml#/$defs/endpoint-base
> +
> +        properties:
> +          bus-format:
> +            $ref: /schemas/types.yaml#/definitions/uint32
> +            minimum: 0x1001
> +            maximum: 0x1fff
> +            description: |
> +              Describes how the display panel is connected to the display interface.
> +              Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
> +              The mapping between the color/significance of the panel lines to the
> +              parallel data lines are defined in:
> +              https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats
> +

Last month I had the chance to talk in person about this topic with
Dave, Marek and Max in Dublin.

My understanding is that this change is addressing a general need, Dave
confirmed me they have a downstream patch for raspberrypi [1].

From what I could tell the only concern is about the actual encoding of
this `bus-format` property.

I am personally convinced that a simple enum is the way to go, I think
that Marek proposal is adding complexity and not flexibility (from my
understanding Dave is on the same page, just correct me if I
misunderstood you).

The current proposal is already encoding the exact bit placing as
described in Documentation/userspace-api/media/v4l/subdev-formats.rst [2],
this enumeration can be extended to address any future needs
and I would not invent a new one to define the exact same
things (and using the same enum was also suggested by Rob).

Marek: you told me that you had some concern about some valid use case
not covered by this solution, would you mind explaining why that would
not be covered with an addition on this enumeration?

Any other opinion on this topic? How can we move this forward?

Francesco

[1] https://github.com/raspberrypi/linux/commit/8e43f1898191b43aa7ed6e6ca3a4cd28709af86d
[2] https://www.kernel.org/doc/html/latest/userspace-api/media/v4l/subdev-formats.html

