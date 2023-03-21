Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2336C371B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 17:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCUQk1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 12:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjCUQkW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 12:40:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088AC1D934
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 09:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 923F661D39
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 16:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0AC9C4339C;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679416819;
        bh=GY8DQNujLNBf1HugJ+wTulFJIHywPT3nK3IqkYbjfSw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nzrHPXhBaxqsdsPmy6zwBKAPQtRp2bM8qij9gEFUdObJHMmj8YOPgHNruZGoH5Ocq
         /aIa4vxUdG45pmfvlzwfRoC7aFY4/7i/16HRK0DdFP+1S7j6KXVMR3hc/jwNZSxvnF
         DIZxC7M4l+Kn0yVeAlJ/5Fh9z0YGj0Uyx67lc7wMqMaRD5SXOuLQPAH04AZsg74ORO
         NA9Noe4iUGokgGChTCD+8iEaxJNQlzEc5Z/bQWOWLBgR+ngz8oytGvAxr5RqD2SGdK
         WnP+k7yHpwy6j2ICq0LbSH2drABVgP0dAYRbZbK8vIPB95pKZHz4fFF/Z7JAQsQdJN
         m+TTE2YA0CZnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C8E1AE66C9B;
        Tue, 21 Mar 2023 16:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 0/3] remove shared memory structures
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167941681881.25004.14989603719608389854.git-patchwork-notify@kernel.org>
Date:   Tue, 21 Mar 2023 16:40:18 +0000
References: <20230313201216.924234-1-jaegeuk@kernel.org>
In-Reply-To: <20230313201216.924234-1-jaegeuk@kernel.org>
To:     Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
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

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 13 Mar 2023 13:12:13 -0700 you wrote:
> This series removes the use of rb_entry based on memory alignment which doesn't
> look like a right design when considering various architectures/compilers.
> 
>  v2 from v1:
>   - adjusted Eric's review
>   - refactored gc.c further to clean up
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/3] f2fs: factor out victim_entry usage from general rb_tree use
    https://git.kernel.org/jaegeuk/f2fs/c/e433c7887585
  - [f2fs-dev,2/3] f2fs: factor out discard_cmd usage from general rb_tree use
    https://git.kernel.org/jaegeuk/f2fs/c/7e9775a516ff
  - [f2fs-dev,3/3] f2fs: remove entire rb_entry sharing
    https://git.kernel.org/jaegeuk/f2fs/c/6b40bc364c10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


