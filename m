Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9576DE1C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbjDKRBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjDKRAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3101559DF
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A1599629A3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 053ADC433A0;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232420;
        bh=y0sC1maeF6BaZCVKP2Dpae2MYRm6bDMWSoxaogWa0tw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Mu0Y+nL2v52Anxuw8M7kClUMoXtEdnoJ0tC7PXlRgKOG/GIIKEzqpAAHcR/YlBEDE
         oDbCqh45+oxLslZL/sU0YUoh561I/rKLGuMvXPJpW5gV8ysxQIqfOPlC97Y89+Jze9
         9rBlfZ77FyZ3tTTnvThj+6A5tzuQaiwH+1/cDtYAnrbLQ0hu82dCu9YDQVf5hCIjy1
         P63DHgOoSuJGs/CNu+ZkHT6t4juchCJZPanngquwV7gTeq9LPemJVaUxTXJ4MnlxV3
         Yo16NwKW8DgSlE2/m5HvQFNEWbmYKBs+DXBIshczsWl5INcr3cldZ+oII7ygM7ARlJ
         2/0W9RkcyPUKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CE94DE52447;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: use f2fs_hw_is_readonly() instead of
 bdev_read_only()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241984.4928.10498593969347479726.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410021722.1836433-1-chao@kernel.org>
In-Reply-To: <20230410021722.1836433-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Apr 2023 10:17:22 +0800 you wrote:
> f2fs has supported multi-device feature, to check devices' rw status,
> it should use f2fs_hw_is_readonly() rather than bdev_read_only(), fix
> it.
> 
> Meanwhile, it removes f2fs_hw_is_readonly() check condition in:
> - f2fs_write_checkpoint()
> - f2fs_convert_inline_inode()
> As it has checked f2fs_readonly() condition, and if f2fs' devices
> were readonly, f2fs_readonly() must be true.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: use f2fs_hw_is_readonly() instead of bdev_read_only()
    https://git.kernel.org/jaegeuk/f2fs/c/68f0453dabdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


