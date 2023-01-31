Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68484682BDD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 12:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjAaLwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 06:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjAaLwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 06:52:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C7101
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 03:52:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 19E5B614D5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28AC4C433D2;
        Tue, 31 Jan 2023 11:52:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675165936;
        bh=TkDgebvBcy1nAPBeWdAqve5nYhA8Jlh68COgNvMgJq8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEw/isx6nokL5MQajzj0UenWpA26QRuZ9I9TS7D7SPAGyG8zFlRvvnkNHwRsBZUhB
         Bv5NamFV1ZUxxQdxm4mdYEWV6Bsu9zZ7z41P1nX1WYFElOVcDCIlPacUqvdgD9yv9x
         PhvaZcAKTM2D9vSiSBtl8SblcXIROWm5J4arqWiY=
Date:   Tue, 31 Jan 2023 12:52:13 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: Restore alignment and newline in Makefile
Message-ID: <Y9kA7RRfZx1drk5e@kroah.com>
References: <20230124104145.3962497-1-geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230124104145.3962497-1-geert+renesas@glider.be>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2023 at 11:41:45AM +0100, Geert Uytterhoeven wrote:
> The introduction of drivers/accel/ broke alignment, and removed the
> newline at the end of the file.  Fix all of that.
> 
> Fixes: 35b137630f08d913 ("accel/ivpu: Introduce a new DRM driver for Intel VPU")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  drivers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/Makefile b/drivers/Makefile
> index f0972e2226c97cb5..9ea6eb3b5d7b7f17 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -189,4 +189,4 @@ obj-$(CONFIG_COUNTER)		+= counter/
>  obj-$(CONFIG_MOST)		+= most/
>  obj-$(CONFIG_PECI)		+= peci/
>  obj-$(CONFIG_HTE)		+= hte/
> -obj-$(CONFIG_DRM_ACCEL)	+= accel/
> \ No newline at end of file
> +obj-$(CONFIG_DRM_ACCEL)		+= accel/
> -- 
> 2.34.1
> 


Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
