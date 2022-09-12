Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1955B580A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiILKSQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbiILKSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:18:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8132C108
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:18:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6E77B80CB1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 10:18:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B32C433C1;
        Mon, 12 Sep 2022 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662977885;
        bh=iqmiT97K74i/uK+dEhH6wx1JLJEwqi7bJwNDEH97cYY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gIOFRnveklHNi6XvVb3qGyM8/5j08ZbFhzZKM/KeXRMyd/Eopr42IbT0W0Gj82zCO
         xbg8xfxXNeHOVSCCD7iaE9SN/xRfn7oxWHzTgAL+sjgvkCZeQlWrM78ELMz8KMVQke
         /NQNxaxRMoDkjUq534wm3ELhPueAeQm3asGpNGFRkgvgQ9Lj8WPhH8fI7NGEvpLKUg
         4FJyNDOb+klD+oFpH0UOLTcfm6mXG6YFF4ojQMgxPzHoGnNI9bvFsXtMNHeJObLDvK
         +3Zxs01sPGaqOppYPWsmfBE3uM+KMzCoX0LIRtgMjhiAVgXa1PRDWmry+1y+sIn4kQ
         TH+WQqSPuVo+Q==
Date:   Mon, 12 Sep 2022 18:17:59 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     s.hauer@pengutronix.de, catalin.marinas@arm.com, will@kernel.org,
        arnd@arndb.de, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH] arm64: defconfig: select ARCH_NXP
Message-ID: <20220912101759.GB1728671@dragon>
References: <20220908003914.2062126-1-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908003914.2062126-1-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 08:39:14AM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> commit 566e373fe047 ("arm64: Kconfig.platforms: Group NXP platforms
> together") groups NXP platforms with ARCH_NXP, which cause the default
> build not support i.MX with arm64 defconfig, so default enable ARCH_NXP
> to resolve the issue.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Thanks for the patch, Peng!  But I have queued a patch [1] from Michael.

Shawn

[1] https://lore.kernel.org/linux-arm-kernel/20220907070626.2933998-1-michael@walle.cc/T/

> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 91e58cf59c99..07b9185f5937 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -47,6 +47,7 @@ CONFIG_ARCH_KEEMBAY=y
>  CONFIG_ARCH_MEDIATEK=y
>  CONFIG_ARCH_MESON=y
>  CONFIG_ARCH_MVEBU=y
> +CONFIG_ARCH_NXP=y
>  CONFIG_ARCH_MXC=y
>  CONFIG_ARCH_NPCM=y
>  CONFIG_ARCH_QCOM=y
> -- 
> 2.37.1
> 
