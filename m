Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED3D5BFE22
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Sep 2022 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiIUMoG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Sep 2022 08:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiIUMoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Sep 2022 08:44:04 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745A08688A;
        Wed, 21 Sep 2022 05:44:03 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D18BD2B3;
        Wed, 21 Sep 2022 14:44:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663764241;
        bh=hIY9NeY10mPIFhNf/7yysEh0nHb6PlfT2EppjthWmTY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L0oh9H0/uct8ZXze2QfOE6KG3GhKarEcFlF299rQzholayfICHXI6C1Y+Qjo5tsdu
         XfF2BcuKypEnvDCRvPqkV6fDZjl6t5YLF7biz985xhEMIvhlF4KTXBT7cndJIkssGM
         f07OImIIu9E7rrhZXQWQsE2SaFTOPeLpCCYhrPEE=
Date:   Wed, 21 Sep 2022 15:43:46 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: Re: [PATCH v2 2/4] media: dt-bindings: Document Renesas RZ/G2L CRU
 block
Message-ID: <YysHAkWBfTTAJF3E@pendragon.ideasonboard.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 01:40:39PM +0200, Krzysztof Kozlowski wrote:
> On 06/09/2022 01:04, Lad Prabhakar wrote:
> > Document the CRU block found on Renesas RZ/G2L (and alike) SoCs.
> > 
> > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> 
> Thank you for your patch. There is something to discuss/improve.
> 
> > +properties:
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - renesas,r9a07g044-cru       # RZ/G2{L,LC}
> > +          - renesas,r9a07g054-cru       # RZ/V2L
> > +      - const: renesas,rzg2l-cru
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +  interrupts:
> > +    maxItems: 3
> > +
> > +  interrupt-names:
> > +    items:
> > +      - const: image_conv
> > +      - const: image_conv_err
> > +      - const: axi_mst_err
> > +
> > +  clocks:
> > +    items:
> > +      - description: CRU Main clock
> > +      - description: CPU Register access clock
> > +      - description: CRU image transfer clock
> > +
> > +  clock-names:
> > +    items:
> > +      - const: vclk
> > +      - const: pclk
> > +      - const: aclk
> 
> Drop the "clk" suffixes. Remaining names could be made a bit more readable.

These names come from the documentation, isn't it better to match the
datasheet ?

> > +

-- 
Regards,

Laurent Pinchart
