Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD816639D0
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjAJHTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjAJHTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:19:47 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64A2BED
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:19:46 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 299E868AFE; Tue, 10 Jan 2023 08:19:43 +0100 (CET)
Date:   Tue, 10 Jan 2023 08:19:42 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <20230110071942.GA10929@lst.de>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk> <20230108170520.GA19739@lst.de> <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xNNUpfQ6GiQ5+a@shell.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2023 at 05:21:57PM +0000, Russell King (Oracle) wrote:
> > I think the proper thing to do would to just match the right files
> > from the start:
> > 
> > F:	include/linux/nvme.h
> > F:	include/linux/nvme-*.h
> > 
> > is it ok if I commit it with your original attributation with that
> > change?
> 
> LGTM, thanks!

Thanks, I've added the updated version to the nvme-6.2 branch.
