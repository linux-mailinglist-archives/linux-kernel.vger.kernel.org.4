Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3375260114F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 16:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiJQOkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 10:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiJQOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 10:40:36 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0DD5AA28
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 07:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666017620; bh=hrVvHrfFWX/zUmEet33OGmsTs22YqEFCpVEbOT2941k=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=jotFTq2ZV+19JyoHeQwjKH1zmvp3uekpxmVHkwDtO92sKudzUMcXgIsjgP/EeiK3R
         lO5RvAHDNSUQ/raVeUFlp+1pfVX50UHMLJYOTxsDvkQPESgjcOyyMCEKVLSKCBrO72
         lbnxjnXGBT+3yj4Pnuatlz5cIv9xj+W+qzx7cYhM=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Mon, 17 Oct 2022 16:40:20 +0200 (CEST)
X-EA-Auth: KqMRjCz+u0MP0lsX8Hn5F7H1pAy0qTp7ksZUbQgADB2c/8l6MoAXejKcYm5NdGYkcbU56dZXSn2L1DghDG8ILV7OToZ8e6Am
Date:   Mon, 17 Oct 2022 19:40:46 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kumarpraveen@linux.microsoft.com, saurabh.truth@gmail.com
Subject: Re: [PATCH 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <Y01iZjkZuIPgcfz4@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
 <Y01iLXp20G0FSJFG@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y01iLXp20G0FSJFG@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2022 at 04:09:49PM +0200, Greg KH wrote:
> On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> > Reformat long running computation instructions to improve code readability.
> > Address following checkpatch script complaints:
> > 	CHECK: line length of 171 exceeds 100 columns
> > 	CHECK: line length of 113 exceeds 100 columns
> >
> > Signed-off-by: Deepak R Varma <drv@mailo.com>
> > ---
> >  drivers/staging/r8188eu/core/rtw_br_ext.c | 20 +++++++++++++-------
> >  1 file changed, 13 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > index 79daf8f269d6..427da7e8ba4c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_br_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
> >  	} else if (network_addr[0] == NAT25_IPX) {
> >  		unsigned long x;
> >
> > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10];
> > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
>
> Why not go out to [4] here and then you are one line shorter?

Thank you for the feedback.
Arranging 4 on a line still made the line extend 90+ columns. It appeared wide
to me. Stacking three in one line made it look better.
I will resend the patch with 4 in line and let you suggest if that is
acceptable.

Thank you,
./drv

>
> > +		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
> > +		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > +		    network_addr[10];
> >
> >  		return x & (NAT25_HASH_SIZE - 1);
> >  	} else if (network_addr[0] == NAT25_APPLE) {
> > @@ -224,16 +226,20 @@ static int __nat25_network_hash(unsigned char *network_addr)
> >  	} else if (network_addr[0] == NAT25_PPPOE) {
> >  		unsigned long x;
> >
> > -		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^ network_addr[6] ^ network_addr[7] ^ network_addr[8];
> > +		x = network_addr[0] ^ network_addr[1] ^ network_addr[2] ^
> > +		    network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
>
> Same here
>
>
> > +		    network_addr[6] ^ network_addr[7] ^ network_addr[8];
> >
> >  		return x & (NAT25_HASH_SIZE - 1);
> >  	} else if (network_addr[0] == NAT25_IPV6) {
> >  		unsigned long x;
> >
> > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^ network_addr[5] ^
> > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^ network_addr[10] ^
> > -			network_addr[11] ^ network_addr[12] ^ network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
> > -			network_addr[16];
> > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> > +		    network_addr[4] ^ network_addr[5] ^ network_addr[6] ^
> > +		    network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > +		    network_addr[10] ^ network_addr[11] ^ network_addr[12] ^
> > +		    network_addr[13] ^ network_addr[14] ^ network_addr[15] ^
> > +		    network_addr[16];
>
> And here.
>
> thanks,
>
> greg k-h
>


