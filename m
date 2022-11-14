Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D35AC627D77
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbiKNMP1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiKNMPY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:15:24 -0500
Received: from outbound-smtp31.blacknight.com (outbound-smtp31.blacknight.com [81.17.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5877D1DF08
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:15:22 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id A91AEC0C3E
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:15:20 +0000 (GMT)
Received: (qmail 31761 invoked from network); 14 Nov 2022 12:15:20 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 14 Nov 2022 12:15:20 -0000
Date:   Mon, 14 Nov 2022 12:15:17 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] sched/core: Adjusting the order of scanning CPU
Message-ID: <20221114121517.vwg4rr5xb3nvwpjy@techsingularity.net>
References: <20221026064300.78869-1-jiahao.os@bytedance.com>
 <20221026064300.78869-3-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20221026064300.78869-3-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 26, 2022 at 02:43:00PM +0800, Hao Jia wrote:
> When select_idle_capacity() starts scanning for an idle CPU, it starts
> with target CPU that has already been checked in select_idle_sibling().
> So we start checking from the next CPU and try the target CPU at the end.
> Similarly for task_numa_assign(), we have just checked numa_migrate_on
> of dst_cpu, so start from the next CPU. This also works for
> steal_cookie_task(), the first scan must fail and start directly
> from the next one.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Test results in general look ok so

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
