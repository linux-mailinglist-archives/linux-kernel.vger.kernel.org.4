Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF73165DF0E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 22:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240433AbjADV3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 16:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240548AbjADV3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 16:29:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11BC3CC0
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 13:27:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CBFC61844
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 21:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3D70C433D2;
        Wed,  4 Jan 2023 21:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672867653;
        bh=57CtgsMHkeFVcBeyAUuKsmZhu3NAy0h5TZ/By4Ry+rE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=isRVW1dz7l8BAG1DnM02Nfai5LchfSn1JuLkRPx87dHlTKk6r/BJYQLAQdjEfKvK9
         O5ZSVqVrOOybDFdKR6srQDXGVjlapVG0HpfWpZdXAxklGGzu+qmyIl9yd1VpCivfXV
         Lmt2AMJWdu+6MZTpH8xG8i2e0v+oIANKQi9MdtewryxJ5PNbuQVwPnezQNNqQs/WPn
         EGTcLjkN1GIlXXKMNbzfvarVUtb8tELXxkBtauyYu+ZGdRDPQwVddDfPMUoY7i0u+M
         6e2bOrN23CVuCKqe8clVrDekxbVZ3mczJctKhsTaYYelpV0kAgJSiiUr4ok1wdEudE
         bOkDXQcZDyLxw==
Received: by pali.im (Postfix)
        id C9C31A3A; Wed,  4 Jan 2023 22:27:29 +0100 (CET)
Date:   Wed, 4 Jan 2023 22:27:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 6.2-rc1
Message-ID: <20230104212729.s6mdthwqdoxzbjga@pali>
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20230104190115.ceglfefco475ev6c@pali>
 <CAHk-=wh1x-gbmE72xBPcEnchvmPn=13mU--+7Cfay0dNHCxxuw@mail.gmail.com>
 <20230104205640.o2uy2jk4v6yfm4w3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104205640.o2uy2jk4v6yfm4w3@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2023 21:56:40 Pali Rohár wrote:
> On Wednesday 04 January 2023 11:25:41 Linus Torvalds wrote:
> > On Wed, Jan 4, 2023 at 11:01 AM Pali Rohár <pali@kernel.org> wrote:
> > >
> > > Driver is still used and userspace tools for it are part of the udftools
> > > project, which is still under active maintenance. More people already
> > > informed me about this "surprise".
> > 
> > Why is that driver used?
> > 
> > It's *literally* pointless. It's just a shell that forwards ioctl's to
> > the real drivers.
> > 
> > > Any comments on this? Because until now nobody answered why this
> > > actively used driver was removed from kernel without informing anybody:
> > 
> > Well, it's been marked as deprecated for five years, so any kernel
> > config should have gotten this notice for the help entry
> > 
> >           Note: This driver is deprecated and will be removed from the
> >           kernel in the near future!
> > 
> > but I guess people didn't notice.
> > 
> > It could be re-instated, but it really is a completely useless driver.
> > Just use the *regular* device nodes, not the pointless pktcd ones.
> > 
> > Is there any real reason why udftools can't just use the normal device node?
> > 
> > The historical reason for this driver being pointless goes back *much*
> > longer than five years - it used to be that the pktcd driver was
> > special, and was the only thing that did raw commands.
> > 
> > But the regular block layer was taught to do that back around 2004, so
> > the "pktcd" driver has literally just been a pointless shell for
> > almost two decades.
> > 
> > And I know it was in 2004, because I actually did most of that "make
> > SCSI commands generic" work myself (but had to go back to the old BK
> > archives to find the exact date - it's been two decades, after all).
> > 
> > I did it because I was fed up with the crazy pktcd driver requiring
> > extra work, when I just wanted to write CD's on my regular IDE CD-ROM
> > the obvious way.
> > 
> > So if there is some reason to actually use the pktcd driver, please
> > tell us what that is.
> > 
> >               Linus
> 
> Last time I did big retest of optical media was two years ago. At that
> time kernel was not able to mount CD-RW disc in full read-write mode
> from the normal node /dev/cdrom. Via pktcdvd driver mapping it was
> possible without any issue. Was there any change in last 5 (or more)
> years in this CD-RW area? Mounting CD-RW media in read-only mode via
> normal /dev/cdrom node always worked fine. Also "burning" CD-R media
> with userspace burning tools on normal /dev/cdrom node also worked.
> But here it is CD-RW media in read-write mode with kernel udf filesystem
> driver without any userspace involved (after proper formatting).

In commit where was pktcdvd dropped is written:
https://git.kernel.org/torvalds/c/f40eb99897af665f11858dd7b56edcb62c3f3c67

  * At the lowest level, there is the standard driver for the CD/DVD device,
  * such as drivers/scsi/sr.c. This driver can handle read and write requests,
  * but it doesn't know anything about the special restrictions that apply to
  * packet writing. One restriction is that write requests must be aligned to
  * packet boundaries on the physical media, and the size of a write request
  * must be equal to the packet size. Another restriction is that a
  * GPCMD_FLUSH_CACHE command has to be issued to the drive before a read
  * command, if the previous command was a write.
  *
  * The purpose of the packet writing driver is to hide these restrictions from
  * higher layers, such as file systems, and present a block device that can be
  * randomly read and written using 2kB-sized blocks.

Were all these write restrictions implemented in sr.c driver? Do you
remember other details?

Because CD-RW support into kernel was really introduced in 2004 in
this historical commit, but it was not for SCSI sr.c driver:
https://git.kernel.org/history/history/c/2f8e2dc86c9876edca632e8ef2ab1f68d1b753f0
