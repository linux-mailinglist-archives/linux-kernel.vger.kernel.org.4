Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A234174454C
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 01:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjF3Xkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbjF3Xk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 19:40:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D792D62
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 16:40:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A94E6183B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 23:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9C6CEC433D9;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688168423;
        bh=MUL3HpynqrN8NXdFIHKVH4ua0Im3yKJVHftqI1IB12M=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=c+z+1Nzpgg3utPqW7eXVKec7CL6/wio8T75TJuSTVfW91nK0qXy35Lby5VWka6hkW
         93PzCl5zuA2LxfeJ10LwZY8dDc4J+eeAoV6SHnwzeAvccPMDQ1zZE2R2mPrTq1zHl9
         ZPvpHV4L91Ws5V0lNTkpXWXJj4wUk9sdLgouzYVbdhro/Iiu7ij5aaJj5Z0iSZAw91
         XZn9i/irTqDBnnnZoWyPXunkDFT3nTo3Wgg+UCtBnlp3MBlv8WXtunlSqwmkRrajx+
         9oJ/7WYahlTcSqdWqxN5NsJ1PHJZNpfWX+HbaFMiBsB6m2mOxXax4AOHMAA/q9uRWs
         xECfiyQeacFWA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74606C6445B;
        Fri, 30 Jun 2023 23:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix compile warning in
 f2fs_destroy_node_manager()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168816842347.31915.15373358739208478916.git-patchwork-notify@kernel.org>
Date:   Fri, 30 Jun 2023 23:40:23 +0000
References: <20230629014134.3058318-1-chao@kernel.org>
In-Reply-To: <20230629014134.3058318-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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

On Thu, 29 Jun 2023 09:41:34 +0800 you wrote:
> fs/f2fs/node.c: In function ‘f2fs_destroy_node_manager’:
> fs/f2fs/node.c:3390:1: warning: the frame size of 1048 bytes is larger than 1024 bytes [-Wframe-larger-than=]
>  3390 | }
> 
> Merging below pointer arrays into common one, and reuse it by cast type.
> 
> struct nat_entry *natvec[NATVEC_SIZE];
> struct nat_entry_set *setvec[SETVEC_SIZE];
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix compile warning in f2fs_destroy_node_manager()
    https://git.kernel.org/jaegeuk/f2fs/c/c31e49615762

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


