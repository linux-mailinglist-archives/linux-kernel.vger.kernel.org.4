Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26006512A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Dec 2022 20:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbiLSTR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Dec 2022 14:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiLSTRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Dec 2022 14:17:02 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467CE12D2F
        for <linux-kernel@vger.kernel.org>; Mon, 19 Dec 2022 11:16:52 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BEA8A320025E;
        Mon, 19 Dec 2022 14:16:49 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 19 Dec 2022 14:16:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tycho.pizza; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671477409; x=1671563809; bh=rjUsL417U0
        iV5j5xNXkCITEEN+5bMG2rGdx4wSKwQDE=; b=lJMbYQxjl7JexG9ECtnoyb3bDl
        AwiXT/9IE1P/V0FHHRP8PVY2uAylvMYpZ39uB5WVO5R9x9nr6ojQzYQdar7k78L3
        hFB1i6WS0+1FeABEHl3/ujbAXobKXGxpteobl/f830hQGZ3mzHOGrRb584b7ueeR
        yd8igHbj6jbTPSqT7HufTi/IPA+Assp0Ny/Ij8c/zFiGbn7P/zXByWWPnlxKMjSK
        N1Ye8g1MgI2+5kjoKTXUeSBNeWXtvrFxz7z5AUQoxaLxfS5KMbILLDYPekd9lerN
        94RIyxrKxtUQS26pnrLT2L4+x+UINkpbIPAx9oo2rAC6S1j/hPdu5wy5zI7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671477409; x=1671563809; bh=rjUsL417U0iV5j5xNXkCITEEN+5b
        MG2rGdx4wSKwQDE=; b=oulPqgvAkYRRLyvl0/1vjmmms3Y+ZwR7FMGT7b+TGI2E
        5Mi4ou80pOEzT1LqqF9oswKfRxS7BZaLxRtFWq/FIGDk+OdzSeoK79bn4SWFcqS0
        2ACpmTVpMtLKZ/u5veydv7X8282cJ0PWiPJyil5Pe97IA/epUUQSkTQtB7xp3yFM
        9JvG2LVm+Jxsyd7Omc7KQoTi+2wDrwY8d8OSghH4/OvwASXOU3h03Y7D9rxqMTIo
        XKmXaP5Z3Lu4dMe8dVxqhrWniw1UQNJfgtiDa1AnKszIbfeszACdSDoSCGgeOCvA
        vmTRtWRjQpQ5Dm7DCSwBLlIRhPGeEwubOpdCGZAOsg==
X-ME-Sender: <xms:oLigY0jVWcgdk-qLgA8KkgnHnQOj-A5QHfuq3OnJ59bmQAjbrO8BYg>
    <xme:oLigY9CbNFrL5pUYeYfh-OBcgGT4mC5gLBEIh7XtFeprvAlF5gKA_qB-Nx4OLqeiN
    wzstqSyGL-jIx8tYOs>
X-ME-Received: <xmr:oLigY8GPg6euFbfLMRDtuwKW_3-l-Uvq_RDLOqJdg9UHMHk4c6Sf2XC_xNYpAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgeefgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefvhigthhho
    ucetnhguvghrshgvnhcuoehthigthhhosehthigthhhordhpihiiiigrqeenucggtffrrg
    htthgvrhhnpeeutedttefgjeefffehffffkeejueevieefudelgeejuddtfeffteeklefh
    leelteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hthigthhhosehthigthhhordhpihiiiigr
X-ME-Proxy: <xmx:oLigY1QH-64N4h2I2909TCfeh2dCRIeubqb84Ma-_nzoPIUkEHwwjw>
    <xmx:oLigYxxbK9-uRz9rymjprQ6i9dLVWVrpPc5FcJcJ2XRApukE8jAaDw>
    <xmx:oLigYz6PB8C_aG7qfEX4ztfX2gheSZnaGeZFgj2rWH2KjZGVZApUpg>
    <xmx:obigY59ej475FRw4nUcmJo_VHrONRMUZeB9AH3FQrIWME7Hd_wRpYQ>
Feedback-ID: i21f147d5:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 19 Dec 2022 14:16:47 -0500 (EST)
Date:   Mon, 19 Dec 2022 12:16:46 -0700
From:   Tycho Andersen <tycho@tycho.pizza>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Eric Biederman <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
        "Serge E . Hallyn" <serge@hallyn.com>
Subject: Re: [PATCH v3] fuse: In fuse_flush only wait if someone wants the
 return code
Message-ID: <Y6C4ni3wpkaYxmLw@tycho.pizza>
References: <CAJfpegvrd2nsydG26stcmeEkdO1JLyeu69KrZs4dvVxXtoz42Q@mail.gmail.com>
 <20221114160209.1229849-1-tycho@tycho.pizza>
 <Y4TNI8+QVHFuzeZC@tycho.pizza>
 <CAJfpegtckCReg7V6ET4a8EW_X-WfmANQdc4hP26bV9zoRrk7Wg@mail.gmail.com>
 <Y5IjpyLHIF8PgQ6l@tycho.pizza>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5IjpyLHIF8PgQ6l@tycho.pizza>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 10:49:30AM -0700, Tycho Andersen wrote:
> On Thu, Dec 08, 2022 at 03:26:19PM +0100, Miklos Szeredi wrote:
> > On Mon, 28 Nov 2022 at 16:01, Tycho Andersen <tycho@tycho.pizza> wrote:
> > >
> > > Hi Milkos,
> > >
> > > On Mon, Nov 14, 2022 at 09:02:09AM -0700, Tycho Andersen wrote:
> > > > v3: use schedule_work() to avoid other sleeps in inode_write_now() and
> > > >     fuse_sync_writes(). Fix a UAF of the stack-based inarg.
> > >
> > > Thoughts on this version?
> > 
> > Skipping attr invalidation on success is wrong.
> 
> Agreed, that looks like my mistake.
> 
> > How about the attached (untested) patch?
> 
> It passes my reproducer with no warnings or anything. Feel free to
> add:
> 
> Tested-by: Tycho Andersen <tycho@tycho.pizza>
> 
> if you want to commit it.

Ping, thoughts on landing this?

Thanks,

Tycho
