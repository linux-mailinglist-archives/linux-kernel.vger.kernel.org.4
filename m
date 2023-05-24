Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF7670EDA0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 08:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239642AbjEXGIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 02:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235788AbjEXGIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 02:08:49 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18447132;
        Tue, 23 May 2023 23:08:49 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CF6E68CFE; Wed, 24 May 2023 08:08:45 +0200 (CEST)
Date:   Wed, 24 May 2023 08:08:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Mike Snitzer <snitzer@kernel.org>,
        Joern Engel <joern@lazybastard.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Pavel Machek <pavel@ucw.cz>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 15/24] block: move the code to do early boot lookup of
 block devices to block/
Message-ID: <20230524060844.GC19611@lst.de>
References: <20230523074535.249802-1-hch@lst.de> <20230523074535.249802-16-hch@lst.de> <b384f464-92c6-6a14-4072-1faa9fa6a6a8@infradead.org> <e96e4e85-7371-2859-b9a5-0f2c1f3b97d9@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e96e4e85-7371-2859-b9a5-0f2c1f3b97d9@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 09:59:50PM -0700, Randy Dunlap wrote:
> >>  	root=		[KNL] Root filesystem
> >> -			See early_lookup_bdev comment in init/do_mounts.c.
> >> +			See early_lookup_bdev comment in block/early-lookup.c
> > 
> > Patch 13 does this:
> > 
> >  	root=		[KNL] Root filesystem
> > -			See name_to_dev_t comment in init/do_mounts.c.
> > +			See early_lookup_bdev comment in init/do_mounts.c.
> > 
> > Should this latter chunk be dropped?
> > 
> 
> Oh, oops, reverse order of patches?

Patch 13 renames the function, this patch moves it.  So I think this
correct, but feel free to double check my foggy brain :)

