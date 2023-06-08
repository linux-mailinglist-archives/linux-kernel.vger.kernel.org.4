Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753BF728926
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 22:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235939AbjFHUGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 16:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjFHUF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 16:05:59 -0400
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B06B9;
        Thu,  8 Jun 2023 13:05:56 -0700 (PDT)
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-33b1e83e1daso4877725ab.0;
        Thu, 08 Jun 2023 13:05:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686254755; x=1688846755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0/sR8/S11r6POKJwJKZdRyyXC9EYM0/cQxZIkmiJzsI=;
        b=JRPIuhhmKyEUQLQ/SpOQzFK7PltQumnuLYZ0gPLtuMBS9DfVJIsm6xLVirNij1ta6T
         EycuEU/bYjODCeP1NthOVTx8hYn5WSJUgqLdkvrAqLb1UJsVsPSaA9Jh4U73FW/lMtg+
         yAAI3SZr8TVEm8GqlgGUL49IX0FO0+Uecz8xSEXgI6yZzLjRFFrSyRyp01rqtGWiQ06l
         GZ1oc/q66JcqieM9QbzqSKcA8brJLlZgJwSp2doyymUFaqk0JwH6hOLrxrK5InjDy27V
         Ybtz/THwO7wSRi2rpfmEO1r1UfFW6Q5LyZV+M3gOeoZlEe/SiM8h4LIp1z/iibpPm5gk
         YUwA==
X-Gm-Message-State: AC+VfDy40COyb2+aFBmlw4CoE4xaTWt7sMyVXToVZ0+xWxRUAVuo0pN+
        3Jjsq2VJbcg3mxg8lorcIg==
X-Google-Smtp-Source: ACHHUZ4Z/oQrytUoNlri3g8lDHCGhsb5liDnpSpmhO6hxn9vEvVy6hx4AJ8tUzV/0PRd4R7ABah0Qg==
X-Received: by 2002:a05:6602:218c:b0:777:b4b7:f6ac with SMTP id b12-20020a056602218c00b00777b4b7f6acmr10471093iob.10.1686254755522;
        Thu, 08 Jun 2023 13:05:55 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id u19-20020a02c953000000b0041672c963b3sm483509jao.50.2023.06.08.13.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 13:05:54 -0700 (PDT)
Received: (nullmailer pid 3315825 invoked by uid 1000);
        Thu, 08 Jun 2023 20:05:52 -0000
Date:   Thu, 8 Jun 2023 14:05:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Julien Stephan <jstephan@baylibre.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        mkorpershoek@baylibre.com, khilman@baylibre.com,
        Florian Sylvestre <fsylvestre@baylibre.com>,
        Andy Hsieh <andy.hsieh@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: add mediatek MIPI CD-PHY module
 v0.5
Message-ID: <20230608200552.GA3303349-robh@kernel.org>
References: <20230524083033.486490-1-jstephan@baylibre.com>
 <20230524083033.486490-3-jstephan@baylibre.com>
 <f92c39c8-177a-e18d-c3b0-79e7349ea4db@collabora.com>
 <2jfgupyvtuenvm7x52l6bo5xzzpva7u6njeg3ecd52wwj4spv6@y3nsq7j2hl2u>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2jfgupyvtuenvm7x52l6bo5xzzpva7u6njeg3ecd52wwj4spv6@y3nsq7j2hl2u>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 04:05:03PM +0200, Julien Stephan wrote:
> On Wed, May 24, 2023 at 11:45:30AM +0200, AngeloGioacchino Del Regno wrote:
> > Il 24/05/23 10:30, Julien Stephan ha scritto:
> > > From: Florian Sylvestre <fsylvestre@baylibre.com>
> > >
> > > This adds the bindings, for the MIPI CD-PHY module v0.5 embedded in
> > > some Mediatek soc, such as the mt8365
> > >
> > > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > > ---
> > >   .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 67 +++++++++++++++++++
> > >   MAINTAINERS                                   |  6 ++
> > >   2 files changed, 73 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> > >
> > > diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> > > new file mode 100644
> > > index 000000000000..a1bd96a98051
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> > > @@ -0,0 +1,67 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +# Copyright (c) 2023 MediaTek, BayLibre
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/phy/mediatek,mt8365-csi-rx.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> > > +
> > > +maintainers:
> > > +  - Julien Stephan <jstephan@baylibre.com>
> > > +  - Andy Hsieh <andy.hsieh@mediatek.com>
> > > +
> > > +description:
> > > +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> > > +  receivers. The number of PHYs depends on the SoC model.
> > > +  Depending on the SoC model, each PHYs can be either CD-PHY or D-PHY only
> > > +  capable.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - mediatek,mt8365-csi-rx
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  '#phy-cells':
> > > +    const: 0
> > > +
> > > +  mediatek,phy-type:
> >
> > Instead of declaring a phy-type here like this, can't we instead declare that in
> > the phy cells, like we're doing with MTK TPHY and like other non-MediaTek PHYs are
> > already doing?
> >
> > device {
> > 	...
> > 	phys = <&csi0_rx PHY_TYPE_CDPHY>;
> > 	...
> > }
> >
> > Regards,
> > Angelo
> >
> >
> 
> Hi Angelo,
> 
> This is a hardware property that is not dynamic, so IMHO it doesn't make sense
> to use phy argument for that. 

Why? Interrupt numbers are fixed hardware properties which go in arg 
cells.

> Some driver already use a 'phy-type'
> property (such as phy-cadence-torrent.yaml).
> 
> I was thinking of using phy argument on future upgrade when driver will
> support D-PHY and C-PHY modes so the phy user will be able to choose the
> mode.

Once you design the binding, you don't get to change it.

Rob
