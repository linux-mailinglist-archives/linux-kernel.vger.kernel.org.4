Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D5374ED55
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 13:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjGKLwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 07:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjGKLwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 07:52:20 -0400
Received: from out-33.mta1.migadu.com (out-33.mta1.migadu.com [IPv6:2001:41d0:203:375::21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B79711D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 04:52:19 -0700 (PDT)
Message-ID: <6825f687-9573-51eb-bb89-17eadb60f71b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689076337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xAlCKMbHrJaFchyjxLhK4XN3M9/LmqiAnoNyHkr0+GY=;
        b=EcPgXd6jVyp0eZFnTWRCJaE4qOA3TO+dNOwpZqCFhTdoSIb4pG5wgivWJtQkYygUMOTwFj
        UBPjPNqkcRVdiX0cyG9sPd4O6jbu7h0AjRCxENcQWrFEqG8SxTGInP4MYhbI1vQwyKV2gq
        R8kVaCHJqWKVuy5SryRBTn0jYz1ImKk=
Date:   Tue, 11 Jul 2023 19:52:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] blk-flush: fix rq->flush.seq for post-flush requests
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhouchengming@bytedance.com
References: <20230710064705.1847287-1-chengming.zhou@linux.dev>
 <20230710133024.GA23157@lst.de>
 <4431d779-e6e7-aff1-5cf8-4147de974d8d@linux.dev>
 <20230711113126.GA26978@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230711113126.GA26978@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/11 19:31, Christoph Hellwig wrote:
> On Tue, Jul 11, 2023 at 07:06:20PM +0800, Chengming Zhou wrote:
>> Ok, will add a Fixes tag and send it as a separate patch since it's a bug fix.
> 
> Btw, it's probably not worth resending patch 2 until we've figured out
> and dealt with the SATA flush regression that Chuck reported.

Ok, I will not resend patch 2. As for the patch 1, should I resend it as a separate patch
or just put it in that series [1] before other flush optimizations ?

I search on the block mail list, find the issue [2] you mentioned, will look into it too.

[1] https://lore.kernel.org/lkml/20230707093722.1338589-1-chengming.zhou@linux.dev/
[2] https://lore.kernel.org/linux-block/7A57C7AE-A51A-4254-888B-FE15CA21F9E9@oracle.com/
