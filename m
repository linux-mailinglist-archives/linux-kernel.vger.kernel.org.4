Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B3D16401A0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:11:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiLBILS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiLBILP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:11:15 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8995BAC6E3;
        Fri,  2 Dec 2022 00:11:13 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A93C11C0007;
        Fri,  2 Dec 2022 08:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669968672;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3FRgB5fOfGPmedW428TvFCtP0/QrMozmnJseWIpuk7A=;
        b=a//fnsh5+JyreJYDyDTikySU4J9EpX5psA+Cjwlklv/RaKg7TDsrvAEcGmhM4hp5vs6WHw
        gIZzeMTHZjznvSMUy2X6BLGCWQn0fYb4ann0a685qwnuD4ZVrb30qVpPDnmWjAGogzd85M
        mgutn9ghLSfx+9lazos999ygFgzLHIrme9jRJw6kscmrUemRC0ow1l4dgFIR8gk28a+Ih9
        cjykEEOcVsVTGk4bUO1on5Ug3HKwn5xTZsbKzTfbpshUpJuqeCKRVuKNaMngEqhMyIMCNl
        Zv4v0jJT35BFM5ckjTuZWA1fR4ycYl+7WVuzrNchNOw3lChUT2yHpJtikprYXQ==
Date:   Fri, 2 Dec 2022 09:11:08 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v2 01/21] dt-bindings: display: tegra: add Tegra20 VIP
Message-ID: <20221202091108.5f492d6f@booty>
In-Reply-To: <20221201231936.GB1660613-robh@kernel.org>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
        <20221128152336.133953-2-luca.ceresoli@bootlin.com>
        <20221201231936.GB1660613-robh@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks for your review.

On Thu, 1 Dec 2022 17:19:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 28, 2022 at 04:23:16PM +0100, Luca Ceresoli wrote:
> > VIP is the parallel video capture component within the video input
> > subsystem of Tegra20 (and other Tegra chips, apparently).
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > Changed in v2 (suggested by Krzysztof Kozlowski):
> > - remove redundant "bindings" from subject line
> > - remove $nodename
> > - add channel@0 description
> > - add reg: const: 0
> > ---
> >  .../display/tegra/nvidia,tegra20-vip.yaml     | 63 +++++++++++++++++++
> >  MAINTAINERS                                   |  7 +++
> >  2 files changed, 70 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> > 
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> > new file mode 100644
> > index 000000000000..44be2e16c9b4
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vip.yaml
> > @@ -0,0 +1,63 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/tegra/nvidia,tegra20-vip.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: NVIDIA Tegra VIP (parallel video capture) controller
> > +
> > +maintainers:
> > +  - Luca Ceresoli <luca.ceresoli@bootlin.com>
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - nvidia,tegra20-vip
> > +
> > +  "#address-cells":
> > +    const: 1
> > +
> > +  "#size-cells":
> > +    const: 0
> > +
> > +  channel@0:  
> 
> Kind of odd there is only 1 channel with a unit-address. Are more 
> channels coming? Please make the binding as complete as possible even if 
> no driver support yet.

This was discussed in v1 with Krzysztof and the outcome was that it's
OK because it's likely that other SoCs have more, but the documentation
is not public so I cannot add examples.

Full discussion (pretty short indeed):

https://lore.kernel.org/linux-devicetree/5292cc1b-c951-c5c5-b2ef-c154baf6d7fd@linaro.org/

Do you agree that the unit-address should be kept?

> > +    description: parallel video capture interface for the VI
> > +    type: object
> > +
> > +    properties:
> > +      reg:
> > +        const: 0
> > +
> > +      ports:
> > +        $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +        properties:
> > +          port@0:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description:
> > +              Port receiving the video stream from the sensor
> > +
> > +          port@1:
> > +            $ref: /schemas/graph.yaml#/properties/port
> > +            description:
> > +              Port sending the video stream to the VI
> > +
> > +        required:
> > +          - port@0
> > +          - port@1
> > +
> > +    additionalProperties: false  
> 
> A bit easier to read the indented cases if this is above 'properties'.

Sure, will do in v3.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
