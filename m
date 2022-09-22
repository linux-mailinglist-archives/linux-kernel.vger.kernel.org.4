Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDFA25E640E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231844AbiIVNra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231839AbiIVNq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:46:59 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4866B2CF9;
        Thu, 22 Sep 2022 06:46:32 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DAD356BE;
        Thu, 22 Sep 2022 15:46:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1663854390;
        bh=4PHTA7WJvRzkt2WYaKYBpZNp5g1S5sLG94TzQnuL42E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b0CKFH/qiOdwbJ0Nkzn8UvIK+aiNAKkFrGvXtEM9+s9f6ZosHkHM6IRKCgSzlFr++
         e2gbTTwZmgpsZK9Fcj7KI164PtJu4cSKqLHQ4GTbxA9y3g6H80Bq0njmSsuFUijbQn
         O4wRK3mE4FMPpGha89+jx0AOJ+dUv0HWobaKNJX0=
Date:   Thu, 22 Sep 2022 16:46:15 +0300
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
Message-ID: <YyxnJ/Ho5rZQzDDN@pendragon.ideasonboard.com>
References: <20220905230406.30801-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20220905230406.30801-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <29d456ed-620c-8dc9-01f0-54f96b670b94@linaro.org>
 <YysHAkWBfTTAJF3E@pendragon.ideasonboard.com>
 <ba436dd5-2ea2-b2e0-7056-5bae6b4c7bb4@linaro.org>
 <YytJ/oJK9s2mfqPL@pendragon.ideasonboard.com>
 <bba1ed72-d691-b51c-dce8-ab9a2e45fe86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bba1ed72-d691-b51c-dce8-ab9a2e45fe86@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 21, 2022 at 08:58:26PM +0200, Krzysztof Kozlowski wrote:
> On 21/09/2022 19:29, Laurent Pinchart wrote:
> >>>>> +  clock-names:
> >>>>> +    items:
> >>>>> +      - const: vclk
> >>>>> +      - const: pclk
> >>>>> +      - const: aclk
> >>>>
> >>>> Drop the "clk" suffixes. Remaining names could be made a bit more readable.
> >>>
> >>> These names come from the documentation, isn't it better to match the
> >>> datasheet ?
> >>
> >> If datasheet calls it "vclk_really_clk_it_is_clk_clk", it's not the
> >> reason to use it. :)
> >>
> >> The "clk" is redundant even if the hardware engineer thought different.
> >>
> >> The same for IRQs ("tx" not "txirq"), for dmas ("tx" not "txdma").
> > 
> > I'd argue that naming clocks "v", "p" and "a" would be less readable and
> > more confusing. Is this a new rule ?
> 
> Not really, but also it's only a style issue.
> 
> Indeed "v" and "p" are not much better... but still "vclk" does not
> bring any additional information over "v". It's redundant.
> 
> You can also drop entire entry - unless it helps in particular
> implementation.

There are multiple clocks, so I think names are better than indices. If
you really insist we could name them "v", "p" and "a", but I think the
clk suffix here improves readability. If those clocks were named
"videoclk", "pixelclk" and "axiclk" I'd be fine dropping the suffix, but
that's not the case here.

> https://lore.kernel.org/all/20220517175958.GA1321687-robh@kernel.org/
> https://lore.kernel.org/all/20210815133926.22860-1-biju.das.jz@bp.renesas.com/
> https://lore.kernel.org/all/YYFCaHI%2FDASUz+Vu@robh.at.kernel.org/
> https://lore.kernel.org/all/20220830182540.GA1797396-robh@kernel.org/

-- 
Regards,

Laurent Pinchart
