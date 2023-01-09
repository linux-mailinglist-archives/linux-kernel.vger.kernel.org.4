Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DF266345A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 23:51:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbjAIWv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 17:51:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbjAIWvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:51:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3271DDFFA
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 14:51:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DCA5FB810A4
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:51:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85EF5C43396;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673304674;
        bh=H8fUG9NgMpPUeDtXFhknhCSc6TOtHhGyumR0hB97Oag=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ofoj9Diy8+Xmc5Rnrtw9WgktGT2cR60RknNB/rmFRud7wCkXQAUc9oqGb41/4Yq5K
         Hm050Cs4AL3MXkIVRHeP9AFcqsoci6+yDYuA9AL8UPh254cuH9lkysHo51pt23yXW7
         nVAKtBqMtCHEaIYwStoujnbUwHEevcqBCxpvMUqrelNLa2w2bpyj57geyYp08uy9vM
         B6SJou3b8pyUbY8MId2mKJaxTeH3wp2NrVB4aB0rXdLlhqq1f1YsODJrmIV++1bXrP
         20E/PSJMp4sXjBSzE/n12emw2XO9LJ1PlOGVhxXnOCHAsf3dtIT3c+sKjdWBQE92Ck
         ON6aVHPqH8xbQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 62689E50D62;
        Mon,  9 Jan 2023 22:51:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to support .migrate_folio for
 compressed inode
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167330467440.13717.17416282995596170493.git-patchwork-notify@kernel.org>
Date:   Mon, 09 Jan 2023 22:51:14 +0000
References: <20221221121445.14400-1-chao@kernel.org>
In-Reply-To: <20221221121445.14400-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

On Wed, 21 Dec 2022 20:14:45 +0800 you wrote:
> Add missed .migrate_folio for compressed inode, in order to support
> migration of compressed inode's page.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/compress.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to support .migrate_folio for compressed inode
    https://git.kernel.org/jaegeuk/f2fs/c/f35474ec0059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


