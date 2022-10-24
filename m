Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF8AE6097FE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 03:58:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiJXB6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 21:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiJXB6l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 21:58:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AEEA6611B;
        Sun, 23 Oct 2022 18:58:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98514B80E77;
        Mon, 24 Oct 2022 01:58:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3219C433C1;
        Mon, 24 Oct 2022 01:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666576718;
        bh=+F7HiW9RND3/Jb9W1InscmlPJ6IHh0hxSyw1E6xpqTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TKY3kDS15T6rvASucVP5zagRbke0MWYCHoxa1dwgkRtPK0g10w8JYXdN+bd3sF9zl
         YwQF2NBMcTPGATXnTCs1XkpTq3rODgHq+IcAW8gQ3bsVlSdoJJ9EBh9Zze/Qx/vtUt
         CRnCXUlIvznZVXTvUMqwET2K1F1XyBcRwoRKYmgs5Edr4Zg0HFfeFMZSf4SoSF2a2b
         sK1qHicITwzEP83uI3MYZaAASsQYIASOXocQ83WN3VD1Qh9v3e3GV31mYcP4laF8n+
         sE8XbDHjCb1fqd/xWx6KbV9MgWSCVmJcXmvtcPYgLGxJJV/dTAHwCIMIQtyK51wbe1
         AeVBGwHIZceJQ==
Date:   Mon, 24 Oct 2022 09:58:29 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alistair Francis <alistair@alistair23.me>,
        Arnd Bergmann <arnd@arndb.de>,
        Fabio Estevam <festevam@gmail.com>,
        Johann Neuhauser <jneuhauser@dh-electronics.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] arm: dts: colibri-imx6: usb dual-role switching
 et. al.
Message-ID: <20221024015829.GX125525@dragon>
References: <20220928073336.63881-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928073336.63881-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 28, 2022 at 09:33:31AM +0200, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> This series is an assortment of USB dual-role specific commits as
> follows:
> 
> Introduce USBC_DET GPIO based USB dual-role aka device/host switching.
> 
> Move USB VBUS supply from single carrier board to module level device
> tree. This pin is as per Colibri module family standard.
> 
> Specify USBH_PEN GPIO being active-low rather than active-high
> (cosmetic only).
> 
> Remove spurious debounce property from linux,extcon-usb-gpio. That
> commit is actually for Colibri iMX7.
> 
> Changes in v2:
> - Dropped fixes tag as this change is rather cosmetic.
> - Add new commit also actually enabling CONFIG_EXTCON_USB_GPIO.
> 
> Marcel Ziswiler (4):
>   arm: dts: colibri-imx6: move vbus-supply to module level device tree
>   arm: dts: colibri-imx6: specify usbh_pen gpio being active-low
>   arm: dts: imx7-colibri: remove spurious debounce property
>   ARM: imx_v6_v7_defconfig: Enable USB GPIO extcon support
> 
> Philippe Schenker (1):
>   arm: dts: colibri-imx6: usb dual-role switching

We idiomatically use prefix 'ARM: dts: ...' for i.MX arm DTS.  Fixed
them up and applied the series.

Shawn
