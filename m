Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530595BFDDE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:32:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230021AbiIUMca (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbiIUMcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:32:21 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A76C475CE7;
        Wed, 21 Sep 2022 05:32:20 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id f20so8433933edf.6;
        Wed, 21 Sep 2022 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hiqLbKca8k6bq2csBR6EohjwEjpvjpypWz+SdN+bVt4=;
        b=emT9vTaCD7+oG6jkAJp0Dn3lwh2mDqMiYurK3U9c46Fpo30G2g3NOIehp1VNLJ17q8
         jyyKS/PCt42kw8LyUwb3LHTVj/ziK/zWyTIJBQnPWfIQ0xXIaYXnNwOvULus0JAo5HZb
         bhGav7kBsMR0v4wy0j3M1xz9k7LEXVhXqLoVwNmMG93KjVz6igYjjCeMtOxWgIxTTmvc
         zHCGDEuwEr7NjBNYycHg9IVET+L5upk7STERCgz8BUlO1l546SjBI0IiPAWAViZObB2h
         CwRCmpzSiNZArUw9PNLRGiiangQyANEA6lAmPYJ0GtDtqaZT9rPdlcvIhrjr7vU9TYn1
         Ez5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hiqLbKca8k6bq2csBR6EohjwEjpvjpypWz+SdN+bVt4=;
        b=WU5S7f5iPer6ynvc3+bl4ep9vv9lf1DC9IVqLOPCP4zrJjHeCq7hW8VrYsxbDhcZlQ
         PlNQvZ7o+EN6Li/9VJ0nw5tdTr8BkogfbZKuZ+ffvAfbJgIp+GMu2jqyU81juKTpjsRc
         Bdlmv7xVqkOMydfUkIFKbQ0WLT/OYysSK9MarbiUfh+aVbjx+DtpTQJTmanuBUjDTBLw
         HicuyQixUisAxh/F/Z/dDee1RtUaWMYWE9np1fb8/smAh/OBLKWLI24xaNP9ndoQ52VR
         giN+I9GCNqO8vBbLDT7KYu3slm8hMNJTcNGOK74Lvl6y7l4a1bJgNptoX2E1ZI+HbNWs
         UYuA==
X-Gm-Message-State: ACrzQf1T8eDa2JPWE1nivts6heDzFxUl/j8+roFntF5r6O4P8kz33BqY
        5mDF1Bd0jjw4oNX/uvxNY69YUAtpZKXiJngba/I=
X-Google-Smtp-Source: AMsMyM4SN4E8Ngfb+QYCpcTmdG3S1tlw3imbL7osycTOyOh35D599SmTIqI4BpaF36WSCZMdWOSNDEX2Br5DvF7JJdw=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr24591975edb.0.1663763538931; Wed, 21
 Sep 2022 05:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-2-prabhakar.mahadev-lad.rj@bp.renesas.com> <961b4821-4111-b48e-1ae0-60da8c427fbb@linaro.org>
In-Reply-To: <961b4821-4111-b48e-1ae0-60da8c427fbb@linaro.org>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 21 Sep 2022 13:31:52 +0100
Message-ID: <CA+V-a8vrixnR2fXv8a8YS+tfK3KHmO1qJxE=RaFw4FPopubdBA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] media: dt-bindings: Document Renesas RZ/G2L CSI-2 block
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Sep 8, 2022 at 12:39 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 06/09/2022 01:04, Lad Prabhakar wrote:
> > Document the CSI-2 block which is part of CRU found in Renesas
> > RZ/G2L (and alike) SoCs.
> >
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> > ---
> > v1 -> v2
> > * Dropped media prefix from subject
> > * Renamed node name csi20 -> csi
> > * Used 4 spaces for indentation in example node
> > * Dropped reset-names and interrupt-names properties
> > * Dropped oneOf from compatible
> > * Included RB tag from Laurent
> >
> > RFC v2 -> v1
> > * Fixed review comments pointed by Rob and Jacopo.
> >
> > RFC v1 -> RFC v2
> > * New patch
> > ---
> >  .../bindings/media/renesas,rzg2l-csi2.yaml    | 140 ++++++++++++++++++
> >  1 file changed, 140 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > new file mode 100644
> > index 000000000000..79beace4dec2
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/media/renesas,rzg2l-csi2.yaml
> > @@ -0,0 +1,140 @@
> > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > +# Copyright (C) 2022 Renesas Electronics Corp.
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/media/renesas,rzg2l-csi2.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Renesas RZ/G2L (and alike SoC's) MIPI CSI-2 receiver
> > +
> > +maintainers:
> > +  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > +
> > +description:
> > +  The CSI-2 receiver device provides MIPI CSI-2 capabilities for the Renesas RZ/G2L
> > +  (and alike SoCs). MIPI CSI-2 is part of the CRU block which is used in conjunction
> > +  with the Image Processing module, which provides the video capture capabilities.
> > +
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-csi2       # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-csi2       # RZ/V2L
> > +      - const: renesas,rzg2l-csi2
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 1
> > +
> > +  clocks:
> > +    items:
> > +      - description: Internal clock for connecting CRU and MIPI
> > +      - description: CRU Main clock
> > +      - description: CPU Register access clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: sysclk
> > +      - const: vclk
> > +      - const: pclk
>
> One more: drop the "clk" suffixes. Remaining names could be made a bit
> more readable.
>
The clock names are coming from the clock-list document provided along
with the HW manual:

- CRU_SYSCLK
- CRU_VCLK
- CRU_PCLK

Ive dropped the CRU_ prefix, do you still want me to rename them?

Cheers,
Prabhakar
