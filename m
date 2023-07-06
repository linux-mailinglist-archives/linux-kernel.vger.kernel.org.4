Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BFA74927E
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 02:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbjGFASc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 20:18:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbjGFASW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 20:18:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F1170F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 17:18:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AFCB61807
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 00:18:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30C45C4163C;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688602695;
        bh=NJw3PZzMuCwwMcMSxFbvLpZhobMhsPnQQv6wafbTKtk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=PTwth056POe7NUFtCvmuHa28xS5FyO5l+dQBHab2NGymq0TI+h83vnutmCEP7HZ4S
         7038WZ/oGBuSQ1rR9FTsGvdTZlPklGh9MT4IWUBxeX7XrjsW5R15UaphF70osX8wMY
         8LU77IEJy8gEQNO0LNJX1K96pyNk8+EKBSmFQqjvFQ6ZE+/xNy7IO2tRJpH70MTqHT
         LUk8NoEATcnxImLTeoS1I1yibU13ZweAEQJGrjaA9ljv/J8JLyTURwvwRK0hn+GDPQ
         dEdX95Ixxc9f8PCUcVwxY6fVVrDEVoGCxzv3QodF3LP+GRA1Y3lk9MhI0A2mFxWzwP
         eca8pDxHvLs7A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06476C561EE;
        Thu,  6 Jul 2023 00:18:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.5
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168860269502.29151.1311493785535240240.git-patchwork-notify@kernel.org>
Date:   Thu, 06 Jul 2023 00:18:15 +0000
References: <ZKWuP6+mGdW/W0/P@google.com>
In-Reply-To: <ZKWuP6+mGdW/W0/P@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Wed, 5 Jul 2023 10:54:07 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thank you.
> 
> The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.5
    https://git.kernel.org/jaegeuk/f2fs/c/73a3fcdaa732

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


