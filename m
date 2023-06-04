Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BA72170C
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjFDMvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjFDMvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8371B8;
        Sun,  4 Jun 2023 05:51:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5004A60BFC;
        Sun,  4 Jun 2023 12:51:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DAFDC433D2;
        Sun,  4 Jun 2023 12:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685883098;
        bh=oOBuCEz7Y/YZs0VqqP7Wn5HOllSMyN0eqRbZVQg2J1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CPp930VfleIQ4jah9Khw4yHX9D5htWsdss7ccMsr2trfGepUj2aFdNWjdqDmj9KUx
         qamO5Ly3WkX4CFlfRM3zReB1p5MATVO/6isTvPx8pf/DTtgcZn9Gdg0e/bGOeDqwIe
         lk1vUPzMgH1iRiPFWN4ZY392K9+xpivw4ASJ6nwxiifB2vGS0SCjO7ERHhE89i6tqG
         t/Z32iejPtq4SaDq6f3juD3QJAcbtcJ4uvuWgrtFcuUDWBpWBelz2CMceMUypMcPYr
         WmDy+W8V+bauqHCJhcrJudHNv/g+EEP6GXPhe1ZHc75+rOkFNwb4wJU+GiaUapFnCI
         uGNO9geoZb/pg==
Date:   Sun, 4 Jun 2023 20:51:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8mn-var-som-symphony: adapt FEC pinctrl
 for SOMs with onboard PHY
Message-ID: <20230604125118.GM4199@dragon>
References: <20230529193525.1034378-1-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529193525.1034378-1-hugo@hugovil.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 03:35:26PM -0400, Hugo Villeneuve wrote:
> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> The VAR SOM symphony carrier board can be used with SOMs which have a
> soldered ethernet PHY onboard and with SOMs which don't have one.
> 
> For SOMs with an onboard PHY, the PHY on the cartrier board is not
> used, and GPIO1_IO9 is used as a reset line to the onboard PHY.
> 
> For SOMs without an onboard PHY, the PHY on the carrier board is
> used. For this configuration, pca9534 GPIO 5 (located on the carrier
> board) is used as a reset line to the PHY, and GPIO1_IO9 is not
> used.
> 
> GPIO1_IO9 is not connected to any user-accessible pins or functions,
> and leaving it enabled in the mux pinctrl for both configurations is
> safe.
> 
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>

Applied, thanks!
