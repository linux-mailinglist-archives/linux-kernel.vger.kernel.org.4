Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6DC5E73B4
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiIWGLh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 02:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIWGLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 02:11:35 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8EFAFAE3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 23:11:35 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 44B6368AFE; Fri, 23 Sep 2022 08:11:31 +0200 (CEST)
Date:   Fri, 23 Sep 2022 08:11:30 +0200
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
Message-ID: <20220923061130.GA15835@lst.de>
References: <36fd82e8780742c2881f078f98110e5e@ExMBX2.phison.com> <20220922053137.GA27191@lst.de> <53e4a6192bf746af839d8da90917a248@ExMBX2.phison.com> <20220922055231.GA27560@lst.de> <1c9807fea3424be486190a99c923a228@ExMBX2.phison.com> <20220922142626.GB28397@lst.de> <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97217d166814421d9de587e84c328580@ExMBX2.phison.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 03:18:52AM +0000, Rita Lin wrote:
> Dear Christoph,
> 
> We had included signed off by information in the patch.

I've not actually found a signoff in either version of the patch.
