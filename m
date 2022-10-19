Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA6C6039D5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 08:38:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiJSGid convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Oct 2022 02:38:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiJSGib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:38:31 -0400
Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C86D6BD4A
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 23:38:30 -0700 (PDT)
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay10.hostedemail.com (Postfix) with ESMTP id 0B1B4C08CB;
        Wed, 19 Oct 2022 06:38:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf02.hostedemail.com (Postfix) with ESMTPA id 470438000D;
        Wed, 19 Oct 2022 06:38:24 +0000 (UTC)
Message-ID: <3ce9206fc3b756e72ee4dcfbbad6cefae5fedada.camel@perches.com>
Subject: Re: [PATCH 2/4] staging: r8188eu: reformat long computation lines
From:   Joe Perches <joe@perches.com>
To:     Deepak R Varma <drv@mailo.com>
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
Date:   Tue, 18 Oct 2022 23:38:22 -0700
In-Reply-To: <Y0+WYIVTugrs6khA@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1666011479.git.drv@mailo.com>
         <2dd27eff9aab5ffe31e61086c0584982794507cf.1666011479.git.drv@mailo.com>
         <Y01iLXp20G0FSJFG@kroah.com>
         <a0bef75b959f4ca6a7bbfaacd531f8ae@AcuMS.aculab.com>
         <Y06fKv7U0/GhZfSZ@debian-BULLSEYE-live-builder-AMD64>
         <e2675698427ed987dd88ed5f9996fe86e5315dbb.camel@perches.com>
         <Y0+WYIVTugrs6khA@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_NONE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Stat-Signature: qrp556xabu4rcgk3uzc5qu1f6emj8yp5
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 470438000D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/g0+7RQbC87mJXozGXiKxUhZ8kAexcSYs=
X-HE-Tag: 1666161504-437654
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-10-19 at 11:47 +0530, Deepak R Varma wrote:
> On Tue, Oct 18, 2022 at 10:43:07PM -0700, Joe Perches wrote:
> > On Tue, 2022-10-18 at 18:12 +0530, Deepak R Varma wrote:
> > > On Tue, Oct 18, 2022 at 11:21:26AM +0000, David Laight wrote:
> > > > From: Greg KH
> > > > > Sent: 17 October 2022 15:10
> > > > > 
> > > > > On Mon, Oct 17, 2022 at 06:52:50PM +0530, Deepak R Varma wrote:
> > > > > > Reformat long running computation instructions to improve code readability.
> > > > > > Address following checkpatch script complaints:
> > > > > > 	CHECK: line length of 171 exceeds 100 columns
> > > > > > 	CHECK: line length of 113 exceeds 100 columns
> > []
> > > > > > diff --git a/drivers/staging/r8188eu/core/rtw_br_ext.c b/drivers/staging/r8188eu/core/rtw_br_ext.c
> > []
> > > > > > @@ -211,8 +211,10 @@ static int __nat25_network_hash(unsigned char *network_addr)
> > > > > >  	} else if (network_addr[0] == NAT25_IPX) {
> > > > > >  		unsigned long x;
> > > > > > 
> > > > > > -		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^ network_addr[4] ^
> > > > > network_addr[5] ^
> > > > > > -			network_addr[6] ^ network_addr[7] ^ network_addr[8] ^ network_addr[9] ^
> > > > > network_addr[10];
> > > > > > +		x = network_addr[1] ^ network_addr[2] ^ network_addr[3] ^
> > > > > 
> > > > > Why not go out to [4] here and then you are one line shorter?
> > > > 
> > > > and/or use a shorter variable name....
> > > Hi David,
> > > I have already re-submitted the patch set with 4 in line arrangement. Do you
> > > still suggest using shorter variable names?
> > 
> > Assuming this code is not performance sensitive, I suggest not just
> > molifying checkpatch but perhaps improving the code by adding a helper
> > function something like:
> > 
> > u8 xor_array_u8(u8 *x, size_t len)
> > {
> > 	size_t i;
> > 	u8 xor = x[0];
> > 
> > 	for (i = 1; i < len; i++)
> > 		xor ^= x[i];
> > 
> > 	return xor;
> > }
> > 
> > so for instance this could be:
> > 
> > 		x = xor_array_u8(&network_addr[1], 10);
> > 
> 
> Hi Joe,
> Great suggestion. Thank you.
> Is there a way to confirm that this improvement won't impact performance? Will I
> need any specific hardware / device to run tests?

I suggest reading the code to see if the uses are in some fast path.

