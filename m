Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1CF26A506D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 02:02:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjB1BCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 20:02:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjB1BCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 20:02:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA85229E15
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 17:01:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6084460F86
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 01:01:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4235EC433A4;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677546115;
        bh=PmoS5E4xHvZz7S45Aua+Oldz0QmPaw0tU7UqcXgqRRs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=FC/l+DsKvowNlIsw52thOMuE3cLhAO4XK0NIFS4KHfE+12QE4MFyV77WEfkhu912z
         eHnbzPxZF95iorEy2tQPemuYdLQOMntGxvpgwO2dvpppsr7H4me1rGxpuZoMW3VCpg
         uWhqnUK/ZhU8fe8CUvnij7r22vBS3/9Y/58MOoA6U5Xo0uniiF3iTxo9R4uU80Y0P8
         pXGmgNiC3eUHZ+odxHVkzB0+4r3kc8BXIRI4bWiPbAA4KrZI5r/evyCuZCJK35pFPj
         7PKzbimXo8acqF5roLuJOSHpFe8Z4X41FZlfd+oKoPDKIdgJKaLnVRJITQj1JIEYPy
         a673U8m5DbL3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 12813E524D4;
        Tue, 28 Feb 2023 01:01:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [GIT PULL] f2fs update for 6.3-rc1
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167754611507.27916.17564819671316940009.git-patchwork-notify@kernel.org>
Date:   Tue, 28 Feb 2023 01:01:55 +0000
References: <Y/004is4VtYI7G2u@google.com>
In-Reply-To: <Y/004is4VtYI7G2u@google.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
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

This pull request was applied to jaegeuk/f2fs.git (dev)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Mon, 27 Feb 2023 14:55:30 -0800 you wrote:
> Hi Linus,
> 
> Could you please consider this pull request?
> 
> Thanks,
> 
> The following changes since commit 512dee0c00ad9e9c7ae9f11fc6743702ea40caff:
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,GIT,PULL] f2fs update for 6.3-rc1
    https://git.kernel.org/jaegeuk/f2fs/c/103830683cfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


