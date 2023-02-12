Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D799069365D
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Feb 2023 08:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjBLHYU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Feb 2023 02:24:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjBLHYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Feb 2023 02:24:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 578BB86AC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 23:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D360F60B50
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 07:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B89C433EF;
        Sun, 12 Feb 2023 07:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676186657;
        bh=Ain59IlHj5wVumV3N4HWxfl2sizYfntAUYp+Sn0DUUo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QjwKOKvIq3jOYDKWswWg1wyPrc38dt8x0kBSCgy90YvzDwUlOvA5kg4symLZO6csT
         l/DQOYPIH9bZPEddx3bKNG2rUebwBbCV622LqJHVmvBXuiIrLvGJlOpvXZ5beOpSCm
         /C9gJ58opIVc3D7D7DvS2MFWiSmyx8Bj4mq3GkDA=
Date:   Sun, 12 Feb 2023 08:24:13 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shreenidhi Shedi <yesshedi@gmail.com>
Cc:     dhowells@redhat.com, dwmw2@infradead.org,
        linux-kernel@vger.kernel.org, Shreenidhi Shedi <sshedi@vmware.com>
Subject: Re: [PATCH 1/4] sign-file: refactor argument parsing logic
Message-ID: <Y+iUHa5xjNnkd77h@kroah.com>
References: <20230209160523.858502-1-sshedi@vmware.com>
 <dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc852d8e-816a-0fb2-f50e-ff6c2aa11dd8@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 12, 2023 at 01:04:08AM +0530, Shreenidhi Shedi wrote:
> On Thu, 9-Feb-2023 21:35, Shreenidhi Shedi wrote:
> > Add support for bulk signing of modules.
> > 
> > Signed-off-by: Shreenidhi Shedi <sshedi@vmware.com>
> > ---
> >   sign-file.c | 349 ++++++++++++++++++++++++++++++++++------------------
> >   1 file changed, 228 insertions(+), 121 deletions(-)
> > 
> > diff --git a/sign-file.c b/sign-file.c
> > index 598ef54..76fee75 100644
> > --- a/sign-file.c
> > +++ b/sign-file.c

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

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

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
