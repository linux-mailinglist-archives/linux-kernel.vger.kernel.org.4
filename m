Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D78740074
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 18:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbjF0QK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 12:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjF0QKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 12:10:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940A62D5E
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 09:10:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 26E3661089
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 16:10:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4024C433C0;
        Tue, 27 Jun 2023 16:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687882249;
        bh=2aOnkNNVe6yhqp19uUA0sWVcSn4XTIaNZ6lJ4idUO/I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ni4544vdzZ9f+x8R3vSLZBcmkDQhC8cvvIPCUPilWV2BPAKNdrMEzIQKM1hQFZtJ8
         Upkpdc6tVA3WJDyh2hg1hvWFtr+94TxKb33s6lHxCZNoGIO3SXeddpkgFHUCdHzBk+
         PJhK/tw/eLWeiIWAqTWMfO0ikVuzk8JN5ARd0vFKpvmdp116CNjA/6CRiiALDxYeVF
         4SUzObr6CK5oJ/aUJFa00lExqjOrqJNPsxfnv5AT1rw6XUusRA70tLmvWeKfpvSF3B
         anObYKVsdfZbv8/CMHvbIVjm8iHVDrDlFXdCL5BekgN0LNHuick2x60k+Gz7r0is3t
         1jKV4oQHSuQEQ==
Date:   Tue, 27 Jun 2023 10:10:46 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        "Clemens S." <cspringsguth@gmail.com>,
        Martin Belanger <martin.belanger@dell.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        John Meneghini <jmeneghi@redhat.com>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux NVMe <linux-nvme@lists.infradead.org>,
        Pankaj Raghav <p.raghav@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: Fwd: Need NVME QUIRK BOGUS for SAMSUNG MZ1WV480HCGL-000MV
 (Samsung SM-953 Datacenter SSD)
Message-ID: <ZJsKBkPqoWzYyngS@kbusch-mbp.dhcp.thefacebook.com>
References: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d18d2a08-9d24-0209-c2cf-baf60bbf5048@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2023 at 08:15:49AM +0700, Bagas Sanjaya wrote:
> See Bugzilla for the full thread.
> 
> The reporter had a quirk (see above) that fixed this regression,
> nevertheless I'm adding it to regzbot to make sure it doesn't fall
> through cracks unnoticed:
> 
> #regzbot introduced: 86c2457a8e8112f https://bugzilla.kernel.org/show_bug.cgi?id=217593
> #regzbot title: NVME_QUIRK_BOGUS_NID is needed for SAMSUNG MZ1WV480HCGL-000MV

These bug reports really should go to the vendors that created the
broken device with non-unique "unique" fields. It's easy enough for me
to write the quirk patch, but it's not the ideal solution and may harm
devices/firmwares with the same VID:DID that don't have this problem.
Not being the vendor, I'm not in a postition to know that, so CC'ing
some Samsung folks.
