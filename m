Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 561DB6A6133
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 22:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1VYc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 16:24:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbjB1VY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 16:24:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076612FCD2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 13:24:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 990AD611BF
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 21:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3D85C433EF;
        Tue, 28 Feb 2023 21:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1677619467;
        bh=ZZ6VDeY/xsCqkaulsw/gZPu9JXjETJr9k/0DEh3D0Wg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FtiEFc28F1/RbeSVSH7gpAh1Q9rwyo8e+YSnT2lIxicATr6umDQdjSdTGfn1q28JL
         9ugDC7drnEh6q10nSTNJ9gIuA1J0N3Qq5+hUMn0/HQ1J5Ft1quUiNR4SGoVWROHhD6
         4SxGndn1cYqEZDfdzXoTprg8ZJT/LG4uNLYhJtCA=
Date:   Tue, 28 Feb 2023 13:24:25 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Raghavendra K T <raghavendra.kt@amd.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mel Gorman" <mgorman@suse.de>,
        "David Hildenbrand" <david@redhat.com>, <rppt@kernel.org>,
        Bharata B Rao <bharata@amd.com>,
        Disha Talreja <dishaa.talreja@amd.com>
Subject: Re: [PATCH V3 0/4] sched/numa: Enhance vma scanning
Message-Id: <20230228132425.1e18d47bdc4f406220a4a409@linux-foundation.org>
In-Reply-To: <cover.1677557481.git.raghavendra.kt@amd.com>
References: <cover.1677557481.git.raghavendra.kt@amd.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Feb 2023 10:20:18 +0530 Raghavendra K T <raghavendra.kt@amd.com> wrote:

>  The patchset proposes one of the enhancements to numa vma scanning
> suggested by Mel. This is continuation of [3]. 
> 
> ...
> 
>  include/linux/mm.h       | 30 +++++++++++++++++++++
>  include/linux/mm_types.h |  9 +++++++
>  kernel/fork.c            |  2 ++
>  kernel/sched/fair.c      | 57 ++++++++++++++++++++++++++++++++++++++++
>  mm/memory.c              |  3 +++

It's unclear (to me) which tree would normally carry these.

But there are significant textual conflicts with the "Per-VMA locks"
patchset, and there might be functional issues as well.  So mm.git
would be the better choice.

Please can you redo and retest against tomorrow's mm-unstable branch
(git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm)?  Hopefully the
sched developers can take a look and provide feedback.

Thanks.
