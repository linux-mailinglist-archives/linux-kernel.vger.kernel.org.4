Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD8274209F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 08:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbjF2GqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 02:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjF2GpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 02:45:14 -0400
Received: from out-55.mta0.migadu.com (out-55.mta0.migadu.com [91.218.175.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BE42D63
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 23:44:49 -0700 (PDT)
Message-ID: <585417dc-674d-5efc-c1dd-417ba9092228@linux.dev>
Date:   Thu, 29 Jun 2023 14:44:33 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/3] blk-mq: ktime_get_ns() only once for batched
 requests init
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, tj@kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com,
        ming.lei@redhat.com
References: <20230628124546.1056698-1-chengming.zhou@linux.dev>
 <20230628124546.1056698-3-chengming.zhou@linux.dev>
 <20230629053001.GE16819@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230629053001.GE16819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/6/29 13:30, Christoph Hellwig wrote:
> Can we just stash the start time into blk_mq_alloc_data instead of
> passing down yet another parameter?
> 

Yes, it's much better.

Thanks.

