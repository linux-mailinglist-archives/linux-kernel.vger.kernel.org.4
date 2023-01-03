Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E0265C4C5
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjACRHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238645AbjACRHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:07:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC8E140DB
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:03:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CAB0A61484
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30ADBC433EF;
        Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672765402;
        bh=es9YEwfTJUiG5onbnN2r3/MT0gKlvyPEE1s/ihzxQ40=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=UNZHWsYsbqP+6kFXbs0mEDWbKzasYQXOzWNSySfJo2aBpZBLMQd3ExEN2Helh9NCb
         24aus7w9kvod/v/bgH1nZQ9CsY9aGHPN+0ns2PwqrI/rg7PxO1nUA79YXN/PVMi1+G
         VEQ7lrz1Hf3XfTIvbN9cPTcepT0WUCI1mmE/9/YB8D2q3N0E0ChN1izfm3M7jzM6nV
         uhUlE/MGvnulY+Fgy3g9tMPZdpECESOD9FumiCd4XDDd92SYzConkj3XoJsBhUpKxr
         12VAzMFjcMnTg/rG5cfJzmhuLeFmrmjbB9l3+d34QI33KIFjfI1ivb1+j3FoDHWOd+
         kuYTRz+TpFLtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0E6ACE5724E;
        Tue,  3 Jan 2023 17:03:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid NULL pointer dereference in
 f2fs_issue_flush()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <167276540205.24190.7786330518792341546.git-patchwork-notify@kernel.org>
Date:   Tue, 03 Jan 2023 17:03:22 +0000
References: <20221230154332.5082-1-chao@kernel.org>
In-Reply-To: <20221230154332.5082-1-chao@kernel.org>
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

On Fri, 30 Dec 2022 23:43:32 +0800 you wrote:
> With below two cases, it will cause NULL pointer dereference when
> accessing SM_I(sbi)->fcc_info in f2fs_issue_flush().
> 
> a) If kthread_run() fails in f2fs_create_flush_cmd_control(), it will
> release SM_I(sbi)->fcc_info,
> 
> - mount -o noflush_merge /dev/vda /mnt/f2fs
> - mount -o remount,flush_merge /dev/vda /mnt/f2fs  -- kthread_run() fails
> - dd if=/dev/zero of=/mnt/f2fs/file bs=4k count=1 conv=fsync
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: fix to avoid NULL pointer dereference in f2fs_issue_flush()
    https://git.kernel.org/jaegeux/f2fs/c/b3d83066cbeb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


