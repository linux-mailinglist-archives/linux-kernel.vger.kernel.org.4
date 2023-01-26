Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0825167C190
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 01:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjAZA2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 19:28:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjAZA2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 19:28:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A1E64691;
        Wed, 25 Jan 2023 16:28:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7C5ED615B1;
        Thu, 26 Jan 2023 00:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFD1C433EF;
        Thu, 26 Jan 2023 00:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674692885;
        bh=mK7pUHAwW539DNx0MZMEc4ufymm0deRp1E6PpwowmRY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J/liQQE7HmYbPTzCwiqzQ81sctCbpCd14PsCupfz5xHNoyKcTba3ix74hzVWnuSzE
         5HSr5ABsWYEOk75hLRL5MyzC9ME3SMGRvNPuHCEbtfH3+DRFvoI2ngT9TKg08URFS1
         e+oU6npIPzBaw1kaoI2n+Yw7GmnOXIi43idYvWpslcn6rUXbizLgCa3VXueEbbqsKI
         ybH8fqN8fLuRk4ccU1KWTrYtk4FD9TAspyLGXASyl4YDwNIFWmIjvjk4MZeIrqH6Md
         A+jHPK6H7LAFTtN3XmelidmPcKBlhsSlYMGSoSn43NECkX6IRrhOXxBEHSx5HSVbD9
         ZEcZ1ccYJBIzA==
Date:   Thu, 26 Jan 2023 08:27:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: [PATCH v1 0/4] ARM/arm64:
 apalis/colibri-imx6/6ull/7/verdin-imx8mp: gpio-key node names
Message-ID: <20230126002744.GM20713@T480>
References: <20230109132001.43489-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230109132001.43489-1-marcel@ziswiler.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 02:19:57PM +0100, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> 
> This series unifies/fixes wakeup gpio-key node names across all Toradex
> modules. And yes, the Tegra-based Apalis/Colibri T20/T30/TK1 already
> look good (;-p).
> 
> 
> Marcel Ziswiler (4):
>   ARM: dts: colibri-imx6: improve wake-up with gpio key
>   ARM: dts: colibri-imx6ull: improve wake-up with gpio key
>   ARM: dts: apalis/colibri-imx6/6ull/7: proper gpio-key node names
>   arm64: dts: verdin-imx8mp: unify gpio-key node name

Applied all, thanks!
