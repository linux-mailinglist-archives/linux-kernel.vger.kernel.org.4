Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6144B6CF64A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 00:21:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230339AbjC2WVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 18:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjC2WVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 18:21:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00D25251
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 15:21:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF6861DD3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 22:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD12EC4339B;
        Wed, 29 Mar 2023 22:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680128489;
        bh=dEY98fti8YdNLuybKGKQCokOJDiPjSDXGX1LP1Dsnjo=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=fxim0T0Li1ctRBtf59cgGXtBHIrEmBPsigbgs3HQsclFEwDrwLbnBi0XUwmJYivbC
         UPbWmcnEMOX9Ou5FgIR5vkl0177wiwYkvB7Idu21eZ3xxtdlaQhcQRwdgGjfIszKKO
         6VNvx2iDPU1Xs8BhQyFW2Wh+VUUqy3z7OfK+Zw5W19ZWKR37fqLzO8GPksIWfkGpMC
         b+bweVBPNFEVE5+WwyN+tmXBDsUimaH4p+Zt/NVxiwJ6LYb+2b9ojpTAHS2Q2uRfyn
         +e1Uuf1x0jRRb/MHHexWWKQCuLbIj7+FEe8Hw0wt1AWzTdnkv7rsCU3J5HlsAqFc+0
         EWzTd4yTMDqnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 81F77E50D75;
        Wed, 29 Mar 2023 22:21:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs fix for 6.3-rc5
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168012848952.3718.12657695551719922710.git-patchwork-notify@kernel.org>
Date:   Wed, 29 Mar 2023 22:21:29 +0000
References: <ZCOHd4jYn8zUCEZ0@google.com>
In-Reply-To: <ZCOHd4jYn8zUCEZ0@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Tue, 28 Mar 2023 17:33:59 -0700 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs fix for 6.3-rc5
    https://git.kernel.org/jaegeuk/f2fs/c/3577a4d37f9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


