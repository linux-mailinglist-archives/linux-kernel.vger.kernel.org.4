Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20F16AB500
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 04:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjCFDQa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 22:16:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCFDQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 22:16:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B30C11E80;
        Sun,  5 Mar 2023 19:16:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DAF8F60B67;
        Mon,  6 Mar 2023 03:16:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88EDBC433D2;
        Mon,  6 Mar 2023 03:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678072584;
        bh=eGvVMoFvfG2F4lUb2FeujEuUejqsOzn7laCzCMspLF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ln3G+Be+35G+J9qKbwqODu6MV/M4WYSB1E5wgSGllo7jn6TAKmA+TDCusxnWtWjg7
         9vEosxMadqwDzkz4uVSuGVHAgdCDF6buPnRRLRFLKd+63k32m4ijBVFpno+L7J/r5D
         6Dhdlcv9UCj5TRTT7O2xpccV/J/Va5sBo29Xd+4v4e0mM4PnLBWVFtP2qsv8XXLEHT
         UM7WaCnhwX8nD3FnGDxowNaKhxP6UXyhGtHwHu/ePMu9sTSnMU2VMmfa/iJ1BglTxx
         N8AfirM0HC7pFKSZMVxb/wf+xPB5VBQLRSIPurvSJbSne9bBLp7sE5d3Rk4mEJ8JrE
         5crmKqoiLSL9g==
Date:   Mon, 6 Mar 2023 11:16:09 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, linux-imx@nxp.com,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Fabio Estevam <festevam@denx.de>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Ming Qian <ming.qian@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shijie Qin <shijie.qin@nxp.com>,
        Tim Harvey <tharvey@gateworks.com>
Subject: Re: [PATCH v7 00/10] arm64: dts: freescale: prepare and add apalis
 imx8 support
Message-ID: <20230306031609.GH143566@dragon>
References: <20230208065641.23544-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230208065641.23544-1-marcel@ziswiler.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 08, 2023 at 07:56:31AM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> Add support for lsio_pwm0-3, add io-channel-cells property for ADC
> nodes, set lpspi0 max frequency to 60MHz, add missed LVDS lpi2c and PWM
> power domains, add flexcan in adma, add can node in devicetree, add vpu
> decoder and encoder, add toradex,apalis-imx8 et al. to dt-bindings and
> finally, add initial support for Apalis iMX8 split into module and
> carrier board parts.
> 
> Changes in v7:
> - Re-order device tree properties according to various more or less
>   undocumented rules as e.g. pointed out by Shawn. Thanks!
> 
> Changes in v6:
> - Add Alexander's acked-by. Thanks!
> - Add Alexander's tested-by. Thanks!
> - Incorporate Shawn's review feedback. Thanks!
> 
> Changes in v5:
> - Update subject prefix as pointed out by Krzysztof. Thanks!
> - Remove LVDS PWM support waiting for Liu's patches to land first.
> - Remove bkl1_pwm functionality depending on the above.
> - Squashing all Apalis iMX8 specific device tree patches. As outlined by
>   Krzysztof reviewers may simply use b4 diff.
> 
> Changes in v4:
> - New patch inspired by the following downstream patch:
>   commit 0c36c5b63c1e ("LF-3569-1 firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains")
>   Avoiding the following being reported upon boot:
>   [    1.309776] lvds0_pwm0_clk: failed to attached the power domain -2
>   [    1.334097] lvds1_pwm0_clk: failed to attached the power domain -2
>   ...
>   [   15.281767] platform 57244000.pwm: deferred probe pending
>   ...
>   [   15.292630] platform backlight: deferred probe pending
> - New patch combining the following downstream patches:
>   commit e8fe3f57223a ("arm64: dts: imx8qxp: add FlexCAN in adma")
>   commit 4e90361f1ed3 ("arm64: dts: imx8qxp: add multi-pd support for CAN1/2")
>   commit 899f516e61f8 ("arm64: dts: imx8: dma: fully switched to new clk binding")
>   commit 8a28ca15a058 ("arm64: dts: imx8qxp: drop multi-pd for CAN device")
>   commit c493402197dd ("arm64: dts: imx8: update CAN fsl,clk-source and fsl,scu-index property")
> - New patch inspired by the following downstream patch:
>   commit 117607e6a7b5 ("arm64: dts: imx8qm: add CAN node in devicetree")
> - New patch combining the following downstream patches:
>   commit 4f2147ce6f0e ("arm64: dts: imx8qm: add vpu decoder and encoder")
>   commit 0c9f9b64d27d ("LF-6575: imx8q: vpu: switch to amphion upstream driver")
> - Shorten subject.
> 
> Changes in v3:
> - Fix subject as pointed out by Shawn. Thanks!
> - Properly accommodate for -v1.1 modules curtsey Francesco.
> - Only use V1.1 compatible for V1.1 module dtsi.
> - Split patch into separate module and carrier boards parts as suggested
>   by Shawn.
> - Put reg after compatible as requested by Shawn.
> - Move atmel_mxt_ts and rtc_i2c into module dtsi to save such
>   duplications as suggested by Shawn.
> - Change iomuxc pinctrl indent style as suggested by Shawn.
> - Change led node names to the preferred first form as suggested by
>   Shawn. While at it also add color (yikes), default-state and function
>   properties and remove the deprecated label property.
> - Put enable-active-high properties after the gpio ones as suggested by
>   Shawn. Thanks!
> - Remove adc node's vref-supply and accompanying reg_vref_1v8 regulator
>   node.
> - Rename gpio-hogs adherring to dt schema naming convention.
> 
> Changes in v2:
> - Fixed missing space in the comment V1.1Module curtsey Max.
> - Added Rob's ack.
> 
> Clark Wang (1):
>   firmware: imx: scu-pd: add missed lvds lpi2c and pwm power domains
> 
> Joakim Zhang (2):
>   arm64: dts: imx8qxp: add flexcan in adma
>   arm64: dts: imx8qm: add can node in devicetree
> 
> Marcel Ziswiler (3):
>   dt-bindings: arm: fsl: add toradex,apalis-imx8 et al.
>   arm64: dts: freescale: add initial apalis imx8 aka quadmax module
>     support
>   arm64: dts: freescale: add apalis imx8 aka quadmax carrier board
>     support
> 
> Max Krummenacher (1):
>   arm64: dts: imx8-ss-dma: add io-channel-cells to adc nodes
> 
> Philippe Schenker (2):
>   arm64: dts: freescale: imx8-ss-lsio: add support for lsio_pwm0-3
>   arm64: dts: freescale: imx8-ss-dma: set lpspi0 max frequency to 60mhz
> 
> Zhou Peng (1):
>   arm64: dts: imx8qm: add vpu decoder and encoder

Applied all, thanks!
