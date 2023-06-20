Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B4C7362A4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 06:24:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjFTEYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 00:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjFTEYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 00:24:04 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78FB10C8;
        Mon, 19 Jun 2023 21:24:03 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 681CF68AA6; Tue, 20 Jun 2023 06:23:59 +0200 (CEST)
Date:   Tue, 20 Jun 2023 06:23:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, jack@suse.cz, jinpu.wang@ionos.com,
        dchinner@redhat.com, hare@suse.de, trix@redhat.com,
        bvanassche@acm.org, yukuai3@huawei.com, willy@infradead.org,
        yi.zhang@huawei.com, dsterba@suse.com, brauner@kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        yangerkun@huawei.com
Subject: Re: [PATCH -next] reiserfs: fix blkdev_put() warning from
 release_journal_dev()
Message-ID: <20230620042359.GA10255@lst.de>
References: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620111322.1014775-1-yukuai1@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
