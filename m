Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39E766B5F98
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 19:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbjCKSPk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 13:15:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjCKSPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 13:15:37 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B244637EA
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 10:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=3rR5OQ3sQVLhWBUYWdY6yHLdxX91kXaMtSzohwuA2Pk=;
  b=T+hAK6PHgMt5hYr8fSfAUi/kToM3unyYNFIksHQ85NP6E5Ps81uZ3oof
   +3JwFvgiY1WX1/mhAxx0bzH5VEmgeCuU84ZTUWbdO1bpnNOEp8URdlpnf
   vkg4rcqJlumaoAiOirXBtlXZcpJfDD+fIux/DZb1F88830qM7UwM7zZ1U
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,253,1673910000"; 
   d="scan'208";a="49892577"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 19:15:34 +0100
Date:   Sat, 11 Mar 2023 19:15:33 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: axis-fifo: remove tabs to align arguments
In-Reply-To: <ZAy69T5sYZiyL4TJ@khadija-virtual-machine>
Message-ID: <alpine.DEB.2.22.394.2303111914050.2802@hadrien>
References: <ZAxsyX8n7G92nlJh@khadija-virtual-machine> <ZAxzfiOoW0SfW5qD@kroah.com> <ZAy69T5sYZiyL4TJ@khadija-virtual-machine>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Mar 2023, Khadija Kamran wrote:

> On Sat, Mar 11, 2023 at 01:26:38PM +0100, Greg Kroah-Hartman wrote:
> > On Sat, Mar 11, 2023 at 04:58:01PM +0500, Khadija Kamran wrote:
> > > In file drivers/staging/axis-fifo/axis-fifo.c, in line 386 and 529, the
> > > last argument is indented as if it were an argument of the second
> > > argument. Remove tabs to align the arguments.
> > >
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > > Changes in v3:
> > >  - Do not align the line 530 since it is not part of the last argument.
> > >
> > >  drivers/staging/axis-fifo/axis-fifo.c | 12 ++++++------
> > >  1 file changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> > > index dfd2b357f484..b119cec25a60 100644
> > > --- a/drivers/staging/axis-fifo/axis-fifo.c
> > > +++ b/drivers/staging/axis-fifo/axis-fifo.c
> > > @@ -384,9 +384,9 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
> > >  		mutex_lock(&fifo->read_lock);
> > >  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> > >  			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> > > -				 (read_timeout >= 0) ?
> > > -				  msecs_to_jiffies(read_timeout) :
> > > -				  MAX_SCHEDULE_TIMEOUT);
> > > +			(read_timeout >= 0) ?
> > > +			msecs_to_jiffies(read_timeout) :
> > > +			MAX_SCHEDULE_TIMEOUT);
> >
> > People have been trying to "polish" this mess for a long time, and I
> > think it's better to step back and see what is really needed here.
> >
> > There is a module parameter, read_timeout, that can only be set at
> > loading time.  As it can only be modified once, why are we doing an if
> > statement each and every time it is read from?
> >
> > Instead, in the module probe function, how about doing something like:
> > 	if (read_timeout >= 0)
> > 		read_timeout = msecs_to_jiffies(read_timeout);
> > 	else
> > 		read_timeout = MAX_SCHEDULE_TIMEOUT;
> >
>
>
> Hi Greg!
> Thank you for the reply. Before sending the patch I just wanted to
> confirm if I have understood this right. Should I write the above
> mentioned code before the wait_event_interruptible_timeout() call, and
> pass read_timeout as the last argument to wait_event_interruptible()?
> And same for write_timeout.

Greg suggests to do the initialization of read_timeout only once in the
probe function.  That is the function in which the driver figures out some
information about the environment in which it is running. It is only
called once, at startup time.  Then there will not be this if on every
wait_event_interruptible_timeout call.

julia


>
>
> > and then only ever use "read_timeout" here in the
> > wait_event_interruptiable() call?  That should simplify this much more
> > overall, and hopefully allow us to just get rid of the module parameter
> > eventually as that's not how drivers should be working at all anymore.
> >
> > Same goes for write_timeout.
> >
> > Overall the code should be much simpler and easier to understand, which
> > is the end goal here.
> >
> > Can you try doing that instead?
> >
> > thanks,
> >
> > greg k-h
>
>
