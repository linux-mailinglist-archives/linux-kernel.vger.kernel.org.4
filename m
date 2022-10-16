Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 992A160009F
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Oct 2022 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiJPP2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 11:28:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJPP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 11:27:58 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359D38698
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1665934054; bh=idphqeTWigMQZuxHgdQxb95C3J+mkr7ydRxjaUo2v58=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=m7ktjrzw+kdMSMJSSq5r7nxPtiOyL7Y3Oq+sqcOzOl+mnS3AadRiMKTz2v1eIOFqM
         yVM8/RPGYeYaEoLSSiG7BrERSqfz0qXcND6gPtJAibo8s77XfmNrxBeZB0bX1ynBIe
         rhNqechEshiNvUg0/ZrBWJrY4H39qNFiQbFzPwCg=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via [213.182.55.206]
        Sun, 16 Oct 2022 17:27:34 +0200 (CEST)
X-EA-Auth: TAQoDZSVK1o2VN0sLBUdUgl53zSZIISs75W0QBybmcPF3auhezmRA4KZCynaH0DQyXoDguusPNZNd3wRRszMy2YJjc3SKeyk
Date:   Sun, 16 Oct 2022 11:27:30 -0400
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     outreachy@lists.linux.dev, pure.logic@nexus-software.ie,
        johan@kernel.org, elder@kernel.org, gregkh@linuxfoundation.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: greybus: loopback: enclose macro statements in
 do-while loop
Message-ID: <Y0wi4itS3d8aExFc@debian-BULLSEYE-live-builder-AMD64>
References: <Y0wS4HQo9m/W/TrQ@debian-BULLSEYE-live-builder-AMD64>
 <alpine.DEB.2.22.394.2210161649400.2876@hadrien>
 <Y0wdDTUBrUT/cr9w@lion2204>
 <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2210161709440.2876@hadrien>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 16, 2022 at 05:10:17PM +0200, Julia Lawall wrote:
>
>
> On Sun, 16 Oct 2022, Deepak R Varma wrote:
>
> > On Sun, Oct 16, 2022 at 04:51:09PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Sun, 16 Oct 2022, Deepak R Varma wrote:
> > >
> > > > Include multiple statements of macro definition inside do-while{0} loop
> > > > to avoid possible partial program execution. Issue reported by
> > > > checkpatch script:
> > > >
> > > > ERROR: Macros with multiple statements should be enclosed in a do - while loop
> > >
> > > I don't think this change will compile.  See if you can figure out why
> > > not.
> >
> > It did compile. I built the greybus driver and loaded it as well with the
> > modinfo tool. Can you please tell why you think it won't compile?
>
> Do you have a .o file for the .c file that you changed?

I see many .o files and a greybus.ko as well, but not the loopback.o
Am I missing anything with my configuration? I did set Greybus Support to (M) in
the menuconfig.

Thank you,
./drv

>
> julia
>
> >
> > ./drv
> >
> > >
> > > julia
> > >
> > > >
> > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > ---
> > > >  drivers/staging/greybus/loopback.c | 4 +++-
> > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/staging/greybus/loopback.c b/drivers/staging/greybus/loopback.c
> > > > index 1a61fce98056..37214cb43937 100644
> > > > --- a/drivers/staging/greybus/loopback.c
> > > > +++ b/drivers/staging/greybus/loopback.c
> > > > @@ -163,9 +163,11 @@ static ssize_t name##_avg_show(struct device *dev,		\
> > > >  static DEVICE_ATTR_RO(name##_avg)
> > > >
> > > >  #define gb_loopback_stats_attrs(field)				\
> > > > +do {								\
> > > >  	gb_loopback_ro_stats_attr(field, min, u);		\
> > > >  	gb_loopback_ro_stats_attr(field, max, u);		\
> > > > -	gb_loopback_ro_avg_attr(field)
> > > > +	gb_loopback_ro_avg_attr(field);				\
> > > > +} while (0)
> > > >
> > > >  #define gb_loopback_attr(field, type)					\
> > > >  static ssize_t field##_show(struct device *dev,				\
> > > > --
> > > > 2.30.2
> > > >
> > > >
> > > >
> > > >
> > > >
> >
> >
> >
>


