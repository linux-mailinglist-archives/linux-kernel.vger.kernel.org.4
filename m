Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22AAF67CA51
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 12:55:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbjAZLz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 06:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjAZLz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 06:55:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B022CFE5;
        Thu, 26 Jan 2023 03:55:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B2392617AB;
        Thu, 26 Jan 2023 11:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9F35C433D2;
        Thu, 26 Jan 2023 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674734125;
        bh=dL5oghASIUs6sQ+zp3NQICLvz0qyCSWBkMxIUwPZo80=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zu63a/0yUmFo2AaRMrpSDlDsFf9Lu2P5dQUI5Gq+0h1Q5rcpSgk1WgqDPQzPtvf8Z
         3JnD0zU+neAXf0VZ33zk7opdAbV9FLKs08JXjfzOUzZLGuNO2ZoiSN9dcFASTCgksy
         gMqT44MH+fZHJVpn8zslPEW811M51FDQG+GyqE2ujuV+9mmhPaFLcxWOfoOQb8h81B
         I5RTu/i8lHjmducKJwbgWjHVQ2R6blDTPu8QWHX4ticWZ3NFBFFTyQVF/fPwigkivq
         W5xnQygl1eHpdEaLXAlFg/KIERbuLsnFJwdSHw/vmVT0CMB4UUiWeKHpgN7q5NZASW
         L7Tja4/EPK80g==
Date:   Thu, 26 Jan 2023 19:55:14 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Aishwarya Kothari <aishwarya.kothari@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Tim Harvey <tharvey@gateworks.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] arm64: dts: imx8m(m|p): Add yavia carrier board
Message-ID: <20230126115512.GJ20713@T480>
References: <20230123151734.44184-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230123151734.44184-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, 2023 at 04:17:31PM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> 
> This series adds the new Yavia Carrier Board for the Verdin family.
> Specifically for Verdin iMX8M Mini and Verdin iMX8M Plus.
> 
> Yavia is a compact carrier board providing easy access to the most
> common features of the Verdin family. The intended use of the carrier
> board is application software development. The board is compatible with
> all current and future Verdin SoMs.
> 
> https://www.toradex.com/products/carrier-board/yavia
> 
> Changes in v2:
> - Added Krzysztof's Acked-by
> - Switch deprecated label in led node with color, function and
>   function-enumerator
> 
> Philippe Schenker (3):
>   dt-bindings: arm: fsl: Add verdin yavia carrier-board
>   arm64: dts: imx8mm-verdin: Add yavia carrier board
>   arm64: dts: imx8mp-verdin: Add yavia carrier board

Applied all, thanks!
