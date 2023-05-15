Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45B6D70221F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbjEODT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjEODTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:19:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7EDA0;
        Sun, 14 May 2023 20:19:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB6C161E14;
        Mon, 15 May 2023 03:19:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7180C433D2;
        Mon, 15 May 2023 03:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684120793;
        bh=ZSQSxTNZYiDWFcAg4CYN5nDMCvhvKUYX3NusPAoh62U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=reoFjylxOK8UL1/PL0o1UELLeW1lkmuuRTyYv8vL7RzY9uLHNPoOgiOKwNp+r5oMe
         cCjsfHVToL5J/nIqrd0jrRW12kVRuxUxf5h/uKqL+AcBSepCSjuiWiImNeUXA/K1+G
         Vu5723N5/fO+8daHhVPMZ/jN8Ia8sa1roQaAa/g5WoRjzGL8FWC9SlOja9nLyzmGe2
         I2k9xHLRYwrIDzPnvsXwhkri4moXYtHdWQyyf3hC2IrJvWG2OX1qgsxdWMLSIxnnJl
         1UquGVo1uueFj/UquDiuNPJn40z8Q2MiZiKPJQtkpBSfTmjBw/RYzTtD6AyGy9xHth
         cB0xkb0NaHenQ==
Date:   Mon, 15 May 2023 11:19:41 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v2 0/4] arm64: dts: colibri-imx8x: misc fixes
Message-ID: <20230515031941.GE767028@dragon>
References: <20230514092246.9741-1-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514092246.9741-1-francesco@dolcini.it>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 11:22:42AM +0200, Francesco Dolcini wrote:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> This series fixes a few small issues on the just introduced Colibri iMX8X:
> 
> * Remove duplicate GPIO3_IO01 pin configuration
> * Remove GPIO3_IO01 pin configuration from SoM level
> * Delete non-existing i.MX8X peripherals adc1 and dsp
> 
> In addition to that a small cleanup patch is added
> * Move iomuxc pinctrl from SoM to carrier board level
> 
> v2:
>  - remove stray newline after Fixes: tag
>  - fixed from patch From:
> 
> Andrejs Cainikovs (1):
>   arm64: dts: colibri-imx8x: delete adc1 and dsp
> 
> Emanuele Ghidoli (3):
>   arm64: dts: colibri-imx8x: fix eval board pin configuration
>   arm64: dts: colibri-imx8x: move pinctrl property from SoM to eval
>     board
>   arm64: dts: colibri-imx8x: fix iris pinctrl configuration

Applied all, thanks!
