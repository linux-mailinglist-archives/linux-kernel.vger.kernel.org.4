Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B10D72D12E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 22:56:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238031AbjFLU4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 16:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbjFLUzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 16:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4D85FE5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 13:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 00D5562264
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 20:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4A519C433EF;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686603022;
        bh=J3OtHHSsn0yjMX1uffsIAnEqKvVl+vYQ2fSPIvHvSCs=;
        h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
        b=mUKTUdzxXFJuqgCl9mF64LbBWb0+c3szdJ5CHE27/XfC2lj4iNRQVmJRGJnKMnlHN
         zDratVzW4nhN3YxOfdlFbDup2LRGLUgrBS852fo40a/dFGoDv86agG6AkgeNct5qIz
         OmcoY8tAa4OEf0SHxB+PehExcg5wo0KPb/UX6hwFHYNoHoGfdFCfwdUI9EEq1ohJtr
         XK/qMqPpVBEEtHmUb7h9Kxms7e0lg5h2PY5fXI02PGKKAIbonBAHzockG/ZUwYdJYA
         l61hEr3doTcKZVuSlcYXjffbxzYDuDusPERIMp+V//DP2v5D+O60fA+2EEyQKq+XOx
         guwkf28Tdmp5Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 27AA1E2A05F;
        Mon, 12 Jun 2023 20:50:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [f2fs-dev] [PATCH] f2fs: check return value of freeze_super()
From:   patchwork-bot+f2fs@kernel.org
Message-Id: <168660302215.10168.4138766982780443549.git-patchwork-notify@kernel.org>
Date:   Mon, 12 Jun 2023 20:50:22 +0000
References: <20230606061901.1179970-1-chao@kernel.org>
In-Reply-To: <20230606061901.1179970-1-chao@kernel.org>
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

On Tue,  6 Jun 2023 14:19:01 +0800 you wrote:
> freeze_super() can fail, it needs to check its return value and do
> error handling in f2fs_resize_fs().
> 
> Fixes: 04f0b2eaa3b3 ("f2fs: ioctl for removing a range from F2FS")
> Fixes: b4b10061ef98 ("f2fs: refactor resize_fs to avoid meta updates in progress")
> Signed-off-by: Chao Yu <chao@kernel.org>
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: check return value of freeze_super()
    https://git.kernel.org/jaegeuk/f2fs/c/e6fd55c1f4b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


