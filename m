Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ACD6C8DF9
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:24:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjCYMYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCYMYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:24:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7BC2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:24:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68DB8B80522
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:24:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E051C433EF;
        Sat, 25 Mar 2023 12:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679747039;
        bh=kLW3bmDLmdHo5VE4SH0Ou0TcjVXcfRrwI6drKo1hNf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oBvgol+1/sr18a9BQ/pW3qSTHJ90sI75+KhHoSW0J1EBDXnmXUBevZkkPnM6nGZv+
         6nFUYvAH3nIoqsyGwgMCBj6yLEYu/9sZisNxVPd1efB3Puow/5hxGB/X5vpz6+0A2n
         6J1/slbIo8CIyEagkhhPhiCCLQylqcS0/iR1DUw4=
Date:   Sat, 25 Mar 2023 13:23:55 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8192u: remove change history from
 comments
Message-ID: <ZB7n23tzWxGmBPe4@kroah.com>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
 <c4ec9246e2d103c15e451fe3d6ed42692c93d39f.1679744684.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4ec9246e2d103c15e451fe3d6ed42692c93d39f.1679744684.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 05:13:17PM +0500, Khadija Kamran wrote:
> Developers use git to browse the file history so revision history is not
> required in the comments.
> Remove the change history information from the comments.
> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 36 ----------------------------
>  1 file changed, 36 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> index a88686be3523..885c5966342f 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -8,11 +8,6 @@
>   * Abstract:
>   *	HW dynamic mechanism.
>   *
> - * Major Change History:
> - *	When		Who				What
> - *	----------	--------------- -------------------------------
> - *	2008-05-14	amy                     create version 0 porting from windows code.
> - *
>   *--
>   */
>  #include "r8192U.h"
> @@ -276,10 +271,6 @@ void init_rate_adaptive(struct net_device *dev)
>   *
>   * Return:		NONE
>   *
> - * Revised History:
> - *	When		Who		Remark
> - *	05/26/08	amy	Create version 0 porting from windows code.
> - *
>   *---------------------------------------------------------------------------

You can remove the extra blank comment line as well.

thanks,

greg k-h
