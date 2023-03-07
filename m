Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B07A6AD879
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 08:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCGHuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 02:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbjCGHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 02:50:05 -0500
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFFD848EF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 23:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=VwKFzaPAhb21yGNMRNg/WNeNXMmPB5JmgKh/nfRZDe8=;
  b=vRRBy8D4qUntCtN98rmxHdjWrHPCY+qOiFQeVbzmkU/QUu0xqST9eJNO
   gB0AXMEj8k57/2fOtd75l6bw3hKm7wcKUCYRA4Po22DrFmCx3+Qgp0rmM
   tqaQQMMvSL1A7RNQqz3P1FL4fdAAz+ANgpO6GQ28yRSjMsIfUgddVY387
   k=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,240,1673910000"; 
   d="scan'208";a="49410178"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2023 08:49:56 +0100
Date:   Tue, 7 Mar 2023 08:49:55 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Khadija <kamrankhadijadj@gmail.com>
cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
In-Reply-To: <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
Message-ID: <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine> <alpine.DEB.2.22.394.2303062202500.3050@hadrien> <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1184433621-1678175395=:3785"
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

--8323329-1184433621-1678175395=:3785
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 7 Mar 2023, Khadija wrote:

> Hey Julia! Thank you for the feedback. I will make the following changes and
> resend the patch:
> 1. Correct the patch description that is right under the subject line (make
> it precise and imperative) and make sure that it does not have more than 70
> characters per line.
> 2. Adjust all the arguments of wait_event_interruptible_timeout so that they
> are lined up. All of them should begin right under ( .

The problem here is that the ( is really far to the right.  My opinion is
that the position of the second argument (ie the first one that is on a
line of its own) is ok in this case.  So you can leave that one where it
is and line up the other one.

julia

> Kindly let me know if I have understood it
> right.[EIu7f6EdNusD0UITKM3h?rid=EIu7f6EdNusD0UITKM3h]
>
> On Tue, Mar 7, 2023 at 2:08 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>
>
>       On Tue, 7 Mar 2023, Khadija Kamran wrote:
>
>       > In file drivers/staging/axis-fifo/axis-fifo.c the alignment
>       did not match the opening parenthesis. So, a few tabs were added
>       to match the alignment to exactly where the parenthesis started.
>
>       Hello Khadija,
>
>       Thanks for plunging in and being the first participant!
>
>       However, there are a number of issues with the proposed patch.
>
>       1.  The log message should be at most around 70 characters
>       wide.  You have
>       one long line.
>
>       2.  The log message should be written in the imperative. 
>       Instead of "a
>       few tabs were added", ay "add a few tabs".
>
>       3.  I'm not sure that it is worth creating a very long line to
>       respect the
>       rule about (.  On the other hand, the way the code is written at
>       the
>       moment seems to be very misleading, because the third argument
>       to
>       wait_event_interruptible_timeout is written as though it is the
>       second
>       argument to ioread32.  So you can adjust the argument list of
>       wait_event_interruptible_timeout so that at least all of the
>       arguments
>       that are not on the same line as the function call are lined up.
>
>       julia
>
>       >
>       > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
>       > ---
>       >  drivers/staging/axis-fifo/axis-fifo.c | 2 +-
>       >  1 file changed, 1 insertion(+), 1 deletion(-)
>       >
>       > diff --git a/drivers/staging/axis-fifo/axis-fifo.c
>       b/drivers/staging/axis-fifo/axis-fifo.c
>       > index dfd2b357f484..6e959224add0 100644
>       > --- a/drivers/staging/axis-fifo/axis-fifo.c
>       > +++ b/drivers/staging/axis-fifo/axis-fifo.c
>       > @@ -383,7 +383,7 @@ static ssize_t axis_fifo_read(struct file
>       *f, char __user *buf,
>       >                */
>       >               mutex_lock(&fifo->read_lock);
>       >               ret =
>       wait_event_interruptible_timeout(fifo->read_queue,
>       > -                     ioread32(fifo->base_addr +
>       XLLF_RDFO_OFFSET),
>       > +                                                   
>       ioread32(fifo->base_addr + XLLF_RDFO_OFFSET),
>       >                                (read_timeout >= 0) ?
>       >                                 msecs_to_jiffies(read_timeout)
>       :
>       >                                 MAX_SCHEDULE_TIMEOUT);
>       > --
>       > 2.34.1
>       >
>       >
>       >
>
>
>
--8323329-1184433621-1678175395=:3785--
