Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFCD4600696
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 08:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiJQGKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 02:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiJQGJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 02:09:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233212A961;
        Sun, 16 Oct 2022 23:09:54 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 665D168BFE; Mon, 17 Oct 2022 08:09:51 +0200 (CEST)
Date:   Mon, 17 Oct 2022 08:09:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christoph =?iso-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Joel Colledge <joel.colledge@linbit.com>
Subject: Re: [PATCH] drbd: only clone bio if we have a backing device
Message-ID: <20221017060951.GA28409@lst.de>
References: <20221013135352.933875-1-christoph.boehmwalder@linbit.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013135352.933875-1-christoph.boehmwalder@linbit.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 03:53:52PM +0200, Christoph Böhmwalder wrote:
> +	if (get_ldev(device)) {
> +		req->private_bio = bio_alloc_clone(device->ldev->backing_bdev,
> +						   bio, GFP_NOIO, &drbd_io_bio_set);

This adds an overly long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
