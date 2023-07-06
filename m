Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61328749F0A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 16:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233148AbjGFObj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 10:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbjGFObh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 10:31:37 -0400
Received: from out-62.mta0.migadu.com (out-62.mta0.migadu.com [IPv6:2001:41d0:1004:224b::3e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B471725
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 07:31:36 -0700 (PDT)
Message-ID: <9b2a1bdc-0180-2e57-2b79-ab5e9ec0cbe5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1688653894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SfS6m33Hx0eD9SR2qYGdsQRQD1bENaHeTDnxa6gjCVE=;
        b=Mq+QTEozyd2VPyquASqf7zasbFPR2J0OuoILLlEpJQlmyqF+iYsDZwPd5Nqpy1gesYCwc/
        9pur+khaLQhqgFqtzmSuxr2UHsI6UVp3oxce0Em7dg5z7HF0Siiz2mg9ClHfQeKixKatyb
        3fEf+BirCwRfZJnMDG2AbEpKVbO0o2Q=
Date:   Thu, 6 Jul 2023 22:31:09 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 4/4] blk-mq: delete unused completion_data in struct
 request
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, tj@kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
References: <20230629110359.1111832-1-chengming.zhou@linux.dev>
 <20230629110359.1111832-5-chengming.zhou@linux.dev>
 <20230706130858.GD13089@lst.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Chengming Zhou <chengming.zhou@linux.dev>
In-Reply-To: <20230706130858.GD13089@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/6 21:08, Christoph Hellwig wrote:
> Looks good:
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> 
> Although I'd order it first or even send it separately as it doesn't need
> any of the other changes.

Ok, will order it first in the next version.

I thought it's too minor to send a separate patch, so put it in this series.

Thanks.

