Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 521D763B782
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 02:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbiK2B6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 20:58:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234243AbiK2B6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 20:58:18 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3291E3AC34;
        Mon, 28 Nov 2022 17:58:18 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B54DF4E6;
        Tue, 29 Nov 2022 02:58:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669687095;
        bh=ALlSUwOjuZtKU27sLYVc2psBB7T9v5/F5DOwwLYltHc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=On8J5s89eysO38gufiECkppkwee6jYkIFoEUQHYAXAFG73gZnFPlC273rqPDnG1mD
         HA6qqNV4BYit1CmixMtUVEz7lpfYCkX7T2oMXXG0uI0Je1sGeDs4DZLBvgaNcFruB9
         z6aRFTO4gdKvEqFMOHN6cMFpfXR9h3x8puYBvh1g=
Date:   Tue, 29 Nov 2022 03:58:00 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc:     Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [PATCH v2 0/7] Renesas V4H DSI & DP output support
Message-ID: <Y4VnKBC+fHGwNZOx@pendragon.ideasonboard.com>
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Wed, Nov 23, 2022 at 08:59:39AM +0200, Tomi Valkeinen wrote:
> From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> Hi,
> 
> These add support for DSI on V4H SoC (r8a779g0) and DP for Whitehawk
> board.
> 
> Changes in v2:
> - A few cosmetic changes
> - Increase vspd address range in dts to 0x7000
> - Arrange nodes in dts by the block address
> - Use gen = 4 for r8a779g0 du
> - Drop the CLOCKSET1 hack patch
> 
> The CLOCKSET1 patch is apparently not needed to get the DSI & DP
> working. Which is baffling, as I'm quite sure it was needed. There are a
> few possible explanations: 1) it was never needed and I was just messing
> things up, 2) it was needed, but some of my later improvements made it
> unnecessary, 3) Whitehawk board firmware was updated in the middle of
> the development of this series, possibly the firmware made the patch
> unnecessary.
> 
>  Tomi
> 
> Tomi Valkeinen (7):
>   dt-bindings: display: renesas,du: Provide bindings for r8a779g0
>   dt-bindings: display: bridge: renesas,dsi-csi2-tx: Add r8a779g0
>   clk: renesas: r8a779g0: Add display related clocks
>   arm64: dts: renesas: r8a779g0: Add display related nodes
>   arm64: dts: renesas: white-hawk-cpu: Add DP output support
>   drm: rcar-du: Add r8a779g0 support
>   drm: rcar-du: dsi: Add r8A779g0 support

I'll take patches 1/7, 2/7 and 6/7 in my tree already for v6.3. I expect
Geert to handle 3/7, 4/7 and 5/7. 7/7 needs a v3.

> 
>  .../display/bridge/renesas,dsi-csi2-tx.yaml   |   3 +-
>  .../bindings/display/renesas,du.yaml          |   2 +
>  .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  |  94 ++++
>  arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 130 +++++
>  drivers/clk/renesas/r8a779g0-cpg-mssr.c       |  14 +
>  drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  22 +
>  drivers/gpu/drm/rcar-du/rcar_du_group.c       |   2 +-
>  drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c       | 484 ++++++++++++++----
>  drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h  |   6 +-
>  9 files changed, 649 insertions(+), 108 deletions(-)
> 

-- 
Regards,

Laurent Pinchart
