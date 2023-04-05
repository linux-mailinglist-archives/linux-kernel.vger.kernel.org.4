Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666A96D8389
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 18:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjDEQUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 12:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjDEQU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 12:20:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E05E72BD
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 09:20:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28D4163F9E
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 907E0C433D2;
        Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680711619;
        bh=aZWL0zcs3q9581Ru8j7YepShZdC8rcoI7ccdq3wCk7Q=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=Ev6VZsHiFwhR6SZiZ1go6umII/WSNGCYiKRdwjHVDNVrq8coT/DwXUOIMPH3GMovB
         6OvhWBQUNMVOZ00ktWyJRzZzI62QyMLn76WDRBasoX0VL0FfOw/qZtIY6pnx9gP7wA
         tDvQJ0BlYKC0SfxwT1C4OQVGnyDrZar8QO1VNGCmI3H7aaT/rAQ2iB1X3V99+BA4BE
         ounUHEFza5GwcP81/r9BmLVwPOuYgstezHyT3DTTx7I9XDqTE4pNhcWFGzVeO7QUZw
         hTBJ1fBsQ4HuJUJY7CQNYqPN5xSdz4EEyfvVxjHIMRqbANa3uIUIIZ6zvMEBTjrGYL
         6DgX4YmlsPbEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EAEBE29F4C;
        Wed,  5 Apr 2023 16:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/4] f2fs: fix to check lz4hc compression when
 CONFIG_F2FS_FS_LZ4HC is not enabled
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168071161944.13885.1835796747309052831.git-patchwork-notify@kernel.org>
Date:   Wed, 05 Apr 2023 16:20:19 +0000
References: <20230124153346.74881-1-frank.li@vivo.com>
In-Reply-To: <20230124153346.74881-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 24 Jan 2023 23:33:43 +0800 you wrote:
> f2fs supports lz4 compression algorithm and lz4hc compression algorithm,
> which the level parameter needs to be passed in. When CONFIG_F2FS_FS_LZ4HC
> is not enabled, even if there is no problem with the level parameter, add
> the level parameter to the lz4 algorithm will cause the mount to fail.
> 
> Let's change it to be the same as other compression algorithms. When the
> kernel does not enable the algorithm, ignore this parameter and print msg.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,1/4] f2fs: fix to check lz4hc compression when CONFIG_F2FS_FS_LZ4HC is not enabled
    (no matching commit)
  - [f2fs-dev,2/4] f2fs: introduce f2fs_set_compress_level()
    (no matching commit)
  - [f2fs-dev,3/4] f2fs: set default compress option only when sb_has_compression
    https://git.kernel.org/jaegeuk/f2fs/c/338abb312bb2
  - [f2fs-dev,4/4] f2fs: merge lz4hc_compress_pages() to lz4_compress_pages()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


