Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 088FD5B6C40
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbiIMLNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiIMLNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:13:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4854F1B6;
        Tue, 13 Sep 2022 04:13:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E6D9B80E45;
        Tue, 13 Sep 2022 11:13:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7561C433C1;
        Tue, 13 Sep 2022 11:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663067620;
        bh=PCCw5NlJaw6DcJUfghw6Xh6pwVzJ/qYI7QEQ8GI8lWY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gRtFFwxOt3Qv1L0btVBcy4CR3kCBBgvK/nG4PV0Flcp1QB4Tu8cp2yjm7v+P6iRG9
         FbtLDtwHDNAHnJ/rD7pMrlB8eG6iG8MWrR3ZR3Em06NxwxCxr5yBJqkCFva6QbkjdM
         Bao1TyAKUPv1ycihxqFXJBSnD3BidVTdPEQ69Y80=
Date:   Tue, 13 Sep 2022 13:14:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-spdx@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 0/2] SPDX tags for copyright
Message-ID: <YyBl/FUVndtEFkW9@kroah.com>
References: <20220908223850.13217-1-u.kleine-koenig@pengutronix.de>
 <YyAPsqKNSwdHccLj@infradead.org>
 <YyA9S9KD47D6Hoce@kroah.com>
 <20220913094635.g2gtqrpveknjusup@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913094635.g2gtqrpveknjusup@pengutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 11:46:35AM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> [dropped Kai Germaschewski as his email address doesn't work]
> 
> On Tue, Sep 13, 2022 at 10:20:27AM +0200, Greg KH wrote:
> > On Mon, Sep 12, 2022 at 10:05:54PM -0700, Christoph Hellwig wrote:
> > > On Fri, Sep 09, 2022 at 12:38:48AM +0200, Uwe Kleine-König wrote:
> > > > Hello,
> > > > 
> > > > for Debian packaging having SPDX license tags already simplifies
> > > > creating the required copyright documentation considerably. Another
> > > > information that is needed for Debian packaging is the copyright
> > > > information. There is an SPDX way for copyright information, too. The
> > > > second patch converts scripts/kallsyms.c to that mechanism as an example
> > > > to maybe discuss if we want to do that in the kernel.
> > > > 
> > > > While the SPDX-FileCopyrightText is officially a free-form field, I
> > > > suggest to just stick to the format
> > > > 
> > > > 	(<year> )?<copyright holder>
> > > > 
> > > > to simplify machine consumption even further.
> > > 
> > > Adding the linux-spdx list and Linus.  If we go with this format
> 
> Ah, didn't know about the spdx list (and didn't dare to bother Linus
> with that). Thanks!
> 
> > > (which doesn't sound bad), we'll clearly need to document the format
> > > we want, and that people should use it.
> > 
> > There is a well-agreed-apon legal format for copyright lines already,
> > and those lines should be fine in the comment text at the top of the
> > file.  No need to mess with SPDX-FileWhateverTagWeWant type of stuff
> > here at all as all of our tools can easily find those lines if they
> > really want to extract the copyright information.
> 
> I didn't find a tool that can extract these informations in the
> collection of scripts (i.e. below scripts/). Did I miss anything?

It's not in the kernel tree, sorry, there are external tools that can do
this if you really want to.  Like 'grep' as you found :)

> What is that "well-agreed-upon legal format for copyright lines"?

There's a whole LF presentation that goes into all of the details on
this that is free:
	https://training.linuxfoundation.org/training/open-source-licensing-basics-for-software-developers/
and a short summary:
	https://www.linuxfoundation.org/blog/copyright-notices-in-open-source-software-projects/

But many company legal departments have their own format and
requirements so there might be variations.  Talk to your lawyers for
what they require/recommend if you work for a company and want to put a
copyright line in a file.

> Grepping a bit around, here are some examples:
> 
>  * Portions Copyright (c) 2004-2006 Silicon Graphics, Inc.
>  * - Copyright (C) 2001 Junichi Morita <jun1m@mars.dti.ne.jp>
>  * **Copyright** |copy| 1999-2020 : LinuxTV Developers
>  * Copyright: |copy| 1995--1999 Martin Mares, <mj@ucw.cz>
>  * Copyright (c) 2000
>    - Jorge Nerin <comandante@zaralinux.com>
>  * Ben Dooks, Copyright 2006 Simtec Electronics
>  * Copyright, IBM Corp. 1999-2002
>  * :copyright:  Copyright (C) 2016  Markus Heiser
>  * Copyright (C) 2015 Atmel,
>                  2015 Nicolas Ferre <nicolas.ferre@atmel.com>
> 
> and this is just the unusal stuff I found in a few minutes.

And you need to get approval from all of those owners to change that
text.  And the SPDX-Tag format will not help with this at all.

As you did a simple grep to find the above, finding copyright lines is
not as difficult as determining license text variations that we
currently are dealing with.

So what's the benefit of changing anything right now as no one is saying
we have Copyright line identification issues?

> > SPDX is great for license declarations, let's stick with only using that
> > for now until we finish the whole kernel and then maybe we can worry
> > about adding additional meta information if it's really decided it can
> > benifit anyone.
> 
> When converting a file to use SPDX-License-Identifier adding the SPDX
> copyright stuff in the same commit might save some churn?!

Again, we aren't recommending to touch copyright lines at all with the
current SPDX stuff.  Let's focus on licenses first please, that effort
is not yet complete.

> Wasn't the situation with licenses similar before SPDX was in use? i.e.
> there are scripts that more or less reliably determine the license of a
> given file. But the "more or less" part results in some unease and so a
> formalism was introduced.

License and copyright are two different things, and different groups
interact with them.  The SPDX effort on the kernel was started to
resolve the license questions that people had.  If you wish to also
address any potential copyright issue, wonderful, please work with the
legal groups involved to get them to agree that using the SPDX tag is an
ok thing to do.  But until that happens, let's leave that alone and just
stick with the text lines for now.

thanks,

greg k-h
