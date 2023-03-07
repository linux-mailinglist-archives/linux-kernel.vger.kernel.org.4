Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 441146AEB8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 18:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232091AbjCGRpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 12:45:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231790AbjCGRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 12:44:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFBDAB8A3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 09:40:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64F946152C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 17:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CCA6BC433A7;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678210824;
        bh=/xkqGNJ4VHBP+p2CoqdnBE4IC+f3MlVqqhOfFRd6CUk=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=D2jOWm0luzts5v/YERrgmPCYhKyXyhHGuq68V0XQ080ZyCCCnUCuAejRQ515bpVOu
         2VeTqhK3DlaByXJKeCHqG6W5Z86bFLJIXmRCddm/H4NM6dh96VVLz/gqek0mLXrYVz
         hC0tJFwac+b4cHL7Iq8tWI00mMCOX58N+hRnP7/CSHylPdT/WRDerBMgBuvmaEirYp
         9TqHrJCWrSykWUg7ZgzVRppzqFnKAKa746Ft8LqWtu/uLNroCM6cA6Ua1TnsgqeIvQ
         463qa0hOT4bUCLr08mc8J66peFmru1jGUjgoTg3p2OPcFjWhyFkK99+1HySnddZ0V+
         JTSjcGngPSuNQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BAA16E61B63;
        Tue,  7 Mar 2023 17:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: make f2fs_sync_inode_meta() static
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167821082476.1693.14172428859403665467.git-patchwork-notify@kernel.org>
Date:   Tue, 07 Mar 2023 17:40:24 +0000
References: <20230223012513.1781735-1-lizetao1@huawei.com>
In-Reply-To: <20230223012513.1781735-1-lizetao1@huawei.com>
To:     Li Zetao <lizetao1@huawei.com>
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

On Thu, 23 Feb 2023 01:25:13 +0000 you wrote:
> After commit 26b5a079197c ("f2fs: cleanup dirty pages if recover failed"),
> f2fs_sync_inode_meta() is only used in checkpoint.c, so
> f2fs_sync_inode_meta() should only be visible inside. Delete the
> declaration in the header file and change f2fs_sync_inode_meta()
> to static.
> 
> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev,-next] f2fs: make f2fs_sync_inode_meta() static
    https://git.kernel.org/jaegeuk/f2fs/c/e6bd5463fce0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


