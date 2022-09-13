Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA5B5B766D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 18:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbiIMQ0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 12:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbiIMQZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 12:25:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F2233372
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 08:20:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B103614C1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 15:12:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E53C433C1;
        Tue, 13 Sep 2022 15:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663081955;
        bh=4luCPVtQTAZm35zZrX2IGMQkLhYUQiShAN4g1WJcn8M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ij4X0cM3XlwT37LgX3kv5/sJHbizPuQndngFDP4EWnIj8AVrjyh4b6G9rr27MVHl/
         L9zwqqsdFItrXT/VRvx4kXzTOHe1gxIRCPfkEr3Y3+E1lJpJZOKHSYEpoDFRsX1fBm
         /r05Dqt4Sl93xrzWV5J+iLKyySpzW9ouyBkoLD4nXCfxOkbDjc8zz3MpD1m5vivW/U
         74G/ZkhqNkD4iuQ6a4eMjCFTw0Jyqv0p2dTzMwVec8oghCfQdpqnjvYwAsNa5vQffI
         X0kQJWcLHfymzX2s66tgDXwPqC9nSdpgKUw5z6Lx04wsIRPrHwjJiBrGQL3X+Gp4OE
         WIUOoz/X0WFyA==
From:   SeongJae Park <sj@kernel.org>
To:     xiakaixu1987@gmail.com
Cc:     sj@kernel.org, akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Kaixu Xia <kaixuxia@tencent.com>
Subject: Re: [PATCH 0/4] mm/damon: code simplifications and cleanups
Date:   Tue, 13 Sep 2022 15:12:33 +0000
Message-Id: <20220913151233.103245-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <1663060287-30201-1-git-send-email-kaixuxia@tencent.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Sep 2022 17:11:23 +0800 xiakaixu1987@gmail.com wrote:

> From: Kaixu Xia <kaixuxia@tencent.com>
> 
> This patchset contains some code simplifications and cleanups
> for DAMON.

For the first three patches,

Reviewed-by: SeongJae Park <sj@kernel.org>

But, I have a question for the last one.  Please answer it.

Thanks,
SJ

> 
> Kaixu Xia (4):
>   mm/damon: simplify the parameter passing for 'prepare_access_checks'
>   mm/damon/sysfs: simplify the variable 'pid' assignment operation
>   mm/damon/core: simplify the kdamond stop mechanism by removing 'done'
>   mm/damon/vaddr: indicate the target is invalid when 'nr_regions' is
>     zero
> 
>  mm/damon/core.c  | 24 +++++++++---------------
>  mm/damon/paddr.c |  5 ++---
>  mm/damon/sysfs.c | 11 ++++-------
>  mm/damon/vaddr.c |  9 ++++++---
>  4 files changed, 21 insertions(+), 28 deletions(-)
> 
> -- 
> 2.27.0
