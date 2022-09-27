Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9544B5EBB22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 09:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbiI0HIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 03:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbiI0HIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 03:08:31 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0893295E74
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 00:08:29 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4D41868AFE; Tue, 27 Sep 2022 09:08:23 +0200 (CEST)
Date:   Tue, 27 Sep 2022 09:08:22 +0200
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
Message-ID: <20220927070822.GA15262@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com> <20220922053137.GA27191@lst.de> <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com> <20220922055231.GA27560@lst.de> <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com> <20220922142626.GB28397@lst.de> <97217d166814421d9de587e84c328580@ExMBX2.phison.com> <20220923061130.GA15835@lst.de> <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b685d5ccb6e492b938c1c10ce378430@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 06:16:01AM +0000, Rita Lin wrote:
> Dear Christoph,
> 
> The signed off information was put in line 10 in previous patch.
> I was not able to attach an image to identify the location to you.

I have not been able to find a Signed-off-by: line.  Please provide one
in reply to this mail.
