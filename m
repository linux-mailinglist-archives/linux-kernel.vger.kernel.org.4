Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99539602BF1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 14:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiJRMmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 08:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJRMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 08:42:43 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85E64C34EB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 05:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666096943; bh=BJDZOO5EfwDno9TdDKdQmr48wqt9eejt/Cff+GSpELk=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=D60+1QoBi0PuMtbVk/gBCxBWJUEHGmxpEsKdmdIxc2R0yEZdJ0VyyNCtBw1whVdO8
         uvKNk9V+udiLcWjqOWbqZXtXpRHV7odT4jPcB+QnlW0TSejlp9US2CytJOA5/+LEd8
         FCRIPkQ5jQA85cdF+vZyIp68IhAWyXNgq5xW9g+U=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Tue, 18 Oct 2022 14:42:23 +0200 (CEST)
X-EA-Auth: GMNQmFwPLIUsLG2ugeTbCJcxK9/GrW8tViAzMAFA14Op7bLkoJlCRbSHs8SEiLiF9UxVvYtNvFM3avWpdMPj6oz1mhWeKVOs
Date:   Tue, 18 Oct 2022 18:12:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     David Laight <David.Laight@aculab.com>
Cc:     'Greg KH' <gregkh@linuxfoundation.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "paskripkin@gmail.com" <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "saurabh.truth@gmail.com" <saurabh.truth@gmail.com>
Subject: Re: [PATCH 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <Y06fKv7U0/GhZfSZ@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
 <Y01iLXp20G0FSJFG@kroah.com>
 <a0bef75b959f4ca6a7bbfaacd531f8ae@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bef75b959f4ca6a7bbfaacd531f8ae@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:21:26AM +0000, David Laight wrote:
> From: Greg KH
> > Sent: 17 October 2022 15:10
> >
> > On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> > > Reformat long running computation instructions to improve code readability.
> > > Address following checkpatch script complaints:
> > > 	CHECK: line length of 171 exceeds 100 columns
> > > 	CHECK: line length of 113 exceeds 100 columns
> > >
> > > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > > ---
> > >  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 +++++++++++++-------
> > >  1 file changed, 13 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > index 79daf8f269d6..427da7e8ba4c 100644
> > > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
> > >  	} else if (network_addr[0] == NAT25_IPX) {
> > >  		unsigned long x;
> > >
> > > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
> > network_addr[5] ^
> > > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > network_addr[10];
> > > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> >
> > Why not go out to [4] here and then you are one line shorter?
>
> and/or use a shorter variable name....
Hi David,
I have already re-submitted the patch set with 4 in line arrangement. Do you
still suggest using shorter variable names?

Thank you,
./drv

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>
>


