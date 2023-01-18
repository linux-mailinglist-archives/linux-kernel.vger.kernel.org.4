Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8345A672514
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjARRgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:36:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjARRg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:36:26 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50AA3C284;
        Wed, 18 Jan 2023 09:36:25 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F07AA67373; Wed, 18 Jan 2023 18:36:21 +0100 (CET)
Date:   Wed, 18 Jan 2023 18:36:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 06/14] blk-mq: remove unncessary from_schedule
 parameter in blk_mq_plug_issue_direct
Message-ID: <20230118173621.GB12399@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-6-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-6-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 05:37:18PM +0800, Kemeng Shi wrote:
> Function blk_mq_plug_issue_direct tries to issue batch requests in plug
> list to driver directly. We will only issue plug request to driver if we
> are not from scheduler, so from_scheduler parameter of
> blk_mq_plug_issue_direct is always false.
> Remove unncessary from_scheduler of blk_mq_plug_issue_direct.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
