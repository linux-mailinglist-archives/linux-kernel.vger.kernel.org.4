Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1097F605FB9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 14:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiJTMGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 08:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiJTMGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 08:06:44 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14118B4B0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 05:06:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=tSAa9IItfB/2eDYRz08Kgo9IPGM2D4x1b+PWnE0NgEM=;
  b=iEmwmJxzQdXT+pNcg/LACDQ50cHFnTHv3M8ULMWj9afCgav3Nb5V3oF4
   EriFD04PB1dHqv7ec1rkOK/2P4B8rVx/MYsKljsMGK98ggDnkUJIIRA5w
   wPkLnXApWHam+aBDZKZ9OxK4N6uyv1qkDX49+JT0dSueGcsCaLKo0q/yr
   A=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,198,1661810400"; 
   d="scan'208";a="66169640"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2022 14:06:41 +0200
Date:   Thu, 20 Oct 2022 14:06:41 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v4 2/2] staging: most: dim2: correct misleading struct
 type name
In-Reply-To: <Y1E1kv6YSmxVzjkf@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <404cc67c-efd6-4a70-c3ca-7958db21bcb@inria.fr>
References: <cover.1666208065.git.drv@mailo.com> <6b772a1ac06ae3b0d63e198e7238c1590b14703a.1666208065.git.drv@mailo.com> <alpine.DEB.2.22.394.2210192208290.3068@hadrien> <Y1BeZYBf/xsW8F4O@debian-BULLSEYE-live-builder-AMD64>
 <Y1E1kv6YSmxVzjkf@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 20 Oct 2022, Deepak R Varma wrote:

> On Thu, Oct 20, 2022 at 02:00:29AM +0530, Deepak R Varma wrote:
> > On Wed, Oct 19, 2022 at 10:08:53PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Thu, 20 Oct 2022, Deepak R Varma wrote:
> > >
> > > > Correct misleading struct type name dim_ch_state_t to dim_ch_state
> > > > since this not a typedef but a normal structure declaration.
> > > >
> > > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > ---
> > > >
> > > > Changes in v4:
> > > >    1. Correct patch subject and log message. Use struct type name instead of
> > > >       variable name for the change description. Feedback from julia.lawall@inria.fr
> > > >
> > > > Changes in v3:
> > > >    1. Patch introduced in the patch set
> > > >
> > > >  drivers/staging/most/dim2/dim2.c | 2 +-
> > > >  drivers/staging/most/dim2/hal.c  | 4 ++--
> > > >  drivers/staging/most/dim2/hal.h  | 6 +++---
> > > >  3 files changed, 6 insertions(+), 6 deletions(-)
> > > >
> > > > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > > > index 4c1f27898a29..a69a61a69283 100644
> > > > --- a/drivers/staging/most/dim2/dim2.c
> > > > +++ b/drivers/staging/most/dim2/dim2.c
> > > > @@ -161,7 +161,7 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
> > > >  	struct list_head *head = &hdm_ch->pending_list;
> > > >  	struct mbo *mbo;
> > > >  	unsigned long flags;
> > > > -	struct dim_ch_state_t st;
> > > > +	struct dim_ch_state st;
> > >
> > > Is there another use in service_done_flag?
> >
> > Hi,
> > I did not understand your question fully. This is from a different function
> > try_start_dim_transfer where the variable st is used down the line in the
> > execution. This time the channel state is retrieved by calling
> > dim_get_channel_state function. The state is simply computed and set. Should I
> > improve this as well?
> >
> > If you are asking something different, could you please elaborate?
>
> Hi Julia,
> Can you please review and comment on my response?

In my kernel there is an occurrence of the type name in service_done_flag.
But I have the mainline, not Greg's staging tree, so there could be some
differences.

When I do git grep dim_ch_state_t, I get two occurrences in
drivers/staging/most/dim2/dim2.c

julia
