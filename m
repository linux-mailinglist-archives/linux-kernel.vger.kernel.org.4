Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85621661FD4
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjAIITx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:19:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233473AbjAIITu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:19:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB65563AA;
        Mon,  9 Jan 2023 00:19:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75CA360F3D;
        Mon,  9 Jan 2023 08:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41E0C433EF;
        Mon,  9 Jan 2023 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673252388;
        bh=BWUWJ0eMw9I0fwuSdKoCjyh0xw/L5wuHy5pALgQSdrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=av7nnm7Zh8D7VOlkfwLg9fWjGK22TSMKMsT7C6l2tWuua/E659Bx3ZYO3whglpTh8
         a0pbLi0Zu+3yfRuZpNIR7oPFsG2hEmDUU1OgyL0t2A5LxO4pXJ9T0hVNd47rqalH36
         QMFycdjkLkTuuTSY68+6f/ywRhbc8ep7hITCvqtD4alS/drhqZWucx6UguHWWnGBRO
         Mbe6bnYuN21sZIGE/LEEm1uOlIwH5Pc3O250ciAsRgJSpebFeaKBdvOopjBZI+QQnQ
         J/7QAQyBPfal2znuuWUBb2CVKI20iqBCJR+D2hCcvA7cpQfIApbpYVHRep4eRl0NAL
         GUsjmXsxuA68w==
Date:   Mon, 9 Jan 2023 16:19:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Frank Li <Frank.Li@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Peng Fan <peng.fan@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v2 2/5] arm64: dts: fsl-imx8qm-device.dtsi: add
 io-channel-cells to adc nodes
Message-ID: <20230109081940.GG18301@T480>
References: <20230102171023.33853-1-marcel@ziswiler.com>
 <20230102171023.33853-3-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102171023.33853-3-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 06:10:19PM +0100, Marcel Ziswiler wrote:
> From: Max Krummenacher <max.krummenacher@toradex.com>
> 
> This commit adds io-channel-cells property to the ADC nodes. This
> property is required in order for an IIO consumer driver to work.
> Especially required for Apalis iMX8 QM, as the touchscreen driver
> uses ADC channels with the ADC driver based on IIO framework.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

fsl-imx8qm-device.dtsi in subject?

Shawn

> ---
> 
> (no changes since v1)
> 
>  arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> index a943a1e2797f..6e5ef8b69bf8 100644
> --- a/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx8-ss-dma.dtsi
> @@ -270,6 +270,7 @@ i2c3: i2c@5a830000 {
>  
>  	adc0: adc@5a880000 {
>  		compatible = "nxp,imx8qxp-adc";
> +		#io-channel-cells = <1>;
>  		reg = <0x5a880000 0x10000>;
>  		interrupts = <GIC_SPI 240 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> @@ -284,6 +285,7 @@ adc0: adc@5a880000 {
>  
>  	adc1: adc@5a890000 {
>  		compatible = "nxp,imx8qxp-adc";
> +		#io-channel-cells = <1>;
>  		reg = <0x5a890000 0x10000>;
>  		interrupts = <GIC_SPI 241 IRQ_TYPE_LEVEL_HIGH>;
>  		interrupt-parent = <&gic>;
> -- 
> 2.35.1
> 
