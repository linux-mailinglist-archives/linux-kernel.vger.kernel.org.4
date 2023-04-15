Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B28E6E322B
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Apr 2023 17:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjDOPzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Apr 2023 11:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjDOPzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Apr 2023 11:55:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D262117
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 08:55:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C866360ABD
        for <linux-kernel@vger.kernel.org>; Sat, 15 Apr 2023 15:55:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE274C433D2;
        Sat, 15 Apr 2023 15:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1681574118;
        bh=JM4wxjnVSczW3VmgopWsX+Y1VdqAfX6CX1UeUSvMeT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eYnrCKeEuvQRpYnsElDqahySK2DGXl1FQgscc2wYdryRKCNsLFz213nhkl0NvzSmP
         BA4hgMIpbdJA2b5HwTxNSTzGgc9iqxIVw7qYtFR8QnvHE8sT3qOYUUQ5SIzLQXs6uq
         RgaA5Ld2ZSEo4mT3IjoqKD+/R/5WZ4t6TxaLvnIo=
Date:   Sat, 15 Apr 2023 17:55:15 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Philipp Hortmann <philipp.g.hortmann@gmail.com>
Subject: Re: [PATCH] staging: rtl8192u: Remove functions rtl8192_wx_get_sens
 and rtl8192_wx_set_sens
Message-ID: <2023041559-peroxide-turmoil-9239@gregkh>
References: <ZDd07Hgfe+Dxlus8@Zephyrus-G14>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDd07Hgfe+Dxlus8@Zephyrus-G14>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 08:50:12AM +0530, Yogesh Hegde wrote:
> Both of these functions depend on the function rf_set_sens, which is
> declared but never defined. Hence calling this function will cause an
> oops. Because there is no definition of the function, priv->rf_set_sens
> will always be NULL.
> 
> As a result rtl8192_wx_set_sens and rtl8192_wx_get_sens will always
> return -1.
> 
> Hence,
> * Removed function definition rf_set_sens
> * Removed usage of variable priv->rf_set_sens
> * Removed functions rtl8192_wx_get_sens and rtl8192_wx_set_sens
> * Cleaned up the variables sens and max_sens used in these functions
> 
> Suggested-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> 
> Signed-off-by: Yogesh Hegde <yogi.kernel@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U.h    |  3 ---
>  drivers/staging/rtl8192u/r8192U_wx.c | 40 ++--------------------------
>  2 files changed, 2 insertions(+), 41 deletions(-)
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.


If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
