Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EBB46B598C
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 09:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjCKIsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 03:48:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjCKIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 03:48:13 -0500
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604022133
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 00:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vxFDoEkmYm4fRNtCrXSAyIIoifg5XvMVqwsWgt4pM4w=;
  b=hRooKtA4P4371CXHG+QqkG17tqUa8lHG0uaE2bw9+8YNXY0wKdL4OlUj
   F5jFW8aSMmETGSf5MCcnoi9RGOX/1+Rs6hBAdPKH8fXx9sFXXEMXoIilb
   pKRGH9ay/BH48o4KfcfHYFVYA0HIgZrFFEW69rip2fEQgwrU9lCsV4t3K
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,252,1673910000"; 
   d="scan'208";a="96627374"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2023 09:48:09 +0100
Date:   Sat, 11 Mar 2023 09:48:09 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
cc:     Deepak R Varma <drv@mailo.com>, Dan Carpenter <error27@gmail.com>,
        outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: greybus: remove tabs to fix line length and
 merge lines
In-Reply-To: <ZAwqzPeLh1Dm10EJ@khadija-virtual-machine>
Message-ID: <alpine.DEB.2.22.394.2303110947230.2802@hadrien>
References: <ZAusnKYVTGvO5zoi@khadija-virtual-machine> <6e9fd119-6566-4778-899e-bc5a7ee7830c@kili.mountain> <ZAwelPOv45zThK6j@khadija-virtual-machine> <ZAwoTVeMDGu/44Ln@ubun2204.myguest.virtualbox.org> <ZAwqzPeLh1Dm10EJ@khadija-virtual-machine>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 11 Mar 2023, Khadija Kamran wrote:

> On Sat, Mar 11, 2023 at 12:35:49PM +0530, Deepak R Varma wrote:
> > On Sat, Mar 11, 2023 at 11:24:20AM +0500, Khadija Kamran wrote:
> > > On Sat, Mar 11, 2023 at 07:16:19AM +0300, Dan Carpenter wrote:
> > > > On Sat, Mar 11, 2023 at 03:18:04AM +0500, Khadija Kamran wrote:
> > > > > In file drivers/staging/greybus/arche-platform.c,
> > > > > - Length of line 181 exceeds 100 columns, fix by removing tabs from the
> > > > >   line.
> > > > > - If condition and spin_unlock_...() call is split into two lines, join
> > > > > them to form a single line.
> > > > >
> > > > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > > > ---
> > > > > Changes in v2:
> > > > >  - Change the subject and log message
> > > > >  - Merge if condition and spin_unlock...() from two lines to one
> > > >
> > > > Apply your patch and then re-run checkpatch.pl -f on the file.  You will
> > > > see the problem.
> > >
> > > Hey Dan!
> > > When I run checkpatch.pl on my file, I can see that my old CHECK no
> > > longer exists instead a new CHECK is mentioned saying 'Alignment should
> > > match open parenthesis'. I understand this from your previous email.
> > > Should I stop working on this file and leave it as is?
> >
> > Hi Dan,
> > Not trying to speak for you, so please override my message if this is
> > inaccurate.
> >
> > Hi Khadija,
> > Yes. It is not useful to resolve one warning and introduce another. Tomorrow
> > someone else is going to try and revert it. So do not make the "remove tab"
> > change. I still like the merging of the split lines. It appears to improve code
> > readability. You can send in a v3 with just that merge change and wait for
> > feedback.
> >
> Hey Deepak,
> Thank you for the feedback. Before sending a patch v3, I think I should
> wait for more feedback.

Khadija,

Please put some blank lines around your responses so they are easier to
find.

thanks,
julia

> > Also, remember to check your change with checkpatch. There is a section about
> > post-commit hooks on the tutorials page. This will allow you to integrate
> > checkpatch as part of your git commit step and do the job for you.
> >
> > And also, always build your change locally on your machine. No new warnings or
> > errors should arise.
> >
> Yes I will keep that in mind for next patches. Thank you!
> > Hope that helps.
> > Deepak.
> >
> >
> > > Thank you!
> > > >
> > > > regards,
> > > > dan carpenter
> > >
> >
> >
>
>
