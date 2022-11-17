Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F85162DAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 13:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233714AbiKQM3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 07:29:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239689AbiKQM3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 07:29:00 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF68B13DCE;
        Thu, 17 Nov 2022 04:28:44 -0800 (PST)
Received: from [192.168.1.15] (91-154-32-225.elisa-laajakaista.fi [91.154.32.225])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2F9A96E0;
        Thu, 17 Nov 2022 13:28:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1668688123;
        bh=2crvZPaGj/RdEilZ8cE3IzIbJpee263IS8ReLqPncQo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=gKVklGFzFgiYFrYrQJ5034/Vk85y5o9kYhK0FIglsX1JXrML1yG76soMvoiPAT49Z
         +mvNxrvDehgB/QeDhqbRnxfCqlg1b7QB7i7oDdWBZllyFjrJy1R7NNTQPgEsVNJccf
         fT5/eYEJpz4eT4Q8Qt+7GLxeO7bshA+cjT0MUt6U=
Message-ID: <9b4bf8b8-7702-1a54-1133-17c6f81e8d30@ideasonboard.com>
Date:   Thu, 17 Nov 2022 14:28:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v1 0/8] Renesas V4H DSI & DP output support
Content-Language: en-US
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/11/2022 14:25, Tomi Valkeinen wrote:
> Hi,
> 
> These add support for DSI on V4H SoC (r8a779g0) and DP for Whitehawk
> board.
> 
> The last patch is a hack, but needed to get the DSI working. It is still
> unclear what the register write does, and as that patch is needed to get
> the DSI working, this series is not ready yet. But all the rest of the
> patches are ready for review.

And I forgot to mention, these are based on:

git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git master
(2c980642d64882b4e373b0317dd7bd45c1c34d80)

  Tomi

> 
>   Tomi
> 
> Tomi Valkeinen (8):
>    dt-bindings: display: renesas,du: Provide bindings for r8a779g0
>    dt-bindings: display: bridge: renesas,dsi-csi2-tx: Add r8a779g0
>    clk: renesas: r8a779g0: Add display related clocks
>    arm64: dts: renesas: r8a779g0: Add display related data
>    arm64: dts: renesas: white-hawk-cpu: Add DP output support
>    drm: rcar-du: Add r8a779g0 support
>    drm: rcar-du: dsi: Add r8A779g0 support
>    HACK: drm: rcar-du: dsi: use-extal-clk hack
> 
>   .../display/bridge/renesas,dsi-csi2-tx.yaml   |   3 +-
>   .../bindings/display/renesas,du.yaml          |   2 +
>   .../dts/renesas/r8a779g0-white-hawk-cpu.dtsi  |  94 ++++
>   arch/arm64/boot/dts/renesas/r8a779g0.dtsi     | 129 +++++
>   drivers/clk/renesas/r8a779g0-cpg-mssr.c       |  14 +
>   drivers/gpu/drm/rcar-du/rcar_du_drv.c         |  22 +
>   drivers/gpu/drm/rcar-du/rcar_mipi_dsi.c       | 488 ++++++++++++++----
>   drivers/gpu/drm/rcar-du/rcar_mipi_dsi_regs.h  |   6 +-
>   8 files changed, 651 insertions(+), 107 deletions(-)
> 

