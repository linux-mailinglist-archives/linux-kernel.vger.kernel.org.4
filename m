Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F67380C7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjFUKUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 06:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbjFUKTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 06:19:35 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D784110D5
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 03:19:25 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 71DE41FD9A;
        Wed, 21 Jun 2023 10:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687342764; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKUBSRmQnb9OXhbSlFmsphRAqkiPFYV6+ztYJzyeJzI=;
        b=ki/Qedz1tDrDku8s5ixiHkg0pVSMxMSPUWHwSYXu/0WFpb1rPalHUdTVNK7+aL7KPTS2ie
        cmRfT2eEP7dGmATkq8K59hnQIr+7ieHEMc1JHQVaiNbzno/hjFZfPUufX6BDohIYOVO5P4
        m2i2TNdh9a+lkh1esiWnYkMmZpvFnOo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687342764;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EKUBSRmQnb9OXhbSlFmsphRAqkiPFYV6+ztYJzyeJzI=;
        b=yf40/zFB2s+kZsmbBuKTaMfsrkl38r9M/Kjj1USo53tZfYLXSMuk2/gmerfLjq9mk4/WVM
        +qezB3Ye4CU/+ADA==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E41992C141;
        Wed, 21 Jun 2023 10:19:22 +0000 (UTC)
Date:   Wed, 21 Jun 2023 11:19:15 +0100
From:   Mel Gorman <mgorman@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Use recent_used_cpu to test p->cpus_ptr
Message-ID: <20230621101915.k323amaxqxjjefzn@suse.de>
References: <20230620080747.359122-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230620080747.359122-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 04:07:47PM +0800, Miaohe Lin wrote:
> When checking whether a recently used CPU can be a potential idle
> candidate, recent_used_cpu should be used to test p->cpus_ptr as
> p->recent_used_cpu is not equal to recent_used_cpu and candidate
> decision is made based on recent_used_cpu here.
> 
> Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")

Acked-by: Mel Gorman <mgorman@suse.de>

-- 
Mel Gorman
SUSE Labs
