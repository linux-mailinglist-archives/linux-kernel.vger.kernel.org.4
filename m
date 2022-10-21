Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69170608F3C
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 21:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiJVTat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 15:30:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJVTar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 15:30:47 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF43D4A34
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 12:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666467028; bh=JTheIU4xRSl5mc5GqAxkbn7h52Wsca6LkI5NJTEdf14=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=Qh53FDKBB8GpVmydYu0rAMSAIM7UQCNf0n1mm65q1cWDp/lhMAlJb0R198wts5ovT
         KDdjRmXtmU5CXIt9eZw5hp95n7x5kwdv+yvCMHcD8DL2lpJrHOMdinoB5vj0kve1rq
         FJCMJfjYCKVlZ5/exrMW2RITnaE/jeeqWfvm/L1M=
Received: by b-4.in.mailobj.net [192.168.90.14] with ESMTP
        via [213.182.55.206]
        Sat, 22 Oct 2022 21:30:28 +0200 (CEST)
X-EA-Auth: q56hZWDqs4iRisuzWFTQxUzkR7F6O3dEDdwhc1oJruUtjsotfYf2wsL9j+FGNIfmaGRgyagBhcnOJGsIix2u85/cZr7HhW7R
Date:   Fri, 21 Oct 2022 22:04:22 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: wlan-ng: remove commented debug printk messages
Message-ID: <Y1LKDv7vSmNrZDEI@debian-BULLSEYE-live-builder-AMD64>
References: <Y1H5tJXjMZqiB6rh@debian-BULLSEYE-live-builder-AMD64>
 <Y1OikehVJv/teZ9e@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1OikehVJv/teZ9e@kroah.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DATE_IN_PAST_24_48,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 22, 2022 at 09:58:09AM +0200, Greg KH wrote:
> On Fri, Oct 21, 2022 at 07:15:24AM +0530, Deepak R Varma wrote:
> > printk messages are added for program flow tracing and are left
> > commented. These commented log messages should be removed as they
> > are no more useful for program execution.
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/wlan-ng/p80211netdev.c | 22 ----------------------
> >  1 file changed, 22 deletions(-)
>
> I recieved 3 different copies of this patch, and do not know which one
> to take at all.

Hello Greg,
My apologies for the spam. There have been some trouble with my email
transactions. I was unable to see my own email and hence ended up resending the
same patch 3 times.

>
> So please resend this as a v2 patch, only once, and I will be glad to
> review it.

Sure and thank you very much. Will send in v2 shortly.

./drv

>
> thanks,
>
> greg k-h


