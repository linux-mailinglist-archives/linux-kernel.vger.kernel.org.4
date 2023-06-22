Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421BA7397E3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 09:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjFVHLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 03:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjFVHLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 03:11:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793071BE7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 00:11:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 033256177A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 07:11:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 59B79C433C9;
        Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687417865;
        bh=GjxOJYaBtSOlnk07x5M2xCANMesU4QG/68w08znZ5Sw=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=GBRM4w2W9hv/OLK76SCW0rizK456TApuO8uBeABjJ1fVuQLKkT5Thw+WEHMXrrweH
         /yHkEO1ccNwCvX7Y+xQacloD7xw7lE/6CAMwWfi5eSRlKcigosVlAp6TayRX7nSXib
         vg2rXLKZOzYwLlopkCccEPFhdr6REICTNVNYbVBpJHK8brZwFXt2Fm+oFs1kvBIHmB
         9fv+F8qrIXYQI9OSYJWlcPI4ttelV0wKV+wWqmkBISxtogrx6KzEUWYuFf2zJTwDrn
         3LkNCZnmhJy2FRAf2YA9CWQN5jNj3E3sekWQekNqV5Qk7PysaMy5yfC+26P8JhvVJJ
         m+34yQKrfiCqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3AC49C691F0;
        Thu, 22 Jun 2023 07:11:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: convert to use
 F2FS_SMALL_VOLUME_IPU_POLICY macro
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168741786523.21692.5617086196942708682.git-patchwork-notify@kernel.org>
Date:   Thu, 22 Jun 2023 07:11:05 +0000
References: <20230613075157.41065-1-frank.li@vivo.com>
In-Reply-To: <20230613075157.41065-1-frank.li@vivo.com>
To:     Yangtao Li <frank.li@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello:

This series was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Tue, 13 Jun 2023 15:51:56 +0800 you wrote:
> Just for cleanup.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  fs/f2fs/segment.h | 2 ++
>  fs/f2fs/super.c   | 3 +--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [f2fs-dev,1/2] f2fs: convert to use F2FS_SMALL_VOLUME_IPU_POLICY macro
    (no matching commit)
  - [f2fs-dev,2/2] f2fs: convert to use sbi directly
    https://git.kernel.org/jaegeuk/f2fs/c/08f83cb23a3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


