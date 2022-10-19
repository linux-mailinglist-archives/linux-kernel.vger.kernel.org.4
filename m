Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED4486039FE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiJSGqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbiJSGqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:46:20 -0400
Received: from msg-4.mailo.com (msg-4.mailo.com [213.182.54.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F06B4DF03
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666161958; bh=e4WxRq6xVQXdhDP7V5crdtEK+/DzIDEQrwg11Rt5GxI=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=UG/inypxWB0tczsGfM9UjDZvVGol/hnaBVPXZgVN8yWlTKKuLgeGxWTMvwFJXyLhf
         Y6NbZejrUP6uZr7qSlm2auvXRCo0bNP0sMzMdqeChl3PKLKQacEhaDmFTmihH85I0f
         ghHGJoozF2L8al16DFv+Cm10G41sMWIC6VSRxeGY=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via [213.182.55.206]
        Wed, 19 Oct 2022 08:45:58 +0200 (CEST)
X-EA-Auth: p5bUe3dqGxoEK1Q9TRfMlMmLH5kBlQznU4+QWxq44+hdO1oAYqXLdjkguZCr9SPpDrLJGz+VEjEqIt2foJTUEj9mIGX8V8RV
Date:   Wed, 19 Oct 2022 12:14:38 +0530
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
Message-ID: <Y0+c1ljPcD+Qr4Gd@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
 <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
 <Y01iLXp20G0FSJFG@kroah.com>
 <a0bef75b959f4ca6a7bbfaacd531f8ae@AcuMS.aculab.com>
 <Y06fKv7U0/GhZfSZ@debian-BULLSEYE-live-builder-AMD64>
 <e2675698427ed987dd88ed5f9996fe86e5315dbb.camel@perches.com>
 <Y0+WYIVTugrs6khA@debian-BULLSEYE-live-builder-AMD64>
 <3ce9206fc3b756e72ee4dcfbbad6cefae5fedada.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ce9206fc3b756e72ee4dcfbbad6cefae5fedada.camel@perches.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:38:22PM -0700, Joe Perches wrote:
> On Wed, 2022-10-19 at 11:47 +0530, Deepak R Varma wrote:
> > On Tue, Oct 18, 2022 at 10:43:07PM -0700, Joe Perches wrote:
> > > On Tue, 2022-10-18 at 18:12 +0530, Deepak R Varma wrote:
> > > > On Tue, Oct 18, 2022 at 11:21:26AM +0000, David Laight wrote:
> > > > > From: Greg KH
> > > > > > Sent: 17 October 2022 15:10
> > > > > >
> > > > > > On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> > > > > > > Reformat long running computation instructions to improve code readability.
> > > > > > > Address following checkpatch script complaints:
> > > > > > > 	CHECK: line length of 171 exceeds 100 columns
> > > > > > > 	CHECK: line length of 113 exceeds 100 columns
> > > []
> > > > > > > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > > []
> > > > > > > @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
> > > > > > >  	} else if (network_addr[0] == NAT25_IPX) {
> > > > > > >  		unsigned long x;
> > > > > > >
> > > > > > > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
> > > > > > network_addr[5] ^
> > > > > > > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > > > > > network_addr[10];
> > > > > > > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> > > > > >
> > > > > > Why not go out to [4] here and then you are one line shorter?
> > > > >
> > > > > and/or use a shorter variable name....
> > > > Hi David,
> > > > I have already re-submitted the patch set with 4 in line arrangement. Do you
> > > > still suggest using shorter variable names?
> > >
> > > Assuming this code is not performance sensitive, I suggest not just
> > > molifying checkpatch but perhaps improving the code by adding a helper
> > > function something like:
> > >
> > > u8 xor_array_u8(u8 *x, size_t len)
> > > {
> > > 	size_t i;
> > > 	u8 xor = x[0];
> > >
> > > 	for (i = 1; i < len; i++)
> > > 		xor ^= x[i];
> > >
> > > 	return xor;
> > > }
> > >
> > > so for instance this could be:
> > >
> > > 		x = xor_array_u8(&network_addr[1], 10);
> > >
> >
> > Hi Joe,
> > Great suggestion. Thank you.
> > Is there a way to confirm that this improvement won't impact performance? Will I
> > need any specific hardware / device to run tests?
>
> I suggest reading the code to see if the uses are in some fast path.

Sounds good. Thank you for your guidance.

>


