Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98248606625
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 18:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbiJTQrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 12:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiJTQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 12:47:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A011DB273;
        Thu, 20 Oct 2022 09:47:18 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1140268C4E; Thu, 20 Oct 2022 18:47:13 +0200 (CEST)
Date:   Thu, 20 Oct 2022 18:47:12 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai3@huawei.com>
Cc:     axboe@kernel.dk, hch@lst.de, willy@infradead.org, kch@nvidia.com,
        martin.petersen@oracle.com, johannes.thumshirn@wdc.com,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, yukuai1@huaweicloud.com,
        yi.zhang@huawei.com
Subject: Re: [PATCH -nect RFC v2 0/2] block: fix uaf in
 bd_link_disk_holder()
Message-ID: <20221020164712.GA14773@lst.de>
References: <20221020132049.3947415-1-yukuai3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020132049.3947415-1-yukuai3@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As mentioned before I don't think we should make this even more
crufty in the block layer.  See the series I just sent to move it int
dm.  
