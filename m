Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576CD6401A6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiLBILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiLBIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:11:28 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [217.70.178.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71FEDB0A17;
        Fri,  2 Dec 2022 00:11:23 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id AAE54240005;
        Fri,  2 Dec 2022 08:11:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1669968681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PAptEfvYgIwFK8ngkctQU/JTtGEWZC2Koz9VlQAcRkA=;
        b=kstJhwEO+cLVVec3Sk9Sa/uvB4r26XymgSL33QXP8njtUT0BOxFIWIvPdYUnPHe+NQ9YnV
        8v32TN8SCY7ufUMPXXrCfRJHlIQm8PlGtwD4KSJ1q+A2/NR42Zd0+HWuJQRET6uDEIpf/v
        /vMIijMbtujIVkMZtWkARcIL2Wax80uO+EEn6wGnkEawZMpXyyCb7UTIq23yz8HZhqEruq
        sTVeVu0bO793DjT3K4Wql5mZvpZyHc9mlzTN/SJEgzIuhMuiCmqR6IROge5OD3ws1YnU5Q
        lujAdDH/jD7nAhFgQhWBUp9+T9UPjn7wDdKaRu32IH4cta0RDt+nFQvtdawnUg==
Date:   Fri, 2 Dec 2022 09:11:17 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
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
Subject: Re: [PATCH v2 02/21] dt-bindings: display: tegra: vi: add 'vip'
 property and example
Message-ID: <20221202091117.52a9a8f0@booty>
In-Reply-To: <20221201231636.GA1660613-robh@kernel.org>
References: <20221128152336.133953-1-luca.ceresoli@bootlin.com>
        <20221128152336.133953-3-luca.ceresoli@bootlin.com>
        <20221201231636.GA1660613-robh@kernel.org>
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

On Thu, 1 Dec 2022 17:16:36 -0600
Rob Herring <robh@kernel.org> wrote:

> On Mon, Nov 28, 2022 at 04:23:17PM +0100, Luca Ceresoli wrote:
> > The Tegra20 VI peripheral can receive parallel input from the VIP parallel
> > input module. Add it to the allowed properties and augment the existing
> > nvidia,tegra20-vi example to show a 'vip' property.
> > 
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> > 
> > ---
> > 
> > Changed in v2 (suggested by Krzysztof Kozlowski):
> > - rename "i2c3" -> "ic2"
> > - add review tag
> > ---
> >  .../display/tegra/nvidia,tegra20-vi.yaml      | 68 +++++++++++++++++++
> >  MAINTAINERS                                   |  1 +
> >  2 files changed, 69 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> > index 782a4b10150a..5b5583c2b562 100644
> > --- a/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> > +++ b/Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-vi.yaml
> > @@ -74,6 +74,22 @@ properties:
> >    avdd-dsi-csi-supply:
> >      description: DSI/CSI power supply. Must supply 1.2 V.
> >  
> > +  vip:
> > +    $ref: /schemas/display/tegra/nvidia,tegra20-vip.yaml
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description:
> > +          Input from the VIP (parallel input capture) module
> > +
> > +        properties:
> > +          endpoint:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint  
> 
> You can drop 'endpoint'. You only need port nodes if there's no extra 
> properties in the endpoints.

Oh, nice, will remove in v3.

Krzysztof, can I keep your Reviewed-by after this change?

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
