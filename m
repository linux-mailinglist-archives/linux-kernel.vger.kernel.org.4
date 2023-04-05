Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AB36D8385
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233435AbjDEQUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231995AbjDEQU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:20:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DED772BB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 375CC63F9F
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9905DC4339C;
        Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711619;
        bh=ThyosfilBVVjyHk4WXighduYLbTynjL9s58cnCVHZVM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=aJxoVoYNYyjmabttpuVoKnHjZJnLOT+c4qNTPL9xUw7d3Te7eCdz2Jk+ffek9nnyj
         zppWZ8q28i0qFeNwPZx4HqODtv9Id/8xng7fm1QJdc6tDLLUGMvbR5mdYliOm30ldw
         DsuuXZImfhbznFjtuVdXljBn7oOrmhLD4wRh+80Bz5NHItnDnL6juOPCOhYVhWc9TJ
         XjFmF4QIJUoY1fugdlJ+QVE0BN68W+3F2jjieae1XINEUfxQZGJmjxO7uA0PbV4luf
         Yfo9H14B/yXZ8gQDRccygjqfOyBjAAxu1lvPfYhxqpzENJW26CfGo3Qy+qEbWQ9v3F
         +nl2AmhrvszaQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 798E4C41670;
        Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [RESEND] f2fs: set default compress option only when
 sb_has_compression
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168071161948.13885.219294727113368599.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 16:20:19 +0000
References: <20230330165648.33907-1-frank.li@vivo.com>
In-Reply-To: <20230330165648.33907-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
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

On Fri, 31 Mar 2023 00:56:48 +0800 you wrote:
> If the compress feature is not enabled, there is no need to set
> compress-related parameters.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [f2fs-dev,RESEND] f2fs: set default compress option only when sb_has_compression
    https://git.kernel.org/jaegeuk/f2fs/c/338abb312bb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


