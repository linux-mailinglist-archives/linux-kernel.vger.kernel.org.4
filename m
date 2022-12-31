Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89DC365A3DB
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 12:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbiLaL7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 06:59:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiLaL7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 06:59:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E026456;
        Sat, 31 Dec 2022 03:59:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1EF19B803F1;
        Sat, 31 Dec 2022 11:59:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9892DC433EF;
        Sat, 31 Dec 2022 11:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672487971;
        bh=Gs4ZkzVyXRuKmG/lF2hfGkbXm+2s/h1Gfg9Lxqkrbb4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hVS9cbz4Z1axK7wYw9co/mIJDHxqB23QOnGwcDQ0Ah2PlzpvdUpD3mGPTHEZwU4MF
         LV36JPBBZ3e7rSc4X3rq+2/qL1VDibJ3pwqh3JtYfYFP1tt0ArO9fflCl98zNu8KOw
         hni/7N9mhJ/VQrzXErparEm8Y0azaIV3uxrSNN2DiDpo3D4WMjGRblmeuistFLZkwD
         zM0z71jeDfVcKx+o/X9IM0fqBRxfiEA2sUDyP4BwzhKn/ZK0zgNzeZyzwCkzde/bDQ
         FYU3ooY+uxnhD0TO34KPBMFaRjaPoeoQz4NlL5JSEx8pOTn1+MMzQhnoefSVMPy9Au
         VtttVR5TENsXA==
Date:   Sat, 31 Dec 2022 19:59:22 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Frieder Schrempf <frieder@fris.de>
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Fabio Estevam <festevam@gmail.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
Subject: Re: [PATCH] arm64: dts: imx8mm-kontron: Add RTC aliases
Message-ID: <20221231115922.GP6112@T480>
References: <20221130111357.585560-1-frieder@fris.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130111357.585560-1-frieder@fris.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 12:13:49PM +0100, Frieder Schrempf wrote:
> From: Frieder Schrempf <frieder.schrempf@kontron.de>
> 
> Add aliases for the RTCs on the board and on the SoC. This ensures that
> the primary RTC is always the one on the board that has a buffered supply
> and maximum accuracy.
> 
> Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>

Applied, thanks!
