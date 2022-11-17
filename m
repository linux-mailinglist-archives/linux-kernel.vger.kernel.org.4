Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FC762E4C4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 19:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239778AbiKQSuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 13:50:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234802AbiKQSua (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 13:50:30 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E9635917F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 10:50:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D1F6CE1E60
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 18:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16F1C433D6;
        Thu, 17 Nov 2022 18:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1668711025;
        bh=fs0+884Rrp2ydND1a+01LKBd9qfdHL/I8ilA5m9iX/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DUuE2gRnahBKuyvdosL624a3uTa22KUYNAIL7aowwYNXSjrY8dCG5NFZsfr1sJTpj
         KiMKWwsUg+Y/6g4q5yDRBUVA3bBjjuMipaTXHHx1P+45aPO2CV4EnaoyxypS+8I191
         Nds7XZwtF7f6CYiFNj47O+AZh3GfaL7ihww7vzd8=
Date:   Thu, 17 Nov 2022 19:49:59 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Brent Pappas <bpappas@pappasbrent.com>
Cc:     johan@kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] staging: gdm724x: Replace macro GDM_TTY_READY with
 static inline function
Message-ID: <Y3aCV4rSrfrptA0q@kroah.com>
References: <20221116192412.22446-1-bpappas@pappasbrent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116192412.22446-1-bpappas@pappasbrent.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 02:24:13PM -0500, Brent Pappas wrote:
> Replace the macro GDM_TTY_READY with a static inline function
> to follow the Linux kernel coding style.
> 
> Signed-off-by: Brent Pappas <bpappas@pappasbrent.com>
> ---
>  drivers/staging/gdm724x/gdm_tty.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
> index cc6d80554c98..93d50d42a367 100644
> --- a/drivers/staging/gdm724x/gdm_tty.c
> +++ b/drivers/staging/gdm724x/gdm_tty.c
> @@ -21,7 +21,10 @@
>  
>  #define MUX_TX_MAX_SIZE 2048
>  
> -#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
> +static inline int gdm_tty_ready(struct gdm *gdm)

Why is this "int" and not "bool"?

thanks,

greg k-h
