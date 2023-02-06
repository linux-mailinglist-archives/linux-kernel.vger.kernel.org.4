Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DD468C277
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 17:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBFQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 11:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjBFQGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 11:06:16 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5EF1CF70;
        Mon,  6 Feb 2023 08:06:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 09FF768C7B; Mon,  6 Feb 2023 17:06:07 +0100 (CET)
Date:   Mon, 6 Feb 2023 17:06:07 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     ming.lei@redhat.com, Christoph Hellwig <hch@lst.de>,
        axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 12/14] blk-mq: remove set of bd->last when get
 driver tag for next request fails
Message-ID: <20230206160607.GA15025@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-12-shikemeng@huaweicloud.com> <20230118174208.GH12399@lst.de> <1f116b9b-8194-54c8-eedb-7f2c9cd493c6@huaweicloud.com> <0526b518-0894-10f6-e428-c03644d39c02@huaweicloud.com> <119aeade-151b-e375-f89b-20956bd9f3fb@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <119aeade-151b-e375-f89b-20956bd9f3fb@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 09:05:25AM +0800, Kemeng Shi wrote:
> Could anyone please help review the last two patches without reviewed-by.

I'm still not really convinved of this one patch.

The rest of the series looks like great small cleanups, but this one
isn't quite as trivial.   Maybe you can split it from the series and
resend it with a more detailed and better explanation for the next
merge window?
