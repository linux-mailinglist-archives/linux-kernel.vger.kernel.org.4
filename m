Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A676E15CC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 22:24:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbjDMUYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 16:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjDMUYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 16:24:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811C7EE8;
        Thu, 13 Apr 2023 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=U4jrUd8hQ5eRUURGISwKURlHJnN7Gzh84foZjhx9Z1c=; b=Ek8k+z9vzmg4qaacOISeO99H0B
        2slRpPLR5SjsRY5Ompuql6YtOYw/wsiAKbun6hRtCMLmE3APJimwy2a7qB/2a2TmBVlpWj2SyJVTk
        e7NdpnJnR9z7NObjzSG6fAjWZXFtcmCaYO+kNnemMIAdKhdD35CYnhC0bxVr9itVJMUEBq1ejCMj8
        rC7gI0o04XvTryC5PrGxQbZ6DpDYEZg9z+DEc3/+WHTsbpFLgnr81ZBa0pMoGrcRfkzWtfu1Lug8Y
        ns+lhMG/MCeWSWsDrgn/RPdhmAEme2nmsErlRCIjEvM+125xnc0hUmpkflA3lgCSnZr+oUAErBOfa
        4xUpYc1A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pn3UN-0075fe-1P;
        Thu, 13 Apr 2023 20:24:15 +0000
Date:   Thu, 13 Apr 2023 13:24:15 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Nick Alcock <nick.alcock@oracle.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH 10/17] tty: remove MODULE_LICENSE in non-modules
Message-ID: <ZDhk79Ep0IrXxtL6@bombadil.infradead.org>
References: <ZAoGLhRpTr5f7AD/@kroah.com>
 <ZApf0iNOsSAUbhMz@bombadil.infradead.org>
 <ZArc0ib697JIwKou@kroah.com>
 <ZAuGE2ay3q0MT4Yi@bombadil.infradead.org>
 <CAMuHMdVZODAr77KSp3Yicoyjz=y8OqQB+z6zTLbxO1HMKoJMSA@mail.gmail.com>
 <ZB1p5zRp7rlGGuCP@kroah.com>
 <CAMuHMdVRXQupFEoU0EbSkBnS21QXGJQ4ZOYVy-Ntwjnw7er0nA@mail.gmail.com>
 <87h6uamdzw.fsf@esperi.org.uk>
 <ZB2zrHSzmi8FXABI@kroah.com>
 <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZB3mw4G8GdGwSP41@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 24, 2023 at 11:06:59AM -0700, Luis Chamberlain wrote:
> On Fri, Mar 24, 2023 at 03:29:00PM +0100, Greg Kroah-Hartman wrote:
> > On Fri, Mar 24, 2023 at 02:16:03PM +0000, Nick Alcock wrote:
> > > On 24 Mar 2023, Geert Uytterhoeven uttered the following:
> > > > I (still) agree with that, and I saw similar comments from others as well.
> > > > Unfortunately these comments are spread across tens of threads :-(
> > > 
> > > Ugh. Should I do this sort of thing in one big commit next time? That
> > > would fix that problem, but at the cost of others. Lumping seems to me
> > > to be troublesome because it makes it harder to accept/reject different
> > > bits, but would it be *as* troublesome as this much splitting?
> > 
> > The problem is, some of us disagree that this should be done at all, so
> > reverting all of the individual parts is going to be hard now.
> > 
> > Please put back the license bits that you removed, as it is not a good
> > idea to remove that if the file does not have a SPDX entry at the very
> > least.
> 
> Nick, I've just dropped your series. Please only re-submit only for
> files where the license is clear. The effort of clarifying licenses
> on files where one doesn't have an SPDX tag is welcomed but can take
> time and we'll need this anyway in the future to help later strive to
> see if we can automatically generate the MODULE_LICENSE() from the
> SPDX tags.

I had not seen any effort to get a new series going for this so given
I realize this is a royal pain in the ass to, and Nick has *already*
done enough, I've done the sanity checks myself and dropped the patches
from Nick which lacked SPDX annotations.

One can verify if a patch you are modifying lacks SPDX annotations in
a commit series with:

./scripts/spdxcheck.py -f $(git diff --name-only commid-id | xargs echo)

And so I've dropped all the patches that did that from Nick's series
and pushed to modules-next only the ones that did have an SPDX
annotation.

There were only 11 files which *did not* have SPDX annoations, these can
be worked on with the community later to get SPDX annotations added:

drivers/bus/arm-cci.c
drivers/bus/imx-weim.c
drivers/gpu/drm/drm_mipi_dsi.c
drivers/irqchip/irq-mvebu-pic.c
drivers/reset/reset-axs10x.c
drivers/reset/reset-hsdk.c
drivers/video/fbdev/asiliantfb.c
drivers/video/fbdev/gbefb.c
drivers/video/fbdev/imsttfb.c
drivers/xen/xenbus/xenbus_probe.c
lib/glob.c

  Luis
