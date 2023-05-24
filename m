Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C6270F837
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 16:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbjEXOFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 10:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbjEXOFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 10:05:13 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3B2119
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:05:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-309438004a6so602505f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 07:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1684937109; x=1687529109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gYK7qPs3K1mFYFt83RxjkD5ObwozLtF5ga5amIDsihk=;
        b=4ZafKxfGLJdkPWBsxlTVtT+cEWZgHCeBAVxIB1Yj/ajbUZXdejKUVx11UN31nSk161
         pCLnKBPkgeIZryb+Q6Fi1k6sqDcPorkF5vUQsAjAHaI8GD7DXGa0hPWHrEgEUPnKzRUA
         CNzODjz6k+O76u81KJS7gBPhfaFPGXNwsd0gqtIEmvkelhzBSVy40S+5aGozdCCPbY3W
         T+ebSUBLH6iDUmZlgQ/Bqkb/Tuo9drKd8oBgi1JjlYIzXfz1vcdgrfv1oWMdIsV3FRkX
         FPGwAXkqnrlGOy1anD8KfMUrZOO8hxQy/qJEggfYxOK6IqPLxrppkpwbBGU9GvM/lHrW
         kTsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684937109; x=1687529109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gYK7qPs3K1mFYFt83RxjkD5ObwozLtF5ga5amIDsihk=;
        b=A7b4zOk1upRLyb3UlknMMR+gC+TTuN0FKbtkpxkieQSUTI9GUCMU6ueD8L/2er5TZa
         F5NmkItOHSEGBmbmA1eirg+rSqkbEXVgNv9ATrgBytmO4veRwNGJZFXSnfCloAfwBWRq
         kTvBRIhrjf3WPdZyL9MOxWPZroTQD29pmoy9cFTIEFTGbGv4Iz0vf0I2bTbob7mpGO4w
         yecumTBO3DBGsnvRyHjD68zUkKo4GLgpcUSrucdcfcWNprUxrYAv1YTVvAyZT65XdqfU
         PRaWouzS4jmpp6KOL2d3/9wj7A/XVYLSraUr+xjduLIqGjaRuhoINtejglbAk0Y6KjdD
         DBRQ==
X-Gm-Message-State: AC+VfDxtmoZGHWWjTKGQuMiBZRqv7S7gHievLRBOHU+h7iBhL+Sjb7ap
        aCy+qy/f+nrF4JZHtHSTic8sZQ==
X-Google-Smtp-Source: ACHHUZ7DY/QLV/yoCNKc+5pHRfJJcvT+0JwdYcgh8jA6/pQw2WsZyH/SczX7hjf76cberK5A66uMnQ==
X-Received: by 2002:adf:e8ce:0:b0:306:34d6:6dfc with SMTP id k14-20020adfe8ce000000b0030634d66dfcmr12451544wrn.37.1684937109015;
        Wed, 24 May 2023 07:05:09 -0700 (PDT)
Received: from localhost ([2a01:e0a:55f:21e0:9e19:4376:dea6:dbfa])
        by smtp.gmail.com with ESMTPSA id t1-20020a5d6a41000000b003063176ef09sm14849411wrw.6.2023.05.24.07.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 07:05:08 -0700 (PDT)
Date:   Wed, 24 May 2023 16:05:03 +0200
From:   Julien Stephan <jstephan@baylibre.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mkorpershoek@baylibre.com, khilman@baylibre.com,
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
        Rob Herring <robh+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH v3 2/3] dt-bindings: phy: add mediatek MIPI CD-PHY module
 v0.5
Message-ID: <2jfgupyvtuenvm7x52l6bo5xzzpva7u6njeg3ecd52wwj4spv6@y3nsq7j2hl2u>
References: <20230524083033.486490-1-jstephan@baylibre.com>
 <20230524083033.486490-3-jstephan@baylibre.com>
 <f92c39c8-177a-e18d-c3b0-79e7349ea4db@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f92c39c8-177a-e18d-c3b0-79e7349ea4db@collabora.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2023 at 11:45:30AM +0200, AngeloGioacchino Del Regno wrote:
> Il 24/05/23 10:30, Julien Stephan ha scritto:
> > From: Florian Sylvestre <fsylvestre@baylibre.com>
> >
> > This adds the bindings, for the MIPI CD-PHY module v0.5 embedded in
> > some Mediatek soc, such as the mt8365
> >
> > Signed-off-by: Florian Sylvestre <fsylvestre@baylibre.com>
> > Signed-off-by: Julien Stephan <jstephan@baylibre.com>
> > ---
> >   .../bindings/phy/mediatek,mt8365-csi-rx.yaml  | 67 +++++++++++++++++++
> >   MAINTAINERS                                   |  6 ++
> >   2 files changed, 73 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> > new file mode 100644
> > index 000000000000..a1bd96a98051
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/phy/mediatek,mt8365-csi-rx.yaml
> > @@ -0,0 +1,67 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +# Copyright (c) 2023 MediaTek, BayLibre
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/phy/mediatek,mt8365-csi-rx.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Mediatek Sensor Interface MIPI CSI CD-PHY
> > +
> > +maintainers:
> > +  - Julien Stephan <jstephan@baylibre.com>
> > +  - Andy Hsieh <andy.hsieh@mediatek.com>
> > +
> > +description:
> > +  The SENINF CD-PHY is a set of CD-PHY connected to the SENINF CSI-2
> > +  receivers. The number of PHYs depends on the SoC model.
> > +  Depending on the SoC model, each PHYs can be either CD-PHY or D-PHY only
> > +  capable.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - mediatek,mt8365-csi-rx
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  '#phy-cells':
> > +    const: 0
> > +
> > +  mediatek,phy-type:
>
> Instead of declaring a phy-type here like this, can't we instead declare that in
> the phy cells, like we're doing with MTK TPHY and like other non-MediaTek PHYs are
> already doing?
>
> device {
> 	...
> 	phys = <&csi0_rx PHY_TYPE_CDPHY>;
> 	...
> }
>
> Regards,
> Angelo
>
>

Hi Angelo,

This is a hardware property that is not dynamic, so IMHO it doesn't make sense
to use phy argument for that. Some driver already use a 'phy-type'
property (such as phy-cadence-torrent.yaml).

I was thinking of using phy argument on future upgrade when driver will
support D-PHY and C-PHY modes so the phy user will be able to choose the
mode.

Does it makes sense?

Best
Julien
