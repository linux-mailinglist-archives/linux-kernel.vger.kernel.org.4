Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDFC6E1872
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbjDMXkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 19:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjDMXkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 19:40:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689DE1727
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 16:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCCD64292
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 23:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DAA5BC4339B;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681429218;
        bh=fZPPuWKEzgHEeF7NvGfgflts7JxtanhschQS1SQZgaI=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=immdKNSy5L0EeNxGFex4I8z+xe4JkKjf/8SxzKk96BMPdK3p754DTZayphFi8BWRq
         cooVbaShlMkuzkfo2fC+NaCqaQeMZKJulm0X6L/9B0gXH7+U3ezyyUHPXdCV1BBlos
         Hz27U5B0fFNHhrwK6dIa94GpD/BbVNy4f1/ijVDCJDqoh0G6QHH9R1V8qu6//L1GIl
         TcyRR22YrZ+YS6ImkVDaqda4eJJ3XmGJIp525toYWpFdzNylPTsi6js4QsAtoH0JXz
         YE21Qq8HSq2MQjy2T9CFZJpVM/h/4foIAAx3TnbyLnu0L1a/JaGS5QKPvaTRDJYc0T
         MIj9Kk7/WnXGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3D48E5244F;
        Thu, 13 Apr 2023 23:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH 1/1] f2fs: support iopoll method
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168142921873.31957.2801806079442088561.git-patchwork-notify@kernel.org>
Date:   Thu, 13 Apr 2023 23:40:18 +0000
References: <20230413101711.13682-1-bo.wu@vivo.com>
In-Reply-To: <20230413101711.13682-1-bo.wu@vivo.com>
To:     Wu Bo <bo.wu@vivo.com>
Cc:     jaegeuk@kernel.org, chao@kernel.org, wubo.oduw@gmail.com,
        linux-kernel@vger.kernel.org,
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

On Thu, 13 Apr 2023 18:17:11 +0800 you wrote:
> Wire up the iopoll method to the common implementation.
> As f2fs use common dio infrastructure:
> commit a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>
> ---
>  fs/f2fs/file.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [f2fs-dev,1/1] f2fs: support iopoll method
    https://git.kernel.org/jaegeuk/f2fs/c/50aa6f44e1da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


