Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B660860E2AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbiJZNyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbiJZNxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:53:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1705D101E1E
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:52:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0907B8225A
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:52:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F7F8C433C1;
        Wed, 26 Oct 2022 13:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666792361;
        bh=K7jEal6x1Na5c8Q6HECvo3yVgzCvvO7sXemhZBWHVF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5WSECAYn6puczp/4foqTqyreDtLM8K/aNF7zi1w6LKgtsdEO3qqyx540JZWdoVG/
         3LBw4McEZ/g4fKuqfspPdXP2Iv6wtvZl6YKBf9m6yA4GEqOpiH4YtwEyIgf/LvivsC
         0u251EByaHFDCBnBo2wdhNiS3AdnziFKHunrX+uc=
Date:   Wed, 26 Oct 2022 15:53:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     UMWARI JOVIAL <umwarijovial@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] Fixed[ERROR:trailing whitespace and braces around scalar
 initializer]
Message-ID: <Y1k73n3yIZ1yQpss@kroah.com>
References: <20221026132838.GA44037@rdm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026132838.GA44037@rdm>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 04:28:38PM +0300, UMWARI JOVIAL wrote:
> Using the checkpatch.pl script, found the below errors and  fixed
> ERROR: trailing whitespace
> CHECK: Please don't use multiple blank lines
> warning: braces around scalar initializer
> 
> Signed-off-by: UMWARI JOVIAL <umwarijovial@gmail.com>
> ---
>  drivers/staging/most/dim2/dim2.c | 2 --
>  1 file changed, 2 deletions(-)

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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what is needed in order to
  properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/SubmittingPatches for what a proper Subject: line should
  look like.

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
