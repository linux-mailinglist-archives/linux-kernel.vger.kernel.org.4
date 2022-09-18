Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4FBB5BBE2F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 15:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiIRNte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 09:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiIRNta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 09:49:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4F3C17
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 06:49:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9DEAB80FF0
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 13:49:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE916C433D6;
        Sun, 18 Sep 2022 13:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663508965;
        bh=b9e71F3nMW7cIsiR4wi0l6hkI8dVVqpIwHBb+/eFsLc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pCAlmFkDeRC+AmLbAAxtBpNPbWcnPkGwNCgwE8VlNrYfBSjlifMtSYS97q+/NKFkb
         B2LCGod2DxM7N4zUvoUX9FqCY3JMRKAbRPwqaS/rg0m3OnaT3r9L9CLNZZf/+xdG1k
         j/QPEamLZ4APABsLJ38uaHFQEdRbJnT8numeEEfk=
Date:   Sun, 18 Sep 2022 15:49:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Valentin Vidic <vvidic@valentin-vidic.from.hr>
Cc:     Philipp Hortmann <philipp.g.hortmann@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192e: fix CamelCase struct member
Message-ID: <YyciAPSyyusp1eCR@kroah.com>
References: <20220918114926.3809060-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220918114926.3809060-1-vvidic@valentin-vidic.from.hr>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 18, 2022 at 01:49:26PM +0200, Valentin Vidic wrote:
> Fix checkpatch warnings for struct member pFirmware.
> 
> Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
> ---
>  drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c      | 8 ++++----
>  drivers/staging/rtl8192e/rtl8192e/r8192E_firmware.c | 4 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c        | 8 ++++----
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.h        | 2 +-
>  4 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> index 4b9249195b5a..6308a25e064c 100644
> --- a/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> +++ b/drivers/staging/rtl8192e/rtl8192e/r8192E_dev.c
> @@ -707,19 +707,19 @@ bool rtl92e_start_adapter(struct net_device *dev)
>  		rtl92e_writeb(dev, ANAPAR, 0x37);
>  		mdelay(500);
>  	}
> -	priv->pFirmware->status = FW_STATUS_0_INIT;
> +	priv->pfirmware->status = FW_STATUS_0_INIT;

What does "pfirmware" mean here?

If you fix up camelcase warnings, please do so in a way that is the
proper Linux kernel style, not just making everything lowercase.

Look up Hungarian notation and why the original was named this way and
why this isn't needed in Linux at all (i.e. we have modern compilers.)

thanks,

greg k-h
