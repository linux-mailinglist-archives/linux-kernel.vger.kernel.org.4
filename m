Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0449E6CA2B1
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbjC0LoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbjC0LoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:44:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA02270E;
        Mon, 27 Mar 2023 04:44:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8A54B80B7E;
        Mon, 27 Mar 2023 11:44:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5985C433D2;
        Mon, 27 Mar 2023 11:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679917445;
        bh=39dMlcm9dz8DHNPorL7lH7wJe0iuw2BjZ6ty9Z48GHs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T9C2RVcQrn1x/Y1E4n4IcP/nwoRpfeMXmrftTche9bo5eSdefMUJypOw/ZI5srZiO
         kfGlv+vns8AyOG0vJBQO71KL0WHdKh6HZNZaTmYMLsdgAipBj5WhmKVEPuQr32AW38
         I63Cf09Qa/ZxWO8jCmVO1G53QVEDqPo8pbek+GYk=
Date:   Mon, 27 Mar 2023 13:43:57 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZCGBfbZztfBpgIXf@kroah.com>
References: <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
 <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
 <87h6uamdzw.fsf@esperi.org.uk>
 <ZB2zrHSzmi8FXABI@kroah.com>
 <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
 <87tty6lbed.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tty6lbed.fsf@esperi.org.uk>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 27, 2023 at 11:46:34AM +0100, Nick Alcock wrote:
> On 24 Mar 2023, Luis Chamberlain spake thusly:
> 
> > On Fri, Mar 24, 2023 at 03:29:00PM +0100, Greg Kroah-Hartman wrote:
> >> Please put back the license bits that you removed, as it is not a good
> >> idea to remove that if the file does not have a SPDX entry at the very
> >> least.
> >
> > Nick, I've just dropped your series.
> 
> Thanks, that's much easier than getting all those reverts in.
> (Presumably the bits taken by other people can all stay.)
> 
> >                                      Please only re-submit only for
> > files where the license is clear. The effort of clarifying licenses
> > on files where one doesn't have an SPDX tag is welcomed but can take
> > time and we'll need this anyway in the future to help later strive to
> > see if we can automatically generate the MODULE_LICENSE() from the
> > SPDX tags.
> 
> For now, I have an alternative that might be acceptable. I did a bit of
> an audit and it's all a right mess (see below), with wild divergence
> even when SPDX is present, GPL versus -only or GPL-2.0+ apparently
> applied almost at random and some things being completely different (in
> some cases they were both committed simultaneously and were inconsistent
> from the moment the module was written). So many things are inconsistent
> that kallmodsyms would call a lot of things modules that really aren't:
> there is enough error that there probably be noticeable mistakes in
> quite a high percentage of kernels.

As you have found out, there is a difference that matters in the SPDX
lines vs the MODULE_LICENSE lines when it comes to GPL vs GPLv2+ stuff.
The SPDX lines are correct for the code itself, while the MODULE_LICENSE
lines are correct from a "this is the license of this binary" point of
view.

So don't get confused here, if you all can figure out a way to generate
the MODULE_LICENSE() lines from SPDX, that would be great, but in my
quick look I think it's going to be very difficult (think about how
multiple files make up a single module binary...)

good luck!

> But... for our purposes, we don't actually *mind* if non-modules list
> things like licenses inconsistently in two different places. Removing
> MODULE_LICENSE was a means, not an end. What we're actually interested
> in doing is removing .modinfo in things that can't possibly be modules,
> and since a .modinfo in a guaranteed-non-module is at best entirely
> useless I don't think anyone could reasonably be opposed to that end
> goal (though they might reasonably be unhappy about all the churn
> involved in getting there). They object to the removal of the visible
> MODULE_LICENSE() argument text string, not to the useless compile-time
> effect of a MODULE_LICENSE in a non-module.

there are other things that create .modinfo lines, so I'm confused why
you picked the license line to trigger all of this.

> So how about, for the first three groups below (the groups where
> MODULE_LICENSE and SPDX are inconsistent, or where a SPDX simply doesn't
> exist), instead of removing the MODULE_LICENSE we replace it with an
> identical call to a new macro named perhaps NONMODULE_LICENSE(), which
> is defined in module.h as simply expanding to nothing, except possibly
> emitting a compile-time error if it's ever used in a module? This more
> clearly denotes what's going on, keeps the license string in the source
> file on a nearly identical line (for whatever purpose it serves), drops
> the spurious .modinfo that's causing trouble, and probably makes fewer
> people unhappy?

Again, no, why aren't you just stubbing out MODULE_LICENSE() in the
build if it's not being built as a module like the other MODULE_*()
macros are?  Why is the license so special here yet the device list or
module authors not?

Don't treat this macro as somehow special where authors have to remember
to not use it (or to use it), while the other MODULE_* macros do not
have the issue?

That's my main objection here.  Don't get confused by the license stuff,
that's secondary.

thanks,

greg k-h
