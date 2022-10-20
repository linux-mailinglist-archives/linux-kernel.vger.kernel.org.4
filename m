Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF41B6071FD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiJUIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJUIUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 04:20:23 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF30B95AEA
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 01:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666340402; bh=+bQsr/W07yQh8PSQPd19qBisDeIL2JsbU1VDu9a269Q=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=iKKlGhfpLUkPrBTNQ8T9u30eCy9n5o9P0J8tYbh3FkrIuJWMASsvse3EKPCFvUZqU
         axIutcr/BkIIf5ZUPbu06b2QSIxwKlU3Y48INhlkJvi3cN2hxjYeG+eLhAeY5lHuH3
         m6u2diX05nJ26N4qiZFmKH0gjBfFuAUoXOJo65UM=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Fri, 21 Oct 2022 10:20:02 +0200 (CEST)
X-EA-Auth: AzBcy7NE4SFdLzeZ97hR04GHdzi986N4Bwe5hnKmG3+d5+xMYNGkm2ibmH7Vx7+53i0z6jhALnJVg0GYjoYNuK1cCENFsaHO
Date:   Fri, 21 Oct 2022 05:04:37 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        saurabh.truth@gmail.com
Subject: Re: [PATCH v4 11/11] staging: r8188eu: Remove unused macros
Message-ID: <Y1HbDZbZvdme1hJb@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666299151.git.drv@mailo.com>
 <efaf637a14b6f7fdd0178e2aecf8abf17e6922f6.1666299151.git.drv@mailo.com>
 <b038a335-29a3-5118-bda6-9b3230094f90@linux.microsoft.com>
 <Y1I0dcZqMJAzHSm2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1I0dcZqMJAzHSm2@kroah.com>
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 21, 2022 at 07:56:05AM +0200, Greg KH wrote:
> On Fri, Oct 21, 2022 at 11:21:06AM +0530, Praveen Kumar wrote:
> > On 21-10-2022 03:02, Deepak R Varma wrote:
> > > Simple variants of macros PlatformEFIOWrite and PlatformEFIORead are
> > > defined but never used. As they do not appear to be designed for anything
> > > significant, we can remove them to avoid unexpected usage.
> > >
> > > Suggested-by: Julia Lawall <julia.lawall@inria.fr>
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >
> > > Changes in v4:
> > >    1. Patch newly added to the patch set.
> > >
> > >
> > >  drivers/staging/r8188eu/include/rtw_io.h | 14 --------------
> > >  1 file changed, 14 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
> > > index 87fcf6c94ff3..e9744694204b 100644
> > > --- a/drivers/staging/r8188eu/include/rtw_io.h
> > > +++ b/drivers/staging/r8188eu/include/rtw_io.h
> > > @@ -285,18 +285,4 @@ void bus_sync_io(struct io_queue *pio_q);
> > >  u32 _ioreq2rwmem(struct io_queue *pio_q);
> > >  void dev_power_down(struct adapter *Adapter, u8 bpwrup);
> > >
> > > -#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
> > > -	rtw_write8(_a, _b, _c)
> > > -#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
> > > -	rtw_write16(_a, _b, _c)
> > > -#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
> > > -	rtw_write32(_a, _b, _c)
> > > -
> > > -#define PlatformEFIORead1Byte(_a, _b)		\
> >
> > Can the naming be reworked to make more Linux friendly ? something like PLATFORM_EFIO_READ1BYTE or better if there are other suggestions?
> > Rest others as applicable ?
>
> All of these should just be removed entirely and the normal calls here
> made instead.  There is no need for these #defines at all.

Hello Greg,
The current patch scope results in removal of these #defines. Can you please
clarify what you mean by "normal calls here made instead"? Do you mean the
calling function should directly call the wrapped functions OR you are
suggesting converting these #defines to inline functions?

Thank you,
./drv

>
> thanks,
>
> greg k-h
>


