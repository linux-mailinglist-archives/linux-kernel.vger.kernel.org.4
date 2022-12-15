Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9A064E140
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbiLOSrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:47:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230318AbiLOSrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:47:13 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F1E44D5CD
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 10:46:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCFD761ED2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Dec 2022 18:46:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089D4C433EF;
        Thu, 15 Dec 2022 18:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671130004;
        bh=x9bWYzUxgKuZhJ+ojrxhQJDtwuVcFG5HzxB5nLuRHKY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sujr8PWeAcvVFmpdLc0aXAJetCLKKUuNwx4IITPhRJ9LXXsJn5Z+AKi8V9fDKc/wl
         1/lDsqXJgY2uTHOcO/vu+75GRhpveQ/1a7b5cPewN7Br8hLh7kOqn/PKpuvrF4B6GI
         eMMT7uT48j7XHl4dGAR9BeKze+/FaCLTitqsohoptkgbN48I2OHVC46CziNOyxxRFz
         uBBGzbN0aqgUj6/XwrjROwtu+B1LtGMcfBl1sUSJIli1msi+dabmk9364+UyOSVbm5
         zNSoO5dGwm+5Tka5uFiVGaWLv1hPaPKtKCz+CtT30TpO8kp0xtIZXt1679hwbhih+X
         1fD+9eM9DZoNA==
Date:   Thu, 15 Dec 2022 10:46:42 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add f2fs's patchwork and add Yangtao as a
 reviewer of f2fs
Message-ID: <Y5trkmRJ2LIV2u3V@google.com>
References: <20221215172020.8115-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215172020.8115-1-frank.li@vivo.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Yangtao Li wrote:
> >From now on, f2fs also has its own patchwork link, thanks to Jaegeuk
> for starting this tool. Let's update it to f2fs entry.
> 
> I've been focusing on android storage (especially f2fs) for the past
> two years. And I volunteered to be a f2fs reviewer, add my email address
> in maintainship entry of f2fs.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  MAINTAINERS | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a608f19da3a9..655a8b68b332 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7886,9 +7886,11 @@ F:	drivers/iommu/exynos-iommu.c
>  F2FS FILE SYSTEM
>  M:	Jaegeuk Kim <jaegeuk@kernel.org>
>  M:	Chao Yu <chao@kernel.org>
> +R:	Yangtao Li <frank.li@vivo.com>

Sorry, I don't see the level of your work to reach out to this.

>  L:	linux-f2fs-devel@lists.sourceforge.net
>  S:	Maintained
>  W:	https://f2fs.wiki.kernel.org/
> +Q:	https://patchwork.kernel.org/project/f2fs/list/
>  B:	https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git
>  F:	Documentation/ABI/testing/sysfs-fs-f2fs
> -- 
> 2.25.1
