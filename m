Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B4D74DAA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjGJP7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjGJP66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 11:58:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B628CA
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 08:58:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00F596108F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 15:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B242C433C7;
        Mon, 10 Jul 2023 15:58:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689004736;
        bh=QUm9t1ezC/IIBjn6xwi8cf0YyRAsFcWX+N8CXwamai4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qErJf3rV0VSpOBIFaXedO/qXItU5H8PQsiFAaXjpq+rI9yjOk+4dSlOoV8gjGnOuL
         gVsk5LZxUzKimVySyZNlOkD4C28uhf8aVy7JT0F411kCaAYrln0AwBgiQ2w/uIxbBV
         ETAnqmD71bPt3/uC360q33UqtfVDEyF6ztR+0CmoLqEiUq7VMmqMqc7cun8p3TAZkI
         YCcmfB6g+dLatvmJjjxYJiihz124cK2wbhkFTw5MT6cspS4oBZicsA/GkfMgb+cRoW
         IN4n2n8m34M+Wh86LUDLbcKVmoTH0XrL+Pu07/zB20qtJAPB40RHgZnsUU8fEzZfJS
         tX5RdTFMze6DQ==
Date:   Mon, 10 Jul 2023 09:58:53 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <ZKwqvTMPVmhnkZjS@kbusch-mbp.dhcp.thefacebook.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
 <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
 <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f333133-2cc4-406a-d6c2-642ac6ccabca@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 10:52:52AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 27.06.23 18:10, Keith Busch wrote:
> > On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> >> See Bugzilla for the full thread.
> >>
> >> The reporter had a quirk (see above) that fixed this regression,
> >> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> >> through cracks unnoticed:
> >>
> >> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
> >> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV
> > 
> > These bug reports really should go to the vendors that created the
> > broken device with non-unique "unique" fields.
> 
> I understand that, but I think we need middlemen for that, as I or Bagas
> don't have the contacts -- and it's IMHO also a bit much too ask us for
> in general, as regression tracking is hard enough already. At least
> unless this becomes something that happen regularly, then a list of
> persons we could contact would be fine I guess. But we simply can't deal
> with too many subsystem specific special cases.

I'm not asking the Linux regression trackers to fill that role, though.
I'm asking people who experience these issues report it to their vendor
directly because these device makers apparently have zero clue that
their spec non-compliance is causing painful experiences for their
customers and annoyance for maintainers. They keep pumping out more and
more devices with the same breakage.

This particular vendor has been great at engaging with Linux, but that's
not necessarily normal among all device makers, and I don't have
contacts with the majority of the vendors we've had to quirk for this
issue.

We did complain to the NVMe spec workgroup that their complaince cert
suite is not testing for this. There was a little initial interest in
fixing that gap, but it fizzled out...

> Another request came in today, even with a pseudo-patch:
> https://bugzilla.kernel.org/show_bug.cgi?id=217649
> 
> To quote:
> ```
> As with numerous NVMe controllers these days, Samsung's
> MZAL41T0HBLB-00BL2, which Lenovo builds into their 16ARP8 also suffers
> from invalid IDs, breaking suspend and hibernate also on the latest
> kernel 6.4.2.
> 
> The following change restores this functionality:
> 
> File: root/drivers/nvme/host/pci.c
> Change:
> 
> -	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
> -		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
> 
> +	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G, 512G and 1TB */
> +		.driver_data = NVME_QUIRK_BOGUS_NID |
> +				NVME_QUIRK_DISABLE_WRITE_ZEROES, },

Panjaj, okay with this one too?
