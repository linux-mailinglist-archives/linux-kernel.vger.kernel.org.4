Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92736FB654
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 20:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjEHSec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 14:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjEHSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 14:34:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 839AE59FC
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 11:34:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E5E61F50
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 18:34:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3854EC433D2;
        Mon,  8 May 2023 18:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683570867;
        bh=Dn7+e8seK6/zwfLvdedKADC/j3PIr8QfOPcWNlmROtU=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D8gF7m1nvfltldXU0tUm0i9BzkC0+M4VLhXZRrDUDCjs1mxxe02T9VXg1d8MW49yN
         HFqIVWnZEe6XUQOXRZ/vZCxjh3c4iZqBCCIrSl8MoSPs59YOwPiqsaBfcn4JLz1f1U
         O5agOHtKQ6XK5Q9X6h0xUWO1NwI7l5zSiJjMht4ZWQtEDvj2j+yGPUIDRKLcb5EHzy
         izTpIkCDm+m74FPEgUEZTvpbegUo3IDUUp3riV2rnl6Iq8TuFEDTll9FKEY9i3vo7B
         Wu88ENKVdcy60gCWZhFOD3ERo1FitJCJgNIJiAWM6+nhbEoJcM+tv0ZNhPWSS4T+pb
         jzV+1wuzP5saA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1698CC39562;
        Mon,  8 May 2023 18:34:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add sanity check for proc_mkdir
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168357086708.2764.4303615885378186638.git-patchwork-notify@kernel.org>
Date:   Mon, 08 May 2023 18:34:27 +0000
References: <20230425160611.79848-1-frank.li@vivo.com>
In-Reply-To: <20230425160611.79848-1-frank.li@vivo.com>
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed, 26 Apr 2023 00:06:11 +0800 you wrote:
> Return -ENOMEM when proc_mkdir failed.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
> v2:
> -removing check for proc in f2fs_unregister_sysfs and f2fs_register_sysfs
>  fs/f2fs/sysfs.c | 39 +++++++++++++++++++++++----------------
>  1 file changed, 23 insertions(+), 16 deletions(-)

Here is the summary with links:
  - [f2fs-dev,v2] f2fs: add sanity check for proc_mkdir
    https://git.kernel.org/jaegeuk/f2fs/c/888ca6edac81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


