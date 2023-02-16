Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15EEC698B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 05:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjBPExa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 23:53:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBPEx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 23:53:28 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5ADC165
        for <linux-kernel@vger.kernel.org>; Wed, 15 Feb 2023 20:53:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3914B61DA6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 04:53:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF37C433D2;
        Thu, 16 Feb 2023 04:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676523206;
        bh=90lhV0HywhXsRni2vshP93quUm+ZF2TfjJu5k0qOhp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2W23ChlEdZZuWcsBEtY3nPucM+i3TANzpjoQYT8mDG0zYWjb8EKBuYYmP8ysh44b
         l77NJ6qrDVFgnGq4IB4XgLQl7M96CG1umSCMDKRdCFR2qNfj+t1+8+/qQkO6q22rBK
         ku1m6Ew2fH0/qDa7glf910Nhiw5glAJV4vTjHkXA=
Date:   Thu, 16 Feb 2023 05:53:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jesper Juhl <jesperjuhl76@gmail.com>
Cc:     linux-kernel@vger.kernel.org, speakup@linux-speakup.org
Subject: Re: [Patch] [drivers/accessibility] Remove unneeded version.h
Message-ID: <Y+22wycuuZzdf4YA@kroah.com>
References: <ce52283d-7fbe-cb9e-de8d-069fcb0af916@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ce52283d-7fbe-cb9e-de8d-069fcb0af916@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:46:30AM +0100, Jesper Juhl wrote:
> > From bf38cc9d1c32d3debdc846d30ae6a0523c5a64d3 Mon Sep 17 00:00:00 2001
> From: Jesper Juhl <jesperjuhl76@gmail.com>
> Date: Mon, 13 Feb 2023 02:44:01 +0100
> Subject: [PATCH 01/12] [drivers/accessibility] Remove unneeded version.h
>  includes found by 'make versioncheck'
> 
> Signed-off-by: Jesper Juhl <jesperjuhl76@gmail.com>
> ---
>  drivers/accessibility/speakup/genmap.c      | 1 -
>  drivers/accessibility/speakup/makemapdata.c | 1 -
>  2 files changed, 2 deletions(-)
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

- You did not specify a description of why the patch is needed, or
  possibly, any description at all, in the email body.  Please read the
  section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what is needed in
  order to properly describe the change.

- You did not write a descriptive Subject: for the patch, allowing Greg,
  and everyone else, to know what this patch is all about.  Please read
  the section entitled "The canonical patch format" in the kernel file,
  Documentation/process/submitting-patches.rst for what a proper
  Subject: line should look like.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
