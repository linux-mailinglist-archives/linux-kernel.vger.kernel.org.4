Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0816663AB
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239579AbjAKTVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 14:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235978AbjAKTUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 14:20:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96C4164BC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 11:20:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 86199B81CC8
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 19:20:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06ACBC433AE;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673464818;
        bh=kNvNOvylHjWzU3GA1gta75zMrroVfqpYNdHi3hvG1y0=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=P5vBoI+sbqBd9z2VYX0Whmvz/Yfprf+uCGsDo7wAT544GfnC0N+VzYM3k5D8vyC4G
         mJPDbJ2HDJEMVAgT0f2mueSB1WMuF4rTvKW7dzf5AaH7tUE1e4bo7Jj/esa+UxhL1A
         /FB0+/5j2xEXWAzhAvX3aOqyRMAAQu0OjkMdZpZpOdny9/3AjB/TBUtLMFFMXhuXZ5
         FHzZViQuEIEtVCyiskFxbh1Ke1pLVjNx37fp5TG/J66eDuglpx9HNAGExqLh34pwm0
         HRTyCY1ecQy2jumWKojpM3hY++wDYwdaiEIY1uIR2go2Tdh+tJ1i0qVVHoCYpvFdLh
         eMmW/bU2ZCegQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6C89E524C9;
        Wed, 11 Jan 2023 19:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: mark f2fs_init_compress_mempool w/ __init
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167346481787.5008.1714393402439701709.git-patchwork-notify@kernel.org>
Date:   Wed, 11 Jan 2023 19:20:17 +0000
References: <20221229131828.59116-1-frank.li@vivo.com>
In-Reply-To: <20221229131828.59116-1-frank.li@vivo.com>
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

On Thu, 29 Dec 2022 21:18:28 +0800 you wrote:
> f2fs_init_compress_mempool() only initializes the memory pool during
> the f2fs module init phase. Let's mark it as __init like any other
> function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/compress.c | 2 +-
>  fs/f2fs/f2fs.h     | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: mark f2fs_init_compress_mempool w/ __init
    https://git.kernel.org/jaegeuk/f2fs/c/a1357a91ec9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


