Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E615C654E71
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235993AbiLWJeB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:34:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235669AbiLWJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:33:59 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0270379C6;
        Fri, 23 Dec 2022 01:33:55 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0BB5F68AA6; Fri, 23 Dec 2022 10:33:52 +0100 (CET)
Date:   Fri, 23 Dec 2022 10:33:51 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221223093351.GA8028@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de> <20221221083450.GA23903@lst.de> <87mt7g27lv.fsf@meer.lwn.net> <20221222160920.GA10193@lst.de> <87zgbfma5w.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgbfma5w.fsf@meer.lwn.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 22, 2022 at 01:54:35PM -0700, Jonathan Corbet wrote:
> I'm not really a fan of adding more top-level directories; one of these
> years I'd like to try to move things in the opposite direction.  That is
> a battle for another day, though; for now let's just go with this and
> get the document merged.

I though about that, but could not thing of a good subdirectory.

> 
> That said, I suspect you'll add a build warning about the new document
> not being included in any toctree.  Fixing that would involve adding a
> basic index.rst to the new directory and adding that to a file like
> Documentation/subsystem-apis.rst.

The new document is included in
Documentation/maintainer/maintainer-entry-profile.rst in this path.

I also did check for new warnings and did not see any, even if that's
a little difficult with the rather chatty shpinx output.
