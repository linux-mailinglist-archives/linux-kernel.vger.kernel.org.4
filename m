Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CCC66BA5F
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 10:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjAPJbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 04:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjAPJao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 04:30:44 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F89616AD5;
        Mon, 16 Jan 2023 01:30:42 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D163D802;
        Mon, 16 Jan 2023 10:30:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673861440;
        bh=9YWn45J/ZNgJKTD6UEkGgR2mEmqJ7NYekCQW2ePfKgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N+zSHiOP3BPeIWVxgMUMZkbWSMpAwC7eyS7KRf00o33vAIM8HgnNlYZlsGe4NvEx+
         ggan64ipd8TDap0zM7nKhc17S/7JZhs8uDIM+s21vxICnSvXcvLCGEqibqZ7MKdHAQ
         GpwQEr5QqXpkio0Z6yTPKSTEHMw4GfSB6ctnf2Pk=
Date:   Mon, 16 Jan 2023 11:30:40 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>, Nishanth Menon <nm@ti.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Rahul T R <r-ravikumar@ti.com>
Subject: Re: [RFC PATCH 0/4] dt-bindings: Introduce dual-link panels &
 panel-vendors
Message-ID: <Y8UZQHvVT2VQcQ33@pendragon.ideasonboard.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230103064615.5311-1-a-bhatia1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya,

On Tue, Jan 03, 2023 at 12:16:11PM +0530, Aradhya Bhatia wrote:
> Hi all,
> 
> Microtips Technology Solutions USA, and Lincoln Technology Solutions are
> 2 display panel vendors, and the first 2 patches add their vendor
> prefixes.
> 
> The fourth patch, simply introduces the new compatible for the generic
> dual-link panels in the panel-lvds driver. This new compatible is based
> from a new DT binding added in the third patch explained below.
> 
> The third patch introduces a dt-binding for generic dual-link LVDS
> panels. These panels do not have any documented constraints, except for
> their timing characteristics. Further, these panels have 2 pixel-sinks.
> In a dual-link connection between an LVDS encoder and the panel, one
> sink accepts the odd set of LVDS pixels and the other, the even set.
> 
> A lot of this has been based from the Advantech,idk-2121wr dual-link
> panel[1] and Maxime's patches for generic LVDS panels[2] (which are
> single-link by default.) and the discussions that happened before they
> were finally merged.
> 
> Below are some notes and points that I want to bring forward.
> 
>   - The advantech,idk-2121wr panel binding uses 2 boolean properties
>     dual-link-odd/even-pixels, to signify which port sink is being used
>     for which set of LVDS pixels. I too have added similar support and
>     introduced constraints around those properties, so as to not break
>     the ABI... but I believe there is a better way to achieve this.
> 
>     A "pixel-type" enum property could be introduced in their stead,
>     which can accept one of the 2 options <dual-lvds-odd-pixels> or
>     <dual-lvds-even-pixels>.
> 
>     This method, in my opinion, is more accurate and cleaner to
>     implement in the bindings as well.
> 
>     If this does sound a better I can push out a new revision where the
>     driver supports both these methods (to not break the ABI) and the
>     advantech,2121wr panel can remain as an exception.

It's usually best not to change an existing system if there are no good
reasons, so I'd ask why you think a pixel-type property would be better
(including when taking into account the fact that we would have to
maintain the advantech,2121wtr driver separately) if you want to go that
way. Otherwise, if we were developing this from scratch, I would have no
real preference.

>   - As an alternative to the previous point, if that method is not
>     preferred for some reason, the advantech,2121wtr panel binding
>     could then be merged in the panel-dual-lvds binding as part of
>     future work.
> 
> 
>   - Another tweak, I am looking forward to do as part of future work and
>     would like all your comments is to introduce driver-based
>     implementation of the panel timing parameters, like it is with
>     "panel-simple". The driver can then support both the panel-timing
>     sources (DT node or hard-coded driver structure) and the binding
>     can remove this from the "required" section.

There's been a very long discussion in the past (multiple discussions
actually) regarding whether timings should be set in DT or in drivers.
There were multiple arguments supporting both sides, without (it seems)
a clear winner. If you want driver-side timings for dual-link panels,
I'd like to understand why you think that's better. If the reasons are
the same as the ones expressed when we discussed simple panels, you
should also look at whether or not any of the fears expressed on either
side have materialized.

> Thank you!
> 
> [1]: https://patchwork.freedesktop.org/patch/357122/
> [2]: https://patchwork.freedesktop.org/patch/471228/
> 
> Aradhya Bhatia (4):
>   dt-bindings: vendor-prefixes: Add microtips
>   dt-bindings: vendor-prefixes: Add lincolntech
>   dt-bindings: panel: Introduce dual-link LVDS panel
>   drm: panel-lvds: Introduce dual-link panels
> 
>  .../display/panel/panel-dual-lvds.yaml        | 157 ++++++++++++++++++
>  .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
>  MAINTAINERS                                   |   1 +
>  drivers/gpu/drm/panel/panel-lvds.c            |   1 +
>  4 files changed, 163 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/panel-dual-lvds.yaml

-- 
Regards,

Laurent Pinchart
