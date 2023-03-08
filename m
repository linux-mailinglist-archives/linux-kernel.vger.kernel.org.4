Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3864E6B10E0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 19:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCHSRX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 13:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjCHSRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 13:17:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113202684
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 10:17:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9DCE618EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 18:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9319BC433EF;
        Wed,  8 Mar 2023 18:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678299439;
        bh=WSCK4EjboqTykWYFTwfbIgSgksqAobdYHV2zBrtxayQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fm9Tp+jDqiNJLqPdubQL+sEqoF7WZwjzbyVuKq+9MWn9ysbdCt5ZNPU6JbsKRN9Zg
         JkNLuMwYtPX2w/9tvhKaBqMIj07vlY3iYlZlBEYZJPY9ZMIejpGFpG1QswMMXHZAP5
         YNk/VSlUjOYLNxMQknxZksyrIkd43L/P54M3dWwVGmuGZuqoyVE94rUkuy0/CjfH7C
         9xk+6GsVbcc/U3HEIPRscOwUkG2+2HIyUaaP8ISTMxMUgD+3f/BkZjqMgaeq03nomF
         Sm74VuBfnURUVXRNZbd1apZCYyTbaV/1QwjQfG33+M+J5fNwGfJNRZ0xXRDIhX6jBF
         /ibogoPIXwq4A==
From:   SeongJae Park <sj@kernel.org>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, damon@lists.linux.dev
Subject: Re: [PATCH v3 0/3] mm/damon/paddr: minor code improvement
Date:   Wed,  8 Mar 2023 18:17:17 +0000
Message-Id: <20230308181717.46186-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230308083311.120951-1-wangkefeng.wang@huawei.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On Wed, 8 Mar 2023 16:33:08 +0800 Kefeng Wang <wangkefeng.wang@huawei.com> wrote:

> Unify folio_put() to make code more clear, and also fix minor issue in
> damon_pa_young().
> 
> v3: 
> - as SJ split the bugfix from v2, and it has merged[1], only do code
>   improvement
> - fix a missing folio_sz update in damon_pa_young()
> - add RB from SJ
> - rebase on next-20230308
> 
> [1] https://lkml.kernel.org/r/20230304193949.296391-1-sj@kernel.org
> 
> v2: 
> - use goto lable in damon_pa_pageout() and refact too more functions
> 
> Kefeng Wang (3):
>   mm/damon/paddr: minor refactor of damon_pa_pageout()
>   mm/damon/paddr: minor refactor of
>     damon_pa_mark_accessed_or_deactivate()
>   mm/damon/paddr: fix missing folio_sz update in damon_pa_young()
> 
>  mm/damon/paddr.c | 26 ++++++++++----------------
>  1 file changed, 10 insertions(+), 16 deletions(-)

For the series,

Reviewed-by: SeongJae Park <sj@kernel.org>

Thank you for your efforts on this, Kefeng!


Thanks,
SJ

> 
> -- 
> 2.35.3
> 
