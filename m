Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD0E67DFAB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 10:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbjA0JID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 04:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231486AbjA0JIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 04:08:01 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636928A50;
        Fri, 27 Jan 2023 01:07:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87705B81F94;
        Fri, 27 Jan 2023 09:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B68DCC433D2;
        Fri, 27 Jan 2023 09:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674810473;
        bh=8pPQixkLyVGwTAlHM8wO/5r5wtzLG9ukHcqgxxVOpFM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pbi8wdVFnXz/2gUXoFaRAe3lXZB9bUZhCWjJ763aAIuCHI4fsC6nzPKDfiMbMGFq6
         zc8hYALTk/ZLCNQg3KaRVR4xKjEdP+QN8FslIb0uUypGo/+vfPCe2u4Y1EL6Pr7Etk
         03RmTQQRxsjj5UddxpTngpa7gkJF2582oF9pMy68=
Date:   Fri, 27 Jan 2023 10:07:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tom Rix <trix@redhat.com>
Cc:     ysato@users.sourceforge.jp, dalias@libc.org,
        bgolaszewski@baylibre.com, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sh: fix spdx format
Message-ID: <Y9OUZuTbvVpNRrv2@kroah.com>
References: <20230124133941.632974-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124133941.632974-1-trix@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 05:39:41AM -0800, Tom Rix wrote:
> checkpatch reports
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> FILE: arch/sh/include/asm/platform_early.h:1:
> +/* SPDX--License-Identifier: GPL-2.0 */
> 
> Remove extra -
> 
> Fixes: 507fd01d5333 ("drivers: move the early platform device support to arch/sh")
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  arch/sh/drivers/platform_early.c     | 2 +-
>  arch/sh/include/asm/platform_early.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/sh/drivers/platform_early.c b/arch/sh/drivers/platform_early.c
> index 143747c45206..1c2a571a8ab8 100644
> --- a/arch/sh/drivers/platform_early.c
> +++ b/arch/sh/drivers/platform_early.c
> @@ -1,4 +1,4 @@
> -// SPDX--License-Identifier: GPL-2.0
> +// SPDX-License-Identifier: GPL-2.0
>  
>  #include <asm/platform_early.h>
>  #include <linux/mod_devicetable.h>
> diff --git a/arch/sh/include/asm/platform_early.h b/arch/sh/include/asm/platform_early.h
> index fc802137c37d..00b6e6dc4ac4 100644
> --- a/arch/sh/include/asm/platform_early.h
> +++ b/arch/sh/include/asm/platform_early.h
> @@ -1,4 +1,4 @@
> -/* SPDX--License-Identifier: GPL-2.0 */
> +/* SPDX-License-Identifier: GPL-2.0 */
>  
>  #ifndef __PLATFORM_EARLY__
>  #define __PLATFORM_EARLY__
> -- 
> 2.26.3
> 

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
