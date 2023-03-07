Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 304956AEB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjCGRqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:46:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232285AbjCGRpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:45:08 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8992D974BA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:40:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 380DEB819C7
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E96D7C433EF;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210825;
        bh=sIZlFfMWBsTCJuuFDyf/IkINN3ShV1UqVU0yc1AsDfw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=LwV6l6rpbxiTRQuAE7nCrnXMmK3dA4wKKxRUJJVDgTP1wRdXF8xx/Be4f26cV2Eqa
         wzpwDtUUj8E7eE7G1rNt2KoLk77AqTaUBYo7gbsP13jii6umm5OcLtmPcB3lAHXaiw
         Aivuxx64KBVym0n+7XXa1yzdJFasKX3pWmTd0YRPvnzjhvwlpHAsR8WPD1bjlJxSf/
         bE3SVMvMOEnZ0vUGR1YTgmWH09dsMXuLCpTvx+4ggioywLUZeNwZAsINUrjXdPZwYO
         L8zCBYfs1swvGYSdeOwZv38NKLXBAMYqizxVVobulj4m4EMKpNwO//KygLF6ZtYwTV
         UKQnN5twyCX8g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCAACE61B65;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2,
 RESEND] f2fs: export compress_percent and compress_watermark entries
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167821082483.1693.5488669635546632139.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 17:40:24 +0000
References: <20230216140935.20447-1-frank.li@vivo.com>
In-Reply-To: <20230216140935.20447-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
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

On Thu, 16 Feb 2023 22:09:35 +0800 you wrote:
> This patch export below sysfs entries for better control cached
> compress page count.
> 
> /sys/fs/f2fs/<disk>/compress_watermark
> /sys/fs/f2fs/<disk>/compress_percent
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,v2,RESEND] f2fs: export compress_percent and compress_watermark entries
    https://git.kernel.org/jaegeuk/f2fs/c/a29f3722b128

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


