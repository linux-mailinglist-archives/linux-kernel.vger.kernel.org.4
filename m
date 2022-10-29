Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54381611F02
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbiJ2BVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiJ2BVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:21:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEAC1D52D9;
        Fri, 28 Oct 2022 18:21:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4ED1A62B3D;
        Sat, 29 Oct 2022 01:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5480FC433C1;
        Sat, 29 Oct 2022 01:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667006475;
        bh=5TkdmKtr0vd4StVEShzYTsdB+zVnMpjpJrgmlbn67jY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JUm4EulxAMUPNQASBBnrXSseDx8YhEzI4TMBwvwpTWNdXizoHnFjVyV9B2hoycJ2s
         wdhnF/d2kXMBqZUwpWWypdv4rnzjCur5XW2cJsDZU71mIY5HDLhyyA68w92vlkjq/P
         sw51d06jTIeAp/y75GNMhX8dtOeLcXASVJpOn04PRMMiv1XJzhtqteU5XVmMs+ZM/t
         Zy8ZeCeToYTEXNXaek5qqS9T0lrH5FpOT0LAD9Y2M1aNFphhl0hjJYWHV6J9+GtGbh
         OdpUfZjS9mvHHHIprO+NhzjugwME6RzKaKUng6fs/1OsjJFy/IBd1GEhB1Ab9SGugp
         DPGiYoogT1a/w==
Date:   Sat, 29 Oct 2022 09:21:08 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx8: correct clock order
Message-ID: <20221029012108.GH125525@dragon>
References: <20221010100747.289644-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010100747.289644-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 06:07:47PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Per bindings/mmc/fsl-imx-esdhc.yaml, the clock order is ipg, ahb, per,
> otherwise warning: "
> mmc@5b020000: clock-names:1: 'ahb' was expected
> mmc@5b020000: clock-names:2: 'per' was expected "
> 
> Fixes: 16c4ea7501b1 ("arm64: dts: imx8: switch to new lpcg clock binding")
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Applied, thanks!
