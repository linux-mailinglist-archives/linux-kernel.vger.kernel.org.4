Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003C66DF432
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDLLuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjDLLuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:50:03 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B22230FF
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 04:49:59 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id A191668AA6; Wed, 12 Apr 2023 13:49:55 +0200 (CEST)
Date:   Wed, 12 Apr 2023 13:49:55 +0200
From:   "hch@lst.de" <hch@lst.de>
To:     Jinyoung CHOI <j-young.choi@samsung.com>
Cc:     "hch@lst.de" <hch@lst.de>, "kbusch@kernel.org" <kbusch@kernel.org>,
        "axboe@fb.com" <axboe@fb.com>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
Subject: Re: (2) [PATCH 2/2] nvme-pci: fix metadata mapping length
Message-ID: <20230412114955.GA9786@lst.de>
References: <20230412065736.GB20550@lst.de> <20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p8> <CGME20230412052443epcms2p836b669a12c4e81368bec2cd340656f73@epcms2p1> <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412071230epcms2p145d53bfc8e40eede25f282b80247218c@epcms2p1>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 04:12:30PM +0900, Jinyoung CHOI wrote:
> I agree with you.
> I think the problem is bio_integrity_add_page().
> If it is modified, sg functions for blk-integrity should also 
> be modified.
> 
> If you think the blk-integrity modification is better, 
> I will send an mail to block mailing after modifying it.

Please wait for feedback from Martin.
