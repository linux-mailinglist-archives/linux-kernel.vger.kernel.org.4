Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33ABB652DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234454AbiLUIbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:31:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiLUIbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:31:07 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8678F640B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:31:06 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7C5667373; Wed, 21 Dec 2022 09:31:02 +0100 (CET)
Date:   Wed, 21 Dec 2022 09:31:02 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     August Wikerfors <git@augustwikerfors.se>
Cc:     Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
        Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: Re: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1
 256G and 512G
Message-ID: <20221221083102.GA23826@lst.de>
References: <20221116171727.4083-1-git@augustwikerfors.se> <CGME20221116172324epcas5p3d9877249797ac741ead5785cba27e00e@epcas5p3.samsung.com> <20221116171935.GA24524@lst.de> <20221117031951.GB392@test-zns> <20221206055928.GB24451@test-zns> <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a80857cb-e3a0-74b2-a7c4-a1afb34e5082@augustwikerfors.se>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 12:30:39PM +0100, August Wikerfors wrote:
>> Took more time than I wanted. Firmware team mentioned that issue existed
>> in this firmware. This is fixed in new firmware, but bit of travel time
>> is involved when official release from OEM (Lenovo) comes out.
>>
>> Hope the information is sufficient, and quirk can go in.
>>
>> If required, Acked-by: Kanchan Joshi <joshi.k@samsung.com>
>
> Ping, anything left for me to do before this can be merged?

We don't want to add quirks for things fixed by firmware updates,
see the recently posted features and quirks policy.
