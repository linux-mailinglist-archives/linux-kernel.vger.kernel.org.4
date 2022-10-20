Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FE605F3D
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 13:49:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiJTLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJTLst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 07:48:49 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55B521BBEFC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 04:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666266519; bh=P+kmPU5kkvXfWUROM7rwscCiZlOGpAiN1PmgpAxx1gg=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=h/ONn8ODQuIfFIpvNuv8BRpSvLTs1xZpzNNQd5orhnYdYi91ppLn0TpovczEFLcnq
         DhiDPSu4NzpLeaYZw00MvZctM53m8PzQciblNGpRdmP2NYNmeJwZlxJmIK9kIsN3sL
         tBj14H83Z0tadPT9HbJT2zSGLDrWxv8d0SdkqNmg=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 13:48:39 +0200 (CEST)
X-EA-Auth: WbyAjLEHV5U2tK4BVpGMKa3Z5g2AYZP/VbZR8AOhE6Fo5VgK1ofkcL8OJ/B6TfjsmO+Fuan49nJN/SsQLeDQf8oKJauITOq7
Date:   Thu, 20 Oct 2022 17:18:34 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH v4 2/2] staging: most: dim2: correct misleading struct
 type name
Message-ID: <Y1E1kv6YSmxVzjkf@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666208065.git.drv@mailo.com>
 <6b772a1ac06ae3b0d63e198e7238c1590b14703a.1666208065.git.drv@mailo.com>
 <alpine.DEB.2.22.394.2210192208290.3068@hadrien>
 <Y1BeZYBf/xsW8F4O@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1BeZYBf/xsW8F4O@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 02:00:29AM +0530, Deepak R Varma wrote:
> On Wed, Oct 19, 2022 at 10:08:53PM +0200, Julia Lawall wrote:
> >
> >
> > On Thu, 20 Oct 2022, Deepak R Varma wrote:
> >
> > > Correct misleading struct type name dim_ch_state_t to dim_ch_state
> > > since this not a typedef but a normal structure declaration.
> > >
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >
> > > Changes in v4:
> > >    1. Correct patch subject and log message. Use struct type name instead of
> > >       variable name for the change description. Feedback from julia.lawall@inria.fr
> > >
> > > Changes in v3:
> > >    1. Patch introduced in the patch set
> > >
> > >  drivers/staging/most/dim2/dim2.c | 2 +-
> > >  drivers/staging/most/dim2/hal.c  | 4 ++--
> > >  drivers/staging/most/dim2/hal.h  | 6 +++---
> > >  3 files changed, 6 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/staging/most/dim2/dim2.c b/drivers/staging/most/dim2/dim2.c
> > > index 4c1f27898a29..a69a61a69283 100644
> > > --- a/drivers/staging/most/dim2/dim2.c
> > > +++ b/drivers/staging/most/dim2/dim2.c
> > > @@ -161,7 +161,7 @@ static int try_start_dim_transfer(struct hdm_channel *hdm_ch)
> > >  	struct list_head *head = &hdm_ch->pending_list;
> > >  	struct mbo *mbo;
> > >  	unsigned long flags;
> > > -	struct dim_ch_state_t st;
> > > +	struct dim_ch_state st;
> >
> > Is there another use in service_done_flag?
>
> Hi,
> I did not understand your question fully. This is from a different function
> try_start_dim_transfer where the variable st is used down the line in the
> execution. This time the channel state is retrieved by calling
> dim_get_channel_state function. The state is simply computed and set. Should I
> improve this as well?
>
> If you are asking something different, could you please elaborate?

Hi Julia,
Can you please review and comment on my response?

>
> ./drv
>
> >
> > julia
> >
> > >
>
>
>


