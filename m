Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEE216BD604
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 17:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbjCPQjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 12:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjCPQj1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 12:39:27 -0400
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471C13A9A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 09:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1678984687; bh=Kti0gAcbr59Xg+6okdBU+uD+W9xf9sDWRStCrAcOJ4s=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=MpYMyj3h+WRHsz5m/3dSCHqHcdsQqcU3iipwsS5ST06faAeCUENQH0FKMnmLp3Hau
         A6SV+tumrNAD+6gbnnoMFqD6FwgVcSM5Cpb9optdmbrC1Pzb/ZrU8lswMb0mxzD3qE
         UmqOReO9/jU2u0+/WqT3NQJCXD4oq08ZlUNV83rA=
Received: by b221-1.in.mailobj.net [192.168.90.21] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Thu, 16 Mar 2023 17:38:07 +0100 (CET)
X-EA-Auth: xS5K6sMJyZB5C4Xo8c0qOvU9JMnb3RCzRI4ueGQqMOL0OEgihcPYCVFynBD70bzxim6YtGVEOL1XkPsZhPyx6OVzWCTi9MQ6
Date:   Thu, 16 Mar 2023 22:07:57 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Sumitra Sharma <sumitraartsy@gmail.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev
Subject: Re: [PATCH v2] Staging: octeon: Fix line ending with '('
Message-ID: <ZBNF5YY/a3msg78k@ubun2204.myguest.virtualbox.org>
References: <20230316155202.GA82100@sumitra.com>
 <ZBNAkYSO3ARPbjKU@ubun2204.myguest.virtualbox.org>
 <20230316162442.GA82267@sumitra.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316162442.GA82267@sumitra.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2023 at 09:24:42AM -0700, Sumitra Sharma wrote:
> On Thu, Mar 16, 2023 at 09:45:13PM +0530, Deepak R Varma wrote:
> > On Thu, Mar 16, 2023 at 08:52:02AM -0700, Sumitra Sharma wrote:
> > > Adhere to coding-style.
> > 
> > Hi Sumitra,
> > Quick background: Linux Kernel coding style required developers to limit the
> > code within 80 columns per line. This resulted in splitting the long lines into
> > more than one lines. Some splits were unwillingly poor causing checkpatch error
> > [e.g. this one that you are attempting to address].
> > Recently, the 80 column limit was relaxed to 100 columns. This now will allow to
> > merge some poorly split lines resulting in improved readability and avoid
> > checkpath complaints.
> >
> Hi Deepak
> 
> Since, you mentioned that the 80 column limit has been relaxed to 100
> columns. So will then this patch be useful??

Yes, that change from 80 to 100 makes way for your patch.

Also always do a "reply-all". You can add more recipients to the email if
necessary, but you should not remove anyone.

> 
> > Now, can you use this information to convert your live above a little more
> > descriptive. Remember a well written "why" explanation is almost always
> > necessary.
> 
> Okay!
> 
> > 
> > > 
> > > Checkpatch has reported code style warning:
> > > CHECK: Lines should not end with a '('.
> > > 
> > > Enhance the design of a function header:
> > > Align the function parameters immediately after '(' in a single line.
> > 
> > This is the "what" part and not so useful for such a simple change. You need not
> > write this. However for complex changes or tricky code optimization, the "what"
> > part will be very useful as well.
> >
> 
> I will keep this in mind.
> 
> > Hope this helps.
> > 
> > Deepak.
> > 
> > > 
> 
> Regards
> 
> SUmitra
> > > Signed-off-by: Sumitra Sharma <sumitraartsy@gmail.com>
> > > ---
> > > 
> > > v2: Change patch subject and description.
> > > 
> > >  drivers/staging/octeon/octeon-stubs.h | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/staging/octeon/octeon-stubs.h b/drivers/staging/octeon/octeon-stubs.h
> > > index 7a02e59e283f..3e7b92cd2e35 100644
> > > --- a/drivers/staging/octeon/octeon-stubs.h
> > > +++ b/drivers/staging/octeon/octeon-stubs.h
> > > @@ -1372,9 +1372,7 @@ static inline void cvmx_fau_async_fetch_and_add32(uint64_t scraddr,
> > >  						  int32_t value)
> > >  { }
> > >  
> > > -static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(
> > > -	int interface,
> > > -	int port)
> > > +static inline union cvmx_gmxx_rxx_rx_inbnd cvmx_spi4000_check_speed(int interface, int port)
> > >  {
> > >  	union cvmx_gmxx_rxx_rx_inbnd r;
> > >  
> > > -- 
> > > 2.25.1
> > > 
> > > 
> > 
> > 


