Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C947C652E05
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:35:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbiLUIe6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiLUIey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:34:54 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4028A1F607;
        Wed, 21 Dec 2022 00:34:54 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 99C1067373; Wed, 21 Dec 2022 09:34:50 +0100 (CET)
Date:   Wed, 21 Dec 2022 09:34:50 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@meta.com, sagi@grimberg.me,
        kbusch@kernel.org, linux-nvme@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] docs, nvme: add a feature and quirk policy document
Message-ID: <20221221083450.GA23903@lst.de>
References: <20221215125130.261098-1-hch@lst.de> <87zgboddb7.fsf@meer.lwn.net> <20221215132622.GA21083@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221215132622.GA21083@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 15, 2022 at 02:26:22PM +0100, Christoph Hellwig wrote:
> On Thu, Dec 15, 2022 at 06:08:44AM -0700, Jonathan Corbet wrote:
> > The document looks fine, but I do wonder if it wouldn't be better placed
> > with the other maintainer entries in Documentation/maintainer?
> 
> Hmm, nothing in there looks very similar to me, while process
> seems to have real policy documents.  But we can live with either
> place.

Any strong arguments for moving it Documentation/maintainer?

I'd like to merge this with the fixups from Randy through the nvme
tree ASAP, and need to decide on the location.
