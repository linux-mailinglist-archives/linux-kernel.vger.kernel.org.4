Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7617274ED90
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 14:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjGKMGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 08:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjGKMGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 08:06:15 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73FCE4B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:06:14 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1466867373; Tue, 11 Jul 2023 14:06:10 +0200 (CEST)
Date:   Tue, 11 Jul 2023 14:06:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Pankaj Raghav <p.raghav@samsung.com>,
        Keith Busch <kbusch@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>,
        =?utf-8?B?67CV7KeE7ZmY?= <jh.i.park@samsung.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <20230711120609.GB27050@lst.de>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com> <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com> <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info> <CGME20230710155902eucas1p2b464a29adc35e983c73b00d18ab5344c@eucas1p2.samsung.com> <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com> <f0fdf86e-4293-8e07-835d-b5a866252068@samsung.com> <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <462e0e1e-98ea-0f3c-4aaa-8d44f0a8e664@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 11:39:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> Well, that "They keep pumping out more and more devices with the same
> breakage" and the "new device" comment from Pankaj below bear the
> question: should we stop trying to play "whack a mole" with all those
> quirk entries and handle devices with duplicate ids just like Windows does?

As far as I can tell Windows completely ignores the IDs.  Which, looking
back, I'd love to be able to do as well, but they are already used
by udev for the /dev/disk/by-id/ links.   Those are usually not used
on desktop systems, as they use the file system labels and UUIDs, but
that doesn't work for non-file system uses.

And all this has been working really well with the good old enterprise
SSDs, it's just that the cheap consumer devices keep fucking it up.

If we'd take it away now we'd break existing users, which puts us between
a rock and a hard place.

