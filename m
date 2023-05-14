Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31832701B72
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 05:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjEND6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 23:58:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjEND6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 23:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715FA1FED;
        Sat, 13 May 2023 20:58:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0E2A56143D;
        Sun, 14 May 2023 03:58:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47A7C433EF;
        Sun, 14 May 2023 03:58:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684036699;
        bh=mYGPU0cFGm7qK1AgVsO6OENE7OEFNoQDy2Iu9eodTXQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jDpSsuCqQAJsUiHheG/z7M57cxbi8n27LvA01QJAwgH4Hm1G3BsU9totWcKJGoxsJ
         W1QsDV8hSZWj9iK4xrRkXsgdiW4cCv/F38ej6vQdaDt5slzOz0ZGNAZ8Z9rhSkAfyc
         lxXcFiAgEKLjpaZAyf/ds3tVxlM+6JjvjAUqsiDad72RJK8Y39eZB3V8WcsoQMxYoW
         KhqoBfnbM7+0KNiLba6QB6EaD4b7eocZxG6En9Sm5PUj2/LdGc6KQ3In5qDPrkauI3
         vv6fmYXZ1lfr8ZGOoeg8EbxrClu0H9cfPI70f6/Gsic+XVX7tRKMKrE5VqstLLAJgl
         FphPdKXR0i+Rw==
Date:   Sun, 14 May 2023 11:58:06 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, aford@beaconembedded.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] arm64: dts: imx8mn: Fix video clock parents
Message-ID: <20230514035806.GR727834@dragon>
References: <20230423123513.1346323-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230423123513.1346323-1-aford173@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 23, 2023 at 07:35:13AM -0500, Adam Ford wrote:
> There are a few clocks whose parents are set in mipi_dsi
> and mxsfb nodes, but these clocks are used by the disp_blk_ctrl
> power domain which may cause an issue when re-parenting, resuling
> in a disp_pixel clock having the wrong parent and wrong rate.
> 
> Fix this by moving the assigned-clock-parents as associate clock
> assignments to the power-domain node to setup these clocks before
> they are enabled.
> 
> Fixes: d825fb6455d5 ("arm64: dts: imx8mn: Add display pipeline components")
> Signed-off-by: Adam Ford <aford173@gmail.com>

Is it a fix for v6.4-rc or material for -next?

Shawn
