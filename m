Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB5268C24F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjBFPyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:54:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231501AbjBFPx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:53:57 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 828A22DE6D;
        Mon,  6 Feb 2023 07:53:40 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id E1FAE68C7B; Mon,  6 Feb 2023 16:53:37 +0100 (CET)
Date:   Mon, 6 Feb 2023 16:53:37 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     hch@lst.de, axboe@kernel.dk, dwagner@suse.de, hare@suse.de,
        ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v4 09/14] blk-mq: use blk_mq_commit_rqs helper in
 blk_mq_try_issue_list_directly
Message-ID: <20230206155337.GF13392@lst.de>
References: <20230118093726.3939160-1-shikemeng@huaweicloud.com> <20230118093726.3939160-9-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118093726.3939160-9-shikemeng@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
