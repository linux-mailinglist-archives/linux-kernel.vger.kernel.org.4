Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABD68362B
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 20:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbjAaTKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 14:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjAaTKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 14:10:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F61D56EE3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 11:10:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D9FC9B81E6E
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 19:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 49FFEC433A0;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675192220;
        bh=tCiZPdBodHgn+9HGNSelz7b93sIkuDQColYmbEDd9S0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=VlI4hatzDQ8JmbW0G/9iPlsaY5C1y9GqsFEavNR117DezU+LlkSaNNEH2r76Tggxs
         umDEnv9sxtp3pKQw85c0NZ4gq+KT5PDy0U+WhtY0IBLuTEVVQDWyNM38OlQ3f6qDYf
         5KkBvwVHy6v4977LSEzs/YCQAaZ0tJN6Qnmw2i0wTwVpVLpz+QrKzcpayTXSnVcTvv
         baOAR3RRuG/ZqD9y2nTamPJpTLPNiFyamDvPPxp94mmnxmRCfqWx1yOXgxEFHphUek
         UeEaTY5SzGSSsOlPRAttCcCpmlRqZlsMpYg5lHC0KB7wbAhQnrKgWfnfcfpqW1d0Pa
         Ng6hcSAiEGe/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D826E50D6C;
        Tue, 31 Jan 2023 19:10:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: clean up __update_extent_tree_range()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167519222011.20142.17605283450543529387.git-patchwork-notify@kernel.org>
Date:   Tue, 31 Jan 2023 19:10:20 +0000
References: <20230131144701.34418-1-chao@kernel.org>
In-Reply-To: <20230131144701.34418-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 31 Jan 2023 22:46:59 +0800 you wrote:
> No logic change, just avoid goto statement.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/extent_cache.c | 66 ++++++++++++++++++++----------------------
>  1 file changed, 31 insertions(+), 35 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: clean up __update_extent_tree_range()
    (no matching commit)
  - [f2fs-dev,2/3] f2fs: fix to update age extent correctly during truncation
    https://git.kernel.org/jaegeuk/f2fs/c/334ce4a79c9e
  - [f2fs-dev,3/3] f2fs: fix to update age extent in f2fs_do_zero_range()
    https://git.kernel.org/jaegeuk/f2fs/c/de6b3a5e09b2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


