Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3F76EFDD7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 01:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbjDZXH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 19:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZXHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 19:07:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D359BBB
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 16:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 620C263345
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 23:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C45B4C433D2;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682550440;
        bh=/+hULzucfSLRlVWrR5BmDeyXpDowzM7ZKzI3SZWoaRU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=bi3StrqxZmtuSO0VU5rtR4Xpo0KbCTRtH2j7+0g85WAx1upPH/NRl7Yja1ApSe84k
         3jS6/yzQK97XcK5J0YTrOeQbvoylykMIOm+JQSMvUGlfL1pmA0V3FtAiY9tJcdJ4yP
         vG8AoGxZm0rvlqNlfyFkF7Z0bwG3DXDH7iOWcvzWSKPKjX4U5VGc/PgZwcjrgblJti
         1jJYCRiHc2X7rOoTtk1rJrsc4jfxQJfl/TvgXzy04i/VfQtVd1ZYfyT2b1BrB52Bme
         lWYEn0qePPm/df1rFJSDTbUSzSAV7nq4k1HcKVo1vqVkhaRRO0lZe9h3rsrqtRxdpF
         DfTzM3ffHUkeg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A3931C73FF3;
        Wed, 26 Apr 2023 23:07:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.4
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168255044066.16014.6020850362177131584.git-patchwork-notify@kernel.org>
Date:   Wed, 26 Apr 2023 23:07:20 +0000
References: <ZEgdmJWhJX9NJ0fG@google.com>
In-Reply-To: <ZEgdmJWhJX9NJ0fG@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

On Tue, 25 Apr 2023 11:36:08 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit ffe78bbd512166e0ef1cc4858010b128c510ed7d:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.4
    https://git.kernel.org/jaegeuk/f2fs/c/5c7ecada25d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


