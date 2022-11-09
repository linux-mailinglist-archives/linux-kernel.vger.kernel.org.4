Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BAB6223EE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 07:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiKIGU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 01:20:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiKIGUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 01:20:50 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D8193CC;
        Tue,  8 Nov 2022 22:20:47 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1613B68AFE; Wed,  9 Nov 2022 07:20:43 +0100 (CET)
Date:   Wed, 9 Nov 2022 07:20:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Gerd Bayer <gbayer@linux.ibm.com>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        linux-nvme@lists.infradead.org
Subject: Re: nvme-pci: NULL pointer dereference in nvme_dev_disable() on
 linux-next
Message-ID: <20221109062042.GB10528@lst.de>
References: <fad4d2d5e24eabe1a4fcab75c5d080a6229dc88b.camel@linux.ibm.com> <20221108074846.GA22674@lst.de> <Y2qQk/LuiNNdmdRD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qQk/LuiNNdmdRD@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 10:23:31AM -0700, Keith Busch wrote:
> This looks good to go. I vote apply for 6.1, and we should consider
> merging your larger refactor for 6.2 after more test/review.

The problem doesn't exist yet in 6.1, it is caused by the recent
quiesce rework.
