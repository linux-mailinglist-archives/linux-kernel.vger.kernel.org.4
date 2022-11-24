Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24012636F94
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 02:05:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbiKXBF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 20:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiKXBFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 20:05:08 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A003E105A82
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 17:05:01 -0800 (PST)
Date:   Wed, 23 Nov 2022 17:04:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669251900;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oACjNXXP3xVgZpEB/f3J9yFE/s5qP5Dh8NzPjfpB1mc=;
        b=B9dnoEMQAoIAwP+RbNbiy+Twg38gpcQFCpvK0NeZ6ZlkStgcw+TmkpjtBbAK+ypI2eStg+
        lCd7c1BFXMvUaRtaXe8+Pus6RAo5a1P0AG+Pp/+DwSq8ETzGaPVLIxCnPaXXeIM0k+Gkce
        7iHfSJbK7/IvTV3e29o3uf211WyX6pI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 3/3] selftests: cgroup: make sure reclaim target memcg
 is unprotected
Message-ID: <Y37DOJqKrFfFB2ZW@P9FQF9L96D.corp.robot.car>
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-4-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123092132.2521764-4-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:21:32AM +0000, Yosry Ahmed wrote:
> Make sure that we ignore protection of a memcg that is the target of
> memcg reclaim.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> ---
>  tools/testing/selftests/cgroup/test_memcontrol.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
