Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11D56C8DF4
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 13:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbjCYMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 08:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjCYMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 08:22:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691A883E2
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 05:22:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 24770B8075B
        for <linux-kernel@vger.kernel.org>; Sat, 25 Mar 2023 12:22:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EEFC433EF;
        Sat, 25 Mar 2023 12:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679746958;
        bh=YuqdbWe/XYdqPWicCpygLVXjj3TI/mTA8gm6+zYlqwA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bbOaCoDSp+LuQYYFoCHRohft6b9nn24xSX/S4Ruqbmqtk0Q+hyC5oSeRQRNvUo8pw
         RxiX0V/0F+McY/J0rEaYrfjbHX77Ql93xSGAEdJz7G6w8yUq5b1iCTa01desermExr
         fYVH1fEaiOcq6GPpIIFoLEbscffkPURLDRMBKgxs=
Date:   Sat, 25 Mar 2023 13:22:35 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] staging: rtl8192u: remove code from comments
Message-ID: <ZB7ni6yQdTvuhOIW@kroah.com>
References: <cover.1679744684.git.kamrankhadijadj@gmail.com>
 <70aacb99144b4c776f8efa4c47a8423c58a9454f.1679744684.git.kamrankhadijadj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70aacb99144b4c776f8efa4c47a8423c58a9454f.1679744684.git.kamrankhadijadj@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 25, 2023 at 05:13:18PM +0500, Khadija Kamran wrote:
> Writing code in comments is generally not considered a good coding
> practice.
> Remove all the code comments from the file.

How about something like:
	Remove all of the commented out code lines as they are not being
	used and can be brought back in the future if they are ever
	needed again.

And the subject reads a bit odd too, how about:
	staging: rtl8192u: remove commented out code

> 
> Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> ---
>  drivers/staging/rtl8192u/r8192U_dm.c | 127 +--------------------------
>  1 file changed, 2 insertions(+), 125 deletions(-)
> 
> diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> index 885c5966342f..f210ede8b1c7 100644
> --- a/drivers/staging/rtl8192u/r8192U_dm.c
> +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> @@ -50,11 +50,9 @@ static	void	dm_init_bandwidth_autoswitch(struct net_device *dev);
>  static	void	dm_bandwidth_autoswitch(struct net_device *dev);
>  
>  /* DM --> TX power control */
> -/*static	void	dm_initialize_txpower_tracking(struct net_device *dev);*/
>  
>  static	void	dm_check_txpower_tracking(struct net_device *dev);
>  
> -/*static	void	dm_txpower_reset_recovery(struct net_device *dev);*/
>  

The extra blank lines can now go away as well, at the same time, right?

thanks,

greg k-h
