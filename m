Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D2162C635
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 18:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234583AbiKPRTw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 12:19:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbiKPRTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 12:19:41 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14431112E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 09:19:39 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF76268AA6; Wed, 16 Nov 2022 18:19:35 +0100 (CET)
Date:   Wed, 16 Nov 2022 18:19:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221116171935.GA24524@lst.de>
References: <20221116171727.4083-1-git@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116171727.4083-1-git@augustwikerfors.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 06:17:27PM +0100, August Wikerfors wrote:
> The Samsung PM9B1 512G SSD found in some Lenovo Yoga 7 14ARB7 laptop units
> reports eui as 0001000200030004 when resuming from s2idle, causing the
> device to be removed with this error in dmesg:
> 
> nvme nvme0: identifiers changed for nsid 1

What EUI did it report before? Is the identifier stable after
multiple resume cycles?

Can some of the Samsung folks here reach out to the relevant firmware
team to see if they have any clues?
