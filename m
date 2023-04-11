Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79C116DE1CC
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjDKRBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229840AbjDKRBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:01:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3EE76596
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 176C362992
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 19A7AC433AA;
        Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232420;
        bh=PMmdMCO12455MMTWEUxUMZXQatPGCk8YW8205G5rdHQ=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SS7AZRGyWPIlQtBOj1GcVzY9XIxET3EWytGmhLpRTl9QX07zkq+rwn4xWf/MhBZ92
         zjXmdbc3FudP4ciEjYVwKSyUGay4UMSG8JO2G6RbRb3KdYmwFrbSfqknuLanm+wIPJ
         p/SQQm1irlz4DphNwif4LATHKRRXv51HBIgohXl5r/4hTAYifeqOGwAhrQi/1u8tCk
         chQVqCliUF8qbIhNNGeo0xLfNUX5cEEiIfV+c11EA31ACWnb3DKF2esvPWM4tXLio+
         0U5wZoXW4xbBjso827hVwQfZQQfwLyQk8LQ38aKFuhiqv8dvdy+1RF1zXcqYJ+C9fP
         QcXQeA4Nyv0jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E84D7E52445;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to keep consistent i_gc_rwsem lock
 order
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241994.4928.5946573581439812528.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410021140.1825781-1-chao@kernel.org>
In-Reply-To: <20230410021140.1825781-1-chao@kernel.org>
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

On Mon, 10 Apr 2023 10:11:40 +0800 you wrote:
> i_gc_rwsem[WRITE] and i_gc_rwsem[READ] lock order is reversed
> in gc_data_segment() and f2fs_dio_write_iter(), fix to keep
> consistent lock order as below:
> 1. lock i_gc_rwsem[WRITE]
> 2. lock i_gc_rwsem[READ]
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to keep consistent i_gc_rwsem lock order
    https://git.kernel.org/jaegeuk/f2fs/c/db141b729bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


