Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A9560933E
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 15:08:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbiJWNIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 09:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJWNIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 09:08:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C46719B9;
        Sun, 23 Oct 2022 06:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A966960E00;
        Sun, 23 Oct 2022 13:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4183DC433D6;
        Sun, 23 Oct 2022 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666530519;
        bh=ouu7Bk62SDEuFF7cRLC97PYcQZcdaHWbLN9NGBfp7Ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=e1ZlGBZUrJfgUNh09H8TVgjfWRkL6smg0m6h3qScNQ77/QtI8oLpt0F+QjC8Rb7Hk
         YKnGCCSviVHf4rBeTWVVqjCcpZoqZvVDxuEmPvZ3eXwTg+A20M6l8UYe3R36Rd5MR4
         OfVV6RcBB6XYN/+Z/AqSwEy0RIQ3jnU7FP7UTxpYyDvD1SYaNjvL0xPGUhw9l5AIEz
         naAqFsXnQEBfojWe/lhdTRBcBUKEPv7uNbxUm49uJSysU762uKK+dSH3LSadAzYbCz
         0juPCtoHDMOuwpBeyHGBLuoU5I2GB3kf5DhiEwHN2+U864oGo8CoRnq7W7mo/au2kB
         X+OfX+QIhL0mQ==
Date:   Sun, 23 Oct 2022 21:08:31 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/8] arm64: dts: verdin-imx8mp: fix ctrl_sleep_moci
Message-ID: <20221023130831.GI125525@dragon>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
 <20220922162925.2368577-2-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922162925.2368577-2-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 06:29:18PM +0200, Marcel Ziswiler wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> The GPIO signaling ctrl_sleep_moci is currently handled as a gpio hog.
> But the gpio-hog node is made a child of the wrong gpio controller.
> Move it to the node representing gpio4 so that it actually works.
> 
> Without this carrier board components jumpered to use the signal are
> unconditionally switched off.
> 
> Fixes: 1d8df9c74bff ("arm64: dts: freescale: add initial support for verdin imx8m plus")
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Applied, thanks!
