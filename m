Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D995361396F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiJaO4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiJaO4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:56:05 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6690EC65
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=INRZigj25XUuHJcedMTmvQTxAXOYKe2nYr5bVOUmhFY=;
  b=FvMgwGi3/2kQcgLWeKKbACZBcLhvWBXp4ZJsnkjZQFiTp7+rX+Nl65KZ
   MwRZveAfZricO2jPW6a8PID07FF3XEYKMGO/waVlsjtwKpkosmJQfFC5x
   ER3ThLazU1vTwSpGw0kGFafJC5VY6uzzx522RzzWjFif1UB8x0PyNaZQh
   A=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.95,228,1661810400"; 
   d="scan'208";a="36110298"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2022 15:56:00 +0100
Date:   Mon, 31 Oct 2022 15:55:59 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
To:     Deepak R Varma <drv@mailo.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192u: remove unused macro definition
In-Reply-To: <Y1/fn1+cthIdPKl2@debian-BULLSEYE-live-builder-AMD64>
Message-ID: <b728f4b-3e20-87ac-c58e-8a567fadb02d@inria.fr>
References: <cover.1666754500.git.drv@mailo.com> <b7053d8737c048d6a878609f0ec24d66b18c5abd.1666754500.git.drv@mailo.com> <Y1kyr/hWqbKCzaaR@kroah.com> <Y1k5y5PVT6t0+OIS@debian-BULLSEYE-live-builder-AMD64> <Y1k8NWuTxOf6z5zL@kroah.com> <Y1rdEE8HBb9CVwlq@ubunlion>
 <Y1/fn1+cthIdPKl2@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 31 Oct 2022, Deepak R Varma wrote:

> On Fri, Oct 28, 2022 at 01:03:36AM +0530, Deepak Varma wrote:
> > On Wed, Oct 26, 2022 at 03:55:01PM +0200, Greg Kroah-Hartman wrote:
> > > On Wed, Oct 26, 2022 at 07:14:43PM +0530, Deepak R Varma wrote:
> > > > On Wed, Oct 26, 2022 at 03:14:23PM +0200, Greg Kroah-Hartman wrote:
> > > > > On Wed, Oct 26, 2022 at 08:58:44AM +0530, Deepak R Varma wrote:
> > > > > > Pre-processor macros that are defined but are never used should be
> > > > > > cleaned up to avoid unexpected usage.
> > > > > >
> > > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > > ---
> > > > > >  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 --
> > > > > >  1 file changed, 2 deletions(-)
> > > > > >
> > > > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > > index 00c07455cbb3..0b3dda59d7c0 100644
> > > > > > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > > @@ -230,8 +230,6 @@ struct cb_desc {
> > > > > >  #define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
> > > > > >  #define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl
> > > > > >
> > > > > > -#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
> > > > > > -
> > > > > >  #define free_ieee80211			free_ieee80211_rsl
> > > > > >  #define alloc_ieee80211			alloc_ieee80211_rsl
> > > > >
> > > > > These #defines are a mess, please look into unwinding them as they
> > > > > should not be needed at all.
> > > >
> > > > Hello Greg,
> > > > I would like to know what you mean by "unwind them". Is there a documentation or past
> > > > commit that I can review to understand the expectations better?
> > >
> > > Look at them and try to figure out why they are there, and then work to
> > > remove them entirely.  A define like this is very odd in the kernel, it
> > > should not be needed at all, right?
> >
> > Hello Greg,
> > I will look into these additional macros soon and send any further edits as a
> > separate patch (set). Is the current patch set with 2 patches acceptable?
> >
> > Also, I am trying to get Coccinelle to work on my machine. Trying to work
> > through strange issues. I will work on the macro unwinding task you suggested
> > once a get the Coccinelle task completed.
>
> Hello Greg,
> Most of these macro defines appear to be unused in the module anywhere.
> I can simply delete the #defines for these and let the original function
> names be retained.
> The other way is to rename the functions by the defined value. So, we will have
> to make the code change to use the foo_rsl symbol names at all places. This will
> be a bigger change involving the API name change itself.

I'm not sure to understand.  In the case of

#define abc def

If abc is never used, it would seem that you could just remove the macro
definition.

If abc is used, one might consider whether the renaming is worth it, or
whether the abc's should be changed to def.  Or maybe def is a very simple
function, that just calls some standard kernel function like kfree, in
which can you could get rid of both abc and def everywhere and just use
kfree.

It is often better to use standard functions, because it makes it easier
for people to understand immediately what is going on.

julia


>
> I am unable to determine the initial intention as to why these #defines were
> added. Can you please suggest what would be the recommended way for the clean up
> of these unused macros?
>
> Thank you,
> ./drv
>
> >
> > Thank you,
> > ./drv
> >
> > >
> > > thanks,
> > >
> > > greg k-h
> > >
> >
> >
> >
>
>
>
>
