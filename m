Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765D96AD8B7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjCGIIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjCGIIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:08:13 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C878A3BF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Q1RR8vW0ctHNiAqd/s3rypbjxDCVNCdhzrnrBsLgxtk=;
  b=JSJWTiSXj+cpxY9CfuycYgZaiVOM6GSjclaUSVNgFTexl1Td+VMnIJb6
   Uq4wZXcI9WYX9Aof/ZIVvrTqr/Wj2I5u07+C6NPYFyWeBKkxzZhaT4R6O
   fIyNtPj+h4XTYXunOhyEQrctSCLMnGOvkOCCyZip32bBLBYf1k1+2gGII
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="49412312"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 09:07:38 +0100
Date:   Tue, 7 Mar 2023 09:07:37 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Dan Carpenter <error27@gmail.com>
cc:     Khadija <kamrankhadijadj@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
In-Reply-To: <78d1ea82-ef18-42b2-8a8e-27ee3c7ad55f@kili.mountain>
Message-ID: <aebfe9ab-3fec-d718-6e7-1cddac2b20a4@inria.fr>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine> <alpine.DEB.2.22.394.2303062202500.3050@hadrien> <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com> <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
 <78d1ea82-ef18-42b2-8a8e-27ee3c7ad55f@kili.mountain>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1614340543-1678176457=:3785"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1614340543-1678176457=:3785
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT



On Tue, 7 Mar 2023, Dan Carpenter wrote:

> On Tue, Mar 07, 2023 at 08:49:55AM +0100, Julia Lawall wrote:
> >
> >
> > On Tue, 7 Mar 2023, Khadija wrote:
> >
> > > Hey Julia! Thank you for the feedback. I will make the following changes and
> > > resend the patch:
> > > 1. Correct the patch description that is right under the subject line (make
> > > it precise and imperative) and make sure that it does not have more than 70
> > > characters per line.
> > > 2. Adjust all the arguments of wait_event_interruptible_timeout so that they
> > > are lined up. All of them should begin right under ( .
> >
> > The problem here is that the ( is really far to the right.  My opinion is
> > that the position of the second argument (ie the first one that is on a
> > line of its own) is ok in this case.  So you can leave that one where it
> > is and line up the other one.
> >
>
> I kind of like lining things up like this.  I think if you can't align
> things with the parens, then it's nice to at least use two tabs.  It's
> not kernel style or anyone's style explicitly, but I kind of like it.
>
> It doesn't make checkpatch happy.
>
> I guess I probably wouldn't bother sending this patch.  To controversial.
> I'd just move on to something else.  It's not like there is a shortage
> of stuff to do.  One idea in this file is that you could use
> sysfs_emit() in sysfs_read() and get rid of char tmp[32]; buffer.

Dan, the problem is not that the argument is to the left of the (

The problem is that the last argument is indented exactly as though it
were an argument of the second argument.  But it's not.  You have to count
the parentheses to see that.  It's very misleading.

julia

>
> regards,
> dan carpenter
>
> diff --git a/drivers/staging/axis-fifo/axis-fifo.c b/drivers/staging/axis-fifo/axis-fifo.c
> index dfd2b357f484..0bf180cf44a6 100644
> --- a/drivers/staging/axis-fifo/axis-fifo.c
> +++ b/drivers/staging/axis-fifo/axis-fifo.c
> @@ -383,10 +383,10 @@ static ssize_t axis_fifo_read(struct file *f, char __user *buf,
>  		 */
>  		mutex_lock(&fifo->read_lock);
>  		ret = wait_event_interruptible_timeout(fifo->read_queue,
> -			ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> -				 (read_timeout >= 0) ?
> -				  msecs_to_jiffies(read_timeout) :
> -				  MAX_SCHEDULE_TIMEOUT);
> +				ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
> +				(read_timeout >= 0) ?
> +					msecs_to_jiffies(read_timeout) :
> +					MAX_SCHEDULE_TIMEOUT);
>
>  		if (ret <= 0) {
>  			if (ret == 0) {
>
--8323329-1614340543-1678176457=:3785--
