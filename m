Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439468B4A1
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 04:50:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbjBFDu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 22:50:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBFDuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 22:50:25 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78E4118A98
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 19:50:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25C1EB80D30
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 03:50:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C8F46C4339B;
        Mon,  6 Feb 2023 03:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675655417;
        bh=tShHIVAsWrTXq/vjTB84km04tKH/kLs7E4lW6PVPjhM=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=tdGiB22M3+SFu/sXgKWEz0Zj/bqsCBZGwzLG2kc1nKTNiaAkdBruUiuzrVqhGbarY
         gzmq6Pg1KhceYitA0nvCkX4wVJcmZnNUlRF2Lc1c/RWZ5454BRgtmEBQGEg2oDven2
         idLerX9JxlZICKniKXYKcof7lhvIF9BSDWFxHE5oQ9HJvl6Pqrbxq1TBl6xAloxzND
         xozOqa3x6/1005if6F+4DWAv94vSmReiBt73PO7JCknWj7UVcHpEYfv4xxyCFQObW+
         25Qoz9SITlG+ZQ1+OntJGaemiXGQU3m+Eu2u4+VKbsQ7ViB3pinzlnIuEl2XD0u7Gx
         +AnQZug5GWsKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A714FE55F00;
        Mon,  6 Feb 2023 03:50:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix f2fs_show_options to show nogc_merge
 mount option
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167565541767.9334.7350798804353905371.git-patchwork-notify@kernel.org>
Date:   Mon, 06 Feb 2023 03:50:17 +0000
References: <20230202094123.74342-1-frank.li@vivo.com>
In-Reply-To: <20230202094123.74342-1-frank.li@vivo.com>
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

On Thu,  2 Feb 2023 17:41:23 +0800 you wrote:
> Commit 5911d2d1d1a3 ("f2fs: introduce gc_merge mount option") forgot
> to show nogc_merge option, let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/super.c | 2 ++
>  1 file changed, 2 insertions(+)

Here is the summary with links:
  - [f2fs-dev] f2fs: fix f2fs_show_options to show nogc_merge mount option
    https://git.kernel.org/jaegeuk/f2fs/c/04d7a7ae43fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


