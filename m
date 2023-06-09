Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D44728F01
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 06:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbjFIEjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 00:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjFIEj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 00:39:28 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92B0630EE
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 21:39:26 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 759C968C4E; Fri,  9 Jun 2023 06:39:22 +0200 (CEST)
Date:   Fri, 9 Jun 2023 06:39:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] block: fix rootwait=
Message-ID: <20230609043922.GA30632@lst.de>
References: <20230607135746.92995-1-hch@lst.de> <aab7ae20-d36a-47cf-bc1a-9590c3d8b3b7@sirena.org.uk> <CAOMZO5DhO7G70FZXZzwoX_Xm=VHtb8E=8G8moz+CjEdnUc2Eeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5DhO7G70FZXZzwoX_Xm=VHtb8E=8G8moz+CjEdnUc2Eeg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 08, 2023 at 10:02:00PM -0300, Fabio Estevam wrote:
> > below) lands on this commit and reverting the first hunk:
> >
> > > @@ -181,7 +181,7 @@ static int __init devt_from_devname(const char *name, dev_t *devt)
> > >         *p = '\0';
> > >         *devt = blk_lookup_devt(s, part);
> > >         if (*devt)
> > > -               return 0;
> > > +               return -ENODEV;
> 
> I have tested reverting this first hunk and it also works for me, so
> if someone submits this fix:

Yes, the first hunk is completely bogus, sorry.

I'll send the fix.
