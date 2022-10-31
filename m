Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D53613940
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 15:46:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbiJaOqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 10:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbiJaOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 10:46:06 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3551B101CD
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 07:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1667227551; bh=F7/jUVASJHFdFrib2qiFCrAoDx3j0XxPPYgG1AbgNR4=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=bV3JJgsu14hA7EAeUOslFLEl5VDNVbvrXQWBrehz5fziUiV/pA5r53roxk4F4pze8
         nEV9A5wF0mbA3wNk6KNitu9ecRDKbITWqGSNhBoIKWZWRine5QqL0ehsbIR9nv+7L6
         BWHRO5dGDVCIz45TEs6oMTGujocN196LXK5keb5A=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via [213.182.55.206]
        Mon, 31 Oct 2022 15:45:51 +0100 (CET)
X-EA-Auth: 6XfSXNO20IQJl9fhQUCf1G+bp7BY2kb6am+RAmSXTh5tu9X2ORcRGUnf+30EMF8X96Pg0x/BStdiBjjZ2egP+0gDc3tLiq9N
Date:   Mon, 31 Oct 2022 20:15:51 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: rtl8192u: remove unused macro definition
Message-ID: <Y1/fn1+cthIdPKl2@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666754500.git.drv@mailo.com>
 <b7053d8737c048d6a878609f0ec24d66b18c5abd.1666754500.git.drv@mailo.com>
 <Y1kyr/hWqbKCzaaR@kroah.com>
 <Y1k5y5PVT6t0+OIS@debian-BULLSEYE-live-builder-AMD64>
 <Y1k8NWuTxOf6z5zL@kroah.com>
 <Y1rdEE8HBb9CVwlq@ubunlion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1rdEE8HBb9CVwlq@ubunlion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 01:03:36AM +0530, Deepak Varma wrote:
> On Wed, Oct 26, 2022 at 03:55:01PM +0200, Greg Kroah-Hartman wrote:
> > On Wed, Oct 26, 2022 at 07:14:43PM +0530, Deepak R Varma wrote:
> > > On Wed, Oct 26, 2022 at 03:14:23PM +0200, Greg Kroah-Hartman wrote:
> > > > On Wed, Oct 26, 2022 at 08:58:44AM +0530, Deepak R Varma wrote:
> > > > > Pre-processor macros that are defined but are never used should be
> > > > > cleaned up to avoid unexpected usage.
> > > > >
> > > > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > > > ---
> > > > >  drivers/staging/rtl8192u/ieee80211/ieee80211.h | 2 --
> > > > >  1 file changed, 2 deletions(-)
> > > > >
> > > > > diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211.h b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > index 00c07455cbb3..0b3dda59d7c0 100644
> > > > > --- a/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211.h
> > > > > @@ -230,8 +230,6 @@ struct cb_desc {
> > > > >  #define ieee80211_unregister_crypto_ops ieee80211_unregister_crypto_ops_rsl
> > > > >  #define ieee80211_get_crypto_ops	ieee80211_get_crypto_ops_rsl
> > > > >
> > > > > -#define ieee80211_ccmp_null		ieee80211_ccmp_null_rsl
> > > > > -
> > > > >  #define free_ieee80211			free_ieee80211_rsl
> > > > >  #define alloc_ieee80211			alloc_ieee80211_rsl
> > > >
> > > > These #defines are a mess, please look into unwinding them as they
> > > > should not be needed at all.
> > >
> > > Hello Greg,
> > > I would like to know what you mean by "unwind them". Is there a documentation or past
> > > commit that I can review to understand the expectations better?
> >
> > Look at them and try to figure out why they are there, and then work to
> > remove them entirely.  A define like this is very odd in the kernel, it
> > should not be needed at all, right?
>
> Hello Greg,
> I will look into these additional macros soon and send any further edits as a
> separate patch (set). Is the current patch set with 2 patches acceptable?
>
> Also, I am trying to get Coccinelle to work on my machine. Trying to work
> through strange issues. I will work on the macro unwinding task you suggested
> once a get the Coccinelle task completed.

Hello Greg,
Most of these macro defines appear to be unused in the module anywhere.
I can simply delete the #defines for these and let the original function
names be retained.
The other way is to rename the functions by the defined value. So, we will have
to make the code change to use the foo_rsl symbol names at all places. This will
be a bigger change involving the API name change itself.

I am unable to determine the initial intention as to why these #defines were
added. Can you please suggest what would be the recommended way for the clean up
of these unused macros?

Thank you,
./drv

>
> Thank you,
> ./drv
>
> >
> > thanks,
> >
> > greg k-h
> >
>
>
>


