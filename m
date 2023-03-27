Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58EE96C9984
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 04:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbjC0CLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 22:11:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjC0CLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 22:11:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9184ED0;
        Sun, 26 Mar 2023 19:11:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CACD060F91;
        Mon, 27 Mar 2023 02:11:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D96C433D2;
        Mon, 27 Mar 2023 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679883095;
        bh=hT2F3oWbteAWK6tjWGOdfWl2Yi/cqh8QOd6HM4TCh0M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IosU6VqBzg4Mwbwd+qSHwKF5AonZDXfVR6Gb/GA/0YukmajCP7g/k+Kf/3Od3mzt5
         8JgXTNsuGEqpUeiDyew1chGAaWzLNe4mM8aRp3ZdM9AVruykQE/IdeF2sh/y/QIDI+
         V0HuH7TYld+CgcNclPvVA44zztsai6f87mNji9LnjclI6fkYJPPGL2hwLWeg4pXVcs
         VnJQkRpDkhuAtTXIsNrCzuaGIrhxfST6yhmKPSWsKROjIertardYodxgSY6u/MxUI2
         ZOlNrtjbgLC3G0TVzot1i2GmkH+AXJEv68YYbWlRRLQOeLOMGlFClffzvcnrH3GvbR
         6ALGObNG1esIg==
Date:   Mon, 27 Mar 2023 10:11:26 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Li Yang <leoyang.li@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/23] Update Colibri iMX8X Devicetrees
Message-ID: <20230327021126.GD3364759@dragon>
References: <20230314102410.424773-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314102410.424773-1-dev@pschenker.ch>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 11:23:46AM +0100, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> This patch series does update the device-trees for Colibri iMX8X to the
> latest state of development.
> 
> Adds the Carrier Board device-trees for:
> 
> - Aster
> - Iris
> - Iris v2
> 
> It as well changes the pinmuxing bracket format together with some
> minor fixes.
> 
> Changes in v2:
> - Add -B flag to format-patch for readability
> - Change clock-16mhz-fixed to clock-16mhz
> - Remove status="okay"
> - Added Krzysztof's Acked-by, thanks!
> - Drop patch
>   "arm64: dts: colibri-imx8x: Sort fec1 node alphabetically"
> - Drop patch
>   "arm64: dts: colibri-imx8x: Sort properties"
> - Adapted cover-letter
> 
> Philippe Schenker (23):
>   arm64: dts: colibri-imx8x: Prepare for qxp and dx variants
>   arm64: dts: colibri-imx8x: Update spdx license
>   arm64: dts: colibri-imx8x: Use new bracket format
>   arm64: dts: colibri-imx8x: Add atmel pinctrl groups
>   arm64: dts: colibri-imx8x: Add pinctrl group for csi_mclk
>   arm64: dts: colibri-imx8x: Split pinctrl_hog1
>   arm64: dts: colibri-imx8x: Correct pull on lcdif
>   arm64: dts: colibri-imx8x: Add separate pinctrl group for cs2
>   arm64: dts: colibri-imx8x: Add pinctrl group for hdmi hpd
>   arm64: dts: colibri-imx8x: Add SPI
>   arm64: dts: colibri-imx8x: Add gpio-line-names
>   arm64: dts: colibri-imx8x: Disable touchscreen by default
>   arm64: dts: colibri-imx8x: Add jpegenc/dec
>   arm64: dts: colibri-imx8x: Add colibri pwm b, c, d
>   arm64: dts: colibri-imx8x: eval: Add spi-to-can
>   arm64: dts: colibri-imx8x: Add no-1-8-v to sd-card
>   arm64: dts: colibri-imx8x: Set thermal thresholds
>   arm64: dts: colibri-imx8x: Move gpio-keys to som level
>   arm64: dts: colibri-imx8x: Add todo comments
>   dt-bindings: arm: fsl: Add colibri-imx8x carrier boards
>   arm64: dts: colibri-imx8x: Add aster carrier board
>   arm64: dts: colibri-imx8x: Add iris carrier board
>   arm64: dts: colibri-imx8x: Add iris v2 carrier board

Applied all, thanks!
