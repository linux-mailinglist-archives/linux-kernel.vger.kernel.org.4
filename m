Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94B7B5F7F41
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbiJGUuL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiJGUuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:50:09 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B0C58B69;
        Fri,  7 Oct 2022 13:50:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8EA51CE1923;
        Fri,  7 Oct 2022 20:50:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF73CC433D6;
        Fri,  7 Oct 2022 20:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665175804;
        bh=0COepWKyJnS9dnJU4MRagprS9XKGb+mdMm+zs9Dr6HE=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=R/n6C/ZHW3VrvpAReWY3qdvA79riZ/1MusojdeFSgo0zXBaJuWF7/EsFlejjbdhbA
         HfYNa/R/vjeOfG/cbXSRt/c/QWLPU3V9wvdIj+Wvl9FQq6g5Rm2k99ZyvUKGNKOS50
         w2TSPMmU0MRzpxFZu/fxXw5XDLhjbB78YGRG8IOt+9TnWwAHBD6KJEItHTx8IENWFn
         4TlrGPMGu2JRkkeI2o5Xdt0DmziV+Gb4TybLkj5whz0J+5Pniku6VSb3hsWPNtpGeT
         zf/+7P5+ET0o/PlhsGhQzf9/LrhWMPJyBCcAgWVN6rw25vZiipnF+cWQsRxAWgENp5
         VpRZ1Y7utai9A==
Date:   Fri, 7 Oct 2022 13:50:01 -0700 (PDT)
From:   Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To:     Colin Ian King <colin.i.king@gmail.com>
cc:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: Kconfig: Fix spelling mistake "Maxmium" ->
 "Maximum"
In-Reply-To: <20221007203500.2756787-1-colin.i.king@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2210071349510.3690179@ubuntu-linux-20-04-desktop>
References: <20221007203500.2756787-1-colin.i.king@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Oct 2022, Colin Ian King wrote:
> There is a spelling mistake in a Kconfig description. Fix it.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
>  drivers/xen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> index a65bd92121a5..d5d7c402b651 100644
> --- a/drivers/xen/Kconfig
> +++ b/drivers/xen/Kconfig
> @@ -56,7 +56,7 @@ config XEN_MEMORY_HOTPLUG_LIMIT
>  	depends on XEN_HAVE_PVMMU
>  	depends on MEMORY_HOTPLUG
>  	help
> -	  Maxmium amount of memory (in GiB) that a PV guest can be
> +	  Maximum amount of memory (in GiB) that a PV guest can be
>  	  expanded to when using memory hotplug.
>  
>  	  A PV guest can have more memory than this limit if is
> -- 
> 2.37.3
> 
