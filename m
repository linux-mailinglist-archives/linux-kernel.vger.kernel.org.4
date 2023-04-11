Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450D26DE1C9
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 19:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjDKRBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 13:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjDKRAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 13:00:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E11E5BA5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 10:00:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AA931629A7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 11FE9C433A7;
        Tue, 11 Apr 2023 17:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681232420;
        bh=aJirYYVnV507CuqdHFL9yYz35QVzF4kkQPhyKYjmd94=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=nk6jCMDRQOZ12KevU/XEk6UfbS8sZsm08gwJLobFPYj9YjVSnWXcNnOXZjoEHGJEo
         qK0AVOX6ShPpnPSHhmME56aQpIDcB62I4ITy0bop9tEMR/oqWU6izNqMktTE1z/XfO
         sc9MhpOoq4UXMph6YyLI7CdGXaYEvof7HP68YWsq1oLG58cD6e12HcPG0t7LVh7XnJ
         YY7zVQUue9d9/Pb9wVFRL51CkR/hXw5Rl2VnE9B2k+CkuPWPK7sk0db5qZMqSz/HR5
         qMFzh1QOOwyUxvO+HepHgei65BbibdSX4RnGjM/imFPA2Qdl8r2c+AiZsbuHrm+pDc
         MCe1THivk+jDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF9BBE52449;
        Tue, 11 Apr 2023 17:00:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: remove unneeded in-memory i_crtime copy
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168123241991.4928.7987013426639567312.git-patchwork-notify@kernel.org>
Date:   Tue, 11 Apr 2023 17:00:19 +0000
References: <20230410022012.1839127-1-chao@kernel.org>
In-Reply-To: <20230410022012.1839127-1-chao@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     jaegeuk@kernel.org, linux-kernel@vger.kernel.org,
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

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Mon, 10 Apr 2023 10:20:12 +0800 you wrote:
> i_crtime will never change after inode creation, so we don't need
> to copy it into f2fs_inode_info.i_disk_time[3], and monitor its
> change to decide whether updating inode page, remove related stuff.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/f2fs.h  | 5 +----
>  fs/f2fs/inode.c | 1 -
>  2 files changed, 1 insertion(+), 5 deletions(-)

Here is the summary with links:
  - [f2fs-dev] f2fs: remove unneeded in-memory i_crtime copy
    https://git.kernel.org/jaegeuk/f2fs/c/c277991d7cf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


