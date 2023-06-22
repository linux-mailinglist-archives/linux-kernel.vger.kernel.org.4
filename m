Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9D77397E4
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjFVHLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjFVHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7926C1BE6
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB3A46177D
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 53330C433C8;
        Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687417865;
        bh=vrXHtyphIJe+SKj81IvX0Y99BnNTATMm/NijGQ1EtTg=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PUtViafET0AZXl4/NXmnOZfAwAEeAN9/I5Jqn/cHkbz7v/TZUtW+nKMcOakPrO+pH
         ikj2SzC/BolmNIRhZ9zf+iY1DDKDbPIP2C128fwF71dxElBciBBNrJDmjEwXZHDpU9
         osLECYS7rkLCWgC6Clc1B6eXOGV1g2gjO/fhTWEwi8boz6EhVM4iD8l67UzhpO+vHJ
         iQexp6O45ZJCeoGVy++5Ryladbng1wOMLCJOxO7r6PtYmtnh4jYjC1+wVzTQW62MKp
         ewzJysmp33FRhaiQXvK/Y3GHFSZzN7WCNUT/Kk1/kqMe8PkAB+hCOEIRVpPP9PTOZp
         ry7lBoB1xWMTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 31431C395FF;
        Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: convert to use sbi directly
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168741786519.21692.7476718026354315817.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 07:11:05 +0000
References: <20230509095706.17844-1-frank.li@vivo.com>
In-Reply-To: <20230509095706.17844-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue,  9 May 2023 17:57:03 +0800 you wrote:
> F2FS_I_SB(inode) is redundant.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: convert to use sbi directly
    https://git.kernel.org/jaegeuk/f2fs/c/08f83cb23a3e
  - [f2fs-dev,2/4] f2fs: move the conditional statement to hold the inode lock in f2fs_ioc_decompress_file() and f2fs_ioc_compress_file()
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: move the conditional statement to hold the inode lock in f2fs_release_compress_blocks()
    (no matching commit)
  - [f2fs-dev,4/4] f2fs: move the conditional statement to hold the inode lock in f2fs_reserve_compress_blocks()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


