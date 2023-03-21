Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79646C3721
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjCUQkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjCUQk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:40:26 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD18B1F5CC
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4D5F5B818E4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:40:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06064C4339E;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679416819;
        bh=55reRUuPYsN7go7p2j+K98DZVMdkLy5/d38sthfHPtE=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=kNgNn/z7V167WafQ8J3z1OcoJVbYWOuONUmHB3Jp6OyL5C3nVwHb14tJj1g/5DyQt
         SvHEtHdTDzv1rgahBeyDfWq++YCANCYuFrqz3Jp17NFH5xsLnL72dH4s71KsMoObqj
         UoNdAWQygaYYVW0fK22yWC2cuIXqiHyxpXzmSoxCFvglWYv1Tgi1tF9zrHsoVkXOYu
         mEUb8+LqvhsAmH025Y748edTTr9sEE1HhL9w93PQ6FXhjH32Oh1BlpoNomYuFKWBnG
         pd4Jmo4DVsd9vuZMp3n47XDkIinaYfHZmU+HiLHi1bKAyOuu/AD0XR+0KOaT/Hzp1Y
         0yZsFbUil8HiA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1BD1E66C9A;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: convert to MAX_SBI_FLAG instead of 32
 in stat_show()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167941681885.25004.9197554561763193050.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:40:18 +0000
References: <20230308140623.35942-1-frank.li@vivo.com>
In-Reply-To: <20230308140623.35942-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  8 Mar 2023 22:06:23 +0800 you wrote:
> BIW reduce the s_flag array size and make s_flag constant.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -make s_flag constant
>  fs/f2fs/debug.c | 36 ++++++++++++++++++------------------
>  fs/f2fs/f2fs.h  |  6 +++++-
>  2 files changed, 23 insertions(+), 19 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: convert to MAX_SBI_FLAG instead of 32 in stat_show()
    https://git.kernel.org/jaegeuk/f2fs/c/e17992cc090b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


