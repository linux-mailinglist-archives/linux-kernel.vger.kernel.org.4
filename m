Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF50604E0E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 19:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbiJSREq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 13:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiJSREg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 13:04:36 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F74BC86
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666170260; bh=hEVfT2JbyLs5Gr5UpL/k8FYzC2YYLPYBL7rsr8QE1os=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=nqqOY52fDhvUSk9GiQxEkfA9Oj3Qiu/TopzlkVhfNh9+GeKN7Lt1+1hxM6nSm1xGE
         OZNKtxw7Y1+32wmcJ3/2i/vFv8WTq8qB6gbqvzNTimXmCaQ6ftm5uVaYSwsf51uCbc
         /cEULRGCC85GCYKtB3gxBn3K9xVK4IVKOiHXEvqc=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 11:04:20 +0200 (CEST)
X-EA-Auth: ntGaQGQ20LqP0d8FsaYBfrxaYSUSvESEasrQC7tE5rHoBo+C5kGzTortDq30IQ2mEasGIL6FWEqyBr/71xPweCOfjDC8gYQr
Date:   Wed, 19 Oct 2022 14:32:59 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Joe Perches <joe@perches.com>
Cc:     David Laight <David.Laight@aculab.com>,
        'Greg KH' <gregkh@linuxfoundation.org>,
        "outreachy@lists.linux.dev" <outreachy@lists.linux.dev>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "phil@philpotter.co.uk" <phil@philpotter.co.uk>,
        "paskripkin@gmail.com" <paskripkin@gmail.com>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kumarpraveen@linux.microsoft.com" <kumarpraveen@linux.microsoft.com>,
        "saurabh.truth@gmail.com" <saurabh.truth@gmail.com>
Subject: Re: [PATCH 2/4] staging: r8188eu: reformat long computation lines
Message-ID: <Y0+9Q6hIde3Y3tNC@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
 <Y01iLXp20G0FSJFG@kroah.com>
 <a0bef75b959f4ca6a7bbfaacd531f8ae@AcuMS.aculab.com>
 <Y06fKv7U0/GhZfSZ@debian-BULLSEYE-live-builder-AMD64>
 <e2675698427ed987dd88ed5f9996fe86e5315dbb.camel@perches.com>
 <Y0+WYIVTugrs6khA@debian-BULLSEYE-live-builder-AMD64>
 <3ce9206fc3b756e72ee4dcfbbad6cefae5fedada.camel@perches.com>
 <Y0+c1ljPcD+Qr4Gd@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y0+c1ljPcD+Qr4Gd@debian-BULLSEYE-live-builder-AMD64>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:14:38PM +0530, Deepak R Varma wrote:
> On Tue, Oct 18, 2022 at 11:38:22PM -0700, Joe Perches wrote:
> > On Wed, 2022-10-19 at 11:47 +0530, Deepak R Varma wrote:
> > > On Tue, Oct 18, 2022 at 10:43:07PM -0700, Joe Perches wrote:
> > > > On Tue, 2022-10-18 at 18:12 +0530, Deepak R Varma wrote:
> > > > > On Tue, Oct 18, 2022 at 11:21:26AM +0000, David Laight wrote:
> > > > > > From: Greg KH
> > > > > > > Sent: 17 October 2022 15:10
> > > > > > >
> > > > > > > On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> > > > > > > > Reformat long running computation instructions to improve code readability.
> > > > > > > > Address following checkpatch script complaints:
> > > > > > > > 	CHECK: line length of 171 exceeds 100 columns
> > > > > > > > 	CHECK: line length of 113 exceeds 100 columns
> > > > []
> > > > > > > > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > > []
> > > > > > > > @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
> > > > > > > >  	} else if (network_addr[0] == NAT25_IPX) {
> > > > > > > >  		unsigned long x;
> > > > > > > >
> > > > > > > > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
> > > > > > > network_addr[5] ^
> > > > > > > > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > > > > > > network_addr[10];
> > > > > > > > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> > > > > > >
> > > > > > > Why not go out to [4] here and then you are one line shorter?
> > > > > >
> > > > > > and/or use a shorter variable name....
> > > > > Hi David,
> > > > > I have already re-submitted the patch set with 4 in line arrangement. Do you
> > > > > still suggest using shorter variable names?
> > > >
> > > > Assuming this code is not performance sensitive, I suggest not just
> > > > molifying checkpatch but perhaps improving the code by adding a helper
> > > > function something like:
> > > >
> > > > u8 xor_array_u8(u8 *x, size_t len)
> > > > {
> > > > 	size_t i;
> > > > 	u8 xor = x[0];
> > > >
> > > > 	for (i = 1; i < len; i++)
> > > > 		xor ^= x[i];
> > > >
> > > > 	return xor;
> > > > }
> > > >
> > > > so for instance this could be:
> > > >
> > > > 		x = xor_array_u8(&network_addr[1], 10);
> > > >
> > >
> > > Hi Joe,
> > > Great suggestion. Thank you.
> > > Is there a way to confirm that this improvement won't impact performance? Will I
> > > need any specific hardware / device to run tests?
> >
> > I suggest reading the code to see if the uses are in some fast path.
>
> Sounds good. Thank you for your guidance.

Hi Joe,
based on the code review so far, I am unable to determine if the chain of
function calls are part of any fast path. There is not enough code comments or
documentation available with this code.

Considering my Outreachy patch submission targets and timelines, I am unable to
spend much time on this research right now; unless an expert can confirm it is
okay to add the routine you outlined. Else, I will put this in on my TODO list
and revisit when I have time.

R8188EU maintainers / experts,
Can you confirm if it is sensible to implement the helper function suggested by
Joe? If yes, I will include the improvement in my current patch set and resubmit
the set for review.

Thank you,
./drv






>
> >
>
>
>


