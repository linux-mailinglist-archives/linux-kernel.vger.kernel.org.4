Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BFA96613D6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 08:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232147AbjAHHDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 02:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjAHHDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 02:03:42 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3A1E167DD;
        Sat,  7 Jan 2023 23:03:41 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 320A6AD0;
        Sun,  8 Jan 2023 08:03:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1673161420;
        bh=SgTISQ/SukTle7e0xStwxxuBquT6G6FT4fVXqIU5d10=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlXxdsB3tJL9Nji6j8zDKL9EWhQUzr8iu5jWbl6Tse/m5CDXieZqiK4On7683PoFM
         ae4Eb7vAGRwjdUVc9X+lCUrmY7lIhXwKf4geA/s+nXmKRhKwDnk31Wa7pSknV121on
         Y3Rhykpy8wACbezlvreFxkLb9EA+VBC/AXtjFaMU=
Date:   Sun, 8 Jan 2023 09:03:36 +0200
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
        Guo Ren <guoren@kernel.org>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
Subject: Re: [RFC PATCH 2/4] dt-bindings: vendor-prefixes: Add lincolntech
Message-ID: <Y7pqyKKvjINno7W/@pendragon.ideasonboard.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
 <20230103064615.5311-3-a-bhatia1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230103064615.5311-3-a-bhatia1@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aradhya,

Thank you for the patch.

On Tue, Jan 03, 2023 at 12:16:13PM +0530, Aradhya Bhatia wrote:
> Add document vendor prefix for Lincoln Technology Solutions
> (lincolntech).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> index 516134cbcb3c..82427a6ddf97 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -729,6 +729,8 @@ patternProperties:
>      description: Lichee Pi
>    "^linaro,.*":
>      description: Linaro Limited
> +  "^lincolntech,.*":
> +    description: Lincoln Technology Solutions
>    "^linksprite,.*":
>      description: LinkSprite Technologies, Inc.
>    "^linksys,.*":

-- 
Regards,

Laurent Pinchart
