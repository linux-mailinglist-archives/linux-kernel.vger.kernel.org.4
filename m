Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C61896FD883
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236056AbjEJHsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJHsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA2D1B7
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:48:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F0C462F11
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 07:48:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CB3EC433EF;
        Wed, 10 May 2023 07:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683704898;
        bh=Q0YkIVrsYSiUntR8XUeUJQ9NKp/dYkedYevQTQb2i4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HMuI5RNh4+G6d5k8e8/2GKKF50cdI+G/tsR83FkbP+ja2j0Xs9BIkIVpMhH5WNQjO
         Xo6lT3ztyddPfAQyuOcCOH6nSRoVO+Rh8HI0sPw5pxHeKkm+Rf8uv/QDrxjqK0U+kq
         xXkz/fZAcQ6L7xjKi5wr/EAhvF8LlEu4aol4cUh8=
Date:   Wed, 10 May 2023 09:48:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ivan Orlov <ivan.orlov0322@gmail.com>
Cc:     perex@perex.cz, tiwai@suse.com, oswald.buddenhagen@gmx.de,
        axboe@kernel.dk, 42.hyeyoo@gmail.com, surenb@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Message-ID: <2023051052-recoil-headache-1594@gregkh>
References: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:27:26AM +0400, Ivan Orlov wrote:
> Fix some obvious codestyle issues in the pcm_native.c file. Some of them
> were found by checkpatch with --strict option, and the others by just
> looking at the code. These issues include incorrect placement of brackets,
> trailing and starting spaces, wrong alignment of function arguments,
> incorrect multiline comments, using __attribute__((packed)) instead of just
> "__packed", comparison with null instead of using "!". Also, today we have
> 100 columns per line available, and I tried to reformat the file
> considering this.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>
> ---
>  sound/core/pcm_native.c | 696 +++++++++++++++++++---------------------
>  1 file changed, 323 insertions(+), 373 deletions(-)

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

- Your patch did many different things all at once, making it difficult
  to review.  All Linux kernel patches need to only do one thing at a
  time.  If you need to do multiple things (such as clean up all coding
  style issues in a file/driver), do it in a sequence of patches, each
  one doing only one thing.  This will make it easier to review the
  patches to ensure that they are correct, and to help alleviate any
  merge issues that larger patches can cause.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
