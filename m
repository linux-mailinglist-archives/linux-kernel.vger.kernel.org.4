Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E663966172E
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 18:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjAHRF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 12:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjAHRFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 12:05:25 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C93E10
        for <linux-kernel@vger.kernel.org>; Sun,  8 Jan 2023 09:05:24 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A532E68AA6; Sun,  8 Jan 2023 18:05:20 +0100 (CET)
Date:   Sun, 8 Jan 2023 18:05:20 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
Message-ID: <20230108170520.GA19739@lst.de>
References: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0cccd40d7801..64cc6947099e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
>  F:	drivers/nvme/host/
>  F:	drivers/nvme/common/
>  F:	include/linux/nvme*
> +X:	include/linux/nvmem*

I think the proper thing to do would to just match the right files
from the start:

F:	include/linux/nvme.h
F:	include/linux/nvme-*.h

is it ok if I commit it with your original attributation with that
change?
