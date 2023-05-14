Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F41701D82
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 15:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234676AbjENNAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 09:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230496AbjENNAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 09:00:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F9351BF6;
        Sun, 14 May 2023 06:00:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2118160C52;
        Sun, 14 May 2023 13:00:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71E0C433D2;
        Sun, 14 May 2023 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684069202;
        bh=CbrJy/Ijqi82NhC+AkKPoENaVTukFKVJIDC9dx6RRX4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmeYN29nPYO9jhGKgvmLJ2YX+HY+PuiS+D/PYWJH471tOgJrPDzggvHId39E1OwxY
         MrMF/h47GfNl3mI8EsfjCNafHSk7WA4B6kN94vvR/5bBR6Q7S6m5SeeoYRMK6W//5M
         bEaIQDcmkc+uIgRCZcJ28aquV6IAk46+Pkpl7o7Y/dTJpff6DoFvt+3Aml/9pLFIKq
         oU1NbvzXXKZrJWPUk+6K6rcYW3/tpst6LSrBYjBGxKgEFnbxmD+LoQt2MxubWdVbWf
         bgLZydc2iUpvqD/kyZDFHwEefp4kBL1MjK4Lnkb/dMRJ2943jIMTZ1wePcU3s6TFIL
         bubjXy9rGXJoA==
Date:   Sun, 14 May 2023 20:59:46 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Christoph Niedermaier <cniedermaier@dh-electronics.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Marek Vasut <marex@denx.de>,
        Fabio Estevam <festevam@denx.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        kernel@dh-electronics.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: imx6ull-dhcor: Set and limit the mode for PMIC
 buck 1, 2 and 3
Message-ID: <20230514125946.GV727834@dragon>
References: <20230502111424.3114-1-cniedermaier@dh-electronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230502111424.3114-1-cniedermaier@dh-electronics.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 01:14:24PM +0200, Christoph Niedermaier wrote:
> According to Renesas Electronics (formerly Dialog Semiconductor), the
> standard AUTO mode of the PMIC DA9061 can lead to stability problems
> depending on the hardware revision. It is recommended to set a defined
> mode such as PFM or PWM permanently. So set and limit the mode for
> buck 1, 2 and 3 to a fixed one.
> 
> Fixes: 611b6c891e40 ("ARM: dts: imx6ull-dhcom: Add DH electronics DHCOM i.MX6ULL SoM and PDK2 board")
> 
> Signed-off-by: Christoph Niedermaier <cniedermaier@dh-electronics.com>
> Reviewed-by: Marek Vasut <marex@denx.de>

Applied, thanks!
