Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296015E5B01
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 07:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbiIVFwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 01:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiIVFwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 01:52:36 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76001B40FB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Sep 2022 22:52:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A4D268AFE; Thu, 22 Sep 2022 07:52:31 +0200 (CEST)
Date:   Thu, 22 Sep 2022 07:52:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rita Lin <ritach_lin@phison.com>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?77+9U+aZn++/vXw=?= <redd_huang@phison.com>,
        Tina Hsu <tina_hsu@phison.com>,
        Vita Hsueh =?utf-8?B?KOiWm+S8iuWAqSk=?= 
        <Vita.Hsueh@quantatw.com>, "Wang, Audrey" <audrey.wang@hp.com>
Subject: Re: nvme-pci: disable write zeros support on SSDs
Message-ID: <20220922055231.GA27560@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com> <20220922053137.GA27191@lst.de> <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:50:52AM +0000, Rita Lin wrote:
> Dear Christoph,
> 
> Thank you for your reply.
> These SSDs do support write 0 command and the function was tested without issue.
> But since these SSDs are DRAMless products, the write 0 command will take a lot longer to complete which had impacted the product performance.
> Due to the FW had been frozen, we would like to check if we could apply CL for these 2 products.

please add a comment explaining this to the IDs entry.
