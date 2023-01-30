Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCC0681F4D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 00:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbjA3XDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 18:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbjA3XDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 18:03:18 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE3279A7
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 15:02:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DFC5CB8172F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jan 2023 23:00:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2577EC4339E;
        Mon, 30 Jan 2023 23:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675119618;
        bh=zz2fZTcXQE8aex0XxwAs/xActBapAAFL/JM4bRudbfw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=SJwA3jZ3s7rRAd10fBoTdE9Mrsc/m2xlUj4UTaXbdzzuro3CF0pT39LBmltbqtq+x
         cZLFq6vP5cv9nxa3EmtxBh8dSqyRndp+InDwXkTkxW5QAJ4S88XDNFUVsRYXC0n1x+
         BagVF5L8W9PHTb4poa0rHAZZBhJs+fEM60PxedTj9s+sCAySKnHmJ45ZDNsEUzqzfT
         psRSTHgoXpzYzkpRYXqvtRcHxXhjwjxGwRGo0yrgIHdiQmiCkjBpH2jv6jWBCNKq9g
         BmwkymVmpemoznAfzVE7HCKFo1OnLMoutnz1oQKi7qKjMF39uMg/NZo9bemAFs/Q4C
         czfzfEZXdJaNA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DAC4CE52558;
        Mon, 30 Jan 2023 23:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: allow set compression option of files
 without blocks
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167511961789.12751.5170670621436578021.git-patchwork-notify@kernel.org>
Date:   Mon, 30 Jan 2023 23:00:17 +0000
References: <20230123094601.32940-1-frank.li@vivo.com>
In-Reply-To: <20230123094601.32940-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 23 Jan 2023 17:46:01 +0800 you wrote:
> Files created by truncate have a size but no blocks, so
> they can be allowed to set compression option.
> 
> Fixes: e1e8debec656 ("f2fs: add F2FS_IOC_SET_COMPRESS_OPTION ioctl")
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: allow set compression option of files without blocks
    https://git.kernel.org/jaegeuk/f2fs/c/0f837b84b2af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


