Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFA1627780
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 09:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236392AbiKNIZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 03:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236289AbiKNIZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 03:25:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E1C46461;
        Mon, 14 Nov 2022 00:25:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0490F60F06;
        Mon, 14 Nov 2022 08:25:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20AE8C433C1;
        Mon, 14 Nov 2022 08:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668414325;
        bh=mEWDDGfOvzODYr1Wo+Lm67meG8rILRHSmSM3ZZZ4HkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mZJ0mhDyMraRf77awQWX5pRoxAmoEe4QLq2cUvKaPicTOxQ00hA8HGff3NrBWIIYD
         /g4uqg/BQyH1en/eAHzslwdiOPP85MpRE+V+ZpZasN6sZNv6VRjcyRLfjE95gKZr3c
         pHIWqhnbmyuR9Oo/5jUoqNtMz9K5ScMcK+MakcJzpfurjGwfud0WKwbNPO6+kiG+BD
         Ei9ClUEyvFuT1NV6U2G18SwSvHjCBodxi37dng0Xy7AOs5j1hBVOHHg7jk5lB9V4us
         PtmNceN4mpJhbqUJ7Wca9GYvi2ZJHbhDiPQW06Ao4r8sGTWD+3s7oPbsjdkN7Mhqm0
         xQ3ggIwKE9Ilg==
Date:   Mon, 14 Nov 2022 16:25:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] ARM: dts: imx6qdl-sabre: Add mmc aliases
Message-ID: <20221114082518.GS2649582@dragon>
References: <20221028141811.101122-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221028141811.101122-1-detlev.casanova@collabora.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 10:18:11AM -0400, Detlev Casanova wrote:
> If not specified, the mmc0 and mmc1 devices will be the devices
> mmc@2190000 and mmc@2194000, which are in disabled state on the iMX.6
> Sabrelite devices.
> 
> The actual SD card reader devices are the ones at mmc@2198000 and
> mmc@219c000.
> 
> Set aliases to use the correct mmc devices order.
> 
> Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>

Applied, thanks!
