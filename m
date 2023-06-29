Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D485C741FEC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 07:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjF2Faf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 01:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbjF2FaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 01:30:20 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66A030EC;
        Wed, 28 Jun 2023 22:30:04 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id F29DB67373; Thu, 29 Jun 2023 07:30:01 +0200 (CEST)
Date:   Thu, 29 Jun 2023 07:30:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     chengming.zhou@linux.dev
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com, hch@lst.de
Subject: Re: [PATCH v3 2/3] blk-mq: ktime_get_ns() only once for batched
 requests init
Message-ID: <20230629053001.GE16819@lst.de>
References: <20230628124546.1056698-1-chengming.zhou@linux.dev> <20230628124546.1056698-3-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628124546.1056698-3-chengming.zhou@linux.dev>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can we just stash the start time into blk_mq_alloc_data instead of
passing down yet another parameter?

