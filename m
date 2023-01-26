Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1BA67C57F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 09:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbjAZIG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 03:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbjAZIG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 03:06:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658585C0E9;
        Thu, 26 Jan 2023 00:06:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A389B817C1;
        Thu, 26 Jan 2023 08:06:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 327F0C433D2;
        Thu, 26 Jan 2023 08:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674720381;
        bh=MdqLJZqyVBrelG7lv4TaPZFi7gyG8a4VUrUwlrtKvvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RnKqaLM04nfR9VfnKd8u2zZOM8z8cB73mIjp/YfA65UNtgfLmusbTDpa6L5CIr4Aj
         zWmGps1yVNWe5qRrZoc5dVpmJ9WryPPpPyGqVi52lSs4jELYYkK/oBO+ABV49fPCSn
         2xjxpwGmicOFSFo4rdXHO+hkGJ2DY+BDV/rwSDI5iLpQG1FpewEI119USQ4TrQ4WPE
         ZNtKlUkGObWpLUv31QmQhGsyWs8SE0l1v7bB4SvCji46mK7ouhOYcgDMXzYKMjmY4S
         CKK/FWh44yRDekga4kjJvlB8MOTQaQvB3RCOd1FuAG4BZpkd/DBelIB8h1YuXxjQ0U
         0aYeUhHkerJLA==
Date:   Thu, 26 Jan 2023 16:06:13 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Emanuele Ghidoli <emanuele.ghidoli@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] arm64: dts: (imx8mm|imx8mp)-verdin-dev: Do not
 include dahlia dtsi
Message-ID: <20230126080611.GC20713@T480>
References: <20230118105251.6035-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118105251.6035-1-dev@pschenker.ch>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 11:52:49AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> 
> We so far included the Dahlia device-tree in the development board
> devicetree in order to try to minimize code duplication.
> 
> This mainly gets rid of ''status = "okay"' lines. Plus we saw that some
> settings in the audio-codec of verdin-imx8mm are inherited that are
> wrong for the development board. Those did also lead to the DT Schema
> checker to fail on multiple settings.
> 
> We decided to remove this include in order to get the audio-codec
> settings correct and make the DT Schema checker return less warnings.
> This introduces some code duplication which we consider being mostly
> only configuration of the actual development/dahlia boards.
> 
> This series of two patches removes the include for both Verdin boards we
> have at the moment.
> 
> This issue was spotted by Rob Herring. [1]
> 
> [1] https://lore.kernel.org/all/167182349408.373865.10339766752503211557.robh@kernel.org/
> 
> 
> Philippe Schenker (2):
>   arm64: dts: imx8mm-verdin-dev: Do not include dahlia dtsi
>   arm64: dts: imx8mp-verdin-dev: Do not include dahlia dtsi

Applied both, thanks!
