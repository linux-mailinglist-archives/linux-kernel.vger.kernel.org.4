Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E2E6C5E42
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 05:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjCWEzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 00:55:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjCWEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 00:55:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A5A2914F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Mar 2023 21:55:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 649B9623C2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 04:55:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7090AC433EF;
        Thu, 23 Mar 2023 04:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679547324;
        bh=L8V8tdH9v0Pzz/Q+0e1Gx1r0FWztww1FBu2Dj3c0Zd8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y276/HWlE/usJ9mOqeGEygGMOaJ873CjPrJP0yUashiHXnS55OsV9kHzk5LpwNmc6
         HxyurKiolWUokkf3wvgF+W8GixkYYq7DsxycdlRWe+5kgRZZFTyNFQFs/IRmhJJHYs
         G1OLwZWgRcb+I1ihBrL6TkvNbspht8ZJSLHrPuQ4=
Date:   Thu, 23 Mar 2023 05:55:21 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rohit Chavan <roheetchavan@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH] staging: vme_user: Fixing coding style issues reported
 by checkpatch
Message-ID: <ZBvbufoYo/wPp4qY@kroah.com>
References: <20230322142923.723-1-roheetchavan@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322142923.723-1-roheetchavan@gmail.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 07:59:23PM +0530, Rohit Chavan wrote:
> Fixing alignment should match open parenthesis issue on multiple lines,
> reported by checkpatch script.

You might want to mention on the subject line that this is a parenthesis
issue, right?

> Signed-off-by: Rohit Chavan <roheetchavan@gmail.com>
> ---
>  drivers/staging/vme_user/vme_tsi148.c | 102 +++++++++++++-------------
>  1 file changed, 51 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/staging/vme_user/vme_tsi148.c b/drivers/staging/vme_user/vme_tsi148.c
> index 2f5eafd50934..716de1d7fe21 100644
> --- a/drivers/staging/vme_user/vme_tsi148.c
> +++ b/drivers/staging/vme_user/vme_tsi148.c
> @@ -55,14 +55,14 @@ static struct pci_driver tsi148_driver = {
>  };
> 
>  static void reg_join(unsigned int high, unsigned int low,
> -	unsigned long long *variable)
> +		     unsigned long long *variable)

For many of these, you can just move the line to the previous one,
making it a single line, right?  That would make the code much more
readable.

thanks,

greg k-h
