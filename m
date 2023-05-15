Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91C7C70224E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbjEOD3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238660AbjEOD2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:28:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB882133;
        Sun, 14 May 2023 20:28:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6D070618D6;
        Mon, 15 May 2023 03:28:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65281C433D2;
        Mon, 15 May 2023 03:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121305;
        bh=C10aqQd3ZJqF8H5LNpyNNaapjiLnU8RHkcB3BggilQs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q9NqjfVKnXKItke/jAPWfKeAiKmMZVAl8g8mns2LMHlh9xW06P9QYoKLa2EeOgVxX
         PSkN00zPPhWpQUyg/C4glAr3ElcRcXlM76XCaS1Y4eqT/8jYquAlrA2P9Do0UphQX3
         ugdfmJYjILAmdbDwN9WmDGbGQhLCODaDtcJcJZ/x4nOfTN37bhcsmygqewKADhniJl
         dfH1hCSYPG4muyL01/D5Yn/0/s0OQgrgbEh0IbJ+jA2Wu+T7dXlOuBuuyVilnMgwmr
         RjYb18CeXnt5VQG/PzF1weQcAx3borF87ZIcThZyJ4M7C3qQ+gGr7hW7Wb+k0qIjFC
         gLiwlNeelToPg==
Date:   Mon, 15 May 2023 11:28:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Himanshu Bhavani <himanshu.bhavani@siliconsignals.io>
Cc:     krzysztof.kozlowski@linaro.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Jesse Taube <mr.bossman075@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Jagan Teki <jagan@edgeble.ai>,
        Chris Morgan <macromorgan@hotmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 0/3] arm64: dts: Add initial support for Emtop SoM &
 Baseboard
Message-ID: <20230515032810.GG767028@dragon>
References: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230513113133.1913736-1-himanshu.bhavani@siliconsignals.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 13, 2023 at 05:01:23PM +0530, Himanshu Bhavani wrote:
> Change in v2:
> - in patch 1/3:
> 	- Update dtb add order in Makefile
> 	- Update proper prefix/name in dts
> 	- Removed stray blank line
> 	- Add pinctrl-names
> 
> - in patch 2/3:
> 	- Update bindings
> 
> Changes in v3:
> - in patch 1/3:
> 	- Removed dead code
> 	- Fixed style and indentations
> 
> - in patch 3/3:
> 	- Update vendor prefix
> 
> Changes in v4:
> - in patch 2/4:
> 	- Update SoM Name
> 
> - in patch 3/4:
> 	- Add Acked-by
> 
> Changes in v5:
> - in patch 1/5:
> 	- Add device tree for Emtop SoM
> 	- Add device tree for Baseboard
> 	- Update grp suffix
> 	- Update alphabetical order of nodes
> 	- Update bindings
> 
> - in patch 2/5:
> 	- Add bindings for SoM
> 	- Update bindings for Emtop
> 	- Add bindings for Baseboard
> 
> -in patch 3/5:
> 	- Update proper vendor prefix
> 
> 
> Himanshu Bhavani (3):
>   arm64: dts: Add support for Emtop SoM & Baseboard
>   dt-bindings: arm: fsl: Add Emtop SoM & Baseboard
>   dt-bindings: vendor-prefixes: Add Emtop

Applied all, thanks!
