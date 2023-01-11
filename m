Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B886663A9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238657AbjAKTUj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:20:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235835AbjAKTUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:20:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362481838D
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:20:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B479961E0B
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11E77C433B0;
        Wed, 11 Jan 2023 19:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464818;
        bh=zeLE3YuBaPwdWq0OnqqBjA40FXySaJ6AnpW40oUr8Lc=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=IMSEorBOzO2Ww7x7/MWbXKeebz64zRMpkhWr63foKAF8w2ewvKjSHlVSjaFbXmGnr
         9h/FM7H2BGqRwIJGXBpwBk3xXcqefHtQlqmV+uxPPy9eapQ2mhpzablhm0CzyupE83
         L5TvexHb8NQdE/y6NnunONCAUtJsY3kpXZmXx2RxZI/KMOj7B7NcNdr7LyLTC4pK8/
         jSs6DskjNRKYw65jH4AJcBP/dX1jBbCs8GXXf2B3QdTLzH8h/98eJpfRuIVkvCSNxC
         mfy/wqnUXvvXpylOPFTaRHC+KTmGKwIcJRLzwvcwtAp51QKyJBn6zNtRrGUKMBUE0s
         iktjr6KNGgjIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DE8BCE50D61;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert to use MIN_DISCARD_GRANULARITY
 macro
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167346481790.5008.280373755009706563.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 19:20:17 +0000
References: <20221217052448.60656-1-frank.li@vivo.com>
In-Reply-To: <20221217052448.60656-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Sat, 17 Dec 2022 13:24:48 +0800 you wrote:
> Commit 1cd2e6d54435 ("f2fs: define MIN_DISCARD_GRANULARITY macro")
> introduce it, let's convert to use MIN_DISCARD_GRANULARITY macro.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/segment.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: convert to use MIN_DISCARD_GRANULARITY macro
    https://git.kernel.org/jaegeuk/f2fs/c/f08142bc3a60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


