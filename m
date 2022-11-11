Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47436253F5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 07:43:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbiKKGnH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 01:43:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232583AbiKKGnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 01:43:05 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C3B27CD0;
        Thu, 10 Nov 2022 22:43:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A4365CE24F4;
        Fri, 11 Nov 2022 06:43:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51E7EC433D6;
        Fri, 11 Nov 2022 06:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668148981;
        bh=K3pgQ075aB1kFFQS6S2jJqCrDZ8OxMvVb/ppEUQtMVI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NbKzq8wrgXEkCu0GO7R0zADxdGm+tSToYOrKROtS9jjjESLnq95TbsdR/sxeVyu1n
         wSYcUGjP2DL47KPkrT7R4u3LHdrwHBNj5qfNyQvtsDDLDlEwbnXoou3geURklXevix
         9v5+lbwNTLxkWbM3HHDdjJDyc71/aCWn1BZReLweLawsOe/ZD3I99lz/lgonCgt5wh
         CZYH4HsDHLEVYQhGjj3sK7Ne0id7dszTZdJ8207psHHf4QLRyRCqHiPqNBB73LfjuL
         ZW08wexeB0Aq0GdouYdXxkJK+JSh/8GjojfKzcUQA9YZQUI3hiX+dhT4/nOhalbM2s
         mm8h7DSyGV3gw==
Date:   Fri, 11 Nov 2022 14:42:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: dts: imx93-pinfunc: drop execution permission
Message-ID: <20221111064254.GL2649582@dragon>
References: <20221104054942.1696344-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221104054942.1696344-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:49:42PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Drop the header file execution permission
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Added Fixes tag below:

Fixes: ec8b5b5058ea ("arm64: dts: freescale: Add i.MX93 dtsi support")

Applied, thanks!
