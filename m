Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78A4D66C65D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbjAPQT3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:19:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjAPQSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:18:04 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395C2F7A6;
        Mon, 16 Jan 2023 08:10:06 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0E1EF68D15; Mon, 16 Jan 2023 17:10:00 +0100 (CET)
Date:   Mon, 16 Jan 2023 17:09:58 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, dwagner@suse.de,
        hare@suse.de, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, john.garry@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
Message-ID: <20230116160958.GB23434@lst.de>
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com> <20230111130159.3741753-8-shikemeng@huaweicloud.com> <20230111054520.GA17158@lst.de> <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com> <e2ba1495-e9a8-8dfc-4eee-d9a2984bc0d2@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e2ba1495-e9a8-8dfc-4eee-d9a2984bc0d2@huaweicloud.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 09:07:00AM +0800, Kemeng Shi wrote:
> >> Why?  I think always having the trace even for the commit case seems
> >> very useful for making the traces useful.
> > I think unplug event more likely means that request going to be sent to driver
> > was plugged and in plug list. And the current code do only trace unplug event
> > when dispatching requests from plug list. If so, would it be better to add
> > a new event to trace commit?
> Hi Christoph, which way do you prefer now? Keep unplug event consistent to
> trace commit of requests from plug list only or trace all commits with
> unplug event. Please let me know and I will consider it in next version.
> Thanks.

To me always having the trace feels more useful, but let's see if Jens
has an opinion on it.
